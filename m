Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F34DC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4prF-0000co-9V; Thu, 10 Sep 2026 21:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPv-0001jS-Dz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPl-0007DV-2X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49e63568bfbso513915e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083759; x=1789688559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DvqpQ/5WW7AkpDNQqqrysO6vi5pABEqrTUwHZBF/GFc=;
 b=kaM1IZH8rwXzjuP9hkwXbUzeYCNBJfjROb0Xk1J9PcCQZ50Ukt1OVPEkJVukDT3CM9
 IPiWsWz0ebmzLb7CBlZuDAzOg8ocoiMSIjvLfSjbtmbExMPWEwSPlS/KeoYFjk6lo/mf
 2xN1/AlmOco2mFJVdErH9DhWZ/B99UEmJLhMEOCIlYdf9XzQ8EsEZAi/hAsiV8ToGeeK
 +qWxXZI4D03BGGQD+2iOLyYccq9mIDAIS8ZOtTi40gWccgycFWzz122lOf1QFIF2YOyh
 jhIo3kFkQOIDtPLXo/7BVcaKiT5XLEQnNjnoBO+UIERJ12Djnu8mhtAo3a/0F3oF06x5
 LOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083759; x=1789688559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DvqpQ/5WW7AkpDNQqqrysO6vi5pABEqrTUwHZBF/GFc=;
 b=TAvkTbe00L8UwlR56qMAkEaQyNOLZjMxgn+ZSLFkh55R+h5EZnRQ81dvoke9mCFFdZ
 X2hyke20OxX8VARkC9Y9tHMgbV9HNHgUHblCr2HxFzc6a6/FrJh3Nvyj+8VOyJt7HuAZ
 AtOOzAkcX5kOcuyjdA7braLRoQra/U6CMsC3ajamkkfPTYTLegIoMktevkDBCWvNBTsN
 c7hihwG5Krd81EKMf7AcflDfaEqclkTCDb9H1nwtAFaBrYjpu/jet2geM0Y6ApUw7Uar
 D7amCXVHIwNv2lARamSzAsxmeM2oElj2jnM0ecSuUqio1D8gcsI2muxg0VEJofc0WBS6
 rWnA==
X-Gm-Message-State: AFuF++lEzVyUg6tBu65q3WejVtLadPaQFR6tK5upfUhU1iU6+geeAAOW
 Fho9UvoAkVTO1WUQUaecRPTBseg3xsKz+i0lv+IZfuuc9G7ChI3z5qhrDBpLXvziyx8=
X-Gm-Gg: AYBFou09l8cD3oo9+jqqY93J1DSj83+eBRN6a26JQjsH7YY5blXPSdHZf1VnaqmKfeO
 B5yl1VuuIoGQ728CVxlMLI85mr94emXmvdf/XQGyNhPLkTKXYokGJ31bcSBxLXSDtAa+KeY7XRi
 UtBnYfIVj00UdIF0trbHeINugscaCFZeJiOTYVfjPAP15YiuoQ38HJzUKzta3F37FozQx22/5TX
 wPFADk1SUvgXBhKmI8OwhP8pPt/sGAc4aI+0exzoB3dBlvMHTz+SMBAp1iK82IrhMYsMf19h2D3
 hwrCybn4ydGlfLAMMnBNrWiG3FysvRpTdUxJ72kZfLA4HtsUC2fI+lwoZrBAbGgVp8F0kyd89dX
 s5wEHdhgpTqxbTv4nTMl9oeKAMZ35LwJ+O9kwAj4IqlCulvcfrqC/4rtwWMcQ3eCZCuOJq6zWK2
 hpebrz+7c3FKneC0S2sRqPTss57nDA8f/BOZb9X87lOH/b9e5m85QnXkG84Ss0AKrghE2Y
X-Received: by 2002:a05:600c:1f8d:b0:499:be2d:c290 with SMTP id
 5b1f17b1804b1-49e6198933cmr15706105e9.9.1789083759602; 
 Thu, 10 Sep 2026 16:42:39 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:39 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 12/29] parallels: Limit search in parallels_mark_used to the
 last marked cluster
Date: Fri, 11 Sep 2026 01:42:05 +0200
Message-ID: <20260910234222.3039975-13-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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


