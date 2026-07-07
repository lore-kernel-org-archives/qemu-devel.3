Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F86FC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFPr-0002cV-RG; Tue, 07 Jul 2026 19:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFPq-0002bp-17; Tue, 07 Jul 2026 19:41:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFPo-0006Ir-44; Tue, 07 Jul 2026 19:41:25 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmNT1920595; Tue, 7 Jul 2026 23:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jv18ys
 t7qaP0DLP5c+LuJvnW5VF+SH9SY83Jw4PKyMQ=; b=CpW8WsKP0cwM9z7T9Ac+H2
 X2V1zvkTcAi+ducJ7WVIrrWbGlAhpR7h7XECgau7T7fxEzmwIgac/jRuuWUlb6yv
 pBHIt4b69n1qoWTfsCY1je+9dGE+bHKvAVf3f/rmrlizY/LY82Kcm4VK7g6Ooh5f
 h0ZDQWX0+6i2jojqzoOQrL2gJEQv58GY0161tZgyWqorgwQ2jGzf88zUynBkPIvz
 sBeZ1AqCtNIDooQaQHfJ7G8L20dBiBSrDHdMHS5P8noYW2epfMUyumYnj5BV42cE
 PUJ2+kXY8f/3/qWZSaX0YM5xwNYZFYeordgS958KWzCAKtAffUz9RM9nHwypNBoQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3sva5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:41:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667NYeH4019448;
 Tue, 7 Jul 2026 23:41:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y4t3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:41:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NfHhc47907284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:41:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D5CA58056;
 Tue,  7 Jul 2026 23:41:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DC5158052;
 Tue,  7 Jul 2026 23:41:15 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:41:15 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v16 33/33] docs/system/s390x: Add secure IPL documentation
Date: Tue,  7 Jul 2026 19:40:46 -0400
Message-ID: <20260707234047.2499921-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707234047.2499921-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707234047.2499921-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4d8ea0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=q5T4S90kAAAA:8 a=xOmL8MRHFtDrr2fuNQ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=LnBBZQxPVJ0Z7KJyRdxh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIyOSBTYWx0ZWRfX3D4jn/4CSynf
 KSVNOlbOcqtc5N4yuAh2RLHE2N76FdJoytYMi7AxFCOze62pRb27WYk0SihVy7MDfr+Kir+jYIc
 GaKpjMBXQ4ivO6hbPiTPGe3ttfm5SwQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIyOSBTYWx0ZWRfX6j3+9h9eNSJK
 D3O53lpOhowVMeXisorA35i2XrgTndZUlmkJpmkwLuws14Vo1gJEE+Kjpo5dqHpv3CDn90VlwNc
 oMFh9YUqegSBAgRbgH68MMeY4goIinyKU6PTRa/UpcCRaLWoeHGWBjUM1LUwqPOwWWvLlHORXB2
 QXWfG2TQ/MtaRTRXMJhADphCbgJfbeeLTl7FXZVP2Q6fkeH4yMvdRYYjIoMy96jR8ezWHP3jgvj
 nndRSuE4tv+gHBXaKS7LFCt0YGevhkFyiQAvoBuBUbwey5FvQYQwIzPS9GcNP1T+mWLjFESmMv7
 C5v/UeN5Jo0GxSg3M49l9HGeg0dgLB1/hPt82D1mf9g6jd9TEtZnOWWWvYvSmZgMkrm0mNUtjX5
 0pHeW7LawHlnwLm83SU0R+KAZFiOer2xqRWrCwevMBO1QNdBjDbcG3n87OkgJphxAe7MOLCj+xN
 woSoTJGP+rWOMTr05vA==
X-Proofpoint-ORIG-GUID: oIbZV696dnvXfS_Ool4uNtScHE-2tOOa
X-Proofpoint-GUID: oIbZV696dnvXfS_Ool4uNtScHE-2tOOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070229
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

Add documentation for secure IPL

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 docs/system/s390x/secure-ipl.rst | 103 +++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index c8fb887ac0..67de20f47a 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -1,5 +1,22 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+s390 Secure IPL
+===============
+
+Secure IPL, also known as secure boot, enables s390-ccw virtual machines to
+verify the integrity of guest kernels.
+
+For technical details of this feature, see the
+:doc:`specs document </specs/s390x-secure-ipl>`.
+
+This document explains how to use secure IPL with s390x in QEMU. It covers
+the command line options for providing certificates and enabling secure IPL,
+the different IPL modes (Normal, Audit, and Secure), and system requirements.
+
+A quickstart guide is provided to demonstrate how to generate certificates,
+sign images, and start a guest in Secure Mode.
+
+
 Secure IPL Command Line Options
 -------------------------------
 
@@ -79,3 +96,89 @@ Configuration:
 .. code-block:: shell
 
     qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
+
+
+Constraints
+-----------
+
+The following constraints apply when attempting to boot an s390x guest in secure
+mode:
+
+- z16 or "qemu" CPU model
+- certificates must be in X.509 PEM format
+- only support for SCSI scheme of virtio-blk/virtio-scsi devices
+- a boot device must be specified
+- any unsupported devices (e.g., ECKD and VFIO) or non-eligible devices (e.g.,
+  network) will cause the entire boot process to terminate early, with an error
+  logged to the console.
+
+
+Secure IPL Quickstart
+---------------------
+
+Build QEMU with gnutls enabled
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block:: shell
+
+    ./configure … --enable-gnutls
+
+Generate certificate (e.g. via certtool)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A private key is required before generating a certificate. This key must be kept
+secure and confidential.
+
+Use an RSA private key for signing.
+
+.. code-block:: shell
+
+    certtool --generate-privkey > key.pem
+
+A self-signed certificate requires the organization name. Use the ``cert.info``
+template to pre-fill values and avoid interactive prompts from certtool.
+
+.. code-block:: shell
+
+    cat > cert.info <<EOF
+    cn = "My Name"
+    expiration_days = 365
+    cert_signing_key
+    EOF
+
+    certtool --generate-self-signed \
+             --load-privkey key.pem \
+             --template cert.info \
+             --hash=SHA256 \
+             --outfile cert.pem
+
+Sign Images (e.g. via sign-file)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+- signing must be performed on a guest filesystem
+- sign-file script used in the example below is located within the kernel source
+  repo
+
+.. code-block:: shell
+
+    ./sign-file sha256 key.pem cert.pem /boot/vmlinuz-…
+    ./sign-file sha256 key.pem cert.pem /usr/lib/s390-tools/stage3.bin
+
+Note: re-signing a component will not verify correctly; the existing signature
+must be stripped before a new one is applied.
+
+Run zipl with secure boot enabled
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+- zipl must be performed on a guest filesystem
+
+.. code-block:: shell
+
+    zipl --secure 1 -V
+
+Command line options for starting the guest
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=cert.pem ...
-- 
2.54.0


