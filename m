Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B7FCD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Zg-0005t8-PQ; Thu, 21 May 2026 07:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wQ1ZY-0005TW-SJ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wQ1ZX-0003ac-3J
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779362894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mUsQabucQNt9y47LuNlsFptVLP9qvmU+MGspZjqbPk=;
 b=EAcp9TAieWqgCXnCc9wxJhF2ttISm6RFU5puRFut7D1pWJTw76joygMPJkIbnEN7/IETsP
 CezPuIC+79Nzz+3emurHB+ia0lcUI5Plu/8hqWrSBr8BXDbnSCcKrqlVbGimS3TR776Qyq
 GwkitYzAbCkxJ/ORmuXsgNraE8Nz4H8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73--HJZTYaqOtu2DcD8NXNkvA-1; Thu,
 21 May 2026 07:28:10 -0400
X-MC-Unique: -HJZTYaqOtu2DcD8NXNkvA-1
X-Mimecast-MFC-AGG-ID: -HJZTYaqOtu2DcD8NXNkvA_1779362889
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E1D91800359; Thu, 21 May 2026 11:28:09 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.32.173])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34D6F1684; Thu, 21 May 2026 11:28:09 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 369487DC648; Thu, 21 May 2026 13:28:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/3] hw/arm: add support for shim loading
Date: Thu, 21 May 2026 13:28:06 +0200
Message-ID: <20260521112806.504961-4-kraxel@redhat.com>
In-Reply-To: <20260521112806.504961-1-kraxel@redhat.com>
References: <20260521112806.504961-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add support for direct kernel boot with
shim to the arm platform.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/arm/boot.c         | 6 ++++++
 include/hw/arm/boot.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 780b6be637..9b7553dde5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1161,6 +1161,11 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
             fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
                               info->kernel_cmdline);
         }
+
+        if (info->shim_filename) {
+            load_image_to_fw_cfg_file(fw_cfg, "etc/boot/shim",
+                                      info->shim_filename);
+        }
     }
 
     /*
@@ -1195,6 +1200,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
      * doesn't support secure.
      */
     assert(!(info->secure_board_setup && kvm_enabled()));
+    info->shim_filename = ms->shim_filename;
     info->kernel_filename = ms->kernel_filename;
     info->kernel_cmdline = ms->kernel_cmdline;
     info->initrd_filename = ms->initrd_filename;
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index a2e22bda8a..94386fdbea 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -39,6 +39,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename,
 /* arm_boot.c */
 struct arm_boot_info {
     uint64_t ram_size;
+    const char *shim_filename;
     const char *kernel_filename;
     const char *kernel_cmdline;
     const char *initrd_filename;
-- 
2.54.0


