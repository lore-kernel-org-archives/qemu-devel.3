Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50B9C4453D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaOK-0005FB-OH; Wed, 22 Jul 2026 13:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO6-0005DE-6u
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO4-0001aJ-3n
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-495437bb891so53564515e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739939; x=1785344739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfUxWo9DRfnzypPrGvcp6jHwrWI7DnwyNSb11uKFohg=;
 b=UfiLf6IQmGYZoAsI545lPW1kNHGgT9JDqG+RIjZJBNWv/xs2yI8FhQ5/F1SIAh9NpR
 +tyLcdbwC9upBn0D+o8zhvLB0wD/CjPk9kuu2RYEvEO081oVrbOZCkaSYbkEOOQgfo78
 RuAV4Z9XG7ANC6sCQ/V/tcrcjWHvFYlcGExBsrZX9icZZ7I/B/atXDHE1TRiDNQ6WlTy
 VHKrU0Q11ETevvylHgG44n6g025NVEY/pzv8lpIfYnXmJmubI7LrGvgSEYJq6vmVIA17
 5wEtFuo9Xpw6m0hs7JF9zQ8YsKguhRepiJxnzesLgh6BqeLR6hQD9MhpmVi7LqvuExdS
 k1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739939; x=1785344739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yfUxWo9DRfnzypPrGvcp6jHwrWI7DnwyNSb11uKFohg=;
 b=g7472v55rkbxd2z9yWyMCyx4QVz5GkfN7sEnTbTVFVOugX1hueilzlFUAEOy4rKQd/
 83P1qcvQanOZWYvdSwNhxJS6T/nBHU2R9oQuBiAQpuoHCNXM28uYhsVsIbA2LKa7AaKi
 yV9OrpxFg1f3gPbzQJ4c6eXhcrJN40by8tEkTZtH3L4IwD1EnSYkEV0nURNx11mN+Qtg
 Xn/FghIH3/ibimsgr/uH2Z2SOf9tupSp0cezriy+PUV0yJijtbsj+Iq9GF2rcOUnaeJt
 iUStwkDHHMFTR3mp8RynR9E5gy+TFX4nobdNQYkRuxrUP9wGs9NkCf26M64dUtxvF++x
 Bs/w==
X-Gm-Message-State: AOJu0YySzywTeqvwQpMUxIbS3j3Q5eLy2GKLXpai/jFj2/dgp7Fd2TVn
 T+fh+PvL/g8rxdZXcwWs5dbrik6P819szCyZOUe5L6naYCP8L2WBVd33jRqNF8e0tcGep1p2tMS
 BEgeW
X-Gm-Gg: AR+sD10RBlRZip0sEAqXoxCpezcUhnTmupALsZ+ZdSJsgLHOPdgBsDNYGJ0rl6KVv7n
 YT087h7KZXV6mHPSFj3B7i5U8IJ/eYRWbu4bb0msWiMjMsT+GHwgDREGwEPo8VPOoGq4ZDJX43M
 YvMOe7lrlt/JkTgQObSON5XmOTzISG1btY4qzvstKYNb9ftEkGkCEeFGTJWaqOseKMu5sWjXMgi
 YFeesEmsBfWonBcIX2obawO0ZHogJ3cy574OJOwKRR1vM0x05iS3QvVv8SAmnu8Ko3gimmO9253
 imILTMmNTdKgPByHaaCIwRAJ0+oKzA2ub1XBlQMT+QwpSo0d4RI+JlfZQE3yymqvBTSfoKjf6q/
 cgcsMjVk0IE/FOHgW3s6zfPAXL9KSlYUi1Q9YGX6aqOOLsXGdlLJIg3awz3EoPzQMsJJhTseO2o
 c=
X-Received: by 2002:a05:600c:4f88:b0:493:b698:9247 with SMTP id
 5b1f17b1804b1-4956a50fe9dmr58627915e9.14.1784739938686; 
 Wed, 22 Jul 2026 10:05:38 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:38 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 7/9] parallels: avoid fatal abort on large bitmap L1 table
Date: Wed, 22 Jul 2026 19:05:25 +0200
Message-ID: <20260722170527.2593225-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722170527.2593225-1-den@openvz.org>
References: <20260722170527.2593225-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
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

parallels_load_bitmap() allocated the L1 table with g_new(), which
aborts the whole process on allocation failure instead of returning
an error.

Use g_try_new() and fail the open normally.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels-ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 704e16e1de..7f6ab6b0d2 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -169,7 +169,13 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
     }
 
     if (bf.l1_size != 0) {
-        l1_table = g_new(uint64_t, bf.l1_size);
+        l1_table = g_try_new(uint64_t, bf.l1_size);
+        if (!l1_table) {
+            error_setg(errp, "Failed to allocate the bitmap L1 table "
+                       "(%" PRIu32 " entries)", bf.l1_size);
+            goto fail;
+        }
+
         for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
             l1_table[i] = ldq_le_p(data);
         }
-- 
2.53.0


