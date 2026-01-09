Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C54ED1A613
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBoK-0004MH-BQ; Fri, 09 Jan 2026 07:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veBoE-0003xh-Ez
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veBoA-0007Lt-BO
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767962496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nMpYXW9meLSUzxVDZTHSFAAkKl4E5nHrrDYTRCdlJDE=;
 b=c8gJg/Pt/zlvJAf0LV8UfVH+NI+rh8cxPAFML+2Rcsudt9pUmeoQK7zL+Y4opBWQFytKd4
 8NCcw+9SjgUdONkhzvwMNhccQgHFB8/9V4jfoZmobAsgpG6RGF1hwpBbvaVVvn6zVMMTlV
 EUz5RF4/3oJvy4tZFsB7Hnfa9rkElMY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Dbw2CB__N6W-F20kriGafA-1; Fri, 09 Jan 2026 07:41:35 -0500
X-MC-Unique: Dbw2CB__N6W-F20kriGafA-1
X-Mimecast-MFC-AGG-ID: Dbw2CB__N6W-F20kriGafA_1767962494
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b7a29e6f9a0so407818566b.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 04:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767962494; x=1768567294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nMpYXW9meLSUzxVDZTHSFAAkKl4E5nHrrDYTRCdlJDE=;
 b=QfiUsJhRsxB/oouUfW7xZFp8iOmIuTIalm3tGyeQyn5oV22Wu3XQz2G6lcJdoYQ7qX
 /AowS3UoueMr2FbdKUpGUQCfYR38uqFA9S2ONGAASI3F7nLlmk4eVRDRoGLAVESyPrQ+
 4+2UEv7HXlkPSEJgRPKqjLdLzcoAGGvoIf8n0v9BTzIWVs+WUTwQlB+hoNgOmS0QvNDU
 8Sc7wH4WNu2j68SY93ZZpHloEoeeDqdca1Wc1IymlqQNNMCHex/yE3qzDJGWohwgNhZM
 MXXsib6+tTSWqr9BXxu81VJCD8lcA1scjtlR5CVFLRt6O7pxuGhZiWt2TsUXgjuU5Tub
 Tamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767962494; x=1768567294;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMpYXW9meLSUzxVDZTHSFAAkKl4E5nHrrDYTRCdlJDE=;
 b=lCBiiE1KcepMP+ZtAheV/3ISqdTWkvJQ+TriJ0xzV0zOVVEvjkul3HL47vdrlCzEZe
 s5U4XmAUpEri9iySbtx17o63rzYv+NeQiiuXBekOJiENWtQ6X3c6Nd9Comu3UrKIodpo
 tRF2M3BcUfKm7q1mxYIQDNAevZsBtC2XtWZ4OREsWSa0niZ3LkvW+49kkh40EkhuOacU
 Xbj5gDKzua3XdlNavih6aVBPH9leaTjReKmAdgSzvq3NnW3GnuoQ1eUECQ56pwS1BDmk
 szPxUfVH73H4uNMUxs6Tmoy3D9BVYpFS5sY4OuUjQyDpaShcil8+4DZM2vYw/UZbAuFE
 8b7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfhEDwqTR0W+b+EBitlkcv2dZCURqW6+uFCwzHZ+oISqdMOVBwsrPsNfSd252lTh+bpA+6vp8UIBmm@nongnu.org
X-Gm-Message-State: AOJu0YwdWr1OWSpY2gaCt1HCcxo16byGs3Mzj9MB6sFXO+iCMdpZGZhJ
 A3f0KUDG+TPuifMShz9wXtJbP2czLLABCxMgIKg6oBLdLPS6KiBQPOvwRFpci7YwfQF/9YUZt1f
 HDHTLSeXTeAF2iQdjbujgCAleZ0VpuXbS8h3wLCCR9QXSHTPfGssYxrm/
X-Gm-Gg: AY/fxX7mj9czItEwCkw1TzV7+UTCy7yK1glvNKaCMiUvCssYG62paYOGxjKTwn2TYx8
 3EA5lG/EkBEygjeocdki4OH1TFQ5IgvAu3hxvLYL0yVIIUt9rsOK14w11zvQiJX9Wzt8Nqfw1Gi
 iIwBMnhTSuRrY6+7qNP87G4+3tV5IDRzBNxaWFmuCexc5RAYPSwh70+WQaUAaluNINZRXPWaz7E
 6P6JP9h1EmQmYTVaUnwNUPAbmGbGYw1YA7OI/xBtEPVpz8mo6gDbeY4QZTokqwIHQliykFTwhVN
 DOgYYBVOa47kNmsbM92bYnVIjLv8JifnLcNBME+1Up0QMH/f6W2iJhldxdFf6IzpVuno6/q0Tkb
 9KX3SeJ8=
X-Received: by 2002:a17:907:961d:b0:b83:975:f8a6 with SMTP id
 a640c23a62f3a-b844536955dmr882763966b.43.1767962493999; 
 Fri, 09 Jan 2026 04:41:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3FPX2gGAORDXIEnDGpxpn4QLfvuvRYvlGEi/K8hDd9NuyzNp670Ed7V9zIu9GgDB2ykahOQ==
X-Received: by 2002:a17:907:961d:b0:b83:975:f8a6 with SMTP id
 a640c23a62f3a-b844536955dmr882760766b.43.1767962493443; 
 Fri, 09 Jan 2026 04:41:33 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a517cf1sm1091066566b.59.2026.01.09.04.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 04:41:33 -0800 (PST)
Message-ID: <75ea4764-6344-4584-b583-2e7316ddb81c@redhat.com>
Date: Fri, 9 Jan 2026 13:41:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/29] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-10-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
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
...
 > +struct VCEntry {
 > +    uint32_t len;
 > +    uint8_t flags;
 > +    uint8_t key_type;
 > +    uint16_t cert_idx;
 > +    uint32_t name[16];

Why is this defined as an array of uint32_t when it is rather a string instead?

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
...
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 0e1897e03d..1498b29a0d 100644
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
>   static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
> @@ -231,8 +233,330 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
>       return DIAG_320_RC_OK;
>   }
>   
> +static bool is_cert_valid(S390IPLCertificate cert)

You're using call-by-value for all S390IPLCertificate parameters in this 
patch ... that's quite cumbersome since the struct has a size of ~80 bytes.

Unless there is a very good reason for doing so, I'd suggest that you switch 
the code to use (const) pointers instead of passing around that struct on 
the stack.

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
> +
> +    if (VCE_HEADER_LEN + key_id_len > be32_to_cpu(vce->len)) {
> +        error_report("Unable to write key ID: exceeds buffer bounds");
> +        return;
> +    }
> +
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
> +
> +    hash_offset = VCE_HEADER_LEN + keyid_field_len;
> +    if (hash_offset + hash_len > be32_to_cpu(vce->len)) {
> +        error_report("Unable to write hash: exceeds buffer bounds");
> +        return -1;
> +    }
> +
> +    vce->hash_len = cpu_to_be16(hash_len);
> +    vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
> +    vce->hash_offset = cpu_to_be16(hash_offset);
> +
> +    memcpy((uint8_t *)vce + hash_offset, hash_data, hash_len);
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
> +
> +    cert_offset = be16_to_cpu(vce->hash_offset) + hash_field_len;
> +    if (cert_offset + cert.der_size > be32_to_cpu(vce->len)) {
> +        error_report("Unable to write certificate: exceeds buffer bounds");
> +        return -1;
> +    }
> +
> +    vce->format = DIAG_320_VCE_FORMAT_X509_DER;
> +    vce->cert_len = cpu_to_be32(cert.der_size);
> +    vce->cert_offset = cpu_to_be16(cert_offset);
> +
> +    memcpy((uint8_t *)vce + cert_offset, cert_der, cert.der_size);
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
> +        rc = qcrypto_x509_check_ecc_curve_p521(cert.raw, cert.size, &err);
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

strncpy is often tripping up static analyzers when you use it like this.
Please consider using memcpy(), pstrcpy() or strpadcpy() instead.
(I guess memcpy is the right thing to use here since vc_name has already 
been initialized with strpadcpy ?)

> +    key_type = get_key_type(cert);
> +    if (key_type == -1) {
> +        return -1;
> +    }
> +    vce->key_type = key_type;
> +
> +    return 0;
> +}

  Thomas


