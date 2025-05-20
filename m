Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B9AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 08:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHI9d-0003vu-IC; Tue, 20 May 2025 04:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHI9Z-0003vA-SK
 for qemu-devel@nongnu.org; Tue, 20 May 2025 04:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHI9X-0000mx-Cw
 for qemu-devel@nongnu.org; Tue, 20 May 2025 04:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747729004;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HkKXjq7ZCfcHzC2af10hDiBcGDtr5eTqC8Ia8a8nxlY=;
 b=a5b9Xz0Oe7GVaODgeB2tmCnkBqFxhwSuyv4mNuZFgspC3j0togFPujptUtAnc27/rxsWNT
 7itaJbRXHQXPHpG4AE8BtzEijBnPYtThJSfdYzyKGroo/JIyKTAYCYV35ObQl3uTGQhh+x
 PoCmtDhMi92AkaOKnqcrZoqYCLaYqX4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-wTNk3uljPsSkaWIUj1pp5w-1; Tue,
 20 May 2025 04:16:40 -0400
X-MC-Unique: wTNk3uljPsSkaWIUj1pp5w-1
X-Mimecast-MFC-AGG-ID: wTNk3uljPsSkaWIUj1pp5w_1747728997
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65FA11954B18; Tue, 20 May 2025 08:16:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B41118004A7; Tue, 20 May 2025 08:16:32 +0000 (UTC)
Date: Tue, 20 May 2025 09:16:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, fiuczy@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/25] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
Message-ID: <aCw6XJj9oOY_np_D@redhat.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-10-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508225042.313672-10-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 08, 2025 at 06:50:25PM -0400, Zhuoying Cai wrote:
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
>  crypto/x509-utils.c            | 54 +++++++++++++++++++++++
>  include/crypto/x509-utils.h    |  4 ++
>  include/hw/s390x/ipl/diag508.h | 22 +++++++++
>  target/s390x/diag.c            | 81 +++++++++++++++++++++++++++++++++-
>  4 files changed, 160 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 51bd75d4eb..56d9a42f39 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -20,6 +20,7 @@
>  #include <gnutls/gnutls.h>
>  #include <gnutls/crypto.h>
>  #include <gnutls/x509.h>
> +#include <gnutls/pkcs7.h>
>  
>  static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>      [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
> @@ -373,6 +374,51 @@ cleanup:
>      return ret;
>  }
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
>  #else /* ! CONFIG_GNUTLS */
>  
>  int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> @@ -438,4 +484,12 @@ int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
>      return -ENOTSUP;
>  }
>  
> +int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
> +                             uint8_t *comp, size_t comp_size,
> +                             uint8_t *sig, size_t sig_size, Error **errp)
> +{
> +    error_setg(errp, "signature-verification support requires GNUTLS");
> +    return -ENOTSUP;
> +}
> +
>  #endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index cf43de0b2c..ec90667376 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -35,4 +35,8 @@ int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
>                                   size_t *resultlen,
>                                   Error **errp);
>  
> +int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
> +                             uint8_t *comp, size_t comp_size,
> +                             uint8_t *sig, size_t sig_size, Error **errp);
> +

Needs API docs to say what all these different params mean

>  #endif

Please always aim to seperate out code from different subsystems into
separate patches, if technically possible.

> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
> index 6281ad8299..80a5bb906b 100644
> --- a/include/hw/s390x/ipl/diag508.h
> +++ b/include/hw/s390x/ipl/diag508.h

> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 954c95fe50..2171e3275d 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -494,7 +494,10 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  
>  void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  {
> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
> +    size_t csi_size = sizeof(Diag508CertificateStoreInfo);
>      uint64_t subcode = env->regs[r3];
> +    uint64_t addr = env->regs[r1];
>      int rc;
>  
>      if (env->psw.mask & PSW_MASK_PSTATE) {
> @@ -509,7 +512,83 @@ void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  
>      switch (subcode) {
>      case DIAG_508_SUBC_QUERY_SUBC:
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

Leaks 'svb' here

> +                break;
> +           }
> +        }
> +
> +        g_free(svb);

This and all the other paths leak 'svb_comp' and
'svb_sig'.

Declare all three allocated vars with 'g_autofree' and then you don't
need to remember to manually g_free them.

>          break;
>      default:
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


