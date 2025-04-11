Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DBFC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 14:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3FWT-000310-S2; Fri, 11 Apr 2025 10:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3FWP-0002zQ-PC
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 10:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3FWN-0001vK-GT
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 10:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744382298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lJpOO8EiR9PQt61UuE+UeAB7SN2OueHqe22uusXk/pM=;
 b=SXkcA8SAPstdUs0PNH4r0q5mgyyICMoH/5eWz7sOKtuGaI8SXlRZui2QUlXAmPm2Y/QtwM
 HsM7O0mCO12m6f3wPWtdIhlP+0Dhg9y6tMrSX7CGfLARvLzQ+jDWfT2+3u1mdOclqFkk5+
 UaWNuVzFn2Zs3BCyu6jBaNUiLAv8HrQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-dXSQCNe3PZ2zrifrt9m5Cw-1; Fri, 11 Apr 2025 10:38:16 -0400
X-MC-Unique: dXSQCNe3PZ2zrifrt9m5Cw-1
X-Mimecast-MFC-AGG-ID: dXSQCNe3PZ2zrifrt9m5Cw_1744382295
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so11339035e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 07:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382295; x=1744987095;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJpOO8EiR9PQt61UuE+UeAB7SN2OueHqe22uusXk/pM=;
 b=nBNTTKQNSxy0PdGxq6/I26fArIB1f80mkqHB3mGrccYUH4dZI74uqIG+NFPjQ52DT2
 bp+pIEfHtj819XjwsZGKrcrjoyT9dJi/j6URq7uTsQFzGxUfS4pzOAKjPgNHuoDSf5sV
 KyE49ul4gxdM8f3/CW+Yl94v0sMUPYAUUokuzTlUTMnLYJ991XvjsOb/MQmFUOVlFumn
 4Hv1zYySyekKkRTcGuF9aWewT+wDVMSVMO7YA9wQc0mY7IoTLuf7FCYsyDeYwGWQo6N3
 aJuZgBLgnG6LJ0MFAJcUSA6G+qPOw3HROgxlwvFh5+4vsKF0PZcIy01JyOvvM/Tsxy6V
 2U8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq0n0AOgWZ/SM17YZh4jQuvqZE6zwTIJ93YpicSpsBXji+jrmrUQ7/Oi0zsdHLOBy9+BWLwijl7CUc@nongnu.org
X-Gm-Message-State: AOJu0YymDMkfDKQJWMl+SbJt0eoGroYetieerX7DRb44eonDR2+MFPJt
 9Wc21+rxxRW7ygBISCad0P7Wqq7EOn+PEQelunL4UNd6fr7i61/4MkmhE+qtTO+IIS7DcR1qv+V
 QH9nYd4q5Vh2iHDcm82dPObEAcP3uUVIPH1ddMqYM0FpY3Ne+pz4t
X-Gm-Gg: ASbGncvPZxypOmsnheyhPiPdO2KpPfZzqVoyf9Cs3hNUcWBBDSr2S3+LG7Ee7e9Y5F6
 J1a5K6mivZg7JRniH/xxEBT81GMaQO3PZQm6oztchMXXd7Mx15NlmUVwh5qvmmRIDfX2ThcG0gU
 el6sDJ2Cw9Kdu4j2XsPxR32+55blHMhvY+ii/Ry7pUIVtglHSW8Dm3ax3ItKWljhWA2SbdoPO6i
 i5wvvA6Ig7MZMWlyzpJbpS0KKJA+ArsYxuow8FyWgFtv3VX3LwmC/OwUVT0wy3g1MZ5m+wxy1Hy
 K9AFz/37sY9E6a/fjsbPEUdQpcga9HHVmFbtB35+8/Y=
X-Received: by 2002:a05:600c:348d:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43f3a9afaf7mr34305575e9.31.1744382295383; 
 Fri, 11 Apr 2025 07:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHWNM2qhddrRSoqTHs2MefisIcWnBrCX5xx+kiG6SJuJU3xcHAnaE7jPuTTtc849sUdjSlg==
X-Received: by 2002:a05:600c:348d:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43f3a9afaf7mr34305185e9.31.1744382294990; 
 Fri, 11 Apr 2025 07:38:14 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f235a5d31sm85633365e9.35.2025.04.11.07.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:38:14 -0700 (PDT)
Message-ID: <6bc09c58-831b-4333-b8d1-17fe162eb359@redhat.com>
Date: Fri, 11 Apr 2025 16:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/24] s390x/diag: Implement DIAG 508 subcode 2 for
 signature verification
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-10-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/04/2025 17.55, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
> 
> DIAG 508 subcode 2 performs signature-verfication on signed components.
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
> 	0x0402: component data is invalid
> 	0x0502: certificate is not in x509 format
> 	0x0602: signature is not in PKCS#7 format
> 	0x0702: signature-verification failed
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/diag508.h |  25 +++++++
>   target/s390x/diag.c            | 131 ++++++++++++++++++++++++++++++++-
>   2 files changed, 155 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
> index 83c4439cb2..f8f4b6398e 100644
> --- a/include/hw/s390x/ipl/diag508.h
> +++ b/include/hw/s390x/ipl/diag508.h
> @@ -13,5 +13,30 @@
>   #define S390X_DIAG508_H
>   
>   #define DIAG_508_SUBC_QUERY_SUBC    0x0000
> +#define DIAG_508_SUBC_SIG_VERIF     0x4000
> +
> +#define DIAG_508_RC_OK              0x0001
> +#define DIAG_508_RC_NO_CERTS        0x0102
> +#define DIAG_508_RC_CERT_NOT_FOUND  0x0202
> +#define DIAG_508_RC_NO_MEM_FOR_CERT 0x0302
> +#define DIAG_508_RC_INVAL_COMP_DATA 0x0402
> +#define DIAG_508_RC_INVAL_X509_CERT 0x0502
> +#define DIAG_508_RC_INVAL_PKCS7_SIG 0x0602
> +#define DIAG_508_RC_FAIL_VERIF      0x0702
> +
> +struct Diag508CertificateStoreInfo {
> +    uint8_t  idx;
> +    uint64_t len;
> +} QEMU_PACKED;
> +typedef struct Diag508CertificateStoreInfo Diag508CertificateStoreInfo;
> +
> +struct Diag508SignatureVerificationBlock {
> +    Diag508CertificateStoreInfo csi;
> +    uint64_t comp_len;
> +    uint64_t comp_addr;
> +    uint64_t sig_len;
> +    uint64_t sig_addr;
> +} QEMU_PACKED;
> +typedef struct Diag508SignatureVerificationBlock Diag508SignatureVerificationBlock;
>   
>   #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index ad7f4b5025..cecb8bf130 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -25,6 +25,11 @@
>   #include "target/s390x/kvm/pv.h"
>   #include "qemu/error-report.h"
>   
> +#ifdef CONFIG_GNUTLS
> +#include <gnutls/x509.h>
> +#include <gnutls/gnutls.h>
> +#include <gnutls/pkcs7.h>
> +#endif /* CONFIG_GNUTLS */
>   
>   int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>   {
> @@ -489,9 +494,67 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>       env->regs[r1 + 1] = rc;
>   }
>   
> +#ifdef CONFIG_GNUTLS
> +#define datum_init(datum, data, size) \
> +    datum = (gnutls_datum_t){data, size}
> +
> +static int diag_508_init_comp(gnutls_datum_t *comp,
> +                              Diag508SignatureVerificationBlock *svb)
> +{
> +    uint8_t *svb_comp = NULL;
> +
> +    if (!svb->comp_len || !svb->comp_addr) {
> +        error_report("No component data.");
> +        return -1;
> +    }
> +
> +    /*
> +     * corrupted size vs. prev_size in fastbins, occurs during 2nd iteration,
> +     * allocating 1mil bytes.

I don't understand that comment - could you elaborate?

> +     */
> +    svb_comp = g_malloc0(svb->comp_len);
> +    cpu_physical_memory_read(svb->comp_addr, svb_comp, svb->comp_len);
> +
> +    /*
> +     * Component data is not written back to the caller,
> +     * so no need to do a deep copy. Comp is freed when
> +     * svb is freed.
> +     */
> +    datum_init(*comp, svb_comp, svb->comp_len);
> +    return 0;
> +}
> +
> +static int diag_508_init_signature(gnutls_pkcs7_t *sig,
> +                                   Diag508SignatureVerificationBlock *svb)
> +{
> +    gnutls_datum_t datum_sig;
> +    uint8_t *svb_sig = NULL;
> +
> +    if (!svb->sig_len || !svb->sig_addr) {
> +        error_report("No signature data");
> +        return -1;
> +    }
> +
> +    svb_sig = g_malloc0(svb->sig_len);
> +    cpu_physical_memory_read(svb->sig_addr, svb_sig, svb->sig_len);
> +
> +    if (gnutls_pkcs7_init(sig) < 0) {
> +        error_report("Failed to initalize pkcs7 data.");
> +        return -1;
> +    }
> +
> +    datum_init(datum_sig, svb_sig, svb->sig_len);
> +    return gnutls_pkcs7_import(*sig, &datum_sig, GNUTLS_X509_FMT_DER);
> +
> +}
> +#endif /* CONFIG_GNUTLS */
> +
>   void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
> +    size_t csi_size = sizeof(Diag508CertificateStoreInfo);
>       uint64_t subcode = env->regs[r3];
> +    uint64_t addr = env->regs[r1];
>       int rc;
>   
>       if (env->psw.mask & PSW_MASK_PSTATE) {
> @@ -506,7 +569,73 @@ void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   
>       switch (subcode) {
>       case DIAG_508_SUBC_QUERY_SUBC:
> -        rc = 0;
> +        rc = DIAG_508_SUBC_SIG_VERIF;
> +        break;
> +    case DIAG_508_SUBC_SIG_VERIF:
> +        size_t svb_size = sizeof(Diag508SignatureVerificationBlock);
> +        Diag508SignatureVerificationBlock *svb;
> +
> +        if (!qcs || !qcs->count) {
> +            error_report("No certificates in cert store.");

Not sure whether we should print an error by default here ... it's likely 
better to use a trace_...() function here, I think.

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

Do you need to byteswap the read values with be_to_cpuXX() here?

> +#ifdef CONFIG_GNUTLS
> +        gnutls_pkcs7_t sig = NULL;
> +        gnutls_datum_t comp;
> +        int i;
> +
> +        if (diag_508_init_comp(&comp, svb) < 0) {
> +            rc = DIAG_508_RC_INVAL_COMP_DATA;
> +            g_free(svb);
> +            break;
> +        }
> +
> +        if (diag_508_init_signature(&sig, svb) < 0) {
> +            rc = DIAG_508_RC_INVAL_PKCS7_SIG;
> +            gnutls_pkcs7_deinit(sig);
> +            g_free(svb);
> +            break;
> +        }
> +
> +        rc = DIAG_508_RC_FAIL_VERIF;
> +        /*
> +         * It is uncertain which certificate contains
> +         * the analogous key to verify the signed data
> +         */
> +        for (i = 0; i < qcs->count; i++) {
> +            gnutls_x509_crt_t g_cert = NULL;
> +            if (g_init_cert((uint8_t *)qcs->certs[i].raw, qcs->certs[i].size, &g_cert)) {
> +                continue;
> +            }
> +
> +            if (gnutls_pkcs7_verify_direct(sig, g_cert, 0, &comp, 0) == 0) {
> +                svb->csi.idx = i;
> +                svb->csi.len = qcs->certs[i].size;
> +                cpu_physical_memory_write(addr, &svb->csi,
> +                                          be32_to_cpu(csi_size));
> +                rc = DIAG_508_RC_OK;
> +                break;
> +            }
> +
> +            gnutls_x509_crt_deinit(g_cert);
> +        }
> +
> +        gnutls_pkcs7_deinit(sig);
> +#else
> +        rc = DIAG_508_RC_FAIL_VERIF;
> +#endif /* CONFIG_GNUTLS */
> +        g_free(svb);
>           break;
>       default:
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);

  Thomas


