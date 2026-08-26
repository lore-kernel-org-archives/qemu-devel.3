Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A87C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzF4x-0005J2-9v; Wed, 26 Aug 2026 10:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzF4t-00057F-PR; Wed, 26 Aug 2026 10:58:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzF4q-0000n3-Dw; Wed, 26 Aug 2026 10:58:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1fkC4099728; Wed, 26 Aug 2026 14:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MAkJaYqiWnnlJyEkS
 y6absQ9VS0rhls4MrY208GZmAU=; b=NSsW4tcqtuRNX2r7tcbjP9mec5Kz/6IjK
 /Zcyiy3q2JEK5CAF8iKDCqSadrzwdT5GvAz2DliHQOdZCeVAq4xvc6/R8IuUjVKJ
 Y+/LzxdLbOIu38XyZLtqgCfE7M+mfi35PI4K5bWBKy9JGW5FQqLyJgULgdg58lhY
 uvXG1QuCN0kZRLC6Vxi6Quh8vZuujQ7Wh6elHbhvlbMqvAH8DrCVT5Kw/sFRTdya
 Hgu+mqLlrk7Nlw3uUFN23yoGpl4BQ5QWdQmEJBWlFn7eHKIesXvQOfYd2zsn7iRr
 QEVGpMCOriTmsaw+3GIHGypm+vWF5LEnrdJ0caaA/QItTbZgaqfTg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hyfyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:58:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuH4e020643;
 Wed, 26 Aug 2026 14:58:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwanf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:58:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QEvvow16122160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 14:57:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA41C2004F;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B252A2004B;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id 94F7E162533; Wed, 26 Aug 2026 16:57:56 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v2 2/3] tests/functional/s390x/test_secure_ipl: Skip test if
 SIPL not supported by hypervisor
Date: Wed, 26 Aug 2026 16:57:55 +0200
Message-ID: <20260826145756.2324598-3-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826145756.2324598-1-jdaley@linux.ibm.com>
References: <20260826145756.2324598-1-jdaley@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX2xkZCQ6LuLLB
 5H7Ne1D2oAxKprAPzTWez6oQWywKuphQ3NNIrGnkwxiEIsUY0Now4xCSjffdmzotEcwn9yBqYOy
 AOzvWUIA05JDxYdjOSyfUwU0rD56TCM=
X-Proofpoint-GUID: KzVgAT8eCumm4rL_Tgvt3r_04NUqXDCJ
X-Proofpoint-ORIG-GUID: KzVgAT8eCumm4rL_Tgvt3r_04NUqXDCJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX5zGW47hiWXVR
 cLhZXbQ4tgCzaKzRFgv2izhCcUojokKo0q7pv1xSH6wU5euer1OF0oDtAhPiWXX6X8RlZwTPYrl
 BSByjIAWVQmb/jJjI0iY24RDtxzqEvsRnhLZxX300ufQpaqH1PA4mFV/3WzFZyvClChw+jAOguH
 jbCkYFr+CWlQDzX40HNcaMtRx0Fj71GrJwRwJskzLkcm6hB5l3zzE9Akj7EuDaUyp0+N/4c3byP
 pZ7fnKAPQ6DuOFAE2WOJZbKzVPO3DGUUzOeVDzGQ88RxV0OeKqqceEJnpVPFjtIPws5RkMPOekw
 bmaqpaCxhmNRoHfyGvjYZ9YjLSH3Amti0q7JCR3uJGIGOCYiJOg3tpYkJxkSZbIZxjabiPsJ3Zo
 U6or046hMdlOsRQQZKmRKIq3L/D3a3S5M4nPAB9vMof09vjt/swJQm9grHVU6e8LQytOc1I50jw
 EV9iGuMZihOgrdePllQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8efefb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=UZxYUTtkSsvthtqRCrcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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
index 06fc93e404..5af36b91d8 100755
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


