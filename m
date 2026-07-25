Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE1DC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbwB-0006cZ-VK; Sat, 25 Jul 2026 08:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wnbw6-0006aL-He; Sat, 25 Jul 2026 08:57:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wnbw3-0005ZA-PP; Sat, 25 Jul 2026 08:57:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66PB5tmD2800363; Sat, 25 Jul 2026 12:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RsCh7Iv4IUpm/luvy
 MauWFJ3TDyIp3sP+j8uJxS5qVw=; b=TNvUj9MgkLTdrNqGih0988OF1ceS3qf5l
 fPfgXcbnXOCGcLWGHiDXkkFYr2R1frCPfDxqlNoKpsoEwPP8PaK77fv+GGxcb/Zl
 xZ4Aiim0rb3tPKGSJh2E+R1Q8Bcb+enr/20f1sExg70zRQjGTBhZSkIGyOaaNLbJ
 JOi/dAGlC6jSxnWf+DJDUZo5mlPJ0mYROxLcR3vqsYZgbNu6k/bJsXep8S2yx8z1
 9cl4dBRrfBlYQZWyGX+9kAF12KpQ7IOyaAu/wO0+gJihUYJFa3rPRkLCNv2wcPFJ
 zdRdCzSL+rwGGaEBptJPCyLoZF2wfXX4VJw797fjX3ugKD8cd02kg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc08c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 12:56:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PCuF4P012968;
 Sat, 25 Jul 2026 12:56:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5h9a06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 12:56:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66PCuqAQ39911902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 25 Jul 2026 12:56:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93C34200E3;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7578F200E2;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 5B2141624F9; Sat, 25 Jul 2026 14:56:52 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 1/3] iotests/108: skip test if cannot access /dev/fuse
Date: Sat, 25 Jul 2026 14:56:49 +0200
Message-ID: <20260725125651.3896151-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725125651.3896151-1-farman@linux.ibm.com>
References: <20260725125651.3896151-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pc2tLdQf__uv-W3jxBgvMZGi90O4WNXo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDEyMCBTYWx0ZWRfX308XvaFjYJZM
 n32OeO7y642fa0PzUxf7ZhX97I0U03DvinIFkAFPrQJjRJEESZHGIhzFoHwXbrZfWNsI/VhsTcU
 IhEzghBj+DwZ0bLDysnS58eKJaZyIqH/c3vNE1i8Tj5YlvI3E/dR1kpHBW1nYm6CYThkMuU0o0C
 2RCGb6Sq/D4QtjSuA7nef6CiQuacOXZjnbWTKZZ/nt7RY8TXShRP6ECK4yyvlBw2JBJJKWU9k1f
 gwo62772fmLeYGVdFkxjf1dIU1bFLEM7bMt6Q1laDvJs1hJdFmXr2idBzpuxP1OgqOLeQDhL/gU
 caam8IgL+E+3hWwtF3KyWci59cayzEPklY+XH+KXu1ztw/duE8LRWxRF7xlXtf4CATDzvW/Oavs
 ume+90/9trNyRiuZ6skWGOoEOqDECRsqpq9pm3tobRDzW4cz/QBD0yBumgSFm6q9RsYkyTBOOwW
 FIbx9srBRLJOKhPtENg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDEyMCBTYWx0ZWRfX52QJxm4kYZ69
 4ttHKM1yeVmxW+tOocCPSrH64SaO5WQnqX5/b0fs7LtAlwn+ShWuxIsxxLrvIyAvV++G02X92OT
 sHvZuQEseu7+G/mPxx/mM5IBe8JPOHA=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a64b299 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=V8WWMFzuk9fVDQPB-bMA:9
X-Proofpoint-GUID: pc2tLdQf__uv-W3jxBgvMZGi90O4WNXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250120
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

This test might fail if the user is not root (or sudo'd):

  fusermount3: failed to open .../scratch/qcow2-file-108/fuse-export: Per=
mission denied

A check exists to try to cover for this, but there are
two potential error messages that signal this case
(per the comment block associated with the check) and
only a skip for one of them.

Add a check for the other potential error message.

Fixes: 9ffd6d646d ("iotests/108: Test new refcount rebuild algorithm")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/108 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index bf808b3512..136007ceaf 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -69,7 +69,7 @@ else
     # or "Invalid parameter 'fuse'", depending on whether there is
     # FUSE support or not.
     error=3D$($QSD --export fuse 2>&1)
-    if [[ $error =3D *"'fuse'"* ]]; then
+    if [[ $error =3D *"'fuse'"* || $error =3D *"'id'"* ]]; then
         _notrun 'Passwordless sudo for losetup or FUSE support required,=
 but' \
                 'neither is available'
     fi
--=20
2.53.0


