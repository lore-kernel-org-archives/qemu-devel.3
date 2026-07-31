Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C17C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpakX-0001kn-SP; Thu, 30 Jul 2026 20:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakU-0001eW-Jd
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakR-0001LB-87
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:14 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso341519b3a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456308; x=1786061108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rdh3OOkoPnHUJw/UD4a6FqZEuxZNNZ9BwpVlBszcZe8=;
 b=byjCDJXdluHeIdmlst3Ih6oNAF4FQXb2MY/A+9Pdil2B3JksKviEFmH0XbNcf/o5xu
 o7WZKrBzgDVZcdhavDvJSC7xY5hz495ZfwKnt1a1R9V7Lk74UzWHl3IQ6fWjC0g9L/k3
 6aAJClfQoYb7WA1wGdE2PTg40r/y0Z5jCBMaDntd2GxQA/fGjxh59ZmHSZHsk4sVefS+
 1LWIvbva/6dU33lEmXM92Bg4iJOyUVOTTRgSg6soonKWw3r3lwfBzqGmaD9QMAzXAWZE
 Fxc8IwGN9JgwxUx57PYdwLDOkAPNadS+158WBz+cHRLRMHF2RTHrDgEfPM4rRe/hoOat
 IwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456308; x=1786061108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rdh3OOkoPnHUJw/UD4a6FqZEuxZNNZ9BwpVlBszcZe8=;
 b=rKosTiGHbL6I9S3TC7FlCKXtf1GM6OyMAdBPMkp4DZFvdNzm0ugKIPvU2WX3j27ix1
 xW2ymzthQupd0Z6DI24aOeKm5tDos3ZqcV1SvmvbqreEAL0Z6ulPhw2Eod8npK7JwDV0
 NGrrvf5EBRNUV/Awj9eYcYFLlq4CNCmdTJyIlGGFNwMkjtCp4EgtPCxUnOcdCZn4Vhqj
 OCRc/G6YJFux0BumU59m0depmRwyAcY/3/pFv+5mZuJITk6vsLHH/5KJFftVdmK1qdxb
 7DY1NS7LapjGTs6jG/2iL/Eq4PXj9DjsSym5yxRFLP2BurdRXVM9/Dry6y1dXT9u3ioT
 iLyw==
X-Gm-Message-State: AOJu0Ywqwv34fMcwgiX4g2Rk8WusXHroKbhBXEW9E/5WcXNC1ehhL2eD
 pFrEUQFvCEO6U/ysR/BJn9hFXB/Qw2F8QlpzEADblxrDtpIoWPgFmmZy62r9b0c1wexwv0Tzt/y
 T7tPW
X-Gm-Gg: AR+sD12eUI7WkXA5n7bFm4aHn+9EH6hbVjTjDjd3vZa25Ifv7a0/xFkt7Pn0wMPigsd
 FnzQkISbykq7B3ywiCmnPbYhbJ4/fWKFaKaIfsW+Gyc0IeKBFuuZKp64W9HbMDR9couLlsx1zI1
 z19s00MHbl+U9kUTUhnqUi2HVyZ2z3EbbpaEIyxDdCHNzKe5s14d4S603/IhSUXe/YcC2H+ZiPo
 t99fCOdljB+2IntdlLR0LzZeEY4W0+0yX8+Vfq9EfUUNVskdETni4gb1d0oNi8TL1SAIIz4HCJX
 PZ8LQDTYPRTOTngiGV5zr6AtUL0gY41vy1v/0JmJdoGHU2FT9u4EG4M4sm2IV3VrHFV6zbuJrin
 ZWIO7C4pu2s6lbnJ4jklDjzUrZqBMPubtUYJ91O2kH8U3/fDtIT7E7E/gMbhtFRm22fTXz41BGu
 b1G6/mW38U9ITp/Ex3mC99LLmcg1ks5JMMx6Qfhji2PQGC+Rt54KD/9RUzpyfamsotP6aYgrYMX
 xH3iEJ5KO7liTPIgBP2
X-Received: by 2002:a05:6a20:7f9a:b0:3c3:8fc3:5373 with SMTP id
 adf61e73a8af0-3c90085c8b8mr3827736637.35.1785456308136; 
 Thu, 30 Jul 2026 17:05:08 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 04/11] target/loongarch: Use generic tcg_gen_revbit*
Date: Thu, 30 Jul 2026 17:04:56 -0700
Message-ID: <20260731000503.170446-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/helper.h                   |  2 --
 target/loongarch/tcg/op_helper.c                | 10 ----------
 target/loongarch/tcg/insn_trans/trans_bit.c.inc |  9 +++++++--
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 8a6c62f116..4b0fc81db6 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -5,8 +5,6 @@
 
 DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
-DEF_HELPER_FLAGS_1(bitrev_w, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(bitrev_d, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 
 DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index e63ac66daa..37afa8e92d 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -22,16 +22,6 @@ void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
     do_raise_exception(env, exception, GETPC());
 }
 
-target_ulong helper_bitrev_w(target_ulong rj)
-{
-    return (int32_t)revbit32(rj);
-}
-
-target_ulong helper_bitrev_d(target_ulong rj)
-{
-    return revbit64(rj);
-}
-
 target_ulong helper_bitswap(target_ulong v)
 {
     v = ((v >> 1) & (target_ulong)0x5555555555555555ULL) |
diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
index ee5fa003ce..3d24e320ce 100644
--- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
@@ -178,6 +178,11 @@ static void gen_masknez(TCGv dest, TCGv src1, TCGv src2)
     tcg_gen_movcond_tl(TCG_COND_NE, dest, src2, zero, zero, src1);
 }
 
+static void gen_bitrev_w(TCGv dest, TCGv src)
+{
+    tcg_gen_revbit32_tl(dest, src, TCG_BSWAP_OS);
+}
+
 TRANS(ext_w_h, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext16s_tl)
 TRANS(ext_w_b, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext8s_tl)
 TRANS(clo_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
@@ -196,8 +201,8 @@ TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
 TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
 TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
 TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
-TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
+TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_w)
+TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_revbit64_i64)
 TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
 TRANS(masknez, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
 TRANS(bytepick_w, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
-- 
2.43.0


