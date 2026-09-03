Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61DBC624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28f4-0002g6-Dz; Thu, 03 Sep 2026 10:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28es-0002cj-Nb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28er-0003yl-2U
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so27643035e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446595; x=1789051395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ge1jeswhVctr5Jsow25jpgxpoGxNOiJ1+3Iq4dhUSxM=;
 b=bW3oXd+hxg99A2efbeur9v0hH3uT5k51Dy4AM1O9RNWuddDh3dyoaodmDqBpEoAqk+
 Bg9a+5RRXKUFc0jbbdWwzDNICWlH/sZBMIx0ifsFFrSAbPlZoUO5UxmtbFkuMeFsiejg
 I0Fws6QzhCPwEGUtD5/zQlj+aNv43MvNCcasYSzLoo3KirBviPM7sHyGxZO43wZwsHDt
 //F8ebgx0E1W3CMHasIqmWFh/c324/E+FM84kmOfcALcNlRdcs+8VXCevUylnoQ8i1ic
 s/Fu9FyE7YNI1UB/4jYBpTiE3CNEE60Voh19MPLWSn+7RniL4K2LqphEAUMApfqky38S
 UrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446595; x=1789051395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ge1jeswhVctr5Jsow25jpgxpoGxNOiJ1+3Iq4dhUSxM=;
 b=ZTdfgPwU2I02QYaYuT3NkBqpv8jAE4RA4DW6ooAJVA7ECOQWbPWDgOw2MCa3UIg7U2
 w2XWeOUjJuD6DMVV+o01Q+o5b90Nemj8MMtJfHzXysuYWPNSpgszAQByhNDsatDutVGo
 b78wI/2GHXGUQZoUc6nDN3Rxo2LB3K8g4qycYlwtHgKN7bT175gEumWusbTbPeea3io4
 wFFQq/RMkTLGkjj1j3EZ5LcHW3ltRRG2Q7XgAlvYkvwocdlMTQAO0vMkwvOm0D/qfASJ
 wmY6XOZv5S2oK4grfn0Qd8WSyPDj551AfXnDeEeRIqLH+nK2T8EES274N4AIZVfuWmER
 dGYw==
X-Gm-Message-State: AFuF++nsd8xl4OqQMGgyyeRF8qgsCYjjatSzIJYoV5DDxyF9x3ne7DxK
 YvfqLbTfeuuhqGDAWSe+0g+nl6quaDc725+bEw5C000awbvv4Q6Zjjdgd1+Z7zT1aASGRXEoAnb
 7rtly
X-Gm-Gg: AYBFou0xTRpwirHIvmjNS19xrnKE9fZdiAdEtYBwyb9QxwFKL7bilVHUR15AT59+lcS
 JvynmHuURGKmNWQfRxPWb6dRGHoNt1lP3VsA9fOqFlb/yE8JncO5Y4v8AuPM+GK2yVH+M5fmOGR
 1JAgdQhV9ds/HxcqQi8isIzfzNsOICxRR31W//juNSwn+aKA+ZkTrd/G8aoavx5RBMGihQG08rS
 BREzmHVQ4RU5VWBuDSxJItkZ185dPJ+5XajU7Zt44DGGo9HJatf4WmhRYYY8neSE7gKzXhjZBBk
 25b21hzcMClbLm1L9VSRRwDTFgXCHRIx7CpIJsESaOopCVC7nluT5VjNOfy56IR+em5VwCQKfL+
 kffhiEeWBJNIdRp3DX9l79sshQXigVThfRrZpMpF367PqeLOSJBmLmo9k0kGSwPS03PEJBhzw6y
 CwO7GdalaPH3zjaGiFuAUZVh913TYLOR6m85IzeGYiQFGyYPi/QaBhqTmq
X-Received: by 2002:a05:600c:8b88:b0:49c:e1cd:536 with SMTP id
 5b1f17b1804b1-49ce584b899mr227465065e9.12.1788446594558; 
 Thu, 03 Sep 2026 07:43:14 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:13 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 02/25] parallels: split inactivation out and add the
 activation counterpart
Date: Thu,  3 Sep 2026 16:41:20 +0200
Message-ID: <20260903144143.2328870-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
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

We are going to add parallels image extensions storage and need a
separate function for the inactivation code, which parallels_close()
carries inline today. Move it into parallels_inactivate() and register
it as .bdrv_inactivate, so the image is written out when the node is
inactivated and not only when it is closed.

The condition guarding the old call moves inside, as the handler is now
reached for any node: bdrv_inactivate_recurse() calls it and
blockdev-set-active can ask for it at any time. There is nothing to
write out for a node we can not write to, and trying turns a request
which has nothing to do into "Failed to inactivate node:
Operation not permitted".

Clearing the in use flag now needs someone to set it again.
parallels_open() is the only place doing that, and it does not run when
a node is made active again, which would leave an image whose header
says it was closed correctly while it is open for writing: a crash then
looks like a clean shutdown and the repair on open is skipped. Add
parallels_co_invalidate_cache(), the counterpart of the above, which
arms the flag again and reports through errp when it can not.

The flag may only be cleared once everything which can still fail has
succeeded, as a failed inactivation leaves the node writable and the
image has to keep saying so. The order is therefore the reverse of the
code being moved: truncate first, write the header last and answer with
the result of that write instead of ignoring it.

The migration blocker stays, though its comment asks for it to go once
an activate method exists. An activated node needs more than the in use
flag to be correct, as the used cluster bitmap describes the image as
it was before the handover.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 94692275c9..f02ad7a0be 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1481,6 +1481,41 @@ fail:
     return ret;
 }
 
+static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int ret;
+
+    if (!(bs->open_flags & BDRV_O_RDWR) || (bs->open_flags & BDRV_O_INACTIVE)) {
+        return 0;
+    }
+
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
+                        PREALLOC_MODE_OFF, 0, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    s->header->inuse = 0;
+    return parallels_update_header(bs);
+}
+
+static void coroutine_fn GRAPH_RDLOCK
+parallels_co_invalidate_cache(BlockDriverState *bs, Error **errp)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int ret;
+
+    if (!(bs->open_flags & BDRV_O_RDWR)) {
+        return;
+    }
+
+    s->header->inuse = cpu_to_le32(HEADER_INUSE_MAGIC);
+    ret = parallels_update_header(bs);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to mark the image in use");
+    }
+}
 
 static void parallels_close(BlockDriverState *bs)
 {
@@ -1488,14 +1523,7 @@ static void parallels_close(BlockDriverState *bs)
 
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
-        s->header->inuse = 0;
-        parallels_update_header(bs);
-
-        /* errors are ignored, so we might as well pass exact=true */
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                      PREALLOC_MODE_OFF, 0, NULL);
-    }
+    parallels_inactivate(bs);
 
     parallels_free_used_bitmap(bs);
 
@@ -1533,6 +1561,8 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_check              = parallels_co_check,
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
+    .bdrv_co_invalidate_cache   = parallels_co_invalidate_cache,
+    .bdrv_inactivate            = parallels_inactivate,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.53.0


