Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658EEC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbe-0005rj-Kq; Mon, 24 Aug 2026 01:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbE-0004zs-Hm
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:00 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbB-0002y8-Mo
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:59 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cbedf318752so2243431a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550716; x=1788155516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HaltHBrD2Aw1tYNfzSMF6Xxi4/NnMEbI9K3tbX0694Y=;
 b=WZfwERe8JJQBtpSoxrbI8q0cASEH4U693qZx8NJc/+qqyCOPaAN10S9ybYocfeCvSQ
 7Z9zGphj4gUqztyCJLsFqxUUWQjcJXXIIZsFXIOHLujYKy7t8aC9vJLihACaDG35oRqt
 Y4jU59ayiaeprIR6QGlwOVuJx7TuHjA2r3caqeuul/qOj5p282L2CJXpO8g03JOKm1kz
 pS0wsVygznwtNVDqa+s9VaiFkfbIGNyI+Sdj0xnuGZfMETc1C3mJ1ZcsKSGmiU1us63b
 sVPApgRKRv4EgtKUqWU0JFDu3edLXM5yjqKSqopg73b/ijJ+BH0e1svoNzoSRj0rRvWY
 LZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550716; x=1788155516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HaltHBrD2Aw1tYNfzSMF6Xxi4/NnMEbI9K3tbX0694Y=;
 b=aZflyeQgPb1BD00tSFU2wEMeMtloLaR77Hcr7L7KFXz5gtu1Cm9ZLAUnB36ghR58s7
 ICERwHeAVfvo6m4v1fY1CCqMKpnkq6Pm4FD/1sOldvaTn46R8CjIhU3RdGTFmmSKqfut
 nuabArOJE2ifc1YhHm6DhAEzguzyblLQDJqusFcCD3wGyjVwVxxCMPCvrA3mDE85RPAf
 Yy6tFdUilu7864Z0nsakkI4Xjo9G8/r307aM7kD9p92mF7rx9M4fekfDyFIYcKoRQyyM
 ggXT3YR57vM5zKASt6UBxqfGkEmr2ayMAtZzad8Lfmlf2n2CfZ4fL9pZ5J1WnDwS8kp/
 CzPg==
X-Gm-Message-State: AFuF++mtF6byDmZenmTFr0ux75OjRFpTrGz4e6ALxG3njGDoDD3tv4IM
 ATuE9BR7awb1kc3hBPa5AiwXT3TVQn/rSnDe4sAB4pL5Pod3Me8gxcAb3y1IyQ==
X-Gm-Gg: AR+sD13bmsV3Nq8bDQT4xMlFJdxnfUm/vfnJFQhth0C5KYqUroOk2w4hs2Qr20ik0Od
 IgeIW5407H2ZOmqJ4PDD2zxaePj5ZYK8QeBpJg/6HQvm48bKOc8sndyGHAP8rZ7Zcy4D3ZfH6PF
 3ByYSd/v0R1yAoRrdZBm+DXWzXHjqpvrJnp6W64+leqnfvYgm2aI16b7z/mskRQhnW3WtkFQAP7
 /5OX427Br+Ox129bLK8p9S0EVosRxf38DJS40NFm+0h/XWVQ0wOp0pLznDz1PKZdzb/SwnA5Z0c
 lOIk8pNMqxnBFC4U5o3rFgcgP/BCkRlk8GnOfqb8ukDStjj0bi0YYOgidlNDw92Ot+2iMLN3iT1
 8v+AOX8Z7LTvV2LPj5QRjFJQbZwSBNVl02UJMnKA1lMLfaD32YZFYcMmSZEbVo0J/7iTMDnXY3t
 AU52kH3Mq1S7CS1Afo3J1SmFb77/up9NGGCjcZ0UBz4uL+8WsNmDt+hirPvCu8JhcCBcW+Bcib/
 Wm8Tzc=
X-Received: by 2002:a17:90b:3902:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-395c3377f59mr36457097a91.2.1787550715686; 
 Sun, 23 Aug 2026 22:51:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 72/96] disas/riscv: Fix isa decoding of rev8
Date: Mon, 24 Aug 2026 15:47:42 +1000
Message-ID: <20260824054806.2790041-73-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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


