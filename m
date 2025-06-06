Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B3EC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUml-0000O5-TN; Fri, 06 Jun 2025 06:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUmj-0000Nn-T0
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUmi-0007Uo-40
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749207530;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=leIumJ0lPZfhJVnM8XRHXCsf39U3AdQmf5CBhnzX9Wo=;
 b=CGD1pvT6JTE0sbo4h6RetFDBQS/lwjNRpHlXuUoYVK+w6c45evQZZpFEEyUyjAFQ9aMpGH
 5Z5vZt0LkWXUiR4p3xZdU6ZXflV/PE5LSf7ljivhoRkRThV4LACimIj0jkT589/cbJ75F+
 xmxs0wEWIj0v14LHBzBo42z3jsrwUGc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-Cc1vKz5fMwqemZJRAx6BAA-1; Fri,
 06 Jun 2025 06:58:47 -0400
X-MC-Unique: Cc1vKz5fMwqemZJRAx6BAA-1
X-Mimecast-MFC-AGG-ID: Cc1vKz5fMwqemZJRAx6BAA_1749207526
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAEA319560A2; Fri,  6 Jun 2025 10:58:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1D0A19560B2; Fri,  6 Jun 2025 10:58:40 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:58:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 12/28] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
Message-ID: <aELJ3WYvwZ-hG4E9@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-13-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604215657.528142-13-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 04, 2025 at 05:56:40PM -0400, Zhuoying Cai wrote:
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


> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 1ef1eb5299..ca7dd0f2e6 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -526,9 +526,81 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>      env->regs[r1 + 1] = rc;
>  }
>  
> +static int handle_diag508_sig_verif(uint64_t addr, size_t csi_size, size_t svb_size,
> +                                    S390IPLCertificateStore *qcs)
> +{
> +    int rc;
> +    int verified;
> +    Error *err;
> +    uint64_t comp_len, comp_addr;
> +    uint64_t sig_len, sig_addr;
> +    g_autofree uint8_t *svb_comp;
> +    g_autofree uint8_t *svb_sig;
> +    g_autofree Diag508SignatureVerificationBlock *svb;

All g_auto* variables must be initialized to NULL at time
of declaration. As written this results in freeing of
unitialized data if a 'return' is hit before these are
initialized.

> +
> +    if (!qcs || !qcs->count) {
> +        return DIAG_508_RC_NO_CERTS;
> +    }
> +
> +    svb = g_new0(Diag508SignatureVerificationBlock, 1);
> +    cpu_physical_memory_read(addr, svb, svb_size);
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
> +
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
> +     */
> +    for (int i = 0; i < qcs->count; i++) {
> +        err = NULL;
> +        verified = qcrypto_verify_x509_cert((uint8_t *)qcs->certs[i].raw,
> +                                            qcs->certs[i].size,
> +                                            svb_comp, comp_len,
> +                                            svb_sig, sig_len, &err);
> +
> +        /* return early if GNUTLS is not enabled */
> +        if (verified == -ENOTSUP) {
> +            break;
> +        }

All errors must be honoured not merely missing gnutls, and this code
leaks 'err' too

> +
> +        if (verified == 0) {
> +            svb->csi.idx = i;
> +            svb->csi.len = cpu_to_be64(qcs->certs[i].size);
> +            cpu_physical_memory_write(addr, &svb->csi, be32_to_cpu(csi_size));
> +            rc = DIAG_508_RC_OK;
> +            break;
> +       }
> +    }
> +
> +    return rc;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


