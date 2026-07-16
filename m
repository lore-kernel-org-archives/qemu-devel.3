Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77135C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkKB3-0002S3-Ur; Thu, 16 Jul 2026 07:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkKB1-0002Q7-Qi
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:22:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkKAz-0005EU-Vu
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:22:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so40632625e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784200968; x=1784805768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZDV1Ev+3zB9CQS2nSF+kvUKo9rgUplCzN5eq7uGNPP0=;
 b=VK+48AFoI5a/pDYMbOGriuAlTEiQZPxxuD9L0WDN0nmHCSz2Wbwm6aQ3x6mTBTTasR
 W9YN9BX50oikT7FIDW9NcdXG5fCKK2JEBNwgt7clrI5vOrerg+T112y646vjcvlKRbDC
 RPDYONgYyOemsAl+JiaMRE6RaA6GD6PXlXIzknvszTJEScy4W13gaZedS5QKxQnO2ORe
 7MvCrdpAkgBxYfmWw4eQ7D+yh6oaEL6U2CzK0El6gerwhQrju1eXjA0hrJUhOGRHNPdB
 hC7PXiN0UrvmvoVlwHJY0GCqSWNUV9sN5KgDUnAzNntmjcNqYgNHAaG6E7YZaRwJrkhY
 eL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784200968; x=1784805768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZDV1Ev+3zB9CQS2nSF+kvUKo9rgUplCzN5eq7uGNPP0=;
 b=gNKAKEuOzh62Hz58oeKtLIy4WS2feOm4l2GGjIiJCGGP48wLk2e/3XDdhOS8YVmC1V
 /Ymm0I0FNNO8x0jOfcSV3LL5CftF9j0KfNGVeI89GYV08pprJJ4pnASzX/Yt1QbirYSA
 /C+gPdCBEMETs4vo89Svm0UnOz09zFRknJWq6tDTKZe7wOARq3GdNUNZvTCbObTvehfK
 N4MXYnbmmnrL3BhQvsOwGaRup6KkX59Y6DpKOsOJwj8PQBGQXF5rkgx/fQaL6OONixOZ
 J5Pzo2lT+8Nj6BHJO4EcAYZDc/1y5oqAAImjk+/DXomBsvCTHwXAGtBhyar/sSkfCg9w
 Ux6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq81lUQ0l1fwhr2R8XccENHKZQf4hIhQr/F3M6xKYS1FIWDJf4R7yreW/ywns2vaih9rMRhcw6woBiJ@nongnu.org
X-Gm-Message-State: AOJu0YxBur1iFQGlsXVEv2cecc/n1DErMik6U4HLqXNf7gt305DQoebm
 odfvbAiZxdqn4UV6l6rxcQJVThqdeFAXE++AXXo4xpZI0MlPtzivUh8zPcqCQulLgwI=
X-Gm-Gg: AfdE7cmQZ9RPcaOqc0MvfgF+D2w5JdTUBBkhiD0ukJUIio4Xl41CwTjC0AINmiyd5cQ
 Er2bz1C6BwSnNzi46bjj6ouxIkUq0L1jTXAr6sIPj2NnezI6iq9FnK2l8oOV/Z5MvszM0/rYinG
 jIn/Rh5loKizIuoYQB2rul4onwGTUlVdfqbORkJu72jhoEPdDM9NyDmDjxOcO6QXcUBkM+KPeBw
 ins0F5mxST7MNdZZL6JQB+OiLNhdacQKB4/o1+i50DjC5SFpEFMz7wrVrYLCL42zCw78uayj699
 AxdZD8FK0m3kzVKM+hr1Ku/tV94FhYxNOLKEednAIF4G+qxz0Ix8wNRi95ysOl5K0vLh/+ASORo
 mryvj0Yi5MgMrMd/5SYjL7wCVzMf7lxVEejfkteDPMHLyRP1/AxBXeuUhGYylLWLnH9U7Ol//cD
 c=
X-Received: by 2002:a05:600c:5292:b0:495:40aa:d982 with SMTP id
 5b1f17b1804b1-49540aad9a1mr35567695e9.6.1784200968410; 
 Thu, 16 Jul 2026 04:22:48 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4ca9:146f:3485:e2c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm24019672f8f.24.2026.07.16.04.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:22:48 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 3/3] block/monitor: allow dropping a bitmap never stored on
 disk
Date: Thu, 16 Jul 2026 13:22:42 +0200
Message-ID: <20260716112242.3000035-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716112242.3000035-1-den@openvz.org>
References: <20260716112242.3000035-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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

block-dirty-bitmap-remove refuses any readonly bitmap outright, via
the generic BDRV_BITMAP_RO check in bdrv_dirty_bitmap_check(). That
check cannot tell whether the bitmap is actually on disk, so it also
blocks dropping one that only ever existed in memory, which needs no
write at all.

Drop the blanket check and let qcow2 decide: bdrv_remove_persistent_
dirty_bitmap() already treats an absent on-disk entry as a no-op, so
such a bitmap is now released with no write attempted. For one that
is genuinely stored, qcow2_co_remove_persistent_dirty_bitmap_locked()
now checks can_write() before it would update the on-disk directory,
so removal still fails there, with a message naming the actual
reason instead of just the bitmap's readonly flag.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/monitor/bitmap-qmp-cmds.c                         | 4 ++--
 block/qcow2-bitmap.c                                    | 9 +++++++++
 tests/qemu-iotests/tests/remove-bitmap-from-backing.out | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
index d87ca982aa..aabf2790b6 100644
--- a/block/monitor/bitmap-qmp-cmds.c
+++ b/block/monitor/bitmap-qmp-cmds.c
@@ -165,11 +165,11 @@ BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
         return NULL;
     }
 
-    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_RO,
-                                errp)) {
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY, errp)) {
         return NULL;
     }
 
+    /* Dropping a bitmap needs no write access unless it is actually stored. */
     if (bdrv_dirty_bitmap_get_persistence(bitmap) &&
         bdrv_remove_persistent_dirty_bitmap(bs, name, errp) < 0)
     {
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 256ec99878..ac5a724588 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1487,6 +1487,15 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
         goto out;
     }
 
+    if (!can_write(bs)) {
+        error_setg(errp, "Cannot remove persistent bitmap '%s': "
+                   "no write access to node '%s'", name,
+                   bdrv_get_node_name(bs));
+        ret = -EACCES;
+        bm = NULL;
+        goto out;
+    }
+
     QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
 
     ret = update_ext_header_and_dir(bs, bm_list);
diff --git a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
index fe105fe0a3..628fa737d9 100644
--- a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
+++ b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
@@ -1,6 +1,6 @@
 Trying to remove persistent bitmap from r-o base node, should fail:
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "base"}}
-{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap0' is readonly and cannot be modified"}}
+{"error": {"class": "GenericError", "desc": "Cannot remove persistent bitmap 'bitmap0': no write access to node 'base'"}}
 Remove persistent bitmap from base node reopened to RW:
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "base"}}
 {"return": {}}
-- 
2.53.0


