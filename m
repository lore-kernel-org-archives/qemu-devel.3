Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F023CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 21:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1XRD-0004Gp-Sv; Wed, 24 Sep 2025 17:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1XR7-0004Fm-F9; Wed, 24 Sep 2025 17:54:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1XR1-0006BF-FX; Wed, 24 Sep 2025 17:54:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OEqk1N010177;
 Wed, 24 Sep 2025 21:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tvW7ET
 xWZ9XjW4Y0eyrTk1bpYEBTZzumAJS8RPX44r4=; b=YSXgdNXNAZI1NISNpU2C1y
 GgZlclCNP88eaMGLwAjjvWxdSZw6FFjNMB5TOrxjlUPqvTnrw7LoGYRuZPaNhvgv
 3zRoqrMOmpBukJdMe/doCSazi/USYdCD/xzO3xQqS/00Ui8+A7qD/UGb3ybx/Uum
 o1RY4SM+VUibuZvShZRIOK9S1DYykB8x+oPrXmkyDczr+/HiBxG4cieilwgyxufx
 0jlbnh0mJJa4vrUPZ4u0xjEn1bx0Y2r7kBDyRN4FjoSK2gr0bguIoK7+SOErTQeu
 FgCryRnzIMctiG70LjmwIzutZ0i/PQrltTC81nctVn+VujI3xWRmfHclCTtQK5Cg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc28em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 21:53:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OI54Rq030397;
 Wed, 24 Sep 2025 21:53:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1ah6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 21:53:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58OLri8l32244348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 21:53:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1BD158058;
 Wed, 24 Sep 2025 21:53:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92BCE58057;
 Wed, 24 Sep 2025 21:53:43 +0000 (GMT)
Received: from [9.61.248.28] (unknown [9.61.248.28])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Sep 2025 21:53:43 +0000 (GMT)
Message-ID: <b7f5433e-cf42-4e33-a37a-90fa61fe3d0d@linux.ibm.com>
Date: Wed, 24 Sep 2025 14:53:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/28] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-10-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XKowFKPVO_4DKZFoVVITb3Jdla_6Ry4J
X-Proofpoint-GUID: XKowFKPVO_4DKZFoVVITb3Jdla_6Ry4J
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d4686b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=u19dmlX19oJDyMxJhTcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX+YqhrUWyqM3M
 UCY22d4++UZwgqIgYgGSOQfL1QB6Nwa9p1BwOEFrn87wp/lIV/QqJqMLPJDSjD5s6TZGsRd6Hk+
 bwWzq9vw4odBgJ46M9Ws+YGvcLRMUd2w/3KT2rbu/KKztPHfZV5ljkjgieOF4ot4wmCuqa6o65e
 IOpwAFeNFcuw99dIBclxTPk7y8a4OWQnKiiPa+hhxJUvAoWmo9E9hAD6YZWCleV5b6alrTXe5vh
 +rEAh5AFUvjU+6yqzIt9eEb6zWjQwKRNmxvLDTZC7q4+RRcvVVLswlK5D4Q8gwmJjhrnV0Ju+eZ
 L9cDimDqvDKD9Ed+v+ghmn011M9+Ba6cbCikRCrcn14Dka78A+rNPvcNY2ybR3JPQKyJ4ej2wn0
 f+/DyXu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> DIAG 320 subcode 2 provides verification-certificates (VCs) that are in the
> certificate store. Only X509 certificates in DER format and SHA-256 hash
> type are recognized.
>
> The subcode value is denoted by setting the second-left-most bit
> of an 8-byte field.
>
> The Verification Certificate Block (VCB) contains the output data
> when the operation completes successfully. It includes a common
> header followed by zero or more Verification Certificate Entries (VCEs),
> depending on the VCB input length and the VC range (from the first VC
> index to the last VC index) in the certificate store.
>
> Each VCE contains information about a certificate retrieved from
> the S390IPLCertificateStore, such as the certificate name, key type,
> key ID length, hash length, and the raw certificate data.
> The key ID and hash are extracted from the raw certificate by the crypto API.
>
> Note: SHA2-256 VC hash type is required for retrieving the hash
> (fingerprint) of the certificate.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst |  13 ++
>   include/hw/s390x/ipl/diag320.h  |  49 +++++
>   target/s390x/diag.c             | 312 +++++++++++++++++++++++++++++++-
>   3 files changed, 373 insertions(+), 1 deletion(-)
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 4217f19c84..e28f0b40d7 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -35,3 +35,16 @@ Subcode 1 - query verification certificate storage information
>   
>       The output is returned in the verification-certificate-storage-size block (VCSSB).
>       A VCSSB length of 4 indicates that no certificates are available in the CS.
> +
> +Subcode 2 - store verification certificates
> +    Provides VCs that are in the certificate store.
> +
> +    The output is provided in a VCB, which includes a common header followed by zero
> +    or more verification-certificate entries (VCEs).
> +
> +    The first-VC index and last-VC index fields of VCB specify the range of VCs
> +    to be stored by subcode 2. Stored count and remained count fields specify the
> +    number of VCs stored and could not be stored in the VCB due to insufficient
> +    storage specified in the VCB input length field.
> +
> +    VCE contains various information of a VC from the CS.
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index 6e4779c699..2af14b9f01 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -12,19 +12,30 @@
>   
>   #define DIAG_320_SUBC_QUERY_ISM     0
>   #define DIAG_320_SUBC_QUERY_VCSI    1
> +#define DIAG_320_SUBC_STORE_VC      2
>   
>   #define DIAG_320_RC_OK              0x0001
>   #define DIAG_320_RC_NOT_SUPPORTED   0x0102
>   #define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
> +#define DIAG_320_RC_INVAL_VCB_LEN   0x0204
> +#define DIAG_320_RC_BAD_RANGE       0x0302
>   
>   #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
>   #define DIAG_320_ISM_QUERY_VCSI     0x40000000
> +#define DIAG_320_ISM_STORE_VC       0x20000000
>   
>   #define VCSSB_NO_VC     4
>   #define VCSSB_MIN_LEN   128
>   #define VCE_HEADER_LEN  128
> +#define VCE_INVALID_LEN 72
>   #define VCB_HEADER_LEN  64
>   
> +#define DIAG_320_VCE_FLAGS_VALID                0x80
> +#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
> +#define DIAG_320_VCE_KEYTYPE_ECDSA_P521         1
> +#define DIAG_320_VCE_FORMAT_X509_DER            1
> +#define DIAG_320_VCE_HASHTYPE_SHA2_256          1
> +
>   struct VCStorageSizeBlock {
>       uint32_t length;
>       uint8_t reserved0[3];
> @@ -39,4 +50,42 @@ struct VCStorageSizeBlock {
>   };
>   typedef struct VCStorageSizeBlock VCStorageSizeBlock;
>   
> +struct VCBlock {
> +    uint32_t in_len;
> +    uint32_t reserved0;
> +    uint16_t first_vc_index;
> +    uint16_t last_vc_index;
> +    uint32_t reserved1[5];
> +    uint32_t out_len;
> +    uint8_t reserved2[3];
> +    uint8_t version;
> +    uint16_t stored_ct;
> +    uint16_t remain_ct;
> +    uint32_t reserved3[5];
> +    uint8_t vce_buf[];
> +};
> +typedef struct VCBlock VCBlock;
> +
> +struct VCEntry {
> +    uint32_t len;
> +    uint8_t flags;
> +    uint8_t key_type;
> +    uint16_t cert_idx;
> +    uint32_t name[16];
> +    uint8_t format;
> +    uint8_t reserved0;
> +    uint16_t keyid_len;
> +    uint8_t reserved1;
> +    uint8_t hash_type;
> +    uint16_t hash_len;
> +    uint32_t reserved2;
> +    uint32_t cert_len;
> +    uint32_t reserved3[2];
> +    uint16_t hash_offset;
> +    uint16_t cert_offset;
> +    uint32_t reserved4[7];
> +    uint8_t cert_buf[];
> +};
> +typedef struct VCEntry VCEntry;
> +
>   #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 4e6de483b8..d5f6c54df3 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -17,6 +17,7 @@
>   #include "s390x-internal.h"
>   #include "hw/watchdog/wdt_diag288.h"
>   #include "system/cpus.h"
> +#include "hw/s390x/cert-store.h"
>   #include "hw/s390x/ipl.h"
>   #include "hw/s390x/ipl/diag320.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
> @@ -24,6 +25,7 @@
>   #include "kvm/kvm_s390x.h"
>   #include "target/s390x/kvm/pv.h"
>   #include "qemu/error-report.h"
> +#include "crypto/x509-utils.h"
>   
>   
>   int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
> @@ -225,8 +227,308 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
>       return DIAG_320_RC_OK;
>   }
>   
> +static bool is_cert_valid(S390IPLCertificate cert)
> +{
> +    int rc;
> +    Error *err = NULL;
> +
> +    rc = qcrypto_x509_check_cert_times(cert.raw, cert.size, &err);
> +    if (rc != 0) {
> +        error_report_err(err);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void handle_key_id(VCEntry *vce, S390IPLCertificate cert)
> +{
> +    int rc;
> +    g_autofree unsigned char *key_id_data = NULL;
> +    size_t key_id_len;
> +    Error *err = NULL;
> +
> +    key_id_len = CERT_KEY_ID_LEN;
> +    /* key id and key id len */
> +    rc = qcrypto_x509_get_cert_key_id(cert.raw, cert.size,
> +                                      QCRYPTO_HASH_ALGO_SHA256,
> +                                      &key_id_data, &key_id_len, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        return;
> +    }
> +    vce->keyid_len = cpu_to_be16(key_id_len);
> +
> +    memcpy(vce->cert_buf, key_id_data, key_id_len);
> +}
> +
> +static int handle_hash(VCEntry *vce, S390IPLCertificate cert, uint16_t keyid_field_len)
> +{
> +    int rc;
> +    uint16_t hash_offset;
> +    g_autofree void *hash_data = NULL;
> +    size_t hash_len;
> +    Error *err = NULL;
> +
> +    hash_len = CERT_HASH_LEN;
> +    /* hash and hash len */
> +    hash_data = g_malloc0(hash_len);
> +    rc = qcrypto_get_x509_cert_fingerprint(cert.raw, cert.size,
> +                                           QCRYPTO_HASH_ALGO_SHA256,
> +                                           hash_data, &hash_len, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +    vce->hash_len = cpu_to_be16(hash_len);
> +
> +    /* hash type */
> +    vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
> +
> +    hash_offset = VCE_HEADER_LEN + keyid_field_len;
> +    vce->hash_offset = cpu_to_be16(hash_offset);
> +
> +    memcpy((uint8_t *)vce + hash_offset, hash_data, hash_len);

Do we need any check here to make sure we are not going out of the 
bounds of vce buffer?


> +
> +    return 0;
> +}
> +
> +static int handle_cert(VCEntry *vce, S390IPLCertificate cert, uint16_t hash_field_len)
> +{
> +    int rc;
> +    uint16_t cert_offset;
> +    g_autofree uint8_t *cert_der = NULL;
> +    Error *err = NULL;
> +
> +    /* certificate in DER format */
> +    rc = qcrypto_x509_convert_cert_der(cert.raw, cert.size,
> +                                       &cert_der, &cert.der_size, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +    vce->format = DIAG_320_VCE_FORMAT_X509_DER;
> +    vce->cert_len = cpu_to_be32(cert.der_size);
> +    cert_offset = be16_to_cpu(vce->hash_offset) + hash_field_len;
> +    vce->cert_offset = cpu_to_be16(cert_offset);
> +
> +    memcpy((uint8_t *)vce + cert_offset, cert_der, cert.der_size);

Similar to above, do we need any check here to make sure we are not 
going out of the bounds of vce buffer?


> +
> +    return 0;
> +}
> +
> +static int get_key_type(S390IPLCertificate cert)
> +{
> +    int algo;
> +    int rc;
> +    Error *err = NULL;
> +
> +    /* public key algorithm */
> +    algo = qcrypto_x509_get_pk_algorithm(cert.raw, cert.size, &err);
> +    if (algo < 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    if (algo == QCRYPTO_PK_ALGO_ECDSA) {
> +        rc = qcrypto_x509_is_ecc_curve_p521(cert.raw, cert.size, &err);
> +        if (rc == -1) {
> +            error_report_err(err);
> +            return -1;
> +        }
> +
> +        return (rc == 1) ? DIAG_320_VCE_KEYTYPE_ECDSA_P521 :
> +                           DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
> +    }
> +
> +    return DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
> +}
> +
> +static int build_vce_header(VCEntry *vce, S390IPLCertificate cert, int idx)
> +{
> +    int key_type;
> +
> +    vce->len = cpu_to_be32(VCE_HEADER_LEN);
> +    vce->cert_idx = cpu_to_be16(idx + 1);
> +    strncpy((char *)vce->name, (char *)cert.vc_name, VC_NAME_LEN_BYTES);
> +
> +    key_type = get_key_type(cert);
> +    if (key_type == -1) {
> +        return -1;
> +    }
> +    vce->key_type = key_type;
> +
> +    return 0;
> +}
> +
> +static int build_vce_data(VCEntry *vce, S390IPLCertificate cert)
> +{
> +    uint16_t keyid_field_len;
> +    uint16_t hash_field_len;
> +    uint32_t cert_field_len;
> +    int rc;
> +
> +    handle_key_id(vce, cert);
> +    /* vce key id field length - can be 0 if failed to retrieve */
> +    keyid_field_len = ROUND_UP(be16_to_cpu(vce->keyid_len), 4);
> +
> +    rc = handle_hash(vce, cert, keyid_field_len);
> +    if (rc) {
> +        return -1;
> +    }
> +    hash_field_len = ROUND_UP(be16_to_cpu(vce->hash_len), 4);
> +
> +    rc = handle_cert(vce, cert, hash_field_len);
> +    if (rc || !is_cert_valid(cert)) {
> +        return -1;
> +    }
> +    /* vce certificate field length */
> +    cert_field_len = ROUND_UP(be32_to_cpu(vce->cert_len), 4);
> +
> +    /* The certificate is valid and VCE contains the certificate */
> +    vce->flags |= DIAG_320_VCE_FLAGS_VALID;
> +
> +    /* Update vce length to reflect the acutal size used by vce */
> +    vce->len += cpu_to_be32(keyid_field_len + hash_field_len + cert_field_len);

Should we validate the final vce->len calculated is <= vce_len?


> +
> +    return 0;
> +}
> +
> +static VCEntry *diag_320_build_vce(S390IPLCertificate cert, uint32_t vce_len, int idx)
> +{
> +    g_autofree VCEntry *vce = NULL;
> +    int rc;
> +
> +    /*
> +     * Construct VCE
> +     * Allocate enough memory for all certificate data (key id, hash and certificate).
> +     * Unused area following the VCE field contains zeros.
> +     */
> +    vce = g_malloc0(vce_len);
> +    rc = build_vce_header(vce, cert, idx);
> +    if (rc) {
> +        vce->len = cpu_to_be32(VCE_INVALID_LEN);
> +        goto out;
> +    }
> +    vce->len = cpu_to_be32(VCE_HEADER_LEN);

This is redundant as we already set vce->len to VCE_HEADER_LEN on 
successful call to build_vce_header. I think rather vce->len should be 
set to vce_len to make bounds checking easier in the helper functions.

> +
> +    rc = build_vce_data(vce, cert);
> +    if (rc) {
> +        vce->len = cpu_to_be32(VCE_INVALID_LEN);
> +    }
> +
> +out:
> +    return g_steal_pointer(&vce);
> +}
> +
> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
> +                                   S390IPLCertificateStore *qcs)
> +{
> +    g_autofree VCBlock *vcb = NULL;
> +    size_t vce_offset;
> +    size_t remaining_space;
> +    uint32_t vce_len;
> +    uint16_t first_vc_index;
> +    uint16_t last_vc_index;
> +    uint32_t in_len;
> +
> +    vcb = g_new0(VCBlock, 1);
> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +
> +    in_len = be32_to_cpu(vcb->in_len);
> +    first_vc_index = be16_to_cpu(vcb->first_vc_index);
> +    last_vc_index = be16_to_cpu(vcb->last_vc_index);
> +
> +    if (in_len % TARGET_PAGE_SIZE != 0) {
> +        return DIAG_320_RC_INVAL_VCB_LEN;
> +    }
> +
> +    if (first_vc_index > last_vc_index) {
> +        return DIAG_320_RC_BAD_RANGE;
> +    }
> +
> +    vcb->out_len = VCB_HEADER_LEN;
> +
> +    if (first_vc_index == 0) {
> +        /*
> +         * Zero is a valid index for the first and last VC index.
> +         * Zero index results in the VCB header and zero certificates returned.
> +         */
> +        if (last_vc_index == 0) {
> +            goto out;
> +        }
> +
> +        /* DIAG320 certificate store remains a one origin for cert entries */
> +        vcb->first_vc_index = 1;
> +        first_vc_index = 1;
> +    }
> +
> +    vce_offset = VCB_HEADER_LEN;
> +    remaining_space = in_len - VCB_HEADER_LEN;
> +
> +    for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
> +        VCEntry *vce;
> +        S390IPLCertificate cert = qcs->certs[i];
> +        /*
> +         * Each VCE is word aligned.
> +         * Each variable length field within the VCE is also word aligned.
> +         */
> +        vce_len = VCE_HEADER_LEN +
> +                  ROUND_UP(CERT_KEY_ID_LEN, 4) +
> +                  ROUND_UP(CERT_HASH_LEN, 4) +
> +                  ROUND_UP(cert.der_size, 4);
> +
> +        /*
> +         * If there is no more space to store the cert,
> +         * set the remaining verification cert count and
> +         * break early.
> +         */
> +        if (remaining_space < vce_len) {
> +            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
> +            break;
> +        }
> +
> +        vce = diag_320_build_vce(cert, vce_len, i);
> +
> +        /* Write VCE */
> +        if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1,
> +                                    vce, be32_to_cpu(vce->len))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            g_free(vce);
> +            return -1;
> +        }
> +
> +        vce_offset += be32_to_cpu(vce->len);
> +        vcb->out_len += be32_to_cpu(vce->len);
> +        remaining_space -= be32_to_cpu(vce->len);
> +        vcb->stored_ct++;
> +
> +        g_free(vce);
> +    }
> +    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
> +
> +out:
> +    vcb->out_len = cpu_to_be32(vcb->out_len);
> +    /*
> +     * Write VCB header
> +     * All VCEs have been populated with the latest information
> +     * and write VCB header last.
> +     */
> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +
> +    return DIAG_320_RC_OK;
> +}
> +
>   QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != VCSSB_MIN_LEN,
>                      "size of VCStorageSizeBlock is wrong");
> +QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != VCB_HEADER_LEN, "size of VCBlock is wrong");
> +QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != VCE_HEADER_LEN, "size of VCEntry is wrong");
>   
>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
> @@ -259,7 +561,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>            * for now.
>            */
>           uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
> -                                         DIAG_320_ISM_QUERY_VCSI);
> +                                         DIAG_320_ISM_QUERY_VCSI |
> +                                         DIAG_320_ISM_STORE_VC);
>   
>           if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
>               s390_cpu_virt_mem_handle_exc(cpu, ra);
> @@ -285,6 +588,13 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           }
>           env->regs[r1 + 1] = rc;
>           break;
> +    case DIAG_320_SUBC_STORE_VC:
> +        rc = handle_diag320_store_vc(cpu, addr, r1, ra, qcs);
> +        if (rc == -1) {
> +            return;
> +        }
> +        env->regs[r1 + 1] = rc;
> +        break;
>       default:
>           env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
>           break;

