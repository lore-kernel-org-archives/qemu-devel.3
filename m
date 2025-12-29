Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4B5E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIh-0004Bx-57; Mon, 29 Dec 2025 13:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHO-0003i3-BD
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:49 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHM-0008Fu-Dr
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:42 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTA97S43642171
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0SfJ/yrK7FM
 0cvB/DgDChYJxB5rSfnncLQR9ksHFvOg=; b=FYBcjTTQNxN1MkiWpYWxIp2sxra
 Ty3QKqkIE6f4XB3k9ZknuDmtSDBryzoczup4O3GbWt6F7k1JBJ73sM8DQOp+lXFp
 EEV5zjPd+aEaLlq4JsmtAEC9YffSTFByievIzs6wh2MIYVpGuR1Bec+unI3QiNOl
 yybg7y4fryIB9+RGb5n0fHDtuewzcB2omq9MasyaVu7dR6WMhsUhMqdO3QPfX2rQ
 QYHspEbJH8rlglrcmyvLl2bhrhBxfP1f5wxq9uZASdOq3EPZ64/z8rW3Vzbnd6hD
 niZXW7l/7dG4w1jsTdddLYb4RvejKH7/y1DoM6ad409mS4WR+LnfrQPn3+Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6sg552u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a0d43fcb2fso312899965ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034058; x=1767638858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SfJ/yrK7FM0cvB/DgDChYJxB5rSfnncLQR9ksHFvOg=;
 b=dJLjlvgEcsnV2uDGfP0VScfivI0ss/WafOyLqYT1V9etex7W5MUHw0MzGFR2ztF6DM
 fMdF1KcCrvvAirRApgsoWEGuiUEm86MUv81J//1tdD3NCOVOFzFO5Psg05RZL8klLZHC
 sqxYOm0GUw/KQgTVU1vx62IVgRP8MgkL98TWGUjkRL4bHzuVy9K08qqUQVYC50060JHb
 j1bgIvaxm/hl8J+108qLPUC/4sWkC7Uv8gVxG8W7Akk9eN3ylGJGsyRrZUyVnbaw4W33
 d8/MLLzl7OKHhAt1VaXDTou53ffLWqN5EgkQ3ChGnzkXvrGznEUPaFkjHZcBB+Bk+7xs
 rhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034058; x=1767638858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0SfJ/yrK7FM0cvB/DgDChYJxB5rSfnncLQR9ksHFvOg=;
 b=V77eG761jNGii5RARFd97QWMkWCmtoUAyvbM4LlCtIVlaaNyzRthbINs3tYAmywk0F
 pq62TKPfduf5wBMCVKsy/QoDe5EhL4qImal+ng+BhpAHbM6ttE5U941K7ow1IGCjcmFY
 2uGA+txgsgEAVQKsvwbtHBxOY9vpXWRhBCy006OAy4V+h3vX1jFP3eowVjdnTH+SLXE8
 7a73C+2/khWqsljJv48eotyPlc+mGP1dHtOomX4QzBO+unbGDYU6PDPgHKy2a0awQP0+
 CEDoRBK2dpNVp52RVc7QsvrBZHMpr60gl3PjQweO845ZhD5HWJBJrGfFEfJpRO2Uu6E1
 iMRA==
X-Gm-Message-State: AOJu0YwjngV08pZVaJrwGOrI2IgrdY10V52nToHU/CC2URaunOPkII7z
 KfuX1lprY9NixBtG9itohPfFxtaZkPusVqKTPdCQt9XlRDvAD0EBdGQym6gWEXjnuZwhwM15c/r
 XoDwjn0bReOkWXaF56g0wfeZTGPfTUBw1DqHzLuFRyPIGty+Cw47sQERKS6MSwqopEA==
X-Gm-Gg: AY/fxX6thgMEf0I3gcgoFjxk0iH71Gn8vSthWn4krqQGPFqy2Bwp+/W9KueZUA3ioCs
 l6sRwFRpTSaiLaMRQCcVkVZD39nP15N0YKJ2dDWot4lCc0HDoLH0vSITIeoUXy9Ll+DapGitK23
 ishR9/3p98IneRVi94BKGorHLB7Ua0MkTtHJDTZaS7nAFWROLUaiPwwUiU3TxWN+WicL5CWOxq0
 IlLPkXdA7KXiv8m7IvBKyYg6P8A7PU0NisqzCv4Te6n3ncqARzEKkeCMpM+9hKYgZXY/n2GRcCz
 ElKErcEeHz5izYpRAadZMtQyjuaw3nQI2zDd2D38JP+v7csa5xlX0xIZhZODhq7eh0Ud+F0dazi
 WQBRM0o50NYZSoFKrDcaJPLcZ3WKPjJSniBChaSGinQDrRmA=
X-Received: by 2002:a17:902:e747:b0:2a0:b02b:2114 with SMTP id
 d9443c01a7336-2a2f220697cmr307093015ad.11.1767034058179; 
 Mon, 29 Dec 2025 10:47:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGxFPgFbZIcP8g2AqN/0ZC/0QlJdoERnhzHIOleGTAd1X2a6Icv02zGQb3L7pIfzIPJB07qA==
X-Received: by 2002:a17:902:e747:b0:2a0:b02b:2114 with SMTP id
 d9443c01a7336-2a2f220697cmr307092835ad.11.1767034057697; 
 Mon, 29 Dec 2025 10:47:37 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:37 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 08/17] hw/riscv/trace-encoder: write e-trace packets to RAM
 sink
Date: Mon, 29 Dec 2025 15:46:47 -0300
Message-ID: <20251229184656.2224369-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SWDALwAizKSOJ42WDtYGaMXvOGgvbPId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX18DV/xF8kCLo
 PAM5gO7kisMjLqCZMUjJqoyey/XjtWoGWQlGvjfYWybizrRh6R9+T0Vo6vo+FKQqSAC6ZanJCEZ
 I7TIvP6gJvcj217gjWeWUydUx7eA2uW9eq14ICl7SjwhL3tEICcSiK3Vp3w5cNCCskBhyXt7WJ+
 RXPusnzOOXK7HR0QmADwAeUoHHOujBwJwgoe6HL6M2gS9HgzcrFAUEcMTzG2xRy3rBzt0xZAt+I
 Nr7K3487uistH7HmTbzkL7ttguQpwpHlNzSsjSJ//zv3cAq9RspVqolELWoeFrd3N49rCokZ6nl
 WFui9vUFnQUW1SO2CiCW4xaXh5ZdJDhuwz5TkHilyydXd8xq/Jv9SzeV+W/rD3XQAwlsjXQi4T5
 WzNsrzPK7x2tmN3Cw8w55LgOR0looxYVkwJXJ3QYHcIvKWpoMGaPsqK5c3gENVsSkSP7mq5qNpK
 QrgrjyTe/bbd6H/psUA==
X-Proofpoint-ORIG-GUID: SWDALwAizKSOJ42WDtYGaMXvOGgvbPId
X-Authority-Analysis: v=2.4 cv=Y+L1cxeN c=1 sm=1 tr=0 ts=6952cccb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=R6bvkyUyvnGTYty0lT0A:9 a=GvdueXVYPmCkWapjIL-Q:22
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We have the needed pieces to make the trace encoder write messages (or
packets, in e-trace lingo) in its associated RAM sink.

We'll start by writing a sync message that we're already able to fetch
from the TCG instruction train. The trace encoder must be able to
read/write TR_RAM_WP RAM sink regs to know where it is supposed to write
packets, thus a handful of helpers are added to manipulate both the ram
sink SMEM memory and relevant registers.

The bulk of the work is done in trencoder_send_message_smem() where the
trace encoder writes each trace packet. The 'wrap' mechanism is
implemented to keep writing the RAM sink memory even after a SMEM
workflow.  If we can't fit a full packet in the end of the ring buffer
we're filling with NULLs and writing a new packet back to ramstart.

In an overflow event we'll wrap the TR_RAM_WP_LOW WRAP bit and userspace
is supposed to clear it after the wrapping was handled (i.e. userspace
read the whole ring buffer back to the start).

We're also allowing userspace to freely set ramsink and ramstart before
the trace session begins, allowing for more freedom w.r.t where the SMEM
will be written by the encoder. Note that this also means that userspace
is responsible for setting at least TR_RAM_WP_LOW and TR_RAM_WP_HIGH
before starting a trace session.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c | 121 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index b6f0fc7e13..3ffe4dfe61 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -20,6 +20,34 @@
 #include "system/device_tree.h"
 #include "hw/register.h"
 #include "cpu.h"
+#include "hw/riscv/trace-ram-sink.h"
+#include "rv-trace-messages.h"
+
+/*
+ * Size of header + payload since we're not sending
+ * srcID and timestamp.
+ */
+#define TRACE_MSG_MAX_SIZE 32
+
+static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
+{
+    CPURISCVState *env = &te->cpu->env;
+
+    switch (env->priv) {
+    case PRV_U:
+        return env->virt_enabled ? VU : U;
+    case PRV_S:
+        return env->virt_enabled ? VS : S_HS;
+    case PRV_M:
+        return M;
+    }
+
+    /*
+     * Return a reserved value to signal an error.
+     * TODO: handle Debug (D).
+     */
+    return RESERVED;
+}
 
 /*
  * trTeControl register fields
@@ -82,6 +110,41 @@ REG32(TR_TE_IMPL, 0x4)
 REG32(TR_TE_INST_FEATURES, 0x8)
     FIELD(TR_TE_INST_FEATURES, NO_ADDR_DIFF, 0, 1)
 
+static uint32_t trencoder_read_reg(TraceEncoder *te, uint32_t reg_addr)
+{
+    hwaddr addr = te->dest_baseaddr + reg_addr;
+    uint32_t val;
+
+    cpu_physical_memory_read(addr, &val, sizeof(uint32_t));
+    return val;
+}
+
+static void trencoder_write_reg(TraceEncoder *te, uint32_t reg_addr,
+                                uint32_t val)
+{
+    hwaddr addr = te->dest_baseaddr + reg_addr;
+
+    cpu_physical_memory_write(addr, &val, sizeof(uint32_t));
+}
+
+static hwaddr trencoder_read_ramsink_writep(TraceEncoder *te)
+{
+    hwaddr ret = trencoder_read_reg(te, A_TR_RAM_WP_HIGH);
+    ret <<= 32;
+    ret += trencoder_read_reg(te, A_TR_RAM_WP_LOW);
+
+    return ret;
+}
+
+static hwaddr trencoder_read_ramsink_ramlimit(TraceEncoder *te)
+{
+    hwaddr ret = trencoder_read_reg(te, A_TR_RAM_LIMIT_HIGH);
+    ret <<= 32;
+    ret += trencoder_read_reg(te, A_TR_RAM_LIMIT_LOW);
+
+    return ret;
+}
+
 static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
 {
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
@@ -171,6 +234,9 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     if (!te->trace_running && trTeInstTracing) {
         /* Starting trace. Ask the CPU for the first trace insn */
         te->trace_next_insn = true;
+
+        te->ramsink_ramstart = trencoder_read_ramsink_writep(te);
+        te->ramsink_ramlimit = trencoder_read_ramsink_ramlimit(te);
     }
 
     te->trace_running = trTeInstTracing ? true : false;
@@ -274,12 +340,67 @@ static void trencoder_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void trencoder_update_ramsink_writep(TraceEncoder *te,
+                                            hwaddr wp_val,
+                                            bool wrapped)
+{
+    uint32_t wp_low = trencoder_read_reg(te, A_TR_RAM_WP_LOW);
+
+    wp_low = FIELD_DP32(wp_low, TR_RAM_WP_LOW, ADDR,
+                        extract64(wp_val, 2, 30));
+
+    if (wrapped) {
+        wp_low = FIELD_DP32(wp_low, TR_RAM_WP_LOW, WRAP, 1);
+    }
+
+    trencoder_write_reg(te, A_TR_RAM_WP_LOW, wp_low);
+    trencoder_write_reg(te, A_TR_RAM_WP_HIGH, extract64(wp_val, 32, 32));
+}
+
+static void trencoder_send_message_smem(TraceEncoder *trencoder,
+                                        uint8_t *msg, uint8_t msg_size)
+{
+    hwaddr dest = trencoder_read_ramsink_writep(trencoder);
+    bool wrapped = false;
+
+    msg_size = QEMU_ALIGN_UP(msg_size, 4);
+
+    /* clear trRamWrap before writing to SMEM */
+    dest = FIELD_DP64(dest, TR_RAM_WP_LOW, WRAP, 0);
+
+    /*
+     * Fill with null bytes if we can't fit the packet in
+     * ramlimit, set wrap and write the packet in ramstart.
+     */
+    if (dest + msg_size > trencoder->ramsink_ramlimit) {
+        g_autofree uint8_t *null_packet = NULL;
+        uint8_t null_size = trencoder->ramsink_ramlimit - dest;
+
+        null_packet = g_malloc0(null_size);
+        cpu_physical_memory_write(dest, null_packet, null_size);
+
+        dest = trencoder->ramsink_ramstart;
+        wrapped = true;
+    }
+
+    cpu_physical_memory_write(dest, msg, msg_size);
+    dest += msg_size;
+
+    trencoder_update_ramsink_writep(trencoder, dest, wrapped);
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
 
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
 static const Property trencoder_props[] = {
-- 
2.51.1


