Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D652EC113C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucz1-0006eK-Te; Mon, 23 Feb 2026 15:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyz-0006dB-8V
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:45 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyx-000836-DM
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:45 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c4b494fcso2722450a34.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880202; x=1772485002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVDBnQheb5AqqO1lYjCblA3eDzS8YuZY045hPHYSD2M=;
 b=OZAAdNO3ONMdRx1uxQGftXSIDWUXeqRr/aWKVXG41pXVTDV6bDoNYpCZ4iDy4hObDh
 Ny/BBLrNg/JvwOKcLnY+MJshMgm2mOfQtXyE9l1qFTMt+1F8eRHd3rC9kKeqYl/WI1Bp
 z8oUlemJOyg+dc602uYjcEVfEZAP9PlIX53CJxt+A7KcqrEgxWxBjZG2lVaNXXNz8Mdx
 Y0lmvdaKKLkxKdURXUdMbcs5iaIi6ZWMiGXvBKdlHWIJCsj2cJdPutUVwdwrQcsHIGK6
 3MPecy1xHn/74d/SxbIvwlIDIU3DsIGuPINQcnRqihIQqmrEkcsFIaNKpR/TATVDq0A9
 OiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880202; x=1772485002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tVDBnQheb5AqqO1lYjCblA3eDzS8YuZY045hPHYSD2M=;
 b=F9A7i9JuqnFjvssgayEK8Rr6CEq6qcyr4i1+aaJn9xWpkVcM0DFK0NvJP2VGchRhcr
 dlBQS/LG8rKHYJx09T/UOdwTHuPOfc88xaPWDSILXnLWOQGRRrejN2tKezyvDHp7KdoN
 PhnhzConPxxz8oxXPvQU84qDuetlrfQsAmvTa9C1D67G2f7UK61gj5vK4INrAO6m0qAh
 hh+Ms5nnO9bdNtDbJKbKPZ6nHt5W08tjSUDJ/Nj150QanJg/t9Cl11l/9lWJLi15rDpB
 Spka9D+3U+tWqJ51xGkrg/Myqj7i9LE+qzLYH+SFm55mjmctTXxUgegvKmjcQPs6BZ1J
 EOwg==
X-Gm-Message-State: AOJu0YzZl67/GHg9u9RLfrX3pP+sjAxpcrhWO4ZwyG4TtkiFFhRvN46Q
 G4gvqjmhIG/GDVJ5RSwjVZlEVTeTR9R456p0tIkFJOjzvWBjeBzj/VhnvtuLaQ==
X-Gm-Gg: AZuq6aIpst5kOA2h5sqsZs+bVuSThz2hlnz/bC+t61EnjMWmbbLwxNPoYCTXhPM6Tkm
 NlNjvFanGJYqNOhmfOZDOPT9aLN4bGtS7lOTXhYDi1p4HEsV6fxhMB6to2Qt9jgqwqku5KG0JMO
 YuiUR4hQVrnS2sAIs/m7jKnIp00YYYVpMaHMWcq6IIMEKHFPUujhbykc2tlRtADQ5ZmOVxZyHGd
 yDyz7l0EZG/DbHeyt23zSBMM0WwYJpeOw5SjMb23TB1Ema9gTemIpo5Q01TctvJWrCejNYN8E3/
 UITaZtW2r64JOs48oz2I2x0IS0ttUtWKwEKISLS7apKrnrsz2bAAoA1hG35AkbAqYZb6JJpfjSZ
 b33TeY7PKRfGBdWwRE/EtlrOprQiTXl03VXxm5nxuTm6clHpwjPnT7mnaXDGyRLUk/bhc8LjQ25
 0lVxWRM6AfCDHLcEO2E3JZ/O+QUBUs5t3RS95+Vy+ZPIKWIcBwBnyM5lwLM9AUhg1qI2OxNjLJT
 luben5uhrc+t0xh31g29z9zPw28JdJfNsbTWg==
X-Received: by 2002:a05:6830:81ec:b0:7c7:6063:8e0f with SMTP id
 46e09a7af769-7d52beb8817mr6524201a34.15.1771880201703; 
 Mon, 23 Feb 2026 12:56:41 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:41 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 8/8] Hexagon (target/hexagon) Remove old way of detecting
 register multiwrites
Date: Mon, 23 Feb 2026 13:56:32 -0700
Message-ID: <20260223205632.223714-9-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32b.google.com
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

We now detect register multiwrites in packet analyzis instead of
packet decoding

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/insn.h             |  4 ---
 target/hexagon/decode.c           | 54 -------------------------------
 target/hexagon/translate.c        |  5 ---
 target/hexagon/gen_trans_funcs.py | 10 ------
 4 files changed, 73 deletions(-)

diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index 835b1c954e..5d59430da9 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -41,8 +41,6 @@ struct Instruction {
     uint32_t new_value_producer_slot:4;
     int32_t new_read_idx;
     int32_t dest_idx;
-    bool dest_is_pair;
-    bool dest_is_gpr;
     bool has_pred_dest;
 
     bool part1;              /*
@@ -74,8 +72,6 @@ struct Packet {
     bool pkt_has_hvx;
     Insn *vhist_insn;
 
-    bool pkt_has_write_conflict;
-
     Insn insn[INSTRUCTIONS_MAX];
 };
 
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index dbc9c630e8..1b0ed51323 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -647,55 +647,6 @@ decode_set_slot_number(Packet *pkt)
     return has_valid_slot_assignment(pkt);
 }
 
-/*
- * Check for GPR write conflicts in the packet.
- * A conflict exists when a register is written by more than one instruction
- * and at least one of those writes is unconditional.
- *
- * TODO: handle the more general case of any
- * packet w/multiple-register-write operands.
- */
-static bool pkt_has_write_conflict(Packet *pkt)
-{
-    DECLARE_BITMAP(all_dest_gprs, 32) = { 0 };
-    DECLARE_BITMAP(wreg_mult_gprs, 32) = { 0 };
-    DECLARE_BITMAP(uncond_wreg_gprs, 32) = { 0 };
-    DECLARE_BITMAP(conflict, 32);
-
-    for (int i = 0; i < pkt->num_insns; i++) {
-        Insn *insn = &pkt->insn[i];
-        int dest = insn->dest_idx;
-
-        if (dest < 0 || !insn->dest_is_gpr) {
-            continue;
-        }
-
-        int rnum = insn->regno[dest];
-        bool is_uncond = !GET_ATTRIB(insn->opcode, A_CONDEXEC);
-
-        if (test_bit(rnum, all_dest_gprs)) {
-            set_bit(rnum, wreg_mult_gprs);
-        }
-        set_bit(rnum, all_dest_gprs);
-        if (is_uncond) {
-            set_bit(rnum, uncond_wreg_gprs);
-        }
-
-        if (insn->dest_is_pair) {
-            if (test_bit(rnum + 1, all_dest_gprs)) {
-                set_bit(rnum + 1, wreg_mult_gprs);
-            }
-            set_bit(rnum + 1, all_dest_gprs);
-            if (is_uncond) {
-                set_bit(rnum + 1, uncond_wreg_gprs);
-            }
-        }
-    }
-
-    bitmap_and(conflict, wreg_mult_gprs, uncond_wreg_gprs, 32);
-    return !bitmap_empty(conflict, 32);
-}
-
 /*
  * decode_packet
  * Decodes packet with given words
@@ -715,10 +666,6 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
 
     /* Initialize */
     memset(pkt, 0, sizeof(*pkt));
-    for (i = 0; i < INSTRUCTIONS_MAX; i++) {
-        pkt->insn[i].dest_idx = -1;
-        pkt->insn[i].new_read_idx = -1;
-    }
     /* Try to build packet */
     while (!end_of_packet && (words_read < max_words)) {
         Insn *insn = &pkt->insn[num_insns];
@@ -782,7 +729,6 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
             /* Invalid packet */
             return 0;
         }
-        pkt->pkt_has_write_conflict = pkt_has_write_conflict(pkt);
     }
     decode_fill_newvalue_regno(pkt);
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 32cb2e7fb4..1dc6dc70ed 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -994,11 +994,6 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         clear_pkt_ctx(ctx);
         analyze_packet(ctx);
 
-        /*
-         * Check that the new method is a superset of the old methond
-         * Remove in a later patch
-         */
-        g_assert(!pkt.pkt_has_write_conflict || pkt_has_write_conflict(ctx));
         if (pkt_has_write_conflict(ctx)) {
             gen_exception_decode_fail(ctx, words_read,
                                       HEX_CAUSE_REG_WRITE_CONFLICT);
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 19c1f9fdea..45da1b7b5d 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -91,8 +91,6 @@ def gen_trans_funcs(f):
         new_read_idx = -1
         dest_idx = -1
         dest_idx_reg_id = None
-        dest_is_pair = "false"
-        dest_is_gpr = "false"
         has_pred_dest = "false"
         for regno, (reg_type, reg_id, *_) in enumerate(regs):
             reg = hex_common.get_register(tag, reg_type, reg_id)
@@ -106,12 +104,6 @@ def gen_trans_funcs(f):
                 if dest_idx_reg_id is None or reg_id < dest_idx_reg_id:
                     dest_idx = regno
                     dest_idx_reg_id = reg_id
-                    dest_is_pair = ("true"
-                                    if isinstance(reg, hex_common.Pair)
-                                    else "false")
-                    dest_is_gpr = ("true"
-                                   if reg_type == "R"
-                                   else "false")
             if reg_type == "P" and reg.is_written() and not reg.is_read():
                 has_pred_dest = "true"
 
@@ -137,8 +129,6 @@ def gen_trans_funcs(f):
         f.write(code_fmt(f"""\
             insn->new_read_idx = {new_read_idx};
             insn->dest_idx = {dest_idx};
-            insn->dest_is_pair = {dest_is_pair};
-            insn->dest_is_gpr = {dest_is_gpr};
             insn->has_pred_dest = {has_pred_dest};
         """))
         f.write(textwrap.dedent(f"""\
-- 
2.43.0


