Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28D8CF5389
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bG1-0007je-S7; Wed, 23 Oct 2024 09:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFf-0007Ma-HU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFc-0002FW-Md
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7Xdq2MTkGp0eGQVrGv94zTNIl5BzH+CbbEPfqGYkj4=;
 b=Xzxmcbc4k+BRbLELmeR0p2tm3rR1qe6SAnJHsfz1WloDFoDRBOOSgBGzdYekjAbgAtySYj
 6XirLf8soOMgcIFS2UflF27AOeh0mJo1/AL5I+a4pH+PSWRKMc9O7b/f0mGCz4Eb4XlaQU
 g5z5ITDT2p0u0zWVCVvqipAh2uxQmfU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-FRd9asa-O7evNAu_366XBw-1; Wed,
 23 Oct 2024 09:18:10 -0400
X-MC-Unique: FRd9asa-O7evNAu_366XBw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB6B51955BE1; Wed, 23 Oct 2024 13:18:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E570819560AE; Wed, 23 Oct 2024 13:18:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 19/23] tests/qtest: Add s390x boot order tests to cdrom-test.c
Date: Wed, 23 Oct 2024 15:17:06 +0200
Message-ID: <20241023131710.906748-20-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add two new qtests to verify that a valid IPL device can successfully boot after
failed IPL attempts from one or more invalid devices.

cdrom-test/as-fallback-device: Defines the primary boot target as a device that
is invalid for IPL and a second boot target that is valid for IPL. Ensures that
the valid device will be selected after the initial failed IPL.

cdrom-test/as-last-option: Defines the maximum number of boot devices (8)
where only the final entry in the boot order is valid. Ensures that a valid
device will be selected even after multiple failed IPL attempts from both
virtio-blk and virtio-scsi device types.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241020012953.1380075-20-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/cdrom-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 9d72b24e4b..c86725a511 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -213,6 +213,30 @@ static void add_s390x_tests(void)
                         "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
                         "-device virtio-blk,drive=d2,bootindex=1 "
                         "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/as-fallback-device",
+                        "-device virtio-serial -device virtio-scsi "
+                        "-device virtio-blk,drive=d1,bootindex=1 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
+                        "-device virtio-blk,drive=d2,bootindex=2 "
+                        "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/as-last-option",
+                        "-device virtio-serial -device virtio-scsi "
+                        "-device virtio-blk,drive=d1,bootindex=1 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
+                        "-device virtio-blk,drive=d2,bootindex=2 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d2 "
+                        "-device virtio-blk,drive=d3,bootindex=3 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d3 "
+                        "-device scsi-hd,drive=d4,bootindex=4 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d4 "
+                        "-device scsi-hd,drive=d5,bootindex=5 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d5 "
+                        "-device virtio-blk,drive=d6,bootindex=6 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d6 "
+                        "-device scsi-hd,drive=d7,bootindex=7 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d7 "
+                        "-device scsi-cd,drive=d8,bootindex=8 "
+                        "-drive if=none,id=d8,media=cdrom,file=", test_cdboot);
     if (qtest_has_device("x-terminal3270")) {
         qtest_add_data_func("cdrom/boot/without-bootindex",
                             "-device virtio-scsi -device virtio-serial "
-- 
2.47.0


