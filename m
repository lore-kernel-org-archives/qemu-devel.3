Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67E8C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFee-0001qV-JR; Tue, 07 Jul 2026 19:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFec-0001oj-0T; Tue, 07 Jul 2026 19:56:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFeY-0002kt-QD; Tue, 07 Jul 2026 19:56:41 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MncaM1574072; Tue, 7 Jul 2026 23:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jv18ys
 t7qaP0DLP5c+LuJvnW5VF+SH9SY83Jw4PKyMQ=; b=pPC3MD9PDjL7um1dZ3ynNt
 foodPrEi5t8eXi/f13KdRJ95W5Itz/NsQBQvL2R7ESfldLh0eEvUKiX017ke2SRx
 YoeN3Qh614RZw1lzrWv/4H82ZlbI1QuFnh1DOKs89OjZZv4NmdctSra8VN26Y7kl
 rlF0qqvC/gfXgzyxtgzyXNetc6ChpVgTvJd1pVJ6jEmw9ujDRcy4layt50TLNcB1
 9rhWU85zN77buKdjmZNkHcyWBhOXs/si5Tz+rnJMDsWMbOkwavUgrKszfDJYV74r
 2CayFSWpN78IVLsKO0wLaTuMV7RAzQRndtCfLpCoOUf/g3LY6YJP1zUC2SO/6JmQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknhekm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667NndHh008229;
 Tue, 7 Jul 2026 23:56:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hd2m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NuN5p32637532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:56:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4926658056;
 Tue,  7 Jul 2026 23:56:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E499C58052;
 Tue,  7 Jul 2026 23:56:22 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:56:22 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v16 33/33] docs/system/s390x: Add secure IPL documentation
Date: Tue,  7 Jul 2026 19:56:07 -0400
Message-ID: <20260707235615.2513487-13-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4d9228 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=q5T4S90kAAAA:8 a=xOmL8MRHFtDrr2fuNQ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=LnBBZQxPVJ0Z7KJyRdxh:22
X-Proofpoint-GUID: upohqDn5kpSJM_lOxvxY-YryagChPon_
X-Proofpoint-ORIG-GUID: upohqDn5kpSJM_lOxvxY-YryagChPon_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX6eLcfmlifmjI
 hdC2MsCQjJqHVoyhIEOQaUU0IrvyKdMKprAENXURnsY5YD2iGpCnXr11YVcE0z2S/+MdEsK9SMr
 cFIgoVoKuV7lzJxHGKJzjlYmV6wpPXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfXwLn2iGzOLM+7
 8VFnOscFC6Ql+2PVL9lmbz7C9bSmZV3ivipLFkU96XAZ3dvMQDZimQ/ItmRrNimLXuPZaECTuHR
 ntvqDUUIuy6VyGzeJkiNwdOpj7UCEI1FBzJst25WW6KwLhsfAXDMQa0hweVBOuqWd4+r/a8YvYJ
 PvDVT0GdR9i56stXBIKRXRND4DS9gombcE3G+Kujo8FTm8/CHp51pnX+u7RhnopQ3Od7OxHWXly
 j+svKTUtnyHHyU/+urJzoH7D+mjirMxuRpp/DF5Ax/9rhlCXUKRla5UfLvoDu7I6ZxUbKiqcbqW
 +66UPn3XWlx8N4usM8JZuBTiADyZr4c3bGSbCZ7sgJtBTr+Wq0mUVc126HTVUJ799Fz9anTvf19
 UPoeJVrnFWvOn94fiQZqHO0RkrhE2GRxraa2WWbLhmF/nXUq84jlHmqp/IBDIO7t2RbMyM6Q9FA
 03P8iwtPexXd0G17AfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070233
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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


