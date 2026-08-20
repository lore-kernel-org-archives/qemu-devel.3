Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE3BC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlM-0006hg-HD; Wed, 19 Aug 2026 23:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlK-0006eL-8t
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:18 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlI-0004Nt-SM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:18 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so1773146a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197696; x=1787802496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b2F4kXj+XlomzI5ywD3BSgCQbVAV2xTdDpSTO+oa8Tk=;
 b=Yxe98o5KsRJ4rlZ9BECARN/7weTDktktMsvmXxteLjVCLnhORwj8eXLW3vFu0Zxlzp
 NDUwJI4oEywPTiu8yGxNQsv0dRM5nW+2PA0Bkng8PfpNuWR6j9fdyKrshX2dyepFsCSu
 86xW80/5I8j1PdqRgn67LiYY2ruOuVEn/+tDPX3UWvOBoAqeJIMd2VzeJNbbdBG/m7ax
 GF1l5hffWGm4jbsvDjZNwDmWJOFEqMMdbyO4Q2Aswc8tYTLb9sV2y0lHFDH9984f0EOA
 w7dusQdILKCYdE+iwURW+vYVa9FkfC9D9WMNyGP4cdSJHAgeYqExxlczrH60ds+Pmkpo
 ygRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197696; x=1787802496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b2F4kXj+XlomzI5ywD3BSgCQbVAV2xTdDpSTO+oa8Tk=;
 b=IdQF0shvUuaN1OquUUJw6uE6pnOEyy9W1jYTzCa9nEYRFiwoGp5xyIjvryU20h1V24
 IHs4cFCXIVPFx+v1GoRd9I2+63m5+j3T3ZKwmOzYaJXWd38oWL+mLq5M7Y1s0YBiDxok
 41Kk2KEZmqqIK8kB6FwmpiL/5WiccI/ogh4I3ml+PFsgHk/vyWSFUIsJCv1xuuJm8KTI
 WR2nyU5up3MiybTF5oIHzU6G0FEMIRmGgLm5GHRddpIL6UjEaCKQTF6gO28NdoyB7UOw
 bTKvzYPhHUIK3V+Dku/b1r8i+6cF6r9mvwfQ6rAWsS9Ny89aZNJb0MCbq46DNYjaVCVz
 KNJQ==
X-Gm-Message-State: AFuF++lVbBWzKk1LMMiCtjgHFtHn9AaMIoS1FvyIhNoZyCFS7UK33cdt
 lwlLpGKXGRH9FGFRr8821E4ahIgh0TXLAfFAZGAFM/gYPFbS8/RSluz+CxbjdQ==
X-Gm-Gg: AR+sD12mvCcd0yzrj0I8uM8vrgXkIWCj7d9ZAXewsPyA7v3SiqAoPdVm8ul/kDZ7oUs
 nP7J4T1SLJbcEYHU66SlZrgW5sFWuTGyZjYoiT11qs/V7p27UmbdxBuD4KAX8pGd2noasyXQut8
 iI6Q2LOmozex0XZzmCRWmM9mMGRSu9ccqn+6wDsj8ygoPwRzmQR6Y2oZdDzdUO2hp8gzd/54x5O
 jEqHnZ7P/72vdPjuSzZNkQG1xJDHx6CVtHXrQ+1+VANsuTW6iN4KXhNEncGrgtaLU6MgAKtyHVf
 c+xM8iO4nkisS+aH3Gz0hvg20g30h4JvaoX43BUbupT96y0ze9Wa7tMOvT1jWY0DEy3TFmGuASw
 aOTT7omoZZ0V7RVVVFS4AIA0tFYwP5nWA0C290ntKGcZRcr7XhLIcqlAz9+OQk7pAcNfb3aXLsu
 Mt3I8s2VLlx3xtTJFEqunLpVxtsmL9/Z+C/53gIRZZP5lrMDB76aKAD4g2V3q1tdDeqGlS0Q5Y9
 plmmh6/1zhfp4Dd
X-Received: by 2002:a17:90b:37cb:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-3958046ce9cmr17421043a91.0.1787197695640; 
 Wed, 19 Aug 2026 20:48:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 74/93] disas/riscv: Fix rv32 encoding of zext.h
Date: Thu, 20 Aug 2026 13:44:11 +1000
Message-ID: <20260820034430.1186695-75-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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

For rv64, pack with rs2 = 0 does not encode zext.h.

Cc: qemu-stable@nongnu.org
Fixes: 02c1b569a15 ("disas/riscv: Add Zb[abcs] instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-39-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e650ad7688..5624e7f60a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3506,9 +3506,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 14: op = rv_op_rem; break;
             case 15: op = rv_op_remu; break;
             case 36:
-                switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_zext_h; break;
-                default: op = rv_op_pack; break;
+                if (isa == rv32 && !((inst >> 20) & 0b11111)) {
+                    op = rv_op_zext_h;
+                } else {
+                    op = rv_op_pack;
                 }
                 break;
             case 39: op = rv_op_packh; break;
-- 
2.54.0


