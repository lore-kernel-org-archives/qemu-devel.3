Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A4CCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 18:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSIq7-0004P0-7e; Wed, 27 May 2026 14:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSIpw-0004Iz-BM
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:18:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSIpt-0002fV-AX
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:18:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RHXscB150054
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 18:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nLhP0p/Ls7k
 3OiDQO1/N8nCEm2JVT2Uv8Rx5BBGtfpU=; b=lzeBnBwFPGAz/x5X53hrWUiBQCK
 ftdTf3ustU2LZyklixxCDbfJfnZj6lob9meBhrSWrmwokx1z30DJp2wPo9fURPLp
 QKRszNHNoW+OTIq8VCqc1RbQheZVjsWK5xrjxSp31n4BNp8QSnAnuLyBYJZPIXkw
 x2bZSzdFQZm8xGeRjJHIFcN5XbLknpZCh8gzSj0fLweR2ayFMOeMYcGukzBl1c7K
 FuEalPW4CmMCHWLW+Hu6cScn0vrkJ5f99Sbu97vbGXzo0inYP6nOWLaC5TFljxQ8
 2DxQCux89eEP1DlvKa77ttDB03dkZTLJUJb2yfaFxojbwUmkEQN56FUQq0A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxxvst9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 18:18:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b7e68098dcso130969866d6.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779905910; x=1780510710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLhP0p/Ls7k3OiDQO1/N8nCEm2JVT2Uv8Rx5BBGtfpU=;
 b=Ce9KJAsEWqTZf/VLGX/J0GYmcB0fX41Fmu7ZnOM8uK4jeLSPvGOT6UbyySkOGT9pOL
 HWdoSKpWQXd5FH4J5cSf7uHIiGbflOOTaARJ11pkzaXpe5G4O68X+zpZ8tTgMkDc341F
 my2ROG86hVOUQI4xhGY6V/amMjLkKAON23neqsrwebuSpk6v6jOL08KTKvj6epmlCDzF
 MeFSk5c59rK17H9zGl2c475HNO3wKzlKCZqMr26X8D7CKfv5pvuHNBM4y1H85t3ItAOV
 58390POVYKQBR3qX719+cldaocNCcBeeDsOUulMW8rNM32ohq9HoytvZsi7hhQ8fHIeP
 xVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779905910; x=1780510710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nLhP0p/Ls7k3OiDQO1/N8nCEm2JVT2Uv8Rx5BBGtfpU=;
 b=G+83jKdqVK2SpLaDPmc5sKdqG8DX7lKprwOvu1oH/dybVrddKVsd5ciF648hLytmC2
 ZkHpXnZ+z4ARf19evK9Mv1RPHTMOHOrX2tQvT0K1Bbfd77X/Qr7xRLFcR6W/Qg3viqUW
 9j3wpxSXTNZ7t5kIQl63dzGsyxrgX6ZVmKrvCw1DVMbKqYhdchBcssobkO296pkObEn7
 M+NqylV32gTaGr78g2gAhdJAIbhEzadxe4c/ZmBKeBRCylERkaV6xuizVz4Bczh2J8bm
 7KxnHfVeYbtv3ZNEBk3/pwrURjC39WOReYfplGvm01okfR0Q4wJi25XCwJywHPiSpX1Q
 vkKQ==
X-Gm-Message-State: AOJu0YyWX/cfBSaAr6YLue+CCdUQHSf+1NUPRfZKfg/bXtx0NW2ayKmW
 OTUr4hwZg61CKSot3KVFFIxvTXPJ7aWEbEL++OqLr+6BNIUITrbtY0iIcpozOAEMsD8fZhlN3xR
 Q5/GNTqfgOrcYxyGE155o4hn6JD4g8kz3B8H6Bi3QauPbfvTEx+6s9Xe2tftcoO07ag==
X-Gm-Gg: Acq92OH0a0+ehJdP1Itz0A0K/PAHkIxQSvfkNMaX3/0KrebKbKcf+FeGDbJ3L0K5lYx
 8algyRSCbYA1MtX2uDjvInpRkeiRMlSpmdCOwpw6VsiQ1IaW1/u6r/GmxcZu6Lg96MWT2/eu+bR
 EplkncwF9bFJiryIyQ6WqQ/acbOc3aP86oW4MZvSLdNQPGeJqsKQxSkjlQjo7i5i1bbV1uUgbhI
 VpkdQCKX55C2Smgpe5lUEKmP7cbZXIf1kRMfglN1WU95o8PdCK2Ol0kDzGpqslMDzYjvz23Qskc
 WxwnBEZ7j79E4q0HoZtnshKGrWKSktHwn37mcws+YyfPxBSBe645Uue3Tn1RIpPzT6HaJJlf7iT
 vvoXUpJCWQuihuvwfz+sSFPHEp5ZjZd+NatXNTgYqvH5tg2doesZuNFp4vDanv5DhigR00g==
X-Received: by 2002:a05:6214:c21:b0:8b2:8b6:4bcf with SMTP id
 6a1803df08f44-8cc7b56e9f3mr401217226d6.0.1779905909665; 
 Wed, 27 May 2026 11:18:29 -0700 (PDT)
X-Received: by 2002:a05:6214:c21:b0:8b2:8b6:4bcf with SMTP id
 6a1803df08f44-8cc7b56e9f3mr401216566d6.0.1779905909098; 
 Wed, 27 May 2026 11:18:29 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80df081asm174454426d6.18.2026.05.27.11.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 11:18:28 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 1/1] target/riscv: deprecate 'debug' CPU property
Date: Wed, 27 May 2026 15:18:22 -0300
Message-ID: <20260527181822.1945644-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527181822.1945644-1-daniel.barboza@oss.qualcomm.com>
References: <20260527181822.1945644-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rY2AmqcrdswnPwYMayxDae32zhAVKBPQ
X-Authority-Analysis: v=2.4 cv=bJAm5v+Z c=1 sm=1 tr=0 ts=6a173576 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=Db-wHElssVap-trf3igA:9
 a=iYH6xdkBrDN1Jqds4HTS:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4MyBTYWx0ZWRfX9milsBpfbVzT
 LtlgmpSUCSFrJiCsrQkxSzQ5xC29h6sVXl1RjYrDI5qgwiIlo2r3QTt189mEBwNTpgmAcMym0Ee
 lx+muPjiqI2rc1uMpUiGc0nZe9xZe2HLpG4ZyuKkq9eTkQIQEohX/AIUNkqQONMZgHMn3NUV8ke
 Xf7KCZ8a4GxiE2UwkyCUIoMqcuDUYf57Wrt3cEr75Rc0WFw2OFzps3nJF6DGnu7RRNUDqtw+089
 qbO0KAX6G6yj4HvnJ41ohrkuqMtz7E9ajREdEt/CcvdduO1KKrsMKlWqgTxth3K/+xz0/bjU9w0
 1w7w1YO1Qp6z30xEp2NrAaiXY6i4FwKf5VDVCKBCudxAfYIanr5H5aJf5xxG0f3qOfn94tunMP6
 UeYBHDnMXOOxx7QwYeSnsvfNTalIdJugSm3Yzan/Na6KuzwwX7nhUiudQwUbw+RPsFmlMdrb0eL
 6eEboVNuOf4nkW4cwGQ==
X-Proofpoint-GUID: rY2AmqcrdswnPwYMayxDae32zhAVKBPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig'.

We're going to add more debug trigger extensions, e.g. 'sdext' [1].  And
all of a sudden the existence of this flag is now weird. Do we keep it
as a 'sdtrig' only or do we add 'sdext'?

The solution proposed here is to deprecate it. The flag was introduced a
long time ago as a way to encapsulate support for all debug related
CSRs.  Today we have specific debug trigger extensions and there's no
more use for a generic 'debug' flag. Users should be encouraged to
enable/disable extensions directly instead of using "made-up" flags that
exists only in a QEMU context.

The following changes are made:

- 'ext_sdtrig' flag was added in cpu->cfg. 'debug' flag was removed from
  cpu->cfg;
- All occurrences of cpu->cfg.debug were replaced to 'ext_sdtrig';
- Two explicit getters and setters for the 'debug' property were added.
  The property will simply get/set ext_sdtrig;
- vmstate_debug was renamed to vmstate_sdtrig. We're aware that this
  will impact migration between QEMU 10.2 to newer versions, but we're
  still in a point where the migration break cost isn't big enough to
  justify adding migration compatibility scaffolding.

Finally, deprecated.rst was updated to deprecate 'debug' and encourage
users to use 'ext_sdtrig' instead.

[1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevorn@gmail.com/

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 docs/about/deprecated.rst         |  6 ++++
 target/riscv/cpu.c                | 50 ++++++++++++++++++++++++++++---
 target/riscv/cpu_cfg_fields.h.inc |  2 +-
 target/riscv/csr.c                |  2 +-
 target/riscv/machine.c            | 24 +++++++--------
 target/riscv/tcg/tcg-cpu.c        |  2 +-
 6 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 97750f5edc..7014d706c1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -417,6 +417,12 @@ ABI is long-obsolete. We are therefore deprecating both OABI support
 and NWFPE emulation, and they will be removed in a future QEMU
 release.
 
+``debug=true|false`` on RISC-V CPUs (since 11.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This option, since QEMU 10.1, has been a simple alias to the ``sdtrig``
+extension. Users are advised to enable/disable ``sdtrig`` directly instead
+of using ``debug``.
 
 Backwards compatibility
 -----------------------
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b480..54e8f78a4d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -226,7 +226,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
-    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
                                 has_priv_1_12),
     ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
@@ -807,7 +807,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -971,7 +971,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1150,6 +1150,14 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    /*
+     * 'debug' started being deprecated in 11.0, been just a proxy
+     * to set ext_sdtrig ever since. It has been enabled by default
+     * for a long time though, so we're stuck with setting set 'strig'
+     * by default too. At least for now ...
+     */
+    cpu->cfg.ext_sdtrig = true;
+
     if (mcc->def->profile) {
         mcc->def->profile->enabled = true;
     }
@@ -2514,8 +2522,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     NULL
 };
 
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static void prop_debug_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.ext_sdtrig;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static void prop_debug_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+
+    visit_type_bool(v, name, &value, errp);
+    cpu->cfg.ext_sdtrig = value;
+}
+
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static const PropertyInfo prop_debug = {
+    .type = "bool",
+    .description = "DEPRECATED: use 'sdtrig' instead.",
+    .get = prop_debug_get,
+    .set = prop_debug_set,
+};
+
 static const Property riscv_cpu_properties[] = {
-    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    {.name = "debug", .info = &prop_debug},
 
     {.name = "pmu-mask", .info = &prop_pmu_mask},
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 734fa079f2..44235bfaa1 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
+BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smstateen)
 BOOL_FIELD(ext_sstc)
 BOOL_FIELD(ext_smcdeleg)
@@ -159,7 +160,6 @@ BOOL_FIELD(ext_xlrbr)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
-BOOL_FIELD(debug)
 BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5514e0f455..17992715ff 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -796,7 +796,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6776e7bf5a..4ca5c9c8d7 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -218,14 +218,14 @@ static const VMStateDescription vmstate_kvmtimer = {
 };
 #endif
 
-static bool debug_needed(void *opaque)
+static bool sdtrig_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.ext_sdtrig;
 }
 
-static int debug_post_load(void *opaque, int version_id)
+static int sdtrig_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
@@ -237,12 +237,12 @@ static int debug_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_debug = {
-    .name = "cpu/debug",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .needed = debug_needed,
-    .post_load = debug_post_load,
+static const VMStateDescription vmstate_sdtrig = {
+    .name = "cpu/sdtrig",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdtrig_needed,
+    .post_load = sdtrig_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
         VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
@@ -444,8 +444,8 @@ static const VMStateDescription vmstate_mseccfg = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 11,
-    .minimum_version_id = 11,
+    .version_id = 12,
+    .minimum_version_id = 12,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -511,7 +511,6 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_kvmtimer,
 #endif
         &vmstate_envcfg,
-        &vmstate_debug,
         &vmstate_smstateen,
         &vmstate_jvt,
         &vmstate_elp,
@@ -519,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ctr,
         &vmstate_sstc,
         &vmstate_mseccfg,
+        &vmstate_sdtrig,
         NULL
     }
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3e22e7ed53..a6dd864264 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -180,7 +180,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.43.0


