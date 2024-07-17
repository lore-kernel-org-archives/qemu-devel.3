Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3791C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6sp-0006VX-5w; Wed, 17 Jul 2024 11:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1sU6ft-0004el-8b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:34:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1sU6fr-0004pg-G5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:34:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so2394815f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1721230473; x=1721835273; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5oDIohgS1ZQJBzOA3AwPKCN3EDp3pXKXOb8IfIED3xI=;
 b=V8Qi0DBhE/nGuNBqLFTQa8I+y4LD35lMV+syScbLgpcF8ALaPndkRF7Rf3yeITkGUa
 RRzgmyIfY2nvCRY2OHPSThJDcMQqJn/9u8xCoOicTHA7aK4ek+VFLewvDNmOspPlbcdG
 DN0HKbgirl28m9ka4zqQHAyAY/3cz/XVVuYhS5pVLhfwQEk2bmOQGeKjtGuGCW47krLJ
 bn2z6+ouODqQ4ZjguZk7BBqzEy6y2HQMhjVfMEn68JyoEKuEW0cdQkN2nWjpqYX1bZgZ
 oum+2kuz8hbkvKCGxU0Qfw7FeaDWAsHMxABDUjveZjFgbceYeoGncUpysHjpAmZvjNUx
 FqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721230473; x=1721835273;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5oDIohgS1ZQJBzOA3AwPKCN3EDp3pXKXOb8IfIED3xI=;
 b=Dvq606F0FpyGOYm6yPgmCtnAvB5r0y6DiRn7gG/is9Y2enwmsqV2PJJZ3nBs826AzT
 okk+snPQuItmKpy0AEqrbLbl2yo4WKGz/Z4x9gRLcqSFsQgwqyADS+C5mj2L+nWTtPTY
 XqqcuGTu9GObBjvcWvi166kNfAdgDwrvCifI0Vm+mNIG2wLI347xNnVHvgueLQ9C3oTj
 eBCaft1UEdHo0sXu3MbRQYkwXtymi9bAPRRS20bjyCvKV0RWvGAgVMKTc6/pmecwos3Z
 p28/pT9An4b/R55/tKPjmaj05bounugJ46ANuWcJB3guJnIr9vwj3iLj7Tzfnu9MybX/
 rJzQ==
X-Gm-Message-State: AOJu0YxklT9ad6f7oPC6WfPCh1lfq2JKvzOiZx06k/UHEAU2LY1bUG/g
 FJXMzLcO63Nx6J9XMsYqpaQfpJtGG35dCBQ+/fbOH3fJ7ruKSFOdS6gKSJZzxPE9PyqX51q+wzU
 llIEeDw==
X-Google-Smtp-Source: AGHT+IEUQ6X29LhVbfvTrgKe7YyeB/eRPNwrRdLiZPVgpXpZtfAFV+yMb2SRMJWJ0AjQ/Y9JhCilzw==
X-Received: by 2002:a5d:4bc4:0:b0:366:efa2:f2f7 with SMTP id
 ffacd0b85a97d-36831600b19mr1598385f8f.1.1721230473321; 
 Wed, 17 Jul 2024 08:34:33 -0700 (PDT)
Received: from paolo-ThinkPad-T490.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c779839bsm2369475e9.7.2024.07.17.08.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:34:32 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC 2/2] target/riscv: rvv: improve performance of RISC-V vector
 loads and stores on large amounts of data.
Date: Wed, 17 Jul 2024 16:30:40 +0100
Message-Id: <20240717153040.11073-3-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240717153040.11073-1-paolo.savini@embecosm.com>
References: <20240717153040.11073-1-paolo.savini@embecosm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jul 2024 11:47:57 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch optimizes the emulation of unit-stride load/store RVV instructions
when the data being loaded/stored per iteration amounts to 64 bytes or more.
The optimization consists of calling __builtin_memcpy on chunks of data of 128
and 256 bytes between the memory address of the simulated vector register and
the destination memory address and vice versa.
This is done only if we have direct access to the RAM of the host machine.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
---
 target/riscv/vector_helper.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4b444c6bc5..7674972784 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -486,7 +486,22 @@ vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
     }
 
     fn = fns[is_load][group_size];
-    fn(vd, byte_offset, host + byte_offset);
+
+    if (byte_offset + 32 < byte_end) {
+      group_size = MO_256;
+      if (is_load)
+        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t *)(host + byte_offset), 32);
+      else
+        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t *)(vd + byte_offset), 32);
+    } else if (byte_offset + 16 < byte_end) {
+      group_size = MO_128;
+      if (is_load)
+        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t *)(host + byte_offset), 16);
+      else
+        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t *)(vd + byte_offset), 16);
+    } else {
+      fn(vd, byte_offset, host + byte_offset);
+    }
 
     return 1 << group_size;
 }
-- 
2.17.1


