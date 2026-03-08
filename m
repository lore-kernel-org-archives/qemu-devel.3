Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC22F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8QU-0007np-MC; Sun, 08 Mar 2026 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QS-0007dy-22
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:45 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QQ-0001vp-84
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:43 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2be1b5fe11cso6988717eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954381; x=1773559181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MX3WB4nCG/IAxBpjVipEnn4pbM1NmDgDXTp2xeRvhWw=;
 b=O8jaBeLFO2ltCERQ+JCR/+Q6CtNicI56aSiu7C2xT5R4eigQGh1hAlo0/yNqnLo20K
 vFskFzFvCT+G3ty/+wBKiSjpqVObv28wYkXfQsxQ576DV+oL1+0NKBD0PiDw8YNHejxc
 hP5D5uQdbBWE3eZsSsRG0K/rEzKgzf6valys8AqFhzUu4oNu8XSNZ/1eQZTH4cBLQHqD
 9L92K7m1MC2BJajWyaLdwk2AZXVlrBwy2Hdga7TpXnks+nk+fbK3lQkWuIfoT0jXgRgt
 1rl2K17mvxTTDieBVBWEEhdjk45jSQ1xE3MIvXO7+3sKm2Tsm3Wk0doCqG5qzNmuq3Uo
 8j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954381; x=1773559181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MX3WB4nCG/IAxBpjVipEnn4pbM1NmDgDXTp2xeRvhWw=;
 b=gR+qoiawM417atWPHDJp6rY9DGuJSTD38iu5n7UyBTTpHR3TCh3LBx3haIRy0mVhTe
 KzYMcCI3qaXJ8gC63yVS2HLda9hW4iPlib6zOadr0oxHtDZcPGFyLXdOpN8FFPFZYVWS
 /YcSXuWI3kvpS89aiYSBQFFVvKOmXcYd2rjvMiGDNSoiWayLqofqmgz22GfcbJPkhuTV
 JMo4896oGriLyGbddZ3KfbolI8oTlmVyaJ64pwMUgGX7rCoYWUbP6wlU/SGCm9qP5q3o
 kINwbXglY593nibnAykx9HuFAXpMfOh2ZvMjXeSOBGKSKvh3/zTySgW49b4lL2em9m5w
 ozYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWACA0hvIVxR8wPnGWSDs6yzdwFGDBViMHDtd2C8BMq88f19bdNNYFOXU3uOvwEplo0Myy9QkxtO7Y@nongnu.org
X-Gm-Message-State: AOJu0YzqSPJg49kKuzMUqcaNVNWxKdhLy2WI3eqoP6Myxv+roCVMSFny
 0MLKmMaSmryzqYvFLivPpjSkESRL99o5U9XpkJ2Oi/M47qOY8tCPcmX8
X-Gm-Gg: ATEYQzwB/s3cH2pTJ+7NquWK5KiZDACBMZZY58WiSxialk4LGdCapfLlU0yEu9d9+pK
 wWA4ikpWiaPgez1FjN0kFwlH4wge3ZYcrElPr7MUepR2VT+BzV/DbajICdW6Qr5dpdvfMQ+QgIJ
 M+cCYm+HV+btHdwzh9lwSNrXU2sT4He3aJQ+a4PClehtlO4lxo5xX6EK8nxbO5ugYNUHFS1vVM3
 hdsRGFTna/BzWKJQ5I5dht0P6tdbrrwnbjMUdeWTDHiVtJxPd6nDX5fgbhxZ2iOVITRyXbGabmL
 gzi7DRAOiBqWF4IF+95azCZhAnEVEx8N3/3GAYfoFSQzrbIzE5Mj9nZ0Eht8kV14U5z0W+82j32
 OYVc470FF1wZydHYgkFZ+jAceOKbKfrteiOssIehEyZD6Y+r0HxZ0gzMeQ04+5qmW8DsYQAXOVr
 poFLqYYkHxPlGp5zrXcg4ilHc51QlMO54yXyHhfNpWwrMaUDh9/TnW42zlkM4KQnL5xFYmr/4K1
 NsjJMkFHGrv9kX8cw9PCZxZuiM=
X-Received: by 2002:a05:7301:9f04:b0:2be:ca4:e145 with SMTP id
 5a478bee46e88-2be4e08fc05mr2471853eec.21.1772954380834; 
 Sat, 07 Mar 2026 23:19:40 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:39 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 12/28] target/riscv: tighten itrigger privilege and count
 checks
Date: Sun,  8 Mar 2026 15:17:15 +0800
Message-ID: <6adff7fe6b74b9f25918d8c64ca0c4a9ca3b0fa0.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

Decode itrigger privilege enables directly from the mode bits and
only advertise itrigger activity while an instruction-count
trigger still has a non-zero count.

This removes a looser check in the debug helper paths and keeps
the exposed itrigger state aligned with the conditions under
which the trigger can actually fire.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/debug.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 00fd75f15f..f3d6eaeb1e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -795,30 +795,37 @@ itrigger_set_count(CPURISCVState *env, int index, int value)
 static bool check_itrigger_priv(CPURISCVState *env, int index)
 {
     target_ulong tdata1 = env->tdata1[index];
+
     if (env->virt_enabled) {
-        /* check VU/VS bit against current privilege level */
-        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_VU) == env->priv);
-    } else {
-        /* check U/S/M bit against current privilege level */
-        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
-               (get_field(tdata1, ITRIGGER_U) == env->priv);
+        switch (env->priv) {
+        case PRV_S:
+            return !!(tdata1 & ITRIGGER_VS);
+        case PRV_U:
+            return !!(tdata1 & ITRIGGER_VU);
+        default:
+            return false;
+        }
+    }
+
+    switch (env->priv) {
+    case PRV_M:
+        return !!(tdata1 & ITRIGGER_M);
+    case PRV_S:
+        return !!(tdata1 & ITRIGGER_S);
+    case PRV_U:
+        return !!(tdata1 & ITRIGGER_U);
+    default:
+        return false;
     }
 }
 
 bool riscv_itrigger_enabled(CPURISCVState *env)
 {
-    int count;
     for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
-        if (check_itrigger_priv(env, i)) {
-            continue;
-        }
-        count = itrigger_get_count(env, i);
-        if (!count) {
+        if (!itrigger_get_count(env, i)) {
             continue;
         }
         return true;
-- 
2.53.0


