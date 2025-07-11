Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2550DC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL2P-00011X-VV; Fri, 11 Jul 2025 17:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL2I-0000v9-VY; Fri, 11 Jul 2025 17:12:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL2G-00033z-De; Fri, 11 Jul 2025 17:12:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BCgVPH010972;
 Fri, 11 Jul 2025 21:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JfCIeg
 BsURsvuwd+wiIEmBLzoZeodeH4DhNwuWop7Jw=; b=i+pRnblg6vcHjb3ssnSX4Z
 +zvJ1pc5NKcUCkuVqLf/mVzfpS7DLCXiug2ZyOqVwS8qbExmEjnO/O6hc6jggzvu
 gmAJKsyKpW9ZtEFJsPa/5ZvxxD4PS7wIFmYVqXLL7npn+b8/3Cd7GGdx0dfDH0vF
 TS3yZ6LiLJ2SF+JGtj6Ko0/LkSVofVpPnaOSurrkxJjtFciS781Piz7jepdOGaWi
 xmEMlgWnC93ZqfQ90e5Wu/UhPD3bHEpw4lOY9MaYyCeF1IURDe5V3sO+tJn8JhBv
 tcqQIVNFBVOcClcabGc03YB6OK127T8Qrl7CDJmCmdQTPwCmDO8WrPGVp/WX8uQQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrm346-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BK7of3002860;
 Fri, 11 Jul 2025 21:11:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmvefa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBuCP25231840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 590CE5805D;
 Fri, 11 Jul 2025 21:11:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC2E658061;
 Fri, 11 Jul 2025 21:11:54 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:54 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 28/28] docs: Add secure IPL documentation
Date: Fri, 11 Jul 2025 17:11:04 -0400
Message-ID: <20250711211105.439554-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=68717e1e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=q5T4S90kAAAA:8
 a=dzVlrgI-bTyDp38zYA8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=LnBBZQxPVJ0Z7KJyRdxh:22
X-Proofpoint-ORIG-GUID: CwKnrXCzuk6H5UT0_U1v2tDPyJ6k9DHu
X-Proofpoint-GUID: CwKnrXCzuk6H5UT0_U1v2tDPyJ6k9DHu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1MiBTYWx0ZWRfX3ye8RsN1cBmA
 7uxRvN6h3///Gq79UIpxiV2Gtujfy/7kRvjQI92Z8MpDUCbolRPqjuvOgYiPYI6s9dE+/Ny2bw2
 gXiGyN93jY4yac38JO+XdjbcO60pKvKIr/cNIj58It766dP28l/k7DThfMcjZXZqSPawfJExNkJ
 C6mjC+NgvZfXDL09hZd1X+30BDbFY9Un3ft32NwbSYHfXUc/C5uwZjkFR9G504PdcAWiI1dS5Te
 BdjrY/gcAmaoELK+cnrA2Q7+0OWm1t6SkEwKG31Gs7HV3ka+gCB/tMHq3fwhJv5Xbxri0FfZhb5
 TQFpa3KhM/SSl5+wtL0PgR/peAXHYxKaOYVPpFRkij7P3mT7UAa63FJArGFDw4pyeGe//0xuZKR
 xd2/SolAdh19v/pRfmIozTzXJdZtI573LasYBQ8rFE16SsNuVC3EYCR0wk0tl1t1LavHc2ug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 docs/specs/s390x-secure-ipl.rst  | 159 +++++++++++++++++++++++++++++++
 docs/system/s390x/secure-ipl.rst | 156 ++++++++++++++++++++++++++++++
 2 files changed, 315 insertions(+)
 create mode 100644 docs/specs/s390x-secure-ipl.rst
 create mode 100644 docs/system/s390x/secure-ipl.rst

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
new file mode 100644
index 0000000000..1ff69092e2
--- /dev/null
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -0,0 +1,159 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+s390 Secure IPL
+===============
+
+Secure IPL (a.k.a. secure boot) enables s390-ccw virtual machines to
+leverage qcrypto libraries and z/Architecture emulations to verify the
+integrity of signed kernels. The qcrypto libraries are used to perform
+certificate validation and signature-verification, whereas the
+z/Architecture emulations are used to ensure secure IPL data has not
+been tampered with, convey data between QEMU and userspace, and set up
+the relevant secure IPL data structures with verification results.
+
+To find out more about using this feature, see ``docs/system/s390x/secure-ipl.rst``.
+
+Note that "userspace" will refer to the s390-ccw BIOS unless stated
+otherwise.
+
+Both QEMU and userspace work in tandem to perform secure IPL. The Secure
+Loading Attributes Facility (SCLAF) is used to check the Secure Code
+Loading Attribute Block (SCLAB) and ensure that secure IPL data has not
+been tampered with. DIAGNOSE 'X'320' is invoked by userspace to query
+the certificate store info and retrieve specific certificates from QEMU.
+DIAGNOSE 'X'508' is used by userspace to leverage qcrypto libraries to
+perform signature-verification in QEMU. Lastly, userspace generates and
+appends an IPL Information Report Block (IIRB) at the end of the IPL
+Parameter Block, which is used by the kernel to store signed and
+verified entries.
+
+The logical steps are as follows:
+
+- Userspace reads data payload from disk (e.g. stage3 boot loader, kernel)
+- Userspace checks the validity of the SCLAB
+- Userspace invokes DIAG 508 subcode 1 and provides it the payload
+- QEMU handles DIAG 508 request by reading the payload and retrieving the
+  certificate store
+- QEMU DIAG 508 utilizes qcrypto libraries to perform signature-verification on
+  the payload, attempting with each cert in the store (until success or exhausted)
+- QEMU DIAG 508 returns:
+
+  - success: index of cert used to verify payload
+  - failure: error code
+
+- Userspace responds to this operation:
+
+  - success: retrieves cert from store via DIAG 320 using returned index
+  - failure: reports with warning (audit mode), aborts with error (secure mode)
+
+- Userspace appends IIRB at the end of the IPLB
+- Userspace kicks off IPL
+
+More information regarding the respective DIAGNOSE commands and IPL data
+structures are outlined within this document.
+
+s390 Certificate Store and Functions
+====================================
+
+s390 Certificate Store
+----------------------
+
+A certificate store is implemented for s390-ccw guests to retain within
+memory all certificates provided by the user via the command-line, which
+are expected to be stored somewhere on the host's file system. The store
+will keep track of the number of certificates, their respective size,
+and a summation of the sizes.
+
+DIAGNOSE function code 'X'320' - Certificate Store Facility
+-----------------------------------------------------------
+
+DIAGNOSE 'X'320' is used to provide support for userspace to directly
+query the s390 certificate store. Userspace may be the s390-ccw BIOS or
+the guest kernel.
+
+Subcode 0 - query installed subcodes
+    Returns a 256-bit installed subcodes mask (ISM) stored in the installed
+    subcodes block (ISB). This mask indicates which sucodes are currently
+    installed and available for use.
+
+Subcode 1 - query verification certificate storage information
+    Provides the information required to determine the amount of memory needed to
+    store one or more verification-certificates (VCs) from the certificate store (CS).
+
+    Upon successful completion, this subcode returns various storage size values for
+    verification-certificate blocks (VCBs).
+
+    The output is returned in the verification-certificate-storage-size block (VCSSB).
+
+Subcode 2 - store verification certificates
+    Provides VCs that are in the certificate store.
+
+    The output is provided in a VCB, which includes a common header followed by zero
+    or more verification-certificate entries (VCEs).
+
+    The first-VC index and last-VC index fields of VCB specify the range of VCs
+    to be stored by subcode 2. Stored count and remained count fields specify the
+    number of VCs stored and could not be stored in the VCB due to insufficient
+    storage specified in the VCB input length field.
+
+    VCE contains various information of a VC from the CS.
+
+
+Secure IPL Data Structures, Facilities, and Functions
+=====================================================
+
+IPL Information Report Block
+----------------------------
+
+The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
+IPL Information Report Block (IIRB), which contains the results from secure IPL
+operations such as:
+
+* component data
+* verification results
+* certificate data
+
+
+Secure Code Loading Attributes Facility
+---------------------------------
+
+The Secure Code Loading Attributes Facility (SCLAF) enhances system security during the
+IPL by enforcing additional verification rules.
+
+When SCLAF is available, its behavior depends on the IPL mode. It introduces verification
+of both signed and unsigned components to help ensure that only authorized code is loaded
+during the IPL process. Any errors detected by SCLAF are reported in the IIRB.
+
+Unsigned components are restricted to load addresses at or above absolute storage address
+``0x2000``.
+
+Signed components must include a Secure Code Loading Attribute Block (SCLAB), which is
+appended at the very end of the component. The SCLAB defines security attributes for
+handling the signed code. Specifically, it may:
+
+* Provide direction on how to process the rest of the component.
+
+* Provide further validation of information on where to load the signed binary code
+  from the load device.
+
+* Specify where to start the execution of the loaded OS code.
+
+
+DIAGNOSE function code 'X'508' - KVM IPL extensions
+---------------------------------------------------
+
+DIAGNOSE 'X'508' is reserved for KVM guest use in order to facilitate
+communication of additional IPL operations that cannot be handled by userspace,
+such as signature verification for secure IPL.
+
+If the function code specifies 0x508, KVM IPL extension functions are performed.
+These functions are meant to provide extended functionality for s390 guest boot
+that requires assistance from QEMU.
+
+Subcode 0 - query installed subcodes
+    Returns a 64-bit mask indicating which subcodes are supported.
+
+Subcode 1 - perform signature verification
+    Perform signature-verification on a signed component, using certificates
+    from the certificate store and leveraging qcrypto libraries to perform
+    this operation.
diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
new file mode 100644
index 0000000000..83223ddd7c
--- /dev/null
+++ b/docs/system/s390x/secure-ipl.rst
@@ -0,0 +1,156 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
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
+Secure IPL Command Line Options
+===============================
+
+New parameters have been introduced to s390-ccw-virtio machine type option
+to support secure IPL. These parameters allow users to provide certificates
+and enable secure IPL directly via the command line.
+
+Providing Certificates
+----------------------
+
+The certificate store can be populated by supplying a comma-delimited list of
+certificates on the command-line:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio, \
+    boot-certificates=/.../qemu/certs:/another/path/cert.pem
+
+Enabling Secure IPL
+-------------------
+
+Different IPL modes may be toggled with the following command line option:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on|off
+
+Additionally, the provision of certificates affect the mode.
+
+
+IPL Modes
+=========
+
+Normal Mode
+-----------
+
+The absence of both certificates and the ``secure-boot`` option will attempt to
+IPL a guest without secure IPL operations. No checks are performed, and no
+warnings/errors are reported.  This is the default mode, and can be explicitly
+enabled with ``secure-boot=off``.
+
+
+Audit Mode
+----------
+
+With *only* the presence of certificates in the store, it is assumed that secure
+boot operations should be performed with errors reported as warnings. As such,
+the secure IPL operations will be performed, and any errors that stem from these
+operations will report a warning via the SCLP console.
+
+
+Secure Mode
+-----------
+
+With *both* the presence of certificates in the store and the ``secure-boot=on``
+option, it is understood that secure boot should be performed with errors
+reported and boot will abort.
+
+
+Constraints
+===========
+
+The following constraints apply when attempting to secure IPL an s390 guest:
+
+- z16 CPU model
+- certificates must be in X.509 PEM format
+- only sha256 encryption is supported
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
+A private key is required before generating a certificate. This key must be keypt secure
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
+    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certificates=cert.pem ...
-- 
2.49.0


