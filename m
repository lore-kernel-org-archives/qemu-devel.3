Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6105C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5B-0003zg-Up; Thu, 08 May 2025 18:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA58-0003z0-JV; Thu, 08 May 2025 18:51:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA52-0006QO-Vy; Thu, 08 May 2025 18:51:09 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548LdHlF005371;
 Thu, 8 May 2025 22:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=5UcX51uz6ksyGBRAlya9az7nACgE
 YKbpZw2y1lTLRvw=; b=e+sOEk80pLvddWUpYTK8Jyl8W4/s/3ZcS6pczLp92Zm/
 Wfb5H5cD3O6hofAqpt1EddrXY6nN+hUIiQ8tsM9ZqsjBeJMB96yUWVekhX/8vyUQ
 5N4K4rWwVC8FyZ6OKHNDsbp3AbmGPLSbcEyXiEr9bA2Zk1d4MvVAIIzfvkxo42Pq
 lXqL1zb1NiF5kT1WZeGpISvcmxLdA/mss+yraKhPg+QD2W9GrVuaA0Ted9YvMpPL
 bAAoKKjakOi1WG9/SAP7LVCbJ+ZshvqGbuNJnPpoCwKOGa+XbRhwqKtDVQ3sdJ6W
 paB0duJOjMwmGy/YKQtMpy8h6RN5tg9QjAG3DJSaWg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4q8r8ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:50:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548L3gGk002765;
 Thu, 8 May 2025 22:50:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfp835b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:50:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mov2i26411492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:50:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D03C58055;
 Thu,  8 May 2025 22:50:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 093F05804B;
 Thu,  8 May 2025 22:50:56 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:50:55 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 00/25] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
Date: Thu,  8 May 2025 18:50:16 -0400
Message-ID: <20250508225042.313672-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N6spF39B c=1 sm=1 tr=0 ts=681d3554 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GBR_YEU_Uo71KFJdXP4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ShnB9l4clnPQxSDwd4HRsfiVlRRcgHoQ
X-Proofpoint-ORIG-GUID: ShnB9l4clnPQxSDwd4HRsfiVlRRcgHoQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfXxtCwEVVQkR2g
 ztHyXEH6m7lEO8EkG/KF5NurMppGPgWWnCiOPKmtcXM0E44xRtkt1xClyeUW9uTSOz/XTqEGpHl
 rBluSWw7/WdLEslsOa458wgwK8iPU1VQVh9fvGKjsfPss/h33ieebrzJhGX8kVI1jJYd76pMyng
 dLvQEVIOVMGfJyyeBrNdksqZ7ZVAsNs0y0VJNjD5vyY1hR3VdM/0UGEAnnwZ0MPZApD8coxLlIy
 pZ+c2XTZeIyTIqokHqf3+B/7Uae3f+QrODTM4A3nUlYJZN0HPOorIk7hGVs0erUcLB3w2nMi2Gv
 Lc+AHj6ZGHTa+Y0YUm7JMxm7Dsjt7Xn2S7qjTRVBvgh2WZtXP8yEqeUGWK0nLhfBludGOuRjwSO
 pn9FEcSxn5b9hzWZsnaeBBtPNBQPHt/DwiaR9NC2mcZvTp8ptkCtMnTBaMXUJIcALaQOU9YF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changelog v1->v2:

- Fix typos in patches
- Edit cover letter
- Add secure IPL documentation

QEMU Command-Line Interface:
- Move boot-certificates under the machine-type option for s390x-virtio-ccw
- Move secure-boot under the machine-type option for s390x-virtio-ccw

hw/s390x/ipl: Create Certificate Store
- Define internal GNUTLS-related APIs
- Add check to only accept certificates using SHA-256 hashing
- Recalculate data_buf_size to ensure word alignment
- Clean up memory allocation
- Refactor functions for clarity

s390x: Guest Support for Certificate Store Facility (CS)
- Update patch description to clarify:
    - Why Secure IPL is not available with Secure Execution
    - Why this feature requires S390_FEAT_EXTENDED_LENGTH_SCCB
-Restrict features to z16 due to additional layers requiring z16

s390x/diag: Implement DIAG 320 Subcode 1
- Rename VerificationCertificate prefix to VC
- Byte-swap written values for endianness correctness

s390x/diag: Implement DIAG 320 Subcode 2
- Edit commit message for clarity
- Define internal GNUTLS-related APIs
- Rename data structure variables
- Ensure length fields in VCE are word-aligned
- Handle the VC index 0 case
- General refactoring

s390x/diag: Implement DIAG 508 Subcode 2 for Signature Verification
- Define subcode from 2 to 1
- Remove unused error codes
- Define internal GNUTLS-related APIs
- Byte-swap read values

hw/s390x/ipl: Add IPIB Flags to IPL Parameter Block
- Move DIAG308 flags to a new header file

s390x: Guest Support for Secure-IPL Facility
- Rename SCLP variable from cbl to fac_ipl

pc-bios/s390-ccw: Add Signature Verification for Secure Boot (Audit Mode)
- Move Secure IPL-related functions to pc-bios/s390-ccw/secure-ip.c|h
- Refactor code for clarity

-----------------------------------------------------------------------------

# Description

This patch series is an external requirement by Linux distribution
partners to verify secure IPL process. Additional secure IPL checks are
also included in this series to address security holes in the original
secure IPL design to prevent malicious actors to boot modified or
unsigned code despite secure IPL being enforced.

Secure IPL is enabled when the QEMU options for secure IPL are specified
in the command line.

During this process, additional security checks are performed to ensure
system integrity.

As components are loaded from disk, DIAG 508 subcode 2 performs
signature verification if a signature entry is identified. Upon
successful verification, DIAG 320 subcode 2 will request the
corresponding certificate from QEMU key store to the BIOS.

Secure IPL will continue until all the components are loaded if no error
occurs during True secure IPL mode or in Audit mode (see explanation below).

After that, an IPL Information report block (IIRB) is initialized
immediately following an IPL Parameter Information Block. The IIRB is
populated with information about the components, verification results
and certificate data.

Finally, the guest system proceeds to boot.

Only List-Directed-IPL contains the relevant zIPL data structures to
perform secure IPL. This patch series only adds support for the SCSI
scheme of virtio-blk/virtio-scsi devices. Secure IPL for other device
types will be considered as follow-up work at a later date.

** Note: "secure IPL" and "secure boot" are used interchangeably
throughout the design. **

# True Secure IPL Mode and Audit Mode

## True Secure IPL Mode

When secure IPL is enabled and certificates are provided, all the secure
IPL checks will performed. The boot process will abort if any error
occurs during the secure IPL checks.

## Audit Mode

When the secure IPL option is not selected and certificates are
provided, all the secure IPL checks will still be performed. However,
the boot process will continue if any errors occur, with messages logged
to the console during the secure IPL checks.

The audit mode is also considered as simulated secure IPL because it is
less pervasive, and allows the guest to boot regardless of the secure
checking results.

# How to Enable Secure IPL

## QEMU Build Notes

When building QEMU, enable the cryptographic libraries.

Run configure script in QEMU repository with either parameter:

	./configure … --enable-gnutls

## Create Certificates via Openssl

	openssl req -new -x509 -newkey rsa:2048 -keyout mykey.priv
	-outform DER -out mycert.der -days 36500 -subj "/CN=My Name/"
	-nodes

Use an RSA private key for signing.

It is recommended to store the certificate(s) in the /…/qemu/certs
directory for easy identification.

## Sign Kernel and Prepare zipl

All actions must be performed on a KVM guest.

Copy the sign-file script (located in Linux source repository),
generated private key(s), and certificate(s) to guest's file system.

Sign guest image(s) and stage3 binary:

	./sign-file sha256 mykey.priv mycert.der /boot/vmlinuz-…

	./sign-file sha256 mykey.priv mycert.der /usr/lib/s390-tools/stage3.bin

Run zipl with secure boot enabled.

	zipl --secure 1 -V

Guest image(s) are now signed, stored on disk, and can be verified.

## New QEMU Command Options for Secure IPL

New parameters have been added to the s390-ccw-virtio machine type to
enable Secure IPL and provide certificates for signature verification.

This parameter enables or disables Secure IPL/boot. If not specified, it
defaults to off.

	qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on|off

This parameter specifies one or more paths to boot certificates, used
for signature verification. You can provide a single certificate file or
a directory. Multiple paths can be separated by a colon (:).

	qemu-system-s390x -machine s390-ccw-virtio, \
        boot-certificates=/.../qemu/certs:/another/path/cert.der

Example:
	qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on, \
        boot-certificates=/.../qemu/certs:/another/path/cert.der

Secure IPL command options overview:

If neither the -secure-boot nor the -boot-certificates options are
specified, the guest will boot in normal mode, and no security checks
will be conducted.

If the -secure-boot option is not specified or is set to off, and the
-boot-certificates option is provided, the guest will boot in audit
mode. In this mode, all security checks are performed; however, any
errors encountered will not interrupt the boot process.

If the -secure-boot option is set to on and the -boot-certificates
option is provided, the guest will boot in true secure IPL mode. In this
mode, all security checks are performed, and any errors encountered will
terminate the boot process.
  - If the -boot-certificates option is not provided in true secure IPL
    mode, the boot process will fail for the corresponding device.

## Constraints

- z16 CPU model

- certificates must be in X.509 DER format

- only sha256 encryption is supported

- only support for SCSI scheme of virtio-blk/virtio-scsi devices
    - The boot process will terminate if secure boot is enabled without
specifying a boot device.
    - If enabling secure boot with multiple boot devices, any
unsupported devices or non-eligible devices will cause the entire boot
process terminating early with an error logged to the console.

- attempting to perform secure IPL outside of these constraints will
result in a failure.

# DIAGNOSE 508 - KVM IPL Extensions

Signature verification is performed during IPL via DIAG 508. Component
address, component length, signature address and signature length are
obtained in the BIOS and pass to DIAG 508 subcode 2 to perform signature
verification in QEMU. If verification succeeds, DIAG 508 subcode 2
(signature verification) will return the length and index of the
certificate in the QemuCertificateStore that was used for verification.

## Data Structures

Diag508SignatureVerificationBlock (SVB) — stores addresses and
lengths of the component and signature to be used for signature
verification. Upon verification, an index and the length of the
certificate used is stored.

Collin L. Walling (2):
  s390x/diag: Introduce DIAG 508 for secure IPL operations
  s390x/diag: Implement DIAG 508 subcode 1 for signature verification

Zhuoying Cai (23):
  Add -boot-certificates to s390-ccw-virtio machine type option
  hw/s390x/ipl: Create certificate store
  s390x: Guest support for Certificate Store Facility (CS)
  s390x/diag: Introduce DIAG 320 for certificate store facility
  s390x/diag: Refactor address validation check from diag308_parm_check
  s390x/diag: Implement DIAG 320 subcode 1
  s390x/diag: Implement DIAG 320 subcode 2
  pc-bios/s390-ccw: Introduce IPL Information Report Block (IIRB)
  pc-bios/s390-ccw: Define memory for IPLB and convert IPLB to pointers
  hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
  hw/s390x/ipl: Set iplb->len to maximum length of IPL Parameter Block
  s390x: Guest support for Secure-IPL Facility
  pc-bios/s390-ccw: Refactor zipl_run()
  pc-bios/s390-ccw: Refactor zipl_load_segment function
  pc-bios/s390-ccw: Add signature verification for secure IPL in audit
    mode
  s390x: Guest support for Secure-IPL Code Loading Attributes Facility
    (SCLAF)
  pc-bios/s390-ccw: Add additional security checks for secure boot
  Add -secure-boot to s390-ccw-virtio machine type option
  hw/s390x/ipl: Set IPIB flags for secure IPL
  pc-bios/s390-ccw: Handle true secure IPL mode
  pc-bios/s390-ccw: Handle secure boot with multiple boot devices
  hw/s390x/ipl: Handle secure boot without specifying a boot device
  docs/system/s390x: Add secure IPL documentation

 crypto/meson.build                  |   5 +-
 crypto/x509-utils.c                 | 421 +++++++++++++++++++++++++++-
 docs/system/s390x/secure-ipl.rst    | 249 ++++++++++++++++
 hw/s390x/cert-store.c               | 242 ++++++++++++++++
 hw/s390x/cert-store.h               |  39 +++
 hw/s390x/ipl.c                      |  61 +++-
 hw/s390x/ipl.h                      |  29 +-
 hw/s390x/meson.build                |   1 +
 hw/s390x/s390-virtio-ccw.c          |  44 +++
 hw/s390x/sclp.c                     |   2 +
 include/crypto/x509-utils.h         |  20 ++
 include/hw/s390x/ipl/diag308.h      |  34 +++
 include/hw/s390x/ipl/diag320.h      |  89 ++++++
 include/hw/s390x/ipl/diag508.h      |  37 +++
 include/hw/s390x/ipl/qipl.h         |   8 +-
 include/hw/s390x/s390-virtio-ccw.h  |   2 +
 include/hw/s390x/sclp.h             |   4 +-
 pc-bios/s390-ccw/Makefile           |   3 +-
 pc-bios/s390-ccw/bootmap.c          | 306 ++++++++++++++++++--
 pc-bios/s390-ccw/bootmap.h          |   9 +
 pc-bios/s390-ccw/iplb.h             | 113 +++++++-
 pc-bios/s390-ccw/jump2ipl.c         |   6 +-
 pc-bios/s390-ccw/main.c             | 111 +++++++-
 pc-bios/s390-ccw/netmain.c          |   8 +-
 pc-bios/s390-ccw/s390-ccw.h         |  18 ++
 pc-bios/s390-ccw/sclp.c             |  52 ++++
 pc-bios/s390-ccw/sclp.h             |   7 +
 pc-bios/s390-ccw/secure-ipl.c       | 412 +++++++++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h       | 131 +++++++++
 qapi/crypto.json                    | 100 +++++++
 qemu-options.hx                     |  11 +-
 target/s390x/cpu_features.c         |   5 +
 target/s390x/cpu_features.h         |   1 +
 target/s390x/cpu_features_def.h.inc |   5 +
 target/s390x/cpu_models.c           |   6 +
 target/s390x/diag.c                 | 410 ++++++++++++++++++++++++++-
 target/s390x/gen-features.c         |   3 +
 target/s390x/kvm/kvm.c              |  36 +++
 target/s390x/s390x-internal.h       |   4 +
 39 files changed, 2964 insertions(+), 80 deletions(-)
 create mode 100644 docs/system/s390x/secure-ipl.rst
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h
 create mode 100644 include/hw/s390x/ipl/diag308.h
 create mode 100644 include/hw/s390x/ipl/diag320.h
 create mode 100644 include/hw/s390x/ipl/diag508.h
 create mode 100644 pc-bios/s390-ccw/secure-ipl.c
 create mode 100644 pc-bios/s390-ccw/secure-ipl.h

-- 
2.49.0


