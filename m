Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD98CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUKM-00056Z-Mh; Tue, 16 Jun 2026 09:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wZUKH-000555-3y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:59:38 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wZUKF-0007M5-Gi
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:59:36 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5aa68dbd44fso4536519e87.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781618374; x=1782223174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1843k24ZTU4wUi+EnwW19oLLlgWrWeA2MiXCiM3L90o=;
 b=Yr7+kIb4MJ6WRFjfKSlSbjaFX2cHewz25DYi7XDFuxynTuso2D4dCWqNpFrwKRqsbd
 OrPfVgIBmJKoQ/BwNl+EopEasZ/BVClFGNMKwMO3Mm5G4gBIIauGs/wSHGTst+xxeX/Y
 UEhvUYW7lCYVWbfCTJt/DXu2j9jCBNfwHYwnh7P5ghfhQ3ocPHIuk1SqyD0Mlm8CO+3X
 KkMyLYy0C8Lmt/QHkOPput4H4mRAZFgYHugKshne8lldfTziKuVyof9c1Fn4fOx237pU
 b6kZe9koskCAkxGFrZg0TkLybw+dvNRX2ESxocbnia4KOpN3kt/vYr6X+CtAeEDRAdBF
 EHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781618374; x=1782223174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1843k24ZTU4wUi+EnwW19oLLlgWrWeA2MiXCiM3L90o=;
 b=WTeMJUQCzvc3vKLRrNR3vlcQ6JPAAWpBUfPJpx5FWzDH6HqNJfWT39NN8sQFUGHy9b
 h3aL1Ca27X4uu9CBUK2s2SQwFAAZjF5VnbpryFfTftpMcBAFdQsVTTGtf5UuHRQWyrxj
 CBz85sUKcKFCa/62DSFNOcInE4qBwTITc4hQpMkVFxW+vJGK5ONN8wkDl21JWK/7YfeN
 vm2mlh8p7nX3zFkgk9k9P5zSoWmD3eB7d6Q8PiyQhFpHahV6KyvZuv7kQ23lZfLyDIW1
 RDLsn0O/CVGYVWTzMaagZVwhx8eM9rnG/MhW+qjdkZkEqnPIFM1DLu+5dPgWg7lomioC
 j4DA==
X-Gm-Message-State: AOJu0YybnG1w04y5cnhNFMbSLcS6yvQBhdRxVCFR/cnIajGgIq1B2woT
 9pglP67lx//BepYl47+rWybmy4ETnhRGRIEemdrQOkwEdRfG6a++Oqdvtqlzcb6KF/k=
X-Gm-Gg: Acq92OGCFmL5Y839sS7HjOq65UqnkpTivx5c0sGuHRk7lkWCLTjShfQu4YHYvk6TE2n
 aJw6wnIJbrdDZZxMngYB04xogPIYQ79X5oSX5JMTVgwRUYG5wrE907sOwxk7Q/61FYEtEbGvIQh
 46YqH7mMrh2IjP36eN7p45w7TofX+le8imiYRY4HXpxrLw8HKZ9qlLaKKrSsb2yFzHIfoMIVxl3
 7en8/fOCa/M3FMnILCbhUGd1B8fEPqLk0ZlyLIm2m2/XkPNwI0JqxFh0urdDL8b9QhhCm6qciOy
 6171R0iZ/CMsAWPx2YZpn3cI60T/qzAAmuLU6Vb4+F5yMzcr4vFdU5AK5k/M8Rw1E/jyb/RPZe/
 h4A59W9rJGYe972i2JoNKo5n+6YrZr7ya1NlpKHvMy/oCxMTOgjbN0fJFKbKLT8x7cDx654H2EX
 w+y/RxedckO0hUCNtl0SnDaK/lof+G8JOFHVQv/VZGwM6RKneH
X-Received: by 2002:a05:6512:1253:b0:5ad:3a70:a8cf with SMTP id
 2adb3069b0e04-5ad3a70aa46mr2694319e87.25.1781618373567; 
 Tue, 16 Jun 2026 06:59:33 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8011:f00:689d:b3a0:c7eb:5526])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161f1esm3634677e87.2.2026.06.16.06.59.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 06:59:33 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, philmd@linaro.org,
 anisinha@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 zhao1.liu@intel.com, Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH v2 2/3] hw/smbios: Add dedicated handle range for Type 8 tables
Date: Tue, 16 Jun 2026 16:59:03 +0300
Message-Id: <20260616135904.44930-3-xpahos@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260616135904.44930-1-xpahos@gmail.com>
References: <20260616135904.44930-1-xpahos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SMBIOS Type 8 (Port Connector) tables currently use T0_BASE (0x0) for
handle allocation. This can lead to handle collisions with other table
types that also start at T0_BASE. Types 2, 3, 4, 9, and 11 already
have dedicated handle ranges (T2_BASE=0x200, T3_BASE=0x300, T4_BASE=0x400,
T9_BASE=0x900, T11_BASE=0xe00), but Type 8 was missed.
Add T8_BASE (0x800) to fill the gap in the handle range allocation.
Introduce a static flag and smbios_set_type8_handle_t8_base() setter
to allow machine types to opt in to the new range. When the flag is
false (the default), the old T0_BASE behavior is preserved.

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
 hw/i386/fw_cfg.c             |  1 +
 hw/smbios/smbios.c           | 10 +++++++++-
 include/hw/firmware/smbios.h |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 2876490f06..0b3a14cdb1 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -77,6 +77,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc, mc->name);
     }
+    smbios_set_type8_handle_t8_base(pcmc->smbios_type8_handle_t8_base);
 
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 7d7141851b..0e0200600e 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -49,6 +49,7 @@ static SmbiosEntryPoint ep;
 static int smbios_type4_count = 0;
 static bool smbios_have_defaults;
 static uint32_t smbios_cpuid_version, smbios_cpuid_features;
+static bool smbios_type8_t8_base;
 
 DECLARE_BITMAP(smbios_have_binfile_bitmap, SMBIOS_MAX_TYPE + 1);
 DECLARE_BITMAP(smbios_have_fields_bitmap, SMBIOS_MAX_TYPE + 1);
@@ -553,6 +554,7 @@ bool smbios_skip_table(uint8_t type, bool required_table)
 #define T2_BASE 0x200
 #define T3_BASE 0x300
 #define T4_BASE 0x400
+#define T8_BASE 0x800
 #define T9_BASE 0x900
 #define T11_BASE 0xe00
 
@@ -742,13 +744,19 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
     smbios_type4_count++;
 }
 
+void smbios_set_type8_handle_t8_base(bool t8_base)
+{
+    smbios_type8_t8_base = t8_base;
+}
+
 static void smbios_build_type_8_table(void)
 {
     unsigned instance = 0;
     struct type8_instance *t8;
+    uint16_t base = smbios_type8_t8_base ? T8_BASE : T0_BASE;
 
     QTAILQ_FOREACH(t8, &type8, next) {
-        SMBIOS_BUILD_TABLE_PRE(8, T0_BASE + instance, true);
+        SMBIOS_BUILD_TABLE_PRE(8, base + instance, true);
 
         SMBIOS_TABLE_SET_STR(8, internal_reference_str, t8->internal_reference);
         SMBIOS_TABLE_SET_STR(8, external_reference_str, t8->external_reference);
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 3ea732f4e6..62e728b69c 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -333,6 +333,7 @@ void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version);
 void smbios_set_default_processor_family(uint16_t processor_family);
+void smbios_set_type8_handle_t8_base(bool t8_base);
 uint8_t *smbios_get_table_legacy(size_t *length, Error **errp);
 void smbios_get_tables(MachineState *ms,
                        SmbiosEntryPointType ep_type,
-- 
2.39.5 (Apple Git-154)


