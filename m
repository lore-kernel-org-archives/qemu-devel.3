Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22815C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 01:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcZ4b-0000F9-Nn; Sun, 04 Jan 2026 20:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcZ4Y-0000EZ-VL
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:07:50 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcZ4X-00043l-J9
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:07:50 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c7aee74dceso5292993a34.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 17:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1767575268; x=1768180068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3SVBypWEBMQN8iqEejp5lfya+7lv94nMrn+JYENeJk=;
 b=gasMiYNGL+HZ6bJjIuUkFJq3J2RyHQGvlEeYUfOnQL1P+HSwaqA4FxdHzy0v4jfHIK
 DJqBX6xwyXzrD/OSkuRs872k7JhV/wt4LA8QfjQenLegBhWywlGy5TTLSlYwOlTRS12n
 j/BrUjKbFas0JoOk46L9xE5IFc21ovxan4zD1YmH596Z4uY6rjrsHWjtDrZUU6eFkPot
 K/HwgAdykwGpnKv8g52CMcEbNEu+tzxaKGsITFOXKDzYuZP+Qm4lGcXRd2EurKAGHszd
 F5xtLYLepnQn0CLi4Um+/R8GdqCwwSOwJ41WRvF67eQC5pOMaR/OFXWcKpQW4/vfzDtA
 6/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767575268; x=1768180068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D3SVBypWEBMQN8iqEejp5lfya+7lv94nMrn+JYENeJk=;
 b=En9sWfVRUdaYT4HuM70oPOIBCO58/dVJgurMFaIlTWezAdGbyk6B5AS7Mne/q0zfwb
 iX4+llri4ImmRldbp7la5S6fjxSTiePrvFAssKdyu8bjK/3cWl4+UqCHTY5mATW/u7Ob
 3tKFL4LM1FQSzvc0VC8knZwKQ46pmSEMH8HzHxWcLNc3/jS8TRVbAHumGYQgaqhW9LbZ
 29oftfs0agv1eSSVdQW62bn/Ma8cSEmW4qAzWJ8viDBYhSldP/qvvE7Cl9yO956+DDCX
 BWHqhbSx/1AYbE1r4Ne9tusy7n1swz+g9e+TwqTPCJL9soFtDoVtN0zUJwVzul3bu0X/
 RJxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdC2PgEQxSO4eeFOVRnGOH9N6pt3SUdF6yzIqtleyehBgWa2bnj6qGiZ2lGy1Ku6/Uy4+EDCkqeHN/@nongnu.org
X-Gm-Message-State: AOJu0YyMUGWm9e7WkoKplDmuqpg2+Dlx0GK6ShqKmUdUCMN2va3OgEHt
 dA6M+knDvVzE/XZP8BvQJKqloa6EksNovdHnfpml6JdvnqE6KuDjG0y37FFEsjG4t04=
X-Gm-Gg: AY/fxX6HuNBZqPK8t2+uHVyRC9EYe+zKSoyPpqHaxjLzYc8b4rfxFXNsUTLmA7cJtvG
 3dvcW0M9NVpRmwmrqqxN/1P5ExDrViBpVG/ebAByZhW3SPmGEhvZNQ6U3tJpbeB9j0yiE53ARCY
 RqYRwsrtAxTxvnW53xETY/9Wzis/WxGPATJtuQBYDfnir+wkpmokCE8VJ7/MzMCRBAT6FVaZkGe
 g2Hxq51Bi9Cm/wSkB2oUys2JZWstQoSTnQXSwpbreJbdaS5ExPffNqXycmEDLm8u0D9+hnQjEz7
 aieR2X4y2BCYFUycUAc/XgvPTpZYbKSS9569IjxjCzzQg9UP0QeX5ZwTXFsmcQnFZcXflzrfH3T
 VTaPR+uQBSS4Xqf9WQKD85XSEgaVhp4fKq3Mq7KOimUWJMRd8WABG0aqT7zATd9rRaWgnIo8rqt
 XAQc/dpdXEsZUPiRxB9q+RipZjr6piXN7kCZzq9f2DVahx
X-Google-Smtp-Source: AGHT+IF2HcG7sNsFwa6MdbW23kNWHIsArZ3BZZQBqONmm8dfcCgf3oONP7lC3nucVlsSg+slYI6wIQ==
X-Received: by 2002:a05:6830:2e04:b0:7c7:638a:8100 with SMTP id
 46e09a7af769-7cc66a78273mr27486848a34.32.1767575268629; 
 Sun, 04 Jan 2026 17:07:48 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cdf600885asm15962364a34.21.2026.01.04.17.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jan 2026 17:07:47 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 3/4] target/riscv: rvv: Add mask_reg_full_update to
 mask-manipulation instructions
Date: Mon,  5 Jan 2026 01:05:56 +0000
Message-Id: <20260105010557.318635-3-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105010557.318635-1-antonb@tenstorrent.com>
References: <20260105010557.318635-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/vector_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5bec75edf6..b07e8f7b50 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5075,12 +5075,17 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env->vl;
     uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;
     uint32_t vta_all_1s = vext_vta_all_1s(desc);
+    uint32_t mask_reg_full_update = vext_mask_reg_full_update(desc);
     uint32_t vma = vext_vma(desc);
     int i;
     bool first_mask_bit = false;
 
     VSTART_CHECK_EARLY_EXIT(env, vl);
 
+    if (mask_reg_full_update) {
+        vl = total_elems;
+    }
+
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -5094,6 +5099,17 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
             vext_set_elem_mask(vd, i, 0);
             continue;
         }
+
+        /* Handle elements past vl in mask_reg_full_update mode */
+        if (i >= env->vl) {
+            if (type == ONLY_FIRST) {
+                vext_set_elem_mask(vd, i, 0);
+            } else {
+                vext_set_elem_mask(vd, i, 1);
+            }
+            continue;
+        }
+
         if (vext_elem_mask(vs2, i)) {
             first_mask_bit = true;
             if (type == BEFORE_FIRST) {
-- 
2.34.1


