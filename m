Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230B2C9EC68
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFGk-000480-OV; Mon, 12 Jan 2026 05:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGX-0003r3-F6
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGT-0002NE-Es
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:16 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BNa8fD013867;
 Mon, 12 Jan 2026 10:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wfc5W0UwwY13K09iA
 Mh5BeDolk2EQuypihPY+lzfCKs=; b=hMhQ0UMCg5ZKIaTWTGCauvrmYpuwtA4Zd
 9mPUdv8HPz+ikjoyZPJFVhQkI2SPov4asPYHklTySw7Fbidvaeh5hq85hng18EBY
 wp0tEOxmDFXzHRFdooQIVxwUIOdj9U2BwcHrG6tbxQCBaPZZJBlx3yKEk7lKgeOT
 9um5FdGUrIVTL+f2/cbJM915srAxgb7F2AvczJnP5iW9ANfsJaPChlXSDcEBQPHm
 nFDFGwnzLoeCDbF/LD9JrsFc791GVNXAHSE3JL2NM8NBnEgd7xnbIyzQXJFpmgEm
 b0AdUiZcYU/av4rux+N/RvLa0LnX56HsF8mTkdUPbkwx/KTllvOeg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg46hhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 10:35:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C7Fgea031255;
 Mon, 12 Jan 2026 10:35:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1d37u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 10:35:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAZ9sT21889390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:35:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7006A2004D;
 Mon, 12 Jan 2026 10:35:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A16BE20040;
 Mon, 12 Jan 2026 10:35:08 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:35:08 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/10] tests/functional: Add a OS level migration test for
 pseries
Date: Mon, 12 Jan 2026 16:04:33 +0530
Message-ID: <20260112103433.8451-11-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfXwosYejB/D6gH
 mLNzNd/l/dDf1DyXu/la4fjlPgDDI4XkGdz+K9E5f39XcPMWD8tQ2qj+IEcU+KFWLvqI6A9p1wr
 fU8q81yXMmSxTaY9Ds3tBtoxLhOkFiEh5rDHIdkh2/gPR3haoy9ZhLlpjlLHfh1Na7oi20EuPEO
 1bthL+mqFXYpG3q4hi0GvikbtLIufiMsfFlKD289NP3cEGm/l1SkjfF8xXdIH6cJF8No898HPeP
 9SBnEj4CkQwcyvb//JKUNzfAH8Z8dLJkB7c8IiYtn6Hol+7tfDGHf4cXqKadFodhALM0dAfrh4V
 cy2nSSPGkdLPJIQcQiwASNjF7fFOrBr6a2aYpNUdmrRS/ABGl3QNUqk/AeqvBkffS6tGsBQf0Qt
 OZ7mt/kcUzLxTGNCf4aJngtk2Y7GgqdTYMFbj+0WlQkoGesuog5c5pjz3AOLqke1mMiFgygDtIu
 eWwGP9I3BUVQetE97SA==
X-Proofpoint-ORIG-GUID: pMsTE9qHVVYLXumcxjjTHFmntZcZjOpn
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=6964ce60 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=b9j0PSuHwBvCiBSg_C4A:9
X-Proofpoint-GUID: pMsTE9qHVVYLXumcxjjTHFmntZcZjOpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

There's currently no OS level test for ppc64le. Add one such test by
reusing the boot level tests that are already present.

The test boots the source machine, waits for it to reach a mid-boot
message, migrates and checks that the destination has reached the
final boot message (VFS error due to no disk).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20260109123519.28703-3-farosas@suse.de
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/functional/ppc64/test_migration.py | 12 ++++++++
 tests/functional/ppc64/test_pseries.py   | 35 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
index 5dfdaaf709..a3b819680b 100755
--- a/tests/functional/ppc64/test_migration.py
+++ b/tests/functional/ppc64/test_migration.py
@@ -4,6 +4,7 @@
 #
 # ppc migration test
 
+from qemu_test.ports import Ports
 from migration import MigrationTest
 
 
@@ -21,6 +22,17 @@ def test_migration_with_exec(self):
         self.set_machine('mac99')
         self.migration_with_exec()
 
+    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
+        with Ports() as ports:
+            port = ports.find_free_port()
+            if port is None:
+                self.skipTest('Failed to find a free port')
+            uri = 'tcp:localhost:%u' % port
+
+            dest_vm.qmp('migrate-incoming', uri=uri)
+            source_vm.qmp('migrate', uri=uri)
+            self.assert_migration(source_vm, dest_vm)
+
 
 if __name__ == '__main__':
     MigrationTest.main()
diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
index 7840c4e3ff..b45763c305 100755
--- a/tests/functional/ppc64/test_pseries.py
+++ b/tests/functional/ppc64/test_pseries.py
@@ -9,6 +9,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
+from test_migration import PpcMigrationTest
 
 class PseriesMachine(QemuSystemTest):
 
@@ -87,5 +88,39 @@ def test_ppc64_linux_big_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_ppc64_linux_migration(self):
+        self.set_machine('pseries')
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+
+        dest_vm = self.get_vm(name="dest-qemu")
+        dest_vm.add_args('-incoming', 'defer')
+        dest_vm.add_args('-smp', '4')
+        dest_vm.add_args('-nodefaults')
+        dest_vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        dest_vm.set_console()
+        dest_vm.launch()
+
+        source_vm = self.get_vm(name="source-qemu")
+        source_vm.add_args('-smp', '4')
+        source_vm.add_args('-nodefaults')
+        source_vm.add_args('-kernel', kernel_path,
+                           '-append', kernel_command_line)
+        source_vm.set_console()
+        source_vm.launch()
+
+        # ensure the boot has reached Linux
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message,
+                                 vm=source_vm)
+
+        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
+
+        # ensure the boot proceeds after migration
+        wait_for_console_pattern(self, self.good_message, self.panic_message,
+                                 vm=dest_vm)
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.52.0


