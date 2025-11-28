Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C99FCFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 09:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOuk2-0006E6-D2; Fri, 28 Nov 2025 04:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOuk0-0006AU-SA
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:26:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOujy-0006P6-3g
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764321968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3Zn6gf1bYGgs/PS2v1pmh2KIcBBJirwz9hR8oUGLY0=;
 b=Nk91rTicjEblit6WlwGoPWoi/ix1/UWO2R5s4fR4XdW0rQeYyvBzUwlPnZykvkUexN3Ylf
 EX/xDcRTBzyGw0S7jARcJiTj8e/nnKKhj5jeEcVn7GPizC5Pw80yF+Nyu0IiHveC0kYnvA
 NV1pmWtH8lQw4UOPMj9CcOsz5uG0Vp4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-YAiuTIMTPd6fWz-v4d5o2Q-1; Fri,
 28 Nov 2025 04:26:06 -0500
X-MC-Unique: YAiuTIMTPd6fWz-v4d5o2Q-1
X-Mimecast-MFC-AGG-ID: YAiuTIMTPd6fWz-v4d5o2Q_1764321966
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D77181800673; Fri, 28 Nov 2025 09:26:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.236])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2448130001A4; Fri, 28 Nov 2025 09:26:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B2FEB1800783; Fri, 28 Nov 2025 10:26:02 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] edk2: add qemuvars builds to config
Date: Fri, 28 Nov 2025 10:26:00 +0100
Message-ID: <20251128092602.373747-2-kraxel@redhat.com>
In-Reply-To: <20251128092602.373747-1-kraxel@redhat.com>
References: <20251128092602.373747-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2-build.config | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index 96ebc3bcd9e7..9caafa7a5f55 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -20,6 +20,11 @@ SECURE_BOOT_ENABLE       = TRUE
 SMM_REQUIRE              = TRUE
 BUILD_SHELL              = FALSE
 
+[opts.ovmf.sb.qemuvars]
+SECURE_BOOT_ENABLE       = TRUE
+QEMU_PV_VARS             = TRUE
+BUILD_SHELL              = FALSE
+
 [opts.armvirt.silent]
 DEBUG_PRINT_ERROR_LEVEL  = 0x80000000
 
@@ -55,6 +60,16 @@ plat = OvmfX64
 dest = ../pc-bios
 cpy1 = FV/OVMF_CODE.fd edk2-x86_64-secure-code.fd
 
+[build.ovmf.x86_64.qemuvars]
+desc = ovmf build (64-bit, secure boot)
+conf = OvmfPkg/OvmfPkgX64.dsc
+arch = X64
+opts = common
+       ovmf.sb.qemuvars
+plat = OvmfX64
+dest = ../pc-bios
+cpy1 = FV/OVMF.fd edk2-x86_64-qemuvars.fd
+
 [build.ovmf.microvm]
 desc = ovmf build for microvm
 conf = OvmfPkg/Microvm/MicrovmX64.dsc
@@ -81,6 +96,19 @@ cpy2 = FV/QEMU_VARS.fd edk2-aarch64-vars.fd
 pad1 = edk2-aarch64-code.fd  64m
 pad2 = edk2-aarch64-vars.fd  64m
 
+[build.armvirt.aa64.qemuvars]
+desc = ArmVirt build, 64-bit (arm v8)
+conf = ArmVirtPkg/ArmVirtQemu.dsc
+arch = AARCH64
+opts = common
+       armvirt.silent
+       ovmf.sb.qemuvars
+pcds = nx.broken.shim.grub
+plat = ArmVirtQemu-AArch64
+dest = ../pc-bios
+cpy1 = FV/QEMU_EFI.fd  edk2-aarch64-qemuvars.fd
+pad1 = edk2-aarch64-qemuvars.fd  64m
+
 ####################################################################################
 # riscv64
 
@@ -94,6 +122,15 @@ cpy2 = FV/RISCV_VIRT_VARS.fd  edk2-riscv64-vars.fd
 pad1 = edk2-riscv64-code.fd   32m
 pad2 = edk2-riscv64-vars.fd   32m
 
+#[build.riscv.qemu.qemuvars]
+#conf = OvmfPkg/RiscVVirt/RiscVVirtQemu.dsc
+#arch = RISCV64
+#opts = ovmf.sb.qemuvars
+#plat = RiscVVirtQemu
+#dest = ../pc-bios
+#cpy1 = FV/RISCV_VIRT_CODE.fd  edk2-riscv-qemuvars.fd
+#pad1 = edk2-riscv-qemuvars.fd     32m
+
 ####################################################################################
 # LoongArch64
 
-- 
2.52.0


