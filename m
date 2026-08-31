Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F62C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12iR-0003MI-Ec; Mon, 31 Aug 2026 10:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iQ-0003HW-Eh
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iN-0006cw-LH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VB9wZi3447038
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KRbWU9q52d0
 /x4ooipoZEsStKY3UhJIoyWXZCa1Lr1w=; b=mG7lnXjanBaytrMX0NFyiUvb0ij
 YgNI3fE432vlNuVFGhl/EhoDaOZpVGhlfMO9wC4Sx6ZXydJbiwmEeCEDrl3+r7si
 LHz1XJqpwRDLg51hfHsz3oTSU+9LkULU0PhcofwqPluTy4dEEwEc7eMTtZ6vw44L
 yeQrQd0GuZZz3kRqN68fEAEi/TVsuJ7Hx9O6s3/jsrmPCNJ1GYjqr3M2fse5tDl0
 VXHScYHCQipVPotSHhzsD7UnT/edvGVb2wjYrX78e8l5kDnav2JOCq9h+70qiX4e
 wzX0vh6EV9Uu9JTGmSY0BkpTRjofVjGbdphZB3EIrx7SB+SXWZ+U2vjab3w==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb967q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:16 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-46509ab0149so4135642fac.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185416; x=1788790216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KRbWU9q52d0/x4ooipoZEsStKY3UhJIoyWXZCa1Lr1w=;
 b=KCq54O8EXtQcV9hb9fbipiOT317uIhQSn+4M89YgcTgYInwiDF9jUMaDU1PAcGwK7K
 39Fd7w0moUE8v0ANno1f5I2XbBBdjoPuDuGbHxIfPOmukMWyBX03FmrTGdK3g3e+iZQm
 +V5Eyh1Ha7LPHSedlAniuQdDaRGYw+ZYzpljSn9C+Th2oghavukJM4CjG7ORjKkubNSu
 pKHKWB7VrwBU2pw1Ehor6Gn+KHuhMZ0pIkpJL/NAaBq0NsSx9fUDkRHFk4KZT8OxIcO/
 /DZL4hSifbNcBhv6iXZYDUU8IzI1RvdamPThRfh3PFDcnWtzkompiyBr68kFJapAkHH2
 7qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185416; x=1788790216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KRbWU9q52d0/x4ooipoZEsStKY3UhJIoyWXZCa1Lr1w=;
 b=Vhy81PvIUDPA9daY7m5cpQm7sSwr+NAi+19KQsYLJtCqcSC9NnJzWKgVTr8lxw1DTO
 XVS3jKOHdvjxg3vYsH4h1B9z64NflsG14OsRKdsjGbgxA9xvGwKcd8CFoUplz3rCwI11
 vnKTM2/gTvukYnq7q4GNs1KfpN+wywwvZQeLIEJ4N8D8SZ3F8qTTU/VMxN8NzrM8o8GM
 KdHvpYLMPFw2zAraj2GwYbmP3VyhCJJuzKL0aQEhobkLEjqX5DLTOMFilma53UFFnfgE
 wNCHofvjp5o29jKYh5sB0WcyYiHkYuJjLXV5tUJITRxfziNsiHSNt/Oong+ViCY0P4vp
 fJrg==
X-Gm-Message-State: AFuF++m7zfClbhjGsaGMuXl8uCokMp7ALs20QoNhBgJMbAFToQzaOA+w
 5FG9+EFNT+dsH7H3HMZJMz0IHxfeC9AoIoaeAlWpADRdk+BOC0OR8Dviy9vnQbqSnae7Xy7fMd5
 RbTAn0P7uBQBTXGRsmrB89VzgqZzMOvkSZqPI4bM+wJXvZpEOY7PMqqVgLW6zky8cSA==
X-Gm-Gg: AR+sD11ANUlGOkI7NTE11xL2FpfPkcepsEfzszroC/S024MXHny89ih7He2qbO3ZI62
 V2cyqMCahb5gj6ovF2pXDuwmVdZkSPxV+fx5cO1t6tj27VhJ8YwuEmY/m37oATFXOZz23iiwm4F
 vkemy/eqy8J6Mh2kNI5rG/MhX6kXXh3XEiwbz92v7LtB3Z0M3Dnhvj3UGV9eemE15ogR/nTB0j2
 UI0YNcL2Mi9xNllBJUq8SCSn9V1O75gwvgCuLQfnD/iqtwHvqnpcjT6eZHvJK1wwN62+5JwxcMV
 Tv2bMcnV18yrMVdCkcgVJX6ka5V/PguO53a87QvZqE+8hj/uoOYdjzWqBTy133V9zHIHKPqwdQQ
 mKIu6TSePhioJv5drRO0IITmTV7tt0+qnhb/mrA==
X-Received: by 2002:a05:6871:cc15:10b0:468:41ce:1675 with SMTP id
 586e51a60fabf-46841cf2b5dmr17989223fac.0.1788185416029; 
 Mon, 31 Aug 2026 07:10:16 -0700 (PDT)
X-Received: by 2002:a05:6871:cc15:10b0:468:41ce:1675 with SMTP id
 586e51a60fabf-46841cf2b5dmr17989173fac.0.1788185415414; 
 Mon, 31 Aug 2026 07:10:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm9886129fac.5.2026.08.31.07.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:10:14 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 1/7] target/riscv: add sdext debug CSRs state
Date: Mon, 31 Aug 2026 11:10:00 -0300
Message-ID: <20260831141007.353854-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
References: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hGF6WefEdeDQGmPtDMuZ9kFncEvNFCP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfXzknWzUgtzl8K
 8V7obR6qJLnpk73UTkTGlP7HIT7AjP2FJr4l9bbPgGlybyvsXEpEJzOrAYaENRVxGyib0B2VBVO
 eOhw3AV2DT7mpFnTYvvQ64QbFXfoejO72AqZHMXGiMHpZtJQWd8NBqY6Fxn0ZFPsPzMtOUGnLDP
 C0S1Ss7TjPpmuYLwCIYwM+cbfO8Lzp3nKs1UAXjMZQGAYHO0gUiZnfX44de491XKEp+oLwni13G
 v9+CbsurA9oQILcsRY9fT2ml2mE6Xcu0J2AR9SsLL8NoSpMfSRZgdIlXeAXe6GoswhOP9KYiDld
 A0Fwv2FeIDitRypd4xYq8GomypDqCEskL5m1zeECnRMU6vRfsuihdi3rDBYsdt9uZHKlF0RbAE0
 4ozxz1f6h2OhEMtfGnDiiJSHWb+8mKCBV8V04tVQkpY+2GF0UqiSFDSk+uFnkVS5oKXGSAjN4uH
 8zGlB8MavdxdYfEZHzg==
X-Proofpoint-GUID: hGF6WefEdeDQGmPtDMuZ9kFncEvNFCP_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfXxmJB+vn9nalq
 KewY5/5dnUjBpqI8UHstQ0Yb66KNcNA2oT9EVz9Shg/g5Pm9xWMhAkHJ5jwghGEkTorxrG1sa4X
 EfKj85m9awdERuIgjvRx1BAWP7UG72c=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a958b49 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=8aUGYKOvqt1NoZA4oJ4A:9
 a=1zu1i0D7hVQfj8NKfPKu:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310122
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
them to Debug Mode (or host debugger access).

The Sdext is not fully implemented, so it is disabled by default.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 target/riscv/cpu.c                |   7 ++
 target/riscv/cpu.h                |   4 +
 target/riscv/cpu_bits.h           |  33 ++++++++
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/machine.c            |  20 +++++
 target/riscv/tcg/csr.c            | 126 ++++++++++++++++++++++++++++++
 6 files changed, 191 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 61109672d6..c2078473aa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -248,6 +248,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
                                 has_priv_1_12),
@@ -1091,6 +1092,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
+    env->debug_mode = false;
+    env->dcsr = DCSR_DEBUGVER(4);
+    env->dpc = 0;
+    env->dscratch[0] = 0;
+    env->dscratch[1] = 0;
+
     if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 718b66487a..74bddc8415 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -507,6 +507,10 @@ struct CPUArchState {
 
     /* True if in debugger mode.  */
     bool debugger;
+    bool debug_mode;
+    target_ulong dcsr;
+    target_ulong dpc;
+    target_ulong dscratch[2];
 
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c01050ce2b..769c945517 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -467,6 +467,39 @@
 #define CSR_DCSR            0x7b0
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
+#define CSR_DSCRATCH1       0x7b3
+
+/* DCSR fields */
+#define DCSR_XDEBUGVER_SHIFT    28
+#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_DEBUGVER(val)      ((target_ulong)(val) << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_EXTCAUSE_SHIFT     24
+#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
+#define DCSR_CETRIG             BIT(19)
+#define DCSR_PELP               BIT(18)
+#define DCSR_EBREAKVS           BIT(17)
+#define DCSR_EBREAKVU           BIT(16)
+#define DCSR_EBREAKM            BIT(15)
+#define DCSR_EBREAKS            BIT(13)
+#define DCSR_EBREAKU            BIT(12)
+#define DCSR_STEPIE             BIT(11)
+#define DCSR_STOPCOUNT          BIT(10)
+#define DCSR_STOPTIME           BIT(9)
+#define DCSR_CAUSE_SHIFT        6
+#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
+#define DCSR_V                  BIT(5)
+#define DCSR_MPRVEN             BIT(4)
+#define DCSR_NMIP               BIT(3)
+#define DCSR_STEP               BIT(2)
+#define DCSR_PRV_MASK           0x3u
+
+#define DCSR_CAUSE_EBREAK       1
+#define DCSR_CAUSE_TRIGGER      2
+#define DCSR_CAUSE_HALTREQ      3
+#define DCSR_CAUSE_STEP         4
+#define DCSR_CAUSE_RESET        5
+#define DCSR_CAUSE_GROUP        6
+#define DCSR_CAUSE_OTHER        7
 
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index f91c780299..24f3606f94 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -105,6 +105,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_sdext)
 BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 74edb8c2b5..aba162d0f1 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -302,6 +302,25 @@ static const VMStateDescription vmstate_debug = {
         VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
                               env.num_triggers, 0,
                               vmstate_info_uint64, uint64_t),
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sdext = {
+    .name = "cpu/sdext",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = debug_needed,
+    .post_load = debug_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -577,6 +596,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ctr,
         &vmstate_sstc,
         &vmstate_mseccfg,
+        &vmstate_sdext,
         NULL
     }
 };
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index bd4b6dc114..988261cccf 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3207,6 +3207,126 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static RISCVException sdext(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_sdext) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (!env->debug_mode && !env->debugger) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_visible_mask(CPURISCVState *env)
+{
+    target_ulong mask = (target_ulong)-1;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!riscv_has_ext(env, RVH)) {
+        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
+    }
+    if (!riscv_has_ext(env, RVS)) {
+        mask &= ~DCSR_EBREAKS;
+    }
+    if (!riscv_has_ext(env, RVU)) {
+        mask &= ~DCSR_EBREAKU;
+    }
+    if (!cpu->cfg.ext_zicfilp) {
+        mask &= ~DCSR_PELP;
+    }
+    if (!cpu->cfg.ext_smdbltrp) {
+        mask &= ~DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException read_dcsr(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    *val = env->dcsr & dcsr_visible_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_writable_mask(CPURISCVState *env)
+{
+    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
+                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
+                        DCSR_STEP | DCSR_PRV_MASK;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    mask |= DCSR_MPRVEN;
+
+    if (riscv_has_ext(env, RVH)) {
+        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
+    }
+    if (riscv_has_ext(env, RVS)) {
+        mask |= DCSR_EBREAKS;
+    }
+    if (riscv_has_ext(env, RVU)) {
+        mask |= DCSR_EBREAKU;
+    }
+    if (cpu->cfg.ext_zicfilp) {
+        mask |= DCSR_PELP;
+    }
+    if (cpu->cfg.ext_smdbltrp) {
+        mask |= DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException write_dcsr(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    target_ulong mask = dcsr_writable_mask(env);
+    target_ulong new_val = env->dcsr;
+
+    new_val &= ~mask;
+    new_val |= val & mask;
+    new_val &= ~DCSR_XDEBUGVER_MASK;
+    new_val |= DCSR_DEBUGVER(4);
+    env->dcsr = new_val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dpc(CPURISCVState *env, int csrno,
+                               target_ulong *val)
+{
+    *val = env->dpc & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dpc(CPURISCVState *env, int csrno,
+                                target_ulong val, uintptr_t ra)
+{
+    env->dpc = val & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dscratch(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    *val = env->dscratch[index];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dscratch(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    env->dscratch[index] = val;
+    return RISCV_EXCP_NONE;
+}
+#endif /* !CONFIG_USER_ONLY */
+
 /* Execution environment configuration setup */
 static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
                                    target_ulong *val)
@@ -6435,6 +6555,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
     [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
+#if !defined(CONFIG_USER_ONLY)
+    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
+    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
+    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
+    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
+#endif
 
     [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
     [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
-- 
2.43.0


