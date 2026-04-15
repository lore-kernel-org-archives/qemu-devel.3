Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FDBF433D0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD9oe-0003E2-Ch; Wed, 15 Apr 2026 19:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9oR-0003B4-Qm
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9oQ-0003cw-7X
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so46058355ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776296304; x=1776901104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ItEzHmJ4mreaQM8VeIGNe20D6LHJYRqcrLhEucHCuU=;
 b=Ak/3EG3EIF2q1xvW6kh/xWiXqD2RuRPx6bvXFS2BJ16ZtyN2gLGYy3X9h3CmsH+Y59
 Lqd20dfKGBii311xb6UntAhBKhwNdGsxzsok2u6ltOupvWLdgk2HDrMvKjB7yPqr5EWJ
 8/yvp29Sl8fYkxKXKXrrw75OO2PWKZs7I1mGhrX4L4j79LuFQOAJ/rqEG5EJG6n77o/T
 gxGBL/L0VbY636A3kzl6EASKnnfELsTRvxyxku14g0CqboevgZoglTXM8HNRZhlYF5Lc
 MOjGjt8wABGqF/Urp6in7zcXduOgfm3R9zu4QFp209lewUTkELqQyHeTQH+knBBmsGlO
 OyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776296304; x=1776901104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ItEzHmJ4mreaQM8VeIGNe20D6LHJYRqcrLhEucHCuU=;
 b=BFI9h3q8I+afQtI5FrRqzqTatCT5kKGa4MYrJ8Y8BjN7udDcEZ5UKfho1Pr9A8MW5T
 T+SDqM6ZVjIg6xUqqoSRFXtcKqzyDDnGFptR2Ah1l6SIHACxPCnJPBLPMX5pwggbfuQ2
 ZKgotKt3fuXidf9Ddi5PTlqsa2xWGquPhn8iOCg0I055uinuFYUaTeTwttgmTdcGpfwT
 m/uJKRSREw36E08ePSF1jervHbY70QwHIZlpXJOw3VxnRSgxQPKUmCLE2Y0MFm1sdh1X
 NHWcvpPVrww8tnoIllLrs3nM96XN7ITNqjyr8RRyNfcRNGE3rdomXUhTYILgubTq4WSt
 5bKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+umOEyW+RrfdM/wQUNQMtnNIlqT6vcIbbVC36JOCIXZuAYO8s7ztH+sKKBrsMA4ypizJHFlBHnkD8m@nongnu.org
X-Gm-Message-State: AOJu0YwdZGjzlUh4m9Kv7+plf2sbZfXw7rCrFgRRHCHve2s448yI0tGO
 uQdq8lgov7WX8AFzufzjXkIyknAA05cMMBDM3pHCTcAU8BhYES7/Rz+b
X-Gm-Gg: AeBDieugz44LvDJSIdxR6Bf/tQ0+fkrP1tQ9CD5GhelcuIgbhXH0wEV/AWFyi5ClfeB
 3UnyJ61CX0WKDvcB2uZpVApNEt+LLaReMviqqxUuMnhZpJuYmJHnoulzwPj5jO4FRM/7Gzh8xDY
 e7zsKIW8onFtPuszhox5EnZoTVT3d5iBwrI4kqUkHdmZ2+gFNaab8dY3w++q/4TVEKeZwArNZa2
 +ix64pl4Puxqkc/rziZ30mvm5KTKutK+R9VUMftvBznjWF+e1HAozT/3ox7Rzldgdb2XY2AJDtO
 qROtBqrAFYkBCL7lsCEPvIPGN/Y7LIFM7BKlSwFlwH5oY3SWgnMVZDkiju+4iIHJet4OlJq6oXc
 KSaTyU11bl9vB0cy6/lfJFvqOQHQB+864ZJyt+RgA/lSHhi8ALk3pJLz4ImfLx/EXOLjukpRvao
 AHOBG+hY0HweeAIPx00Rvb8s8VyGzhR7GU0NQOEAcy
X-Received: by 2002:a17:903:2acb:b0:2b2:527d:103 with SMTP id
 d9443c01a7336-2b2d5a5dcc0mr223806155ad.43.1776296304013; 
 Wed, 15 Apr 2026 16:38:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47826ea53sm32341675ad.52.2026.04.15.16.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:38:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 4/4] target/riscv: Use ELEN for Fractional LMUL check
Date: Thu, 16 Apr 2026 09:37:40 +1000
Message-ID: <20260415233740.3027321-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415233740.3027321-1-alistair.francis@wdc.com>
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states that

"""
For a given supported fractional LMUL setting, implementations
must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
"""

We were previously checking VLEN, instead of ELEN, so let's update to
check ELEN instead of VLEN for fractional scaling.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3196
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/vector_helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 83dd26314d..b4fc791eb7 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -47,18 +47,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     target_ulong reserved = s2 &
                             MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
-    uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
     if (vlmul & 4) {
         /*
          * Fractional LMUL, check:
          *
-         * VLEN * LMUL >= SEW
-         * VLEN >> (8 - lmul) >= sew
-         * (vlenb << 3) >> (8 - lmul) >= sew
+         * ELEN * LMUL >= SEW
+         * ELEN >> (8 - vlmul) >= sew
          */
-        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
+        if (vlmul == 4 ||
+            (cpu->cfg.elen >> (8 - vlmul)) < sew) {
             vill = true;
         }
     }
-- 
2.53.0


