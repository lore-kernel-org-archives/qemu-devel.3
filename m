Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE4ACD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPT-0005EA-W4; Sat, 06 Jun 2026 01:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPR-0004xA-C0
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPP-0008Mn-PZ
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzKJ/IpdkG01bM1txdqjhoLFTRAUk3+pG2IUFauAHiA=;
 b=IhbZiOXOuZu93yjjQJqP8jNfb8cv1hqq7BhJeKIUbfJ1TklizVAOIEY6DJBws68lfAZWwl
 sOVwRwkuuE0qgT+ePOsKIGjntvsPSQ6ElG8nRV8cNpICRMG5I98N34szV0FCoAF8heJnUy
 36PCCefXYBP62kfTe3AK1GQTTzD/gEo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-r78MoDlGMfCnWn5k0pQl7g-1; Sat,
 06 Jun 2026 01:17:21 -0400
X-MC-Unique: r78MoDlGMfCnWn5k0pQl7g-1
X-Mimecast-MFC-AGG-ID: r78MoDlGMfCnWn5k0pQl7g_1780723040
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A94A18002FB
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:17:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 451981800480; Sat,  6 Jun 2026 05:17:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:51 +0400
Subject: [GIT PULL v2 19/23] hw/ppc/spapr: free host_model and host_serial
 on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-19-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EFDae8u7ennK5lGTEip5Z4TCCmPwbTBDCnezXm8A95s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z1WHdm3DEK/PyXaBMvb5q6PgQvRiaLD7OlO
 3b08+KrJwWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9QAKCRDa6OEJdZac
 5fKgD/92HsMte1XT6fHbxiDfOfvi5GlK+vN6X4wbUiq9c/ALCAMmsssOrcfI4KNhUBZGyB9qXiK
 uemvyWvEPPuNr52ZfGdbazWdt+xT0Ky1kLcw0SABWGADLjilyUfCfLFS5g7QBxdbEz/cNnV3fwR
 lwbZ248ljCILgNn4t8e07ldMVExYHFrcvkeh7QqWjQr2onlq5DlIqb1rQ/PoctLhbW9Up1/4023
 TvbAajpUSDEmTi1yzqfbmO901fLLVZAke0MnJ4K0D3y7YnOgYkk2x5/wRCsZWcx2t6ZJ65Xu97n
 ZhWQHDqnZloE5gvrt9d0ODq9/qfvoReBqZoWOqvjDQn1z+YXa8APlzitglQ/Qdwujbcd6QXkxLI
 Jsv+OJd8lO0ujYke4PjDa9kEQSjYhxkbdeYjq+20Ou4jhQK+829b5N9LVAueyCHZAnJLjYbAL9l
 x6kDCk0lb1wT7e+ueOYyDDjpfHlJURRnaksT1XKUSu3yiKVxpDJ7FISK0B1MS/iJ/OlWGP+o/By
 QVCXKZkqgehdA4dxMfQoiuaFrzoIzfP0vHpxNKt1xUzXW5akrnkB6AznJqaTJvjWGgbqvVQzDqN
 VInmjM2P7v/PZSykGVKE+l8/WxOp4rz/7GoZoQ8V1AWi9UHINj5X00itYzD9JR7UrT7NGMmjuVR
 iwUBLKqeZEyzVYQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The host_model and host_serial strings are allocated via g_strdup in
property setters but never freed when the machine is destroyed.

Fixes: 27461d69a0f ("ppc: add host-serial and host-model machine attributes (CVE-2019-8934)")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 191f7431bdf..f0e99bb5be7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3517,6 +3517,8 @@ static void spapr_machine_finalizefn(Object *obj)
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
 
     g_free(spapr->kvm_type);
+    g_free(spapr->host_model);
+    g_free(spapr->host_serial);
 }
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)

-- 
2.54.0


