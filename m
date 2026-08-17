Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA56C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2aS-0006yY-0B; Mon, 17 Aug 2026 15:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yv-00061l-0S
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yq-0006My-VJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so41620145e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993190; x=1787597990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DvqpQ/5WW7AkpDNQqqrysO6vi5pABEqrTUwHZBF/GFc=;
 b=hrvhZxZMAhSGTTohcarf+PJ4eBTbs7o2VRaPzsTBHChxjKKKQktzf0EshIyP0LoPJF
 sTUvoFxYVQ7gF4aLpSamo2/KmK9SgH+LJpa0lokwkMzhY2n1QQsB4EX7oVqMKaK+4TGV
 /EaArEXG++E3jC7rwowllCmYeh2Jn5Pu1XEtAlneyHPrIA232K3tah91h2lxy3/cnNNE
 JjIC6LXL2CuNjDOx+jFWXwLl+Mt0lB9GDpaP6AZz1HbQlgo0SHOz2CftyTw9SVBCS3w5
 Lb+HfQn41EOvT061YXX1i3J/jL4yhHFVuAuMOYi+BIzbLx0gSodrtPa+hP6RL6gxu2lz
 BuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993190; x=1787597990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DvqpQ/5WW7AkpDNQqqrysO6vi5pABEqrTUwHZBF/GFc=;
 b=W9lT4hqwXkni2Yi/LNfHW94ohOoxgYojhziWWDyG0gvqaPlB9FvrhOqIbQiBJ7NvxU
 LQfwLyFHVlUYOuOto2GaTp4J8RXPAcvhvFL4Vi76Be4VepszWPf4uAqT2CX51p7QL0y+
 c+nKsNghbOQMliH8MFYRTztqFABzVEvLbo5wjpb+rYGFDGffVqIXCs2Wrl/QLJgSLa9w
 fB6wTpOnK3reFlypySidfdU+kjq7c34thB6qFIcKRt4Rl6pCSHfeg6jk/ba8ivKOqLYK
 /d2nJorVVDcS0Sb/Dz5VB7993RX0FoNDuIIEtLVN+7r1h35Kp+W7Dw7PLOHrGj+dO0nz
 0kRw==
X-Gm-Message-State: AOJu0YzjLu1PdhM9g0AObrqzMhLkvievxuZL/uEcLiJAdkw+9MAze6eV
 qvikJLBGZhlij3ytrnuJdl4V07VDC/dam5KQOQj6PRHU15O/QvVXt8IXkOPQqMBcpCbs0KXjn1i
 WeR6o
X-Gm-Gg: AR+sD11xIUJxRMsPMy/6UWppqiM0ET3lMXgS3Bjdksk1UNXOMpSdGD/Nf2Yn+cEuF/3
 MORk2CdwKDRqRlJ1XQigDQDQCVGxFgcTfzvuJauIb3GZ37gloq+TEdNHEBNF4/MuKe2iKDlqGhi
 omzaSTcTKOHmp1mvP842MuSY50+rDGZCw7BJqx4HiZ6hed4YdfMIsGvQNheTL/DhVtlH+eHsmRu
 Y6NdOicaywNuZpsXkiw2voVhh+8AsQVKluqsxckiGeBmLvDO9zo1m9gvFEtvwluU9MYqfPU+sZg
 v6SY95A/ihNhWGdxAfe6u/ahKws29oPb8gpVP8MQN1EA7Q2X4117UiAFRUOKZNYGbjzFXgisLAY
 P/mn7hNckPOnGSrGFONn5Qt3UWV2Uxh4NVkxdRUvEkT6BE6z3f8ImLVNICX0UlEm/W4rmvVHyqw
 07Q4C0UV6u4NZzmTJjrOPjwApZlq4PWyIn4dnxGL+fdE9WcwaPKPOtofI=
X-Received: by 2002:a7b:c04e:0:b0:499:518d:ebd6 with SMTP id
 5b1f17b1804b1-49987972ef1mr259276795e9.17.1786993190290; 
 Mon, 17 Aug 2026 11:59:50 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:49 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 05/25] parallels: Limit search in parallels_mark_used to
 the last marked cluster
Date: Mon, 17 Aug 2026 20:59:22 +0200
Message-ID: <20260817185942.1065143-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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

From: Denis V. Lunev <den@openvz.org>

There is no necessity to search to the end of the bitmap. Limit the
search area as cluster_index + count.

Add cluster_end variable to avoid its calculation in a few places.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 6f7a9911d7..d537b0bb53 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -192,12 +192,14 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
+    uint64_t cluster_end = (uint64_t)cluster_index + count;
     unsigned long next_used;
-    if ((uint64_t)cluster_index + count > bitmap_size) {
+
+    if (cluster_end > bitmap_size) {
         return -E2BIG;
     }
-    next_used = find_next_bit(bitmap, bitmap_size, cluster_index);
-    if (next_used < (uint64_t)cluster_index + count) {
+    next_used = find_next_bit(bitmap, cluster_end, cluster_index);
+    if (next_used < cluster_end) {
         return -EBUSY;
     }
     bitmap_set(bitmap, cluster_index, count);
-- 
2.53.0


