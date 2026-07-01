Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C215C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1sM-00039O-Me; Wed, 01 Jul 2026 16:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1sK-00038K-Sr; Wed, 01 Jul 2026 16:49:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1sG-0003nN-1z; Wed, 01 Jul 2026 16:49:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661Gml5L1339779; Wed, 1 Jul 2026 20:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=FqGmQEMF6BL1OIRNUNFabULjcbWt
 ZDyvfmWMi3txPMY=; b=XzDSR//Id/qwMuOCTxdinaopf624AH2ct0PuHzvedkej
 qAOVtcnx66n2pe6x6/lNTvYOGcer7mXqMUcSyUTF7sv/SgakpgJ6LBWFICEBYqXA
 mZ4d27JEzck/VMVIl9kYhqebWnJzlhr8SrkzZFtYPkDsK33tUVsboqdsyep2fzHD
 7k+Nk2F2NHgJ/3EnYbxyLMDczt5CHH93OnHCwyB+YhoiEgw9HDHlF7rE7+JIzp55
 yQw70ThjdKJpzbYji0gZj327DEiabSZarHNwKGC8ITzmkYSXNhGqjPUc5Vg2X/DK
 0k1kwzA4Zn416gaoaLNLOT4yvOafw3Ws5EneAHLBog==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa69ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:49:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661KYiCB023537;
 Wed, 1 Jul 2026 20:49:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhh0pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:49:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661KnQM227198092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:49:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2E515804E;
 Wed,  1 Jul 2026 20:49:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A5D05803F;
 Wed,  1 Jul 2026 20:49:23 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:49:23 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 00/35] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
Date: Wed,  1 Jul 2026 16:48:46 -0400
Message-ID: <20260701204922.1320349-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX06NimxNLSm7P
 KZK9jq0+gT4d0KZbOaU+rbaxa73XaPFIXzPUEFMvRPdB78zNeGa3lATFGmW9EvLkfzd6JWn4zbU
 fGHMjC9BpPCHzlQ87k/JaD4bOJ8+bpFlmGI/zj3PY2ZFccD+kYYPc/qb/LkX1lkSzW9USPsTWhb
 +Ox/7WseGpUJiUJ1uZ6yWQO3HuaHc7FgL4LNr/u9JpHi3QeThPfsiwg4KHFoFPZ+JEBtk7oX8k2
 bUb3kWKiiAwboTevbgWGbtXlEWRpKifFsbzQyH9olVC5PWfl7mXme4Qgr8J7HThSiTel1Q9UUkW
 yHlZ8HnwZjaJP4wzQPH1lsiSL+KTRjcd1Z4k7bpcrJ23JcLMimeDJVmEMRZey3P3fiHys4iNvML
 CCLHvmPqBW2i5Xl1rqdQXc78Re2XR7vbQsws1785icMxlcP3Jwk5sAfhzObnEs8RpY/FkTd5hF1
 Wgc+Tm6VACAvsfjLCEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX72vjtzzytT3h
 TP4+TfgrUU6j7KgNAS5vhUYXVw/MBWSKKvmXj+HhJ8ZUbyzolE7zLMjokcFtnLcfa573ruqecMm
 yzRXeQ7LP1J7k+uu/IN83kMyBJ83TLk=
X-Proofpoint-GUID: 1nemuX56dndqudTrlElAlFeW2u_WqfM2
X-Proofpoint-ORIG-GUID: 1nemuX56dndqudTrlElAlFeW2u_WqfM2
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a457d59 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=q5T4S90kAAAA:8 a=20KFwNOVAAAA:8 a=wTrWf8oUr1rh5E4Anm0A:9
 a=K1Kt1Xme3EO4KJYT:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=LnBBZQxPVJ0Z7KJyRdxh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010222
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

Changelog v11 -> v12

New patches
- s390x/diag: generalize s390_ipl_read/write to accept void *
- hw/s390x/ipl: Rework s390_ipl_map_iplb_chain for certificate
  storage
- s390x/ipl: re-apply secure boot flags on DIAG 308 reboot

[PATCH v11 04/32] hw/s390x/ipl: Create certificate store
- Edited commit message and documentation
- Performed general code cleanup
   - init_cert()
     - Used g_autofree for temporary certificate buffers
     - Used g_steal_pointer() for ownership transfer

[PATCH v11 07/32] s390x/diag: Implement DIAG 320 subcode 1
- Renamed VCSSB_MIN_LEN to VCSSB_LEN_VALID

[PATCH v11 08/32] crypto/x509-utils: Add helper functions for
DIAG 320 subcode 2
- Fixed typos

[PATCH v11 09/32] s390x/diag: Implement DIAG 320 subcode 2
- Corrected VCE header length conversion value
- Defined key, format, and hash types as enumerations
- Moved is_cert_valid() logic into build_vce_header()
- Improved readability of handle_*() helpers
- Improved handle_diag320_store_vc()
- Used g_autofree for VCEntry *vce
- Allocated only the VCB header since VCEs are written
  independently
- Refactored VCE construction logic

[PATCH v11 10/32] hw/s390x: Define finite size for single entry
VCEntry
- Renamed MAX_ENTRY_SIZE to MAX_VCENTRY_SIZE

[PATCH v11 13/32] s390x/diag: Implement DIAG 508 subcode 1 for
signature verification
- Replaced cpu_physical_memory_*() with s390_ipl_*() helpers

[PATCH v11 16/32] hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
[PATCH v11 18/32] pc-bios/s390-ccw: Refactor zipl_run()
[PATCH v11 19/32] pc-bios/s390-ccw: Rework zipl_load_segment function
[PATCH v11 20/32] pc-bios/s390-ccw: Introduce ZiplBootMode enum
for IPL mode selection
[PATCH v11 25/32] Add secure-boot to s390-ccw-virtio machine type option
- Reviewed-by: Collin Walling <walling@linux.ibm.com>

[PATCH v11 21/32] pc-bios/s390-ccw: Add signature verification
for secure IPL in audit mode
- Refactored zipl_secure_get_vcssb() to return lengths and
  handle errors
- Removed get_total_certs_length()
- request_certificate()
  - Added explicit error reporting when DIAG 320 certificate
    retrieval fails
  - Edited memory allocation error message with:
    panic("Not enough memory to store requested certificate")
- zipl_run_secure()
  - Replaced SecureIplCompEntryInfo with IplDeviceComponentEntry and
    IplSignatureCertificateEntry
  - Used total_vc_count in cert_list_table[]
  - Logged unsigned component
  - Refactored certificate buffer handling
    - Store certificates in qipl-owned memory
    - Prevent BIOS/kernel memory collisions
  - Freed certificate buffers in error paths
- Set qipl.chain_len to zero if lghi failed in jump2ipl.c to abort IPL
  early

[PATCH v11 22/32] pc-bios/s390-ccw: Add signed component address
overlap checks
- Modeled overlap detection after the kernel intersect()
  helper
- Reused existing IplDeviceComponentList
- Removed custom SecureIplCompAddrRangeList structure

[PATCH v11 24/32] pc-bios/s390-ccw: Add additional security
checks for secure boot
- Refactored is_psw_valid() using intersect()
- Refactored check_global_sclab()
- Removed custom SecureIplSclabInfo structure
- Refactored check_sclab()

[PATCH v11 27/32] pc-bios/s390-ccw: Handle true secure IPL mode
- Refactored get_boot_mode()
- Handled secure IPL capability errors earlier in the boot
  flow

[PATCH v11 28/32] hw/s390x/ipl: Handle secure boot with multiple
boot devices
- Extracted secure boot flag setting into
  s390_set_secure_boot_flags() helper

[PATCH v11 30/32] tests/functional/s390x: Add secure IPL
functional test
- Added docstring
- Refactored setup_s390x_secure_ipl() into standalone helpers
- Added slirp dependency
- Increased test timeout from 280s to 360s to accommodate
  package and qcow2 downloads

[PATCH v11 32/32] docs/system/s390x: Add secure IPL documentation
- Mentioned that re-signing a component results in verification failure

------------------------------------------------------------------------

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

- z16 or "qemu" CPU model

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

Changelog v10->v11

crypto/x509-utils
- Replaced gnutls_free() with g_free()
- Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
  Acked-by: Daniel P. Berrangé <berrange@redhat.com>

[PATCH v10 07/30] s390x/diag: Implement DIAG 320 subcode 1
- Defined VCEntryHeader and VCBlockHeader
- Replaced header length macros with sizeof(...)

[PATCH v10 09/30] s390x/diag: Implement DIAG 320 subcode 2
- Split VCB and VCE into separate header and buffer structures

[NEW] hw/s390x: Define finite size for single entry VCEntry
- Introduced size limits for VCEntry
  * Defined MAX_ENTRY_SIZE as 8 KB
  * Defined CERT_BUF_MAX_LEN as MAX_ENTRY_SIZE -
    sizeof(VCEntryHeader)
- Updated update_cert_store()
  * Enforced certificate buffer size limit using CERT_BUF_MAX_LEN

[PATCH v10 13/30] s390x/ipl: Introduce IPL Information Report
Block (IIRB)
- Adjusted IplDeviceComponentList sizing
  * Used MAX_COMP_ENTRIES =
    (largest supported block size - 32) / 32

[PATCH v10 14/30] pc-bios/s390-ccw: Define memory for IPLB and
convert IPLB to pointers
- Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v10 15/30] hw/s390x/ipl: Add IPIB flags to IPL Parameter
Block
- Removed duplicated S390_IPL_TYPE* definitions
- Moved IPLB length definitions to qipl.h

[PATCH v10 17/30] pc-bios/s390-ccw: Refactor zipl_run()
- Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

[PATCH v10 18/30] pc-bios/s390-ccw: Rework zipl_load_segment
function
- Used block_number_t blockno and uint64_t address parameters

[NEW] pc-bios/s390-ccw: Introduce ZiplBootMode for IPL mode
selection
- Added ZiplBootMode enum
  * Introduced Normal mode
  * Performed IPL validation based on selected boot mode

[PATCH v10 19/30] pc-bios/s390-ccw: Add signature verification
for secure IPL in audit mode
- Refactored list_add helpers
  * cert_list_add() printed warning once at limit and
    returned index
  * comp_list_add() panicked on overflow
- zipl_load_signature()
  * Renamed sig_sec -> sig
  * Reordered condition checks
- zipl_run_secure()
  * Renamed cert_addr -> cert_buf
  * Used SecureIplCompEntryInfo for signature metadata
  * Renamed label out -> error
- Moved secure IPL checks earlier in flow
- DIAG320 updates
  * Renamed diag320 -> _diag320
  * Replaced vcssb_data[] with VCStorageSizeBlock
  * Replaced vcb_data[] with local VCBlock containing one
    VCE and cert_data[MAX_SIZE]
  * Panicked if remain_ct != 0
- Renamed zipl_secure_handle() -> zipl_secure_error()

[PATCH v10 20/30] pc-bios/s390-ccw: Add signed component address
overlap checks
- comp_addr_range_add()
  * Returned early when array limit was reached
  * Moved index increment into this function
- Renamed is_comp_overlap -> check_comp_overlap
- SecureIplCompAddrRangeList
  * Renamed index -> num
  * Adjusted array size to MAX_COMP_ENTRIES

[PATCH v10 22/30] pc-bios/s390-ccw: Add additional security
checks for secure boot
- Refactored validate_comp_condition()
  * Renamed to zipl_secure_validate()
  * Replaced functions with a single check with zipl_secure_validate()
- Renamed SCLAB flags and SCLAB structure
- Reworked sclp_get_fac_ipl()
  * Renamed to sclp_is_fac_ipl_flag_on()
  * Accepted flags parameter and returned masked result

[PATCH v10 24/30] hw/s390x/ipl: Set IPIB flags for secure IPL
- Reviewed-by: Collin Walling <walling@linux.ibm.com>

[PATCH v10 25/30] pc-bios/s390-ccw: Handle true secure IPL mode
- Reported missing SCLAB in audit mode

Documentation
- Fixed title hierarchy issues
- Added link to referenced document
- Clarified zipl must run on guest filesystem

Changelog v9->v10

[PATCH v9 09/30] s390x/diag: Implemented DIAG 320 subcode 2
- Reworded documentation.
- Used vce->len directly from handle_diag320_store_vc().
- Dropped entry_offset; used vcb->out_len from
  handle_diag320_store_vc().

[PATCH v9 13/30] s390x/ipl: Introduced IPL Information Report Block (IIRB)
- Clarified IIRB in documentation and commit message.
- Reviewed-by: Collin Walling <walling@linux.ibm.com>

[PATCH v9 19/30] pc-bios/s390-ccw: Added signature verification for
secure IPL in audit mode
- Removed trailing newline from sclp_get_fac_ipl().
- Zeroed VCB on error path in request_certificate() using memset().
- Introduced component-entry tracking struct to reduce parameter passing.
- Fixed signed/unsigned error-code mismatches in zipl_run_secure().
    - Fixed sig_len/comp_len type mismatch causing negative error
      misinterpretation.
- Dropped unnecessary initialization of cert_len and cert_table_idx
  in zipl_run_secure().

[PATCH v9 20/30] pc-bios/s390-ccw: Added signed component address
overlap checks
- Updated is_comp_overlap() comment.
- Tracked component ranges using SecureIplCompAddrRangeList.

[PATCH v9 22/30] pc-bios/s390-ccw: Added additional security checks for
secure boot
- Refactored functions to reduce parameters.
- Renamed set_comp_cei_with_log() to validate_comp_condition() and
  returned a status flag.
- Renamed security-check helpers for clarity.
    - check_nuc → check_no_unsigned_comp
    - check_sc → check_single_comp
    - check_signed_comp → check_has_signed_comp
- Added signed and unsigned counters to SecureIplSclabInfo.
- Added comment for SCLAB helper struct.

[PATCH v9 25/30] pc-bios/s390-ccw: Handled true secure IPL mode
- Removed ZIPL_BOOT_MODE_INVALID; failed immediately on invalid boot mode.
- Reviewed-by: Collin Walling <walling@linux.ibm.com>

Changelog v8->v9

Documentation
- Replaced "userspace" with "guest code".

[PATCH v8 01/30] Add boot-certs to s390-ccw-virtio machine type
option
- Fixed typo and formatting issues in documentation.

[PATCH v8 04/30] hw/s390x/ipl: Create certificate store
- Fixed coding-style issues.
- Corrected the maximum certificate count check.
- Removed QEMU_BUILD_BUG_MSG from cert-store.h.
- Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v8 05/30] s390x/diag: Introduce DIAG 320 for Certificate
Store Facility
- Updated documentation.
- Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v8 06/30] s390x/diag: Refactor address validation check from
diag308_parm_check
- Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v8 07/30] s390x/diag: Implement DIAG 320 subcode 1
- Adjusted return code in handle_diag320_query_vcsi().
- Changed double-word boundary handling to use a specification
  interrupt rather than an address interrupt.

[PATCH v8 09/30] s390x/diag: Implement DIAG 320 subcode 2
- Fixed a build error caused by a missing include.
- Added a comment documenting VCE_INVALID_LEN usage.
- Enforced 4 KB alignment for the subcode 2 address.

[PATCH v8 12/30] s390x/diag: Implement DIAG 508 subcode 1 for
signature verification
- Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v8 13/30] s390x/ipl: Introduce IPL Information Report Block
(IIRB)
- Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

[PATCH v8 14/30] pc-bios/s390-ccw: Define memory for IPLB and convert
IPLB to pointers
- Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v8 16/30] s390x: Guest support for Secure-IPL Facility
- Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v8 19/30] pc-bios/s390-ccw: Add signature verification for
secure IPL in audit mode
- Corrected ROUND_UP usage and added a remark similar to the one in
  osdep.h.
- Merged sclp_is_diag320_on() and sclp_get_fac134().
- Declared vcssb_data as static.
- Ensured vcssb_data is double-word aligned as required by DIAG 320
  subcode 1.
- Reset vcssb->length on errors (e.g., set to 0).
- Defined vcb_data as a static array with 4 KB alignment, as required
  by DIAG 320 subcode 2.
- Ensured the boot process exits when required facilities are missing
  in secure/audit mode.

[PATCH v8 20/30] pc-bios/s390-ccw: Add signed component address
overlap checks
- Handled out-of-range component address range indices according to
  the active boot mode.

[PATCH v8 21/30] s390x: Guest support for Secure-IPL Code Loading
Attributes Facility (SCLAF)
- Fixed a documentation build issue.

[PATCH v8 22/30] pc-bios/s390-ccw: Add additional security checks for
secure boot
- Fixed coding-style issues.

[PATCH v8 24/30] hw/s390x/ipl: Set IPIB flags for secure IPL
- Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v8 25/30] pc-bios/s390-ccw: Handle true secure IPL mode
- Removed ZIPL_BOOT_MODE_INVALID case from zipl_run() and allowed the
  default case to handle it.

[PATCH v8 26/30] hw/s390x/ipl: Handle secure boot with multiple boot
devices
- Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v8 28/30] tests/functional/s390x: Add secure IPL functional
test
- Made the test executable (chmod a+x) to allow direct execution
  outside the Meson harness.
- Updated the test to operate on a copied asset using qemu-img -b.

Changelog v7->v8

- Edited documentation

[PATCH v7 01/29] Add boot-certs to s390-ccw-virtio machine type
option
- Updated version number from 10.2 to 11.0

[PATCH v7 02/29] crypto/x509-utils: Refactor with GNUTLS fallback
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v7 03/29] crypto/x509-utils: Add helper functions for
certificate store
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v7 04/29] hw/s390x/ipl: Create certificate store
- Merged init_cert_x509() with init_cert()
- Simplified certificate path handling; removed redundant NULL
  checks in get_cert_paths()
- Added warnings for empty certificate directories and non-.pem
  files
- Renamed variables: VC_* → CERT_* and max_cert_size →
  largest_cert_size
- Made certificate store initialization independent of kernel/IPLB
  state
- Fixed memory leak
- Added comments explaining why DER data is not stored in
  S390IPLCertificate

[PATCH v7 05/29] s390x/diag: Introduce DIAG 320 for Certificate Store
Facility
- Simplified control flow in handle_diag_320()
- Removed the word "Provide" from description text

[PATCH v7 06/29] s390x/diag: Refactor address validation check from
diag308_parm_check()
- Added Reviewed-by: Collin Walling <walling@linux.ibm.com>
- Added Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

[PATCH v7 07/29] s390x/diag: Implement DIAG 320 subcode 1
- Added upper-bound validation for vcssb->length
- Added Reviewed-by: Collin Walling <walling@linux.ibm.com>

[PATCH v7 08/29] crypto/x509-utils: Add helper functions for DIAG 320
subcode 2
- Simplified ECC curve validation logic
- Moved public-key algorithm detection to internal helpers
- Removed unused QCRYPTO_PK_ALGO enum
- Fixed commit message

[PATCH v7 09/29] s390x/diag: Implement DIAG 320 subcode 2
- Added sanity checks for key ID retrieval; mark certificates
  invalid if extraction fails
- Reworked VCE construction logic
- Pass S390IPLCertificate as const pointers instead of copying
  structs

[PATCH v7 10/29] s390x/diag: Introduce DIAG 508 for secure IPL
operations
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v7 11/29] crypto/x509-utils: Add helper functions for DIAG 508
subcode 1
- Fixed typos
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>
- Added Reviewed-by: Farhan Ali <alialifm@linux.ibm.com>

[PATCH v7 12/29] s390x/diag: Implement DIAG 508 subcode 1 for signature
verification
- Added comments on maximum component and signature lengths
- Added warning indicating failures due to oversize signature or
  component
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v7 13/29] pc-bios/s390-ccw: Introduce IPL Information Report
Block (IIRB)
- Updated documentation describing guest kernel usage of certificate
  data in the IIRB
- Simplified and renamed flags and type definitions
- Merged unused and reserved fields
- Moved IIRB definitions from pc-bios/s390-ccw/iplb.h to
  include/hw/s390x/ipl/qipl.h

[PATCH v7 14/29] pc-bios/s390-ccw: Define memory for IPLB and convert
IPLB to pointers
- Moved IplBlocks struct from pc-bios/s390-ccw/iplb.h to
  include/hw/s390x/ipl/qipl.h
- Moved attribute annotations to the ipl_data declaration in main.c

  * Note: checkpatch.pl flags the following:
          ERROR: externs should be avoided in .c files
          #88: FILE: pc-bios/s390-ccw/main.c:26:
          +IplBlocks ipl_data __attribute__((__aligned__(PAGE_SIZE)));

This appears to be a false positive, as IplBlocks is not declared as an
extern in a .c file, and checkpatch.pl reports the same warning for the
existing IplParameterBlock declaration in main.c even before this patch.

[PATCH v7 15/29] hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v7 16/29] s390x: Guest support for Secure-IPL Facility
- Fixed reserved-field off-by-one error

[PATCH v7 17/29] pc-bios/s390-ccw: Refactor zipl_run()
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v7 19/29] pc-bios/s390-ccw: Add signature verification for
secure IPL in audit mode
- Updated warning message
- Simplified control flow and error handling in zipl_run()
- Removed UNSPECIFIED boot mode and defaulted to NORMAL
- Refactored zipl_run_secure()
  - Renamed variables and functions
- Adjusted index handling in verify_signature(), accounting for
  DIAG 320 when retrieving certificates

[PATCH v7 21/29] pc-bios/s390-ccw: Add additional security checks for
secure boot
- Renamed constants:
    S390_IPL_INFO_IIEI_* → S390_IIEI_*
    S390_IPL_COMPONENT_CEI_* → S390_CEI_*
- Improved readability by reducing function parameter counts
- Fixed check_sc() to allow only a single signed binary component
- Moved address-range/overlap checks to a separate patch

[PATCH v7 22/29] Add secure-boot to s390-ccw-virtio machine type option
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v7 23/29] hw/s390x/ipl: Set IPIB flags for secure IPL
- Fixed commit message

[PATCH v7 24/29] pc-bios/s390-ccw: Handle true secure IPL mode
- Updated documentation
- Fixed typo

[PATCH v7 25/29] pc-bios/s390-ccw: Handle secure boot with multiple
boot devices
- Handled support for multiple secure boot devices on the QEMU side

[PATCH v7 26/29] hw/s390x/ipl: Handle secure boot without a specified
boot device
- Added Reviewed-by: Thomas Huth <thuth@redhat.com>

[PATCH v7 27/29] tests/functional/s390x: Add secure IPL
- Cleaned up test code
- Switched from time.sleep() to wait_for_console_pattern()

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
- Reworded document to avoid the term "KVM"
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
- Illustrated with gnutls 'certtool' instead of 'openssl' for
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
- Renamed "diag320" to "cstore"

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

Zhuoying Cai (33):
  Add boot-certs to s390-ccw-virtio machine type option
  crypto/x509-utils: Refactor with GNUTLS fallback
  crypto/x509-utils: Add helper functions for certificate store
  hw/s390x/ipl: Create certificate store
  s390x/diag: Introduce DIAG 320 for Certificate Store Facility
  s390x/diag: Refactor address validation check from diag308_parm_check
  s390x/diag: Implement DIAG 320 subcode 1
  crypto/x509-utils: Add helper functions for DIAG 320 subcode 2
  s390x/diag: Implement DIAG 320 subcode 2
  hw/s390x: Define finite size for single entry VCEntry
  crypto/x509-utils: Add helper functions for DIAG 508 subcode 1
  s390x/diag: generalize s390_ipl_read/write to accept void *
  s390x/ipl: Introduce IPL Information Report Block (IIRB)
  pc-bios/s390-ccw: Define memory for IPLB and convert IPLB to pointers
  hw/s390x/ipl: Add IPIB flags to IPL Parameter Block
  hw/s390x/ipl: Rework s390_ipl_map_iplb_chain for certificate storage
  s390x: Guest support for Secure-IPL Facility
  pc-bios/s390-ccw: Refactor zipl_run()
  pc-bios/s390-ccw: Rework zipl_load_segment function
  pc-bios/s390-ccw: Introduce ZiplBootMode enum for IPL mode selection
  pc-bios/s390-ccw: Add signature verification for secure IPL in audit
    mode
  pc-bios/s390-ccw: Add signed component address overlap checks
  s390x: Guest support for Secure-IPL Code Loading Attributes Facility
    (SCLAF)
  pc-bios/s390-ccw: Add additional security checks for secure boot
  Add secure-boot to s390-ccw-virtio machine type option
  hw/s390x/ipl: Set IPIB flags for secure IPL
  pc-bios/s390-ccw: Handle true secure IPL mode
  hw/s390x/ipl: Handle secure boot with multiple boot devices
  hw/s390x/ipl: Handle secure boot without specifying a boot device
  s390x/ipl: re-apply secure boot flags on DIAG 308 reboot
  tests/functional/s390x: Add secure IPL functional test
  docs/specs: Add secure IPL documentation
  docs/system/s390x: Add secure IPL documentation

 crypto/meson.build                        |   2 +-
 crypto/x509-utils.c                       | 409 +++++++++++++++
 docs/specs/index.rst                      |   1 +
 docs/specs/s390x-secure-ipl.rst           | 197 ++++++++
 docs/system/s390x/secure-ipl.rst          | 184 +++++++
 docs/system/target-s390x.rst              |   1 +
 hw/s390x/cert-store.c                     | 234 +++++++++
 hw/s390x/cert-store.h                     |  38 ++
 hw/s390x/ipl.c                            | 118 ++++-
 hw/s390x/ipl.h                            |  27 +-
 hw/s390x/meson.build                      |   1 +
 hw/s390x/s390-virtio-ccw.c                |  52 ++
 hw/s390x/sclp.c                           |   2 +
 include/crypto/x509-utils.h               | 113 +++++
 include/hw/s390x/ipl/diag308.h            |  34 ++
 include/hw/s390x/ipl/diag320.h            | 118 +++++
 include/hw/s390x/ipl/diag508.h            |  45 ++
 include/hw/s390x/ipl/qipl.h               | 110 +++-
 include/hw/s390x/s390-virtio-ccw.h        |   3 +
 include/hw/s390x/sclp.h                   |   4 +-
 pc-bios/s390-ccw/Makefile                 |   2 +-
 pc-bios/s390-ccw/bootmap.c                | 108 +++-
 pc-bios/s390-ccw/bootmap.h                |  11 +
 pc-bios/s390-ccw/iplb.h                   |   9 +-
 pc-bios/s390-ccw/jump2ipl.c               |  13 +-
 pc-bios/s390-ccw/main.c                   |  58 ++-
 pc-bios/s390-ccw/netmain.c                |   8 +-
 pc-bios/s390-ccw/s390-ccw.h               |  27 +
 pc-bios/s390-ccw/sclp.c                   |  27 +
 pc-bios/s390-ccw/sclp.h                   |   7 +
 pc-bios/s390-ccw/secure-ipl.c             | 545 ++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h             | 176 +++++++
 qapi/machine-s390x.json                   |  23 +
 qapi/pragma.json                          |   1 +
 qemu-options.hx                           |  10 +-
 target/s390x/cpu_features.c               |   7 +
 target/s390x/cpu_features.h               |   1 +
 target/s390x/cpu_features_def.h.inc       |   5 +
 target/s390x/cpu_models.c                 |   7 +
 target/s390x/diag.c                       | 578 +++++++++++++++++++++-
 target/s390x/gen-features.c               |   7 +
 target/s390x/kvm/kvm.c                    |  34 ++
 target/s390x/s390x-internal.h             |   4 +
 target/s390x/tcg/misc_helper.c            |  14 +
 tests/functional/s390x/meson.build        |   2 +
 tests/functional/s390x/test_secure_ipl.py | 172 +++++++
 46 files changed, 3458 insertions(+), 91 deletions(-)
 create mode 100644 docs/specs/s390x-secure-ipl.rst
 create mode 100644 docs/system/s390x/secure-ipl.rst
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h
 create mode 100644 include/hw/s390x/ipl/diag308.h
 create mode 100644 include/hw/s390x/ipl/diag320.h
 create mode 100644 include/hw/s390x/ipl/diag508.h
 create mode 100644 pc-bios/s390-ccw/secure-ipl.c
 create mode 100644 pc-bios/s390-ccw/secure-ipl.h
 create mode 100755 tests/functional/s390x/test_secure_ipl.py

-- 
2.54.0


