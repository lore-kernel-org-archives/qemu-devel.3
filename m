Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D66C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96z5-0006pp-EY; Tue, 22 Sep 2026 16:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yR-0005Re-FM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yO-0008CG-Vo
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMj4KEXZfz4tiSaJe0KvxbeQ244z+EpGeq0s+eX68hY=;
 b=jVhar31EIevbbw8E6nx7synvwGuDg3yd+qj6KhzhH6bxXPYL1Sq6EWIeSw5BASCBTCcX1m
 k3eM31RAkRgwxryxeqBb3GQEaTo2e1sLKkfNSc7uacaqReeUpu5lPr22SjKhEMujR6w09h
 zpJwdCGxfQDwxlKn8pyydWwxhLHOmQ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-t9jP9fpXNXaBhzJxBmf_oQ-1; Tue,
 22 Sep 2026 16:20:14 -0400
X-MC-Unique: t9jP9fpXNXaBhzJxBmf_oQ-1
X-Mimecast-MFC-AGG-ID: t9jP9fpXNXaBhzJxBmf_oQ_1790108414
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6D44184B82E; Tue, 22 Sep 2026 20:20:13 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1360441B; Tue, 22 Sep 2026 20:20:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:25 +0400
Subject: [PATCH 18/88] qemu-iotests/copy-before-write: migrate away from
 HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-18-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=10562;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gZ6eYAGzuabrd9QBiYidmKcCE4+jixZealXnUHXbfGs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKvhdwiIzt6gzPq3PVoFwhVI5TyO+cKMB1UT
 fRfp1jmIK2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5YiyD/9fn6st++CdsMyJ+0zSwi9872eycqlPoOIMznJxA999GGBUhfIoANh9SIU90G7JPJzps1E
 E/qw3iBEfXYsRbss1PqWGFiYSg/sC7bq/CMWKyp5Uxt9nccBK0dsHCcTa0zAOHyBJEKFtjYI4Nl
 uojW0QdRjtyPyVbO5NDcAEti/C5s0FZZTNz3lkb7DMVMlX8pTuuDj0ipsPZXw/p/PMH8ENh0Va9
 dIzZliAJvVp7VndTtMMj/w6BVKja0h3nutavNidq4uiy8ASKJhMA/K9qeclKQ/7xRialVRtuffF
 5rken8cclHxomqpnNZtfcBV35BIxCq6BMtGJOvPSFJO7Fjl+nCAdUhczFsHKNZs+XdGqDX7jR+3
 bKze1eeaq2IYaDkCtPC4USW5Mv4ujfOS5mO8fg9I6VioKsfLe6E+F/t+QltAYuNgt6b8LKTwgWc
 Y6sMBPEYAgD8Og2vHAJH4+DdCxe9UpqIefl5NAu/FDq+O7hKZrTAbN1SC6Fy0Ji7r7ygijgI4On
 ZnET6n+/f+KB3Y2Y24EGJAJv4WwKF+dCyXuooORZTxCNBFG8bujTn02f/OHF3K2VXBVXBCFwZA8
 qwu9a0uzhJvZdRKdnaumGXi63brjKPO3YZpgs+ecV8zIaY8ubXqIIEE4UKlXsbUj9d4qMCK+mQ3
 2oKYwGwm27+shKw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

This test doesn't use iotests.VM presumably because it sets up qtest,
conflicting with -machine none.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/copy-before-write | 130 +++++++++++++----------------
 1 file changed, 59 insertions(+), 71 deletions(-)

diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index 5531ad8a4c0d..59ab96738d6d 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -32,6 +32,9 @@ size = '1M'
 
 
 class TestCbwError(iotests.QMPTestCase):
+    def qemu_io_result(self, res):
+        return iotests.filter_qemu_io(res['return']['human-readable-text'])
+
     def tearDown(self):
         self.vm.shutdown()
         os.remove(temp_img)
@@ -85,19 +88,14 @@ class TestCbwError(iotests.QMPTestCase):
             'file': 'cbw'
         })
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io cbw "write 0 1M"')
-        write_res = result['return']
-
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io access "read 0 1M"')
-        read_res = result['return']
+        write_res = self.vm.qmp('x-qemu-io', device='cbw',
+                                command='write 0 1M')
+        read_res = self.vm.qmp('x-qemu-io', device='access',
+                               command='read 0 1M')
 
         self.vm.shutdown()
-        log = self.vm.get_log()
-        log = iotests.filter_qtest(log)
-        log = iotests.filter_qemu_io(log)
-        return log, write_res, read_res
+        self.assertEqual(self.vm.get_log(), '')
+        return write_res, read_res
 
     def do_cbw_error_via_blockdev_backup(self, on_cbw_error=None):
         self.vm.cmd('blockdev-add', {
@@ -148,43 +146,37 @@ class TestCbwError(iotests.QMPTestCase):
             'file': 'cbw'
         })
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io cbw "write 0 1M"')
-        write_res = result['return']
-
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io access "read 0 1M"')
-        read_res = result['return']
+        write_res = self.vm.qmp('x-qemu-io', device='cbw',
+                                command='write 0 1M')
+        read_res = self.vm.qmp('x-qemu-io', device='access',
+                               command='read 0 1M')
 
         self.vm.shutdown()
-        log = self.vm.get_log()
-        log = iotests.filter_qemu_io(log)
-        return log, write_res, read_res
+        self.assertEqual(self.vm.get_log(), '')
+        return write_res, read_res
 
     def test_break_snapshot_on_cbw_error(self):
         """break-snapshot behavior:
         Guest write succeed, but further snapshot-read fails, as snapshot is
         broken.
         """
-        log, write_res, read_res = self.do_cbw_error('break-snapshot')
-        self.assertEqual(write_res, '')
-        self.assertIn('read failed: Permission denied', read_res)
-
-        self.assertEqual(log, """\
+        write_res, read_res = self.do_cbw_error('break-snapshot')
+        self.assertEqual(self.qemu_io_result(write_res), """\
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
+        self.assertIn('read failed: Permission denied',
+                      read_res['error']['desc'])
 
     def test_break_guest_write_on_cbw_error(self):
         """break-guest-write behavior:
         Guest write fails, but snapshot-access continues working and further
         snapshot-read succeeds.
         """
-        log, write_res, read_res = self.do_cbw_error('break-guest-write')
-        self.assertIn('write failed: Input/output error', write_res)
-        self.assertEqual(read_res, '')
-
-        self.assertEqual(log, """\
+        write_res, read_res = self.do_cbw_error('break-guest-write')
+        self.assertIn('write failed: Input/output error',
+                      write_res['error']['desc'])
+        self.assertEqual(self.qemu_io_result(read_res), """\
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
@@ -193,24 +185,24 @@ read 1048576/1048576 bytes at offset 0
         """Ensure CBW filter accepts break-snapshot policy
         specified in blockdev-backup QMP command.
         """
-        log, write_res, read_res = \
+        write_res, read_res = \
             self.do_cbw_error_via_blockdev_backup('break-snapshot')
-        self.assertEqual(write_res, '')
-        self.assertIn('read failed: Permission denied', read_res)
-        self.assertEqual(log, """\
+        self.assertEqual(self.qemu_io_result(write_res), """\
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
+        self.assertIn('read failed: Permission denied',
+                      read_res['error']['desc'])
 
     def test_break_guest_write_policy_forwarding(self):
         """Ensure CBW filter accepts break-guest-write policy
         specified in blockdev-backup QMP command.
         """
-        log, write_res, read_res = \
+        write_res, read_res = \
             self.do_cbw_error_via_blockdev_backup('break-guest-write')
-        self.assertIn('write failed: Input/output error', write_res)
-        self.assertEqual(read_res, '')
-        self.assertEqual(log, """\
+        self.assertIn('write failed: Input/output error',
+                      write_res['error']['desc'])
+        self.assertEqual(self.qemu_io_result(read_res), """\
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
@@ -219,11 +211,11 @@ read 1048576/1048576 bytes at offset 0
         """Ensure break-guest-write policy is used by default when
         on-cbw-error is not explicitly specified.
         """
-        log, write_res, read_res = \
+        write_res, read_res = \
             self.do_cbw_error_via_blockdev_backup()
-        self.assertIn('write failed: Input/output error', write_res)
-        self.assertEqual(read_res, '')
-        self.assertEqual(log, """\
+        self.assertIn('write failed: Input/output error',
+                      write_res['error']['desc'])
+        self.assertEqual(self.qemu_io_result(read_res), """\
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
@@ -266,60 +258,56 @@ read 1048576/1048576 bytes at offset 0
             'file': 'cbw'
         })
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io cbw "write 0 512K"')
-        write1_res = result['return']
+        write1_res = self.vm.qmp('x-qemu-io', device='cbw',
+                                 command='write 0 512K')
 
         # We need second write to trigger throttling
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io cbw "write 512K 512K"')
-        write2_res = result['return']
-
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io access "read 0 1M"')
-        read_res = result['return']
+        write2_res = self.vm.qmp('x-qemu-io', device='cbw',
+                                 command='write 512K 512K')
+        read_res = self.vm.qmp('x-qemu-io', device='access',
+                               command='read 0 1M')
 
         self.vm.shutdown()
         log = self.vm.get_log()
         log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
         log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
-        log = iotests.filter_qemu_io(log)
-        return log, write1_res, write2_res, read_res
+        self.assertEqual(log, '')
+        return write1_res, write2_res, read_res
 
     def test_timeout_break_guest(self):
-        log, write1_res, write2_res, read_res = \
+        write1_res, write2_res, read_res = \
             self.do_cbw_timeout('break-guest-write')
-        self.assertEqual(write1_res, '')
+        self.assertEqual(self.qemu_io_result(write1_res), """\
+wrote 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+""")
         # macOS and FreeBSD tend to represent ETIMEDOUT as
         # "Operation timed out", when Linux prefer
         # "Connection timed out"
-        write2_res = write2_res.replace('Operation timed out',
-                                        'Connection timed out')
-        self.assertIn('write failed: Connection timed out', write2_res)
-        self.assertEqual(read_res, '')
-        self.assertEqual(log, """\
-wrote 524288/524288 bytes at offset 0
-512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+        write2_err = write2_res['error']['desc'].replace(
+            'Operation timed out', 'Connection timed out')
+        self.assertIn('write failed: Connection timed out', write2_err)
+        self.assertEqual(self.qemu_io_result(read_res), """\
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
 
     def test_timeout_break_snapshot(self):
-        log, write1_res, write2_res, read_res = \
+        write1_res, write2_res, read_res = \
             self.do_cbw_timeout('break-snapshot')
-        self.assertEqual(write1_res, '')
-        self.assertEqual(write2_res, '')
-        self.assertIn('read failed: Permission denied', read_res)
-        self.assertEqual(log, """\
+        self.assertEqual(self.qemu_io_result(write1_res), """\
 wrote 524288/524288 bytes at offset 0
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+""")
+        self.assertEqual(self.qemu_io_result(write2_res), """\
 wrote 524288/524288 bytes at offset 524288
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
+        self.assertIn('read failed: Permission denied',
+                      read_res['error']['desc'])
 
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  supported_protocols=['file'],
-                 required_fmts=['copy-before-write'],
-                 require_hmp=True)
+                 required_fmts=['copy-before-write'])

-- 
2.56.0.rc0.29.g47ce80527c56


