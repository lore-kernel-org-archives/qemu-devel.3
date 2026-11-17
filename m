Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8310606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BhbDXLtJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMp3-0006XP-Bc; Tue, 17 Nov 2026 12:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMou-0006VZ-QX
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMot-0006Xu-C7
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794935890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiebR+41tfkDis4dKbv6PVhs3ti6+XQM//Yxopo4Kng=;
 b=BhbDXLtJ5f8+QS6/28QnC7kP7FmGw7RpIJyYc3bFcH1c9m5mbzkEC4gXe02GQnCjh/en9q
 54qSOHIfDbCliL4FvDZfThDtZL0ItyZbnWzoOb5xLVuoxbuMZ+IT3jSKb6maCihE2KSgln
 rY3+3+gcxH+fUuZqQq8NMLVcU+/69/U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-oa0Rdg12MhaovJ4GD_Hhuw-1; Tue,
 17 Nov 2026 12:18:07 -0500
X-MC-Unique: oa0Rdg12MhaovJ4GD_Hhuw-1
X-Mimecast-MFC-AGG-ID: oa0Rdg12MhaovJ4GD_Hhuw_1794935886
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16A73180059B; Tue, 17 Nov 2026 17:18:06 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8512C195B3C6; Tue, 17 Nov 2026 17:18:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 1/8] block/bochs: validate bitmap size and compute
 extent_blocks after validation
Date: Tue, 17 Nov 2026 18:17:51 +0100
Message-ID: <20261117171758.237462-2-kwolf@redhat.com>
In-Reply-To: <20261117171758.237462-1-kwolf@redhat.com>
References: <20261117171758.237462-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: malike <malike@kylinos.cn>

bochs_open() computes bitmap_blocks using the formula
"1 + (le32_to_cpu(bochs.bitmap) - 1) / 512".  le32_to_cpu() returns
uint32_t, so when bochs.bitmap is zero the subtraction wraps to
UINT32_MAX (0xFFFFFFFF) in unsigned arithmetic, yielding
bitmap_blocks = 8388608 instead of 1.

The bitmap field is read directly from the on-disk image header and was
never validated.  The overflowed bitmap_blocks propagates into
seek_to_sector()'s bitmap_offset calculation, causing reads to target
wrong offsets and return I/O errors or incorrect data.

Add an explicit zero check for bochs.bitmap before the formula.

Also move the extent_blocks calculation to after the existing
extent_size validation.  The same "1 + (x - 1) / 512" pattern applies
to extent, but extent==0 is already caught by the "extent_size <
BDRV_SECTOR_SIZE" check; the calculation is moved after that check for
clarity and robustness, and uses the already-validated s->extent_size
instead of re-reading the header field.

Cc: qemu-stable@nongnu.org
Fixes: a8753c3466dc ("Bochs disk image support")
Signed-off-by: malike <malike@kylinos.cn>
Message-ID: <20261014033419.236057-1-malike@kylinos.cn>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/bochs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/bochs.c b/block/bochs.c
index bfda88017d9..7a8091d47d9 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -167,8 +167,13 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->data_offset = le32_to_cpu(bochs.header) + (s->catalog_size * 4);
 
+    if (le32_to_cpu(bochs.bitmap) == 0) {
+        error_setg(errp, "Bitmap size must not be zero");
+        ret = -EINVAL;
+        goto fail;
+    }
+
     s->bitmap_blocks = 1 + (le32_to_cpu(bochs.bitmap) - 1) / 512;
-    s->extent_blocks = 1 + (le32_to_cpu(bochs.extent) - 1) / 512;
 
     s->extent_size = le32_to_cpu(bochs.extent);
     if (s->extent_size < BDRV_SECTOR_SIZE) {
@@ -188,6 +193,8 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    s->extent_blocks = 1 + (s->extent_size - 1) / 512;
+
     if (s->catalog_size < DIV_ROUND_UP(bs->total_sectors,
                                        s->extent_size / BDRV_SECTOR_SIZE))
     {
-- 
2.56.1


