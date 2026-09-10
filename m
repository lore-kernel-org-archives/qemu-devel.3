Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5771C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pnS-0006TE-Sf; Thu, 10 Sep 2026 21:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPc-0001gL-EJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPW-00078x-Rt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so5026545e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083748; x=1789688548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3NKROluHrX0VacEA4l0FH/FI2U2V5K+qKaWUQ7JbxTI=;
 b=fmukhHXjQyZ4VYWMBiEFesVuNeukMLC4UYaIziyr0WNtsWGZJaQsoHBG9zyvb6nAob
 JAAn0YKf6HAttfnKeWHwjyKYhSqc+t58EbvIshGGXpsvqiLkmJ5AtU6Lo31zOsln94FM
 44S0RJgqXXUq6F7kDqnfChaLw5lPk/f4grhZmdV6GTaJMI7li27UEBHf9akUYLGmPElg
 rAtFb7GEhkwy+U1KjczzhXqKVnDpeZIJoncE/zsl2cRuvg0kQzKbN3JWgh9LYUbxR9z3
 vTZ8YKGILtt5wVyX+e2HXW/poAFvhEf3cledVqOD8f3swssakfG0nU3T4NN2r342bbMW
 V97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083748; x=1789688548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3NKROluHrX0VacEA4l0FH/FI2U2V5K+qKaWUQ7JbxTI=;
 b=V1JB8OgmMyTwFm4atjmxGktTvjbYsOc9g+T91kuZfDjJ+WqERbB+Pw4KyegTwcHXZK
 zc2mT2goAFggN84HDmsw8FsbxoqZ/Hz7uzyTfQCStZdw9vf0oQcA40cbMaidH7gEZbdz
 KJ4u5a8NBt4vxANBIo9+qr96BGv4KsFxEAby0PzdH3/PNZaJs5O7fkBI6CtdIcqLKoEL
 GRktTsIfzVW1WXyCTYby4nibg6fz4jFft4nq9cMZ392BHssqisU9+omxdRHRDqMdO48m
 4n4YYR1FmWG+eHFU70wZKXVhnqIUSAXWFYzKvyx/TM3a+hN+jHG0vgd9l3fn++68F1q1
 bMQg==
X-Gm-Message-State: AFuF++l3lcodlgohe91r5b/z1T5QDnHHaFPCiSzwI92oDtwNi1LasBFr
 hEbOJRZZQaiLyEg3oinJek9xuVCTQvIIjqZ0Y3B8jv4Fq5yjMPruwnp7kuWBFdijMPw=
X-Gm-Gg: AYBFou1fAntTqGgwQlf4X5cbySHV2C9q1a2Y+GXKrBX/qMwEIrBi2OproEjOJFRzUWi
 kZUKcp7u6IkUyi6dHgjMKp7cF1FXgwxeaZO4vguyACw6iK/e+YQmFP+XhgZiMe8zjxHh8dYIHik
 wlI6yDB5FCgqAzaRorRMNgCnDeLIZuuvco3lHoNsxiQ8DPVpaq2HxvTEhit9EGXcItB+OxJu6w3
 LJTTdRuUfiHpnZU6NbRVoB6IhSd15NALp7uA5EzbYYASYrdbvgp9GFgGgNshwFjlHfoxVkkkX79
 /xf4qe4i5pi+be1v5sYaIvcLjYRjqVdUY3ac2awXXHH0bMlbd7DBDVqWT5PklZdoRABtVcb2RhZ
 6IFfOR6sd8L7CKVkoxlphYE3p73v4QGInqf0lC3Ouh+OXK48VJIK9XobbuHfEZSsr8jI5HUDdcG
 aKWTGmg1YP6JqwbyHmFD2Dz6FJGP4wx+V8S+dVZ90QnXC9fj7ipYuHBC0tgiqNeiStGAuxQ3Tci
 xDN6Yg=
X-Received: by 2002:a05:600c:8b23:b0:49e:6067:72ff with SMTP id
 5b1f17b1804b1-49e619d1e6amr13987575e9.31.1789083748140; 
 Thu, 10 Sep 2026 16:42:28 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:27 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/29] parallels: bound the bitmap L1 table against the bitmap
 size
Date: Fri, 11 Sep 2026 01:41:56 +0200
Message-ID: <20260910234222.3039975-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
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

parallels_load_bitmap_data() derives the number of bytes to
deserialize from "bm_size - offset" without checking that the offset
is still inside the bitmap, and an offset past the end makes that
subtraction underflow.

The overflow which used to produce such an offset is fixed by
"dirty-bitmap: fix integer overflow in serialization coverage", but
both the cluster size and the L1 contents come from the image, so
refuse the table explicitly. The check cannot reject a valid table:
l1_size is DIV_ROUND_UP(bm_size, limit), so the largest offset the
loop reaches is (l1_size - 1) * limit, always below bm_size.

Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 830ac78a11..63fe4d5b1e 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -76,8 +76,17 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
     buf = qemu_blockalign(bs, s->cluster_size);
     limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
     for (i = 0, offset = 0; i < l1_size; ++i, offset += limit) {
-        uint64_t count = MIN(bm_size - offset, limit);
-        uint64_t entry = l1_table[i];
+        uint64_t count, entry;
+
+        if (offset >= bm_size) {
+            error_setg(errp, "Bitmap L1 table covers more than the bitmap "
+                       "size %" PRIu64, bm_size);
+            ret = -EINVAL;
+            goto finish;
+        }
+
+        count = MIN(bm_size - offset, limit);
+        entry = l1_table[i];
 
         if (entry == 0) {
             /* No need to deserialize zeros because @bitmap is cleared. */
-- 
2.53.0


