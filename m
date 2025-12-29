Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C64DE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIu-0004V3-Km; Mon, 29 Dec 2025 13:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaII4-0003oO-Ao
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHt-0008IX-3V
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:23 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTARDx63834922
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6akNvojVUeM
 jZYffEyBhFsnCpgVYGhubCOr0EvXTmtA=; b=kXUAut+uYCMSnSyRFuy/wXfV2ps
 HnZP7sxB0CjK5OY8VZbjlVBAmP+An4ZG9wDI4E0KKIi4uJy9CfyBNnR3NWtoo2yb
 H5LtzOQ4rlACedK+wUt23Q1s/Z5zSWedJJudVYpmlqmt5JvP2jpMKyBbAeI0Tylp
 jj4BHSEWCRvRidFdwUnAFlV+6mh0d+Vs9szOlJ7NVnzdB+3M5DomKlWjhH4nBSer
 k8bItb17OTcT0ue2Ii1VeH4hw/6a+McpHxdLmABBLkAfm4ZHAhcUYozwwRFPLuyN
 ZKuVEC58vBL3jnRaHhUHnoNSPRuwWCZiZnAgcDgTWNv6Hayr2RqVw8xN4UA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6sg553d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:48:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29f27176aa7so199014815ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034080; x=1767638880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6akNvojVUeMjZYffEyBhFsnCpgVYGhubCOr0EvXTmtA=;
 b=fP1sFuTyWJDnoedknfV2nExex158cRjslLe1mm0PHILvkKBt9rEjReC7Io2laYlYF7
 teaVBvU4SKVZ+AAzq+fJqQ/CnCwtMDn1/qexM/wt53VcnLRxJfL+NTZpkpNmY9qAcgK/
 rxX1jt1yi56K98kZEaVOZmkCGZ/KfuqmToSDpnH6U40owRIMutgv4ftKlRf0LXcrOFKM
 c45ELhURJ1SSMx7LtNj02AxqQLRtYeDUjtysV9C7QA1DGWSzrosaqeW+gk8ZnM4pq/OJ
 15vHNGeylOVlQr6o3SisyJtkHawNeWKj29agLNuF74cgR08kr49oxAdCF34vP2MLLg43
 /NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034080; x=1767638880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6akNvojVUeMjZYffEyBhFsnCpgVYGhubCOr0EvXTmtA=;
 b=AUUlx2gNxI1VCBMc/xOzdZp4HkBJZ3W2lxmij6ydFIpQetDS0zXn7bPIOTSOmYgCdY
 a8axeqi4HfDaatsaunDUaPkuuHs1qdhdsaQzJx4cogBHRkz3PFBDmCRBL/ps/c3m2v8I
 wKUwq+zQ4bMUdWNSzJRWRWLAoNSDokogPjGD16e/cRl5e/yrJ8yobkIU+PLD18A0GTrX
 O3L3s0Ejunz8/EnagygkznDllMQwRV7oCwGCeIsAltHPodXnvDUAZLW1nFzcPkTbCdKs
 evcuvcb3JtsoksUvcrAmX5Yr56FIZ5sUhCylbcQiMUzJF7fM0KPO6FTYSzrVjB7FAaPg
 Pb/w==
X-Gm-Message-State: AOJu0Yze1PmUMbFTa5p5WNfNBugLBCzOxzgEJz4mJXijHZD0vgm+bqNJ
 iy1/OTsg5ia/dnTPAk64eDVLK62IGGcboATXy1MHoz17epLlgwS2R1jNnuKr8yLZbtRNHMstQZ9
 uKt6kvqRvDfY8oQhyNs6deodLVYYhEEBvGjA40vlI+4Vfd/0MPJwEEwe6T7ACszhsKA==
X-Gm-Gg: AY/fxX5PGeByfIVS5YSuSVDAnGvAIF6MZ+P8cBkctNUq//Ve6MGlCJAHXIpJWVB2JJz
 uiVh1vQ/KfqIqj54h+z/YV5DbeDgVwdPPaXllAd8kY0xxc9dm7eadjunMt2WVm1QrwcLF+g/GxN
 3mQARENWXoXLdfPjsUAbZfq+Kxy/EHpikUeWby3D4IJjKJG4FtpFbCdnF5CB4tgffYcZDXjgNCF
 wKrOQ8BrUevXpvpGizeYfdm9dXZtj5bFQf58fAOiYwYrLdBNEctvBFnfWMFLQQ+TDB/Lg17O+86
 5GelgmmeYutgiFTj/Vg7JbNAZ3l4LPMuSYrlpbQzjusUymiTA9mAnkZ58O+JLYpxWll7FqzwuWe
 9zHvempMN9tui3rgNIsqYBL7+WXPItovAaL0bP02MMfzyQKA=
X-Received: by 2002:a17:902:f60a:b0:269:b6c8:4a4b with SMTP id
 d9443c01a7336-2a2f2208e80mr338296435ad.6.1767034079949; 
 Mon, 29 Dec 2025 10:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJReSgPtBOdTrvbocueDidAqdrdQRKQD/b1jDx5IVTNFcsteybYLK8Avt5Y6USi/5ZMSEdTg==
X-Received: by 2002:a17:902:f60a:b0:269:b6c8:4a4b with SMTP id
 d9443c01a7336-2a2f2208e80mr338296165ad.6.1767034079458; 
 Mon, 29 Dec 2025 10:47:59 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:59 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 16/17] hw/riscv/trace-encoder: send branches info
Date: Mon, 29 Dec 2025 15:46:55 -0300
Message-ID: <20251229184656.2224369-17-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: p3_-8MuUN7hKLmSeWA7Tahd88BB56e8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX2Qua0+eRPB8W
 YoGJc6LSEdwDG7sio/Uf166+T4Ta7jFwk1WLnxPNKSobdiMM8Lehg1EpNjfaKRExSpDW7fMszmM
 r0SrNCSHus9fmfhC183mapzS+Gkql5Mu0KqYXji9wYthBubhyPdDG/zarixvYGqTRW1N9DAbw+8
 ErH05Ed/FsCr/LMh+4HuZ7QqRlHWf6Au8jQqL9/7sJni2ZNmdvAPwTdhPw8Rm+yzA2ksNxb/H0+
 Z8TKOCkAooyh/hsL209BSsRgekEC0t9/PxsbNsFuq0Ac9rFp1zwPb8BUBx86vHeBIOhw3PhMAuY
 XFbU1c1UZIpEEj3k9ILf0vh1wgzx6zHvxsX3z2+d3mqV1thSLaiuMfGMEd6uOs8ouFBHtPuNiux
 kmfx6th1022kZw/Xmciu3VdcJ89TQPHdd6pGweHyjDMfXwH/7TvBk+K5w2zE/IJJeY5rioy4sL3
 Ae1mzO+v3JpUgMZzyRA==
X-Proofpoint-ORIG-GUID: p3_-8MuUN7hKLmSeWA7Tahd88BB56e8Y
X-Authority-Analysis: v=2.4 cv=Y+L1cxeN c=1 sm=1 tr=0 ts=6952cce1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GSE619UI_DCnt5MBBt8A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Branch info is reported via the TCG helpers, updating the trace encoder
internal branch map.

Branch packets are sent in two circunstances:

- when the branch map is full;

- when an updiscon packet is about to be sent and the branch map
  isn't empty.

The former will trigger a Format 1 no-addr packet, the latter a Format 1
with the updiscon address.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c                | 52 ++++++++++++++++++++++++-
 hw/riscv/trace-encoder.h                |  4 ++
 target/riscv/helper.h                   |  1 +
 target/riscv/insn_trans/trans_rvi.c.inc | 13 +++++++
 target/riscv/trace_helper.c             | 12 ++++++
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 8b16ce6fa0..c0f74887cf 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -29,6 +29,8 @@
  */
 #define TRACE_MSG_MAX_SIZE 32
 
+#define TRACE_MAX_BRANCHES 31
+
 static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
 {
     CPURISCVState *env = &te->cpu->env;
@@ -313,6 +315,9 @@ static void trencoder_reset(DeviceState *dev)
     te->trace_running = false;
     te->trace_next_insn = false;
     env->trace_running = false;
+
+    te->branch_map = 0;
+    te->branches = 0;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
@@ -410,9 +415,20 @@ static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
     bool updiscon = !notify;
     uint8_t msg_size;
 
-    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+    if (trencoder->branches > 0) {
+        msg_size = rv_etrace_gen_encoded_format1(format2_msg,
+                                                 trencoder->branches,
+                                                 trencoder->branch_map,
+                                                 pc,
                                                  notify,
                                                  updiscon);
+        trencoder->branches = 0;
+    } else {
+        msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+                                                     notify,
+                                                     updiscon);
+    }
+
     trencoder_send_message_smem(trencoder, format2_msg, msg_size);
 
     trencoder->updiscon_pending = false;
@@ -457,6 +473,40 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static void trencoder_send_branch_map(Object *trencoder_obj)
+{
+    TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_format1_noaddr(msg,
+                                                    te->branches,
+                                                    te->branch_map);
+    trencoder_send_message_smem(te, msg, msg_size);
+}
+
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool taken)
+{
+    TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
+
+    /*
+     * Note: the e-trace spec determines the value '1' for a
+     * branch *not* taken. The helper API is using taken = 1
+     * to be more intuitive when reading TCG code.
+     */
+    if (!taken) {
+        te->branch_map = deposit32(te->branch_map, te->branches, 1, 1);
+    }
+
+    te->last_branch_pc = pc;
+    te->branches++;
+
+    if (te->branches == TRACE_MAX_BRANCHES) {
+        trencoder_send_branch_map(trencoder_obj);
+        te->branches = 0;
+    }
+}
+
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 050406b531..48cf8366ee 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -28,6 +28,9 @@ struct TraceEncoder {
     uint32_t reg_mem_size;
 
     uint64_t first_pc;
+    uint64_t last_branch_pc;
+    uint32_t branch_map;
+    uint8_t branches;
 
     hwaddr baseaddr;
     hwaddr dest_baseaddr;
@@ -54,5 +57,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 void trencoder_report_updiscon(Object *trencoder_obj);
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool taken);
 
 #endif
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f27ff319e9..b1de064e17 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
 DEF_HELPER_1(trace_updiscon, void, env)
+DEF_HELPER_3(trace_branch, void, env, tl, int)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index ac00cbc802..ee29adbdeb 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -268,6 +268,15 @@ static void gen_setcond_i128(TCGv rl, TCGv rh,
     tcg_gen_movi_tl(rh, 0);
 }
 
+static void gen_trace_branch(int taken)
+{
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_branch(tcg_env, cpu_pc, tcg_constant_i32(taken));
+    gen_set_label(skip);
+}
+
 static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 {
     TCGLabel *l = gen_new_label();
@@ -299,11 +308,15 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     }
 #endif
 
+    gen_trace_branch(0);
+
     gen_goto_tb(ctx, 1, ctx->cur_insn_len);
     ctx->pc_save = orig_pc_save;
 
     gen_set_label(l); /* branch taken */
 
+    gen_trace_branch(1);
+
     if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
                                     ctx->priv_ver,
                                     ctx->misa_ext) &&
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index a4c5720a65..cd57641d9b 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -37,6 +37,13 @@ void helper_trace_updiscon(CPURISCVState *env)
     te->updiscon_pending = true;
     te->trace_next_insn = true;
 }
+
+void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    trencoder_report_branch(cpu->trencoder, pc, taken);
+}
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
 {
@@ -47,4 +54,9 @@ void helper_trace_updiscon(CPURISCVState *env)
 {
     return;
 }
+
+void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
+{
+    return;
+}
 #endif /* #ifndef CONFIG_USER_ONLY*/
-- 
2.51.1


