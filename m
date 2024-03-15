Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F8CC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5TV-0001Hz-SX; Fri, 15 Mar 2024 07:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5TG-0000zk-MK
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5TE-0006xE-26
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710501086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Sm2KuY35lPtQtAoj5GSSHTXjNbojrvZZnCCJdxh9g4=;
 b=W/fw56KJzVF4q0O73YxiXiFey/YG6X+tWkqX6riG5M095xFhsmwo7ZTRmAdAzjahB2Ekts
 N2G4fHcWwPm94PpbuRyKOzu2MkRhFo2kEC/yDSHSK6BU9u7ZzlcFofNSrZcuWCWHf6EAAz
 asMgdEFN+pTOsgR0z80fDVOWTmcIjgg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-1f-WNMqhOReS-Vi7VZjSnw-1; Fri,
 15 Mar 2024 07:11:23 -0400
X-MC-Unique: 1f-WNMqhOReS-Vi7VZjSnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13F3D38157BC;
 Fri, 15 Mar 2024 11:11:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D83452022EDB;
 Fri, 15 Mar 2024 11:11:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH 8/9] tests/qemu-iotests: Fix some tests that use --image-opts
 for other protocols
Date: Fri, 15 Mar 2024 12:11:07 +0100
Message-ID: <20240315111108.153201-9-thuth@redhat.com>
In-Reply-To: <20240315111108.153201-1-thuth@redhat.com>
References: <20240315111108.153201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Tests 263, 284 and detect-zeroes-registered-buf use qemu-io
with --image-opts so we have to enforce IMGOPTSSYNTAX=true here
to get $TEST_IMG in shape for other protocols than "file".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/263                                | 6 ++++--
 tests/qemu-iotests/284                                | 7 +++----
 tests/qemu-iotests/tests/detect-zeroes-registered-buf | 4 +++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
index ec09b41405..44fdada0d6 100755
--- a/tests/qemu-iotests/263
+++ b/tests/qemu-iotests/263
@@ -34,6 +34,8 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+IMGOPTSSYNTAX=true
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -73,7 +75,7 @@ echo "testing LUKS qcow2 encryption"
 echo
 
 _make_test_img --object $SECRET -o "encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10,cluster_size=64K" $size
-_run_test "driver=$IMGFMT,encrypt.key-secret=sec0,file.filename=$TEST_IMG"
+_run_test "$TEST_IMG,encrypt.key-secret=sec0"
 _cleanup_test_img
 
 echo
@@ -82,7 +84,7 @@ echo
 
 
 _make_test_img --object $SECRET -o "encrypt.format=aes,encrypt.key-secret=sec0,cluster_size=64K" $size
-_run_test "driver=$IMGFMT,encrypt.key-secret=sec0,file.filename=$TEST_IMG"
+_run_test "$TEST_IMG,encrypt.key-secret=sec0"
 _cleanup_test_img
 
 
diff --git a/tests/qemu-iotests/284 b/tests/qemu-iotests/284
index 5a82639e7f..722267486d 100755
--- a/tests/qemu-iotests/284
+++ b/tests/qemu-iotests/284
@@ -33,6 +33,8 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+IMGOPTSSYNTAX=true
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -47,14 +49,12 @@ size=1M
 
 SECRET="secret,id=sec0,data=astrochicken"
 
-IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,encrypt.key-secret=sec0"
 QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
 
 _run_test()
 {
-        IMGOPTSSYNTAX=true
         OLD_TEST_IMG="$TEST_IMG"
-        TEST_IMG="driver=$IMGFMT,file.filename=$TEST_IMG,encrypt.key-secret=sec0"
+        TEST_IMG="$TEST_IMG,encrypt.key-secret=sec0"
         QEMU_IMG_EXTRA_ARGS="--image-opts --object $SECRET"
 
         echo
@@ -78,7 +78,6 @@ _run_test()
 
         TEST_IMG="$OLD_TEST_IMG"
         QEMU_IMG_EXTRA_ARGS=
-        IMGOPTSSYNTAX=
 }
 
 
diff --git a/tests/qemu-iotests/tests/detect-zeroes-registered-buf b/tests/qemu-iotests/tests/detect-zeroes-registered-buf
index edb5f2cee5..5eaf34e5a6 100755
--- a/tests/qemu-iotests/tests/detect-zeroes-registered-buf
+++ b/tests/qemu-iotests/tests/detect-zeroes-registered-buf
@@ -36,6 +36,8 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+IMGOPTSSYNTAX=true
+
 # get standard environment, filters and checks
 cd ..
 . ./common.rc
@@ -46,7 +48,7 @@ _supported_proto generic
 
 size=128M
 _make_test_img $size
-IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,discard=unmap,detect-zeroes=unmap"
+IMGSPEC="$TEST_IMG,discard=unmap,detect-zeroes=unmap"
 
 echo
 echo "== writing zero buffer to image =="
-- 
2.44.0


