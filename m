Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F4DCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1U4-0005zW-K0; Wed, 17 Sep 2025 19:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1Ts-0005tZ-AX; Wed, 17 Sep 2025 19:22:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1Tq-0002Ue-Bx; Wed, 17 Sep 2025 19:22:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HITnCw010975;
 Wed, 17 Sep 2025 23:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IaQahw
 mjdXS87XFYtN291F806fRZ4N7/OKF7lW5JSwM=; b=iC70FrcyW4rdQaqYxhJuoc
 epbm2ptM7s9lHyNJ/rXjOX3/OqN4jdZTuFp5HjPh3Zvy+MrXyO6JgCOI6ZgISUQv
 MDyvMq7mfF61US+vDY1sxkoyBjSmJQGG1aOOLDepl6blHuXuUUn1quPsQQbU3hCR
 M91IwGfv6IBC4d/F30/0SRVsV3rR1ZqswijQmZsc1Fp7kwgZfzWylTR4Gl1vfGja
 jyH728kcV8wPw4Z+oG1tUpL+vAQwvyMJ5bqd6R2ODKIZ1aRLGxG/hpc92LzGBFIu
 GKmCMUFn/5yICzw9pGfFfj5UxBzStG1uogVm8PQhFdTomD+wfBNgqOLMM1ouhW2A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4neg7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:22:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HLpxxu018637;
 Wed, 17 Sep 2025 23:22:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mkmau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:22:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNLt8T29950716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:21:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFC245805C;
 Wed, 17 Sep 2025 23:22:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCE745805A;
 Wed, 17 Sep 2025 23:22:04 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:22:04 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 28/28] docs/system/s390x: Add secure IPL documentation
Date: Wed, 17 Sep 2025 19:21:30 -0400
Message-ID: <20250917232131.495848-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cb42a0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=q5T4S90kAAAA:8
 a=pLVlpZFyWxzbV8Ps1vQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=LnBBZQxPVJ0Z7KJyRdxh:22
X-Proofpoint-GUID: x7dMuntE7qES3L8-H5723xoaHE5Kzsq6
X-Proofpoint-ORIG-GUID: x7dMuntE7qES3L8-H5723xoaHE5Kzsq6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX+yWACQa4aOSE
 32fx21dNHg4SjALoBgNJSYFBU41J5xQR23fciB/px1PrJ+4gfTiYYGhEP7ABcGJAA6Ya+4wLURf
 CS+L5269HLhoW2olqJR1s84INhigfqZVls1BCQ014oplKjrSNo0pMsbwElnHbIJk4xlYuCVAFkO
 jnitvXr80kXLpFnRjZO7BsSr/F4ZAy8g43EfICcG7nxs8aLVCTxv4iXrrG8uwqlI0hLrfjdkWDh
 ixWjjWj6+QLfCy68a4hKGhoafUfF6QkHd/U9eMbtvi9LewT9pdByasVbojj6Zfu5S3qZMDkNLQE
 M6aB4duqrqllUBFnhuZuwNtJWKhk84bQNNcTkdB8fch64wiavCDiFHNOC6XdMs2EQnE8/1exMfm
 sTZe92lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
---
 docs/system/s390x/secure-ipl.rst | 96 ++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 579b7b4993..110dea9fdd 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -1,5 +1,21 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+s390 Secure IPL
+===============
+
+Secure IPL, also known as secure boot, enables s390-ccw virtual machines to
+verify the integrity of guest kernels.
+
+For technical details of this feature, see ``docs/specs/s390x-secure-ipl.rst``.
+
+This document explains how to use secure IPL with s390x in QEMU. It covers
+new command line options for providing certificates and enabling secure IPL,
+the different IPL modes (Normal, Audit, and Secure), and system requirements.
+
+A quickstart guide is provided to demonstrate how to generate certificates,
+sign images, and start a guest in Secure Mode.
+
+
 Secure IPL Command Line Options
 ===============================
 
@@ -83,3 +99,83 @@ Configuration:
                                secure-boot=on, \
                                boot-certs.0.path=/.../qemu/certs, \
                                boot-certs.1.path=/another/path/cert.pem ...
+
+
+Constraints
+===========
+
+The following constraints apply when attempting to secure IPL an s390 guest:
+
+- z16 CPU model
+- certificates must be in X.509 PEM format
+- only support for SCSI scheme of virtio-blk/virtio-scsi devices
+- a boot device must be specified
+- any unsupported devices (e.g., ECKD and VFIO) or non-eligible devices (e.g.,
+  Net) will cause the entire boot process terminating early with an error
+  logged to the console.
+
+
+Secure IPL Quickstart
+=====================
+
+Build QEMU with gnutls enabled
+-------------------------------
+
+.. code-block:: shell
+
+    ./configure … --enable-gnutls
+
+Generate certificate (e.g. via certtool)
+----------------------------------------
+
+A private key is required before generating a certificate. This key must be kept secure
+and confidential.
+
+Use an RSA private key for signing.
+
+.. code-block:: shell
+
+    certtool --generate-privkey > key.pem
+
+A self-signed certificate requires the organization name. Use the ``cert.info`` template
+to pre-fill values and avoid interactive prompts from certtool.
+
+.. code-block:: shell
+
+    cat > cert.info <<EOF
+    cn = "My Name"
+    expiration_days = 36500
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
+--------------------------------
+
+- signing must be performed on a KVM guest filesystem
+- sign-file script used in the example below is located within the kernel source
+  repo
+
+.. code-block:: shell
+
+    ./sign-file sha256 key.pem cert.pem /boot/vmlinuz-…
+    ./sign-file sha256 key.pem cert.pem /usr/lib/s390-tools/stage3.bin
+
+Run zipl with secure boot enabled
+---------------------------------
+
+.. code-block:: shell
+
+    zipl --secure 1 -V
+
+Start Guest with Cmd Options
+----------------------------
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=cert.pem ...
-- 
2.50.1


