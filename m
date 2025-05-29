Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F36BC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 17:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKhPP-0006vu-9J; Thu, 29 May 2025 13:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uKhPM-0006vD-Fm; Thu, 29 May 2025 13:51:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uKhPJ-0006X4-JV; Thu, 29 May 2025 13:51:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDRUdH017943;
 Thu, 29 May 2025 17:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NiX6YF
 TD8yKaagd8d+kNfAYvs+PxqqAckJZPrrNLzdI=; b=LjnF45xeuFG3ye+g3gnbJs
 ycVDvUz802NMe5sMa7k0sa4BgOPhqcKJlDgXTj10x0Wwo8SKA+hbe15Wp6+EvdxR
 pNoNiCthgsWn2zCbdu57+lit7jHSdWGrTSYWxO29/NYYQrObY83P4VtjKi/ROiH4
 GWsqT10Q8nSLNy3MwmhaIKENJwGEsNljc3z/c2LP1xuJFwcnP8DF8nwD0M8l11N4
 fNExJXC76okeay/pvORnYhqxMsrGuWdOc4HLgvbcp4ZErE/lkZ/Q7sZHhsmyehbf
 E9S1z5V2Bkm5Ed39GU4u1f4M4rYT0fyGTcQNryVXjSTGfZSIgTtX0mTN79441X8Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gq30d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 17:51:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54THYtdE029227;
 Thu, 29 May 2025 17:51:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46ureuntkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 17:51:04 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54THp3NO64422306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 17:51:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4793C58052;
 Thu, 29 May 2025 17:51:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE07A58050;
 Thu, 29 May 2025 17:51:01 +0000 (GMT)
Received: from [9.61.85.78] (unknown [9.61.85.78])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 29 May 2025 17:51:01 +0000 (GMT)
Message-ID: <1fc30da2-cfa7-4acd-b173-ac88ea538259@linux.ibm.com>
Date: Thu, 29 May 2025 13:51:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] hw/s390x/ipl: Create certificate store
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, fiuczy@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-3-zycai@linux.ibm.com> <aCRccMVidyvEZZzp@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <aCRccMVidyvEZZzp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cFmDwHLtVs7z16iacCbJeUARnis1EIaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE3MCBTYWx0ZWRfX8jGOLuvrURJm
 wFPQtAMlWfSW2YoL/US+ijbm+mYTH4LNwQnEdzyMZoqsecAcFsnI5eLLJGYzuwqsx8NqGzYNcsZ
 V0vYr2fYR7vtHQRohTBdwGYxweOHPBhvpQVJeBJIfey40z8bnmWfWXDr1bF6StXymhg3n+0Y0GJ
 FDcyV0t2Ggbz3D+VKsWdHF+nGRQoShg9BAC11YqI3QH6NiWZVHg7NJpMkmMuehXOUolOpUYmGMf
 V98OoXa9+HaT8PNS3k2fFJgFFadCf0SM/vxTaI4TfBuhbSLkjXNcC9fszfFcdogkZ1y28JXFICh
 QE+XSnZK+TrDR1MgdZ6puyL4lWeWpc08TpaWyAhQFkcd0MFHY3d+rozGqJU5howQz54xoP/fz54
 LbAQ+nHef4BUDii24TRPPBJVcOy89AatJrmIFIr0CbK/JY5nh/pVay3Ci7R8QLKjUVcMj+Gi
X-Proofpoint-ORIG-GUID: cFmDwHLtVs7z16iacCbJeUARnis1EIaR
X-Authority-Analysis: v=2.4 cv=UflRSLSN c=1 sm=1 tr=0 ts=68389e89 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=Pn4_QnAgKrWirF8qslEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290170
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 5/14/25 5:03 AM, Daniel P. Berrangé wrote:
> On Thu, May 08, 2025 at 06:50:18PM -0400, Zhuoying Cai wrote:
>> Create a certificate store for boot certificates used for secure IPL.
>>
>> Load certificates from the -boot-certificate option into the cert store.
>>
>> Currently, only x509 certificates in DER format and uses SHA-256 hashing
>> algorithm are supported, as these are the types required for secure boot
>> on s390.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  crypto/meson.build          |   5 +-
>>  crypto/x509-utils.c         | 163 ++++++++++++++++++++++++
>>  hw/s390x/cert-store.c       | 242 ++++++++++++++++++++++++++++++++++++
>>  hw/s390x/cert-store.h       |  39 ++++++
>>  hw/s390x/ipl.c              |   9 ++
>>  hw/s390x/ipl.h              |   3 +
>>  hw/s390x/meson.build        |   1 +
>>  include/crypto/x509-utils.h |   6 +
>>  include/hw/s390x/ipl/qipl.h |   3 +
>>  qapi/crypto.json            |  80 ++++++++++++
> 
> 
> Please split the crypto subsystem changes from the s390x subsystem
> changes, as separate commits. Also be sure to CC myself (as crypto
> maintainer) on patches that change the crypto subsystem.
> 
> 
>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>> index 8bad00a51b..0b8cfc9022 100644
>> --- a/crypto/x509-utils.c
>> +++ b/crypto/x509-utils.c
>> @@ -11,6 +11,12 @@
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "crypto/x509-utils.h"
>> +
>> +/*
>> + * Surround with GNUTLS marco to ensure the interfaces are
>> + * still available when GNUTLS is not enabled.
> 
> This comment is redundant - we don't need to explain
> what an #ifdef does.
> 
>> + */
>> +#ifdef CONFIG_GNUTLS
>>  #include <gnutls/gnutls.h>
>>  #include <gnutls/crypto.h>
>>  #include <gnutls/x509.h>
>> @@ -25,6 +31,94 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>>      [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>>  };
>>  
>> +static const int qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS__MAX] = {
>> +    [QCRYPTO_KEYID_FLAGS_SHA1] = GNUTLS_KEYID_USE_SHA1,
>> +    [QCRYPTO_KEYID_FLAGS_SHA256] = GNUTLS_KEYID_USE_SHA256,
>> +    [QCRYPTO_KEYID_FLAGS_SHA512] = GNUTLS_KEYID_USE_SHA512,
>> +    [QCRYPTO_KEYID_FLAGS_BEST_KNOWN] = GNUTLS_KEYI_DUSE_BEST_KNOWN,
>> +};
>> +
>> +static const int qcrypto_to_gnutls_cert_fmt_map[QCRYPTO_CERT_FMT__MAX] = {
>> +    [QCRYPTO_CERT_FMT_DER] = GNUTLS_X509_FMT_DER,
>> +    [QCRYPTO_CERT_FMT_PEM] = GNUTLS_X509_FMT_PEM,
>> +};
>> +
>> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
>> +                                 QCryptoCertFmt fmt, Error **errp)
>> +{
>> +    int rc;
>> +    int ret = 0;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +
>> +    if (fmt >= G_N_ELEMENTS(qcrypto_to_gnutls_cert_fmt_map)) {
>> +        error_setg(errp, "Unknown certificate format");
>> +        return ret;
>> +    }
>> +
>> +    if (gnutls_x509_crt_init(&crt) < 0) {
>> +        error_setg(errp, "Failed to initialize certificate");
>> +        goto cleanup;
>> +    }
>> +
>> +    rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
>> +    if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
>> +        ret = 0;
>> +        goto cleanup;
>> +    }
>> +
>> +    ret = 1;
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return ret;
>> +}
>> +
>> +static int qcrypto_get_x509_cert_fmt(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    int fmt;
>> +
>> +    if (qcrypto_check_x509_cert_fmt(cert, size, QCRYPTO_CERT_FMT_DER, errp)) {
>> +        fmt = GNUTLS_X509_FMT_DER;
>> +    } else if (qcrypto_check_x509_cert_fmt(cert, size, QCRYPTO_CERT_FMT_PEM, errp)) {
>> +        fmt = GNUTLS_X509_FMT_PEM;
>> +    } else {
>> +        return -1;
>> +    }
>> +
>> +    return fmt;
>> +}
>> +
>> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp)
>> +{
>> +    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
>> +        error_setg(errp, "Unknown hash algorithm");
>> +        return 0;
>> +    }
>> +
>> +    return gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
>> +}
>> +
>> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp)
>> +{
>> +    QCryptoHashAlgo alg;
>> +
>> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
>> +        error_setg(errp, "Unknown key id flag");
>> +        return 0;
>> +    }
>> +
>> +    alg = QCRYPTO_HASH_ALGO_SHA1;
>> +    if ((flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]) ||
>> +        (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_BEST_KNOWN])) {
>> +        alg = QCRYPTO_HASH_ALGO_SHA512;
>> +    } else if (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA256]) {
>> +        alg = QCRYPTO_HASH_ALGO_SHA256;
>> +    }
>> +
>> +    return qcrypto_get_x509_hash_len(alg, errp);
>> +}
> 
> This method looks fairly pointless to me. Why doesn't the caller just
> directly call qcrypto_get_x509_hash_len without this indirection of
> QCRYPTO_KEYID_FLAGS, especially given that you've just hardcoded to
> use of QCRYPTO_KEYID_FLAGS_SHA256 in the caller ?
> 

This function will be used in a later patch related to DIAG320 subcode
support, where we need to obtain the certificate key ID. That process
requires calculating the key ID length based on the QCryptoKeyidFlags value.

It's a mistake that I hardcoded QCRYPTO_KEYID_FLAGS_SHA256 in the later
patch instead of using the QCryptoKeyidFlags parameter. I’ll correct
that in the next version.

>> @@ -74,3 +168,72 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>      gnutls_x509_crt_deinit(crt);
>>      return ret;
>>  }
>> +
>> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    int rc = -1;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +    gnutls_x509_crt_fmt_t fmt;
>> +
>> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
>> +    if (fmt == -1) {
>> +        error_setg(errp, "Certificate is neither in DER or PEM format");
>> +        return rc;
>> +    }
>> +
>> +    if (gnutls_x509_crt_init(&crt) < 0) {
>> +        error_setg(errp, "Failed to initialize certificate");
>> +        return rc;
>> +    }
>> +
>> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
>> +        error_setg(errp, "Failed to import certificate");
>> +        goto cleanup;
>> +    }
> 
> This code pattern looks dubious to me.  The qcrypto_get_x509_cert_fmt
> method will call qcrypto_check_x509_cert_fmt which will call
> gnutls_x509_crt_import(), the result of which is then thrown
> away, and this method calls gnutls_x509_crt_import again. Get
> rid of qcrypto_check_x509_cert_fmt from this. 
> 
>> +
>> +    rc = gnutls_x509_crt_get_signature_algorithm(crt);
> 
> This needs to be remapped to the QCryptoSigAlgo enum values.
> 
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return rc;
>> +}
>> +
>> +#else /* ! CONFIG_GNUTLS */
>> +
>> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
>> +                                 QCryptoCertFmt fmt, Error **errp)
>> +{
>> +    error_setg(errp, "To get certificate format requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp)
>> +{
>> +    error_setg(errp, "To get hash length requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp)
>> +{
>> +    error_setg(errp, "To get key ID length requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>> +                                      QCryptoHashAlgo hash,
>> +                                      uint8_t *result,
>> +                                      size_t *resultlen,
>> +                                      Error **errp)
>> +{
>> +    error_setg(errp, "To get fingerprint requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    error_setg(errp, "To get signature algorithm requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +#endif /* ! CONFIG_GNUTLS */
>> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
>> index 1e99661a71..8fb263b9e1 100644
>> --- a/include/crypto/x509-utils.h
>> +++ b/include/crypto/x509-utils.h
>> @@ -19,4 +19,10 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>                                        size_t *resultlen,
>>                                        Error **errp);
>>  
>> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
>> +                                 QCryptoCertFmt fmt, Error **errp);
>> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp);
>> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp);
>> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
> 
> Please add API docs for each method.
> 
> 
>> diff --git a/qapi/crypto.json b/qapi/crypto.json
>> index c9d967d782..2bbf29affe 100644
>> --- a/qapi/crypto.json
>> +++ b/qapi/crypto.json
>> @@ -612,3 +612,83 @@
>>    'base': { 'alg': 'QCryptoAkCipherAlgo' },
>>    'discriminator': 'alg',
>>    'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
>> +
>> +##
>> +# @QCryptoKeyidFlags:
>> +#
>> +# The supported flags for the key ID
>> +#
>> +# @sha1: SHA-1
>> +#
>> +# @sha256: SHA-256
>> +#
>> +# @sha512: SHA-512
>> +#
>> +# @best-known: BEST-KNOWN
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'enum': 'QCryptoKeyidFlags',
>> +  'data': ['sha1', 'sha256', 'sha512', 'best-known']}
>> +
>> +##
>> +# @QCryptoCertFmt:
>> +#
>> +# The supported certificate encoding formats
>> +#
>> +# @der: DER
>> +#
>> +# @pem: PEM
>> +#
>> +# Since: 9.2
> 
> We're in the 10.1 dev cycle
> 
> 
> With regards,
> Daniel


