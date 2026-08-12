Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A13C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAm9-0002ao-Gs; Wed, 12 Aug 2026 11:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wuAll-0002L3-Oe; Wed, 12 Aug 2026 11:21:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wuAlh-0000M0-S6; Wed, 12 Aug 2026 11:21:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CE2P6U2587089; Wed, 12 Aug 2026 15:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CB5iv2BxgL9xivzva
 fmvxSK1Er6Cd04y+IRMncQ+/I8=; b=CTdc1+mkvZUResJRAvA+20n9BJFljLozK
 03q0UAfTNAIrRlAgqnP9gOW72FOUiVZ2Hh1+dkfcJPvIblhhuVM5QYAB08UaHhXV
 HYYOmEMKI27Oo9Pzf6+CPXFkj4EbjYcuMAEC5OzkZ5MOSZGWMYo/nh//IMuiJBQm
 cRW2jx/w7ouRw7ixdo1PJNaAjlzsZ0LvEjaPPchsKCNAy8QtTW3ZXfXf82hLB7eb
 iT7FvNqAM9Wh457YQDd40+tGpXWVjb/W/s8pMvmvzGuK16HyHWRajW9s1/WS9g1G
 B0BzxFfpum2SjoWSi3Fz8iyadx28Yedb5xcHvMNMljAhSZf41ONDQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23uq33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 15:21:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFBI3C003241;
 Wed, 12 Aug 2026 15:21:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6e1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 15:21:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CFLDUf47448326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 15:21:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B5972004E;
 Wed, 12 Aug 2026 15:21:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC40920043;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id B2AF0161298; Wed, 12 Aug 2026 17:21:12 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v1 2/3] tests/functional/s390x/test_secure_ipl: Skip test if
 SIPL not supported by hypervisor
Date: Wed, 12 Aug 2026 17:21:11 +0200
Message-ID: <20260812152112.3330493-3-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812152112.3330493-1-jdaley@linux.ibm.com>
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c8f6d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=UZxYUTtkSsvthtqRCrcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX1y+DlaVfZT18
 9N/Y5hdXqoo9OVJ+kPvGK5Hebmi+Kfv+HNLGxte3JEaFXvBSzVILzaDgjTkKjBM1137UtC81tjT
 dBgY+/ZEp6Vc7yv4Ig9SY/jC0Lf9kjKTNZW5Oin28ZqfG5Q4fyH/U2S0r6i4DR/GQOtaCfuM5kv
 Mmgfxja5PMybDb7/Ypsrk+2gz1OqSJIgG+GVB9lfNN1opGxjxpGghbcJp1t3kWsKC5+yT1WgZui
 BLEqJDyMP5Pc2FEtwg6ZyK8pH6CJbTkYRdV9zyaCc+CfqoQASBHqltlcqKGakHa90YzIsOV6zWj
 lNekVRaXu4E2dD8XGBMT/ODsKGwl0qqOY19VEd3RdPcvEMbv2SdJmSk8SG/3KhQeNuZ0M+VyEmF
 WZ+mluOP5T1XHSe5QFgU2JL5i8OCGP7i1CIUWnYJ5SQPxsS4zQLLnJwFOzlN2vTJXWwMQouGDiH
 MBTkJH7wI9fq/GvMnpg==
X-Proofpoint-ORIG-GUID: VWcc9MrdVpF2tA5tRgN_jA4i2PPVyqPS
X-Proofpoint-GUID: VWcc9MrdVpF2tA5tRgN_jA4i2PPVyqPS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX0h8cpuQTnwYD
 9w7VXPC90t48Oui76qBL798RkwPA56CHqMamGCxarwgyBA1BSt2mMEgfq6tINaG2GKjaQnMQ+/u
 +B9pECRJAeSzlKdgeoN1UTfBLMgrDIw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120122
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


