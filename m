Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897EBFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXd-0000Hm-3Y; Tue, 07 Apr 2026 14:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wABUK-0003xC-5U
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:24 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w9yDY-0007J1-Mc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 00:39:14 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so1347949a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 21:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775536750; x=1776141550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fXiHcneXVMhhF9C2Wl25YfbV2lULaA+TaRNA3rGmZ8=;
 b=i/acd2kn55cKfTVMDLAyi70MMI7eaoVjvL/lUUX7h9rN0fM7Ky9RvzfRJH9RhCz2ii
 wbTqOy0CzePRoZqMFeEzfku3jd2o41o3d2AOyDHIY5Xcg1maOb/tlPso3exWWNnSa9HT
 9GurUKGzq/G25O/Pu+S7RkztyYyKTwE7lCgfD8UOC/SaepZTFKPjGig48+aGqjHDX2G3
 E1cEOyKQEa8t1juCAaDu9bBF3w9+F6TqC8V39lkqiI0beZU/KEOcALHA3FBkTZjarK+g
 4FxpSwAgcL3JvaugUX82iAjXb0qjWBfhex6iS/UEZE4j8y6pzYwxKcQPraVCqk7zI6HY
 Ksjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775536750; x=1776141550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2fXiHcneXVMhhF9C2Wl25YfbV2lULaA+TaRNA3rGmZ8=;
 b=Tk6bsz+2jVq6Y6woClhNefEgWhWIvTxRJN13+r2g0TC5UgNqoCbqujd4JmnJTnLha5
 /2/aqhBd4jxpmGT7D8tuK1DyfIlS+LNv9nguG9B1mO7rWmQfyDhd/WJQ9hd9ghI3RFVy
 xh7vqJFWkajvpg8fendIeJ2rZ5rmP0Er/k9FLbmbVm09AIg3Io1+8Z7Z8rTCjc2RgOTQ
 q2ASiA5i0TdEaSypLJcGMjjhtpw03Ybbm0wMa0afFxpducqGmpPzgy0Uuo3Y70bmUcxU
 jdMda0ZroE8qQMKhVSOp05YSKZQTsM+py/0J0Fyw5PJd3wxuTasuZ1uOVFQhzYCBNY76
 IRow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZbTQoYftn4vj3wU406WQhosWZvyEgVYubEzDsLv5Eo4Q5QDo2xClwNEYIUCdBZ4RUVS8q1ij0Jan1@nongnu.org
X-Gm-Message-State: AOJu0Yxh3YfUYgQqLvivi4CnEhqPdXmIR1XIddUSKCZQIJU3kCuI8Ib7
 r4GYkSaSE1R1g00xD+DN/T8RkbfKFwe1ct3RiuRbZZpGi4ca0M6WrZNH
X-Gm-Gg: AeBDievGfzJMYjcrblJMYJU4KCDlB3Ujk1pE2zQ2DqC6s7WYErrAIL0Qhz4+QFc46MB
 Di0cjFSJy2kUGh8hYUp2pWC+LU4YCNHs6KVQ57UU3rwwtaIIVdN4KNmE+Oh1sge58RYT3FbVNeA
 yYyrjI8JfZEfs6pfVXHvYnaxAbRnDi1ESy/vgSrItJfujbREK5n0Kod2QPVIfDhta0odimRDRcL
 fkLLjRAhZodwFCR1mdgUtqfulFoQq495xxhKZMMGg8xmX9CxAiZUTqA2sr5CuXFIr6CkzNrItex
 IFxgBF2+SxOcHYVWsF6YozM+bloC2n58/NQz5kquGgl+bwufgzAWGn3nByCGQ2POFtkphMMCbES
 DR8xfhGKRA2tKW81/PaerDDw5bVv9HL1x0+QPQqH5a866nX8HHMIUggg2NdtAm4hTf/H4xrhhZ3
 qso8t6UBAUVWGVdZh1g3cnwu91vWtpkc5sRGADERto
X-Received: by 2002:a05:6a20:3d8b:b0:39b:949d:6078 with SMTP id
 adf61e73a8af0-39f2ed105f1mr16825857637.6.1775536750544; 
 Mon, 06 Apr 2026 21:39:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6491fedsm15809963a12.8.2026.04.06.21.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 21:39:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 5/5] target/riscv: Use ELEN for Fractional LMUL check
Date: Tue,  7 Apr 2026 14:36:14 +1000
Message-ID: <20260407043614.372871-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407043614.372871-1-alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3196
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


