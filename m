Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B790DCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAj-0008SF-Ak; Wed, 30 Sep 2026 11:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAf-0008ME-Uw; Wed, 30 Sep 2026 11:24:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAd-000234-Qs; Wed, 30 Sep 2026 11:24:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5QJ11932696; Wed, 30 Sep 2026 15:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=V/FAZHgeAXRB73gHK
 LtT4uZ4CdscjUcH9AXGODgMCcU=; b=KU3vhNo5LzIFgnY0W6zy0PHe1EThQ7qh2
 Gl+TxuwGtCa0F4TxtzAnW8qNqI/LbfgCNtKnf8ZxY8K9lvDmlXaC2B3B8Y/JoWGs
 a3mDJWQEJ3nncpbSByY1+nV9OpvNmMmdjh3enddjvgOJp4kMpX8ZL+ei6i7BNLLH
 9IX2JERzEYrOqisC+pqLR/c2GimUtQFZl+wnNQo4KYm8TN7R6E0Ln3/VszCxrf7k
 oE7ZdzAFly3lIfq8nokyZo+VBcWcd0zG+J9vkTwpGajMCdNzCWZQCkNMgLZBSNjX
 Gm30iGVkjZR4YVHIbCo6fPIhfMgiYkL1XrnIAIVZ4r0wcik52M+8g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fecyfa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE38TC2287805; Wed, 30 Sep 2026 15:24:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pb3jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOW4Y24707734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B1FD5805F;
 Wed, 30 Sep 2026 15:24:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7C335805A;
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 18/23] tests/functional/s390x: Add tests for virtio net PCI in
 test_pxelinux.py
Date: Wed, 30 Sep 2026 11:24:15 -0400
Message-ID: <20260930152420.1956230-19-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd29b2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Z6bpV0tWmYslb40Kif8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX2y0BzEquyTnc
 CyyJO2gc93Xn901W0P87gEwIoaN/nTm0Y/JvFdXspskLrGjwxbDu4U9Pe+ivbe65+8O0M/x0o4Q
 sRVCfkPNKPfDIcgVsb29TlyZSZgOyjw=
X-Proofpoint-ORIG-GUID: HvQ3hHwze9UwIdUYKQlrLXmTFg-hXCGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX9HXnsi1EN3Sj
 dIgHJ87nQLiTCKzIzbHv2qTj0KdrAhgFdqAMhNIF8onyGp8AAB1K3E4jSd97Un73bXrotQ0A61Y
 p4sEXPCR4n+alZ5dLl5EsK5o6LhwEmC1D7SvvVRw4T9m4INpQGuZnURyQ0Y3VnQUWaqqOtmN+4X
 +HU+HRI6KoNa2Y02OSL3CS47LbGFS1KHxWMN6mf6s9S906fAoBCYkyFukC8b81Qgn5mANI22CI1
 VNCuyIcaNWXZpSmOhnh/oH/ZTrYElXIhLjGeG8VP8ayfwRjgf/D8EKR+arywPBqeXLwTMHvxjrD
 waC7AgiFw0YM3FlXNI/Vi2tUHblBrjlvZvoGaj66dOtSNbgVlXQKkUDfUx1dAN/+tekY75A91ri
 LTr7PcM5uEold/hAXvGbqxmJjjXPSc+f1i+dY5aOBtCCLaKIv7LgW/Fmuaq61kTCjolvkHEeauz
 W1ogijPxHI0fiLYOHqQ==
X-Proofpoint-GUID: HvQ3hHwze9UwIdUYKQlrLXmTFg-hXCGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Add test coverage for virtio-net-pci network booting on s390x by
extending the pxelinux functional tests.

This patch adds PCI variants of all existing pxelinux tests to verify
that virtio-net-pci devices work correctly for network booting.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Tested-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260924222949.147720-9-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/functional/s390x/test_pxelinux.py | 71 ++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/tests/functional/s390x/test_pxelinux.py b/tests/functional/s390x/test_pxelinux.py
index c00cce6a5a..5ce42aa074 100755
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
 
+    def test_default_ccw(self):
+        '''pxelinux.cfg "default" lookup via virtio-net-ccw'''
+        self.do_test_default('virtio-net-ccw')
+
+    def test_default_pci(self):
+        '''pxelinux.cfg "default" lookup via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_default('virtio-net-pci')
+
+    def test_mac_ccw(self):
+        '''pxelinux.cfg MAC-address-based file lookup via virtio-net-ccw'''
+        self.do_test_mac('virtio-net-ccw')
+
+    def test_mac_pci(self):
+        '''pxelinux.cfg MAC-address-based file lookup via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_mac('virtio-net-pci')
+
+    def test_uuid_ccw(self):
+        '''pxelinux.cfg UUID-based file lookup via virtio-net-ccw'''
+        self.do_test_uuid('virtio-net-ccw')
+
+    def test_uuid_pci(self):
+        '''pxelinux.cfg UUID-based file lookup via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_uuid('virtio-net-pci')
+
+    def test_ip_ccw(self):
+        '''pxelinux.cfg IP-address-based file lookup via virtio-net-ccw'''
+        self.do_test_ip('virtio-net-ccw')
+
+    def test_ip_pci(self):
+        '''pxelinux.cfg IP-address-based file lookup via virtio-net-pci'''
+        self.require_device('virtio-net-pci')
+        self.do_test_ip('virtio-net-pci')
+
+    def test_menu_ccw(self):
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


