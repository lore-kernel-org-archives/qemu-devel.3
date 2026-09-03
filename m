Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD4CC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29pV-0000vG-2n; Thu, 03 Sep 2026 11:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x29pQ-0000t1-Rs; Thu, 03 Sep 2026 11:58:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x29pP-0006rK-5s; Thu, 03 Sep 2026 11:58:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DVVLV3109153; Thu, 3 Sep 2026 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=g0sS83CVWjINxaj/6
 JaLK/2VH5IhLQCN7sRJZME22CM=; b=LllS14Bxsop9GwKVA/qXTN/uTE35sYY3K
 0WGlAkqYHUCubkyDoupZ0YLkSrdJra0WeLzVb5jYDuXLXuIPb4dG2REFPEszW5Qt
 g0zbjRJ5FaQgAFw8vPbmLyXepAeJAZBJLgRxTlrYnNOELVjxApk7eZYVnj22XgHM
 KTrzxW9KWBHi919k94X8GrEMdW6C4RhcpNW2rAzaBv2F0pT3kTILGVnKM6aZ82Wi
 zVBS2V6FSYO4aemdy3lcgDUAm8zK7SqGc/La9SafVDkk5RRot4c+xm/IKcl6yxGx
 Mhae2hSWDmunHzHLq2vW93TkFkjzjG6PZQKtGfnGO7fxqcysB2uCQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq555tf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 15:58:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683Fufii014905;
 Thu, 3 Sep 2026 15:58:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hr9v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 15:58:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Fw5A140501628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 15:58:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D70D920043;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A170620040;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id 81A62160DFD; Thu, 03 Sep 2026 17:58:05 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v3 2/3] tests/functional/s390x/test_secure_ipl: Skip test if
 SIPL not supported by hypervisor
Date: Thu,  3 Sep 2026 17:58:04 +0200
Message-ID: <20260903155805.1881366-3-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903155805.1881366-1-jdaley@linux.ibm.com>
References: <20260903155805.1881366-1-jdaley@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfXxh7aUov0AgAj
 tKsPNhZJnxCYcYzY/m1FH93UfK5I9GQAFHC56griw4MGTicH4LiHE9YAj2zZ2FPJoMfENLBJ+xa
 GAjyka+l7yKjpvR3zGUpMHmeGP335jU8Qrz56+SKQlMEu77VmoI8gGkyu1lHcUIssTCWQkxc/MB
 nXLWvCRXCl7KXK341FP1mOLAWYGdeOEnluGoCwv3f5QXA/p8cMWWpavaS5xmZbCjuFzhvImWB3E
 LiC/svT9KnPcZS5CclrE1q1f17RYT+JBX9/TqPrSeSGh7cViaJ0Aco/8l0MCQBJTnqBXHtaWR5R
 3IYsiRZSZrekDo5M6CsOdW6NNr7vtosGTnkH4TPdM2NwwM3uoWvHVztZMtthUXdqI2y2+stl/8O
 ClhUwMJ8ywjgl8qGc75TxV5C8KyEPz2lMW5WHUZDd7qD72LERZE6Eey62ZWAShDMt/M9dnl+aHa
 6OIHIa0SfCyWEeotU1A==
X-Proofpoint-ORIG-GUID: yxgw5xX1rTWmHZ6BLWWVHkTfbwIzI3BG
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a999913 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=UZxYUTtkSsvthtqRCrcA:9
X-Proofpoint-GUID: yxgw5xX1rTWmHZ6BLWWVHkTfbwIzI3BG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfX0scRAjAxnGSV
 x9tCcveXwcxYdjSxVv+RGg2+X4YSJTQXdpXtBvDr3mFI9iJ2ErvwKFfeH/q7DJsSbaQRvQuTpOS
 Mwp6COvKA7NyYgeFA+br2Ni8eFy6hNI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jdaley@linux.ibm.com;
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

Currently, if secure IPL is not supported by the hypervisor, the test
will fail because "Verified component" never appears. One must inspect
the console log to observe the cause of the failure.

Add a check that skips the test if the host CPU model is missing the
secure IPL facilities.

Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 tests/functional/s390x/test_secure_ipl.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional=
/s390x/test_secure_ipl.py
index 06fc93e4042..5af36b91d85 100755
--- a/tests/functional/s390x/test_secure_ipl.py
+++ b/tests/functional/s390x/test_secure_ipl.py
@@ -29,6 +29,22 @@ def __init__(self, *args, **kwargs):
         self.cert_path =3D None
         self.prompt =3D None
=20
+    def _require_host_secure_ipl_support(self, vm):
+        """
+        Skip the test if the host CPU model does not expose the Secure I=
PL
+        facilities (sipl, sclaf, cstore).
+        """
+        props =3D vm.cmd('query-cpu-model-expansion',
+                       model=3D{'name': 'host'},
+                       type=3D'full')['model']['props']
+        missing =3D [f for f in ('sipl', 'sclaf', 'cstore')
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
                          '-device', 'virtio-blk-ccw,drive=3Ddrive0,booti=
ndex=3D1')
         temp_vm.launch()
=20
+        self._require_host_secure_ipl_support(temp_vm)
+
         # Initial root account setup (Fedora first boot screen)
         self.root_password =3D 'fedora40password'
         wait_for_console_pattern(self, 'Please make a selection from the=
 above',
--=20
2.34.1


