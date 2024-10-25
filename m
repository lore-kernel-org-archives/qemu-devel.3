Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3949BD0C5FB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 10:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4HSJ-0003th-KX; Fri, 25 Oct 2024 06:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HSI-0003t5-By
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HSD-0000RI-Oa
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729851721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ky3ThRkvDhjr0upkbEECwN+3U+A5A3WcAWKqNWydsmA=;
 b=LmLvFvqHQhoDWUo+SIt/n8mIBuabLi27adVOEr4QXlFKG73dvUabt4CYjUp1dw6Qjm1PEX
 QWeigorMfT+8l202QX5c1E2PZMkGXyqDmPpBu8rkn4sqcHvGBBlNqAGXN1qlmhCqm7vJms
 xNEJSuOr0EJHf5V+ZDp45ziMoMpSI54=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-ZohcQP7aM26-5wtACeHH9g-1; Fri,
 25 Oct 2024 06:20:33 -0400
X-MC-Unique: ZohcQP7aM26-5wtACeHH9g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 260281956083; Fri, 25 Oct 2024 10:20:31 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8165196BB7E; Fri, 25 Oct 2024 10:20:24 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 02/21] arm/cpu: Add sysreg definitions in cpu-sysegs.h
Date: Fri, 25 Oct 2024 12:17:21 +0200
Message-ID: <20241025101959.601048-3-eric.auger@redhat.com>
In-Reply-To: <20241025101959.601048-1-eric.auger@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This new header contains macros that define aarch64 regiters.
In a subsequent patche, this will be replaced by a more exhaustive
version that will be generated from linux arch/arm64/tools/sysreg
file. Those macros are sufficient to migrate the storage of those
ID regs from named fields in isar struct to an array cell.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu-sysregs.h | 42 +++++++++++++++++++++++++++++++
 target/arm/cpu.h         | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 target/arm/cpu-sysregs.h

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
new file mode 100644
index 0000000000..f4b63a3af7
--- /dev/null
+++ b/target/arm/cpu-sysregs.h
@@ -0,0 +1,42 @@
+#ifndef ARM_CPU_SYSREGS_H
+#define ARM_CPU_SYSREGS_H
+
+/* to be generated */
+
+#define SYS_ID_AA64PFR0_EL1                             sys_reg(3, 0, 0, 4, 0)
+#define SYS_ID_AA64PFR1_EL1                             sys_reg(3, 0, 0, 4, 1)
+#define SYS_ID_AA64SMFR0_EL1                            sys_reg(3, 0, 0, 4, 5)
+#define SYS_ID_AA64DFR0_EL1                             sys_reg(3, 0, 0, 5, 0)
+#define SYS_ID_AA64DFR1_EL1                             sys_reg(3, 0, 0, 5, 1)
+#define SYS_ID_AA64ISAR0_EL1                            sys_reg(3, 0, 0, 6, 0)
+#define SYS_ID_AA64ISAR1_EL1                            sys_reg(3, 0, 0, 6, 1)
+#define SYS_ID_AA64ISAR2_EL1                            sys_reg(3, 0, 0, 6, 2)
+#define SYS_ID_AA64MMFR0_EL1                            sys_reg(3, 0, 0, 7, 0)
+#define SYS_ID_AA64MMFR1_EL1                            sys_reg(3, 0, 0, 7, 1)
+#define SYS_ID_AA64MMFR2_EL1                            sys_reg(3, 0, 0, 7, 2)
+#define SYS_ID_AA64MMFR3_EL1                            sys_reg(3, 0, 0, 7, 3)
+
+#define SYS_ID_PFR0_EL1                                 sys_reg(3, 0, 0, 1, 0)
+#define SYS_ID_PFR1_EL1                                 sys_reg(3, 0, 0, 1, 1)
+#define SYS_ID_DFR0_EL1                                 sys_reg(3, 0, 0, 1, 2)
+#define SYS_ID_MMFR0_EL1                                sys_reg(3, 0, 0, 1, 4)
+#define SYS_ID_MMFR1_EL1                                sys_reg(3, 0, 0, 1, 5)
+#define SYS_ID_MMFR2_EL1                                sys_reg(3, 0, 0, 1, 6)
+#define SYS_ID_MMFR3_EL1                                sys_reg(3, 0, 0, 1, 7)
+#define SYS_ID_ISAR0_EL1                                sys_reg(3, 0, 0, 2, 0)
+#define SYS_ID_ISAR1_EL1                                sys_reg(3, 0, 0, 2, 1)
+#define SYS_ID_ISAR2_EL1                                sys_reg(3, 0, 0, 2, 2)
+#define SYS_ID_ISAR3_EL1                                sys_reg(3, 0, 0, 2, 3)
+#define SYS_ID_ISAR4_EL1                                sys_reg(3, 0, 0, 2, 4)
+#define SYS_ID_ISAR5_EL1                                sys_reg(3, 0, 0, 2, 5)
+#define SYS_ID_MMFR4_EL1                                sys_reg(3, 0, 0, 2, 6)
+#define SYS_ID_ISAR6_EL1                                sys_reg(3, 0, 0, 2, 7)
+#define SYS_MVFR0_EL1                                   sys_reg(3, 0, 0, 3, 0)
+#define SYS_MVFR1_EL1                                   sys_reg(3, 0, 0, 3, 1)
+#define SYS_MVFR2_EL1                                   sys_reg(3, 0, 0, 3, 2)
+#define SYS_ID_PFR2_EL1                                 sys_reg(3, 0, 0, 3, 4)
+#define SYS_ID_DFR1_EL1                                 sys_reg(3, 0, 0, 3, 5)
+#define SYS_ID_MMFR5_EL1                                sys_reg(3, 0, 0, 3, 6)
+#define SYS_ID_AA64ZFR0_EL1                             sys_reg(3, 0, 0, 4, 4)
+
+#endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1493b35d99..0491a482f0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -144,6 +144,14 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
+typedef struct ARMSysReg {
+    int op0;
+    int op1;
+    int crn;
+    int crm;
+    int op2;
+} ARMSysReg;
+
 /* Define a maximum sized vector register.
  * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
  * For 64-bit, this is a 2048-bit SVE register.
@@ -834,6 +842,51 @@ typedef struct IdRegMap {
     uint64_t regs[NR_ID_REGS];
 } IdRegMap;
 
+#define ARM_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm, op2)               \
+        ({                                                              \
+                __u64 __op1 = (op1) & 3;                                \
+                __op1 -= (__op1 == 3);                                  \
+                (__op1 << 6 | ((crm) & 7) << 3 | (op2));                \
+        })
+
+static inline uint64_t _get_idreg(const IdRegMap *map, ARMSysReg sr)
+{
+    int index = ARM_FEATURE_ID_RANGE_IDX(sr.op0, sr.op1, sr.crn, sr.crm, sr.op2);
+
+    return map->regs[index];
+}
+
+static inline void _set_idreg(IdRegMap *map, ARMSysReg sr, uint64_t value)
+{
+    int index = ARM_FEATURE_ID_RANGE_IDX(sr.op0, sr.op1, sr.crn, sr.crm, sr.op2);
+
+    map->regs[index] = value;
+}
+
+/* REG is ID_XXX */
+#define FIELD_DP64_IDREG(MAP, REG, FIELD, VALUE)              \
+{                                                             \
+uint64_t regval = _get_idreg(MAP, SYS_ ## REG ## _EL1);       \
+regval = FIELD_DP64(regval, REG, FIELD, VALUE);               \
+_set_idreg(MAP, SYS_ ## REG ## _EL1, regval);                 \
+}
+
+#define FIELD_EX64_IDREG(MAP, REG, FIELD)                     \
+FIELD_EX64(_get_idreg(MAP, SYS_ ## REG ## _EL1), REG, FIELD)  \
+
+#define SET_IDREG(MAP, REG, VALUE)                            \
+_set_idreg(MAP, SYS_ ## REG ## _EL1, VALUE)
+
+#define GET_IDREG(MAP, REG)                                   \
+_get_idreg(MAP, SYS_ ## REG ## _EL1)
+
+static inline ARMSysReg sys_reg(int op0, int op1, int crn, int crm, int op2)
+{
+        ARMSysReg sr = {op0, op1, crn, crm, op2};
+
+        return sr;
+}
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
@@ -1043,6 +1096,7 @@ struct ArchCPU {
         uint64_t id_aa64zfr0;
         uint64_t id_aa64smfr0;
         uint64_t reset_pmcr_el0;
+        IdRegMap idregs;
     } isar;
     uint64_t midr;
     uint32_t revidr;
-- 
2.41.0


