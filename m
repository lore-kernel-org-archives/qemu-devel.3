Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588FEC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 03:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCt3V-0007TM-I4; Thu, 30 May 2024 23:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt3T-0007Sp-N7
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:35:47 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt3R-00035h-OF
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:35:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c1def9b4b3so114103a91.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 20:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717126544; x=1717731344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEuUjUzQAGNW2bFbTYz8h5s7RYYUBYzAO9/VPokyqDk=;
 b=VmyGK3yba4zvWFbTD+ngw3LbPJYWy+//9UUfutAfU4c2Cz59Sg+eOzL5lI/xm/yNql
 xeaTdZZ6byOTNMq7ZC6/d5KFL7qB0Mo1R9g1NSqyGM0//tPhChtyUEcAB7gwKAX/cMPf
 wm0nj5di5h/lVBny7kefDevgXjkYTuaB7Smcyiq67mDleoqzKcFv5wCqHARjzs4AE9/i
 nCL7x+LQUu+nLEwA7MZ5vPZax/9G57c9rIYz91/9FNCtdLBIxaUDM6qumdEmhHB42Bly
 8Nv4ZC6hV228mhTk4RNp45/dQ9KhF8L9QMicXzgdccm1O38ptO8wYQZKBUGFfw/5YdwV
 I6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717126544; x=1717731344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEuUjUzQAGNW2bFbTYz8h5s7RYYUBYzAO9/VPokyqDk=;
 b=A6wFcQXDjnGSMyCoY4gAXUGoTrtzoFAYz9GaaQD/X9/T1Kp64tVn2wHH6hQA/GhuFA
 ceOM+VmZQeXP3lhVCop3X5UZqjsPZcK2O0w8MvV2XVKgdQZKyjygptxZ0WepUg4FSJdf
 crnfaxgpFMoch8a79x7Y96FS4S4Yjk8gljgPsKDxNcoF6qFGdtpStrowZb0fp+UKNZ8K
 eJ5IIc0DngkfwIYGUaGSr3B2VuJ6vF8KGct0Aezn0H/PO/DH4dyI7SPeVxgJlF5lCYtW
 vT/GqwcVONHXeQmFSInUmACrrNUZLQsyWutNq/fj0m+PbGELyauzTbevZTPbpYW9EtaX
 NOwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2PywwWaLlIdY8DK2Yk82zBdWzIRQSXO8LesdT4HF/zD3lT9iRgy4rXqLwwFgLHyfWyqem0hiMnOkTUg4JtCeSu1ADt9U=
X-Gm-Message-State: AOJu0YwpJD8qxvzq7nQPS1tFELnN9AM3zwan2GjVWl1f6d4tm5UnmNmm
 fqlAhYWBmsI6dpl+pOv2NLdzZJPxoCOf3qBjPWSCgBwq55C25M/uHQ3U/Z58mSc=
X-Google-Smtp-Source: AGHT+IHDT1lC2cdVebO9FTOYs8D4oBLctvRtxSMk5lrJwimnwEt11Bw0EdHm9DrLWuFnNjOyCjwoSA==
X-Received: by 2002:a17:90a:eb17:b0:2c1:a4ec:25d0 with SMTP id
 98e67ed59e1d1-2c1dc5bf315mr672478a91.37.1717126544215; 
 Thu, 30 May 2024 20:35:44 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a777e989sm2457629a91.29.2024.05.30.20.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 20:35:43 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v4 02/10] block/raw: add persistent reservation in/out driver
Date: Fri, 31 May 2024 11:34:47 +0800
Message-Id: <20240531033455.3774806-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
References: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/raw-format.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index ac7e8495f6..3746bc1bd3 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -454,6 +454,55 @@ raw_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
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
+                   uint64_t new_key, BlockPrType type,
+                   bool ptpl, bool ignore_key)
+{
+    return bdrv_co_pr_register(bs->file->bs, old_key, new_key,
+                               type, ptpl, ignore_key);
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
@@ -672,6 +721,13 @@ BlockDriver bdrv_raw = {
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


