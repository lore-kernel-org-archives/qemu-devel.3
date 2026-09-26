Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BBFC98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 11:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAQHM-0008FO-8E; Sat, 26 Sep 2026 07:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAQHK-0008Cj-5Y
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 07:09:14 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAQHH-0002nN-1j
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 07:09:13 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-145ab8fd39cso1533106c88.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790420949; x=1791025749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IQEBi51DUnYcVeY7mMvbrmuS5u5X0k5Ob2x7idCICCQ=;
 b=oEe++DoeaRB/sPjgBzl+6jhjxXtgDSE2CWkSLLB5tfVP/Wo0IYQrQEN2jzc/Zzel7w
 ssbRnWVcYSS4iajOpA2GXOvqdgMwb9OVSmMrolR90pItAeinazR80hOpsf2xQDdYPI91
 h8L0LwIQ39uDup+xH0y7ZnEPEs7JUSC6lJnrbVkFATG7GyStFfL4E2M5723G7qziLE56
 ebMvomb7u58OlEeUnoTWWq7+fXYZx9kzxddSsUv8tYw5LEbPAaiXtXlF7u7pUkq1O4v0
 /lEKWne9TmFFJuvZ2q+TBIaQ2Y4+8ccRo5oeC6qiIvmQQt4k6JlPIqP0Eoer7ZlkcYqR
 2pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790420949; x=1791025749;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IQEBi51DUnYcVeY7mMvbrmuS5u5X0k5Ob2x7idCICCQ=;
 b=R1EaDg7zvxNff8VYe6BX7n/IZ5E/WsF4bBQti0AvroV0LGFwPGWhGQhjIaSKEKsGBl
 wJ7vnYkuA7Wh0jNU7UUzal+KUbiUaMdlNiCRJsnqHkDYPYtQVdKotho0bi77gstZoFxy
 u2tTRN2gIX0uuJMPRnLvs2utPwwOprMEjd9wtzOzS5fZDGZpm0MoxtAxtKWCLBWLe9DK
 gKavT4wd+s1SFq99CACWXr2S0+g2IXuo1J1yAj3+CcPfdYsPeUYSQyB4YZ753a/F7OUo
 XofmfVUVyf7wJhre/aMtsX/FkF3s+9oYi21XuAkGCHTKYbm3i9zLUgaYTzZyKJRRFsFN
 F2Aw==
X-Gm-Message-State: AFuF++lqQ/eStdDB0R6TBe2npdDRuyk/lt4Dm8GURSSzVpz56jctK3rQ
 rbUn3AB1ygj5KPCoMGqbpDk5+hnBVj9ExpNzgt8HGekhzEbZoqhHpeSv3YBqzP6I+ro=
X-Gm-Gg: AYBFou0wiz6LBKoSfyqvP2JHZe1r3V7akBNLOeljFu+5pEYxnV3PnsCIpzOWWcWig/m
 SaEC+u6PBdhdMuRdl3I+wgzqf6I3z9cydx1No8Lfk1xnzdQ3U3EcamnWzaqXyMthVgyk1vYIXzG
 vv/OOhtS/L/IKPgGZ4ldHBUEI84MtFc0UfWMG1+IUTGsiv9bVifuL/G8X4ALDsWIYOCYHLmUupC
 0djG7Xzw1GnOFpNlgI4+XgH975ua3fc0zS29cuiStj3KKCcXcXGxBsSLGHaVfO1O87BIUVKMSkc
 VqyJXOUOTvZIyhjVRebPvjfxgbldeuWqrokL9+fPyk7A4oVX88Y9kc1Y7hmJd9URAcN/KZ6T8pY
 1iKOC6dGtTAbkdWdJSLovAgeorVm62ii6gli/2UO+5KH9TIRVkEG/05jsw1UN8vcXQRXaPegFsH
 KT3tC/wrslfInn71oBXCLbCk/EeAUrBtf5ZT+sm8R9DveeevMrQSd6vVpUiFU9xTdtKMIM/lqIJ
 GLYV62yDhgQIZIk0nk1fAE58BlF+5g=
X-Received: by 2002:a05:701b:4287:20b0:144:c127:dd1b with SMTP id
 a92af1059eb24-146d04985a0mr2965028c88.39.1790420949446; 
 Sat, 26 Sep 2026 04:09:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-145a7318afcsm11414045c88.0.2026.09.26.04.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 04:09:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <17746591750@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>, Ani Sinha <anisinha@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chao Liu <chao.liu@processmission.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 7/9] hw/riscv/virt: prefix ACPI helpers with riscv_virt_
Date: Sat, 26 Sep 2026 19:08:15 +0800
Message-ID: <20260926110818.1912-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926110818.1912-1-luoyonggang@gmail.com>
References: <20260926110818.1912-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
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
index 8e516ec1148..de47631852f 100644
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
index d4b501802f6..9bd1274841e 100644
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
index e516898f9ad..d8f1342e131 100644
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
2.52.0.windows.1


