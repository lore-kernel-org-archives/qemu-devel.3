Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF36C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 18:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4PCd-0006iX-7D; Tue, 07 May 2024 14:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s4PCa-0006hQ-Es
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s4PCX-0005pi-Tt
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715105164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+UjO/ht9tVlihuhzYU+Y1fKToV8y7egqHaB0TByGeBY=;
 b=i9jb78ih8x3BYh8IYfActOrsz3aylgDHf97cudBJfmvo5o+1iNei7R9PRiZNU1ze2WEKBW
 CTPr8FS11wbj1+cIGiOZ8wPXS7Qw4aV74VZOpYoWlFk2+s1QqgT5bigTs33Y5G7e2viLqY
 yTnDRBRxkCqWDyd9HtEK6C64e6viNgU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-xlR28XOMO9a6guFqQnSyFQ-1; Tue,
 07 May 2024 14:06:01 -0400
X-MC-Unique: xlR28XOMO9a6guFqQnSyFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E937029AC009;
 Tue,  7 May 2024 18:06:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D917200AF76;
 Tue,  7 May 2024 18:05:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: <qemu-block@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH] qemu-io: add cvtnum() error handling for zone commands
Date: Tue,  7 May 2024 14:05:58 -0400
Message-ID: <20240507180558.377233-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

cvtnum() parses positive int64_t values and returns a negative errno on
failure. Print errors and return early when cvtnum() fails.

While we're at it, also reject nr_zones values greater or equal to 2^32
since they cannot be represented.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Sam Li <faithilikerun@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-io-cmds.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index f5d7202a13..e2fab57183 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1739,12 +1739,26 @@ static int zone_report_f(BlockBackend *blk, int argc, char **argv)
 {
     int ret;
     int64_t offset;
+    int64_t val;
     unsigned int nr_zones;
 
     ++optind;
     offset = cvtnum(argv[optind]);
+    if (offset < 0) {
+        print_cvtnum_err(offset, argv[optind]);
+        return offset;
+    }
     ++optind;
-    nr_zones = cvtnum(argv[optind]);
+    val = cvtnum(argv[optind]);
+    if (val < 0) {
+        print_cvtnum_err(val, argv[optind]);
+        return val;
+    }
+    if (val > UINT_MAX) {
+        printf("Number of zones must be less than 2^32\n");
+        return -ERANGE;
+    }
+    nr_zones = val;
 
     g_autofree BlockZoneDescriptor *zones = NULL;
     zones = g_new(BlockZoneDescriptor, nr_zones);
@@ -1780,8 +1794,16 @@ static int zone_open_f(BlockBackend *blk, int argc, char **argv)
     int64_t offset, len;
     ++optind;
     offset = cvtnum(argv[optind]);
+    if (offset < 0) {
+        print_cvtnum_err(offset, argv[optind]);
+        return offset;
+    }
     ++optind;
     len = cvtnum(argv[optind]);
+    if (len < 0) {
+        print_cvtnum_err(len, argv[optind]);
+        return len;
+    }
     ret = blk_zone_mgmt(blk, BLK_ZO_OPEN, offset, len);
     if (ret < 0) {
         printf("zone open failed: %s\n", strerror(-ret));
@@ -1805,8 +1827,16 @@ static int zone_close_f(BlockBackend *blk, int argc, char **argv)
     int64_t offset, len;
     ++optind;
     offset = cvtnum(argv[optind]);
+    if (offset < 0) {
+        print_cvtnum_err(offset, argv[optind]);
+        return offset;
+    }
     ++optind;
     len = cvtnum(argv[optind]);
+    if (len < 0) {
+        print_cvtnum_err(len, argv[optind]);
+        return len;
+    }
     ret = blk_zone_mgmt(blk, BLK_ZO_CLOSE, offset, len);
     if (ret < 0) {
         printf("zone close failed: %s\n", strerror(-ret));
@@ -1830,8 +1860,16 @@ static int zone_finish_f(BlockBackend *blk, int argc, char **argv)
     int64_t offset, len;
     ++optind;
     offset = cvtnum(argv[optind]);
+    if (offset < 0) {
+        print_cvtnum_err(offset, argv[optind]);
+        return offset;
+    }
     ++optind;
     len = cvtnum(argv[optind]);
+    if (len < 0) {
+        print_cvtnum_err(len, argv[optind]);
+        return len;
+    }
     ret = blk_zone_mgmt(blk, BLK_ZO_FINISH, offset, len);
     if (ret < 0) {
         printf("zone finish failed: %s\n", strerror(-ret));
@@ -1855,8 +1893,16 @@ static int zone_reset_f(BlockBackend *blk, int argc, char **argv)
     int64_t offset, len;
     ++optind;
     offset = cvtnum(argv[optind]);
+    if (offset < 0) {
+        print_cvtnum_err(offset, argv[optind]);
+        return offset;
+    }
     ++optind;
     len = cvtnum(argv[optind]);
+    if (len < 0) {
+        print_cvtnum_err(len, argv[optind]);
+        return len;
+    }
     ret = blk_zone_mgmt(blk, BLK_ZO_RESET, offset, len);
     if (ret < 0) {
         printf("zone reset failed: %s\n", strerror(-ret));
-- 
2.45.0


