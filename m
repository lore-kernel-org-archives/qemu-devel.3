Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F26CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMF4-0007l2-6n; Tue, 05 May 2026 16:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMF2-0007hE-0j; Tue, 05 May 2026 16:19:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMEz-0000FS-Ug; Tue, 05 May 2026 16:19:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645J1Znq3330886; Tue, 5 May 2026 20:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vEjX0uqKl3hz8mPPc
 TDZNOTid7nDNNw6UHC3uqxRGFo=; b=nQQDueBAhdeNhmYYiFHLMM3Dc+307BEWv
 TwlCVqQT3MSveZKb+jQ/AaAKi1mLosLaf7BVJbOUXp3r2PKv5/JIR5O8OtW9V/py
 FTrSZPwBLkQ4ANcK6fMmKFe3W9GebcLsg7oLN+Kbz8hv8T3olGs34ALCmn7nZPRV
 9Q6ALkbN7LQMDwbjsWRmWn5m2DkQmbAJNr7LfrAjZIB145HN8pBm/Uazt51M1FfA
 lNxl5G10pbjnvLJp0cdMcfCoe4T3M1ptRf0dr6Rr0MDEwYYmHSJM5vbtFDP4ZlA/
 fkR55mAJO6mwBc1c+IvI96tx9xyAb+zYReJjVK59S6xledYwPL+Ag==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7dnnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645K9ah8031779;
 Tue, 5 May 2026 20:19:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqbftd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645KJVbP24838828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 20:19:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B29F25805B;
 Tue,  5 May 2026 20:19:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 215BF5805E;
 Tue,  5 May 2026 20:19:30 +0000 (GMT)
Received: from fedora-workstation.pok.ibm.com (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 20:19:30 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v11 13/32] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
Date: Tue,  5 May 2026 16:18:45 -0400
Message-ID: <20260505201905.997996-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NSBTYWx0ZWRfX4vUBEn9zp59o
 IDNWINq6r49t3A1LWD/RFsHWnMREH3p7tdYQ79lk5u2+L5ORMp+lUvezdhNcztU3x5T7inD8ljI
 ps/VP1EwajRFQVDjjEgMPbkFbG3N1oNoLirDTPmYQoabS9YAZXV6ntMnEcF+zY3lSixdZ2O3DRr
 Oi1sfDhEh1vQ+dabHYBw7ftTlDyDobCbqK9A8hoh5AjwBVRF0+IVs1GgYoGsrwpWvEfNRL88xO1
 8rAyidVnEkAPlzyoQpjE496HCPsuY450tqoPcgi1m0ApCaMwg3FaV33yKrmlpbDcKMRO9ioKbsK
 oeYYDOgPXBlFuI3oVP09q9CfikUdQAUFdlEBPEfICKuaB1Wq4UgLrgBnW86GwIgIYF7VbjSWRd+
 de57uzeB7xuJvWpA7RNc4pe4+Wstf0orL9xTv8UPtDQlWIB83WzJKExmm83pmNedgmhQsryXI1v
 J0PmomVRmRbUqjjFI5Q==
X-Proofpoint-GUID: yDGFDFLe-IvdYVFUJCaHvj2JrgYj2QC3
X-Proofpoint-ORIG-GUID: yDGFDFLe-IvdYVFUJCaHvj2JrgYj2QC3
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fa50d5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=K66z3tz1c1WH2lCF3KIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050195
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

From: Collin Walling <walling@linux.ibm.com>

DIAG 508 subcode 1 performs signature-verification on signed components.
A signed component may be a Linux kernel image, or any other signed
binary. **Verification of initrd is not supported.**

The instruction call expects two item-pairs: an address of a device
component, an address of the analogous signature file (in PKCS#7 DER format),
and their respective lengths. All of this data should be encapsulated
within a Diag508SigVerifBlock.

The DIAG handler will read from the provided addresses
to retrieve the necessary data, parse the signature file, then
perform the signature-verification. Because there is no way to
correlate a specific certificate to a component, each certificate
in the store is tried until either verification succeeds, or all
certs have been exhausted.

A return code of 1 indicates success, and the index and length of the
corresponding certificate will be set in the Diag508SigVerifBlock.
The following values indicate failure:

	0x0102: no certificates are available in the store
	0x0202: component data is invalid
	0x0302: PKCS#7 format signature is invalid
	0x0402: signature-verification failed
	0x0502: length of Diag508SigVerifBlock is invalid

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst |  17 +++++
 include/hw/s390x/ipl/diag508.h  |  30 +++++++++
 target/s390x/diag.c             | 111 +++++++++++++++++++++++++++++++-
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 488981339d..f35e868e4c 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -80,3 +80,20 @@ that requires assistance from QEMU.
 
 Subcode 0 - query installed subcodes
     Returns a 64-bit mask indicating which subcodes are supported.
+
+Subcode 1 - perform signature verification
+    Perform signature-verification on a signed component, using certificates
+    from the certificate store and leveraging qcrypto libraries to perform
+    this operation.
+
+    Note: verification of initrd is not supported.
+
+    A return code of 1 indicates success, and the index and length of the
+    corresponding certificate will be set in the Diag508SigVerifBlock.
+    The following values indicate failure:
+
+    * ``0x0102``: no certificates are available in the store
+    * ``0x0202``: component data is invalid
+    * ``0x0302``: PKCS#7 format signature is invalid
+    * ``0x0402``: signature-verification failed
+    * ``0x0502``: length of Diag508SigVerifBlock is invalid
diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
index 6281ad8299..8a147f32a0 100644
--- a/include/hw/s390x/ipl/diag508.h
+++ b/include/hw/s390x/ipl/diag508.h
@@ -11,5 +11,35 @@
 #define S390X_DIAG508_H
 
 #define DIAG_508_SUBC_QUERY_SUBC    0x0000
+#define DIAG_508_SUBC_SIG_VERIF     0x8000
+
+#define DIAG_508_RC_OK              0x0001
+#define DIAG_508_RC_NO_CERTS        0x0102
+#define DIAG_508_RC_INVAL_COMP_DATA 0x0202
+#define DIAG_508_RC_INVAL_PKCS7_SIG 0x0302
+#define DIAG_508_RC_FAIL_VERIF      0x0402
+#define DIAG_508_RC_INVAL_LEN       0x0502
+
+/*
+ * Maximum componenet and signature sizes for current secure boot implementation
+ * Not architecturally defined and may need to revisit if increased
+ */
+#define DIAG_508_MAX_COMP_LEN      0x10000000
+#define DIAG_508_MAX_SIG_LEN       4096
+
+struct Diag508SigVerifBlock {
+    uint32_t length;
+    uint8_t reserved0[3];
+    uint8_t version;
+    uint32_t reserved[2];
+    uint8_t cert_store_index;
+    uint8_t reserved1[7];
+    uint64_t cert_len;
+    uint64_t comp_len;
+    uint64_t comp_addr;
+    uint64_t sig_len;
+    uint64_t sig_addr;
+};
+typedef struct Diag508SigVerifBlock Diag508SigVerifBlock;
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 390a543ede..0d548fadd9 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -640,9 +640,110 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
     }
 }
 
+static bool diag_508_verify_sig(uint8_t *cert, size_t cert_size,
+                                uint8_t *comp, size_t comp_size,
+                                uint8_t *sig, size_t sig_size)
+{
+    g_autofree uint8_t *sig_pem = NULL;
+    size_t sig_size_pem;
+    int rc;
+
+    /*
+     * PKCS#7 signature with DER format
+     * Convert to PEM format for signature verification
+     *
+     * Ignore errors during qcrypto signature format conversion and verification
+     * Return false on any error, treating it as a verification failure
+     */
+    rc = qcrypto_pkcs7_convert_sig_pem(sig, sig_size, &sig_pem, &sig_size_pem, NULL);
+    if (rc < 0) {
+        return false;
+    }
+
+    rc = qcrypto_x509_verify_sig(cert, cert_size,
+                                 comp, comp_size,
+                                 sig_pem, sig_size_pem, NULL);
+    if (rc < 0) {
+        return false;
+    }
+
+    return true;
+}
+
+static int handle_diag508_sig_verif(uint64_t addr)
+{
+    int verified;
+    uint32_t svb_len;
+    uint64_t comp_len, comp_addr;
+    uint64_t sig_len, sig_addr;
+    g_autofree uint8_t *comp = NULL;
+    g_autofree uint8_t *sig = NULL;
+    g_autofree Diag508SigVerifBlock *svb = NULL;
+    size_t svb_size = sizeof(Diag508SigVerifBlock);
+    S390IPLCertificateStore *cs = s390_ipl_get_certificate_store();
+
+    if (!cs->count) {
+        return DIAG_508_RC_NO_CERTS;
+    }
+
+    svb = g_new0(Diag508SigVerifBlock, 1);
+    cpu_physical_memory_read(addr, svb, svb_size);
+
+    svb_len = be32_to_cpu(svb->length);
+    if (svb_len != svb_size) {
+        return DIAG_508_RC_INVAL_LEN;
+    }
+
+    comp_len = be64_to_cpu(svb->comp_len);
+    comp_addr = be64_to_cpu(svb->comp_addr);
+    sig_len = be64_to_cpu(svb->sig_len);
+    sig_addr = be64_to_cpu(svb->sig_addr);
+
+    if (!comp_len || !comp_addr || comp_len > DIAG_508_MAX_COMP_LEN) {
+        if (comp_len > DIAG_508_MAX_COMP_LEN) {
+            warn_report("DIAG 0x508: component length %lu exceeds current maximum %u",
+                        comp_len, DIAG_508_MAX_COMP_LEN);
+        }
+        return DIAG_508_RC_INVAL_COMP_DATA;
+    }
+
+    if (!sig_len || !sig_addr || sig_len > DIAG_508_MAX_SIG_LEN) {
+        if (sig_len > DIAG_508_MAX_SIG_LEN) {
+            warn_report("DIAG 0x508: signature length %lu exceeds current maximum %u",
+                        sig_len, DIAG_508_MAX_SIG_LEN);
+        }
+        return DIAG_508_RC_INVAL_PKCS7_SIG;
+    }
+
+    comp = g_malloc0(comp_len);
+    cpu_physical_memory_read(comp_addr, comp, comp_len);
+
+    sig = g_malloc0(sig_len);
+    cpu_physical_memory_read(sig_addr, sig, sig_len);
+
+    for (int i = 0; i < cs->count; i++) {
+        verified = diag_508_verify_sig(cs->certs[i].raw,
+                                       cs->certs[i].size,
+                                       comp, comp_len,
+                                       sig, sig_len);
+        if (verified) {
+            svb->cert_store_index = i;
+            svb->cert_len = cpu_to_be64(cs->certs[i].der_size);
+            cpu_physical_memory_write(addr, svb, svb_size);
+            return DIAG_508_RC_OK;
+       }
+    }
+
+    return DIAG_508_RC_FAIL_VERIF;
+}
+
+QEMU_BUILD_BUG_MSG(sizeof(Diag508SigVerifBlock) != 64,
+                   "size of Diag508SigVerifBlock is wrong");
+
 void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     uint64_t subcode = env->regs[r3];
+    uint64_t addr = env->regs[r1];
     int rc;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -657,7 +758,15 @@ void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_508_SUBC_QUERY_SUBC:
-        rc = 0;
+        rc = DIAG_508_SUBC_SIG_VERIF;
+        break;
+    case DIAG_508_SUBC_SIG_VERIF:
+        if (!diag_parm_addr_valid(addr, sizeof(Diag508SigVerifBlock), true)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        rc = handle_diag508_sig_verif(addr);
         break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-- 
2.54.0


