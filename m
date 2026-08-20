Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7A8C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkq-00054y-Vs; Wed, 19 Aug 2026 23:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkS-0003yQ-Vx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:27 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkR-0004Ad-KH
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso13265915ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197642; x=1787802442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3+CQdeS4ZDd2cPsyFQmittENkduVaoRgr67sy9mGB6w=;
 b=KuP1qfKVFshRnC7TEBQnIb16+BQN3q+HKr3sk/6MIlAxGI+MWxvVjBkD3hWlssxms5
 Tlm3iAOYS9akRRCuDLOnoz9FHWBtQJzuvEkYHpjYmsqF3ibZRCID31/CKRE3iegeGTC0
 m8JyOVOXTwQbGQBFzuvj8FIhP0usBCQFpdYMoSEham6yQnYdjyMyjF+r6HKzIU1OSMcq
 5TVtr3lmnLheqwL+xe0QTGIiBn4lQECUpf7vlpZ9Wk3auNazUfAEdKocAPbAJJjWukEh
 WfDU71aZsDRKTcWqqU+mnzp9Wq2QwAO6ELQcXz3U0IQU/xwh1l8hCjj5YaI33gxurNg1
 0x+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197642; x=1787802442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3+CQdeS4ZDd2cPsyFQmittENkduVaoRgr67sy9mGB6w=;
 b=NxY/ZXY2G2O0Kd8TVET5+S4bvrTAz8tOR47EiB1ocVRYT+WkCDVqworzjcAqRBoWLu
 g6f656emohEDYuobsbxvaQQcGlznb8pSGdtlBGSmvi4Isijl1AvcJHj0Vhx19O1zkrtz
 Gb6eVaRfWnTePzvrY2/fs8fweu19rEdELeAAMj9kAxCZDIjnnbSJ06tKJuRhaQnVrUTm
 fxhZAF8kapNjcF7tzuoaWZ/3JMBGsQHlJgFCWtsdaBU2kyBHo8Hiru/9Zr7co9ocQFNZ
 fC3bvOP4/OW1K67kJPlbcLgUQXAzQn0LubZ8yDZFU7QxFFtteWgoZRcfHD99YivF1mUA
 ggXA==
X-Gm-Message-State: AFuF++l2rIWZozsLF1yUf7Fc1oWNJBuCK7NAgykFlP8WEbNIstAny372
 YPA7WcNak3rnap8877aO8ZL+hnYAcVj0YPK+P7/tSFsZO734uexsS2leKY2q5Q==
X-Gm-Gg: AR+sD132GPHeX6oNqRaSNg64gy36aqFfqlf3U9iZ0a6ZqfsN8TWhnuNkucIp9sphkT1
 FV7ZuhDX7NGBS9y9z5vTnqqD7uRLnT/rerBLwR0VrUK5UFMM6gQUluSGujCgFFVa9hKz70do/LL
 41FkeYncziWrzYlYbFy4zrjVKZyGU0HclVdj46TkqRBwWRJbUB8TN04aAddiGc8LzwIbxfGDKeG
 i+PRD3ST1y41LKuF/9reebJWG63ns6kTlKOb8GNEglhWgIXwKIh/jAwWP6gkIaV7B+Ol3mGkHnK
 mFW8hCZe87zZrlyYzzKOkW1uM/UkEQ5q3X+hiOzuidUnEw+glqUN6Ma8q4ceI/gDZWenGNhENIy
 zHFeTkATFuX22J7QNixzCLUVY1mTjY98/ISBS1D6ege+irrp/fWg9HQqHGWmaSez9g6/gRzDtJz
 otC3vILFVTTjVhhulzrN9dX16W1TgqLV5JwEVMMkbzKAvrcK93gDx4Yo0IGxbIoHh2f142/zD5D
 NBq1g==
X-Received: by 2002:a17:90b:5645:b0:381:1f51:1ff0 with SMTP id
 98e67ed59e1d1-3958125af4bmr17962109a91.2.1787197641901; 
 Wed, 19 Aug 2026 20:47:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 54/93] disas/riscv: Do not recognize c.{addw, subw} with rv32
Date: Thu, 20 Aug 2026 13:43:51 +1000
Message-ID: <20260820034430.1186695-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

These code points are reserved with RV32.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-19-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 77347b557d..ddc2f73eae 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3060,8 +3060,16 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 1: op = rv_op_c_xor; break;
                 case 2: op = rv_op_c_or; break;
                 case 3: op = rv_op_c_and; break;
-                case 4: op = rv_op_c_subw; break;
-                case 5: op = rv_op_c_addw; break;
+                case 4:
+                    if (isa != rv32) {
+                        op = rv_op_c_subw;
+                    }
+                    break;
+                case 5:
+                    if (isa != rv32) {
+                        op = rv_op_c_addw;
+                    }
+                    break;
                 case 6: op = rv_op_c_mul; break;
                 case 7:
                     switch ((inst >> 2) & 0b111) {
-- 
2.54.0


