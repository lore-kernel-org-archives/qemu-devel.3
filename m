Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F295FC624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28f0-0002f1-Dn; Thu, 03 Sep 2026 10:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28ew-0002dk-Mj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28et-0003zq-Gy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1571409f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446598; x=1789051398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DvqpQ/5WW7AkpDNQqqrysO6vi5pABEqrTUwHZBF/GFc=;
 b=XFWTDFMwy1yCrH6zQ+gXh14Gl1DCL5Xk0BSZzHoNEmAAUUiL7mjpCAN2+HV1puZlGb
 B9tKXq1soJaoMDQwrZVHKYBCllYPzRzF/Gx99UTPI2N/3FTHwkuFBgSPSvVP4ShGZNkA
 dTkLXDldlPAUOFdOVMjRPqiCEJI1yRK4+IXgHMWjGeHwl2SUtA3+9+guEWishLw8AkLB
 Uy/miZeuZmAF8+Io9cgLX5bUmfJT/JJ4k/CGq9sASqxCWK+0bQKqIVWXYBMA1VPBi0hX
 CJF03m8AnYCPri/e+C9eW6dFZn0hI1lSA3r0aCvNYrrrk+2N7aB8Airy7zv8+aDwzn2z
 Xlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446598; x=1789051398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DvqpQ/5WW7AkpDNQqqrysO6vi5pABEqrTUwHZBF/GFc=;
 b=qE8mI6zU1GUWeyuJ6UAoFLEMtuc79wrv+C8AaAP1IQ9MI0EN86u7Ohc4kP5qtOSdOO
 v9xruzPB6a/rdSnChh9vs+cdZc9/L7KW+7xer1/qplEm6X+8OeKbfwi86uQsVo6J90Qo
 XciplOXrWS2k/qmfx8HypQ0R4N+NcjD3TbnfbbBNwcvw66INDth8VQ//x+XibWZo9lwa
 odS2eVfGCSnts2bgp4zKfWhIWrkLpbXJNrLWHZpXNnQeAhULTr0nyt6z60llOBKQrr6W
 YEClzIxu2Xz53NEh0Je5Y1uqVAbxokyWEXnr9idLTacnQ0vpQICKklLus5nCbVVKbpNg
 eOew==
X-Gm-Message-State: AFuF++lgjz4i59mH70Iq0swmK98on5qVw7OYQCx1Kbr1p6tblQhBK/TR
 lK8qJ8Z7TNPqFPQp9nPSkKjDIgJvzAlpZHNOjoX/IJy+KsF/XZGLkowRF0PmnulqRUylKi8QIVN
 w+edc
X-Gm-Gg: AYBFou10Yf2eX21s6moYPhEtdwvBR2yjdeHnrKzJg6PR1hEHmZ55UipfMtyC3MDJZdW
 Ra7FNY4FbLnrXGewlhCSJIv71uI66+kpzAgfDYi30SlA0nR3kEzJNXnD2cQzW5KmqnTGic06wf2
 NMBbqApgJteDevBaPjxKzy6+QxZw875rz0eF6gqrcW00v2P5uGNG7D2h6DiPA/j1IHcUugTBnjC
 YZhiOktNub34z6HyoGqDRhpJdhuqp4lqNkWu2SzG/5Bd11C8PK66ViPRMhAq/u9pIzqQa3fPuOP
 7snUVzZI4vRQL3+YrEiz6bfm8Y/HzqXqromgTVyAstAkAcmoW1ecy+SZTE2Yy80fc/4yUDHHjxK
 7/jkFzebZcj504JvZmE9yEPFco6OBBcB+pWWTiyygcsehaMryE6BSZAIhgr+BY0NwdnEw6UjOR8
 lWBP8qhIhWHHSlSVCT9/XM0Ljf2FLP5XM5Znk/MQPSMQ45rPooXXwP+pbPSZO49BBSrEw=
X-Received: by 2002:a05:6000:26d2:b0:482:c676:8d04 with SMTP id
 ffacd0b85a97d-48586083bf6mr1278729f8f.18.1788446597979; 
 Thu, 03 Sep 2026 07:43:17 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 05/25] parallels: Limit search in parallels_mark_used to
 the last marked cluster
Date: Thu,  3 Sep 2026 16:41:23 +0200
Message-ID: <20260903144143.2328870-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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


