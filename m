Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BDBC54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolku-0007rO-PW; Tue, 28 Jul 2026 13:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolks-0007j1-3I
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkn-0005w6-2I
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Z+ME3HvxjOw2pJPB4CxjO6c2ZeZm5FaeOAJrBJZppc=;
 b=duAectRazBWRdCENNpNjo+Hk2ygU/QnS5eVelgD3ZHk6Jix5N42+23hZpu6jdd7mX3ZT1a
 LwWHGizW1VUlpDRm6NGDw7V/OtV6Cy0K2bWk+gOrkhRiiEFhuIXp34uihDbDjLFDtz6z53
 Xv5n+jU+mJ02q34iFDTWdmctSrgOosY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-ZRMN-cIMPhOFtpie4re36w-1; Tue,
 28 Jul 2026 13:37:58 -0400
X-MC-Unique: ZRMN-cIMPhOFtpie4re36w-1
X-Mimecast-MFC-AGG-ID: ZRMN-cIMPhOFtpie4re36w_1785260277
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C2411800352; Tue, 28 Jul 2026 17:37:57 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47D0419560AB; Tue, 28 Jul 2026 17:37:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/17] dmg: reject inconsistent UDRW chunk sector count and
 length (CVE-2026-65928)
Date: Tue, 28 Jul 2026 19:37:29 +0200
Message-ID: <20260728173739.352078-8-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The chunk metadata contains both:
- Sector count: number of 512-byte sectors in the virtual disk
- Length: number of bytes in the image file

The UDRW chunk type indicates uncompressed data that can be accessed
directly. The code is missing input validation to verify that sector
count is consistent with length.

If sector count is larger than length, then read requests can access
beyond the end of the s->uncompressed_chunk buffer. This is an
out-of-bounds heap access that could lead to a crash or an information
leak.

While we're at it, also zero the end of the last sector when length is
unaligned. This prevents information leaks from the
s->uncompressed_chunk buffer.

Fixes: CVE-2026-65928
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3846
Reported-by: boy juju <agx1657748706@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260723144519.364701-4-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/dmg.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/dmg.c b/block/dmg.c
index 6f8120e0338..5d7d3b8901f 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -312,6 +312,21 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
             goto fail;
         }
 
+        /*
+         * Uncompressed chunk length must match sector count. Compressed chunks
+         * are validated during dmg_read_chunk() since the uncompressed size is
+         * not known ahead of time.
+         */
+        if (s->types[i] == UDRW) {
+            if (s->sectorcounts[i] != DIV_ROUND_UP(s->lengths[i], 512)) {
+                error_report("length %" PRIu64 " for chunk %" PRIu32
+                             " is inconsistent with sector count %" PRIu64,
+                             s->lengths[i], i, s->sectorcounts[i]);
+                ret = -EINVAL;
+                goto fail;
+            }
+        }
+
         update_max_chunk_size(s, i, &ds->max_compressed_size,
                               &ds->max_sectors_per_chunk);
         offset += 40;
@@ -722,6 +737,16 @@ dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
             if (ret < 0) {
                 return -1;
             }
+
+            /*
+             * Zero the unread part of the last sector when chunk length is
+             * unaligned to avoid exposing uninitialized memory. Valid image
+             * files may never hit this case, but cover it to be safe.
+             */
+            if (s->lengths[chunk] & 511) {
+                size_t trailing_bytes = 512 - (s->lengths[chunk] & 511);
+                memset(s->uncompressed_chunk + s->lengths[chunk], 0, trailing_bytes);
+            }
             break;
         case UDZE: /* zeros */
         case UDIG: /* ignore */
-- 
2.55.0


