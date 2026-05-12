Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D099BCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuV2-0001TM-Qg; Tue, 12 May 2026 17:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUq-0001Od-V9; Tue, 12 May 2026 17:18:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUp-0007Cl-4z; Tue, 12 May 2026 17:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619497; bh=3Dgouw/Be4emkib1kDzVyM9ntYJ2bumwMnhhCb3hOvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pt+1NJ6Vlo2P/ktO/U3FY6tRROo1iP8BqVwLQ40yQxg0aRFWqoW3mIsHL88elodlG
 3GaLymDznjiJXlAUsGLySTCBejdWcS2DuWIKYQthCyLaXNkCDZjAt8w1hD4slnDvbd
 Asyl6e0ABTAqFilY7pGf1NRonPTcQjX5b2dGlW1Z2SJrxMz3+OdmMoa+f6xrD8aCth
 bkGJzKBgKQSnYVTu3uw3PEc+ZcNiHMreiTEpxUHr7LGd+bVvINRgQ9Ge4aWjCHjxeA
 4JcyfHT+K3Uu2/1usgigZhYDxz+GNPimJYD51Cbwp6hKiVbxed/ddesjUv1BoJLB/3
 qzwZa/pCWMPTw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3A92E1AA3D0;
 Tue, 12 May 2026 23:58:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C1B73ABD28;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 05/58] target/i386: fix strList leak in
 x86_cpu_get_unavailable_features
Date: Tue, 12 May 2026 23:57:26 +0300
Message-ID: <20260512205820.361821-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The result list built by x86_cpu_list_feature_names() was never freed
after being visited, causing a memory leak detected by ASan.
(the getter visitor is VISITOR_OUTPUT kind and doesn't own data)

Fixes: 506174bf8219 ("i386: "unavailable-features" QOM property")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260413125040.3842686-1-marcandre.lureau@redhat.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 87e1226e6f6844845ac407d50198d84205e7ed7f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00e..9d126600c0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7842,6 +7842,7 @@ static void x86_cpu_get_unavailable_features(Object *obj, Visitor *v,
 
     x86_cpu_list_feature_names(xc->filtered_features, &result);
     visit_type_strList(v, "unavailable-features", &result, errp);
+    qapi_free_strList(result);
 }
 
 /* Print all cpuid feature names in featureset
-- 
2.47.3


