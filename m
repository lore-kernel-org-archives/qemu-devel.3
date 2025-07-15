Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52FBC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublZ9-000512-HC; Tue, 15 Jul 2025 15:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxO-0004CS-Ma
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxM-0001RX-I1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NhuAW73W93wsBq/i0J12yeR0nN/1/SZBmn64E0RS5A=;
 b=P8cck4ZADp2AR3pM8caVYeoMtRCuAGS47oSjvErU1cv/77GnHWwv88wU16DBOM7hB8odpA
 tc2mDlZiw2Osn5bNe4jjoaMlFy6gU62qp4VHGcUvIua3Quity8eyMWI5iFjCaON5nMtcek
 a/ROehxZtCAn0IGVGjScFRu2MJK4CNM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-7xOFwz53PGCAQ2b7K2TJcw-1; Tue,
 15 Jul 2025 15:04:46 -0400
X-MC-Unique: 7xOFwz53PGCAQ2b7K2TJcw-1
X-Mimecast-MFC-AGG-ID: 7xOFwz53PGCAQ2b7K2TJcw_1752606285
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5962E180120B; Tue, 15 Jul 2025 19:04:45 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C138197702C; Tue, 15 Jul 2025 19:04:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 32/57] qemu-img: create: convert img_size to signed,
 simplify handling
Date: Tue, 15 Jul 2025 21:03:05 +0200
Message-ID: <20250715190330.378764-33-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

Initializing an unsigned as -1, or using temporary
sval for conversion is awkward.  Since we don't allow
other "negative" values anyway, use signed value and
pass it to bdrv_img_create() (where it is properly
converted to unsigned), simplifying code.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250531171609.197078-3-mjt@tls.msk.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e676602fc7..6750d0657c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -511,7 +511,7 @@ static int64_t cvtnum(const char *name, const char *value)
 static int img_create(int argc, char **argv)
 {
     int c;
-    uint64_t img_size = -1;
+    int64_t img_size = -1;
     const char *fmt = "raw";
     const char *base_fmt = NULL;
     const char *filename;
@@ -582,13 +582,10 @@ static int img_create(int argc, char **argv)
 
     /* Get image size, if specified */
     if (optind < argc) {
-        int64_t sval;
-
-        sval = cvtnum("image size", argv[optind++]);
-        if (sval < 0) {
+        img_size = cvtnum("image size", argv[optind++]);
+        if (img_size < 0) {
             goto fail;
         }
-        img_size = (uint64_t)sval;
     }
     if (optind != argc) {
         error_exit("Unexpected argument: %s", argv[optind]);
-- 
2.50.1


