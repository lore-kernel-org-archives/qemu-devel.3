Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3C2C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQom-00080F-Np; Tue, 18 Aug 2026 16:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQod-0007va-Qc; Tue, 18 Aug 2026 16:53:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQob-0000kt-UJ; Tue, 18 Aug 2026 16:53:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJW2bo3584976; Tue, 18 Aug 2026 20:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=55UqOsX+jyCdvavll
 eLPW2TCH4Ig6ILq9h41NDbVAAk=; b=N0GATt6W/xyahZZAtGpNpSOM7hannSh5W
 j7Z0OJpV3ESlAGeMnlEiyTQVADRo+Yr456Rr0TYlLPQ1qGjhNpne1yxHE+QFZIqv
 ctG08x+Wmo0eVnzgrTjVoIWPtwXLZWfIT6cBo8ba7jnpoTMf9rCgTrXqBW+3yeXd
 dmi7S+SpDyByvEaprUWTrw4H8ekgR1coEZrOrNQ5rjfJrCo6bDs6nLee4Rueh00k
 9BXOzM4N9SEPJlHAePk+C994MkVYkcy93jTmTtB0fdBOSvfPPOkVbNwtz47J/m/r
 JGq7IBLTQF61exwfAXv1b+8vLaWxK2zE76dvEu1L5ldznBy4BvZwg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqtu5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfKuN014393;
 Tue, 18 Aug 2026 20:53:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngd7bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IKrgmm26411606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:53:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F20E258045;
 Tue, 18 Aug 2026 20:53:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8448958050;
 Tue, 18 Aug 2026 20:53:40 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.136.182])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:53:40 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 7/7] tests/functional/s390x: Add tests for virtio net PCI
 in test_pxelinux.py
Date: Tue, 18 Aug 2026 16:53:24 -0400
Message-ID: <20260818205324.580199-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205324.580199-1-zycai@linux.ibm.com>
References: <20260818205324.580199-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX2Fj9NNVKnNZ+
 kX9ya2dbWwgcB+oZRQnGcRx4NJvnd78l16cEHfkQ6tY6eup6EtW5EAsfUL9bimR0amOMVz/l2U6
 fxehdL/6WFgFU5CR+DHvbMfMTin260sBKx1gY5sF+w6gPKb9S9GkXv86qolFJvBMLkTxXW0j6Je
 SdlI8piQ9fRiJr4leWcQ3jHhCASiLlhTqTOnTwMQjM5R1IxDbT75zFEGlVCmVQ3Yp8gGWJif16e
 aU4ftGOyny0ybDM34VPIfgIDjwpswCTkKRr4Og2/wCtS/5ZCw7Vj5MEbgYnrZkwVcV1PiL+1uRP
 v9r4Yc2lO7F0EoA2fW3+kXmN+Gem18nVUqNlFb8nXy9pdcAW0dnDmwUX3rSvWxx6dq8sR9bBHMw
 S3pkTUJM9JwKkjXdXA4czx1RE6ARG0zA/F+hZX1OQjXpespDLG37lkRnNDF3hviX+GMVJ033Cn3
 Q6+n5aTyySYxLguHS+g==
X-Proofpoint-ORIG-GUID: P0gU-kdsyfszAN3OhWoWYNyR5LuTta3B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX7En33FUFSHYw
 OpfbRwAOwynZd4hwfiXED6Z3kCPs/lfoly2q83wtPMm28FtXcOK0Hgs7Z93cjQ/DmawBy4u5Bb0
 XdvF2zCMb/T5XzoEDecna09DKthlzlE=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84c658 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Z6bpV0tWmYslb40Kif8A:9
X-Proofpoint-GUID: P0gU-kdsyfszAN3OhWoWYNyR5LuTta3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Add test coverage for virtio-net-pci network booting on s390x by
extending the pxelinux functional tests.

This patch adds PCI variants of all existing pxelinux tests to verify
that virtio-net-pci devices work correctly for network booting.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 tests/functional/s390x/test_pxelinux.py | 71 ++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/tests/functional/s390x/test_pxelinux.py b/tests/functional/s390x/test_pxelinux.py
index c00cce6a5a..7223364852 100755
--- a/tests/functional/s390x/test_pxelinux.py
+++ b/tests/functional/s390x/test_pxelinux.py
@@ -50,7 +50,8 @@ class S390PxeLinux(QemuSystemTest):
          '/images/kernel.img'),
         '480859574f3f44caa6cd35c62d70e1ac0609134e22ce2a954bbed9b110c06e0b')
 
-    def pxelinux_launch(self, pl_name='default', extra_opts=None):
+    def pxelinux_launch(self, pl_name='default', extra_opts=None,
+                        dev='virtio-net-ccw'):
         '''Create a pxelinux.cfg file in the right location and launch QEMU'''
         self.require_netdev('user')
         self.set_machine('s390-ccw-virtio')
@@ -74,7 +75,7 @@ def pxelinux_launch(self, pl_name='default', extra_opts=None):
         with open(cfg_fname, 'w', encoding='utf-8') as f:
             f.write(PXELINUX_CFG_CONTENTS)
 
-        virtio_net_dev = 'virtio-net-ccw,netdev=n1,bootindex=1'
+        virtio_net_dev = f'{dev},netdev=n1,bootindex=1'
         if extra_opts:
             virtio_net_dev += ',' + extra_opts
 
@@ -85,9 +86,9 @@ def pxelinux_launch(self, pl_name='default', extra_opts=None):
         self.vm.launch()
 
 
-    def test_default(self):
+    def do_test_default(self, dev):
         '''Check whether the guest uses the "default" file name'''
-        self.pxelinux_launch()
+        self.pxelinux_launch(dev=dev)
         # The kernel prints its arguments to the console, so we can use
         # this to check whether the kernel parameters are correctly handled:
         wait_for_console_pattern(self, 'testoption=teststring')
@@ -95,36 +96,82 @@ def test_default(self):
         wait_for_console_pattern(self, 'Unpacking initramfs...')
         wait_for_console_pattern(self, 'Run /init as init process')
 
-    def test_mac(self):
+    def do_test_mac(self, dev):
         '''Check whether the guest uses file name based on its MAC address'''
         self.pxelinux_launch(pl_name='01-02-ca-fe-ba-be-42',
-                             extra_opts='mac=02:ca:fe:ba:be:42,loadparm=3')
+                             extra_opts='mac=02:ca:fe:ba:be:42,loadparm=3',
+                             dev=dev)
         wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
 
-    def test_uuid(self):
+    def do_test_uuid(self, dev):
         '''Check whether the guest uses file name based on its UUID'''
         # Also add a non-bootable disk to check the fallback to network boot:
         self.vm.add_args('-blockdev', 'null-co,size=65536,node-name=d1',
                          '-device', 'virtio-blk,drive=d1,bootindex=0,loadparm=1',
                          '-uuid', '550e8400-e29b-11d4-a716-446655441234')
-        self.pxelinux_launch(pl_name='550e8400-e29b-11d4-a716-446655441234')
+        self.pxelinux_launch(pl_name='550e8400-e29b-11d4-a716-446655441234',
+                             dev=dev)
         wait_for_console_pattern(self, 'Debian 4.19.146-1 (2020-09-17)')
 
-    def test_ip(self):
+    def do_test_ip(self, dev):
         '''Check whether the guest uses file name based on its IP address'''
         self.vm.add_args('-M', 'loadparm=3')
-        self.pxelinux_launch(pl_name='0A00020F')
+        self.pxelinux_launch(pl_name='0A00020F', dev=dev)
         wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
 
-    def test_menu(self):
+    def do_test_menu(self, dev):
         '''Check whether the boot menu works for pxelinux.cfg booting'''
         self.vm.add_args('-boot', 'menu=on,splash-time=10')
-        self.pxelinux_launch(pl_name='0A00')
+        self.pxelinux_launch(pl_name='0A00', dev=dev)
         wait_for_console_pattern(self, '[1] Nonexisting')
         wait_for_console_pattern(self, '[2] Debian')
         wait_for_console_pattern(self, '[3] Fedora')
         wait_for_console_pattern(self, 'Debian 4.19.146-1 (2020-09-17)')
 
+    def test_default(self):
+        '''pxelinux.cfg "default" lookup via virtio-net-ccw'''
+        self.do_test_default('virtio-net-ccw')
+
+    def test_default_pci(self):
+        '''pxelinux.cfg "default" lookup via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_default('virtio-net-pci')
+
+    def test_mac(self):
+        '''pxelinux.cfg MAC-address-based file lookup via virtio-net-ccw'''
+        self.do_test_mac('virtio-net-ccw')
+
+    def test_mac_pci(self):
+        '''pxelinux.cfg MAC-address-based file lookup via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_mac('virtio-net-pci')
+
+    def test_uuid(self):
+        '''pxelinux.cfg UUID-based file lookup via virtio-net-ccw'''
+        self.do_test_uuid('virtio-net-ccw')
+
+    def test_uuid_pci(self):
+        '''pxelinux.cfg UUID-based file lookup via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_uuid('virtio-net-pci')
+
+    def test_ip(self):
+        '''pxelinux.cfg IP-address-based file lookup via virtio-net-ccw'''
+        self.do_test_ip('virtio-net-ccw')
+
+    def test_ip_pci(self):
+        '''pxelinux.cfg IP-address-based file lookup via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_ip('virtio-net-pci')
+
+    def test_menu(self):
+        '''pxelinux.cfg interactive boot menu via virtio-net-ccw'''
+        self.do_test_menu('virtio-net-ccw')
+
+    def test_menu_pci(self):
+        '''pxelinux.cfg interactive boot menu via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_menu('virtio-net-pci')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.55.0


