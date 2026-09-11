Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32729C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QO-0003Pi-FX; Fri, 11 Sep 2026 18:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QN-0003LJ-1G
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:47 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QL-0002IJ-8T
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:46 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c206dc8b2eso38298b6e.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164524; x=1789769324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jcu6G3w2xeruVpA+D/qeySkR6kANwAaXZsRk1FDBV3E=;
 b=JQkrigkaKq00SJa8dfR3BcBxPbwiAR1NmzQ4gKjEQQUYqUXY5dYvyPs9TY418qNeC/
 xWTCWFtRxhP8ufD+/T0ac9XgPOQc5aqSPZx1GcegWVTczZbQMTvr7mexS2mI3fo/1G3c
 jYkvQ+vOVUZ2LG9ex4uk7hH9aSN4phK1C1RVxD4r7Nku7gwZDydpCWIkxu5y5MWIQIN6
 p1H8iw9Pqk4ajXzVLikCAaBnxipFj/extDlqlo51NXw+uOyvg+Q0+6VXguKf2NaOOPuG
 1DBIbGAVs034w8EANrpwpqzfCO1W1E/UzJttpZ0TLe5V7QT4wLRRchObZWfqvAup5KlD
 AtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164524; x=1789769324;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jcu6G3w2xeruVpA+D/qeySkR6kANwAaXZsRk1FDBV3E=;
 b=oKKUVopRsG7PgYeNm5BJa0XBw5PnPyvLSd2RrZZ+fY/WxwbQoz/1/lDQIsMmQxenHx
 diYObBr8fAJs4SYFK5Tv4ah+y51ZPUus+a+eB3Cqj7kLA9Bvkv88HE8gpe18dYDFHW/l
 XC/iVfF0buWTy0iIiXEUNSjDS/m78Ilrfx70uSp1DQPs+b+m8ni7+AvQDW+vRVzvXC9P
 z0raqz4CUm/7P4tyg9hLjSJ0ebg7tn7ANP0GX88sZX6jV4nuhz5XxQp5W6IZ1X7dkbXM
 nCCuRB83eJBCJWtSeD++nVOt8Bp5M1wQHARHTAi4HXXCkgjUBmzoSMNxVIw+EyZvPDl9
 uZHg==
X-Gm-Message-State: AFuF++kMSQMcabiyei0f8h/yTVZhaJHwEuOcBKvFi+aAkSdiIZzPejYy
 FRT/R2TrE3cWi3SG4z4qJYNv+gnZQ3RwkoebnkkPTbGLACQi8jo8BZUMlF7CL7ua
X-Gm-Gg: AYBFou1+hVGZt30KmK2R24PdpeQZUE6tWWTvnfUqHk6JjK8jmebD0J7gi61DzNQSWpz
 SOs32Y+Gv85JTrN4HCdfdTyLzrNuC4qpYBlT2rEwc18vZqwXXScsP29MiEwsIoqU2XA/BvukAux
 9ofNrecZYdz5UZNA0rGxAzE/km42nugj0O83nBvrcQ2xZN4ZKzg/9O/MLtLLF5cKZqxilYhLT31
 JDdhKtSElMvLQJrrw6sK/GFAx+EFfEdjUoh3nO1VsgIJ/6T9wsbFCk4vGJpXDHjAXDOMKB8WsR3
 Yr8HTQx80F+LDifMjvBLnPOpSxFhXv/utsL50v14tvaKKkb0XsjmnU6zT9yx0fcId3kiwdmHHOT
 3e8QxYti5FWDpgiUq0ra8zwYxm2Xskovs1SwlEML+C5MKYkLujuqLOx8tcSWcN7PokdTCrTmNKD
 rlNHVLgCmUWM0CvWRdDq53NVVr97pRTibV5FzgK47lkAdbUI5emIzXExRDwrxvUJSjtu+V32SfK
 3LJD1IfIjiHF3uswgVN6iaUHYmWQvn/fvH7M2UPIf8rj5lrdMMKAu9sNi8UVVGx
X-Received: by 2002:a05:6820:220a:b0:6b1:2843:1312 with SMTP id
 006d021491bc7-6c249998bd3mr382327eaf.0.1789164523922; 
 Fri, 11 Sep 2026 15:08:43 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:42 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 10/10] Hexagon (target/hexagon) Remove old way of detecting
 register multiwrites
Date: Fri, 11 Sep 2026 16:08:25 -0600
Message-ID: <20260911220825.143115-11-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/hexagon/translate.c        |  6 ----
 target/hexagon/gen_trans_funcs.py | 10 ------
 4 files changed, 74 deletions(-)

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
index b12e91fe6a..89e961331f 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -691,55 +691,6 @@ bool opcode_supported(uint16_t opcode, const HexagonCPUDef *hex_def)
     return true;
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
@@ -759,10 +710,6 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
 
     /* Initialize */
     memset(pkt, 0, sizeof(*pkt));
-    for (i = 0; i < INSTRUCTIONS_MAX; i++) {
-        pkt->insn[i].dest_idx = -1;
-        pkt->insn[i].new_read_idx = -1;
-    }
     /* Try to build packet */
     while (!end_of_packet && (words_read < max_words)) {
         Insn *insn = &pkt->insn[num_insns];
@@ -837,7 +784,6 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
             /* Invalid packet */
             return 0;
         }
-        pkt->pkt_has_write_conflict = pkt_has_write_conflict(pkt);
     }
     decode_fill_newvalue_regno(pkt);
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index c40ca86810..ca23cc6d9e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1247,12 +1247,6 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         clear_pkt_ctx(ctx);
         analyze_packet(ctx);
 
-        /*
-         * Check that the new method is a superset of the old methond
-         * Remove in a later patch
-         */
-        g_assert(!ctx->pkt.pkt_has_write_conflict ||
-                 pkt_has_write_conflict(ctx));
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


