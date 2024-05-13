Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B853C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6MkA-0001EJ-QS; Sun, 12 May 2024 23:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6Mk7-0001Ce-Q6
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:52:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6Mk5-0008Is-Sg
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:52:51 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f5053dc057so362688b3a.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572368; x=1716177168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWcnAarNJxqeg1/LDUlKJzpC57oJ3MoFtLFkKPJknhg=;
 b=YTKA+/ONCY4dCA/yICstKVbjl/mK2e+oWOW8urybDDC4tolWgFn5QVJHRpSTP0JMFo
 g7hwOXECMbXQyOv64pXh9OgFrz8jvpSMwDaLJ7+/Pr/WklTBA/L47eWxlgvEaWP1b/vX
 qaRK3DCvLnef4GZ/8y/0kxW2FmB7x/heABKL3uShkuW44lldtzx7sCq+15l8iEO1nNEk
 bAC7/fqYacMnbH00kGt9Y5ZZdXvw/FyAo+9UohNF8NzKIYnMx9OdYKxvuxR+/LzZ5MRD
 AXWdsVnmrVYiHwOVrF9JYFA+2pgFazpvgXaZNsd0wDwCc/KQzrMmR2dC3bv53epGJE7d
 p7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572368; x=1716177168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWcnAarNJxqeg1/LDUlKJzpC57oJ3MoFtLFkKPJknhg=;
 b=RelsVcHulF3Fc3WRhwWpl0Hv4a9uHIHYntSoS58dMFhMwElnadYKgL/zgXA+TiqRFH
 2zW/UA1bv+D3zSNqSJ5KjLdF4em6MXtbNa8W1z8zNDD8jy75mVDEogvXmG5jjx5dfZy8
 w1VnAsgUbWaMwwvuhoWIdpD+ErJVoHShNH1pBfAVAOjKIY5nBxzUicu2uHcF7LvOW2Uv
 4UBMlD1hnofXkrVQbFFHQVFvgH0jy1hp1aZ6FJ2Cd4hpT5mNZa+rDSCK0GdiTPuRZYRA
 aW+w9HlY/hwDuyw4MSjXGQvkAiR3pLAIS2t5biPe1zwb/VEk9/jEh5GPAAWJmcyqyoTb
 gtSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhkJaGU9wI9omy3tIiEOgkpos97CfpvdQoKdqFKcvbtTvj0MvpvmQVv+JD+tGbnMJs72zo0qMVibFE/SfGnYGi/ZfCNfg=
X-Gm-Message-State: AOJu0YzojxvuaKLAEjQbrWOE+la09GvEyqr377n2z/AFU/01p/gMULDw
 U3rxEZ3IfNYaKv2es8XO5xLW/C+iSBHg3sqKSgeWjRqw3lhVRlcxRccX/i6/56I=
X-Google-Smtp-Source: AGHT+IHN1UGQB7ywyFrvkx3WtgPeaU1epsTYZfQEANvhFQSG4dQxcQrlItks2TBJcPTMu5qgHsXs6Q==
X-Received: by 2002:a05:6a21:3298:b0:1af:ac31:9b8b with SMTP id
 adf61e73a8af0-1afde09f44fmr11057615637.10.1715572368607; 
 Sun, 12 May 2024 20:52:48 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:52:48 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 02/11] block/raw: add persistent reservation in/out driver
Date: Mon, 13 May 2024 11:52:21 +0800
Message-Id: <20240513035230.60162-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513035230.60162-1-luchangqi.123@bytedance.com>
References: <20240513035230.60162-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x42a.google.com
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

Add persistent reservation in/out operations for raw driver.
The following methods are implemented: bdrv_co_pr_read_keys,
bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/raw-format.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index ac7e8495f6..7ba5b12101 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -454,6 +454,54 @@ raw_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
     return bdrv_co_ioctl(bs->file->bs, req, buf);
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
+                    uint32_t num_keys, uint64_t *keys)
+{
+
+    return bdrv_co_pr_read_keys(bs->file->bs, generation, num_keys, keys);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
+                           uint64_t *key, BlockPrType *type)
+{
+    return bdrv_co_pr_read_reservation(bs->file->bs, generation, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_register(BlockDriverState *bs, uint64_t old_key,
+                   uint64_t new_key, BlockPrType type, bool ignore_key)
+{
+    return bdrv_co_pr_register(bs->file->bs, old_key, new_key,
+                               type, ignore_key);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    return bdrv_co_pr_reserve(bs->file->bs, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    return bdrv_co_pr_release(bs->file->bs, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_clear(BlockDriverState *bs, uint64_t key)
+{
+    return bdrv_co_pr_clear(bs->file->bs, key);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_preempt(BlockDriverState *bs, uint64_t old_key,
+                  uint64_t new_key, BlockPrType type, bool abort)
+{
+    return bdrv_co_pr_preempt(bs->file->bs, old_key, new_key, type, abort);
+}
+
 static int GRAPH_RDLOCK raw_has_zero_init(BlockDriverState *bs)
 {
     return bdrv_has_zero_init(bs->file->bs);
@@ -672,6 +720,13 @@ BlockDriver bdrv_raw = {
     .strong_runtime_opts  = raw_strong_runtime_opts,
     .mutable_opts         = mutable_opts,
     .bdrv_cancel_in_flight = raw_cancel_in_flight,
+    .bdrv_co_pr_read_keys    = raw_co_pr_read_keys,
+    .bdrv_co_pr_read_reservation = raw_co_pr_read_reservation,
+    .bdrv_co_pr_register     = raw_co_pr_register,
+    .bdrv_co_pr_reserve      = raw_co_pr_reserve,
+    .bdrv_co_pr_release      = raw_co_pr_release,
+    .bdrv_co_pr_clear        = raw_co_pr_clear,
+    .bdrv_co_pr_preempt      = raw_co_pr_preempt,
 };
 
 static void bdrv_raw_init(void)
-- 
2.20.1


