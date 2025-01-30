Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647C9C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 20:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdbEe-0002Gr-L4; Thu, 30 Jan 2025 15:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tdbEa-0002GB-Sw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tdbEX-0005Xs-8A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738269231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6U/47y8CubHVDUl3rn7MziF08HzgBtGtl8e569bFio=;
 b=fNFP1RnPU5CwIP2lunOP9dN6+iWAGxQM32rKRC/Naag3LLM/HNL/fR5WAfmrbAN4QzmBEe
 3Dpr3JO5SNAEu+ai+qNRAboOZ4D2a2tbqIbU9rjFFWimpC64OGxOJqDDM2rS8J0usqr9BL
 4xKFE7tvFmn4Yxors8AoGNdYNwFxcLM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-i6acbZWrO9WQjuCD1wO5Jw-1; Thu,
 30 Jan 2025 15:33:46 -0500
X-MC-Unique: i6acbZWrO9WQjuCD1wO5Jw-1
X-Mimecast-MFC-AGG-ID: i6acbZWrO9WQjuCD1wO5Jw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D3BF1955DCB; Thu, 30 Jan 2025 20:33:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90BE41800358; Thu, 30 Jan 2025 20:33:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Denis Rastyogin <gerben@altlinux.org>,
 Leonid Reviakin <L.reviakin@fobos-nt.ru>
Subject: [PULL 1/1] parallels: fix ext_off assertion failure due to overflow
Date: Thu, 30 Jan 2025 15:33:39 -0500
Message-ID: <20250130203339.256630-2-stefanha@redhat.com>
In-Reply-To: <20250130203339.256630-1-stefanha@redhat.com>
References: <20250130203339.256630-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

When ph.ext_off has a sufficiently large value, the operation
le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS in
parallels_read_format_extension() can cause an overflow in int64_t.
This overflow triggers the assert(ext_off > 0)
check in block/parallels-ext.c: parallels_read_format_extension(),
leading to a crash.

This commit adds a check to prevent overflow when shifting ph.ext_off
by BDRV_SECTOR_BITS, ensuring that the value remains within a valid range.

Reported-by: Leonid Reviakin <L.reviakin@fobos-nt.ru>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20241212104212.513947-2-gerben@altlinux.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 23751b28a9..d4bfc44e64 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1298,6 +1298,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         error_setg(errp, "Catalog too large");
         return -EFBIG;
     }
+    if (le64_to_cpu(ph.ext_off) >= (INT64_MAX >> BDRV_SECTOR_BITS)) {
+        error_setg(errp, "Invalid image: Too big offset");
+        return -EFBIG;
+    }
 
     size = bat_entry_off(s->bat_size);
     s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
-- 
2.48.1


