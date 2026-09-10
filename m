Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C79C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pTO-0007x3-FC; Thu, 10 Sep 2026 20:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPf-0001hs-2T
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:54 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPc-0007Bi-FU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:38 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so1681245e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083755; x=1789688555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ge1jeswhVctr5Jsow25jpgxpoGxNOiJ1+3Iq4dhUSxM=;
 b=TKLJyj5s4XYZbYir+WkemkaDV4LHPC+dfudPjyGGex0mAKfXtNgpYPVGj/vz3FujPr
 90V9UaoROsZqAxT3KvUrJkuAPOgJLu94WdR+VdOZe8bZGWox1xQLL+ZjcRRrvIRFZ2GW
 QLjAc349Y8gL2AWXrEzhhob2YslUN8fwEPbX5zuR2xAcPnRZ9Y9Cj940rC6tPt/TP/+4
 GNTqrDD8XNEAR5jUs+9qiXHzqqfqXa4ItowiWouxDauNwzqcwLhcbctzLTQWDd/PVDjz
 FDZb572rXjI2QDXNa+KhqaFsoYVC23T7aTgvVAHWK9UDw6fdig1h0mlHk9qpRDGmrfD4
 9qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083755; x=1789688555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ge1jeswhVctr5Jsow25jpgxpoGxNOiJ1+3Iq4dhUSxM=;
 b=EIgmW7P2b5r1il7HAWgxyOTzqRrgQKHYfRa/c6f5XWur1VmtlufvPakIlwgCL6RhMP
 WGBdMB2RaJ7yXnD6TcnUDVqKA+mv1NS6qTRxgvSpMcly3JQL50VseavYLYOQFoZjKQvL
 vJ+6GVoiJq8SdCoSKD2//Tqf845l8F4knup8McRjeQKeXHN8VlMO6grOSIqGH4Row0Cx
 W6iqQqIiECTKWtiBuTqy+FYG1rafBKSaAxCYlgUms/e9OwwMAABwgBC9/6RQiM4mxns9
 EbSn+6CPL+PujgexDpGOeeCvFFMAEnXcbMXC9g1FRsh1y8cymj44y9FVzpvoICZslC02
 DhjQ==
X-Gm-Message-State: AFuF++luHd0YaLjEeOb26MGITeBh29pPBH2NKQ0enOlojBoWZkVWi9JA
 ACCSRJmLf5vC8hWisW9gzN9cUEYdNVJlk/Dcj/WcanjTp0W6amDC8E0qsaj2BLpQsWQ=
X-Gm-Gg: AYBFou3WkUvWeTbuXBs2OZFt5SbFTYN4C55fuKFM37JdSoQ1GhfLa4UxSDx4gup6wVK
 XrQxiXC3YgHAmT5fdqoWuTWcl1CFmwJtUzlFFCnfXLuhgX8p6HU59/kIty2I5L2kUNiJjvGfgXZ
 ewPc630acf84C2zR4wE45KiBHLq2G/0BNMnogji6LnYtA/Y/nf/kYudC2/arwsGmMXn/7om4y95
 q9irtRfpHFbQnwSPddfJHy6rpdKKGcUEgO6K56CW0BE6fXPTZx/7CcJkW3R7KvDBtxUBX26hnBk
 Bg433mDeBrbpJZRn4ITQ83JL0Fl9ejtQRjxjbMjy756/RO+yGQdnow3lQA95oFu13NNMQUg+OI7
 y/J7PmUr+bU+f0W9MjEfscrsfjj0wwNlJcue8Ba6meIKDokcN2E7bDtWk6RtEmIzOHWciN/M0fR
 ILogHqayfYF4dS3VjDle/lRr3JR9F50BV5ZO0mdQU1mZ7OB+/e8NfVn9atfmVGa5N4d2r7
X-Received: by 2002:a05:600c:c48f:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49e619831b6mr17217095e9.1.1789083755030; 
 Thu, 10 Sep 2026 16:42:35 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 09/29] parallels: split inactivation out and add the activation
 counterpart
Date: Fri, 11 Sep 2026 01:42:02 +0200
Message-ID: <20260910234222.3039975-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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


