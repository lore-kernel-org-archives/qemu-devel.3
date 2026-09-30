Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B44CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBov3-0001AL-J6; Wed, 30 Sep 2026 03:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBov1-00019E-A3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:39:59 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBouy-0003rQ-RI
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:39:58 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-34b590a5b5eso1760835eec.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790753995; x=1791358795; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=avGERWAPGViLuy2+4NKQbGtxaEZWL3P6uQuD6BbLacI=;
 b=ebgwOnv2Vt5yFMDAlU8Bi52vt/tH/ceZ10HPdSkbzhsRUKUmL0jN6W77I5C4goQ4aK
 J+2ARt3rLTZqN/Tey4WV6uxDjCLfPx4p3vXG/jY75kd1J5k/84jpFJtpTwaN6EXzrnlT
 twKjC3/US8/F1W8pYLO/1bhb3Y0U2vGjTleD6qTJLtL5ox7fdbu38hqwPLLEtkwoxhKD
 OUbGa7V/S6bw/iryVl/gRzw/UOM7aeZYlqmXLHpuMNyzvaNTOT57ZnU7tDELAqmmnQdI
 8svMpEzXriKycBXXFbIeH2R/yhE887gC0xM/baTZ180rcXJjemxUmPvvoFrpAO332GxS
 WClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790753995; x=1791358795;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=avGERWAPGViLuy2+4NKQbGtxaEZWL3P6uQuD6BbLacI=;
 b=U/opVbxSgEyEMqxBN3BdU50z0t53wxpU+vTDC+84GNFRwzipBFUdHarIvn1GVcL61L
 TstvouEwSMhLETaIRRde9djNafq24s4tAKcauLt0pG8Onf7hpRSGyDBfpiUCFG38v7w9
 A8CGEkwh8STAgmK5084TKLkMBQQXGGxBooqTedziLQIczRGMbuSACmJ0iLFRU1SCCRNW
 dzyuiREi2SDWDuhA5+J+hWlb062/ULupSNNOprzTH6dnjDxiZ3ppE/70y4ml56QsE7IJ
 090PnBCxxMGMx/C5lYe1zarxSjTikWOq/K3kkCt++LygkbjolKUJPLe1i/pecYsoU41C
 PN8A==
X-Gm-Message-State: AFq9FYLiIZR0fSrMLNfu4v1/L7N+4SmVzNpv5o5T67kDMGJXooAHBoqJ
 ZFVSGvDUwadxG7i6E/DVdqBPxNdDLVwXyP8ZzszV5VCf77OVcZL3vuzjeSA5b8h8
X-Gm-Gg: AYBFou36sdEKsif3DwEYA+3TSHZHC0Hz84/SBFPZEZ5WoA1Q/zFgDj1BZC+/TFrEGIU
 UTvDRvAZE3EY1sBvOqCwQKDA781MNa+V6i/zN/iY1MiKkBGOWgIBEKGFBCApxOV+QvOAGB9AjxE
 sBBsaxZe8WPi7m+Jhp5kJpUnbeyEr36Yp2MMy04Hm22IcQuRoxfLWOzqRk+G2Adppij2LRruHY9
 Q7jvTgIrOTi3Cuagd1faDiqjY9r4nFLJWvImJDDrxLQgCVJmQW8vAsXpHWF21K281Bjbs7ZY70D
 2MZiXuIL5wp7lEd7+/4XYYvUMnD9qjvc1laJ94TCkXuNUVTcu9GbdGpUcROXktJM61im723OAP5
 hbJV7nO4oRcTl1i+GphtxrJmJX30txlY+CIpCJ6kEY/S39IX4kpZ2goQP+TgdjUooAkdjLepYXf
 Jkb8aGO3DbBS4oedjq7UyDG2voekPu3JEzzsl9Kq3FHANc7BYT9PS4VtjzLSofWytv+JzBt5aQC
 AV39aEEyx3yCQA3+Cd9kazv27FC
X-Received: by 2002:a05:7300:b507:b0:340:9d9f:a5c with SMTP id
 5a478bee46e88-34cdd6907admr1305963eec.36.1790753995141; 
 Wed, 30 Sep 2026 00:39:55 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34cf5b4349bsm1825773eec.25.2026.09.30.00.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:39:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/6] hw/riscv/virt: prefix ACPI helpers with riscv_virt_
Date: Wed, 30 Sep 2026 15:39:29 +0800
Message-ID: <20260930073935.712-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260930073935.712-1-luoyonggang@gmail.com>
References: <20260930073935.712-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- virt_acpi_setup and virt_is_acpi_enabled collide with ARM virt when
  both architectures are linked into one qemu-system binary.
- Rename the RISC-V helpers to riscv_virt_acpi_setup and
  riscv_virt_is_acpi_enabled. Leave file-local virt_acpi_build* names
  unchanged.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 hw/riscv/virt.c            | 6 +++---
 include/hw/riscv/virt.h    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8e516ec114..de47631852 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -1021,7 +1021,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(RISCVVirtState *s)
+void riscv_virt_acpi_setup(RISCVVirtState *s)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..9bd1274841 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -705,8 +705,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
     virt_build_smbios(s);
 
-    if (virt_is_acpi_enabled(s)) {
-        virt_acpi_setup(s);
+    if (riscv_virt_is_acpi_enabled(s)) {
+        riscv_virt_acpi_setup(s);
     }
 }
 
@@ -1066,7 +1066,7 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
-bool virt_is_acpi_enabled(RISCVVirtState *s)
+bool riscv_virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi != ON_OFF_AUTO_OFF;
 }
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9a..d8f1342e13 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,9 +121,9 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-bool virt_is_acpi_enabled(RISCVVirtState *s);
+bool riscv_virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
-void virt_acpi_setup(RISCVVirtState *vms);
+void riscv_virt_acpi_setup(RISCVVirtState *vms);
 
 /*
  * The virt machine physical address space used by some of the devices
-- 
2.55.0.windows.3


