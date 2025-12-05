Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4361FD2F7E7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 13:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRVR3-0002Mx-W0; Fri, 05 Dec 2025 08:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRVQI-0002Em-L2
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 08:00:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRVQC-0004Y5-Jz
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 08:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764939626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lxku6T/oohlVvZfVHLJAee1FSVq1nv+dC7aANtRugmo=;
 b=b36Ee1X+5zOh2ISPPxMNZ04wbmn0iLJjfPt2QiAFasKkz7+0ibSIDSaSIcyxU72ujitkQR
 gjy5ViGNQjzBYe+oNq4I51oTcCXlEHGfdxiTCcJoEOT2soD6Hi4y9kRbvJJNTDfDIhZ3q+
 nam88fwFiOnQ6sEiRjAaSoRUE+WUopM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-AP3ah9qgM3SJEsfIwLVCOg-1; Fri,
 05 Dec 2025 08:00:20 -0500
X-MC-Unique: AP3ah9qgM3SJEsfIwLVCOg-1
X-Mimecast-MFC-AGG-ID: AP3ah9qgM3SJEsfIwLVCOg_1764939619
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BE101800451; Fri,  5 Dec 2025 13:00:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.22.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C7E5180028C; Fri,  5 Dec 2025 13:00:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Hanna Reitz <hreitz@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/qemu-iotests: Check for a functional "secret" object
 before using it
Date: Fri,  5 Dec 2025 14:00:14 +0100
Message-ID: <20251205130014.693799-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Thomas Huth <thuth@redhat.com>

QEMU iotests 049, 134 and 158 are currently failing if you compiled
QEMU without the crypto libraries. Thus make sure that the "secret"
object is really usable and skip the tests otherwise.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/049       |  2 ++
 tests/qemu-iotests/134       |  1 +
 tests/qemu-iotests/158       |  1 +
 tests/qemu-iotests/common.rc | 14 ++++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index ed12fa49d7f..a1b922060db 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -39,6 +39,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
+_require_secret
+
 
 filter_test_dir()
 {
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index b2c3c03f08b..cc1e35eb161 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow qcow2
 _supported_proto file
+_require_secret
 
 
 size=128M
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 3a9ad7eed03..8fc4e986532 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow qcow2
 _supported_proto file
+_require_secret
 
 
 size=128M
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e977cb4eb61..10d83d8361b 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -1053,6 +1053,20 @@ _require_one_device_of()
     _notrun "$* not available"
 }
 
+_require_secret()
+{
+    if [ -e "$TEST_IMG" ]; then
+        echo "unwilling to overwrite existing file"
+        exit 1
+    fi
+    if $QEMU_IMG create -f $IMGFMT --object secret,id=sec0,data=123 \
+                 -o encryption=on,encrypt.key-secret=sec0 "$TEST_IMG" 1M 2>&1 \
+                 | grep "Unsupported cipher" ; then
+        _notrun "missing cipher support"
+    fi
+    rm -f "$TEST_IMG"
+}
+
 _qcow2_dump_header()
 {
     if [[ "$1" == "--no-filter-compression" ]]; then
-- 
2.52.0


