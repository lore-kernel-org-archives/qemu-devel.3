Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AE4C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Be2-0006sI-61; Tue, 08 Apr 2025 12:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIa-0005TK-3H; Tue, 08 Apr 2025 11:55:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIX-0005qS-DU; Tue, 08 Apr 2025 11:55:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538CSaSw018465;
 Tue, 8 Apr 2025 15:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=zu0Zyc6+VK7paPNvMy5DGu8gEpSq
 Tt39xgVb2sKPlpA=; b=QWDKUbJt7Yhfgs4we86bhcYUu7+Z6wab9EOfFs73qFKZ
 RU6+oTkvgIemaGTxyXly4oAyln5zILJe8NbKLXzuvOc+ysrAaquqiyB+/j5QX1Nq
 iHAurJpso+14msT7czyKetUpJUb2RNBoJkunoQCGXMRxyeTGRfULjR7WAkpXfJzJ
 bIG1rSY0WddNHHLTKJfWMVlN2BP599DxYdGtBDkf+BlX2VQcZMQ8VGC6rzXCBkWd
 Wx9zhIif87wI71cLrbrR8Y6118lLb8ZP9nKaEz79C4AaZ612tSg2OF3ZK1WDyCjt
 Ex4CcJEsG8J5IO573hkgrk/ayimOqm9bqqfcylwf8g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u3122p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538C4qlB014404;
 Tue, 8 Apr 2025 15:55:31 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunkb9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538FtUOx29295354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:55:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0180F5804E;
 Tue,  8 Apr 2025 15:55:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74A5C5803F;
 Tue,  8 Apr 2025 15:55:28 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:28 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 00/24] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
Date: Tue,  8 Apr 2025 11:55:02 -0400
Message-ID: <20250408155527.123341-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 49-MZHEoiaq95V9jrI_kbKfIS4n0NiCO
X-Proofpoint-ORIG-GUID: 49-MZHEoiaq95V9jrI_kbKfIS4n0NiCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:32 -0400
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

** Note: “secure IPL” and “secure boot” are used interchangeably
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

	./configure … --enable-nettle or --enable-gcrypt

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
generated private key(s), and certificate(s) to guest’s file system.

Sign guest image(s) and stage3 binary:

	./sign-file sha256 mykey.priv mycert.der /boot/vmlinuz-…

	./sign-file sha256 mykey.priv mycert.der /usr/lib/s390-tools/stage3.bin

Run zipl with secure boot enabled.

	zipl --secure 1 -V

Guest image(s) are now signed, stored on disk, and can be verified.

## New QEMU Command Options for Secure IPL

To enable secure IPL and provide certificates for signature verification
via QEMU command line.

Enables secure IPL/boot, this option defaults to off if it is not
provided for the command line options.

	-secure-boot [on|off]

Provides a path to either a directory or a single boot certificate. A
colon may be used to delineate multiple paths.

	-boot-certificates <file>

Example:
	qemu-system-s390x ... \
	-secure-boot on \
	-boot-certificates /.../qemu/certs:/another/path/cert.der

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

# QEMU and Libvirt Interface Discussion

While libvirt provides a secure boot interface
(https://libvirt.org/kbase/secureboot.html), it is not directly reusable
for secure boot design on s390x.The current implementation appears to be
designed for x86 systems, where secure boot is enabled via the
<firmware> tag and keys can be specified using the <nvram> tag.

	<os firmware='efi'>
      	    <firmware>
		<feature enabled='yes' name='enrolled-keys'/>
		<feature enabled='yes' name='secure-boot'/>
	    </firmware>
	    <loader secure='yes' type='pflash'>...</loader>
	    <nvram template='...'>...</nvram>
	</os>

We may be able to reuse some existing tags. However, there is no
efficient way to provide certificates on the host file system for both
QEMU and libvirt.

Ideally, if the QEMU interface for secure IPL is acceptable, we could
introduce new tags specifically for certificates on s390x or potentially
add a new <secureboot> tag to enable secure boot and provide certificates.

Below are my proposed designs for the secure boot interface in libvirt.

Design #1

	<os firmware='s390-ccw'>
	    <type arch='s390x' machine='s390-ccw-virtio-9.2'>hvm</type>
	    <firmware>
		<feature enabled='yes' name='secure-boot'/>
	    </firmware>
	    <certificate path='path/to/cert:cert.der' />
	    <boot dev='hd'/>
	</os>

Design #2

	<os>
	    <type arch='s390x' machine='s390-ccw-virtio-9.2'>hvm</type>
	    <secureboot enabled='yes'>
		<certificates path='path/to/cert:cert.der'/>
	    </secureboot>
	    <boot dev='hd'/>
	</os>

I would appreciate any suggestions or feedback on both QEMU and libvirt
interface designs.

Collin L. Walling (4):
  s390x/diag: Introduce DIAG 320 for certificate store facility
  s390x/diag: Refactor address validation check from diag308_parm_check
  s390x/diag: Introduce DIAG 508 for secure IPL operations
  s390x/diag: Implement DIAG 508 subcode 2 for signature verification

Zhuoying Cai (20):
  Add -boot-certificates /path/dir:/path/file option in QEMU command
    line
  hw/s390x/ipl: Create certificate store
  s390x: Guest support for Certificate Store Facility (CS)
  s390x/diag: Implement DIAG 320 subcode 1
  s390x/diag: Implement DIAG 320 subcode 2
  pc-bios/s390-ccw: Introduce IPL Information Report Block (IIRB)
  pc-bios/s390-ccw: Define memory for IPLB and convert IPLB to pointers
  hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
  hw/s390x/ipl: Set iplb->len to maximum length of IPL Parameter Block
  s390x: Guest support for Secure-IPL Facility
  pc-bios/s390-ccw: Refactor zipl_run()
  pc-bios/s390-ccw: Refactor zipl_load_segment function
  pc-bios/s390-ccw: Add signature verification for secure boot in audit
    mode
  s390x: Guest support for Secure-IPL Code Loading Attributes Facility
    (SCLAF)
  pc-bios/s390-ccw: Add additional security checks for secure boot
  Add -secure-boot on|off option in QEMU command line
  hw/s390x/ipl: Set IPIB flags for secure IPL
  pc-bios/s390-ccw: Handle true secure IPL mode
  pc-bios/s390-ccw: Handle secure boot with multiple boot devices
  hw/s390x/ipl: Handle secure boot without specifying a boot device

 hw/s390x/cert-store.c               | 249 ++++++++++
 hw/s390x/cert-store.h               |  50 ++
 hw/s390x/ipl.c                      |  65 ++-
 hw/s390x/ipl.h                      |  12 +
 hw/s390x/meson.build                |   1 +
 hw/s390x/sclp.c                     |   2 +
 include/hw/s390x/ipl/diag320.h      | 103 ++++
 include/hw/s390x/ipl/diag508.h      |  42 ++
 include/hw/s390x/ipl/qipl.h         |   9 +-
 include/hw/s390x/sclp.h             |   4 +-
 pc-bios/s390-ccw/bootmap.c          | 696 +++++++++++++++++++++++++++-
 pc-bios/s390-ccw/bootmap.h          |   9 +
 pc-bios/s390-ccw/iplb.h             | 188 +++++++-
 pc-bios/s390-ccw/jump2ipl.c         |   6 +-
 pc-bios/s390-ccw/main.c             | 111 ++++-
 pc-bios/s390-ccw/netmain.c          |   8 +-
 pc-bios/s390-ccw/s390-ccw.h         |  14 +
 pc-bios/s390-ccw/sclp.c             |  51 ++
 pc-bios/s390-ccw/sclp.h             |   7 +
 qemu-options.hx                     |  19 +
 system/vl.c                         |  43 ++
 target/s390x/cpu_features.c         |   5 +
 target/s390x/cpu_features.h         |   1 +
 target/s390x/cpu_features_def.h.inc |   5 +
 target/s390x/cpu_models.c           |   6 +
 target/s390x/diag.c                 | 457 +++++++++++++++++-
 target/s390x/gen-features.c         |   3 +
 target/s390x/kvm/kvm.c              |  36 ++
 target/s390x/s390x-internal.h       |   4 +
 29 files changed, 2150 insertions(+), 56 deletions(-)
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h
 create mode 100644 include/hw/s390x/ipl/diag320.h
 create mode 100644 include/hw/s390x/ipl/diag508.h

-- 
2.49.0


