Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1F4C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8Mu-0008AF-MQ; Wed, 15 Jan 2025 13:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY8Mr-00088i-Se
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:43:54 -0500
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY8Mq-0003Bg-4D
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:43:53 -0500
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-5f89aa7a101so11435eaf.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736966630; x=1737571430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwz4467PZxHOYDvJKbfek9VW1OADl098umRJuhCniXA=;
 b=Q2ZfY1g+SM+pjUSUUBbupGxSK3LKtEYQFx+0nFJVQDqynS2bzJAL3RCqFgDuY3P2Pd
 76bEthNEXKg9yNlVFDDITjhTRwgz4kPEskjYmwQNSd3w+Vev1X7T5IRsaxKGuHRmpVYA
 HMojdjO+17LcJV6oUlX+4v9KJX/8A22vQc380f0Vr71+grWRKZbosCCfCUIssVZ6JG19
 ffAeGLT+lrGpmjn55blJ0sOtUZCkbFbbPRRkwNr6j9N8CLNz/Hl3y0G3zle8gyTAT3w5
 kjZMOKOzphKoCOILKqX13zedd7xLxnS2FPFeaV5qSHEknPe+Le1MCJwKex8EIWVPhD+v
 qa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736966630; x=1737571430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwz4467PZxHOYDvJKbfek9VW1OADl098umRJuhCniXA=;
 b=UqInKgdqRwE+lQKRAjWjr5ZqNkHUlhuVL/V3JrZ6ru3RCWHTHnFZpGxRpNc7D6ZTvZ
 +Plx83ksl78DmU632gl6Ps8k3egYljdFJc8VzbfDFhetJqREdBdzXB0QXeFiztT14VFg
 UWbkNnGPlLZGWI6n6d96pp0nOvgNB/qsft+8PDedb3hJLfFXR6ooK4GsNGUinO1GVJqM
 AmbMaj395+Zcw2WtS4Q2nD6vkV0hhDI83s8NODi9pP4G+IFKdenYWLIg4846acguJCAZ
 IjnkhrhRxThbHWsIpd0uclxr+1G3JxIThEJLUrzyBrWnVtI4KOtnc/BWcmPTZSfE6mBP
 mFFQ==
X-Gm-Message-State: AOJu0YzKGLf+V1QwJ8BS77Mlltop4jokQcrIvbGLLGCPSyvClSOVVmyx
 hLf26frirhdMuidV5LN0PgdLKYyGmOa19ufoPCiyrK+ScuDswAlVgRGWJLkEgyE0TvivPBUMfNN
 xso7MUw==
X-Gm-Gg: ASbGncveCZA5eZycDZ0uxP/8povkLuqftDJe3dkH5CVQLAnpQiSuJllmhy2Rj28bpxK
 +v4qYwxIxzcwDuH1ewtjM1caJSGlIypydYz+YBawZJUlSJm8aiepoJ03O2RTu0s8zGHvOBWK6V4
 4Ob7HgDZa8YDaci5YIa8qt2ZSbmD7QL6e5ifr/gqAEu7LtIzChlDVSNMmbqhSacK5n89OwpKPwY
 uc7cqfalLHa3xRur4HyD9Gqyj4i6RgmKG6gJuodRYFxJU6pMKMhUAHjYv4=
X-Google-Smtp-Source: AGHT+IExPfSCpjv+BifQlO2WaKYlA4Jl7zofx7iOkOjuPVFZkUbpLf8AaKlaAQp3JSsa5XIMNB3ijQ==
X-Received: by 2002:a05:6870:af85:b0:297:2719:deb6 with SMTP id
 586e51a60fabf-2aa0664faebmr16189172fac.1.1736966629842; 
 Wed, 15 Jan 2025 10:43:49 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad80a5cb64sm6539196fac.47.2025.01.15.10.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:43:48 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 6/6] target/riscv: add RVA23S64 profile
Date: Wed, 15 Jan 2025 15:43:16 -0300
Message-ID: <20250115184316.2344583-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc44.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add RVA23S64 as described in [1]. This profile inherits all mandatory
extensions of RVA23U64 and RVA22S64, making it a child of both profiles.

A new "rva23s64" profile CPU is also added. This is the generated
riscv,isa for it (taken via -M dumpdtb):

rv64imafdcbvh_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_
ziccrse_zicond_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zimop_
zmmul_za64rs_zaamo_zalrsc_zawrs_zfa_zfhmin_zca_zcb_zcd_zcmop_zba_zbb_zbs_
zkt_zvbb_zve32f_zve32x_zve64f_zve64d_zve64x_zvfhmin_zvkb_zvkt_shcounterenw_
sha_shgatpa_shtvala_shvsatpa_shvstvala_shvstvecd_smnpm_smstateen_ssccptr_
sscofpmf_sscounterenw_ssnpm_ssstateen_sstc_sstvala_sstvecd_ssu64xl_
supm_svade_svinval_svnapot_svpbmt

[1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 53ead481a9..4cfdb74891 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -41,6 +41,7 @@
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
+#define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 761da41e53..adfce231a7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2421,10 +2421,41 @@ static RISCVCPUProfile RVA23U64 = {
     }
 };
 
+/*
+ * As with RVA23U64, RVA23S64 also defines 'named features'.
+ *
+ * Cache related features that we consider enabled since we don't
+ * implement cache: Ssccptr
+ *
+ * Other named features that we already implement: Sstvecd, Sstvala,
+ * Sscounterenw, Ssu64xl
+ *
+ * The remaining features/extensions comes from RVA23S64.
+ */
+static RISCVCPUProfile RVA23S64 = {
+    .u_parent = &RVA23U64,
+    .s_parent = &RVA22S64,
+    .name = "rva23s64",
+    .misa_ext = RVS,
+    .priv_spec = PRIV_VERSION_1_13_0,
+    .satp_mode = VM_1_10_SV39,
+    .ext_offsets = {
+        /* New in RVA23S64 */
+        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
+        CPU_CFG_OFFSET(ext_sscofpmf), CPU_CFG_OFFSET(ext_ssnpm),
+
+        /* Named features: Sha */
+        CPU_CFG_OFFSET(ext_sha),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
     &RVA22S64,
     &RVA23U64,
+    &RVA23S64,
     NULL,
 };
 
@@ -2918,6 +2949,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
 
     RVA23U64.enabled = true;
 }
+
+static void rva23s64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA23S64.enabled = true;
+}
 #endif
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
@@ -3198,6 +3236,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.47.1


