Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D681EF55138
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Qc-0008ND-TZ; Sun, 08 Mar 2026 03:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QW-00088m-QG
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:48 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QV-0001yi-5F
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:48 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso9005191eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954386; x=1773559186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Arw5DkHnIHFmXLFPr7igt+8kKLdzDCKYx1CXG3qK2V4=;
 b=f2GmZQ02Zqr1TF1/aNmX1CrUJam928cPiHcmy1JZrgJcrJzOLpmgMArtGwwYfTYea/
 ARYep9549hUqxAQ6Ptw7Gb6UKCnNsY9283T38gsPApBj69I9uRJ1Z3QrMleoDiac7Msh
 qooNAbjp1rMrX6xIfYvJUeMWUshmOJAiWm+m9oEDjJIKOos5uUFE0cR8UVADd98E56EI
 xU5x/A5Ai1q+UzXUBmQCBCb/M7NxqOi90G0fADjzVInXgZ/QfzJ8YDbUVbIktr9kTLh1
 mAFc53Mro41Aig83o4NHGLGrCCKSy/9x9LmbhWzQyxGiIag41d1KTonkEw6PIAkJyiQg
 B/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954386; x=1773559186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Arw5DkHnIHFmXLFPr7igt+8kKLdzDCKYx1CXG3qK2V4=;
 b=EjUf572lG2tyd/GFO4AN0swY13EDK7qyXhWvyPyNm2H9WXsDMfEhPGI0xeT98FaTSV
 j1e4yWM9/pRYlC493F5yioH0ACw6S8yaBI5sIjvHB4SOvKtYO5YXtvLS1BQRPgdM6thf
 Pduf6bDHwrKImMxdti7xUJ8LuvZwnGfLdvCiBv95CiK+XvaIDAeLoshxBtpCJOSmdPlK
 oYgvpcCDSzP95/WjOmKeUftZhzsoaIumIXC4gWBUVHC9uu0urgtovRt5hp4W+hVOOXGU
 weAOk2RQkLXBkyeyq8viwSL8oZaRjxg67Np3OSd1wvR8bgILOC754S2ZP2pNlFxmAJmR
 kx4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZBdQmruqRPovFLL+0rPEuEAaijnZxoJcE35hEMgDSafrkXpkbS0c+MuP2qaRg0jXA7ZDufcvybMZ8@nongnu.org
X-Gm-Message-State: AOJu0YwX8ZL7fCFRtr1GL6miTaA1ULkthPNitpij2O7GMGH/tqMo0SdZ
 s4jPs/khnVknG1hFjpAEJrgbCDo+hP6wwVUjb2zv+r5JIVfPijGzb1qM
X-Gm-Gg: ATEYQzxpPwf8T/lwQJTu8wdlnDYriqG+jHoapDiQuSnhtMU7Seyi5RND/oADDBxaYTM
 K/XgBY71J2k2EA5+TSvc9YUu2ze3xIszn+Lw8sncobeREMQWolD6UOZ6TeUYPVdpaHIyY9zvdk7
 zI+rTeYJmPdnsIA1fhdnTob2Caz3KGE7g2uweJO0ydZLvCVZiu21j5nB/cXofZEA5jEoMElpby8
 1iKNNW7lE5tSDizOh737RNeMIfkbIOR82MhilXN4qiDe09xXyzhO6+Kd0+1A3BGpL18kOR3n11S
 Q9CFideMM7hJUUybnGYGJjsNWfmL8g6U6ij0ogxjfdo6LhNBxdWE2K+XYSRP3a56n3b/5l5nZNd
 ajZLsusLjd2eDTLwoVI4JxUQmRDxMO249Lark/s0x2qe4O+xgT+oA69n+nnEHxc9yk/PHimwivS
 7SwzIB7wHp9zET8F6vddGwsIwjscWxD9mmtWyg2Bj2tEH9tZjOsLdi6ZkhBVe7vQEoSTmtPbMBV
 EfvkY0IawTEIeu94vvQEqd1wWM=
X-Received: by 2002:a05:7300:6c28:b0:2be:e4b:60c3 with SMTP id
 5a478bee46e88-2be4e027173mr2822376eec.19.1772954385681; 
 Sat, 07 Mar 2026 23:19:45 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:45 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 13/28] target/riscv: allow debug-mode actions for itrigger
Date: Sun,  8 Mar 2026 15:17:16 +0800
Message-ID: <c03f4751f2145f6817083fed32aee06dcf65584c.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Accept action=debug-mode in itrigger tdata1 when Sdext is enabled
and reject unsupported action encodings explicitly.

This extends the instruction-count trigger path to the same
debug-entry mode used by other trigger types and keeps invalid
encodings from being silently accepted.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/debug.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index f3d6eaeb1e..4dbcf289f2 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -916,15 +916,27 @@ static target_ulong itrigger_validate(CPURISCVState *env,
                                       target_ulong ctrl)
 {
     target_ulong val;
+    uint32_t action;
 
     /* validate the generic part first */
     val = tdata1_validate(env, ctrl, TRIGGER_TYPE_INST_CNT);
 
-    /* validate unimplemented (always zero) bits */
-    warn_always_zero_bit(ctrl, ITRIGGER_ACTION, "action");
     warn_always_zero_bit(ctrl, ITRIGGER_HIT, "hit");
     warn_always_zero_bit(ctrl, ITRIGGER_PENDING, "pending");
 
+    action = ctrl & ITRIGGER_ACTION;
+    if (action == DBG_ACTION_DBG_MODE) {
+        if (env_archcpu(env)->cfg.ext_sdext) {
+            val |= action;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "trigger action=debug mode requires Sdext\n");
+        }
+    } else if (action != DBG_ACTION_BP) {
+        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
+                      action);
+    }
+
     /* keep the mode and attribute bits */
     val |= ctrl & (ITRIGGER_VU | ITRIGGER_VS | ITRIGGER_U | ITRIGGER_S |
                    ITRIGGER_M | ITRIGGER_COUNT);
-- 
2.53.0


