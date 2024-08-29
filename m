Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2092AC83010
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 08:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjajv-0005lE-VU; Thu, 29 Aug 2024 04:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjaju-0005eh-5H
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:42:46 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjajs-0000Aw-GK
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:42:45 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3c098792bso289560a91.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724920963; x=1725525763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROim7xG4VeV7okIeoWk1lldyf4YzP1rLfO+fx4YPjhw=;
 b=HP2xz18og9fugiccsCMD/DezsDlDfWCIPE/VQ7rtl8zLYVrcvb/I+a81GMMNvxUeSU
 Av5wxnpzAu/xc8cgCP5x7LolLb6P/x0ZAhgK7GrfC8453l2Vaa1Kb5xYpfoxiHI1X/UB
 /UKtV25W60lifSPd8gppCwjCOJqCenP7L/xFM8WEZjBax34d4/gdm+I/lv6cpFDyHFoH
 7AhEHx7EYppInmZHHrl0W+IL9rfB0rXvdFiTRUNOw9k/nAyS5zkX00+WvuG+J6EWqjPL
 TUJt99Hqbwp2tg8eFYWBnnnA8rsOE6D8/M9qqec4shbxSTtISdsogjPjAy8T0kIDxnMK
 lLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724920963; x=1725525763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROim7xG4VeV7okIeoWk1lldyf4YzP1rLfO+fx4YPjhw=;
 b=jbYISMQ9ykJ8Sqoh8rF7NNwsbdYew+EYReDyqGt0R97ntXAi29ws0zuPxaVAoNCCvz
 hzuJxMDWMFd7u4vI2gShHhMwDdrHlNpENVJuCqK3L+ZiFUnLWwZyyZ3CnjC+aPyDlcOq
 CSiCiEv3d0AqKkbYmBtXAqqe8sHCNNp/GZeVkLzOrwT7iwpiWQ6gbr5SYlKcOpRhyU5Q
 7w4V59nc3F4s54AS2kl1RL6iU/JojtFs96qkavCctwGR6ZO06Fz3lyYtW1G5iAaiWraD
 QUNvSicAgz4X4quda6wKL2CRQfwriEaoUnclr1OAbIHW7eofk0kLElcZEWsg3jftowf/
 +mbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuPNuwxNeE9AyP9M5hgEoWqhaqHMvLvuxNjC6I+xaQfK9nPTaf0g3cvA/+8O5buBMAxBHXuMxqik6c@nongnu.org
X-Gm-Message-State: AOJu0YwVt4/CfIhVEDN0Uly9nLVjIF816VbiDwKv2wjglO2rpD2KfMx+
 OKHBDgERLOVD1+l+X7JdgDmqN7r35++bpgFGl15uv9AP6AZnklzLDBAWxiWZiMI=
X-Google-Smtp-Source: AGHT+IH4M+4oC+6nGZGniMH0XPqecvkVga2rIO+AUe3/sWlg+1s8Qfpxu2npEECvjJaRPJhRNgewug==
X-Received: by 2002:a17:90b:524a:b0:2c9:321:1bf1 with SMTP id
 98e67ed59e1d1-2d8564a50cbmr2238273a91.39.1724920963252; 
 Thu, 29 Aug 2024 01:42:43 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3897sm3431856a91.49.2024.08.29.01.42.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Aug 2024 01:42:42 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v10 02/10] block/raw: add persistent reservation in/out driver
Date: Thu, 29 Aug 2024 16:42:06 +0800
Message-Id: <20240829084214.50548-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240829084214.50548-1-luchangqi.123@bytedance.com>
References: <20240829084214.50548-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x1036.google.com
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


