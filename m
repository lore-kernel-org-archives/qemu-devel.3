Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AEAC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 17:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGL8-0005WA-8w; Tue, 22 Jul 2025 12:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFmQ-0005gn-14
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFmO-0004Ur-0C
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753201424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9TRIhTq5TmRYyvsveC0VB4lUyOqMVSFU6UbHeczAOCA=;
 b=e7c5wSou++cueXGDzcSUEEeLqJT31jZYt2oy28qgMM224iTJmaYex1n0PaTUgquwjxKBYM
 /j8DJ+mx2Ot1D/P0tNSvuOhX11XjguVmm+Df1thssGyG8pJUda3YU3seU6O8nG4hQlyDCT
 IExjvdjRuSMtULPVyU9iRIEdJr/JMDI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-SP3Xn19GOs-27isFyP5ESw-1; Tue,
 22 Jul 2025 12:23:40 -0400
X-MC-Unique: SP3Xn19GOs-27isFyP5ESw-1
X-Mimecast-MFC-AGG-ID: SP3Xn19GOs-27isFyP5ESw_1753201419
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 969831800165; Tue, 22 Jul 2025 16:23:38 +0000 (UTC)
Received: from redhat.com (dhcp-16-135.lcy.redhat.com [10.42.16.135])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D494318016FE; Tue, 22 Jul 2025 16:23:34 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:23:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
Subject: Re: [PATCH v4 09/28] s390x/diag: Implement DIAG 320 subcode 2
Message-ID: <aH-7A6Yuclqe1WDL@redhat.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-10-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711211105.439554-10-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 11, 2025 at 05:10:45PM -0400, Zhuoying Cai wrote:
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

>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
> @@ -191,8 +193,252 @@ out:
>      }
>  }
>  
> +static int diag_320_is_cert_valid(S390IPLCertificate qcert)
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

IMHO this isn't doing anything worthwhile given qemu accepts
any version at all here.

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

Shouldn't this have an "else" clause to either fill in vce->key_type,
or raise an error

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

Again, an "else" clause to either fill in vce->hash_type,
or raise an error ?

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



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


