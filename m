Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4316AFED3CB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGGYs-00055n-DK; Fri, 24 Apr 2026 09:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wGGYq-00055L-OR; Fri, 24 Apr 2026 09:27:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wGGYp-0001I0-4y; Fri, 24 Apr 2026 09:27:12 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OAqZXa3292244; Fri, 24 Apr 2026 13:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=lUIZinq5a1wLZf0Z3ANC6hPOlUp6fYAjI9C0V4mJw
 ZE=; b=B5qsIfmRNOlW6F7zuthWJdHVIsDh3OMziXDb9/wr3iIkdo8MDXOAT/M2W
 E6CjRa6g/weaZ7BTyTtWGRKgeiixHdti2p1MkD9iKRRAktEofWtndRZ5j/xWIYlz
 TIgL9XzkrmShXb9JjqZ/Sn+s1muNpVrb8uMMIgjfhX7p3EsBAXxi63lprsbOuyv9
 eNtWGCynq2o5R/78XNvnbqH2hyGJOA8Gl/Qi5XoWRQHu5WUXQvlUploN0krRAj/x
 tEPHhcAv+vD8OYCKcIidKH+0yOXPgzn4DDVu1SCLJgLGsMWzkgfhjMfh2tr5qIOX
 tvbWLoXsICY0xctNXqMHkw88KM2fQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrndb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 13:27:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63ODKNuZ012882;
 Fri, 24 Apr 2026 13:27:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkytyg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 13:27:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63ODR5Zo21234280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 13:27:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A89258059;
 Fri, 24 Apr 2026 13:27:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37CD658058;
 Fri, 24 Apr 2026 13:27:04 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.79.186]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 13:27:04 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH] tests/functional/s390x: Update expected virtio-pci IDs
Date: Fri, 24 Apr 2026 09:27:03 -0400
Message-ID: <20260424132703.833249-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S7y0c4iQR2p6I9jMCPogHfMvIUqy3U1q
X-Proofpoint-ORIG-GUID: S7y0c4iQR2p6I9jMCPogHfMvIUqy3U1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDEyOCBTYWx0ZWRfX/ALrDvQ3rkue
 /xmf05XA0qfdodwgYoL7Q5WAfqLk8I348R/ERCyaM4B0YKOc0lP3Y3Fvc6D9NfbfgUWdvx1Wh5e
 vbcLOHzjRgnc6gGqJthvQPXRYUIDBYEhkU22HZaO7OXswaGUNmj0UFPBupjExgR4JxwmgWfcJoj
 UWCc4upE1HYPaB/+dfX7qGsfbvR43U4KFetR8zrhjOQ0lp94lvj29wAfEjAPGiTcr4sA3l24xoW
 o2X0Da8T9HL0bdBcrjXN7NFLPeDPRpUgkz+RWpVjeF8twfBlccSFSn10BBseWdcAk0Xd3Ck5aRu
 lQysQJXWVbkA64RG6lZMkjq3H7/I9EsMxNq2ewqsq1OFWkYwVdgTJVY9WpQY1Ox2s0jI+83p03X
 Ae0yB9y/uzNzaV3vtuJLZQgHiu/FmX78OYR/XA/orlGsOMnc4KdRLoV0NqXDn1djhpSoKPEgeuo
 wxnpufRZXnQAg8ZwxYQ==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eb6fab cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=7nMS0yjKHXQJnQQSu-oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240128
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Now that legacy virtio-pci is disabled by default for s390x, adjust
existing testcases to look for appropriate device IDs.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 tests/functional/s390x/test_ccw_virtio.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
index 0455337856..1d4958bbe2 100755
--- a/tests/functional/s390x/test_ccw_virtio.py
+++ b/tests/functional/s390x/test_ccw_virtio.py
@@ -136,7 +136,7 @@ def test_s390x_devices(self):
                     r'0x1af4')
         exec_command_and_wait_for_pattern(self,
                     r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
-                    r'0x0001')
+                    r'0x1100')
         # check fid propagation
         exec_command_and_wait_for_pattern(self,
                     r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
@@ -203,7 +203,7 @@ def test_s390x_fedora(self):
                         'while ! (dmesg | grep enP7p0s0) ; do sleep 1 ; done',
                         'virtio_net virtio0 enP7p0s0: renamed')
         exec_command_and_wait_for_pattern(self, 'lspci',
-                             '0007:00:00.0 Class 0200: Device 1af4:1000')
+                             '0007:00:00.0 Class 0200: Device 1af4:1041')
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/net/enP7p0s0/address',
                              '02:ca:fe:fa:ce:12')
-- 
2.53.0


