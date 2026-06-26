Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3676BCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3en-00020v-1N; Fri, 26 Jun 2026 06:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ea-0000uE-Fp
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eX-0005NS-Up
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvuCG09jFYT3N7DhZlRwPAPRQKQKrhXH30rKgvdzMNE=;
 b=QNUUyda/yeBnA0miS7ed68gahA/p8tNPTGanJc5cz1waTlK51OBTnp7OSPtPl9jfemgp2T
 HcYMafCN/1uwMAHN91tTgL6TBn2nx63Qbikp0wn0S7pMjEYLzPV/1wXPHdO5ZUd2Et7slq
 Aa0xguvgDBYhq2UdXX+JmEbKDFTEZrM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-eGYNhJHxNJKRSxZr2q-yOA-1; Fri, 26 Jun 2026 06:19:16 -0400
X-MC-Unique: eGYNhJHxNJKRSxZr2q-yOA-1
X-Mimecast-MFC-AGG-ID: eGYNhJHxNJKRSxZr2q-yOA_1782469155
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4924583c7baso9445035e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469155; x=1783073955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvuCG09jFYT3N7DhZlRwPAPRQKQKrhXH30rKgvdzMNE=;
 b=ZX2umTdoE0S7mB5QNPI9uVEpg5lMZW4Vo5rjHpRJrPoXHTocYZU4XgUSTgGvKKjgP1
 f128alrw/L7lwPe9a+a41ft4KLw9T7tyIh7nl3Ep9OOKVCgCD+3TpFOE2VPQQ3Qeo5Vw
 HzGHgdlPWDdPdfG1vGLJt85larXyUdODh+TZ44KMMWODQn6gk+ojFcsqFb7FTQfkroqQ
 9rx+FSMzwceaYJ089A4QSH6GtpdFLdDy8srMRJeFAh6JbRQ5Z8L42lJ/jT+LcMxvVds0
 +MOUlK5ls6MR8vyQJifaN4Z1B1MeYiEZMYYCtzN4G6Ev/HXNK0YdhyquERqxMVgaQ2RI
 mtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469155; x=1783073955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mvuCG09jFYT3N7DhZlRwPAPRQKQKrhXH30rKgvdzMNE=;
 b=S/itsYtzYh1AL9Gjd0NQ2TTCsDqIspeZruRsaWodQz05zUfpH6iNH7rLtL3NvyhkUT
 7MmQs+pqZKPhAx1gu3A/TK5NnxD3b/GwsXNMj5XBWUnz607NbnUtfjqENOlBm45pneLm
 T1JSmfZj+R/oyOkcUTwlkhD7po3qoTuA6Dgh/bnCskSveQIhNWDWHOPAo5AMDp19hlA5
 mYSC5d8s53d10fZ5cd2z2ohWOWCtvMFTigy8cCe30OIKqSbYy6sTQQZ/OZj7eiIWcvcF
 s1LZGQ6srbjhr/4Px6Xkstnr5h0arPlFshc87h17VJqE0Y+AhzdAs3XuSILboI9LmgEV
 Ws5A==
X-Gm-Message-State: AOJu0YxK5nrWVE6D4Bhtmu3A1RLows1GZ6fbJtFboBWUDvnAStK/OCzV
 YXUNaXXFrBNPDZgJyXktYOpK+ZvilWYjzRImxCoQpz7MVM8s2Sj3wnDEMnx2I4Hdr6bGKX3aJbq
 s4tLFUXkE2orn5SQZ9Oaqk9+EmlfZHal9K0QVcGnxZ/s5JF9VRhfxZ0gdHZaFx6jFbB4LWkgViM
 3pSO4chwnUbiwUHRp6Jsi4D2mgTJzQO3fM+WyY5Dyt
X-Gm-Gg: AfdE7cnwl3FJvDEWk1vjKeXs5iWJmjwMKUnWKj2ZPQoof6/CoMhVnJDIK21uUkekSTP
 4wHEtILQWyQ4Q9CVNF0vJS/tPnTGYz8nOvT8sVyTA4kwlLwKNMQagiq1VHbA1PPDXtaL/sWHGov
 7ExGdELnkdgeQn397HNrOmR3KlijATSmXs6Mo2hCm95DgJ0+Yv+0FXVaDTw5luuIc3VaqNbl1+f
 NbWTSV8WH4BdOJjyeiPsKzQ/eBphpUq79aPMWEFLETcdUK9Ykcg48EzO1CC5wI/bbdiWX2Nsn7N
 tUWpjle9L9IQo93vk03BNn7VTSwNuZt5JANncUxns5A3DFIXB0D9MlqdkzAcEUBYMxFPdPZfGFu
 eyNZM4LCVUannYuMF9pN4XyUas1OKcG6KcNAweX8hJgIYoWYuHHqs0UOUgAO+pkEYKatvBtzWsj
 riNtKu4ckuV79VsVSw
X-Received: by 2002:a05:600c:1d25:b0:492:3c49:88ac with SMTP id
 5b1f17b1804b1-49266847bb9mr79331125e9.10.1782469154595; 
 Fri, 26 Jun 2026 03:19:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1d25:b0:492:3c49:88ac with SMTP id
 5b1f17b1804b1-49266847bb9mr79330605e9.10.1782469154000; 
 Fri, 26 Jun 2026 03:19:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f86c34d76sm1156931f8f.3.2026.06.26.03.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 31/45] target/i386/mshv: migrate MTRR MSRs
Date: Fri, 26 Jun 2026 12:17:34 +0200
Message-ID: <20260626101748.1728079-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This change roundtrips memory access/caching MSRs. The mapping scheme
is a bit more elaborate on these, so we have added a special handling
instead of individual entries in the MSR mapping table.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-22-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/msr.c | 136 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 7 deletions(-)

diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 7447467dbf5..76b593060a7 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -77,6 +77,10 @@ static const MshvMsrEnvMap msr_env_map[] = {
     { HV_X64_MSR_SIMP,      HV_REGISTER_SIMP,
                             offsetof(CPUX86State, msr_hv_synic_msg_page) },
 
+    /* MTRR default type */
+    { IA32_MSR_MTRR_DEF_TYPE, HV_X64_REGISTER_MSR_MTRR_DEF_TYPE,
+                              offsetof(CPUX86State, mtrr_deftype) },
+
     /* Other */
 
     /* TODO: find out processor features that correlate to unsupported MSRs. */
@@ -88,6 +92,98 @@ static const MshvMsrEnvMap msr_env_map[] = {
                             offsetof(CPUX86State, spec_ctrl) },
 };
 
+/*
+ * The assocs have to be set according to this schema:
+ *      8  entries for 0-7 mtrr_base
+ *      8  entries for mtrr_mask 0-7
+ *      11 entries for 1 x 64k, 2 x 16k, 8 x 4k fixed MTRR
+ *      27 total entries
+ */
+
+#define MSHV_MTRR_MSR_COUNT 27
+#define MSHV_MSR_TOTAL_COUNT (ARRAY_SIZE(msr_env_map) + MSHV_MTRR_MSR_COUNT)
+
+static void store_in_env_mtrr_phys(CPUState *cpu,
+                                   const struct hv_register_assoc *assocs,
+                                   size_t n_assocs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i, fixed_offset;
+    hv_register_name hv_name;
+    uint64_t base, mask;
+
+    assert(n_assocs == MSHV_MTRR_MSR_COUNT);
+
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        assert(assocs[i].name == hv_name);
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+        assert(assocs[i + MSR_MTRRcap_VCNT].name == hv_name);
+
+        base = assocs[i].value.reg64;
+        mask = assocs[i + MSR_MTRRcap_VCNT].value.reg64;
+        env->mtrr_var[i].base = base;
+        env->mtrr_var[i].mask = mask;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    fixed_offset = MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        assert(assocs[fixed_offset + i].name == hv_name);
+        env->mtrr_fixed[i] = assocs[fixed_offset + i].value.reg64;
+    }
+}
+
+/*
+ * The assocs have to be set according to this schema:
+ *      8  entries for 0-7 mtrr_base
+ *      8  entries for mtrr_mask 0-7
+ *      11 entries for 1 x 64k, 2 x 16k, 8 x 4k fixed MTRR
+ *      27 total entries
+ */
+static void load_from_env_mtrr_phys(const CPUState *cpu,
+                                    struct hv_register_assoc *assocs,
+                                    size_t n_assocs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i, fixed_offset;
+    uint64_t base, mask, fixed_value;
+    hv_register_name base_name, mask_name, fixed_name;
+    hv_register_assoc *assoc;
+
+    assert(n_assocs == MSHV_MTRR_MSR_COUNT);
+
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        base = env->mtrr_var[i].base;
+        mask = env->mtrr_var[i].mask;
+
+        base_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        mask_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+
+        assoc = &assocs[i];
+        assoc->name = base_name;
+        assoc->value.reg64 = base;
+
+        assoc = &assocs[i + MSR_MTRRcap_VCNT];
+        assoc->name = mask_name;
+        assoc->value.reg64 = mask;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    fixed_offset = MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        fixed_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        fixed_value = env->mtrr_fixed[i];
+
+        assoc = &assocs[fixed_offset + i];
+        assoc->name = fixed_name;
+        assoc->value.reg64 = fixed_value;
+    }
+}
+
 int mshv_init_msrs(const CPUState *cpu)
 {
     int ret;
@@ -129,8 +225,9 @@ static void store_in_env(CPUState *cpu, const struct hv_register_assoc *assocs,
     union hv_register_value hv_value;
     ptrdiff_t offset;
     uint32_t hv_name;
+    size_t mtrr_index;
 
-    assert(n_assocs <= (ARRAY_SIZE(msr_env_map)));
+    assert(n_assocs <= MSHV_MSR_TOTAL_COUNT);
 
     for (i = 0, j = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         hv_name = assocs[j].name;
@@ -144,17 +241,38 @@ static void store_in_env(CPUState *cpu, const struct hv_register_assoc *assocs,
         MSHV_ENV_FIELD(env, offset) = hv_value.reg64;
         j++;
     }
+
+    mtrr_index = j;
+    store_in_env_mtrr_phys(cpu, &assocs[mtrr_index], MSHV_MTRR_MSR_COUNT);
 }
 
 static void set_hv_name_in_assocs(struct hv_register_assoc *assocs,
                                   size_t n_assocs)
 {
     size_t i;
+    size_t mtrr_offset, mtrr_fixed_offset;
+    hv_register_name hv_name;
+
+    assert(n_assocs == MSHV_MSR_TOTAL_COUNT);
 
-    assert(n_assocs == ARRAY_SIZE(msr_env_map));
     for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         assocs[i].name = msr_env_map[i].hv_name;
     }
+
+    mtrr_offset = ARRAY_SIZE(msr_env_map);
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        assocs[mtrr_offset + i].name = hv_name;
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+        assocs[mtrr_offset + MSR_MTRRcap_VCNT + i].name = hv_name;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    mtrr_fixed_offset = mtrr_offset + MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        assocs[mtrr_fixed_offset + i].name = hv_name;
+    }
 }
 
 static bool msr_supported(uint32_t name)
@@ -177,8 +295,8 @@ static bool msr_supported(uint32_t name)
 int mshv_get_msrs(CPUState *cpu)
 {
     int ret = 0;
-    size_t n_assocs = ARRAY_SIZE(msr_env_map);
-    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
+    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     size_t i, j;
     uint32_t name;
 
@@ -219,8 +337,9 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
     CPUX86State *env = &x86_cpu->env;
     ptrdiff_t offset;
     union hv_register_value *hv_value;
+    size_t mtrr_offset;
 
-    assert(n_assocs == ARRAY_SIZE(msr_env_map));
+    assert(n_assocs == MSHV_MSR_TOTAL_COUNT);
 
     for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         mapping = &msr_env_map[i];
@@ -229,12 +348,15 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
         hv_value = &assocs[i].value;
         hv_value->reg64 = MSHV_ENV_FIELD(env, offset);
     }
+
+    mtrr_offset = ARRAY_SIZE(msr_env_map);
+    load_from_env_mtrr_phys(cpu, &assocs[mtrr_offset], MSHV_MTRR_MSR_COUNT);
 }
 
 int mshv_set_msrs(const CPUState *cpu)
 {
-    size_t n_assocs = ARRAY_SIZE(msr_env_map);
-    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
+    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     int ret;
     size_t i, j;
 
-- 
2.54.0


