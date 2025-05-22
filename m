Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B770C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 13:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI67x-0000QI-VS; Thu, 22 May 2025 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI67v-0000Py-Rx
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI67s-0001YT-Ta
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747921103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FOxYpbZOSNLW7pDDjikF00tCEjCwg8lNxMYXYj6efo4=;
 b=Xk71BPhsThUlIYTR66VjQlLcxljiqLe0/bjwZrC9Tr3Se+NmVEBuU56OWOBREXlowrcTDT
 tSOPKTqzOWxgDjocy/TYvjdYhnX9Yxw7JdYj7VqsYrSBcJ0TyqAYAfx1H7gaWRP1Rm/zlL
 /+pqQLWVaC5lhYga9sRjTMUNou5CK7g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-jfUrfzmNM6y93pcG4RMDdA-1; Thu,
 22 May 2025 09:38:20 -0400
X-MC-Unique: jfUrfzmNM6y93pcG4RMDdA-1
X-Mimecast-MFC-AGG-ID: jfUrfzmNM6y93pcG4RMDdA_1747921099
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B7A61800261; Thu, 22 May 2025 13:38:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C956430001A1; Thu, 22 May 2025 13:38:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 4/4] tests/functional/test_vmstate: Test whether the
 checker script works as expected
Date: Thu, 22 May 2025 15:37:56 +0200
Message-ID: <20250522133756.259194-5-thuth@redhat.com>
In-Reply-To: <20250522133756.259194-1-thuth@redhat.com>
References: <20250522133756.259194-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

We've got two vmstate dump files in the repository which are meant
for verifying whether the vmstate-static-checker.py works as expected.
Since running this manually is a cumbersome job, let's add an automated
test for this instead that runs the script with the two dump files
and checks for the expected output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_vmstate.py | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
index cc988987481..19a62e8a17e 100755
--- a/tests/functional/test_vmstate.py
+++ b/tests/functional/test_vmstate.py
@@ -9,6 +9,22 @@
 from qemu_test import QemuSystemTest
 
 
+expected_output='''Warning: checking incompatible machine types: "pc-i440fx-2.1", "pc-i440fx-2.2"
+Section "fw_cfg" does not exist in dest
+Section "fusbh200-ehci-usb" version error: 2 > 1
+Section "fusbh200-ehci-usb", Description "ehci-core": expected field "usbsts", got "usbsts_pending"; skipping rest
+Section "pci-serial-4x" Description "pci-serial-multi": Entry "Fields" missing
+Section "intel-hda-generic", Description "intel-hda", Field "pci": missing description
+Section "cfi.pflash01": Entry "Description" missing
+Section "megasas", Description "PCIDevice": expected field "irq_state", while dest has no further fields
+Section "PIIX3-xen" Description "PIIX3": minimum version error: 1 < 2
+Section "PIIX3-xen" Description "PIIX3": Entry "Subsections" missing
+Section "tpci200": Description "tpci200" missing, got "tpci2002" instead; skipping
+Section "sun-fdtwo" Description "fdc": version error: 2 > 1
+Section "sun-fdtwo", Description "fdrive": Subsection "fdrive/media_rate" not found
+Section "usb-kbd" Description "usb-kbd" Field "kbd.keycodes" size mismatch: 4 , 2
+'''
+
 class VmStateTest(QemuSystemTest):
 
     def run_vmstate_checker(self, src_json, dst_json):
@@ -19,6 +35,27 @@ def run_vmstate_checker(self, src_json, dst_json):
                               stderr=subprocess.STDOUT,
                               text=True)
 
+    def test_checker(self):
+        """
+        Test whether the checker script correctly detects the changes
+        between dump1.json and dump2.json.
+        """
+        if self.arch != 'x86_64':
+            self.skipTest('for x86 only')
+        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  'dump1.json')
+        dst_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  'dump2.json')
+        self.log.info(f'Comparing {src_json} with {dst_json}')
+        cp = self.run_vmstate_checker(src_json, dst_json)
+        if cp.returncode != 13:
+            self.fail('Unexpected return code of vmstate-static-checker: ' +
+                      cp.returncode)
+        if cp.stdout != expected_output:
+            self.log.info('vmstate-static-checker output:\n' + cp.stdout)
+            self.log.info('expected output:\n' + expected_output)
+            self.fail('Unexpected vmstate-static-checker output!')
+
     def test_vmstate(self):
         target_machine = {
             'aarch64': 'virt-7.2',
-- 
2.49.0


