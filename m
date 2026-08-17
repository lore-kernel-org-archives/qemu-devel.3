Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26500C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2Z7-00063W-R9; Mon, 17 Aug 2026 15:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yr-0005zm-6d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yn-0006MJ-40
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so35286085e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993187; x=1787597987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ge1jeswhVctr5Jsow25jpgxpoGxNOiJ1+3Iq4dhUSxM=;
 b=XhsmBffP54nyKnIDG2jftfIDEeBFfhZsNC1Z2f2IhhQ5wautog60HiN08uQxxciV0S
 /NKIEla0u9vVW5sXIDDWn3ceLORU2Pv4fB3elw9KBbDqejTY/YxpMobQAgyCP6nWcehL
 4nPsYQeVKXhI19xbxiGILFP1p3HMvWDXRylQJwC1fGfmU4w5qIdq5PWy2w+y4wD63ZtD
 jJIGD/GtgE2uQnW5B85CztanJXIxpdOf4W1z7mj/U/pwM6vFy2PdsaSFDGtAERHxcYCr
 d/49+ZDjvqp6nU2mhkhk4cYOgyMBKogXXSq5XLiP/m+DSU6tns9uf25d2mcPB4N2nfzd
 eZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993187; x=1787597987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ge1jeswhVctr5Jsow25jpgxpoGxNOiJ1+3Iq4dhUSxM=;
 b=l1AbYaSMJ/CUBfUtngFFAdL1lKsMOvKd3p/UdNWXPEQnhTcAQTXbF6rU39z+nmDvXJ
 O0Z2d4vgyWODTElSqo8QsyxjiheVea55XMRbMYxrCVw/i84DqA5ysbkF2xIiNofDDHU1
 LQXcc5K/bGwYy/Y9C6hx6x8NzRn5w6IQlNQRcGeYJMVjh9ClPoD3woAWrVQo4Qbf82vK
 /aK9nQZUFSNudp1TAKa6mGTbSlpnYlyMc/1ukuZB4m8ZAyQjbseoy+7IteyLx5phkpLs
 GuwzERoXZphbZ9NLQk4Z9E/xJ/SHvepvoNmJ6EteQIOZcdJZwOPwpNuOCXA7ZqA98I1Z
 tU8w==
X-Gm-Message-State: AOJu0Yz0iqM2Ont8DXKC86L5yWVSHGvghJrGukYmVKKToZl2xFqh48Sk
 ILL/4RRcW/n28PVd+ME1+nC63jB0efbPNDCdSOy4cdIPwOEUPmc6n467gH8iB1rvofOqlIKWNhC
 ApQPl
X-Gm-Gg: AR+sD12/PX3bLQqqa/REvqn9LfJ8yXz233luFLjKe4++i6Q+HBbBV3fjfDvy/RMZ849
 77w0mak72dpwYOxi32DpGfIae2s5PDh4A31KuxY1BYZCy7e/w4ALt2mpQwPIiTpFSaEKVAQsGDn
 uEPlxStgbmToMR04Nijnksiyba9z0FrzaGwZoQqm+5H9Zv+WVM7GzyC9J1BQNKMyWqG6N1TDMxf
 ES9R/uuiP55l/6/9Y/nFwjt9DN1ium5kqmmoY+9bjuS+Fp/41rjV2YPPcFaNKQ+v8S4P5xTo/6L
 +bN/sj15ZfRxU3CGWvnfpAs9arYZnboOe4e9GMlR5//Sn/mIdJ0g7slNaZf3+XsiVQ739b4oVMm
 ttzzmje4aaYsc9bSll8jNbX4LqUJ0ETJlfsD+DPK/aM58aM7cnQIvzseJoU17/BVK3sgH40RshM
 aXMwCTP8jn+SA79Aiu4drEYELI9RrL5dgFLdU/0WS9eWRmpigJyjJiaaxezPhg
X-Received: by 2002:a05:600c:1387:b0:499:81ae:1020 with SMTP id
 5b1f17b1804b1-49987971c60mr305940965e9.11.1786993187240; 
 Mon, 17 Aug 2026 11:59:47 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:46 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 02/25] parallels: split inactivation out and add the
 activation counterpart
Date: Mon, 17 Aug 2026 20:59:19 +0200
Message-ID: <20260817185942.1065143-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
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


