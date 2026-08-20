Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC03C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlP-0006k5-AM; Wed, 19 Aug 2026 23:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlN-0006j1-Ng
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:21 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlM-0004OO-95
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:21 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so1939436a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197699; x=1787802499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HaltHBrD2Aw1tYNfzSMF6Xxi4/NnMEbI9K3tbX0694Y=;
 b=IVWLmagdZ2IKOnUld3UTPSnZ7ByQfeTer1ZdSGJKx/k5J7sDJFerWlGAsr4ht9Q+qq
 ND5jrPGYzn+lGfr9rqujttUh32MZtAC+1CM7LH0pY5dCjff9RB3AK1KRrDM2LWusc0uP
 BOVz3225rlDKl4YIwf3G4KW4xKhGoT7Vwk0cRBJYDWgg4PAaVnewrxAZ4gs0PH/OBOnP
 iClCIdXVk3EPcC//X5L0uM8/0elH0j1/JBZ8FdlwP7x9SaY51MF2mUTShiofiMl8Q4g8
 HKC56ptyQXx13Q6miEDIGlJS5X0gEvtV1uSmi8kWKS2AhB3tQ0ubiKyGuWTzLiSiR2Yv
 0ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197699; x=1787802499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HaltHBrD2Aw1tYNfzSMF6Xxi4/NnMEbI9K3tbX0694Y=;
 b=nNSXFaEIBVI6Juh57ncjBiEtZrIQg29onnnjcH7EBCvgsY8ThddAI7Jm9WuOgL6JZY
 dZ0xMHHd1U589buzo5Zh4xQdcgPGvSefstKCYUw6rCeFC1xkvDn/0V9JY37OxbYXe45R
 BAEB2WWda/hDo345wuxT6yGGHxIePsZd9EUGMx7+dZhjMFji+ZgYS38KRS0eRmRRUMJl
 RRjbwdQ4ukTYWaHd0Q+wUu23SHNqEMTdrOKJs638GF18JNxsQz66+rghxV7hL20ORF4d
 gfYBU85PraiwPelXFQGlpky4L7iSlh0rwWOqmlCVMkZOnYBj8DYIyL4abXfaUyV3lUK9
 ATWg==
X-Gm-Message-State: AFuF++mUo9qILAmApJ4PoQ3iGvUFI/i/qrF41wwj4+8y4bY9pHLNX+RE
 HmX8oCrjttl50acY82/tyzyUUzrQtbWaceZdldyR6HY+y19l4QvzeLs9PXeJdw==
X-Gm-Gg: AR+sD11BzB3bqHb8CrECcY9S4wh+D6Wz28oyJICiz8T4gzQwiMag1NWZVUjlsieZXyr
 MkZ8eW+iE/3KTsKK2jGPtVmjeBGi2B4eBNmTZM7rfE78ARStiYQ/vhbPrgOtcMP5r9ElmIwP39y
 WjOEujsBB+6C0Lls2V0gInl5afvS5gfjlWaaegtM+deaDO/ulRHBB/RXMJMJCit2xgn8Mm4DMoV
 xMmoHMB6AXee+ujEryeFW6wx9LL/iazOdnSOEIb9kKHtFvJzZ1/Fd0BTMG/gvLEP71HoSgexQLc
 MKHxVv0eJrGrd5ZovdVOxEUyJe+SDIkVeRJInzB8qDfPJuoldHWMXglWBRVXNWJzJLsadQS/YLO
 BIrshQRkdl5zjTfn3X8s+Orn7VBrw3jBsytva8eS5jnMzsNuZ+Hy6hyg/T9oEGIX1LpErrZWO5z
 ChCvDwdvfJqnt96v3x702tDMPmcJwgYuJT2IlLglAu2jzr9MT6r3Tv1VSmjRdsu1h3GQlUzzNHA
 W1Bjg==
X-Received: by 2002:a17:90b:5102:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-395810caaf4mr5432259a91.14.1787197698856; 
 Wed, 19 Aug 2026 20:48:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 75/93] disas/riscv: Fix isa decoding of rev8
Date: Thu, 20 Aug 2026 13:44:12 +1000
Message-ID: <20260820034430.1186695-76-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

The encoding of rev8 is different for rv32 and rv64.

Cc: qemu-stable@nongnu.org
Fixes: 02c1b569a15 ("disas/riscv: Add Zb[abcs] instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-40-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 5624e7f60a..787340e811 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3292,8 +3292,16 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 0b01100: op = rv_op_rori; break;
                 case 0b01101:
                     switch ((inst >> 20) & 0b1111111) {
-                    case 0b0011000: op = rv_op_rev8; break;
-                    case 0b0111000: op = rv_op_rev8; break;
+                    case 0b0011000:
+                        if (isa == rv32) {
+                            op = rv_op_rev8;
+                        }
+                        break;
+                    case 0b0111000:
+                        if (isa == rv64) {
+                            op = rv_op_rev8;
+                        }
+                        break;
                     case 0b0000111: op = rv_op_brev8; break;
                     }
                     break;
-- 
2.54.0


