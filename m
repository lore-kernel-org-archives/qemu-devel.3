Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0031D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSiqx-0007EX-T9; Mon, 08 Dec 2025 16:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSiqp-0007C7-Jr; Mon, 08 Dec 2025 16:32:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSiql-0000Zb-Fs; Mon, 08 Dec 2025 16:32:58 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8EavT0001279;
 Mon, 8 Dec 2025 21:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=TDHjnCPmi1EZveNtp5nCpAjtXJI4
 1Icnif2dZ4LtMvo=; b=DPj0i6dyttIc0pTmTsQ/RMm4l2Auf7p59KSSnkQf4PIr
 hQZ7CXpJCEOF6Y0+zQrHbdxLxAB1Oqgos3Maz8ZgdU+hBr9O33pFRiR2fLXfMZgp
 kiP/5KqUvCRo02Gj4aH7yFXOT/WAnut/cxyR+Nt/G4+Lzrpbd42cnAL1MErd4nv4
 fHxgDcep6an1oLodWXf7aP730kwUUsboD1W/7FxLrQ6kLlr7zKeyiJDVWDDVnYtd
 s4pY6p4CiEsoiMQUNab8kKh0qsMdfy56UujerNfdRko8Ctb30wdg5Y1JpCobW4mz
 PiGmEqhITRmci6boLvirsu8qsrpUAROTozMqyaGIlw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvhmkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:32:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8ITc6Q012432;
 Mon, 8 Dec 2025 21:32:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajqnm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:32:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LWotk27853446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:32:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED88C58058;
 Mon,  8 Dec 2025 21:32:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29CC05805B;
 Mon,  8 Dec 2025 21:32:48 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:32:48 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 00/29] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
Date: Mon,  8 Dec 2025 16:32:17 -0500
Message-ID: <20251208213247.702569-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uc9fTQzg3vclOpGA99Pl3qtq7yfoqJhD
X-Proofpoint-ORIG-GUID: Uc9fTQzg3vclOpGA99Pl3qtq7yfoqJhD
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=69374404 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=q5T4S90kAAAA:8 a=Wes58VO_7EPYKQMGZaAA:9
 a=8xE43Odk46ggxST0:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=LnBBZQxPVJ0Z7KJyRdxh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX0k/lDJ0BMQ+T
 lsxUEuv/9S6K91qdpdZEVLoVXSkMlzyd125bYKn8b2Fzn66d2n+NmLWb3kBlsnPCE2MwoKtjREU
 CSvWe7blFD5yN+BV6gx1/jLaNCId/VSnj6IR0MwyCqORlJXW3YcmjdPExRpT1TfaJRqzZGeG2oD
 IoKOJD0G+BpdhgpScZ0Zs7pb5t6rq7EUeAtKnDUL7xrw7FreScJO6l24Kvo2y9HBd5qY0PO1I6x
 c7STA7NjBRhPH5qfQPHIdWjwZVNnfrxbfYOKjXEmUD8QBrzl8XMRS/AGWIy976DJ+BCZT27kaGn
 ljmrG9n6oDuUts3c16MUcQlZ0bQNWjNiRFaLptI/dXkce1SCM0iEl+XKdbgoHhzMZYHAqybs721
 2sovfQNLdslaWPK8MiRr8D/9P922BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
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

Changelog v6->v7

Add functional test for secure IPL

Secure IPL documentation
- Merged command line into one line
- Limited line length to 80 columns

[PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type option
- Renamed BootCertificate to BootCertificates
- Added Acked-by: Markus Armbruster <armbru@redhat.com>

[PATCH v6 02/28] crypto/x509-utils: Refactor with GNUTLS fallback
- Edited commit message
- Added Acked-by: Daniel P. Berrangé <berrange@redhat.com>
        Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
        Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v6 03/28] crypto/x509-utils: Add helper functions for certificate
store
- Added Acked-by: Daniel P. Berrangé <berrange@redhat.com>
        Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
        Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v6 04/28] hw/s390x/ipl: Create certificate store
- Removed QEMU_PAKCED
- Inlined cert2buf wrapper function to reduce lines of code
- Reported error and handled exit in s390_ipl_create_cert_store()

[PATCH v6 05/28] s390x/diag: Introduce DIAG 320 for Certificate Store
Facility
- Fixed typos
- Added Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v6 06/28] s390x/diag: Refactor address validation check from
diag308_parm_check
- Moved diag_parm_addr_valid() to target/s390x/diag.c
- Added Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v6 07/28] s390x/diag: Implement DIAG 320 subcode 1
- Added Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v6 08/28] crypto/x509-utils: Add helper functions for DIAG 320
subcode 2
- Edited commit message
- Handled negative return value from gnutls_x509_crt_get_pk_algorithm()
in qcrypto_x509_get_pk_algorithm
- Checked boundary before using hash_alg in qcrypto_x509_get_cert_key_id()
- Rename qcrypto_x509_is_ecc_curve_p521() to
qcrypto_x509_check_ecc_curve_p521()

[PATCH v6 09/28] s390x/diag: Implement DIAG 320 subcode 2
- Removed redundant set vce->len
- Added check to make sure data doesn't exceed buffer bounds

[PATCH v6 10/28] s390x/diag: Introduce DIAG 508 for secure IPL operations
- Reworded document to avoid the term “KVM”
- Added Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v6 11/28] crypto/x509-utils: Add helper functions for DIAG 508
subcode 1
- Fixed indentation
- Replaced g_new0() and memcpy() with g_memdup2()

[PATCH v6 12/28] s390x/diag: Implement DIAG 508 subcode 1 for signature
verification
- Edit commit message and documentation in handle_diag508_sig_verif()
- Changed diag_508_verify_sig function return type from int to bool
- Set upper limit for comp_len and sig_len to avoid malicious memory
allocation
- Fixed coding style - eliminate unnecessary variables

[PATCH v6 13/28] pc-bios/s390-ccw: Introduce IPL Information Report
Block (IIRB)
- Removed bios structs packing

[PATCH v6 14/28] pc-bios/s390-ccw: Define memory for IPLB and convert
IPLB to pointers
- specify ipl_data attribute in the pc-bios/s390-ccw/main.c

[PATCH v6 15/28] hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
- Moved the setting of iplb->len to when the DIAG308_IPIB_FLAGS_IPLIR is set

[PATCH v6 17/28] pc-bios/s390-ccw: Refactor zipl_run()
- Preserved return error value from zipl_run_normal()

[PATCH v6 18/28] pc-bios/s390-ccw: Rework zipl_load_segment function
- Fixed typoes
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v6 19/28] pc-bios/s390-ccw: Add signature verification for secure
IPL in audit mode
- Edited documentation
- Removed bios structs packing
- Be more specific in the error message and mention Passthrough (vfio)
CCW device does not support secure boot
- Allocated memory for vcb using max_single_vcb_len instead of
MAX_SECTOR_SIZE in request_certificate()
- Rename variables in zipl_run_secure()
cert_index → cert_entry_idx
comp_index → comp_entry_idx
cert_idx → cert_table_idx
- Refactored handle_certificate(): only handles certificate related
operations and moved the increment of cert_entry_idx and cert to
zipl_run_secure()

[PATCH v6 21/28] pc-bios/s390-ccw: Add additional security checks for
secure boot
- Fixed coding style
- Added out of range warning in comp_addr_range_add()
- Fixed end address issue in is_psw_valid() and is_comp_overlap()
- Inlined comparison functions

[PATCH v6 22/28] Add secure-boot to s390-ccw-virtio machine type option
- Moved bool secure_boot next to other bool variables to avoid
additional padding

[PATCH v6 24/28] pc-bios/s390-ccw: Handle true secure IPL mode
- Edited documentation
- Used panic instead of IPL_assert() in zipl_secure_handle()

[PATCH v6 25/28] pc-bios/s390-ccw: Handle secure boot with multiple boot
devices
- Used a stack variable for QemuIplParameters instead of a malloc in
check_secure_boot_support()

-----------------------------------------------------------------------

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

## Create Certificates via certtool

Generate and use an RSA private key for signing.

	certtool --generate-privkey > key.pem

A self-signed certificate requires the organization name. Use the cert.info
template to pre-fill values and avoid interactive prompts from certtool.

	cat > cert.info <<EOF
	cn = "My Name"
	expiration_days = 36500
	cert_signing_key
	EOF

	certtool --generate-self-signed \
		 --load-privkey key.pem \
		 --template cert.info \
		 --hash=SHA256 \
		 --outfile cert.pem

It is recommended to store the certificate(s) in the /…/qemu/certs
directory for easy identification.

## Sign Kernel and Prepare zipl

All actions must be performed on a guest.

Copy the sign-file script (located in Linux source repository),
generated private key(s), and certificate(s) to guest's file system.

Sign guest image(s) and stage3 binary:

	./sign-file sha256 key.pem cert.pem /boot/vmlinuz-…

	./sign-file sha256 key.pem cert.pem /usr/lib/s390-tools/stage3.bin

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
a directory.

	qemu-system-s390x -machine s390-ccw-virtio, \
                                   boot-certs.0.path=/.../qemu/certs, \
                                   boot-certs.1.path=/another/path/cert.pem

Example:
	qemu-system-s390x -machine s390-ccw-virtio,
	                           secure-boot=on, \
	                           boot-certs.0.path=/.../qemu/certs, \
                                   boot-certs.1.path=/another/path/cert.pem

Secure IPL command options overview:

If neither the -secure-boot nor the -boot-certs options are
specified, the guest will boot in normal mode, and no security checks
will be conducted.

If the -secure-boot option is not specified or is set to off, and the
-boot-certs option is provided, the guest will boot in audit mode.
In this mode, all security checks are performed; however, any
errors encountered will not interrupt the boot process.

If the -secure-boot option is set to on and the -boot-certs option is
provided, the guest will boot in true secure IPL mode. In this mode,
all security checks are performed, and any errors encountered will
terminate the boot process.
  - If the -boot-certs option is not provided in true secure IPL
    mode, the boot process will fail for the corresponding device.

## Constraints

- z16 CPU model

- certificates must be in X.509 PEM format

- only support for SCSI scheme of virtio-blk/virtio-scsi devices
    - The boot process will terminate if secure boot is enabled without
specifying a boot device.
    - If enabling secure boot with multiple boot devices, any
unsupported devices or non-eligible devices will cause the entire boot
process terminating early with an error logged to the console.

- attempting to perform secure IPL outside of these constraints will
result in a failure.

# DIAGNOSE 508 - IPL Extensions

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

------------------------------------------------------------------------

Changelog v5->v6

Add boot-certs to s390-ccw-virtio machine type option
- Renamed struct BootCertPath to BootCertificate
- Defined DummyBootCertificates struct for QMP to use
BootCertificateList internally

crypto/x509-utils
- Used gnutls_x509_crt_export2() in qcrypto_x509_convert_cert_der()
- Allocated buffers with g_new for results in
qcrypto_x509_convert_cert_der() and qcrypto_pkcs7_convert_sig_pem()
- Added check for qcrypto_to_gnutls_hash_alg_map bounds in
qcrypto_x509_get_cert_key_id()
- Added qcrypto_x509_is_ecc_curve_p521() function to determine if an ECC
public key algorithm uses P521 curve
- Fixed typo

hw/s390x/ipl: Create certificate store
- Made any configuration errors fatal when loading certificates into the
cert store
- Removed key_id_size and hash_size from S390IPLCertificate and defined
them as constants
- Do not reinitialize the cert store if it already exists
- Handled memory cleanup

s390x/diag: Implement DIAG 320 subcode 1
- Added QEMU_BUILD_BUG_MSG

s390x/diag: Implement DIAG 320 subcode 2
- Refactored build_vce_header() and created a new function for getting
key type
- Added QEMU_BUILD_BUG_MSG

s390x/diag: Implement DIAG 508 subcode 1 for signature verification
- Updated Diag508SigVerifBlock

hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
- Override IPLB length only when DIAG308_IPIB_FLAGS_IPLIR flag is set
- Dropped hw/s390x/ipl: Set iplb->len to maximum length of IPL Parameter
Block patch

pc-bios/s390-ccw: Add signature verification for secure IPL in audit mode
- Added validation for VCB and VCE before retrieving information in
request_certificate()
- Replaced uint64_t *cert with uint8_t *cert in zipl_run_secure()

Changelog v4->v5

- Segmented documentation by introducing them alongside the patches that
add the relevant functionality
- Removed hash-type restriction from S390IPLCertificateStore

Add boot-certs to s390-ccw-virtio machine type option
- Added boot-certs property to the s390-ccw-virtio machine type
    - Changed to use an array property for passing certificate instead
      of colo-delimited strings.
    e.g. boot-certs.0.path=/path/to/dir,
         boot-certs.1.path=/to/other/dir,
         boot-certs.2.path=/some/...

crypto/x509-utils
- Refactored fallback handling into a separated commit
- Removed QCryptoKeyidFlags and qcrypto_x509_get_keyid_len() function
- Removed qcrypto_x509_get_cert_version() and
qcrypto_x509_get_signature_algorithm()
- Passed QCryptoHashAlgo to qcrypto_x509_get_cert_key_id() instead of
QCryptoKeyidFlags
- Improved memory cleanup

hw/s390x/ipl: Create certificate store
- Fixed error handling and memory management
- Added condition to only accept files with ".pem" extension

s390x: Guest support for Certificate Store Facility (CS)
- Renamed "S390_FEAT_DIAG_320" to "S390_FEAT_CERT_STORE"
- Merged this patch with s390x/diag: Introduce DIAG 320 for certificate
store facility patch

s390x/diag: Introduce DIAG 320 for certificate store facility
- Added bit zero to indicate subcode 0 is supported
- Set response code to 0x0102 when the subcode is not supported
- Added check to ensure subcode fits within one byte

s390x/diag: Implement DIAG 320 subcode 1
- Refactored and moved implementation to a helper function
- Added check to ensure VCSSB length is set to a minimum of 128 bytes
from the userspace
- Removed max_vce_len field from the VCSSB data structure

s390x/diag: Implement DIAG 320 subcode 2
- Refactored and split functions for extracting certificate information
- Set VCE length to 72 if certificate is invalid
- Returned VCE even if the certificate is invalid

pc-bios/s390-ccw: Refactor zipl_run()
- Refactor zipl_run_normal() to reduce duplicate code

pc-bios/s390-ccw: Add signature verification for secure IPL in audit mode
- Moved secure-boot related functions into secure-ipl.c/h files
- Rename zipl_handle_sig_entry() to zipl_load_signature()
- Refactored zipl_run_secure() to use switch cases for different entry
types instead of a while loop
- Renamed ZiplBootMode enumerations with "ZIPL_BOOT_MODE" prefix
- Added meaningful file header to secure-ipl.c
- Renamed zipl_secure_print() to zipl_secure_handle()

Changelog v3->v4:

cyrpto/x590-utils
- Updated patch descriptions to summarize what each patch introduces.
- Restricted accepted certificate format on the QEMU command line to PEM
only.
    - Added internal conversion routines to handle PEM-to-DER and
DER-to-PEM as needed.
- Renamed crypto functions using the qcrypto_x509_ prefix.
- Replaced QAPI enums with plain C enums.
- Improved GNUTLS error propagation throughout the crypto API.
- Standardized error returns to -1 (instead of using errno values) for
consistency.
- Removed unused helpers: qcrypto_check_x509_cert_fmt() and
qcrypto_get_x509_hash_len().
- Added bounds checking before converting GNUTLS enums to internal
crypto enums.
- Modified qcrypto_get_x509_cert_key_id() to dynamically allocate the
result.
- Fixed a typo in the crypto API documentation.

hw/s390x/ipl: Create certificate store
- Removed max_size check when loading certificate.
- Removed check_path_type() and use the stat() & S_ISXXX checks inline
where needed.
- Initialized all g_autofree variables.
- Refactored get_cert_paths()
    - Used g_auto(GStrv) and g_autoptr(GPtrArray) for automatic cleanup.
    - Renamed misleading variables and dropped unnecessary intermediates.
    - Replaced check_path_type() with stat(), and treated failures as fatal.
    - Treated empty path components as fatal configuration errors.
    - Used GError with g_dir_open() and handled errors properly.
    - Removed redundant casts and manual cleanup.
- Treated providing 65 or more certificates as a fatal error.
- Modified S390IPLCertificate
    - Changed raw from char * to uint8_t * for API consistency.
    - Added cert_der field to calculate certificate data buffer size for
DIAG 320 and format conversion.

s390x/diag
- Handled error propagation from crypto API correctly.
- Added g_autofree to variables to ensure proper memory cleanup.
- Initialized all g_autofree variables.

pc-bios/s390-ccw: Add signature verification for secure IPL in audit mode
- Allocated certificate buffer based on calculated size instead of
static MAX_CERT_SIZE.

pc-bios/s390-ccw: Add additional security checks for secure boot
- Refactored to improve readability.
- Handled SCLAB Single Component/No Unsigned Component flags.

docs: Add secure IPL documentation
- Updated documentation.
- Illustrated with gnutls ‘certtool’ instead of ‘openssl’ for
consistency with other certificate creation docs.

- Updated cover letter with corresponding changes.

Changelog v2->v3:

- Fixed typos in patches
- Edited and corrected patch description
- Enabled secure IPL feature in TCG
- Split crypto subsystem changes from s390x subsystem changes
    - Added API documentation for each helper function
    - Removed qcrypto_get_x509_cert_fmt()
    - Reworked qcrypto_check_x509_cert_fmt() to return 0 on success and
negative error code on errors
    - Rephrased error messages when GNUTLS is not enabled
    - Changed dev cycle reference from 9.2 to 10.1

hw/s390x/ipl: Create certificate store
- Passed *cert_buf to g_file_get_contents() directly in cert2buf()
- Returned NULL for early returns
- Added check to only allow maximum of 64 certificates in the certificate
store

s390x: Guest support for Certificate Store Facility (CS)
- Renamed “diag320” to “cstore”

s390x/diag: Implement DIAG 320 subcode 1
- Removed QEMU_PACKED from VCStorageSizeBlock
- Removed unnecessary error check from subcode 1 implementation

s390x/diag: Implement DIAG 320 subcode 2
- Removed QEMU_PACKED from VCBlock and VCEngtry
- Reworked diag_320_is_cert_valid() to return 0 on success and negative
error code on errors
- Set *key_id_data and *hash_data to NULL after g_free()
- Moved DIAG_320_SUBC_STORE_VC case block implementation to a separate
function

s390x/diag: Implement DIAG 508 subcode 1 for signature verification
- Added a reserved field to Diag508CertificateStoreInfo
- Removed QEMU_PACKED from Diag508CertificateStoreInfo and
Diag508SignatureVerificationBlock
- Applied g_autofree to svb, svb_comp and svb_sig varaibles
- Moved DIAG_508_SUBC_SIG_VERIF case block implementation to a separate
function

pc-bios/s390-ccw: Refactor zipl_load_segment function
- Removed casting when calculating comp_len

pc-bios/s390-ccw: Add signature verification for secure IPL in audit mode
- Used malloc() to allocate certificate buffer instead of statically
allocating
- Reworked zipl_secure_print()

s390x: Guest support for Secure-IPL Code Loading Attributes Facility (SCLAF)
- Added check to make sure SIPL is enabled when SCLAF is enabled

docs: Add secure IPL documentation
- Split document into two parts:
    - docs/specs/s390x-secure-ipl.rst (developer reference)
    - docs/system/s390x/secure-ipl.rst (user guide)

Changelog v1->v2:

- Fixed typos in patches
- Edited cover letter
- Added secure IPL documentation

QEMU Command-Line Interface:
- Moved boot-certificates under the machine-type option for s390x-virtio-ccw
- Moved secure-boot under the machine-type option for s390x-virtio-ccw

hw/s390x/ipl: Create Certificate Store
- Defined internal GNUTLS-related APIs
- Added check to only accept certificates using SHA-256 hashing
- Recalculated data_buf_size to ensure word alignment
- Cleaned up memory allocation
- Refactored functions for clarity

s390x: Guest Support for Certificate Store Facility (CS)
- Updated patch description to clarify:
    - Why Secure IPL is not available with Secure Execution
    - Why this feature requires S390_FEAT_EXTENDED_LENGTH_SCCB
-Restricted features to z16 due to additional layers requiring z16

s390x/diag: Implement DIAG 320 Subcode 1
- Renamed VerificationCertificate prefix to VC
- Byte-swap written values for endianness correctness

s390x/diag: Implement DIAG 320 Subcode 2
- Edited commit message for clarity
- Defined internal GNUTLS-related APIs
- Renamed data structure variables
- Ensured length fields in VCE are word-aligned
- Handled the VC index 0 case
- General refactoring

s390x/diag: Implement DIAG 508 Subcode 2 for Signature Verification
- Defined subcode from 2 to 1
- Removed unused error codes
- Defined internal GNUTLS-related APIs
- Byte-swap read values

hw/s390x/ipl: Add IPIB Flags to IPL Parameter Block
- Moved DIAG308 flags to a new header file

s390x: Guest Support for Secure-IPL Facility
- Renamed SCLP variable from cbl to fac_ipl

pc-bios/s390-ccw: Add Signature Verification for Secure Boot (Audit Mode)
- Moved Secure IPL-related functions to pc-bios/s390-ccw/secure-ip.c|h
- Refactored code for clarity

Collin L. Walling (2):
  s390x/diag: Introduce DIAG 508 for secure IPL operations
  s390x/diag: Implement DIAG 508 subcode 1 for signature verification

Zhuoying Cai (27):
  Add boot-certs to s390-ccw-virtio machine type option
  crypto/x509-utils: Refactor with GNUTLS fallback
  crypto/x509-utils: Add helper functions for certificate store
  hw/s390x/ipl: Create certificate store
  s390x/diag: Introduce DIAG 320 for Certificate Store Facility
  s390x/diag: Refactor address validation check from diag308_parm_check
  s390x/diag: Implement DIAG 320 subcode 1
  crypto/x509-utils: Add helper functions for DIAG 320 subcode 2
  s390x/diag: Implement DIAG 320 subcode 2
  crypto/x509-utils: Add helper functions for DIAG 508 subcode 1
  pc-bios/s390-ccw: Introduce IPL Information Report Block (IIRB)
  pc-bios/s390-ccw: Define memory for IPLB and convert IPLB to pointers
  hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
  s390x: Guest support for Secure-IPL Facility
  pc-bios/s390-ccw: Refactor zipl_run()
  pc-bios/s390-ccw: Rework zipl_load_segment function
  pc-bios/s390-ccw: Add signature verification for secure IPL in audit
    mode
  s390x: Guest support for Secure-IPL Code Loading Attributes Facility
    (SCLAF)
  pc-bios/s390-ccw: Add additional security checks for secure boot
  Add secure-boot to s390-ccw-virtio machine type option
  hw/s390x/ipl: Set IPIB flags for secure IPL
  pc-bios/s390-ccw: Handle true secure IPL mode
  pc-bios/s390-ccw: Handle secure boot with multiple boot devices
  hw/s390x/ipl: Handle secure boot without specifying a boot device
  tests/functional/s390x: Add secure IPL functional test
  docs/specs: Add secure IPL documentation
  docs/system/s390x: Add secure IPL documentation

 crypto/meson.build                        |   2 +-
 crypto/x509-utils.c                       | 421 ++++++++++++
 docs/specs/s390x-secure-ipl.rst           | 175 +++++
 docs/system/s390x/secure-ipl.rst          | 175 +++++
 hw/s390x/cert-store.c                     | 211 ++++++
 hw/s390x/cert-store.h                     |  41 ++
 hw/s390x/ipl.c                            |  60 ++
 hw/s390x/ipl.h                            |  21 +-
 hw/s390x/meson.build                      |   1 +
 hw/s390x/s390-virtio-ccw.c                |  52 ++
 hw/s390x/sclp.c                           |   2 +
 include/crypto/x509-utils.h               | 135 ++++
 include/hw/s390x/ipl/diag308.h            |  34 +
 include/hw/s390x/ipl/diag320.h            |  91 +++
 include/hw/s390x/ipl/diag508.h            |  41 ++
 include/hw/s390x/ipl/qipl.h               |   7 +-
 include/hw/s390x/s390-virtio-ccw.h        |   3 +
 include/hw/s390x/sclp.h                   |   4 +-
 pc-bios/s390-ccw/Makefile                 |   3 +-
 pc-bios/s390-ccw/bootmap.c                | 112 ++-
 pc-bios/s390-ccw/bootmap.h                |  11 +
 pc-bios/s390-ccw/iplb.h                   |  97 ++-
 pc-bios/s390-ccw/jump2ipl.c               |   6 +-
 pc-bios/s390-ccw/main.c                   | 109 ++-
 pc-bios/s390-ccw/netmain.c                |   8 +-
 pc-bios/s390-ccw/s390-ccw.h               |  19 +
 pc-bios/s390-ccw/sclp.c                   |  52 ++
 pc-bios/s390-ccw/sclp.h                   |   7 +
 pc-bios/s390-ccw/secure-ipl.c             | 803 ++++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h             | 152 ++++
 qapi/machine-s390x.json                   |  23 +
 qapi/pragma.json                          |   1 +
 qemu-options.hx                           |  10 +-
 target/s390x/cpu_features.c               |   7 +
 target/s390x/cpu_features.h               |   1 +
 target/s390x/cpu_features_def.h.inc       |   5 +
 target/s390x/cpu_models.c                 |   7 +
 target/s390x/diag.c                       | 571 ++++++++++++++-
 target/s390x/gen-features.c               |   7 +
 target/s390x/kvm/kvm.c                    |  34 +
 target/s390x/s390x-internal.h             |   4 +
 target/s390x/tcg/misc_helper.c            |  14 +
 tests/functional/s390x/meson.build        |   2 +
 tests/functional/s390x/test_secure_ipl.py | 140 ++++
 44 files changed, 3613 insertions(+), 68 deletions(-)
 create mode 100644 docs/specs/s390x-secure-ipl.rst
 create mode 100644 docs/system/s390x/secure-ipl.rst
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h
 create mode 100644 include/hw/s390x/ipl/diag308.h
 create mode 100644 include/hw/s390x/ipl/diag320.h
 create mode 100644 include/hw/s390x/ipl/diag508.h
 create mode 100644 pc-bios/s390-ccw/secure-ipl.c
 create mode 100644 pc-bios/s390-ccw/secure-ipl.h
 create mode 100644 tests/functional/s390x/test_secure_ipl.py

-- 
2.51.1


