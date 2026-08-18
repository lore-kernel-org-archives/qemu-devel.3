Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36346C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCc-0007SN-D2; Tue, 18 Aug 2026 13:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCa-0007Ri-Uh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:16 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCZ-0004jZ-7e
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:16 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so15113a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072534; x=1787677334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OgPDe2T/DVSI923G2nyjCGQkDZBVEDARB5/Kz4eMf3E=;
 b=V5cQyz1SQ81FwW22oZE6N7fPRk02ORl2N8mSf9Jdi7UCcSkOWee9JuS0efu38Yaxxr
 xVZvkVtp+GVwYCRsFI0LhBsmukx0iVeUwPiMdKDDD3aIa81aFE6WK4N6sGA9Jf3Bmuk6
 spHQ+djN7b0WakekHXQOzgE95vhlqQMJDgTC4S6Wf6Lv+xehc2Q1zP1X5PwNqaVEUqHI
 0yIcFV9eONA2O1IiukvVDDInpaET6xN7wD/Z0x2u91MQhJrchK9Wr5zBq0ScWs1GmGdi
 5R2NHDqtBEhG+w/G40C6GgwGFC+AECqTesNmPFk5ow8LRphyrTN2YPKY2OoJ3x3PWOlG
 zbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072534; x=1787677334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OgPDe2T/DVSI923G2nyjCGQkDZBVEDARB5/Kz4eMf3E=;
 b=BJHlQ3Dq71h61Glf6lPduCYz+/jlW5UE0KC5L/wUNdasVjGfP7+G7WEa3SSkv3RYDG
 ZyevdUe25Kvi6zBPBq+xilbNcYe+nX0VA+htyspFbX6f5jh/SUtwWYvlcOuTYF7157vC
 iTLduwCb6Qpn+UJC/nYul+U0oXycaCzRu56Hc19sGFB3c7FhR8yLLAgPRliV5XuEk775
 lWw5cZqZfE9GEzGRM14/YM3XCJH4vdQn98laNx9eGHqC+nRMl4ediBtfClPyByXf/55p
 i4+TGcT27JTu3pEpGdVHV0VACNJgj43psAPexUNwprCG4vJwGwpypJqyQHA7+ilX01mS
 Y8Zg==
X-Gm-Message-State: AOJu0YxJsYPRuGtQ+HrMWlPwEt6UiDc+zfqOuBmzAUQuk6SRpZ9mcdHz
 wt7a8PgzpFAp+CKLrtbNhGVcaMl6yPGViiY2bKAmReNlGccntk33cOlngRDx4ZNWnMoeJYMEILq
 5G/5m1O8=
X-Gm-Gg: AR+sD131cjVQQVOqN09QmtEiGYC4Rc6r3Fpd/uEXxqa7vgVIc9eI7cGssiNs3Of3/na
 ifDa52jQiDw44XvFgxbliei+QQRdN8/yMvttxlX46ZmIu8DBao/ZWjU5fA1nPBYI9AXm2Lozbbq
 dgqY1o0kY3EEmxAOqKQ3E2YJHtfYvbi7aQRNTt7Sm6Cv7IXBbE32izpa6aEvsmL1JRP3lTmOugz
 lF14wBA+OA3QF2ir6GvPf1C5Z+w6gVDVnNQrTk4IGvpvdXkNeHXvixlT1GVfgJtib4Fm807NALl
 5m2e17fnmknG8sWXZREh9+Za0CkPWGiBf/90W6hglbYpn67nb01he0aSTCxfoxvqEnPJ7HRKJj3
 R3knxTcghZwf2FZHon2qmcWR/B7jTt5XhyGNmvlkPoHFzhoB33U51l2/7vQqqkNmWg1fRGk3CfO
 lWEQaKxizZE1ykOU+nZpUrJvHFqcGNkQO/a2zhG972e47iOsdtKkd/YmHrWutV+Lk82BxSbUE3g
 v8NLawRg+5Q1XUia/sdoZY47h8xqIYlvtSSm42c/GdEMA==
X-Received: by 2002:a05:6a00:348e:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-851b8785567mr15154869b3a.16.1787072533617; 
 Tue, 18 Aug 2026 10:02:13 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 13/38] target/riscv: Use generic tcg_gen_revbit8
Date: Tue, 18 Aug 2026 10:01:30 -0700
Message-ID: <20260818170155.1907006-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                       |  1 -
 target/riscv/tcg/bitmanip_helper.c          | 15 ---------------
 target/riscv/tcg/insn_trans/trans_rvb.c.inc |  2 +-
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 542b7c264f..4fc2d3a155 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -79,7 +79,6 @@ DEF_HELPER_FLAGS_2(froundnx_d, TCG_CALL_NO_RWG_SE, i64, env, i64)
 /* Bitmanip */
 DEF_HELPER_FLAGS_2(clmul, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_FLAGS_2(clmulr, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_FLAGS_1(brev8, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(unzip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(zip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(xperm4, TCG_CALL_NO_RWG_SE, tl, tl, tl)
diff --git a/target/riscv/tcg/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
index 1156a87dd3..d8d94bca7b 100644
--- a/target/riscv/tcg/bitmanip_helper.c
+++ b/target/riscv/tcg/bitmanip_helper.c
@@ -52,21 +52,6 @@ target_ulong HELPER(clmulr)(target_ulong rs1, target_ulong rs2)
     return result;
 }
 
-static inline target_ulong do_swap(target_ulong x, uint64_t mask, int shift)
-{
-    return ((x & mask) << shift) | ((x & ~mask) >> shift);
-}
-
-target_ulong HELPER(brev8)(target_ulong rs1)
-{
-    target_ulong x = rs1;
-
-    x = do_swap(x, 0x5555555555555555ull, 1);
-    x = do_swap(x, 0x3333333333333333ull, 2);
-    x = do_swap(x, 0x0f0f0f0f0f0f0f0full, 4);
-    return x;
-}
-
 static const uint64_t shuf_masks[] = {
     dup_const(MO_8, 0x44),
     dup_const(MO_8, 0x30),
diff --git a/target/riscv/tcg/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
index e4dcc7c991..3e74be223b 100644
--- a/target/riscv/tcg/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
@@ -522,7 +522,7 @@ static void gen_packw(TCGv ret, TCGv src1, TCGv src2)
 static bool trans_brev8(DisasContext *ctx, arg_brev8 *a)
 {
     REQUIRE_ZBKB(ctx);
-    return gen_unary(ctx, a, EXT_NONE, gen_helper_brev8);
+    return gen_unary(ctx, a, EXT_NONE, tcg_gen_revbit8_tl);
 }
 
 static bool trans_pack(DisasContext *ctx, arg_pack *a)
-- 
2.43.0


