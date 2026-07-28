Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93612C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolkv-0007sN-4x; Tue, 28 Jul 2026 13:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolks-0007j0-3J
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkn-0005wk-3f
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dic/xYE7w0ZGRSy4vTqdGsET1sJ+FyAccUS3zVDMPFg=;
 b=C/2ZAZWunV0VZm9ckduRFIPVr7V18OMVmFHrPHLA8+AfDeqWtmoa4jPXJQTUew8KVofCUL
 yImf46YqncoQftz/IbGAAzYlb9UtDNbyM7nPNRBBw/haXGi1jHhv5fBcQCsLgs+IpyxIJl
 mBGqpiJ7AD7eOz/W97XXpbTzc/wsJes=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-J5osA2FMN4qvqFBy6QHJgQ-1; Tue,
 28 Jul 2026 13:38:04 -0400
X-MC-Unique: J5osA2FMN4qvqFBy6QHJgQ-1
X-Mimecast-MFC-AGG-ID: J5osA2FMN4qvqFBy6QHJgQ_1785260283
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 619D719560B7; Tue, 28 Jul 2026 17:38:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C7C91956044; Tue, 28 Jul 2026 17:38:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 10/17] iotests: skip FUSE tests when FUSE is not usable
Date: Tue, 28 Jul 2026 19:37:32 +0200
Message-ID: <20260728173739.352078-11-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

file-io-error, fuse-allow-other and fuse-mmap-shared skip only when
FUSE is not compiled in. When FUSE is built in but unusable at run
time (no /dev/fuse access, fusermount lacking permissions), the
export fails to mount with "Failed to mount FUSE session to export"
and the tests report a spurious failure instead of skipping, like
NBD tests already do for missing NBD support.

Add _notrun_on_fuse_error() to common.rc and use it in the shell
tests. fuse-mmap-shared is Python, so it gets an equivalent inline
check.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
Message-ID: <20260715103451.1930909-3-den@openvz.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.rc              | 14 ++++++++++++++
 tests/qemu-iotests/tests/file-io-error    |  4 +---
 tests/qemu-iotests/tests/fuse-allow-other |  2 ++
 tests/qemu-iotests/tests/fuse-mmap-shared |  9 ++++++---
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 298bc483e0c..bcb1ec50a93 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -981,6 +981,20 @@ _require_drivers()
     done
 }
 
+# Skip if FUSE is unusable: not compiled in, or the export failed to
+# mount. $1 is the failing 'block-export-add' reply.
+_notrun_on_fuse_error()
+{
+    case "$1" in
+        *"Parameter 'type' does not accept value 'fuse'"*)
+            _notrun "No FUSE support"
+            ;;
+        *"Failed to mount FUSE session"*)
+            _notrun "FUSE not usable in this environment"
+            ;;
+    esac
+}
+
 # Check that we have a file system that allows huge (but very sparse) files
 #
 _require_large_file()
diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
index fb8db73b31b..0d970c102f6 100755
--- a/tests/qemu-iotests/tests/file-io-error
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -89,9 +89,7 @@ output=$(_send_qemu_cmd $QEMU_HANDLE \
     'return' \
     | grep -v 'option allow_other only allowed if')
 
-if echo "$output" | grep -q "Parameter 'type' does not accept value 'fuse'"; then
-    _notrun 'No FUSE support'
-fi
+_notrun_on_fuse_error "$output"
 echo "$output"
 
 echo
diff --git a/tests/qemu-iotests/tests/fuse-allow-other b/tests/qemu-iotests/tests/fuse-allow-other
index eaa39f8f236..50a36601d75 100755
--- a/tests/qemu-iotests/tests/fuse-allow-other
+++ b/tests/qemu-iotests/tests/fuse-allow-other
@@ -77,6 +77,8 @@ fuse_export_add()
         _notrun "allow_other not supported"
     fi
 
+    _notrun_on_fuse_error "$output"
+
     echo "$output"
 }
 
diff --git a/tests/qemu-iotests/tests/fuse-mmap-shared b/tests/qemu-iotests/tests/fuse-mmap-shared
index 52941a3bb69..b1901058946 100755
--- a/tests/qemu-iotests/tests/fuse-mmap-shared
+++ b/tests/qemu-iotests/tests/fuse-mmap-shared
@@ -28,9 +28,12 @@ def test_fuse_support(mount_point):
     })
     test_qsd.stop()
     if 'error' in res:
-        assert (res['error']['desc'] ==
-                "Parameter 'type' does not accept value 'fuse'")
-        iotests.notrun('No FUSE support')
+        desc = res['error']['desc']
+        if desc == "Parameter 'type' does not accept value 'fuse'":
+            iotests.notrun('No FUSE support')
+        if 'Failed to mount FUSE session' in desc:
+            iotests.notrun('FUSE not usable in this environment')
+        assert False, desc
 
 # Shared mmap when using direct IO is only supported for Linux kernels >= 6.6
 # with commit e78662e818f94 ("fuse: add a new fuse init flag to relax
-- 
2.55.0


