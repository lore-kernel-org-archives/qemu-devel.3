Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB58C982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kK1-0005tQ-0g; Mon, 21 Sep 2026 16:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJq-0005l4-C5; Mon, 21 Sep 2026 16:08:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJl-0005Nu-Ec; Mon, 21 Sep 2026 16:08:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8UGv1860730; Mon, 21 Sep 2026 20:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IXQb1T0BseVH5ND5k
 A8soZ2S0NaNEA5/77jGxglATFI=; b=j2WStmqDmsLqZNlAwuTkjyfvwOb84qQEd
 AtJFHzwHxLntDmAX8cBpTtphtrue7Da7K/VB/k+OdIsEpimVJvKr5ZLNkSCf9M1T
 q4QrzbKd0AdeYnNpW7oWs09z4Y3zOORPPIZbBftkFRYg+UAvZ5jZIJRGZxlF2Tr+
 47I7Yi8NQJQHho8bJDCqY2MqafTBBPEq+3t4M7OPghsCxcrzIUq5AbAPecqr/iEi
 K8Xz9yTzFC42HIbjxIV0S6KkdOBYx8qrcVdIKo5v1KVvpN1Rhr1n2da2jk6oHsW5
 TAI58F7z4Xaz4PFGStYzbXEGfrwOg/f/HLee+RbrFv1pg9Fbb0e8w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ah4t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJ0keQ1451434; Mon, 21 Sep 2026 20:08:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gpu55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8jcw25428550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A5A558043;
 Mon, 21 Sep 2026 20:08:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88E4D58055;
 Mon, 21 Sep 2026 20:08:44 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:44 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Joshua Daley <jdaley@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 22/33] tests/functional/s390x/test_secure_ipl: Skip test if
 SIPL not supported by hypervisor
Date: Mon, 21 Sep 2026 16:08:19 -0400
Message-ID: <20260921200830.1302919-23-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lt6hVkWlDLnDeYgd5lC58Uylr4V1N-rF
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab18ecf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UZxYUTtkSsvthtqRCrcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX5OzxFHXBVZT1
 ZmMs+c0Xev3fEkQ6h6FbYN75ka56Xwl83Dlvrh6OjSrlJZQL5b2TJA3oAirOQw36/VOxONtpxxA
 6L0Q8bvBK0SuEWZVdA2+iy90kKQf35u1v86jOKEUfxNqWPAjsXEPhgswRw3IqTKaVn3rVOIcV15
 yV4f7iiumhhIQgaxoLY6SACAa4TCnCOLcoRU42lGV7xRdSjLy4YxrO/+3t2qaU+aPjQgjUEoaMK
 3dqKKQSmGc6HHqUSdjBOujpIcyC+yLyvnaa1O7Pi0I2cBEqblzAH7PpliIUHTXI25h1AWuePl9K
 T216+9hwNl9T75Cw5h9Eo5HntnY4EK5KqvEx3WOiUhYgX8dXzyBRBExMpuF8h2DK8JBM5rVwJ8Q
 ZFHtQVSslgVpxUkQhq1zZIxmBvayVPLkEwE0jJNqTNcjDQ3vOfOsmuIPv042b52JnqoWokKxTQt
 GxWOaxCLR8X5Z2gv+8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfXxFCM2zxCSkaP
 +mYFCN1GWKf+ESDszgytA3QOK/rT39uS+HZWqaGrlN5Uuon/M3kJpKzfJw+7291pfby5+9hndba
 GFHSXNZss8Dl109Oj4yt9K7COu2dQ+I=
X-Proofpoint-GUID: Lt6hVkWlDLnDeYgd5lC58Uylr4V1N-rF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Joshua Daley <jdaley@linux.ibm.com>

Currently, if secure IPL is not supported by the hypervisor, the test
will fail because "Verified component" never appears. One must inspect
the console log to observe the cause of the failure.

Add a check that skips the test if the host CPU model is missing the
secure IPL facilities.

Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260903155805.1881366-3-jdaley@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/functional/s390x/test_secure_ipl.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
index 06fc93e404..5af36b91d8 100755
--- a/tests/functional/s390x/test_secure_ipl.py
+++ b/tests/functional/s390x/test_secure_ipl.py
@@ -29,6 +29,22 @@ def __init__(self, *args, **kwargs):
         self.cert_path = None
         self.prompt = None
 
+    def _require_host_secure_ipl_support(self, vm):
+        """
+        Skip the test if the host CPU model does not expose the Secure IPL
+        facilities (sipl, sclaf, cstore).
+        """
+        props = vm.cmd('query-cpu-model-expansion',
+                       model={'name': 'host'},
+                       type='full')['model']['props']
+        missing = [f for f in ('sipl', 'sclaf', 'cstore')
+                   if not props.get(f)]
+        if missing:
+            self.skipTest(
+                f"Host CPU does not support Secure IPL: "
+                f"missing feature(s): {', '.join(missing)}. "
+                f"Secure IPL requires a z16+ host.")
+
     def _create_certificate(self, vm):
         """Generate x509 certificate"""
         exec_command_and_wait_for_pattern(self,
@@ -107,6 +123,8 @@ def setup_s390x_secure_ipl(self):
                          '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
         temp_vm.launch()
 
+        self._require_host_secure_ipl_support(temp_vm)
+
         # Initial root account setup (Fedora first boot screen)
         self.root_password = 'fedora40password'
         wait_for_console_pattern(self, 'Please make a selection from the above',
-- 
2.55.0


