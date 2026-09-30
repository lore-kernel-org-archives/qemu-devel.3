Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD0FCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxW9-00085L-J4; Wed, 30 Sep 2026 12:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVe-0006cm-SB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:24 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVc-0003ZO-S2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:22 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so42330665e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787019; x=1791391819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gc8btmcgaQ636BUxwTgKPD/UQOCA38WGrDAL/WuGLv8=;
 b=GduSZsFSc0Iml+YLbmKDzKfl4LcDkRPp0Z236oqVyJqG7RfNl1vlywAtzifCGAlzrd
 Kv3JJruGzBSsCY/IprapVQiXd7mnjoSjDTaD++TDnBv7P40Zj8DOXYfpXRhfq09V9ySg
 iFsdNIcyiF120mf4EUedZYgBZflzzRD8yk1n9O5cF1j0m6sUgoPg3yr+yIdZ7J2/sfg/
 MsCBdzPQDBslAfArI0ouwG7DdStSuJk8kClEzcElC4wmsoKr7LE4fEkM7OPxnLrjNj+Y
 SbkX7rN9cKveOKI2ty/PyUXdJJmbxIV4C/zJzApoB1RIz12k9uWMwohcjIlQnMV/WV6o
 jJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787019; x=1791391819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gc8btmcgaQ636BUxwTgKPD/UQOCA38WGrDAL/WuGLv8=;
 b=oa1xW5DcDw5yiu+IUN8gZ9SkRH5qYb+cQjor9lFUwqjPc/xQ9df/p7spJPqpAjJMAO
 wK3Tq7KLv2+4JxCq7zdRb02WyKE0IWBpuC7dxSjcqIAY8BeC4QsYJrQCuaE0SW74CdTY
 pV4KTx+NFfPhZ9j2VLJra0K/VxFrUgRe/GEOb07Tw4OAZA+yPqBuZC259UQ7vuH96giV
 hEuO6lhOO0ia8z+08fMfJ9Y5ubH2SwRxVTwWOtqkz1hkh1Pd9cYTj514koN8R2U+dd2g
 phrGxPBItBC9V6a+k1wbkE/ZQ8gA7c4hXsLE7lH/aARgPvIHhnl1aqP1V6nYBMixgqNg
 l7eQ==
X-Gm-Message-State: AFuF++ma3G2H2otpSUcYR0Zs+4nxUGt+EuCXOc1hAi2+kBdCFZXT41XR
 ZTtmN34xLTknIGFYSqfWjhcVTYesvtQpeQDhOJO2wmESFu8FHu1iWC5P6V7dqgJcEoZ1jcBw0W+
 ssrbj
X-Gm-Gg: AYBFou1W6t3Mj8451Nw1iXbUz6A2Dr0v5JMXL7fcZIsD4TdF6NwSuLJ+CYA/FL7dFSp
 zmHBLT/Ao8AikF4LTPMLy4hJUvorlk4W4fwsgIe0YiVEwLw8gJvvIrhukot21Gd0YnJKQ7yV7IU
 0D+eBhPkobHRLsh6Tm55g44gkO4zSo5Cgm24u43jWQwbBVHSIrE35+NLABySp9Twyl8w6FoNTvQ
 7grzAadG4SwMTJp33nmY6/uHzb91nT4WdJTrVnv7L+rCLGq/T+RhLu6mlCVq10hpTDanaSFKFN1
 6JxG+EVynp2Qy9D+cb8EzrYaW6y68K8AihQhj4N4QkYhceza1C2NeSXIV0RA0bYF159xj5P5fyM
 RIcdCD2L9gcpPFE5D4BIeWQPMWzIUaUEb2MW9rr1ClNHzqDij9Tv97os7+NCIRG0qJlR3/sivSK
 UnDks3bB0mgTy4qrVCZ6dVYtQ2EMbeRveo5vZSF4Y0wjLMF8HS9kCk+q1j70B+uF3hkJk=
X-Received: by 2002:a05:600c:3b10:b0:4a0:c02:938c with SMTP id
 5b1f17b1804b1-4a01b1290f0mr36983705e9.25.1790787018846; 
 Wed, 30 Sep 2026 09:50:18 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:18 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 12/13] block: add blkdebug events for a write before it is
 tracked
Date: Wed, 30 Sep 2026 18:49:58 +0200
Message-ID: <20260930165000.303236-13-den@openvz.org>
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

A breakpoint on pwritev or pwritev_zero stops a request that has
already joined the list of tracked requests, so it is ordered against
everything that arrives later. There was no way to hold a request in
the window before that, which is where a filter has published its
state but the block layer does not yet know the request exists.

Fire pwritev_untracked and pwritev_zero_untracked from
bdrv_co_pwritev_part() once the request counts as in flight and before
tracked_request_begin(). They come in a pair like the events they
mirror, so that a test can tell a preallocation from the writes racing
with it: blkdebug matches on the event, not on the request.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
---
 block/io.c           |  3 +++
 qapi/block-core.json | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index a916b236c3..a32b567264 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2302,6 +2302,9 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     }
 
     bdrv_inc_in_flight(bs);
+    bdrv_co_debug_event(bs, (flags & BDRV_REQ_ZERO_WRITE) ?
+                        BLKDBG_PWRITEV_ZERO_UNTRACKED :
+                        BLKDBG_PWRITEV_UNTRACKED);
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE);
 
     if (flags & BDRV_REQ_ZERO_WRITE) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index aed2888147..340ee8c9e2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3897,6 +3897,13 @@
 #
 # @none: triggers once at creation of the blkdebug node (since 4.1)
 #
+# @pwritev_untracked: a write, before it joins the list of tracked
+#     requests and so before it is ordered against any other request
+#     (since 11.2)
+#
+# @pwritev_zero_untracked: the same for a write zeroes request
+#     (since 11.2)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -3915,7 +3922,8 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write', 'cluster_alloc_space', 'none'] }
+            'cor_write', 'cluster_alloc_space', 'none',
+            'pwritev_untracked', 'pwritev_zero_untracked'] }
 
 ##
 # @BlkdebugIOType:
-- 
2.53.0


