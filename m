Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB21C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwf3p-00048k-51; Wed, 19 Aug 2026 08:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3j-00046T-66
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3d-0007qm-5e
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so9898545e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787141167; x=1787745967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HWuPTwu7BBNInsioIn++QUXErXu52JLqTBsasESnDi8=;
 b=uEMcH0aGv2VClF+LtdOiw6spWavtOzA7vG1xbxcEKfDPyyiRganjZERrGJZfTmxXml
 O+XNVlaZ8Du/JeisjJ2GACubPObseX2woeZCsbFn9dexybRjKORvEn40mOynEewUQPbB
 Al/tZOQANGLVM9zpBKK9D99u9kbq8i5gOuLy389WZbiYriu916ldB1KL/8QEwVoX0av7
 d4sgIhjsIHtpRtzF8ScMAGEoPZPi6urVUoWlNEFwgyu2IgY80wLSAQ7s4Wiu6vngPa1D
 AANEXUMmAS4wBAsLYzqe6lgWZsCTbgdUjPhxVa43sn2y1da9NfDhLJTdFg4wtw7yhNMa
 7UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787141167; x=1787745967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HWuPTwu7BBNInsioIn++QUXErXu52JLqTBsasESnDi8=;
 b=ZiJBqKKUjbBYb5bdYyJk8Njfex4Al+EGZasu9XSJaxvmgTZ8iU12/XMaw/0RjHMg8d
 73AUwkvIKPVY/NJiiakSYW5Rfe8PpJCyXh2hP9+qaMv7eemJilM4sIFra/Cs183H30JI
 DJVjuiZsob2WWKJ4G1I1UdCvDl/w7YctCHSLsXg5VVLPMMn5QP0EHe6y7MJaD3qcOv2J
 Xy2w0HvvE0/XzMOYr44PlHXMbB/FbF2FD5muIwuVwfD6tzbD5HinljLCl2MCvsp3jJHv
 I8n4gwyEBdFC2t/u7wO6gGipYgJRi/3CdICH8VfFYvSNfdxjFzvbgC5mEgbmsysj6j6L
 6JXg==
X-Gm-Message-State: AOJu0YxZwuOH9uXlAhH3p6st43eXT5hPd9d/GcrXUghqjpznIV7ot5AH
 1iJ89e6DBshjM0lygbJWrBU+R9LXUCRlcgFMXY6ADc9hC5Z4wHPjg/fpY2fgDjlFTQ4oQdlAF6A
 hzWH0
X-Gm-Gg: AR+sD11wm1fF/Q1CdR9j1vdi3SyTrteFeK+6X6soGZD3g2UePn7yGLrLjs2ckepFYw4
 oIJzlyGpPY22UxZ/XV+uoOZ42ih2CY2bzyHWWmAZAl3cde09MXeTR5mqaL85Ij5GaTN0LPJXa9V
 hvnFeAVlBX6vWG7QSTQj1pYCZTaQDkoHIDubHA9aQsSoGn1G/WexCnvrbBU4TIlP0nT7cspIrLj
 5AMfXH+JSsrhY0gjZMWZqAbRkIJrR4c64o1DR4CTe0e9UeGJzWoBklXO+sbZ1ShakYxBn41FAW4
 K6BNLVkkFBzOCJ9Kd4K+Dh/iomRElara7rjpbfGv7744lD6ruKXpt+L8KPSJsPHChFRBCxD5Ylf
 r/v2WSxR7S0980oVQy6Kg/FvEW+7wedyHAyM8I8QvLmroniqf8ExByD1Hw5HkjpzKQCp1TT/co/
 HpvKbo4nm280fLmun92c7pnkX9qV93GLJPVX5Ns27jorbTSyYuBERxVgBQOg==
X-Received: by 2002:a05:600c:6091:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-499aa1ead50mr93721075e9.14.1787141166863; 
 Wed, 19 Aug 2026 05:06:06 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:258d:1706:7089:f765])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111a7sm59244785e9.6.2026.08.19.05.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:06:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v3 4/5] block: remember the flags a reopen starts from
Date: Wed, 19 Aug 2026 14:05:57 +0200
Message-ID: <20260819120558.3870413-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819120558.3870413-1-den@openvz.org>
References: <20260819120558.3870413-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
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

From: Denis V. Lunev <den@openvz.org>

bdrv_reopen_commit() updates bs->open_flags, so by the time
.bdrv_reopen_commit_post() runs a driver can no longer tell whether
the node has just become writable or was writable all along. Only the
transition is worth reacting to.

Record the flags while the queue is built, next to the other pre-reopen
state BDRVReopenState already keeps, and let a driver ask about them the
way it asks about the node itself. The predicate which
bdrv_is_writable_after_reopen() spells out gets a name for that, and
stays private to block.c.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block.c                          | 17 ++++++++++++++---
 include/block/block-common.h     |  1 +
 include/block/block_int-common.h |  2 ++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index b29202c8d5..6280a13610 100644
--- a/block.c
+++ b/block.c
@@ -2193,14 +2193,18 @@ static int bdrv_reopen_get_flags(BlockReopenQueue *q, BlockDriverState *bs)
     return bs->open_flags;
 }
 
+/* An inactive node may not be written to, even though it is not read-only */
+static bool bdrv_flags_writable(int flags)
+{
+    return (flags & (BDRV_O_RDWR | BDRV_O_INACTIVE)) == BDRV_O_RDWR;
+}
+
 /* Returns whether the image file can be written to after the reopen queue @q
  * has been successfully applied, or right now if @q is NULL. */
 static bool bdrv_is_writable_after_reopen(BlockDriverState *bs,
                                           BlockReopenQueue *q)
 {
-    int flags = bdrv_reopen_get_flags(q, bs);
-
-    return (flags & (BDRV_O_RDWR | BDRV_O_INACTIVE)) == BDRV_O_RDWR;
+    return bdrv_flags_writable(bdrv_reopen_get_flags(q, bs));
 }
 
 /*
@@ -2214,6 +2218,12 @@ bool bdrv_is_writable(BlockDriverState *bs)
     return bdrv_is_writable_after_reopen(bs, NULL);
 }
 
+bool bdrv_reopen_was_writable(const BDRVReopenState *state)
+{
+    GLOBAL_STATE_CODE();
+    return bdrv_flags_writable(state->old_flags);
+}
+
 static char *bdrv_child_user_desc(BdrvChild *c)
 {
     GLOBAL_STATE_CODE();
@@ -4473,6 +4483,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
     bs_entry->state.options = options;
     bs_entry->state.explicit_options = explicit_options;
     bs_entry->state.flags = flags;
+    bs_entry->state.old_flags = bs->open_flags;
 
     /*
      * If keep_old_opts is false then it means that unspecified
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 895ea17541..eb2dd8aff1 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -358,6 +358,7 @@ typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 typedef struct BDRVReopenState {
     BlockDriverState *bs;
     int flags;
+    int old_flags; /* bs->open_flags is updated on commit */
     BlockdevDetectZeroesOptions detect_zeroes;
     bool backing_missing;
     BlockDriverState *old_backing_bs; /* keep pointer for permissions update */
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 035e54d434..4ea1a78494 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1346,6 +1346,8 @@ char *create_tmp_file(Error **errp);
 void bdrv_parse_filename_strip_prefix(const char *filename, const char *prefix,
                                       QDict *options);
 
+bool bdrv_reopen_was_writable(const BDRVReopenState *state);
+
 
 int bdrv_check_qiov_request(int64_t offset, int64_t bytes,
                             QEMUIOVector *qiov, size_t qiov_offset,
-- 
2.53.0


