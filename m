Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A764EC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n12-0003ti-BX; Wed, 16 Sep 2026 06:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x6n0s-0003mp-4f; Wed, 16 Sep 2026 06:37:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x6n0h-0001in-Jk; Wed, 16 Sep 2026 06:37:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FLVsVj1952303; Wed, 16 Sep 2026 10:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BRj34CgiY9evdq9cq
 SVOocaDD5xjhkKjvjonBBTez4Y=; b=dwhql4IguJM4DPGnzyARtV/xQdjbYBSdn
 EiMiComiNpDtI7TVqumccTJCT9Ec4kscmQoUizV3GclB4HjVpNx4mXgyZoiucOlh
 DJ8ybxDeBwQR+Ibr5DU/B1AuFT4N0hlzLCTdx8JDDG5JXPocLaYLLKUCNL9vf9Z7
 rGwb5YOrelgORqyiOu3qxlBze8TvldQ3cE7EWoHBuBNgmCO/FrozroNqs1Xf7BW/
 4I995FsQTSzSgIsxw3+eeecnSAY78F726QLGiH8Iy9vFRCqqhjxDMWhkPJ8ze5ay
 601+lsod9r43Ilj+Ukhs+GlD2nNfYhVFaYiqnejMleKaQVPZg1woQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83v0n7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 10:37:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G7XsS5426534; Wed, 16 Sep 2026 10:37:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089nstr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 10:37:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GAauDY26804682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 10:36:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DE1620040;
 Wed, 16 Sep 2026 10:36:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E1BF20043;
 Wed, 16 Sep 2026 10:36:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.21.121])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Sep 2026 10:36:52 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com,
 thuth@redhat.com, asahu1x@linux.ibm.com
Subject: [PATCH v2 1/2] tests/functional/ppc64: extend pseries migration tests
Date: Wed, 16 Sep 2026 16:06:34 +0530
Message-ID: <20260916103635.7797-2-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260916103635.7797-1-asahu1x@linux.ibm.com>
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzOCBTYWx0ZWRfX43SfS+uSCm1b
 G5ktshmqxHrGQO3d0BeS7eFZt+Im30CMNYq5m1nf7vr7cUcvpzhVyTh+oLn+7AaWtJd7WBnRVWq
 kgWHTjCSDHDjLG/lRbds59ISOaiuy/umJdsqq5j0vpT2ih1KEWIFNnStVlvkpBKWH6Ar0/cetid
 Xz8KAY4XnkovWaM+ERUO6wRdE01EaYM4DxLv9uNAXZ34VHnkYs1BAZ9ST49sZerlvYSFdZsytq7
 V2ClCCT/3fFtbh0ntjBlbqZt+sXy/FKiDpG859VdQ+ixhALRkG9pPIulOoCqXds5ZIMIou1nW7N
 G/ZziO6KuATjYMUis5/F++sYyuU7PgP9xaxB0IpZb1ubo35wZKiBXWO6jkl2V2hhs6PDV4eDIzE
 x2B35DVMpP1B6bvQ8FoMZKE2uUO3caUPw7czp+ZOM6BQ1Nnwer9jD8OlHZoIIvI9/thO1VdPdjB
 WW3UfX5M3UVaL67kfAw==
X-Proofpoint-ORIG-GUID: VxUYUY0DOFGMGCgrCT3uT56-UoZN5t4K
X-Proofpoint-GUID: Mp5pnlGk_pNeyp2UwLeKKrZwP7DVQEJP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEzOCBTYWx0ZWRfX8/X+xrvx7jTe
 JyCB6EcKBHI1eIQozPvbHdgUrsDR3tF5hDDs3svAPcZbiuF4NpsR+SugNvj1tu4+KpkVJWrd98T
 7TEtcik9J+4hvWhPgRwR+s3RMObatzc=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaa714d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=lZSLbgsDqh2nBwNdn7wA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Made a few changes to test_pseries.py to extend the migration
tests to validate exec (socat) and UNIX paths.

- Refactored test_ppc64_linux_migration to a private method
_do_linux_migration(dst_uri, src_uri=None).
- It is then called by three separate methods which exercise the
TCP, UNIX and exec paths via the migrate_vms method from
MigrationTest.
---
 tests/functional/ppc64/test_pseries.py | 41 ++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
index cb6d25dc81..19f31141b1 100755
--- a/tests/functional/ppc64/test_pseries.py
+++ b/tests/functional/ppc64/test_pseries.py
@@ -8,8 +8,9 @@
 # later.  See the COPYING file in the top-level directory.
 
 from qemu_test import Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, which
 from migration import MigrationTest
+from qemu_test.ports import Ports
 
 class PseriesMachine(MigrationTest):
 
@@ -88,12 +89,20 @@ def test_ppc64_linux_big_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
-    def test_ppc64_linux_migration(self):
+    def _do_linux_migration(self, dst_uri, src_uri=None):
+        """
+        Boot a pseries kernel on a source VM, wait until Linux is up, then
+        migrate to a destination VM over the given URI(s) and verify the boot
+        continues on the destination.
+        """
         self.set_machine('pseries')
 
         kernel_path = self.ASSET_KERNEL.fetch()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
 
+        if src_uri is None:
+            src_uri = dst_uri
+
         dest_vm = self.get_vm(name="dest-qemu")
         dest_vm.add_args('-incoming', 'defer')
         dest_vm.add_args('-smp', '4')
@@ -111,16 +120,38 @@ def test_ppc64_linux_migration(self):
         source_vm.set_console()
         source_vm.launch()
 
-        # ensure the boot has reached Linux
+        # ensure the boot has reached Linux before migrating
         console_pattern = 'smp: Brought up 1 node, 4 CPUs'
         wait_for_console_pattern(self, console_pattern, self.panic_message,
                                  vm=source_vm)
 
-        self.migration_with_tcp_localhost_vms(dest_vm, source_vm)
+        self.migrate_vms(dst_uri, src_uri, dest_vm, source_vm)
 
-        # ensure the boot proceeds after migration
+        # ensure the boot continues on the destination after migration
         wait_for_console_pattern(self, self.good_message, self.panic_message,
                                  vm=dest_vm)
 
+    def test_ppc64_linux_migration(self):
+        with Ports() as ports:
+            port = ports.find_free_port()
+            if port is None:
+                self.skipTest('Failed to find a free port')
+            self._do_linux_migration('tcp:localhost:%u' % port)
+
+    def test_ppc64_linux_migration_unix(self):
+        self._do_linux_migration(
+            'unix:%s/migration.sock' % self.socket_dir().name)
+
+    def test_ppc64_linux_migration_exec(self):
+        if not which('socat'):
+            self.skipTest('socat is not available')
+        with Ports() as ports:
+            port = ports.find_free_port()
+            if port is None:
+                self.skipTest('Failed to find a free port')
+            self._do_linux_migration(
+                'exec:socat TCP-LISTEN:%u -' % port,
+                'exec:socat - TCP:localhost:%u,forever' % port)
+
 if __name__ == '__main__':
     MigrationTest.main()
-- 
2.52.0


