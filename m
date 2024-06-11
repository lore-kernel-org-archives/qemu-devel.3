Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BA2C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5Qv-00008T-ST; Tue, 11 Jun 2024 13:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qu-000078-GW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qs-0008Ua-NE
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718127438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJaqIGhVpINR8HgGtOg7iThzOx8v1LlBfHCauXsWLWw=;
 b=Iuh9DGiFcPz5A5kK+yeR1de8Hcmo2DtmRBs3Kn4qpQ+vQCTxgv/yP/LxkBHH0suhRlZZZp
 ZoWHl1TL6+0yMnkq+wh2Elwv8G2VgEuLPVUqOOJtskj601lBqBnli7Vv4ydvpuzgRsTlej
 vVkrhs8tPemIgeohty9vmVSOflHOq2E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-Mwc_56U2NX-uHg2rhw68ZA-1; Tue,
 11 Jun 2024 13:37:13 -0400
X-MC-Unique: Mwc_56U2NX-uHg2rhw68ZA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DFA31956086; Tue, 11 Jun 2024 17:37:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.130])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0123E19560AF; Tue, 11 Jun 2024 17:37:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 4/8] qemu-io: add cvtnum() error handling for zone commands
Date: Tue, 11 Jun 2024 19:36:54 +0200
Message-ID: <20240611173658.231831-5-kwolf@redhat.com>
In-Reply-To: <20240611173658.231831-1-kwolf@redhat.com>
References: <20240611173658.231831-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

cvtnum() parses positive int64_t values and returns a negative errno on
failure. Print errors and return early when cvtnum() fails.

While we're at it, also reject nr_zones values greater or equal to 2^32
since they cannot be represented.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Sam Li <faithilikerun@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240507180558.377233-1-stefanha@redhat.com>
Reviewed-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.45.2


