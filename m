Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246D1CA5FA9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHWT-0004dB-6A; Mon, 28 Sep 2026 16:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHVU-0004Kr-7B
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:59:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHVM-0006iH-SB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:59:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHvuEg2338378
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KW6O1vVQ23h
 QWVoaauV9nB0kCvSpCOP8pM7o2rC7Q7g=; b=m0Z+KbQdwAtpsxRWmH/Kf6IHU7t
 Q6uwXbvrAL0fuxBKP3gcousUIluypE4HE9hcqubVAfEL5ds4NvCsDd8m2NCy1Qs0
 MDXB18TLWQ0V1u+Kon0WkJ/AOX/9MD96AxQm62dbeYS+0crRuhOFWyiy4l6aRa3t
 AGPDV33caO7RdVnkwQF5r0kaM4F2tIjosHLiIYdS11ypVtWh/j96EAS7OLNkCC6U
 iz0OYFmKDlCz69h8o6qnJP3vtFeUx8DDvoHId0ceu2Va6KX+Ahn12OlNvTIuVCiK
 4XzLM6eDnDiEHpXOAXv1gNwtHMQm2QiTgPb4QwirkyLaGyXatukqDmIjg8Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s3cu5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:59:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91454ecbd2fso51082046d6.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790625551; x=1791230351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KW6O1vVQ23hQWVoaauV9nB0kCvSpCOP8pM7o2rC7Q7g=;
 b=Gxk/EeHy7dVIUF9tAvTiF3DRZ/4uUKvsaUkbh1ZIVdfn9L2yPCAHnBNdAcR6+gTpQO
 i/oEBsKaddf2Jtgwp9k5jKXstxjve4nF2DtAvv3IjHBm/ACNb1zSal4pmqCFIzvm5NGN
 b0+V+V5neEV07Dh0XAMmXFSgJcGMCPl+UOFPwUj08EwAcGkT6x6AOUssaz2NrwP86qfZ
 KHr/EWCafo9tJpJ/8ZvFiCYlFllnTDBj7bTtb5/yQo/YwLpXZTMUINwLv5B6+MhAmkxi
 IvS5lFIr3VlRJYIF5/klw0ChgnJFrfFgtPIJgXpG32LaQIPmU5CwO7kyms97aCtL6Nyo
 arww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790625551; x=1791230351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KW6O1vVQ23hQWVoaauV9nB0kCvSpCOP8pM7o2rC7Q7g=;
 b=c3VMqKt3VXVk8QbeA3PV9qu14mpy6iHy0H3eJLRWM/XopAdPhfFVrTcB0LSAxdVNsP
 J7R24k1Grcb7NUQhltHmv2IyXCza6+jTyxQ1i9WibEfprASTqG0uc858CK/bJPihG0fc
 iEGYubCqBMKiblK79HepQ2pZ/WYuywt7Ba8PgEhkFSpJvu3goAJFlqMQestg582BhJV3
 aDDLFTUW/a/i1FQ0qwjRdK4Iu8iFbvxdyw6ogx2Fma09JcEe5X+8Qjswj0Defsj3a3sY
 4tzpfTSccapSIdgeJrJI6GX5jvraFL7claMT/xrcemPLfFydVkUYgK0ZqyRB44JBR+S7
 kdhw==
X-Gm-Message-State: AFq9FYLSQr9+9hLEAcZFtfyWsRhNssSYMAzadjODufbqLvhMoMziALXN
 bYgL1P+9Z7tIJ/UiVz7JxH6VAuHJNMn1Cww73HzqE5l6uhdaPel80uYCPq8c/felpM7EOpgYKvh
 C4TGJo54i5HZQCMxq2UMgecxC6wmP9vZ+D4wWBufMFIor7VNPx8/O6RsI+hzLPxh3Yw==
X-Gm-Gg: AYBFou0MkeBGWo2hMLEMYv/Bg0fiWdf4aRxSJnSXwGG2FaZMz0se7yvYIKTpD1SMeS7
 xVcX5w+NrEIUoavuvxHw0s1EmAgiHQXClHLISr2G2K9t86r9/GdZsxeFOS/hX0nFSjmw29qyVUO
 EFxBtMlmGAURlwKHhh4ynWoJye/C7Kp1CRIa6R/+gU6jcndIaMkHhSKKobTw7uH7g9qHjx1M68R
 fKytgrBPszpvJQKDp5ILCHWVPcYtDOYI6BJkVy6s8LkXZps15kPZ/XbK8LNK2U4IHVFrjfN+K4I
 5I/FAxI4DvRR0gAJAsfEaCLENXQ2g2N2Z/UHE7pwcJ31w7x7Vqvt4LRXqt08SjoJA0xrw/JPGDc
 q2TqZMHtCI8cKWsRY4SsIoO5A+KfQ5Pp6dCQ=
X-Received: by 2002:a05:6214:daf:b0:915:eb3f:30b9 with SMTP id
 6a1803df08f44-915eb3f3449mr73386786d6.9.1790625551023; 
 Mon, 28 Sep 2026 12:59:11 -0700 (PDT)
X-Received: by 2002:a05:6214:daf:b0:915:eb3f:30b9 with SMTP id
 6a1803df08f44-915eb3f3449mr73386386d6.9.1790625550386; 
 Mon, 28 Sep 2026 12:59:10 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9143d0a64b9sm75905556d6.35.2026.09.28.12.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:59:09 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v10 1/7] target/riscv: add sdext debug CSRs state
Date: Mon, 28 Sep 2026 16:58:55 -0300
Message-ID: <20260928195902.2045235-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
References: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3OSBTYWx0ZWRfX+hymfPAM73HH
 qgBZsJ2niwluzocTzn1c9/kcnebK87FgWu6Vbckym97V4ah1BkZ641QhErJNlv/lusHfgqCe37I
 5S/ZXFmawiQP0Dn01RIIBIHIXGAwNQYO7fA8JaoAozzCrVZqZ3cpi9vKHXElM/YoZrxfKqrgCKt
 1a93nf9WAlSYOXB8AI0OAFBYbIFvBnJqAEv9OwdhXTaVAzzauzsbVo6iyb7CJCnMhH2m4y5No1/
 ur3l1s+rQgevyd02zheES74YxWc+TFLFQ+Cm83Mfg03UiIlPfNiF3+GYjarRmMhoszZxBUtS/Jm
 ZMjTNfa0YCZeGdHXSZu0RliiNR8o9RtNC9gogX4lJ0m7952Q08E2+HtDmH9vzqCOUKbJpX2xGAh
 MRCkgGvFh26gurvMvNYFePxkMIWUAFvR/C42Tp2Gee7RceN6huAlEKtfnBTGHf9n8vOCtkZRUNY
 1ihu/8GMiwwOY8Eu+CA==
X-Proofpoint-ORIG-GUID: 2zMZK2Vu9I5VVVOAYnwjatUdKar2JTK6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3OSBTYWx0ZWRfX7Oxqr7SqmmoP
 C3KwCml2AaTVUpIPWoAiaJ6skddxwdYnwLwqbf9o7Vr3IjfChUqAkjLHtvY8Q1wmngUkYDZWT+I
 gORozDCnLS4sU+dZfN+sjbI6oKbWe2s=
X-Proofpoint-GUID: 2zMZK2Vu9I5VVVOAYnwjatUdKar2JTK6
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6abac710 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=69EAbJreAAAA:8
 a=8aUGYKOvqt1NoZA4oJ4A:9 a=pJ04lnu7RYOZP9TFuWaZ:22 a=_Ge82aPy-h_wFa7gWU4u:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 target/riscv/cpu.c                |   7 ++
 target/riscv/cpu.h                |   4 +
 target/riscv/cpu_bits.h           |  33 ++++++++
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/machine.c            |  22 ++++++
 target/riscv/tcg/csr.c            | 126 ++++++++++++++++++++++++++++++
 6 files changed, 193 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da4c1a090b..f5490c81ea 100644
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
@@ -1094,6 +1095,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
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
index 5489c564ae..5de8b2ceb4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -510,6 +510,10 @@ struct CPUArchState {
 
     /* True if in debugger mode.  */
     bool debugger;
+    bool debug_mode;
+    uint32_t dcsr;
+    target_ulong dpc;
+    target_ulong dscratch[2];
 
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c01050ce2b..3579789a1f 100644
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
+#define DCSR_DEBUGVER(val)      ((val) << DCSR_XDEBUGVER_SHIFT)
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
index ed10e65259..0de06e9588 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -327,6 +327,13 @@ static bool debug_needed(void *opaque)
     return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
 }
 
+static bool sdext_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_sdext;
+}
+
 static int debug_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
@@ -361,6 +368,20 @@ static const VMStateDescription vmstate_debug = {
     }
 };
 
+static const VMStateDescription vmstate_sdext = {
+    .name = "cpu/sdext",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdext_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(env.debug_mode, RISCVCPU),
+        VMSTATE_UINT32(env.dcsr, RISCVCPU),
+        VMSTATE_UINTTL(env.dpc, RISCVCPU),
+        VMSTATE_UINTTL_ARRAY(env.dscratch, RISCVCPU, 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int riscv_cpu_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
@@ -634,6 +655,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ctr,
         &vmstate_sstc,
         &vmstate_mseccfg,
+        &vmstate_sdext,
         NULL
     }
 };
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index fe561c7649..09897c59fb 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3254,6 +3254,126 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
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
@@ -6498,6 +6618,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


