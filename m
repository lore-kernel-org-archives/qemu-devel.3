Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CA0C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TPw-0001SI-Cl; Tue, 01 Sep 2026 14:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TPn-0001OB-D7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TPl-0006K0-8Q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788288056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVmsdH6szw+OzI1T7/k++XjaIUl4aN50H4QCNN8iNw4=;
 b=h0L3trIwqHGMSsIVKcbBuTl0m+Jo336AqKAAf3TrwxATqPv/pl/RY1FyxFa/nARYwcoJZ5
 LOX5qUTzYMpzfMej+cuKD6Nxm17wDr25Wc06yIK27fZVJXy2HpQpYD5YQ1G2V6FkASnzHM
 N9Slc7HjMLl803licvYv6F8xq9j04js=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-CWZZwfKzPoiTR_tpFK0OZg-1; Tue,
 01 Sept 2026 14:40:53 -0400
X-MC-Unique: CWZZwfKzPoiTR_tpFK0OZg-1
X-Mimecast-MFC-AGG-ID: CWZZwfKzPoiTR_tpFK0OZg_1788288052
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1296F180AEE1; Tue,  1 Sep 2026 18:40:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36A201803A67; Tue,  1 Sep 2026 18:40:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Niklas Cassel <cassel@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>
Subject: [PULL 3/3] file-posix: fix zone write granularity assignment for
 zoned block devices
Date: Tue,  1 Sep 2026 14:40:42 -0400
Message-ID: <20260901184043.728292-4-stefanha@redhat.com>
In-Reply-To: <20260901184043.728292-1-stefanha@redhat.com>
References: <20260901184043.728292-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Niklas Cassel <cassel@kernel.org>

In the ZBC and ZAC specifications, the requirement is that the write
granularity matches the physical block size.

However, in the ZNS specification, the requirement is simply that the
write granularity matches the logical block size.

See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a805a4fa4fa376bbc145762bb8b09caa2fa8af48

In Linux, there is a zone_write_granularity sysfs property which abstracts
this away, so let's make use of it.

Currently, it is theoretically possible that QEMU presents an inflated
write granularity for NVMe devices where the physical block size is larger
than the logical block size.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: a3c41f06d5a8 ("file-posix: add tracking of the zone write pointers")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 01037f4b5c3..9aad156aad4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1493,7 +1493,7 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
         bs->bl.max_append_sectors = ret >> BDRV_SECTOR_BITS;
     }
 
-    ret = get_sysfs_long_val(st, "physical_block_size");
+    ret = get_sysfs_long_val(st, "zone_write_granularity");
     if (ret >= 0) {
         bs->bl.write_granularity = ret;
     }
-- 
2.55.0


