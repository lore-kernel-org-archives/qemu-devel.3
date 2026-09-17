Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB48BC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo9-0003Hx-Gh; Thu, 17 Sep 2026 17:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo3-0002lu-O0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo2-0007mm-7l
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:11 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso1001592a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681089; x=1790285889; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e+/VSc0AoOxec/vdBShKvGD/5w+D/ti2Wf6rzgxH750=;
 b=Ig6AxwhNYl/CACjmK7hmRjTvR6QvgReMthMs8YQSMmksN4qNBuH/w0Idr8Vjhbebvl
 LEx1sWy7+0RBGzPMmbpjTViZ/sLCN7OerHHmSxFLhk3Zpx4U4mdvhUv4JBO4J3Zaahzx
 ttfcM+x1hsgEubvYjed5hhlDbuTdpWaN9xOj1c6gaed/OJ3XWJYWN8xSXy+CZCIpN37W
 CzK5si+txTZjhWaeVbo9hjzD4l6RWK+w9E7PkH57SOr9IH6iHoLEoiMyOcnI5X7/2rEc
 EZbYw0SSO+EEfCCaF+Jtl6W3SI7I6SoSN0UZUVZ/e/GPSnOUMSWKmkA6kqnNf1euQBWN
 R+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681089; x=1790285889;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e+/VSc0AoOxec/vdBShKvGD/5w+D/ti2Wf6rzgxH750=;
 b=bUYeK2IwfBVPfM1p482n2WDO8pwfOlz4r4fsckZcHCxKIl8zg26pTTjXciV9IaQKRy
 b47tbQEUy/+I333myIVfCwt3XqdnQZA7F21t/ng/mTlLQruJnYlGzXfp8tVTzViiUQn0
 o9ksBXVFfI+CbLXumdBwGtkspnBtt4Zw0Lf0sppKeJC04AjvJd4F/5uhPPRCeaB/KFOd
 Zsx6Hwd/SBdsJYnyyeie1LEqhT1J+4RJGVd5ieD1ZB4B2yb08i3lCoOMuXxYVByCN10i
 /41MUHsIQifjd6l5KhlCj73XfkFpXjzXC2Ru1SrPjKIAMKLroZK1HmMxiSIf+HnE/c0n
 oHPA==
X-Gm-Message-State: AFuF++nGn4op0sk1ZefSvW0wKUdlvZhZqlM+uXwJaQppjV7IIXJLhG2n
 206QhcobmjTCH23OhEqbpppQxtnUA4Ai4xAh7eFuIZZijuiEjkgvi6Q3PTy5xfs9Ywh6kmjd3F+
 fz9Pss2I=
X-Gm-Gg: AYBFou0hJdCfH00xHno2jiPSAJ/6oJYhoRpyNu8sSK/mgZiCgugXDZvjXuS01D+ZkBA
 xfytyKgiSZZogggctetvYUr3VYxNUTLo2rnkmPcsMpGfT9wIKscYW9g6yuiodP7ULufrj7kR7Sq
 TjtL0rlObGS2/hrtWTlC1qkmv+sWBPy0/oJTbCJSQgRpW6h2R6BVTgO0LHbsheL9SF0rDjYVgV+
 YYGzo7Z9aCZCAYUjRjueRYjpkP2JFj6RYWimQy4l9dMQXJaKsuFH2hEqCSm4a5WM3vN0xSArhHa
 bpDB8DgMPD9LerfBIv3oVO3NwdP9VdxCr2tbFChznSzl00NW+wmVW9xWZ48xOJF+ZJw9Uly3N6p
 1n0F+XpT0ULZCOFVLQDB4VZA7cpG6OgL3Z17g5r+ahG8S8fokWD1vj255Riu1K3NZi94gijBg4a
 FqW6DfJmZDimGqxvnisRk6wmLvUWUEh5ugTVM0JWJN/ezF2vHKaztUZAqmO6ElAQFtbWdxDq0Ii
 kLg6pN05MBwdFLGAA==
X-Received: by 2002:a05:6a21:1493:b0:3dd:85ba:ad1 with SMTP id
 adf61e73a8af0-3dd85ba2512mr2206268637.36.1789681088936; 
 Thu, 17 Sep 2026 14:38:08 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 14/15] target/s390x/tcg: Simplify LRVR
Date: Thu, 17 Sep 2026 11:37:48 -1000
Message-ID: <20260917213749.36756-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-15-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 target/s390x/tcg/translate.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 854ec37d306..68260ffd9d5 100644
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
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0449fc2cee2..a4374bd41f8 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3715,7 +3715,7 @@ static DisasJumpType op_rosbg(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_rev32(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_bswap32_i64(o->out, o->in2, TCG_BSWAP_IZ | TCG_BSWAP_OZ);
+    tcg_gen_bswap32_i64(o->out, o->in2, 0);
     return DISAS_NEXT;
 }
 
-- 
2.53.0


