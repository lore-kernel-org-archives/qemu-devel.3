Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A05CD5BC7
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQlnP-0007hk-Qf; Sat, 23 May 2026 08:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wQdHU-0000Vi-KO
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:44:08 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wQdHS-0002Qm-8I
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:44:08 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5a746f9c092so11548351e87.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 20:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779507844; x=1780112644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1843k24ZTU4wUi+EnwW19oLLlgWrWeA2MiXCiM3L90o=;
 b=ZzMMtysLnH3/+r8yH6HxuMbgbW8E1FhXmA2kSOhDfZjF6SfxUfmIGodAAT9hpt2YHf
 PIn8wxio4BlpFFI8k1iXkbUFcIrxkIEu60wMhxjAV1gGq0bZ2P4N6fS1/qsIjwJbpn3b
 kSKhTuRa7mN+ySF5AzR2w3ey3zgA9iPbFFZ1JVJqlDwZQ3g/ZlVklWY36NaWCWX5MI7Y
 D2hXAH3YNy6FlIZKknD7VLjfSWLXR3fWkepqmWgfdee4ix4Dq/LmTX+997K2Tcp2Rm6G
 N2VdPhg2CzkDpJMlmaIyWahJg1hu+wzZLfSDInvm57+7uCXvSlp0RQxYPqUT5THc3/r5
 YsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779507844; x=1780112644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1843k24ZTU4wUi+EnwW19oLLlgWrWeA2MiXCiM3L90o=;
 b=WxxL6gmCo/sGato1RdJZsenbp2KPN07YaFSpFV3vaTkG1pf8Njy0bQ1XV+ap9xj827
 dqw1xG3yoATdzcyJDfnzx2VcafwxpRki6N54P2IhnUcd7MU+Nk5oJDzDIDss1WxBSw/l
 wCAjU/1ErBmmlUdj7/FzQfjAqP3FDPB65FN2FrA/Y/tcEXFVVPXV2YpueShynRR2s1yP
 ImrgjA6NfFHMOYBqBhysYOXN/YYFSH/KXc260tGH4thgU3OaGXZ/rIZZF8xEYY6Vi3cl
 GRm74T7BahFuHYdIYhdPlkPJqbTFe9JT9qW/qwpWR4BxEjn0s264ADl1udLttRwjpHRZ
 nBww==
X-Gm-Message-State: AOJu0Yy7HVaibmAZ8EqEgDtmNZpv0bZxjGioe2IKaqLd93eHZUj62Zpp
 hNWWYtA2qhmYPfjBbSrYl/4teWEBJjTjj/htlh7rs5QHxJwVZFniMERDaRVRQp6jKds=
X-Gm-Gg: Acq92OGBZtdtvKfiO76HDKhzCcDKWyo5shZj1h5u9y9e2uadbr647bKlxldIu4o2ETG
 jpuxinc6HOAlZkKnkSNnayKfE3KszW+WNL/rnDCEE3Fascc+l4CGskCzPPSYVzohZK4LbxF5HXt
 gTom1lnAVRoWdCH49Hfmvd/dAvJ/eCzPD+5Rro0ef+mNljy8m1kCf6n42z50Wub0oJhjsT/a2zX
 U+Hzvy0hJOhBUIS46Yp2dH+uhTEHjmkDr+FY+y1HbEz9E9OdFtHyI+Vi82XNxOz9Y3dXnSCBNOa
 lj7NeVlPOIY16ESFNnAwHduu/EISG61F1jL+q9NGFxFPynNyzdNLL6KrCU5OhYZ1qZKlaRpA/qd
 +EhAmrtVBm7dGath7k9ykueAqtTH5C6yZx6ahjostFlEemA77U20mZVZ1egcx23MBdI1yd16s3/
 rPBfov4xsRk21Zw0GieIr7o7A2vunyaA==
X-Received: by 2002:a05:6512:114e:b0:5a8:7eda:7d8f with SMTP id
 2adb3069b0e04-5aa2ba85a0cmr3382631e87.12.1779507844339; 
 Fri, 22 May 2026 20:44:04 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:c2d::1:2b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb36f6sm848685e87.4.2026.05.22.20.44.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 20:44:03 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH 2/3] hw/smbios: Add dedicated handle range for Type 8 tables
Date: Sat, 23 May 2026 06:41:57 +0300
Message-Id: <20260523034158.57487-3-xpahos@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260523034158.57487-1-xpahos@gmail.com>
References: <20260523034158.57487-1-xpahos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 23 May 2026 08:49:35 -0400
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


