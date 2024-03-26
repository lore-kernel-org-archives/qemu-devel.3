Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138F3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KN-0004dI-9e; Tue, 26 Mar 2024 03:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KL-0004d4-TB
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KK-0005Ly-Ds
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpboykxMXozd2FPNmZskFONa6Y0t8ZYUDyxC1MW6nEQ=;
 b=XJpSypB+disKIJNVeKq/DWcd4NGncjgOU6Y+g9IRXoPyPYStDVjHC53frYwJsGMErpmFga
 1Q64Ic80fATH8VWKOSnEFilefFdSQZBRUILGHiKEwsWDcWGWojg2K35PjFnsEME8U4SN5+
 8tvou9JfkxQvqA5xX6kaNPL2HJBT5YU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-tPfiWpYZOU6gocVCBdbTOg-1; Tue,
 26 Mar 2024 03:34:26 -0400
X-MC-Unique: tPfiWpYZOU6gocVCBdbTOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9663A1C02C9E;
 Tue, 26 Mar 2024 07:34:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75ED0111F3C6;
 Tue, 26 Mar 2024 07:34:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D5D121E657E; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 02/20] qapi: Resync MigrationParameter and MigrateSetParameters
Date: Tue, 26 Mar 2024 08:34:02 +0100
Message-ID: <20240326073420.738016-3-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enum MigrationParameter mirrors the members of struct
MigrateSetParameters.  Differences to MigrateSetParameters's member
documentation are pointless.  Clean them up:

* @compress-level, @compress-threads, @decompress-threads, and
  x-checkpoint-delay are more thoroughly documented for
  MigrationParameter, so use that version for both.

* @max-cpu-throttle is almost the same.  Use MigrationParameter's
  version for both.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240322135117.195489-3-armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index bebe9f71ba..744d05f364 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -966,16 +966,26 @@
 # @announce-step: Increase in delay (in milliseconds) between
 #     subsequent packets in the announcement (Since 4.0)
 #
-# @compress-level: compression level
+# @compress-level: Set the compression level to be used in live
+#     migration, the compression level is an integer between 0 and 9,
+#     where 0 means no compression, 1 means the best compression
+#     speed, and 9 means best compression ratio which will consume
+#     more CPU.
 #
-# @compress-threads: compression thread count
+# @compress-threads: Set compression thread count to be used in live
+#     migration, the compression thread count is an integer between 1
+#     and 255.
 #
 # @compress-wait-thread: Controls behavior when all compression
 #     threads are currently busy.  If true (default), wait for a free
 #     compression thread to become available; otherwise, send the page
 #     uncompressed.  (Since 3.1)
 #
-# @decompress-threads: decompression thread count
+# @decompress-threads: Set decompression thread count to be used in
+#     live migration, the decompression thread count is an integer
+#     between 1 and 255. Usually, decompression is at least 4 times as
+#     fast as compression, so set the decompress-threads to the number
+#     about 1/4 of compress-threads is adequate.
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
@@ -1042,8 +1052,8 @@
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
 #
-# @x-checkpoint-delay: the delay time between two COLO checkpoints.
-#     (Since 2.8)
+# @x-checkpoint-delay: The delay time (in ms) between two COLO
+#     checkpoints in periodic mode.  (Since 2.8)
 #
 # @block-incremental: Affects how much storage is migrated when the
 #     block migration capability is enabled.  When false, the entire
@@ -1064,8 +1074,8 @@
 #     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
 #     (Since 3.0)
 #
-# @max-cpu-throttle: maximum cpu throttle percentage.  The default
-#     value is 99. (Since 3.1)
+# @max-cpu-throttle: maximum cpu throttle percentage.  Defaults to 99.
+#     (Since 3.1)
 #
 # @multifd-compression: Which compression method to use.  Defaults to
 #     none.  (Since 5.0)
-- 
2.44.0


