Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E932C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7xV-0005DY-Af; Wed, 12 Aug 2026 08:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wu7xT-0005DJ-Mf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:21:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wu7xS-0001BC-3h
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:21:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so440846f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786537280; x=1787142080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ceUcsRCZcacpbvGqC7cSzSGnWAYXiOOlJVltnWZJ3FQ=;
 b=r2vnTtao6888Wfq8ryRGebjlXyVn0UwVgljcxiVP8YBRwdh3INwpk5a6zhY22YKVVa
 QpEYMdBgb71MGDeMQDlmZCNn69v9QKNeTaepk3DxdDQCeIMT51oQl3t+d1hATgG6W4wS
 ZVviFtrApFxAgx8VFlW82TUkcZkwSqov+kQHh+bpwG6m/9f5AiJw5+S4WMnH39g1mkzg
 dnib/pN68apo8NJm97/UYj9m59Mhp2k/IOWtfB1t1IXy+dcnRVZX0aGc7jmDIMhVRIAz
 XeaNXD7BhdEp5UP6UyVJ5YTCQvhacZ3Yk/lHvx173Wp34lRRSf7huptaYwt/4kcYNUNM
 9AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537280; x=1787142080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ceUcsRCZcacpbvGqC7cSzSGnWAYXiOOlJVltnWZJ3FQ=;
 b=F8QbdKRuAwwzOq31fftAPYH9U4BSsgsKYNnC25BvqNyKIjrJFpno2qaJqXwywoOj3G
 zVpgoTUg6XjWON6Lqsb6Ww9DlikXimlt16GeoXaRDd2RZeARBvvr5HpSigJihc4h27B2
 pHIojAGK3Wyg9Cj1hQxhveePwe27i7n2MhndCS4BRWCiLNBlfu58JB3m1PQxI2UivRGl
 vihBQyWohUGtr1mQRpNHVS2npjG/sILer3ZcdJ6mp4C8hnRRlEHQtjaqkxZXZRk8jDla
 Q8dCp5w25MzbfBDMD+3iXLxK3PKhdLhUYwa6FW/kfz6hAWJwNv8t+Xu28cf/RJoz9ALD
 VLmg==
X-Gm-Message-State: AOJu0YzGU5TEe/NRWSxRoS9zSXo1E4G+W0EdmTYuNhE7CLchrE1p3PO6
 asHLeaT6of2NkuxOfwUGHLbx1zax7SqZZ38TdAaC2vtpiMCfug3JIZKbqXraEP8O+c0=
X-Gm-Gg: AR+sD10Sl8jzFzocbMmLHQAEl/LCi0Y9wmr0MBt56uihVJqsvVVjYxPBSFkDr3X25pn
 W0fwhLb5WQAaoBTWDemDlD3DNxOv7NBNhBJ1cUlzyZO0B/wKRq/8XCreGXOxhV4h9meAtss78Ef
 tl1mmldwHLETgOVWUbesmUQp6JOlOV2tOjAVRQ6EpORvdFXRSUNWeTzJoCDVwiHQSqEhaAcDxPE
 FKzux5W8rmz/ENtA4seLbT+agfQvtpusJGY4Equa8VTFHuGeDeKJ5iTGW/kMGghVbEYWs1x0AFx
 C+mjgFESMyFPqY5ZQ/xibZVwExv71fKlEZEFrtPGPFSygMV/oprMLHAwGIzksqF5s0/7Zxhx08G
 wcZd5N0i5PUT5fOSM0CEpaG+eoeMda2gNLKe2XwwyWVW7/97Uv5UzN5uEqKnfrB5IW+Xxjs8BdD
 gUEpSvsSo6UDVW7BiiyoBLQOxALqd5ZnX9143tsXNVIgZOQuRph7kqZI5j5Wi2VOdZaCGVG2dkT
 U48/dzItcQ7C6B89hOcQcAXuCu1c8vmLqZ4vB7Y1/Dg3hORPm6/ApTJop9CKOg9gNcLPLLpCBcM
 VzeD7PHWXxe9cUE2mBuMeS3+Qal4g+TnItyWt7I/DeU=
X-Received: by 2002:a05:600c:8489:b0:495:6338:1453 with SMTP id
 5b1f17b1804b1-4997c153c38mr58446675e9.16.1786537279892; 
 Wed, 12 Aug 2026 05:21:19 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-c122.tugraz.at.
 [129.27.234.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aabab7asm68945585e9.6.2026.08.12.05.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:21:19 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: Set aliased x87 exponent bits to all 1s for MMX
 register writes
Date: Wed, 12 Aug 2026 14:21:14 +0200
Message-ID: <20260812122114.510447-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wr1-x42f.google.com
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

Per the Intel SDM (Vol 3, 15.2), writing an MMX register also sets bits
64-79 of the aliased x87 register to all 1s. gen_writeback() never
does this for X86_OP_MMX destinations, so those bits keep whatever
the x87 side left there (e.g. 0 after finit/fldz). A later x87
instruction such as fucomi/fucomip can then read a stale finite
value where real hardware guarantees a NaN encoding, changing
comparison results and flags.

Set the high 16 bits to 0xffff when writing back to a MMX register (not
memory).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4105
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/emit.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 473f415766..e2f0b4b1f7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -352,6 +352,10 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
         }
         break;
     case X86_OP_MMX:
+        if (!op->has_ea) {
+            tcg_gen_st16_i32(tcg_constant_i32(0xffff), tcg_env,
+                             MMX_OFFSET(op->n) + offsetof(floatx80, high));
+        }
         break;
     case X86_OP_SSE:
         if (!op->has_ea && (s->prefix & PREFIX_VEX) && op->ot <= MO_128) {
-- 
2.53.0


