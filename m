Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C6FC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQ6Y-0002hA-Mq; Mon, 24 Aug 2026 04:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wyQ6R-0002YO-Ar; Mon, 24 Aug 2026 04:32:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wyQ6O-0005BC-6a; Mon, 24 Aug 2026 04:32:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5VYcH4031334; Mon, 24 Aug 2026 08:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=myHknGNMNuxsEUxc6
 nCjOYMMrftQ8JyyUDpwjo80qX4=; b=f5cd93ZY/moa4Dlz8gGkXFK1S8z///6Po
 rkWYmUQDK+8iNrGD3fgRyauuNfjJ9NfdJKGPDw4KvzNjfVnVIO24Mvuqmc0jCaPZ
 aQL78cQbMC2HofHWDy2vQtwgPJnmHVfx9NSiXrXwAJZ91ynEDXHAZsQPg1AuFu4H
 u+KF4Ko3OIRnhzpXgqhs6Ns/GbBcznPC+dRjehPzpDhSEYHlZzjn/uIz8aOM77Ia
 4V1kJed8MkfjWSP2N4VSIm4CkU5798OZIKtngSSgzW+ZY5F7ULAzK+PDxjUxKmlw
 gIXgnV9DznKVei9q488fprQf9KPa/KxqYeU3hLKIV4OA46xbxG/SQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e84pb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 08:32:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QQCM017371;
 Mon, 24 Aug 2026 08:32:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jmtry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 08:32:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67O8W9ou51904966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 08:32:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D14D20040;
 Mon, 24 Aug 2026 08:32:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 633A32004B;
 Mon, 24 Aug 2026 08:32:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 08:32:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 19/20] docs/s390: Document CPACF instructions support
Date: Mon, 24 Aug 2026 10:32:03 +0200
Message-ID: <20260824083204.40877-20-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c018e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=IlYB4z8HrC9mJJy16gAA:9
 a=5wi_FRADO1KgGG3s:21 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfXz4xX4bVy28yW
 Ss0QuoUWURgCVr0AVK11XNnq1FzKDFdORMnPYHF48/DT5Vov8vSbtYkzfSypdA31QKFtMdncMmx
 9PqxN+BNLJhSxDMFE6hOQXu0zRWflCc=
X-Proofpoint-GUID: vQyQSp1N4WYh8ejdgGNUa9Ov3oRfNHsP
X-Proofpoint-ORIG-GUID: vQyQSp1N4WYh8ejdgGNUa9Ov3oRfNHsP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX63BsbBZ3+cGK
 nEzqKYZE2Ptt/OPvGYWHxbw118wmIPgFps8GE8O5Us4kS7geWKqb+Uh0iJwzWyUKzTykEFc8QVU
 oFiScJRV3AAriTVTM6kJpWsdeR6T4UP2RQAzpinPnvVtQWSvmtCIoVgDsMJUl2ly+NSh4wWoYW4
 OVxdiDoxvkTtJcKGaT01xWnCAZ/m9CfXExHKiGepiuyG3NpsCN0tNWWtjC8Tkb1hI75pxORWIzd
 kfghlW4t+LzkZWZfahveaMO4ZPVQ/CmqUNUKzU80IXH1ZU4rrybM/Q6da2A4wveVPBCZClNXsJb
 RuNYhhKNb0WMTVpIauwfxxvBy6f9U4E7X2UHFMwcPYTve5yya5QxEJx4u5ZOTMDIgmMP+e1KP/Z
 JclBaarCz9vQ2QzjRn+4cwLenHpqA8VJ5fR/BFv2Wvl1YRgTRUYBxkUcLEvXyTFebNwCXGtVSq8
 MLYhe6Un9eWA3w2vyHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Add a first document covering the Qemu s390 CPACF instructions
and functions supported.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 docs/system/s390x/cpacf.rst  | 143 +++++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst |   1 +
 2 files changed, 144 insertions(+)
 create mode 100644 docs/system/s390x/cpacf.rst

diff --git a/docs/system/s390x/cpacf.rst b/docs/system/s390x/cpacf.rst
new file mode 100644
index 0000000000..c68aa74abe
--- /dev/null
+++ b/docs/system/s390x/cpacf.rst
@@ -0,0 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+CPACF Support
+=============
+
+CPACF
+-----
+
+CP Assist for Cryptographic Function (CPACF) is a hardware-integrated
+coprocessor feature built into every  processor core of IBM Z and
+LinuxONE mainframes (s390x architecture). It provides high-speed,
+hardware-accelerated encryption and hashing directly on the CPU.
+
+CPACF provides a set of z/Architecture instructions (known as Message
+Security Assist or MSA) that execute cryptographic operations
+synchronously with the main processor.
+
+- Symmetric Encryption: Support for AES (128, 192, 256-bit), DES, and
+  Triple-DES (TDES).
+- Hashing: Acceleration for SHA-1, SHA-2 (up to SHA-512), SHA-3 and
+  SHAKE.
+- Random Number Generation: Pseudo Random Number Generator (PRNG) and
+  a hardware-based True Random Number Generator (TRNG).
+- Asymmetric Support: Elliptic Curve Cryptography (ECC) primitives
+  P-256, P-384, P-521, Montgomery/Edwards curves (e.g., Ed25519).
+
+Documentation about CPACF instructions is publicly available and
+can be found in the "z/Architecture Principles of Operation"
+accessible at the IBM documentation hub https://www.ibm.com/docs/en.
+For example the latest version as a pdf is available here:
+https://www.ibm.com/support/pages/zvm/library/other/22783214.pdf
+
+
+CPACF instructions
+------------------
+
+Here is a list of implemented CPACF instructions and the supported
+functions for each instruction:
+
+KDSA (COMPUTE DIGITAL SIGNATURE AUTHENTICATION)
+- Function code 0x00 - Function Query
+
+KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST)
+- Function code 0x00 - Function Query
+- Function code 0x02 - CPACF_KIMD_SHA_256
+- Function code 0x03 - CPACF_KIMD_SHA_512
+
+KLMD (COMPUTE LAST MESSAGE DIGEST)
+- Function code 0x00 - Function Query
+- Function code 0x02 - CPACF_KLMD_SHA_256
+- Function code 0x03 - CPACF_KLMD_SHA_512
+
+KM (CIPHER MESSAGE)
+- Function code 0x00 - Function Query
+- Function code 0x12 - CPACF_KM_AES_128
+- Function code 0x13 - CPACF_KM_AES_192
+- Function code 0x14 - CPACF_KM_AES_256
+- Function code 0x1a - CPACF_KM_PAES_128
+- Function code 0x1b - CPACF_KM_PAES_192
+- Function code 0x1c - CPACF_KM_PAES_256
+- Function code 0x32 - CPACF_KM_XTS_128
+- Function code 0x34 - CPACF_KM_XTS_256
+- Function code 0x3a - CPACF_KM_PXTS_128
+- Function code 0x3c - CPACF_KM_PXTS_256
+
+KMAC (COMPUTE MESSAGE AUTHENTICATION CODE)
+- Function code 0x00 - Function Query
+
+KMC (CIPHER MESSAGE WITH CHAINING)
+- Function code 0x00 - Function Query
+- Function code 0x12 - CPACF_KMC_AES_128
+- Function code 0x13 - CPACF_KMC_AES_192
+- Function code 0x14 - CPACF_KMC_AES_256
+- Function code 0x1a - CPACF_KMC_PAES_128
+- Function code 0x1b - CPACF_KMC_PAES_192
+- Function code 0x1c - CPACF_KMC_PAES_256
+
+KMCTR (CIPHER MESSAGE WITH COUNTER)
+- Function code 0x00 - Function Query
+- Function code 0x12 - CPACF_KMCTR_AES_128
+- Function code 0x13 - CPACF_KMCTR_AES_192
+- Function code 0x14 - CPACF_KMCTR_AES_256
+- Function code 0x1a - CPACF_KMCTR_PAES_128
+- Function code 0x1b - CPACF_KMCTR_PAES_192
+- Function code 0x1c - CPACF_KMCTR_PAES_256
+
+KMF (CIPHER MESSAGE WITH CIPHER FEEDBACK)
+- not supported
+
+KMO (CIPHER MESSAGE WITH OUTPUT FEEDBACK)
+- not supported
+
+PCC (PERFORM CRYPTOGRAPHIC COMPUTATION)
+- Function code 0x00 - Function Query
+- Function code 0x32 - compute XTS param AES-128
+- Function code 0x34 - compute XTS param AES-256
+- Function code 0x3a - compute XTS param Encrypted AES-128
+- Function code 0x3c - compute XTS param Encrypted AES-256
+
+PCKMO (PERFORM CRYPTOGRAPHIC KEY MANAGEMENT OPERATION)
+- Function code 0x00 - Function Query
+- Function code 0x12 - CPACF_PCKMO_ENC_AES_128_KEY
+- Function code 0x13 - CPACF_PCKMO_ENC_AES_192_KEY
+- Function code 0x14 - CPACF_PCKMO_ENC_AES_256_KEY
+
+PRNO (PERFORM RANDOM NUMBER OPERATION)
+- Function code 0x00 - Function Query
+- Function code 0x72 - CPACF_PRNO_TRNG
+
+Not listed CPACF instructions (KMA) cause an Operation Exception when
+used. Instructions with only query function support (KMF, KMO, KDSA)
+perform register validation and raise a Specification Exception for
+invalid registers or non-query function codes. The query function for
+these instructions will return a function status word with all but the
+query function bit set to 0.
+
+
+Protected key support
+---------------------
+
+The qemu version for protected key support is only a fake provided
+here for developing and testing purpose:
+
+- The protected key is _derived_ from the clear key by xoring the
+  fixed pattern 0xAAAA... onto the key value.
+- The AES Wrapping Key Verification Pattern is a fixed value of 32
+  bytes 0x0F0A0C0E0F0A0C0E...
+
+The PCKMO instruction implementation does exactly this - _derive_ a
+_protected_ key from the clear key given by xor 0xAAAA... and writing
+the fixed value for the WKVP of 0x0F0A0C0E0F0A0C0E... into the blob.
+The other subfunctions of the CPACF instructions dealing with
+protected key treat the protected key blob by first checking for the
+WKVP (against the fixed value of 0x0F0A0C0E0F0A0C0E...) and second
+_decrypting_ the key value by xoring 0xAAAA... and then execute the
+clear key operation with the decrypted key value.
+This is suitable for testing purpose but such keys are not for real
+production load and would open up a huge security breach!
+
+For more details about protected keys see the "z/Architecture
+Principles of Operation" document chapter "General Instructions"
+sub-chapter "Protection of Cryptographic Keys" and again the
+implementation here does NOT implement what is explained there.
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 94c981e732..49159826eb 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -35,3 +35,4 @@ Architectural features
    s390x/bootdevices
    s390x/protvirt
    s390x/cpu-topology
+   s390x/cpacf
-- 
2.43.0


