Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20134C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9klv-0008Um-LX; Thu, 24 Sep 2026 10:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klZ-0008Kw-Mc
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:46 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klW-0005ES-55
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:41 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-868cfc5c244so765183b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261376; x=1790866176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DvW4sTNElEx9UXHErcO6hMyThrj/L63pKktyde7yDpQ=;
 b=MG5nXB17jTQlBkNnpy9px+Qs6XT+U3nJRVIvRFyUW5GHF3+iCImd/pvmFs03I0oOFh
 dvu+GZgyl2TW7FIeXQI5PRCadX3vkE3M1pxTGF1/hpN9su7tPVqfM58L/o9nNIWJfx/4
 pNIet+NuoCpV1MVSEEfpKLQFnZW3eepLVWY30p51kLUwFCeIHZ3mD0iPA3DOu7nSn92X
 G8bUHAoqQpwrxePjI8DiqPSCQ40yuGBYRYfsomM33oKrE70Z3rS0f/KZOofMX50K1y+a
 P0GNE0gJEWBlg55UVAvpm2pFDGx4fXMZTF4SKQz5ErcFjxrTUXO8eoxqBIz/xu7BJSYa
 lGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261376; x=1790866176;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DvW4sTNElEx9UXHErcO6hMyThrj/L63pKktyde7yDpQ=;
 b=RxdFiYNBJAJzry42nLF1z1DCk5xF0KkNFW8ZOg4ShkdjQpUfrUU8XzV/1T24Ml9mwq
 CINqCaaeAXnmogrsld6Uw5t+tR7kDrCPwSrzbpNsZz5ZT0Jp4NqgJ8KqjeK6fuNck7mc
 JaQC1DCcXxLCZjQCkYTzih9KryMa7yEGdJkp4Ou75qL4e6h+ufpOc+xAllpgdRSd2VK6
 3Zn+p5HUoTXc9E+bw1xZ4WT2ZMblYY/h24PnegTqnvtuqlNMTBJEdzjhIanGOwOMGV06
 3A7hMUlVEb1e2qKbNrPd/tA2VaH+l/onfy5XcBAHiHyNyDFHSbWhiabFZaegVpKDZ1v4
 E96w==
X-Gm-Message-State: AFuF++kcd1bsc+j4fh5zQL/2w6T3bMnektS9LbASgBXNx+wKhHochm4d
 kBtXBp9s5oiPJ/p6kQ1+5irErJfB+utDgLd+hqA3b/L9ukaHn/xjgGB0o8ENcstNrd5aNmHf1g2
 PTOxI
X-Gm-Gg: AYBFou2DjMX65N80AqiEQd+B066ktnzsF/wkSHutywf4Fy0d87GuaRAmmZqPpWqZNxq
 /O9rVbmD0PRKBKWOFJiRo2Kz2loWfVndULBGf5wdw+J+amj71nf1gEAqDAKX0C79IHoUUKJxgH7
 qNTn5Be42b9XG0tFcT6L5Wt5LIrGNhpexu4Ul+aLhtMjLRqVfJQI0y8YJ/zrj/zdH5/32b154Wq
 gucOUe9GzPa7KnZTQTtT12j5hloQEf2sheJEdcrJM3TM3E/i87ZvMrLjLqo50x9zgYBlIwSiulG
 xcqLXwjh09A2/9VhYhzrBbEEuFkMFoKwwmNiyCLiv7fDDTadIc9VCojfmDkzA8d7P+byHwxRht8
 50ObRg9uBr2hRcaPfvIrv+/m1DcNBUNEk7RRuP/0h6wrRxb9McjDqb7QA56JYh/WbFCeP6VEmAZ
 3eC8aZCkzLYLwGjLkUV1+fpYHjdlXEgPWPNZ5El6JTOWY2F6jzypk/VJ9BiJBSgEnQHTpDPxA0l
 dTcPNhIUONsuZootyNN0tWriLM2trdFLF4eptKZ
X-Received: by 2002:a05:6a00:35c9:b0:874:705d:f639 with SMTP id
 d2e1a72fcca58-87e99e41f56mr2246001b3a.27.1790261375751; 
 Thu, 24 Sep 2026 07:49:35 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 3/8] target/mips/tcg: Drop zero optimization in gen_mxu_s32mul
Date: Thu, 24 Sep 2026 07:49:26 -0700
Message-ID: <20260924144931.161335-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
References: <20260924144931.161335-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In the unlikely event of the architecturally valid case
of using the zero register as a multiply input, this will
be folded away during optimize.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 9559b8aada3..f30883f976f 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -964,18 +964,13 @@ static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
     rs  = extract32(ctx->opcode, 16, 5);
     rt  = extract32(ctx->opcode, 21, 5);
 
-    if (unlikely(rs == 0 || rt == 0)) {
-        tcg_gen_movi_i32(t0, 0);
-        tcg_gen_movi_i32(t1, 0);
-    } else {
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
 
-        if (mulu) {
-            tcg_gen_mulu2_i32(t0, t1, t0, t1);
-        } else {
-            tcg_gen_muls2_i32(t0, t1, t0, t1);
-        }
+    if (mulu) {
+        tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    } else {
+        tcg_gen_muls2_i32(t0, t1, t0, t1);
     }
     tcg_gen_mov_i32(cpu_HI[0], t1);
     tcg_gen_mov_i32(cpu_LO[0], t0);
-- 
2.53.0


