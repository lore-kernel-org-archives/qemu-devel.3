Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454FBCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 10:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64ua-0000gv-8H; Tue, 07 Oct 2025 06:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v64uY-0000fR-FO
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v64uT-0007Qo-Mm
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759832828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=unG16Wwj0DUTJ6nBh75K+8bTy2WcTOegVHbpMOSBVfc=;
 b=cJujR7IXHUwKw9uZJ8nZHJ+EqV2T1EB1rLfqjktfkMez6atU6Y6QdUEpSzFiZQGJu1s9i9
 +JlspbejIWsRfD8nnZxRY2WCwf4WJGSxCVP3PwQm2NC8koM9qQjCcw3fEdYis8W75vzLUw
 2YEQYn9LO1Wrlv/R/O0/DbYDAFsdy18=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-mrTSE5WgOg2OSBohZtyyXw-1; Tue, 07 Oct 2025 06:27:04 -0400
X-MC-Unique: mrTSE5WgOg2OSBohZtyyXw-1
X-Mimecast-MFC-AGG-ID: mrTSE5WgOg2OSBohZtyyXw_1759832824
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e375dab7dso26831565e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 03:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759832824; x=1760437624;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=unG16Wwj0DUTJ6nBh75K+8bTy2WcTOegVHbpMOSBVfc=;
 b=Fmtb5rYe4uMeHeMyeyOpAWfuPwp0qiw7kCI/zZ4JXwdpLTJ9Jg4B6fnNKQwRf9WxGO
 ApvKqm/hmVavxJZ5d5u6ihUGPHpLYXqkd6BptcNQrX7ZMG1BMs7ZafPKR0hDCisd3IwB
 2fzZIZ2Aw/QygS0rrtiN2x/Atc2cxnP8WfH/7gkw0yYio4ecynVi+YJuGvTH1GPrli85
 28nQKfSp5EwZSBEMx6l/E34zPPdvbzFP1s+RP3hd7EnwcxjBctuNDIarV+CLTCzAq1B8
 9RSWrm6+FgFIXHCauxv5rtEvrm9raK+M68yu66sr63WQv9jIsxwaXIEXUwB0rdsmZie2
 xyFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv2xUxtAL+MMzlmPDvaRMqIR0bnTmqBW1ASzLTIhGauTmvAEHrKYGpJGU09iTwMXKaKeomLKwW37/j@nongnu.org
X-Gm-Message-State: AOJu0YwSL8beHgtvl5shnF/oQZ71hb7L7KQ6mK1ZgytXhl/hX6SrL8ao
 u1JI8u6uvpC49wjCI7Pxj1/83+Y9qUcPsRZPZrr2cJfJh9CAsaIzzZpceECaUMrPW2z5NQlSJla
 XfLhPNDx8R+2BO05SZX4VBziRdqeNjrE2aA7x06MI559xD0LN+alt9yC0
X-Gm-Gg: ASbGncvswNMipsew49eyWOI7IfOIQWUytRGLPyrx9BoHqCOweEK6qaMdeqUfGHc18Bt
 GZFLKcxLRFMegCsvF90RD+evd/fRF87xbtx6s8LYTQ5MviZbIDY8OoB3E1ARUS4PdKCRXB6vCkE
 RQZQUDSgmtNf6DfJr2efAZCFfWy8CEpKFnAS3a/hJao938ja+rouBZLQr9ryJkCG2/E2/BoIv10
 Eyn/gAwqSn9zAGmDbo3Vi6mq15+Mmjh5ebtMxWkZtAOAi+vUOFVpjoaTceu/Dm8YWM+zvLDAgUN
 wwd00JqMzVitROJvHxIu6KiVHxqgNNbEX3he40DbUbJYbep8LYgvC9pws13lfQGCEaM2GIU=
X-Received: by 2002:a05:600c:1989:b0:46c:7097:6363 with SMTP id
 5b1f17b1804b1-46e7110eee0mr88129875e9.13.1759832823633; 
 Tue, 07 Oct 2025 03:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnEzSeZ+7jyqSiDezpO/SbGU4daeXhK4zTjxxVqI12rTRyEW73zQZ5qfl8Td6ajLLkuYQQIQ==
X-Received: by 2002:a05:600c:1989:b0:46c:7097:6363 with SMTP id
 5b1f17b1804b1-46e7110eee0mr88129555e9.13.1759832822966; 
 Tue, 07 Oct 2025 03:27:02 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b7e37sm295522765e9.1.2025.10.07.03.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 03:27:02 -0700 (PDT)
Message-ID: <9acf7d52-0dc9-4c07-9d74-758682a5c62e@redhat.com>
Date: Tue, 7 Oct 2025 12:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/28] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-13-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-13-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
> 
> DIAG 508 subcode 1 performs signature-verification on signed components.
> A signed component may be a Linux kernel image, or any other signed
> binary. **Verification of initrd is not supported.**
> 
> The instruction call expects two item-pairs: an address of a device
> component, an address of the analogous signature file (in PKCS#7 DER format),
> and their respective lengths. All of this data should be encapsulated
> within a Diag508SigVerifBlock.
> 
> The DIAG handler will read from the provided addresses
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
> corresponding certificate will be set in the Diag508SigVerifBlock.
> The following values indicate failure:
> 
> 	0x0102: certificate not available
> 	0x0202: component data is invalid
> 	0x0302: signature is not in PKCS#7 format
> 	0x0402: signature-verification failed
> 	0x0502: length of Diag508SigVerifBlock is invalid
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst |   5 ++
>   include/hw/s390x/ipl/diag508.h  |  23 +++++++
>   target/s390x/diag.c             | 115 +++++++++++++++++++++++++++++++-
>   3 files changed, 142 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 0919425e9a..eec368d17b 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -66,3 +66,8 @@ that requires assistance from QEMU.
>   
>   Subcode 0 - query installed subcodes
>       Returns a 64-bit mask indicating which subcodes are supported.
> +
> +Subcode 1 - perform signature verification
> +    Perform signature-verification on a signed component, using certificates
> +    from the certificate store and leveraging qcrypto libraries to perform
> +    this operation.
> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
> index 6281ad8299..ad401cc867 100644
> --- a/include/hw/s390x/ipl/diag508.h
> +++ b/include/hw/s390x/ipl/diag508.h
> @@ -11,5 +11,28 @@
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
> +#define DIAG_508_RC_INVAL_LEN       0x0502
> +
> +struct Diag508SigVerifBlock {
> +    uint32_t length;
> +    uint8_t reserved0[3];
> +    uint8_t version;
> +    uint32_t reserved[2];
> +    uint8_t cert_store_index;
> +    uint8_t reserved1[7];
> +    uint64_t cert_len;
> +    uint64_t comp_len;
> +    uint64_t comp_addr;
> +    uint64_t sig_len;
> +    uint64_t sig_addr;
> +};
> +typedef struct Diag508SigVerifBlock Diag508SigVerifBlock;
>   
>   #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index ee64257dbc..379fb8f2b4 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -602,9 +602,112 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>       }
>   }
>   
> +static int diag_508_verify_sig(uint8_t *cert, size_t cert_size,
> +                              uint8_t *comp, size_t comp_size,
> +                              uint8_t *sig, size_t sig_size)
> +{
> +    g_autofree uint8_t *sig_pem = NULL;
> +    size_t sig_size_pem;
> +    int rc;
> +
> +    /*
> +     * PKCS#7 signature with DER format
> +     * Convert to PEM format for signature verification
> +     */
> +    rc = qcrypto_pkcs7_convert_sig_pem(sig, sig_size, &sig_pem, &sig_size_pem, NULL);
> +    if (rc < 0) {
> +        return -1;
> +    }
> +
> +    rc = qcrypto_x509_verify_sig(cert, cert_size,
> +                                 comp, comp_size,
> +                                 sig_pem, sig_size_pem, NULL);
> +    if (rc < 0) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int handle_diag508_sig_verif(uint64_t addr, size_t svb_size,
> +                                    S390IPLCertificateStore *qcs)
> +{
> +    int rc;
> +    int verified;
> +    uint32_t svb_len;
> +    uint64_t comp_len, comp_addr;
> +    uint64_t sig_len, sig_addr;
> +    g_autofree uint8_t *svb_comp = NULL;
> +    g_autofree uint8_t *svb_sig = NULL;
> +    g_autofree Diag508SigVerifBlock *svb = NULL;
> +
> +    if (!qcs || !qcs->count) {
> +        return DIAG_508_RC_NO_CERTS;
> +    }
> +
> +    svb = g_new0(Diag508SigVerifBlock, 1);
> +    cpu_physical_memory_read(addr, svb, svb_size);
> +
> +    svb_len = be32_to_cpu(svb->length);
> +    if (svb_len != svb_size) {
> +        return DIAG_508_RC_INVAL_LEN;
> +    }
> +
> +    comp_len = be64_to_cpu(svb->comp_len);
> +    comp_addr = be64_to_cpu(svb->comp_addr);
> +    sig_len = be64_to_cpu(svb->sig_len);
> +    sig_addr = be64_to_cpu(svb->sig_addr);
> +
> +    if (!comp_len || !comp_addr) {
> +        return DIAG_508_RC_INVAL_COMP_DATA;
> +    }
> +
> +    if (!sig_len || !sig_addr) {
> +        return DIAG_508_RC_INVAL_PKCS7_SIG;
> +    }

I think there should also be something like an upper limit for comp_len and 
sign_len here. Otherwise a malicious guest could force QEMU into allocating 
giga- or terabytes of memory here to cause out-of-memory situations in the host.

> +    svb_comp = g_malloc0(comp_len);
> +    cpu_physical_memory_read(comp_addr, svb_comp, comp_len);
> +
> +    svb_sig = g_malloc0(sig_len);
> +    cpu_physical_memory_read(sig_addr, svb_sig, sig_len);
> +
> +    rc = DIAG_508_RC_FAIL_VERIF;
> +    /*
> +     * It is uncertain which certificate contains
> +     * the analogous key to verify the signed data
> +     *
> +     * Ignore errors from signature format convertion and verification,
> +     * because currently in the certificate lookup process.

The second half of above sentence looks incomplete?

> +     *
> +     * Any error is treated as a verification failure,
> +     * and the final result (verified or not) will be reported later.
> +     */
> +    for (int i = 0; i < qcs->count; i++) {
> +        verified = diag_508_verify_sig(qcs->certs[i].raw,
> +                                       qcs->certs[i].size,
> +                                       svb_comp, comp_len,
> +                                       svb_sig, sig_len);
> +        if (verified == 0) {
> +            svb->cert_store_index = i;
> +            svb->cert_len = cpu_to_be64(qcs->certs[i].der_size);
> +            cpu_physical_memory_write(addr, svb, be32_to_cpu(svb_size));
> +            rc = DIAG_508_RC_OK;
> +            break;
> +       }
> +    }
> +
> +    return rc;
> +}

  Thomas


