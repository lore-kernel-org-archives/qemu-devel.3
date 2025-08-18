Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3ACCA0EE9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7eV-0001xG-30; Mon, 18 Aug 2025 17:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7eF-0001ou-Ip; Mon, 18 Aug 2025 17:44:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7dq-0003mY-2Z; Mon, 18 Aug 2025 17:44:09 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IHpNKZ025716;
 Mon, 18 Aug 2025 21:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5sCY091RE+vTIef3g
 kdp/DqTC7/Pdj4qMj960hJor/0=; b=AiACi4KW+twRwt1V+NnuVhOdQo+NnjaJq
 KHcAPkN/58Kuuqh5TykE8tlK31ddWqYSbPjb6chDSkEA7MvRXAIf9X/L3zOgJ3pD
 gZyE63qIugzTtVHDy7ITzO/Y7Z8GlAkkpBLOPz4dwKS2HET2t7Iy6ICEXu9VL60/
 jDgxL5PGTtTsxAJhzlt6aT9iLy5l4QsIcqNmkUzLBixXTG6jnuUJGdt1I5cwvxJJ
 P4f2yyNfK6R3kCWualmSQ5J7Wjzkq6c6M0pPh43ZcdhBPb50jXY/GyuIlLW6Sryf
 fUUb5MBDtFnPp9mw9CGofQ2PQnVuxR4ucDYBIS3TiU19TALZGaGiw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9ugj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJ9QTE014728;
 Mon, 18 Aug 2025 21:43:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k5tmqgnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57ILhe4b26083718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 21:43:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37BB258057;
 Mon, 18 Aug 2025 21:43:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DBC258058;
 Mon, 18 Aug 2025 21:43:39 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.98.172])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Aug 2025 21:43:39 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 12/29] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
Date: Mon, 18 Aug 2025 17:43:05 -0400
Message-ID: <20250818214323.529501-13-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818214323.529501-1-zycai@linux.ibm.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N50pF39B c=1 sm=1 tr=0 ts=68a39e8f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=QUeH2xgz5R9ERI6wYg0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX26j1X59KjhXw
 lUGj7ZULR2/1WDQdW0w6YaOdgkWmSJcqsbDrhQ8BySIZbZ7Bc9O72L4pH2QoI1nbVqQWkyKyyxR
 KqHiT1BaFy5m+SLCDRN54NNvEs6/oyYT+SWvZCV7uvC8/dxomp1E+NZjEMC52bob4ahK3cMdQbF
 VDtM1XFpJGdy6NNVL+HXyBauVNLzcwaAgQ3EUlnwbOodxrfgcgIkYiEXi735rGhbECDvEUBBdnZ
 DCBkNQJ/wX6QPqnqGKbVCnuSyqEP+Lon+/ZMAf2QewYUPNqs45ThMp7tWDlBKQqp+kW97yY/bFk
 AoZzPf9lfhSyrjOiimNqOZ9mOkRtv+xaJD+VVXXpjjBMngoXwtTWOoC20pyGyP+rMOHDpq6Re1N
 vj4qpJU0
X-Proofpoint-GUID: Y5DKEQ3N9iNHSZva8BVcEgC4_l59lZqG
X-Proofpoint-ORIG-GUID: Y5DKEQ3N9iNHSZva8BVcEgC4_l59lZqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Collin Walling <walling@linux.ibm.com>

DIAG 508 subcode 1 performs signature-verification on signed components.
A signed component may be a Linux kernel image, or any other signed
binary. **Verification of initrd is not supported.**

The instruction call expects two item-pairs: an address of a device
component, an address of the analogous signature file (in PKCS#7 DER format),
and their respective lengths. All of this data should be encapsulated
within a Diag508SignatureVerificationBlock, with the CertificateStoreInfo
fields ignored. The DIAG handler will read from the provided addresses
to retrieve the necessary data, parse the signature file, then
perform the signature-verification. Because there is no way to
correlate a specific certificate to a component, each certificate
in the store is tried until either verification succeeds, or all
certs have been exhausted.

The subcode value is denoted by setting the second-to-left-most bit of
a 2-byte field.

A return code of 1 indicates success, and the index and length of the
corresponding certificate will be set in the CertificateStoreInfo
portion of the SigVerifBlock. The following values indicate failure:

	0x0102: certificate not available
	0x0202: component data is invalid
	0x0302: signature is not in PKCS#7 format
	0x0402: signature-verification failed

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst |   5 ++
 include/hw/s390x/ipl/diag508.h  |  23 +++++++
 target/s390x/diag.c             | 112 +++++++++++++++++++++++++++++++-
 3 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 6b3249173f..385f8d85a8 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -64,3 +64,8 @@ that requires assistance from QEMU.
 
 Subcode 0 - query installed subcodes
     Returns a 64-bit mask indicating which subcodes are supported.
+
+Subcode 1 - perform signature verification
+    Perform signature-verification on a signed component, using certificates
+    from the certificate store and leveraging qcrypto libraries to perform
+    this operation.
diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
index 6281ad8299..c99c6705c0 100644
--- a/include/hw/s390x/ipl/diag508.h
+++ b/include/hw/s390x/ipl/diag508.h
@@ -11,5 +11,28 @@
 #define S390X_DIAG508_H
 
 #define DIAG_508_SUBC_QUERY_SUBC    0x0000
+#define DIAG_508_SUBC_SIG_VERIF     0x8000
+
+#define DIAG_508_RC_OK              0x0001
+#define DIAG_508_RC_NO_CERTS        0x0102
+#define DIAG_508_RC_INVAL_COMP_DATA 0x0202
+#define DIAG_508_RC_INVAL_PKCS7_SIG 0x0302
+#define DIAG_508_RC_FAIL_VERIF      0x0402
+
+struct Diag508CertificateStoreInfo {
+    uint8_t  idx;
+    uint8_t  reserved[7];
+    uint64_t len;
+};
+typedef struct Diag508CertificateStoreInfo Diag508CertificateStoreInfo;
+
+struct Diag508SignatureVerificationBlock {
+    Diag508CertificateStoreInfo csi;
+    uint64_t comp_len;
+    uint64_t comp_addr;
+    uint64_t sig_len;
+    uint64_t sig_addr;
+};
+typedef struct Diag508SignatureVerificationBlock Diag508SignatureVerificationBlock;
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 6519a3cedc..2fe25a2c66 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -573,9 +573,107 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
     }
 }
 
+static int diag_508_verify_sig(uint8_t *cert, size_t cert_size,
+                              uint8_t *comp, size_t comp_size,
+                              uint8_t *sig, size_t sig_size)
+{
+    g_autofree uint8_t *sig_pem = NULL;
+    size_t sig_size_pem;
+    int rc;
+
+    /*
+     * PKCS#7 signature with DER format
+     * Convert to PEM format for signature verification
+     */
+    rc = qcrypto_pkcs7_convert_sig_pem(sig, sig_size, &sig_pem, &sig_size_pem, NULL);
+    if (rc < 0) {
+        return -1;
+    }
+
+    /*
+     * Ignore errors from signature format convertion and verification,
+     * because currently in the certificate lookup process.
+     *
+     * Any error is treated as a verification failure,
+     * and the final result (verified or not) will be reported later.
+     */
+    rc = qcrypto_x509_verify_sig(cert, cert_size,
+                                 comp, comp_size,
+                                 sig_pem, sig_size_pem, NULL);
+    if (rc < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int handle_diag508_sig_verif(uint64_t addr, size_t csi_size, size_t svb_size,
+                                    S390IPLCertificateStore *qcs)
+{
+    int rc;
+    int verified;
+    uint64_t comp_len, comp_addr;
+    uint64_t sig_len, sig_addr;
+    g_autofree uint8_t *svb_comp = NULL;
+    g_autofree uint8_t *svb_sig = NULL;
+    g_autofree Diag508SignatureVerificationBlock *svb = NULL;
+
+    if (!qcs || !qcs->count) {
+        return DIAG_508_RC_NO_CERTS;
+    }
+
+    svb = g_new0(Diag508SignatureVerificationBlock, 1);
+    cpu_physical_memory_read(addr, svb, svb_size);
+
+    comp_len = be64_to_cpu(svb->comp_len);
+    comp_addr = be64_to_cpu(svb->comp_addr);
+    sig_len = be64_to_cpu(svb->sig_len);
+    sig_addr = be64_to_cpu(svb->sig_addr);
+
+    if (!comp_len || !comp_addr) {
+        return DIAG_508_RC_INVAL_COMP_DATA;
+    }
+
+    if (!sig_len || !sig_addr) {
+        return DIAG_508_RC_INVAL_PKCS7_SIG;
+    }
+
+    svb_comp = g_malloc0(comp_len);
+    cpu_physical_memory_read(comp_addr, svb_comp, comp_len);
+
+    svb_sig = g_malloc0(sig_len);
+    cpu_physical_memory_read(sig_addr, svb_sig, sig_len);
+
+    rc = DIAG_508_RC_FAIL_VERIF;
+    /*
+     * It is uncertain which certificate contains
+     * the analogous key to verify the signed data
+     */
+    for (int i = 0; i < qcs->count; i++) {
+        verified = diag_508_verify_sig(qcs->certs[i].raw,
+                                       qcs->certs[i].size,
+                                       svb_comp, comp_len,
+                                       svb_sig, sig_len);
+        if (verified == 0) {
+            svb->csi.idx = i;
+            svb->csi.len = cpu_to_be64(qcs->certs[i].der_size);
+            cpu_physical_memory_write(addr, &svb->csi, be32_to_cpu(csi_size));
+            rc = DIAG_508_RC_OK;
+            break;
+       }
+    }
+
+    return rc;
+}
+
+QEMU_BUILD_BUG_MSG(sizeof(Diag508SignatureVerificationBlock) != 48,
+                   "size of Diag508SignatureVerificationBlock is wrong");
+
 void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
+    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
     uint64_t subcode = env->regs[r3];
+    uint64_t addr = env->regs[r1];
     int rc;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -590,7 +688,19 @@ void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_508_SUBC_QUERY_SUBC:
-        rc = 0;
+        rc = DIAG_508_SUBC_SIG_VERIF;
+        break;
+    case DIAG_508_SUBC_SIG_VERIF:
+        size_t csi_size = sizeof(Diag508CertificateStoreInfo);
+        size_t svb_size = sizeof(Diag508SignatureVerificationBlock);
+
+        if (!diag_parm_addr_valid(addr, svb_size, false) ||
+            !diag_parm_addr_valid(addr, csi_size, true)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        rc = handle_diag508_sig_verif(addr, csi_size, svb_size, qcs);
         break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-- 
2.50.1


