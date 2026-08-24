Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5340C5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbd-0005jO-4g; Mon, 24 Aug 2026 01:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNb8-0004pp-49
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNb5-0002v6-M3
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2caea3f742bso48175995ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550709; x=1788155509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yu4ELq3Ofd3UkpQaCSSE8x2tH1NrMj+tlGRK673tC1k=;
 b=hcT9TyuXe2VvgDkSWi7t+pJUJY8EhZcrV+yRC77LOGm6qIa6Y/dnL2UOh9zMT8z0Sd
 ZAgsldOg/hPZaZ2/dU4x3JmFEm0fGirB3zesPCMjB+ScYW9Qbu3sFtVyQ7quThbi45iB
 qHPayj2BJm+Bt0BhP0mCDgfEKizVmCr9tvecF3mUM1XKyzjmSfKSlri+vKapIr4FjpGs
 Z2K2py/hW+yRKDMIQJghRZ3gyzDXcQVZSv/mHaIQb7LL54WqbXEyWBlD67kJ2GhRZSAv
 99SehCFyK9toL+dT9dtXF79/nrc6yrx/u11QDymG8KaOnj3GInm2G1DEPqih8dQzyO3s
 pAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550709; x=1788155509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yu4ELq3Ofd3UkpQaCSSE8x2tH1NrMj+tlGRK673tC1k=;
 b=rMA6HYVGhVZchxE+hlhWhMOCfA2bYw4hTPoBHu+PLuhE4WHT57gmdI63Z4TPdcTFfM
 lXTUttHItXhHboVCmvaxc8qYHuJeD6G3MYJ8Zk8k75VxbDivTFa0zdbvzQxCx+dUZBzp
 TGoa8CjsQ9RHXT8OpQ0i73HyrGRRbZs+6tivXPN6idEc0HU1LyNHV3PUFX9Q1+oYnNG5
 ICqnuz/Cc459vgiZTpTnoWkzpHuEEUn1i7zbGjRKh+tTROiqjiMx4GSiORB/h8IbjjM8
 xAHo5+fDdzU6I3MrKQxOJDaZRV+hKfeDsZiIfFiav8asu79d2YT/UtW7e5+51LhxQT16
 Bcgw==
X-Gm-Message-State: AFuF++kSvmWnxg3kLqAJmYp3E9BdiPNeG9yyAPuDP9cR2VkEUxoKT78R
 0/TyqrDwLFeotYFx+kGLi1JTs95YAFogVI2+vOXd5WM0YMwpveY1zy3tM8OhAg==
X-Gm-Gg: AR+sD126aShVLFGqY/rU/LNLhPdfuKGr1as2pdAdwUyA61+3FKEzu5w/2JHygrC2Rgj
 LIjytvHbtlx8YrlmB75RTQoTVhMXPONLTwoT0jnc3WSMQgMLUvUG1qxQwHDKqPReDbyW5eMQKFA
 aCoqHji7hUxROkkvrSHy6zwoB4uCBwS2o9U9OzqUip98W/cqA5ugi5kro7poj1tRMqr1P2VQvx0
 xH9eck640VRlFSGmK5MFGCBBNs0moALJv4DiDnBv8dhJDL5vNuS0RYpmXqPGUe1taZa1yhdtXV3
 +O03Y3ktBPzIlLYrwhiUhg5+DyNv8Q4QE2scI9hrpMOWBo3CM3O95EGzx29ieTbyxPzSIfQT425
 xeUD4MsnpfST3+PYjvy3gT9/9fhOfM6FihL9V5rYMFvdXM3aQTIJPx8QE8LWH2Minnkqu2BNLp1
 fqgom4yZFTFVe2rXO2QMa/XAdUUshImg5URzWoKN/Q7zh1W0Hp/4v6Ey3lI+47TNhmgEIzfb2gH
 5cKmEkb8fI=
X-Received: by 2002:a17:90b:3d8a:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-395c33daf0fmr45452635a91.3.1787550709505; 
 Sun, 23 Aug 2026 22:51:49 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 70/96] disas/riscv: Reject all of OP-32 and OP-IMM-32 for
 RV32
Date: Mon, 24 Aug 2026 15:47:40 +1000
Message-ID: <20260824054806.2790041-71-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

These entire base opcodes are RV64.  Reject them all at once
rather than one at a time.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-38-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 75c2fa11e6..e650ad7688 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3311,6 +3311,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 6:
+            /* OP-IMM-32 */
+            if (isa == rv32) {
+                break;
+            }
             switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_addiw; break;
             case 1:
@@ -3557,6 +3561,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 13: op = rv_op_lui; break;
         case 14:
+            /* OP-32 */
+            if (isa == rv32) {
+                break;
+            }
             switch (((inst >> 22) & 0b1111111000) |
                     ((inst >> 12) & 0b0000000111)) {
             case 0: op = rv_op_addw; break;
-- 
2.54.0


