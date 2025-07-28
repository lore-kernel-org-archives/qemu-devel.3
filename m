Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA927C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 21:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugUxi-0007H8-5z; Mon, 28 Jul 2025 17:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ugUxB-00070Y-Vt; Mon, 28 Jul 2025 17:00:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ugUx8-0000dt-JH; Mon, 28 Jul 2025 17:00:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SFnhEo008762;
 Mon, 28 Jul 2025 21:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IwLhLi
 IDgboObuhjGZc+RPuy4/FvMF/17d8AvyFbVKQ=; b=WDlsY2umWs5XB2YIKd2BRv
 9DYFc2qosutkzKFhCWppgann054xRvD3Swl/Gge8rX8fJJvBXZHK8dT3bNcrqTc/
 bwuNBL/YNBupwI6oowIhrlMqjfelT+/O6VgAlHaKUtoXMYLKGk+7L3hQWA0qv8ab
 Dz+ovXq9ujMy7Ajq1kUJKjJluxzHNntlPd/bnLakafzrZsY5tSFiv/2rjO5vPPPw
 rRIhsPdMQZCSV/1wmHS157pL2xs4D4NO4+mY9zqo4mO3sdHX9R+hjRNOefXmmniS
 e867cd3eitS3NfTZKWICqdGsrOz+lWoLz087BTiVjEn5CTN+/JiKsUjAh1NkzGmQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hh8n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Jul 2025 21:00:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SIaTGb017944;
 Mon, 28 Jul 2025 21:00:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859btfkjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Jul 2025 21:00:03 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56SL02j263832524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 21:00:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BA2E58054;
 Mon, 28 Jul 2025 21:00:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FAC25803F;
 Mon, 28 Jul 2025 21:00:00 +0000 (GMT)
Received: from [9.67.140.90] (unknown [9.67.140.90])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 28 Jul 2025 21:00:00 +0000 (GMT)
Message-ID: <ca7e2dc7-d70e-41ab-9f62-a411dce7360e@linux.ibm.com>
Date: Mon, 28 Jul 2025 16:59:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v4 09/28] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-10-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250711211105.439554-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HlaRi_YnX81gzWnzidxfzaF9sHAhvkSo
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=6887e4d4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=QACM8N3qCAy4GL2uK8gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HlaRi_YnX81gzWnzidxfzaF9sHAhvkSo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1NCBTYWx0ZWRfX2ISVHb91HW4L
 8VzHX3aAUIoMRkqbC4WAWurz5/pwmx3XkLdXEO78IfH6+THjt1W6j5FbPXHHRd5rZNaKoFJehp8
 6gTLF49QJ/6Trz+61e4DqJiXZl9wvJP26R0YMzlmGpennFRsfom4Oyp7qfdP9HIOS4EST8OV3Ry
 PdihBNhDJ6qYGaOLkizE5mxVb2B7iTwT06myiu8G8KOKeKqmkTY4q8hD0WoCkd+ykNFM922COfJ
 oHQy3gTFsqkfxJyz5OBt7nu/h8PnixBUcCM0Lq/UhZO9cJHZnPm1MoAmGLwazXYWwDW4dFnD/Xw
 jhbyxoY1T2pGGmbq8fBpUGwPwFyjr1CvryMUzo2gaBwa6wDDEUuhuT/YF+Pvy01M0xDJwNDEzLZ
 QCWdmul2UrDCBm2zl/F4i9U0cME7nTTCeSSLkbpjlto3lZfo7WAKb9wHrzCCL95/BnTAJuER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 7/11/25 17:10, Zhuoying Cai wrote:
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
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/diag320.h |  47 ++++++
>  target/s390x/diag.c            | 254 ++++++++++++++++++++++++++++++++-
>  2 files changed, 300 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index 3916a2915e..a926cf7d25 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -12,14 +12,23 @@
>  
>  #define DIAG_320_SUBC_QUERY_ISM     0
>  #define DIAG_320_SUBC_QUERY_VCSI    1
> +#define DIAG_320_SUBC_STORE_VC      2
>  
>  #define DIAG_320_RC_OK              0x0001
> +#define DIAG_320_RC_INVAL_VCB_LEN   0x0204
> +#define DIAG_320_RC_BAD_RANGE       0x0302
>  
>  #define VCSSB_MAX_LEN   128
>  #define VCE_HEADER_LEN  128
>  #define VCB_HEADER_LEN  64
>  
>  #define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
> +#define DIAG_320_ISM_STORE_VC       0x2000000000000000
> +
> +#define DIAG_320_VCE_FLAGS_VALID                0x80
> +#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
> +#define DIAG_320_VCE_FORMAT_X509_DER            1
> +#define DIAG_320_VCE_HASHTYPE_SHA2_256          1
>  
>  struct VCStorageSizeBlock {
>      uint32_t length;
> @@ -37,4 +46,42 @@ struct VCStorageSizeBlock {
>  };
>  typedef struct VCStorageSizeBlock VCStorageSizeBlock;
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
>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 1f7d0cb2f6..4641f88278 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -17,6 +17,7 @@
>  #include "s390x-internal.h"
>  #include "hw/watchdog/wdt_diag288.h"
>  #include "system/cpus.h"
> +#include "hw/s390x/cert-store.h"
>  #include "hw/s390x/ipl.h"
>  #include "hw/s390x/ipl/diag320.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
> @@ -24,6 +25,7 @@
>  #include "kvm/kvm_s390x.h"
>  #include "target/s390x/kvm/pv.h"
>  #include "qemu/error-report.h"
> +#include "crypto/x509-utils.h"
>  
>  
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
> @@ -191,8 +193,252 @@ out:
>      }
>  }
>  
> +static int diag_320_is_cert_valid(S390IPLCertificate qcert)

This could be a boolean type and return true or false
instead of 0 or -1.

> +{
> +    int version;
> +    int rc;
> +    Error *err = NULL;
> +
> +    version = qcrypto_x509_get_cert_version(qcert.raw, qcert.size, &err);
> +    if (version < 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    rc = qcrypto_x509_check_cert_times(qcert.raw, qcert.size, &err);
> +    if (rc != 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int diag_320_get_cert_info(VCEntry *vce, S390IPLCertificate qcert,
> +                                  uint8_t **cert_der, unsigned char **key_id_data,
> +                                  void **hash_data)
> +{

This function is doing a lot: extracting info from the cert, converting
raw cert data into a X509 data, extracting key_id_data, and extracting
hash_data.  I'm afraid it's a bit tricky to follow along :(

I would suggest splitting this function into three: going in order of
key, hash, cert.  It'll help to consolidate the various fields and
reduce some overhead, while producing some easy-to-follow patterns.
Something like:

diag_320_convert_key(VCEntry *vce, S390IPLCertificate qcert) {
 // set all key-related fields & error checking
 // memcpy to vce
}

diag_320_convert_hash(VCEntry *vce, S390IPLCertificate qcert) {
 // set all hash-related fields & error checking
 // memcpy to vce
}

diag_320_convert_cert(VCEntry *vce, S390IPLCertificate qcert) {
 // set all cert-related fields & error checking
 // memcpy to vce
}

This will clean up the loop in handle_diag320_store_vc and the body of
build_vce.  Offsets should be set in the respective vce field.

build_vce and the loop could handle setting whichever remaining pieces
of data that do not directly correlate to the above three -- whatever
makes sense.

> +    int algo;
> +    int rc;
> +    Error *err = NULL;
> +
> +    /* key-type */
> +    algo = qcrypto_x509_get_pk_algorithm(qcert.raw, qcert.size, &err);
> +    if (algo < 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +    if (algo == QCRYPTO_PK_ALGO_RSA) {
> +        vce->key_type = DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
> +    }
> +
> +    /* certificate in DER format */
> +    rc = qcrypto_x509_convert_cert_der(qcert.raw, qcert.size,
> +                                       cert_der, &qcert.der_size, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        goto out;
> +    }
> +
> +    /* VC format */
> +    vce->format = DIAG_320_VCE_FORMAT_X509_DER;
> +
> +    /* key id and key id len */
> +    rc = qcrypto_x509_get_cert_key_id(qcert.raw, qcert.size,
> +                                      QCRYPTO_KEYID_FLAGS_SHA256,
> +                                      key_id_data, &qcert.key_id_size, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        goto out;
> +    }
> +    vce->keyid_len = cpu_to_be16(qcert.key_id_size);
> +
> +    /* hash type */
> +    if (qcert.hash_type == QCRYPTO_SIG_ALGO_RSA_SHA256) {
> +        vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
> +    }
> +
> +    /* hash and hash len */
> +    *hash_data = g_malloc0(qcert.hash_size);
> +    rc = qcrypto_get_x509_cert_fingerprint(qcert.raw, qcert.size,
> +                                           QCRYPTO_HASH_ALGO_SHA256,
> +                                           *hash_data, &qcert.hash_size, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        goto out;
> +    }
> +    vce->hash_len = cpu_to_be16(qcert.hash_size);
> +
> +    return 0;
> +
> +out:
> +    g_clear_pointer(cert_der, g_free);
> +    g_clear_pointer(key_id_data, g_free);
> +    g_clear_pointer(hash_data, g_free);
> +
> +    return -1;
> +}
> +
> +static VCEntry *build_vce(S390IPLCertificate qcert, uint32_t vce_len, int idx,
> +                          size_t keyid_buf_size, size_t hash_buf_size)
> +{
> +    g_autofree VCEntry *vce = NULL;
> +    g_autofree uint8_t *cert_der = NULL;
> +    g_autofree unsigned char *key_id_data = NULL;
> +    g_autofree void *hash_data = NULL;
> +    int is_valid = -1;
> +    int rc;
> +
> +    /*
> +     * Construct VCE
> +     * Unused area following the VCE field contains zeros.
> +     */
> +    vce = g_malloc0(vce_len);
> +
> +    rc = diag_320_get_cert_info(vce, qcert, &cert_der, &key_id_data, &hash_data);
> +    if (rc) {
> +        return NULL;
> +    }

Hrm, not sure if returning NULL is the right call here.

> +
> +    is_valid = diag_320_is_cert_valid(qcert);

With changing this function to boolean, you can do:

	if (diag_320_is_cert_valid(qcert)) {
		vce->flags |= DIAG_320_VCE_FLAGS_VALID;
	}

Additionally, I think it makes more sense to handle any errors from
diag_320_get_cert_info by setting the VCV flag bit to invalid (aka
set to 0) and set the vce len to 72 (see below).

Judging by the fields encapsulated by those 72 bytes, you'll need to
have key-type, cert index, and name filled out as well (if possible).

> +
> +    vce->len = cpu_to_be32(vce_len);
> +    vce->cert_idx = cpu_to_be16(idx + 1);
> +    vce->cert_len = cpu_to_be32(qcert.der_size);
> +
> +    strncpy((char *)vce->name, (char *)qcert.vc_name, VC_NAME_LEN_BYTES);
> +
> +    /* VCE field offset is also word aligned */
> +    vce->hash_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size);
> +    vce->cert_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size + hash_buf_size);
> +

You can use these calculated offsets...

> +    /* Write Key ID */
> +    memcpy(vce->cert_buf, key_id_data, qcert.key_id_size);
> +    /* Write Hash key */
> +    memcpy(vce->cert_buf + keyid_buf_size, hash_data, qcert.hash_size);
> +    /* Write VCE cert data */
> +    memcpy(vce->cert_buf + keyid_buf_size + hash_buf_size, cert_der, qcert.der_size);

...here instead, with vce + vce->*_offset

> +
> +    /* The certificate is valid and VCE contains the certificate */
> +    if (is_valid == 0) {
> +        vce->flags |= DIAG_320_VCE_FLAGS_VALID;
> +    }

else, vce->len = 72

> +
> +    return g_steal_pointer(&vce);
> +}
> +
> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
> +                                   S390IPLCertificateStore *qcs)
> +{
> +    g_autofree VCBlock *vcb = NULL;
> +    size_t vce_offset;
> +    size_t remaining_space;
> +    size_t keyid_buf_size;
> +    size_t hash_buf_size;
> +    size_t cert_buf_size;

The above three fields can go into the respective helper functions that
I mentioned earlier and reduce some of the bloat here.

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

You need a check somewhere for no certs found in either the specified
range or no certs exist in the store at all:
 - VCB output len = 64
 - stored and remaining count = 0
 - response code 0x0001

> +    if (in_len % TARGET_PAGE_SIZE != 0) {
> +        return DIAG_320_RC_INVAL_VCB_LEN;
> +    }
> +
> +    if (first_vc_index > last_vc_index) {
> +        return DIAG_320_RC_BAD_RANGE;
> +    }
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
> +    vcb->out_len = VCB_HEADER_LEN;
> +    remaining_space = in_len - VCB_HEADER_LEN;
> +
> +    for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
> +        VCEntry *vce;
> +        S390IPLCertificate qcert = qcs->certs[i];
> +        /*
> +         * Each VCE is word aligned.
> +         * Each variable length field within the VCE is also word aligned.
> +         */
> +        keyid_buf_size = ROUND_UP(qcert.key_id_size, 4);
> +        hash_buf_size = ROUND_UP(qcert.hash_size, 4);
> +        cert_buf_size = ROUND_UP(qcert.der_size, 4);
> +        vce_len = VCE_HEADER_LEN + cert_buf_size + keyid_buf_size + hash_buf_size;

You could define & set the above four lines inside build_vce (or as
respective fields in the helper functions mentioned above).

The remaining space check could be done after the vce has been built.

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

You also need to check somewhere if there is enough space to store *at
least* the first cert in the range:
 - VCB output len = 64
 - stored count = 0
 - remaining count = // however are remaining
 - response code 0x0001

> +
> +        vce = build_vce(qcert, vce_len, i, keyid_buf_size, hash_buf_size);
> +        if (vce == NULL) {
> +            continue;
> +        }

See above, there shouldn't be a NULL case.

> +
> +        /* Write VCE */
> +        if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1, vce, vce_len)) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return -1;
> +        }> +
> +        vce_offset += vce_len;
> +        vcb->out_len += vce_len;
> +        remaining_space -= vce_len;
> +        vcb->stored_ct++;
> +
> +        g_free(vce);
> +    }
> +
> +    vcb->out_len = cpu_to_be32(vcb->out_len);
> +    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
> +
> +out:
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
>  QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != 128,
>                     "size of VCStorageSizeBlock is wrong");
> +QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != 64, "size of VCBlock is wrong");
> +QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != 128, "size of VCEntry is wrong");

I don't think these are necessary.

>  
>  void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  {
> @@ -219,7 +465,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  
>      switch (subcode) {
>      case DIAG_320_SUBC_QUERY_ISM:
> -        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);
> +        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
>  
>          if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
>              s390_cpu_virt_mem_handle_exc(cpu, ra);
> @@ -258,6 +504,12 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>          }
>          rc = DIAG_320_RC_OK;
>          break;
> +    case DIAG_320_SUBC_STORE_VC:
> +        rc = handle_diag320_store_vc(cpu, addr, r1, ra, qcs);
> +        if (rc == -1) {
> +            return;
> +        }
> +        break;
>      default:
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return;


-- 
Regards,
  Collin

