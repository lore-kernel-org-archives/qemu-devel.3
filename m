Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C0EC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGCF-0005bN-1n; Tue, 20 May 2025 02:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHGCC-0005aq-2I
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHGC9-0002sN-O7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747721479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SMTdTu8HqEtgOQgyAm3zuMPTNXQduixdIcEcQr0meSc=;
 b=HFW/QIGEnTmhaeHX4Cz3Ntq2pf5TSEi/tYCzk2vO8ji2j68GymcNDUI4NfaGPbSQ6x2lC/
 fHvVzU2wBtBbwlVeppE+tXE2N6LU2JSkNWClu1OKkdO/zi/ezDcYDfJpwp8ddOxK1ITaMQ
 a4chBe2rGkHGt7jqgm3JPbAKRLg6kYM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-z40ivNNhOLq-2H4O5akGEw-1; Tue, 20 May 2025 02:11:17 -0400
X-MC-Unique: z40ivNNhOLq-2H4O5akGEw-1
X-Mimecast-MFC-AGG-ID: z40ivNNhOLq-2H4O5akGEw_1747721476
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so30572175e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 23:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747721476; x=1748326276;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SMTdTu8HqEtgOQgyAm3zuMPTNXQduixdIcEcQr0meSc=;
 b=QKdBtaQQw4U5O9MBuGzjGrG1745WHuYr8OLBEOKloYDRoIE16SxRdrzrcVgkyHTp9l
 5qKFJboZAqRk2gM33Q7lgJkJDaaym0VeNw+WcnK2tVLW+5Uy5TmCugC9q5xGhUD8vAW9
 RfPbckZYLUggo6dpazHUgNWonLmEr2VQ7ZIxdk9hA5qubadNbcMLoY6qVGii9GOXHJWH
 dBF2ZDSU7gcsIGkp4WI/5RJElwvq8SpmUbq7+5BbUAqpNmcl2j3bGyyG7Yd3gJPeRILw
 wyRhSV3wJH7JMcrAn6Z0OOR8uChIodT2HN1LfyyRc1G2/LkHLwpJQ2+ojJrWyK6YoUeR
 yJlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyjSpWsOZ5KlUgZIDQq/AefEqZzAfFSBTeaAHS2HHvC8b4NXhKqZyxixTcZ8I3L05xcA1fYI0NCitP@nongnu.org
X-Gm-Message-State: AOJu0YzY05r6g3+0QjHQoFFl9SqKi/R0A4uSr6oxT6Nk9/JDtDKq3Oan
 DmdnH1N9S/lvX+nr9/yvavvk275jEpcUvidRY0oisnO/12WL/wAkCVf8mwE02xDGkdB+0zad6Ed
 7dFAD7QBJkMifAzqj3Qw72a3Neev9V9fhA7j5Ye33/RFXseAtNH6cri9s
X-Gm-Gg: ASbGnculY82ZMVPx7mWy3tsXKa4jCvHaiyjj/YHe2QFh2pBNWldJDZsf0YOYFRyJQto
 RQJtbJMmsYKSrqNqN8SmnErHqYlGvzyfZMjUCN+XSOAmh2O37ZV3+UH354P9zTFvPpEbyLXkVPm
 vvG3D5ZKO71XfRJapecOAYPYdCWQZqrf1+6br1uYw/7x2VCUw8ocBe5tepVTIciiSop3278Lrkz
 08qGhLV7gRkY/oekCMgyf51LnQuVMXOKMu7+d+z7zpTwNTGPCRtW2Wuxry/QhnFzgnxkrFXHPDL
 WifB2L19PufdCgO5tYzSKx5tZM4JjKd9pKY4/ilwwf4=
X-Received: by 2002:a05:600c:4e87:b0:440:59eb:bfc with SMTP id
 5b1f17b1804b1-442ff032a90mr107863405e9.23.1747721476031; 
 Mon, 19 May 2025 23:11:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ya8Die+2wlSWsXV4PlSMo3GwD9PNPykqkvWwq3FLvUMQbcaRzVj/ItOnHZTNOhqWZxNVYg==
X-Received: by 2002:a05:600c:4e87:b0:440:59eb:bfc with SMTP id
 5b1f17b1804b1-442ff032a90mr107863095e9.23.1747721475544; 
 Mon, 19 May 2025 23:11:15 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm17024125e9.22.2025.05.19.23.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 23:11:15 -0700 (PDT)
Message-ID: <cabbd683-f937-4885-82b3-01d3d0ff65a4@redhat.com>
Date: Tue, 20 May 2025 08:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/25] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-10-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
> 
> DIAG 508 subcode 1 performs signature-verification on signed components.
> A signed component may be a Linux kernel image, or any other signed
> binary. **Verification of initrd is not supported.**
> 
> The instruction call expects two item-pairs: an address of a device
> component, an address of the analogous signature file (in PKCS#7 format),
> and their respective lengths. All of this data should be encapsulated
> within a Diag508SignatureVerificationBlock, with the CertificateStoreInfo
> fields ignored. The DIAG handler will read from the provided addresses
> to retrieve the necessary data, parse the signature file, then
> perform the signature-verification. Because there is no way to
> correlate a specific certificate to a component, each certificate
> in the store is tried until either verification succeeds, or all
> certs have been exhausted.
> 
> The subcode value is denoted by setting the second-to-left-most bit of
> a 2-byte field.
> 
> A return code of 1 indicates success, and the index and length of the
> corresponding certificate will be set in the CertificateStoreInfo
> portion of the SigVerifBlock. The following values indicate failure:
> 
> 	0x0202: component data is invalid
> 	0x0302: signature is not in PKCS#7 format
> 	0x0402: signature-verification failed
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   crypto/x509-utils.c            | 54 +++++++++++++++++++++++
>   include/crypto/x509-utils.h    |  4 ++
>   include/hw/s390x/ipl/diag508.h | 22 +++++++++
>   target/s390x/diag.c            | 81 +++++++++++++++++++++++++++++++++-
>   4 files changed, 160 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 51bd75d4eb..56d9a42f39 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -20,6 +20,7 @@
>   #include <gnutls/gnutls.h>
>   #include <gnutls/crypto.h>
>   #include <gnutls/x509.h>
> +#include <gnutls/pkcs7.h>
>   
>   static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>       [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
> @@ -373,6 +374,51 @@ cleanup:
>       return ret;
>   }
>   
> +int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
> +                            uint8_t *comp, size_t comp_size,
> +                            uint8_t *sig, size_t sig_size, Error **errp)
> +{
> +    int rc = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_pkcs7_t signature;
> +    gnutls_datum_t cert_datum = {.data = cert, .size = cert_size};
> +    gnutls_datum_t data_datum = {.data = comp, .size = comp_size};
> +    gnutls_datum_t sig_datum = {.data = sig, .size = sig_size};
> +    gnutls_x509_crt_fmt_t fmt;
> +
> +    fmt = qcrypto_get_x509_cert_fmt(cert, cert_size, errp);
> +    if (fmt == -1) {
> +        error_setg(errp, "Certificate is neither in DER or PEM format");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_import(crt, &cert_datum, fmt) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    if (gnutls_pkcs7_init(&signature) < 0) {
> +        error_setg(errp, "Failed to initalize pkcs7 data.");
> +        return rc;
> +    }
> +
> +    if (gnutls_pkcs7_import(signature, &sig_datum , fmt) != 0) {
> +        error_setg(errp, "Failed to import signature");
> +    }
> +
> +    rc = gnutls_pkcs7_verify_direct(signature, crt, 0, &data_datum, 0);
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_pkcs7_deinit(signature);
> +    return rc;
> +}
> +
>   #else /* ! CONFIG_GNUTLS */
>   
>   int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> @@ -438,4 +484,12 @@ int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
>       return -ENOTSUP;
>   }
>   
> +int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
> +                             uint8_t *comp, size_t comp_size,
> +                             uint8_t *sig, size_t sig_size, Error **errp)
> +{
> +    error_setg(errp, "signature-verification support requires GNUTLS");
> +    return -ENOTSUP;
> +}
> +
>   #endif /* ! CONFIG_GNUTLS */

You might want to introduce this function in a separate patch (so that the 
crypto maintainer can review it separately)


> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index cf43de0b2c..ec90667376 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -35,4 +35,8 @@ int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
>                                    size_t *resultlen,
>                                    Error **errp);
>   
> +int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
> +                             uint8_t *comp, size_t comp_size,
> +                             uint8_t *sig, size_t sig_size, Error **errp);
> +
>   #endif
> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
> index 6281ad8299..80a5bb906b 100644
> --- a/include/hw/s390x/ipl/diag508.h
> +++ b/include/hw/s390x/ipl/diag508.h
> @@ -11,5 +11,27 @@
>   #define S390X_DIAG508_H
>   
>   #define DIAG_508_SUBC_QUERY_SUBC    0x0000
> +#define DIAG_508_SUBC_SIG_VERIF     0x8000
> +
> +#define DIAG_508_RC_OK              0x0001
> +#define DIAG_508_RC_NO_CERTS        0x0102
> +#define DIAG_508_RC_INVAL_COMP_DATA 0x0202
> +#define DIAG_508_RC_INVAL_PKCS7_SIG 0x0302
> +#define DIAG_508_RC_FAIL_VERIF      0x0402
> +
> +struct Diag508CertificateStoreInfo {
> +    uint8_t  idx;
> +    uint64_t len;
> +} QEMU_PACKED;
> +typedef struct Diag508CertificateStoreInfo Diag508CertificateStoreInfo;

Is that struct defined by some pre-existing specification already, or is 
that invented by you here? In the latter case, I'd suggest to add a "uint8_t 
reserved[7]" field after the idx line to pad manually so that len is 
naturally aligned. Then you could get rid of the QEMU_PACKED here.

> +
> +struct Diag508SignatureVerificationBlock {
> +    Diag508CertificateStoreInfo csi;
> +    uint64_t comp_len;
> +    uint64_t comp_addr;
> +    uint64_t sig_len;
> +    uint64_t sig_addr;
> +} QEMU_PACKED;
> +typedef struct Diag508SignatureVerificationBlock Diag508SignatureVerificationBlock;

Depending on whether you can get rid of the QEMU_PACKED for the previous 
struct, you could maybe get of the QEMU_PACKED here, too.

>   #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 954c95fe50..2171e3275d 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -494,7 +494,10 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   
>   void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
> +    size_t csi_size = sizeof(Diag508CertificateStoreInfo);
>       uint64_t subcode = env->regs[r3];
> +    uint64_t addr = env->regs[r1];
>       int rc;
>   
>       if (env->psw.mask & PSW_MASK_PSTATE) {
> @@ -509,7 +512,83 @@ void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   
>       switch (subcode) {
>       case DIAG_508_SUBC_QUERY_SUBC:
> -        rc = 0;
> +        rc = DIAG_508_SUBC_SIG_VERIF;
> +        break;
> +    case DIAG_508_SUBC_SIG_VERIF:
> +        size_t svb_size = sizeof(Diag508SignatureVerificationBlock);
> +        Diag508SignatureVerificationBlock *svb;
> +        uint64_t comp_len, comp_addr;
> +        uint64_t sig_len, sig_addr;
> +        uint8_t *svb_comp;
> +        uint8_t *svb_sig;
> +        int verified;
> +        Error *err = NULL;
> +        int i;
> +
> +        if (!qcs || !qcs->count) {
> +            rc = DIAG_508_RC_NO_CERTS;
> +            break;
> +        }
> +
> +        if (!diag_parm_addr_valid(addr, svb_size, false) ||
> +            !diag_parm_addr_valid(addr, csi_size, true)) {
> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +            return;
> +        }
> +
> +        svb = g_new0(Diag508SignatureVerificationBlock, 1);
> +        cpu_physical_memory_read(addr, svb, svb_size);
> +
> +        comp_len = be64_to_cpu(svb->comp_len);
> +        comp_addr = be64_to_cpu(svb->comp_addr);
> +        sig_len = be64_to_cpu(svb->sig_len);
> +        sig_addr = be64_to_cpu(svb->sig_addr);
> +
> +        if (!comp_len || !comp_addr) {
> +            rc = DIAG_508_RC_INVAL_COMP_DATA;
> +            g_free(svb);
> +            break;
> +        }
> +
> +        if (!sig_len || !sig_addr) {
> +            rc = DIAG_508_RC_INVAL_PKCS7_SIG;
> +            g_free(svb);
> +            break;
> +        }
> +
> +        svb_comp = g_malloc0(comp_len);
> +        cpu_physical_memory_read(comp_addr, svb_comp, comp_len);
> +
> +        svb_sig = g_malloc0(sig_len);
> +        cpu_physical_memory_read(sig_addr, svb_sig, sig_len);
> +
> +        rc = DIAG_508_RC_FAIL_VERIF;
> +        /*
> +         * It is uncertain which certificate contains
> +         * the analogous key to verify the signed data
> +         */
> +        for (i = 0; i < qcs->count; i++) {
> +            verified = qcrypto_verify_x509_cert((uint8_t *)qcs->certs[i].raw,
> +                                                qcs->certs[i].size,
> +                                                svb_comp, comp_len,
> +                                                svb_sig, sig_len, &err);
> +
> +            /* return early if GNUTLS is not enabled */
> +            if (verified == -ENOTSUP) {
> +                g_free(svb);
> +                break;
> +            }
> +
> +            if (verified == 0) {
> +                svb->csi.idx = i;
> +                svb->csi.len = cpu_to_be64(qcs->certs[i].size);
> +                cpu_physical_memory_write(addr, &svb->csi, be32_to_cpu(csi_size));
> +                rc = DIAG_508_RC_OK;
> +                break;
> +           }
> +        }
> +
> +        g_free(svb);

What about freeing svb_comp and svb_sig?

Also, this block introduces a bunch of local variables and is quite huge 
already. Thus this should not be done in a case block, please move the code 
into a separate function instead.

  Thanks,
   Thomas

>           break;
>       default:
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);


