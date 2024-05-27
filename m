Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7CEC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVh0-0000mI-CV; Mon, 27 May 2024 04:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVeG-0003dO-79; Mon, 27 May 2024 04:24:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVeE-00015R-IZ; Mon, 27 May 2024 04:24:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A81036A57A;
 Mon, 27 May 2024 11:22:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D4FB2D8517;
 Mon, 27 May 2024 11:21:40 +0300 (MSK)
Received: (nullmailer pid 66440 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 29/44] target/i386: fix feature dependency for WAITPKG
Date: Mon, 27 May 2024 11:21:20 +0300
Message-Id: <20240527082138.66217-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

The VMX feature bit depends on general availability of WAITPKG,
not the other way round.

Fixes: 33cc88261c3 ("target/i386: add support for VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE", 2023-08-28)
Cc: qemu-stable@nongnu.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit fe01af5d47d4cf7fdf90c54d43f784e5068c8d72)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 33760a2ee1..e693f8ca9a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1550,8 +1550,8 @@ static FeatureDep feature_dependencies[] = {
         .to = { FEAT_SVM,                   ~0ull },
     },
     {
-        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
-        .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
+        .from = { FEAT_7_0_ECX,             CPUID_7_0_ECX_WAITPKG },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
     },
 };
 
-- 
2.39.2


