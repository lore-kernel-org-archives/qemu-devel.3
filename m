Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986FCC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TPv-0001Rk-EA; Tue, 01 Sep 2026 14:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TPl-0001NL-D5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TPj-0006Hu-0K
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788288054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EL/B7zBD0Qp4v2yATtywqiaHdynhOiy6CLDynKAMTOY=;
 b=b3Fzu20QMBUG29sjrh/Nc4NdA25aMuf257So7R/adJzjMYLPwa85652YVuYlsGeqTqyxuG
 2P1+yMHHzHXQ1yghb3Rj66Mnj4Lf9fTknwQz4gOgOvC5qOBkSLxRbKw3scar8PQ4IL/lxl
 kMxh5bQ0H+7Yq4ikTNAgspnL5rvYqqk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-xcrdmZjZO1KX2g4-OYoueQ-1; Tue,
 01 Sept 2026 14:40:48 -0400
X-MC-Unique: xcrdmZjZO1KX2g4-OYoueQ-1
X-Mimecast-MFC-AGG-ID: xcrdmZjZO1KX2g4-OYoueQ_1788288047
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D6D51801318; Tue,  1 Sep 2026 18:40:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 549DC1955F72; Tue,  1 Sep 2026 18:40:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Niklas Cassel <cassel@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PULL 1/3] file-posix: fix cache.direct=on check for zoned block
 devices
Date: Tue,  1 Sep 2026 14:40:40 -0400
Message-ID: <20260901184043.728292-2-stefanha@redhat.com>
In-Reply-To: <20260901184043.728292-1-stefanha@redhat.com>
References: <20260901184043.728292-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Niklas Cassel <cassel@kernel.org>

For zoned block devices with SWR zones, the order of the writes must be
maintained to avoid write not at write pointer errors.
Thus, cache.direct=on must be used to bypass the page cache, since the
page cache uses write-back caching, where the physical order of the writes
is not guaranteed.

There is already a check for cache.direct=on in raw_open_common(),
however, this check is done before raw_refresh_zoned_limits() has been
called (which initializes bs->bl.zoned), so it is currently dead code.

Fix this by moving the check to raw_refresh_zoned_limits(), such that the
check is done after bs->bl.zoned has been initialized.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Fixes: 774c726ceb2a ("block: add zoned BlockDriver check to block layer")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Message-ID: <20260617133658.2022750-1-cassel@kernel.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3c985da94f5..01037f4b5c3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -793,18 +793,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
             goto fail;
         }
     }
-#ifdef CONFIG_BLKZONED
-    /*
-     * The kernel page cache does not reliably work for writes to SWR zones
-     * of zoned block device because it can not guarantee the order of writes.
-     */
-    if ((bs->bl.zoned != BLK_Z_NONE) &&
-        (!(s->open_flags & O_DIRECT))) {
-        error_setg(errp, "The driver supports zoned devices, and it requires "
-                         "cache.direct=on, which was not specified.");
-        return -EINVAL; /* No host kernel page cache */
-    }
-#endif
 
 #ifdef __FreeBSD__
     if (S_ISCHR(st.st_mode)) {
@@ -1455,6 +1443,16 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     }
     bs->bl.zoned = zoned;
 
+    /*
+     * The kernel page cache does not reliably work for writes to SWR zones of
+     * zoned block devices because it can not guarantee the order of writes.
+     */
+    if (!(s->open_flags & O_DIRECT)) {
+        error_setg(errp, "The driver supports zoned devices, and it requires "
+                         "cache.direct=on, which was not specified.");
+        goto no_zoned;
+    }
+
     ret = get_sysfs_long_val(st, "max_open_zones");
     if (ret >= 0) {
         bs->bl.max_open_zones = ret;
-- 
2.55.0


