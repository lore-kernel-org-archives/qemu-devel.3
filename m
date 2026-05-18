Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822F7CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOs5F-0001ub-Qu; Mon, 18 May 2026 03:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOs4h-0001la-Pn
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:07:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOs4g-0007y2-3O
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:07:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso1770632b3a.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779088055; x=1779692855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwZJiq/40a2rmbm16P+G80tHOZ9sLwi7fYVzoyHFvGo=;
 b=ZJDs7YPBCDoxHOF+2gquJ3qVgIKfETOnIUpDogPunXVrB0743me9E9ZUPONIydHX5h
 Tkvj3mp6qLCFispWBb2rffvvLdWiKmkpKIVNrUA+zhi3WEVioRfGzYJ5WQ0aNKqB9qNr
 J4yi7U2KoCPMkHTC2GsUcM6Qr656wP9xz3bZlY3Gm4XroGsczeEKVyMqRsuVTbbZR9a2
 AvSSQas5zEDgSs8p+/QI/NW+jVZhBx+uniAKMWWgfXcCcgi63rDdJVUlJx8l9NOFgIab
 QXZLCiYx9V9JKvxj0YFAG7lBgLOQw/vZoT4MmpBAJaFSChmWu0ju2+RkRLjYQgmJdFMS
 iDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779088055; x=1779692855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IwZJiq/40a2rmbm16P+G80tHOZ9sLwi7fYVzoyHFvGo=;
 b=fukkFPvyIpMv3bP7EPplcqpatdGIrYNByG44tZuQtqktdtRH14lqG27gv/we213K+K
 6h9DVzvWnyk7FjCwh7pF2DeB73VncAL4ocyfq2cCpvutJSFARbuQKHsAgZrsWuQG0pA8
 QkOLeY1Q0qFgIX8GKl6J/tWWa1t9AvkYw7zuifvtt3g7t8llj8LXa5MF/8Qi8OGsbclS
 LetOyruPwL08j5IkIpK8ArWuANrbeX0HZk0HnD4tIJp3NExb/XnLsLNCsRQQmebXnpTB
 0e2xpmbVF7Niynk8Uyi7+sv9hk1ls8IxSnV9rR1WWwYneJmrIN9CzFar9AxN8tzYIEhn
 0s6w==
X-Gm-Message-State: AOJu0Yxam4WqwieyYQD2qy9RTxJVy+88mzRd3DJJ8e2b2IU8XE3I2Mbw
 G8wRoAW+EHTZSMvrrz4UzIEC8iP/XOjKKNFDxvqrEq1383X1FdlCNdIGnjGyWt9yhR24bBjskDx
 IvQ1Vi+J4DaY/JOOJ6K54uM3zQXA/4/bIJG2GPyBdlO7SBXlHzPGFYEMXFQC5RAfksOka8rlUsx
 GyUmQbRCmVqdoPEjQxF/XJtupk1SQDSPvH9j8C7yH385A=
X-Gm-Gg: Acq92OHggKy8+nKyy2c3yL8CXNUlkd5DmgF5Trxgu6gT045bo8d9RT+xXG2E6VwuKJ8
 boSZlzSOjLzAijZMnVK1ov7OHfAdhXH6yvIDJQA6dL+aS65AVNkh/pzs2TJitzegcf2Abp5DkXW
 aqxqNEKRJcSSp1oPs/5RmjssGLLgGOQ0ODqxxnEmAGqWaKqvZcRCp+sODLpG0nA/xpk5SUWcpVb
 CYpQUehg3YCMgDB2/LIyVQugWAOZkA3U3Y0gkEVqGB4Ri/Y/YCTbrO92v8ZIsAQ4f2DWlkMHekn
 QRDqxdS3Lw8YRzi552NU7xuGNxg7M/p2QGV0mjh6U+aIyoffJ4R65yHwavo+9i95Co6JQe/c6+9
 Wn72eY/cU8W76siW8C1ms4CmtIGxEA9Zd7CSz5L/DfTi/eefXKPzJJEdfVe4eKp1C1t2LWH+oDO
 Lh72yDKX7sEUS/9vE6ZqSxmtlIir72+AK9c7JuH69CDwa0IotAou3jtb1IKYjD0A==
X-Received: by 2002:a05:6a21:9212:b0:3b2:924a:36d9 with SMTP id
 adf61e73a8af0-3b2924a8674mr2582341637.11.1779088054622; 
 Mon, 18 May 2026 00:07:34 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5ceb3sm13411671b3a.34.2026.05.18.00.07.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 00:07:34 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 1/2] target/riscv: Align pmp size to pmp-granularity
Date: Mon, 18 May 2026 15:07:24 +0800
Message-ID: <20260518070725.9816-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518070725.9816-1-jay.chang@sifive.com>
References: <20260518070725.9816-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it needs to be aligned
to the PMP granularity.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/pmp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index a71091a316..de2157c830 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -179,11 +179,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             }
             /*
              * When granularity g >= 1 (i.e., granularity > 4 bytes),
-             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
+             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
+             * In this case, an NA4 setting is reinterpreted as a NAPOT mode.
              */
             if ((riscv_cpu_cfg(env)->pmp_granularity >
                 MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
-                    return false;
+                    val |= PMP_AMATCH;
             }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
@@ -263,6 +264,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_NAPOT:
+        /* Bits [g-2:0] need to be all one to align pmp granularity */
+        if (g >= 2) {
+            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);
+        }
+
         pmp_decode_napot(this_addr, &sa, &ea);
         break;
 
-- 
2.48.1


