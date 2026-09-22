Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C18C98308
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970G-0000uA-OH; Tue, 22 Sep 2026 16:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zK-00089T-AQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zI-0008WV-Lt
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4kPwAT/JzOgtUvlnJvzazdlnSn9JZdF/APYaDFIaa4=;
 b=bMamqDIdeJFOTse/VKu9jSUZGwR4TprKTq/E3n10ikisCOdZlzomWxdY0BRGTjAoztAXQb
 potf0DXn8s+aWLtufRPGR9LHkkP9L0e50uJCD8dVyQVvXK9lMOEZVzaALdTqDdbFjJH3Vd
 uVsNIMFEXAHtFxVo8ZBXxSTNKwgfPDg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-D08L2l0MOq-JO1PFOCg_Ug-1; Tue,
 22 Sep 2026 16:21:08 -0400
X-MC-Unique: D08L2l0MOq-JO1PFOCg_Ug-1
X-Mimecast-MFC-AGG-ID: D08L2l0MOq-JO1PFOCg_Ug_1790108467
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BA5C195D02F; Tue, 22 Sep 2026 20:21:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CBDA41B; Tue, 22 Sep 2026 20:21:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:40 +0400
Subject: [PATCH 33/88] qemu-iotests/245: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-33-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5Hegh+2tKBHP8+vztqNh7etXOJEw7NMI56eYPtI3t34=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqy4rCjENdmtMcG0zjAV67pcIAKVXzQERihLtWomiE+Xz/gN
 okCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqsuKwAAoJENro4Ql1lpzlg/kP/1ps
 h+eFnPJi9eCEAsufYfZFXarYVCvJLues2J/jv2kO5xxSqqqV2g086vKpPx/1NRGRgi+wn2viNI8
 katYYSB4GVl33ChlLKJbBpYZN8jx0RN2WcuD/HDOSLwmA0bD7T4jmPdKmGZ7pX0typDXfVfSn+d
 nLQo8L1ztq8DMa9ZHdeWNQGrtf2a4mwShP+NqjfRXfumiRlkz35pSGlGqvxRIcbXvxz8m9HC0Od
 EuuRUoIM43Qda4B6ExlzQalwhFSilSsPwKsxBAp5OPdLbptiobsXwXfOGQfrARJbjtGfRPa4O6R
 FtQ6LQSzdvIbHF8POrry1OJ8Q7CSf/BkMf6HyNcibKjKnR5d8MRcSGcK5RWjNADXzn5DOXXarqQ
 ljwJH/JSr955MKpvQJETRYtnIX2BAMbCWJ11K1ggrw7W3I3E0yLFAGuxYQet1kUqlnwKRZ4wU44
 U67OiLrVGJl0Rs7WSYTGVq0ToYo81bvMz7nhstYV0k60CCRfnBTSnKpwCdGxk3vWbabmRauSnbs
 Kqm7ZfQUFPdFuEio1ko4URpgy9XgMxY/LJmYEnWQSwfiS7kGqo+sEKpTK1MobS9+dkbySnL4f39
 XcboJMLPtbgz2mJ/fKB5OpN4IkiwuPMWlIhAGaA8QavJNEzgmkzvfAIBWRbtTbNi5n9LDLxWoMh
 0K08e
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

No need to wait until the VM is shut down to verify the output.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/245 | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 2f354d1d9205..3f4a87d2cd8a 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -58,34 +58,13 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        self.check_qemu_io_errors()
         os.remove(hd_path[0])
         os.remove(hd_path[1])
         os.remove(hd_path[2])
 
-    # The output of qemu-io is not returned by vm.hmp_qemu_io() but
-    # it's stored in the log and can only be read when the VM has been
-    # shut down. This function runs qemu-io and keeps track of the
-    # number of times it's been called.
     def run_qemu_io(self, img, cmd):
-        result = self.vm.hmp_qemu_io(img, cmd)
-        self.assert_qmp(result, 'return', '')
-        self.total_io_cmds += 1
-
-    # Once the VM is shut down we can parse the log and see if qemu-io
-    # ran without errors.
-    def check_qemu_io_errors(self):
-        self.assertFalse(self.vm.is_running())
-        found = 0
-        log = self.vm.get_log()
-        for line in log.split("\n"):
-            if line.startswith("Pattern verification failed"):
-                raise Exception("%s (command #%d)" % (line, found))
-            if re.match("(read|wrote) .*/.* bytes at offset", line):
-                found += 1
-        self.assertEqual(found, self.total_io_cmds,
-                         "Expected output of %d qemu-io commands, found %d" %
-                         (found, self.total_io_cmds))
+        result = self.vm.qmp('x-qemu-io', device=img, command=cmd)
+        self.assert_qmp_absent(result, 'error')
 
     # Run blockdev-reopen on a list of block devices
     def reopenMultiple(self, opts, errmsg = None):
@@ -1160,5 +1139,4 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 if __name__ == '__main__':
     iotests.activate_logging()
     iotests.main(supported_fmts=["qcow2"],
-                 supported_protocols=["file"],
-                 require_hmp=True)
+                 supported_protocols=["file"])

-- 
2.56.0.rc0.29.g47ce80527c56


