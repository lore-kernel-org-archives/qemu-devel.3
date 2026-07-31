Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389D1C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQj-00005p-6m; Fri, 31 Jul 2026 14:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPX-0007Sf-NI
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:48 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPW-0002FL-5Y
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc891373e0so14333935ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524202; x=1786129002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zt/qHmJMGDq4h+mK6cca3/a9QuK2s82OW00Vxg/CvcU=;
 b=cOfQ9N3WPnvlu/YO0BD3XoMatCGm2w5epUCHNXiBszEGW1nUfR8dnj3omkno4K7AwV
 jiuHbWB671BzmqQZnxVZ9H5ZjaqCZo9LfQjoVO4MwBlKOqcO8twenAneu5ijosJDeCE4
 lRmehE+wx6UjJZFOAqRwx+ApbwsLW3x8UCBjN2qPngktSDammRTETa8TmiSP+I+BfP7o
 ejcA7V/gN73+N+w1uWxTmYDMDP0h4I83bRuM4aQs/ufSquOtueY4PkriFGinL11oPalw
 dwSo33uM+eySqeP2Em7HPbTMl9gSY5BBxYUpxaSJIM6PwxyfrnonlRG4wCsMPDCsnOY/
 GkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524202; x=1786129002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zt/qHmJMGDq4h+mK6cca3/a9QuK2s82OW00Vxg/CvcU=;
 b=fmGh+aMd7BrZ6v6Bqpdx12WnXqoSgyPRuqtA89wwIPDn0bn0btRieSWVJKE9b3pTfI
 usTIA0biyZql5i2dXZfh7sexIhIjY5e1Juf+Gq3MCbjcBZsEfS2Ep2NM3ZuqedpxEsBw
 Av71EHEmp4FxFH8hR9LqFJzhBYF185rE1DkbJAhfHYCJ0tmw+S9sR+VXVbnxEA4Y14tN
 PqGMZOWEoTVWrTL7ipJTmeNl9zHWE637LEWLXKY7a3L9Vmuwb4UeO94HoJK6ef815QwR
 3YbHPutgnlc6Um/OZrybgIahwSsktti1vu0MeCFz2Fgldtvwa24owsmwxUj08fNQ/fO/
 OS1g==
X-Gm-Message-State: AOJu0YxhC4ajRJlr486+TCqJDYgQodhGnvimK6y39dYi/YtsNLBjRZmj
 xp+0d/3DLSqz3lHdHjrnLaJ1B1fmQtld0aJKQ6Zb8x2hq2t59FcMjBWTW23RErWZXZK3v3/gCXY
 FyjOu
X-Gm-Gg: AR+sD13LEA1bzSjkQriBoazB3Rz3PHb1HJFpGqUqMN5Jpl8XXiO7SquzpniGNsiMIT+
 GJb/wBHnpPhqMYBWiWjUFZJsxRt/NNbEZ044jJpLbKpEZigy0PrJQMP7qZXi7/XmgDbJS0lTSv5
 z4hZOhuVDPi5lMhVwnfG+8kwVSSaetzVxausGGalQXitGNiWYbdOjYe7GI1gcAt594wQU8AqQYQ
 SD3Priu8BghxsFQ6Igm/8HBbNrJ/uXnPRLG3A5gkduUHwTe2pfXnfp9JHICo3uySouO/fASfNzb
 Ga/J85u8OUBqUlRxfwqQZvkPxFdPNeFZ3CQsgQD3ymQWFMM8tLhXQh/Junu1LDSxqRwHN9XlHbV
 Rp+f55858Ql1Wqq34dkKwFn/jerCe/ooWEEGz26HXUzvqst7mAwXp2/GBY8PZhv5U3U/caev6SL
 gFowtQgR/GUJvS9xO7xscthTfWegZzWhnoUjiIzPgquco5CL1XLd+jIYBLUqSzlySx4UY9UJBIR
 KFoEok637usw8XT44W2/ElkYX+vVvM=
X-Received: by 2002:a17:902:f78e:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2d05241f274mr9270045ad.38.1785524202131; 
 Fri, 31 Jul 2026 11:56:42 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 14/14] target/s390x: Simplify LRVR
Date: Fri, 31 Jul 2026 11:56:27 -0700
Message-ID: <20260731185628.23161-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

If we drop TCG_BSWAP_IZ, we don't need to zero-extend r1 on input.
Since the output gets passed to deposit in wout_r1_32, the high
bits of the bswap output need not have any specific value, so we
can drop TCG_BSWAP_OZ.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c     | 2 +-
 target/s390x/tcg/insn-data.h.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 09c5541615..07ec01232d 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3715,7 +3715,7 @@ static DisasJumpType op_rosbg(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_rev32(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_bswap32_i64(o->out, o->in2, TCG_BSWAP_IZ | TCG_BSWAP_OZ);
+    tcg_gen_bswap32_i64(o->out, o->in2, 0);
     return DISAS_NEXT;
 }
 
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 774a3cec36..0dbd433ce5 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -588,7 +588,7 @@
     F(0xb340, LPXBR,   RRE,   Z,   x2h, x2l, new_P, x1_P, absf128, f128, IF_BFP)
     F(0xb370, LPDFR,   RRE,   FPSSH, 0, f2, new, f1, absf64, 0, IF_AFP1 | IF_AFP2)
 /* LOAD REVERSED */
-    C(0xb91f, LRVR,    RRE,   Z,   0, r2_32u, new, r1_32, rev32, 0)
+    C(0xb91f, LRVR,    RRE,   Z,   0, r2_o, new, r1_32, rev32, 0)
     C(0xb90f, LRVGR,   RRE,   Z,   0, r2_o, r1, 0, rev64, 0)
     D(0xe31f, LRVH,    RXY_a, Z,   0, a2, new, r1_16, ld, 0, MO_LEUW)
     D(0xe31e, LRV,     RXY_a, Z,   0, a2, new, r1_32, ld, 0, MO_LEUL)
-- 
2.43.0


