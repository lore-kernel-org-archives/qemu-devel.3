Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FB9CA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxW0-0007K1-LZ; Wed, 30 Sep 2026 12:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVW-0006QG-H3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:17 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVQ-0003Vf-WD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:10 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so24343335e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787007; x=1791391807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=arxabVZu3G5gPytGTqP4ECM41QbAg7PaAj4k4dx1Ulc=;
 b=NjiJ+sgP3jwVuh9XemDVcRT7+gbUDoXtB1W1DjmH9GRQD00EYwt18rp2jakknBNUv7
 FE97jtKPcDgGHgEfV76YEAxyk35vixBape2hhWzXBeiX7yKPytctBlZxl2RIQYLI7p9g
 608sbF41cyt4XjizsGPmVTsNKy4sDz1MbY3Xneh72X/wQdsG8derG8F/aTr6FRu7swBO
 bgzsIawXRcZ1AlEtU4trmJlbBuUYBWMeH8wS0uzsuU7bD+ZiUrLbw2LfGli4FrlJ6bgz
 jsLiN+F3Agf4TvUoWkaH16205g46PDPyTuoCU33RQmFUAf9AB/e0ba7FVSm/WcjuCMB4
 nddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787007; x=1791391807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=arxabVZu3G5gPytGTqP4ECM41QbAg7PaAj4k4dx1Ulc=;
 b=P+vf9kij/LL57vx8nYGIRBTYtCJP9gggjqjZUT8DhzfPDWtW+D0OkOixNBYleCcaOo
 dzB/ckcnlHFYkmeGOwIvAeXWBmJ4lCvgvSy4LhAvav0LjZ6PGE1tlMtTHHBp9tPx8Uok
 l50o4PtOc1TecWZQ3ZW1NKuLuixu5Hnb5pullSdQykORkRENUw3LN/mpqv6lKod4yH3s
 YwPodNieAoQrC2o+LUVYTNROkNizaUjdl/IaSiWmwwSQ2Fzp9UOUZQUKFWvOaE0z5hVs
 D0qumFKS2qDXyxcpgtLj5i3HE7bdFyJDNg3Z/+zlN3snMBv0IOho6IsRfY1rDSiTeSL2
 K4Pg==
X-Gm-Message-State: AFuF++mJmW0Ur4TVxO9dag0OqXqUIGhJ5WfOcX0yL8NNS4RzoFuxmeFd
 teFXMoVTuhOal2PYXJkAqaXpoxVi2zynwV08N8LMavm0W6VBzNfXlr+VGKq5UurEtaIKbw4vdBt
 GcybJ
X-Gm-Gg: AYBFou2OAxPjMGa0GbncyIsfNkcRQVBS9kzKMQ48D9csZ1HbI5qYH6JSABoFy8dL0im
 eu0co2VyScPAvTtohaHL6mr53OVZN5Bi0lWU/THxsnHd/y8iPLdrwXBjDW69Yxc8HWRWnd2qVlV
 LbzBRjPfAAfLpVWOEyATtKoFBJz6+UvXZ+yawGIXKcTE7+rtStcJ9meWLEUXKnUW6tSM8J1UFz0
 AaKN5S1lOO1Sod5uni5g2d/VoELs1Qwr7vcVKoPO3bzEcrXG7Pq2EVdT9OjGFrPe8Z9LPzJZ+tW
 T01XNWx0osZCvSfd3XFenGsTywa8sLxBGyoIM2sQp4nfXLlzmDkW9SCDnV/RhfK3kdrdeK/dIpO
 /+Qf2+22CllKJhwThl2L0q5vOLVXGcfU5H3khHaq10Sg/8GVRg/Qcb71pOfIDVL2tj4sB+Xsqc3
 tpZdEJOpRVOU8nFNeaKud99ECpOBfo8mBmNfsxpnxOsswQJ8nnpHQ7YfZtbV5fZMXDqAc=
X-Received: by 2002:a05:600c:800e:b0:49f:ff6b:bc82 with SMTP id
 5b1f17b1804b1-4a01b00d9a1mr34465385e9.20.1790787007487; 
 Wed, 30 Sep 2026 09:50:07 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 03/13] block/preallocate: collect the state assignments in one
 place
Date: Wed, 30 Sep 2026 18:49:49 +0200
Message-ID: <20260930165000.303236-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The filter invalidates or re-establishes data_end, zero_start and
file_end together in six places, each spelling out the same chained
assignment. Put them in one function, so that a change to what the
state consists of is one edit rather than six.

No functional change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: qemu-stable@nongnu.org
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/preallocate.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index 99bd6b1ae7..8cd98684f4 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -104,6 +104,11 @@ static QemuOptsList runtime_opts = {
     },
 };
 
+static void preallocate_set_state(BDRVPreallocateState *s, int64_t v)
+{
+    s->file_end = s->zero_start = s->data_end = v;
+}
+
 static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
                                     BlockDriverState *child_bs, Error **errp)
 {
@@ -149,7 +154,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
      * s->data_end and friends should be initialized on permission update.
      * For this to work, mark them invalid.
      */
-    s->file_end = s->zero_start = s->data_end = -EINVAL;
+    preallocate_set_state(s, -EINVAL);
     s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
@@ -480,12 +485,12 @@ preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
 
     ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
     if (ret < 0) {
-        s->file_end = s->zero_start = s->data_end = ret;
+        preallocate_set_state(s, ret);
         return ret;
     }
 
     if (has_prealloc_perms(bs)) {
-        s->file_end = s->zero_start = s->data_end = offset;
+        preallocate_set_state(s, offset);
     }
     return 0;
 }
@@ -508,7 +513,7 @@ preallocate_co_getlength(BlockDriverState *bs)
     ret = bdrv_co_getlength(bs->file->bs);
 
     if (has_prealloc_perms(bs)) {
-        s->file_end = s->zero_start = s->data_end = ret;
+        preallocate_set_state(s, ret);
     }
 
     return ret;
@@ -539,7 +544,7 @@ preallocate_drop_resize(BlockDriverState *bs, Error **errp)
      * change the child, so mark all states invalid. We'll regain control if a
      * parent requests write access again.
      */
-    s->data_end = s->file_end = s->zero_start = -EINVAL;
+    preallocate_set_state(s, -EINVAL);
 
     bdrv_child_refresh_perms(bs, bs->file, NULL);
 
@@ -566,8 +571,8 @@ preallocate_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared)
     if (can_write_resize(perm)) {
         qemu_bh_cancel(s->drop_resize_bh);
         if (s->data_end < 0) {
-            s->data_end = s->file_end = s->zero_start =
-                bs->file->bs->total_sectors * BDRV_SECTOR_SIZE;
+            preallocate_set_state(s,
+                    bs->file->bs->total_sectors * BDRV_SECTOR_SIZE);
         }
     } else {
         qemu_bh_schedule(s->drop_resize_bh);
-- 
2.53.0


