Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B4ECD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTc8-0000t2-LQ; Mon, 11 May 2026 12:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wMTc2-0000rl-Ub; Mon, 11 May 2026 12:36:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wMTc1-0006X9-05; Mon, 11 May 2026 12:36:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BE3Q5d3734928; Mon, 11 May 2026 16:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=p3N+rilPYtKel0Q8PnGtDYn7jBaf
 LMECY0oHuIH7gYk=; b=OuDbvtGlfAVJOI+JxUa8mOMSBSwxzIGucffejHjqtyAr
 kVX836+r9QC3P7mdbYaU4F4W1awmXsalF46/KY2BvK2d8KumrKTocLdKlHU3p/zt
 h5oI3M6eqyEIGlAq6y1k101BqdivaUQ9Wje/Zx6BID01pxrCGq5NrV8DORu+19MS
 i6WZIhlc+fXlQxjkpi3nOlYb58fpfDaTkINcvbo8VtZnC4wLV+cPXSTphdacqyNO
 GUT+vFRsXSmTA9V05GzO8wFh3fzCRsG3pMSzmQgqofagtTheAC0Yha16NXUPHnCM
 JPbiGk0WAnXI56YbLF15PDe3RkC7AWmXi+apFSdvCQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqs7wq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 16:36:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BGOSpm003427;
 Mon, 11 May 2026 16:36:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg5xf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 16:36:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BGa1dN29950660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 16:36:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 993F32004B;
 Mon, 11 May 2026 16:36:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 715D120040;
 Mon, 11 May 2026 16:36:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 11 May 2026 16:36:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 574E0E04CB; Mon, 11 May 2026 18:36:01 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH] target/s390x: restore cpu_models for system builds
Date: Mon, 11 May 2026 18:35:41 +0200
Message-ID: <20260511163541.192533-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3OCBTYWx0ZWRfX4dVJhSZzALL5
 Zy0u1Ak5qjk7lbJa/KPP/bY+Dhf497HmtVygSHznfn7W5hgpskj9Pbolf6xJuyTpIC8NoHSlEvt
 rcS1YTI6lt4vRHfPCjmTsZPgTRG2TnFETY9bQE8yofvcPWdq4EW+I5VqCziywInfPZv/WVOQoli
 D+RwzNkyv5lbHnmfgt3ngAyVrFyJYtmxuR3yyv2Kmg0TbiXmEBoMM3X0Bx1xgOupaoUx4hdP0M7
 KYTQS0ze5rAhbMOsyyGMMuGY5nFy4Nm2GwB/tGWS0opFCC+qvVSYKgz1E9i774bL10vO8etCUXI
 m/L0ZgKhlc9qc87m5qfopkplXD+M786CyGtbdakjiYkpJelGqXlaGwDLnTaNQjWaPZDh+Bmy6OE
 yZr9zmBQwUkxUDgNLtt9VAqk00N7CM2tWq5HAu1+97o86XJG1NMUxSYmzfsSjeGzA4os2Rq2Ucj
 6r0qloemnB5jydDTkNg==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a020576 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=Q0zCPe2PezqXMeAF0QAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: h5m7pnrd04Yzp6K1SnNj2xh8ccTUuhIb
X-Proofpoint-GUID: h5m7pnrd04Yzp6K1SnNj2xh8ccTUuhIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110178
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

Commit 0b83acf2f05 stated:

    Introduce a source set common to system / user. Start it
    with the files built in both sets: 'cpu_models_user.c'
    and 'gdbstub.c' No logical change intended.

Except that's not true:

    git show 0b83acf2f0 | grep cpu_models
        with the files built in both sets: 'cpu_models_user.c'
    +  'cpu_models_user.c',
    -  'cpu_models_system.c',
    -  'cpu_models_user.c',

Restore the s390x_user_ss section, move "cpu_models_user.c" back
into it, and re-add "cpu_models_system.c" to the common_system
section.

Reported-by: C=C3=A9dric Le Goater <clg@redhat.com>
Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson sou=
rce set")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 44f58ac291..6adc2b896d 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -22,7 +22,6 @@ gen_features_h =3D custom_target('gen-features.h',
=20
 s390x_common_ss.add(gen_features_h)
 s390x_common_ss.add(files(
-  'cpu_models_user.c',
   'gdbstub.c',
 ))
=20
@@ -38,6 +37,11 @@ s390x_common_system_ss.add(files(
   'mmu_helper.c',
   'sigp.c',
   'cpu-system.c',
+  'cpu_models_system.c',
+))
+
+s390x_user_ss.add(files(
+  'cpu_models_user.c',
 ))
=20
 subdir('tcg')
--=20
2.51.0


