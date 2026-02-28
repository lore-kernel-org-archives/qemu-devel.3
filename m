Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB097FEE4EF
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 14:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwKzK-0006xf-JE; Sat, 28 Feb 2026 09:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vwKzH-0006v4-AD
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 09:08:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vwKzF-0004ca-8m
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 09:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772287684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xcifEO2MRS48U/y3b9VGTMmdVys17GC/uGG/Im6GuHE=;
 b=V8NTUDvMXF2RlA5BUMtelDGyNGvRLnDuVYk/rIKigG8KovXhDMq94Duvk5Ghra0OqrD4dB
 7SgybLlQm1vjduocW5t2DtI6/oiAepiYAHBUJ5ToX933l22WXE0qJQW0qUuUlw0lQBOTHC
 hTVhHokL7w8/B65SWPV5rtn7AHLqGmI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-ci_fw3a9OCmTsjmTgeMLvw-1; Sat,
 28 Feb 2026 09:07:57 -0500
X-MC-Unique: ci_fw3a9OCmTsjmTgeMLvw-1
X-Mimecast-MFC-AGG-ID: ci_fw3a9OCmTsjmTgeMLvw_1772287675
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB76718004A9; Sat, 28 Feb 2026 14:07:54 +0000 (UTC)
Received: from [10.44.32.20] (unknown [10.44.32.20])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C401319560B5; Sat, 28 Feb 2026 14:07:47 +0000 (UTC)
Message-ID: <965a0f20-1faa-45a9-b594-ae96c4609d15@redhat.com>
Date: Sat, 28 Feb 2026 15:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/30] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-10-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260212204352.1044699-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/02/2026 21.43, Zhuoying Cai wrote:
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
>   #define VCSSB_NO_VC     4
>   #define VCSSB_MIN_LEN   128
>   #define VCE_HEADER_LEN  128
> +#define VCE_INVALID_LEN 72

Why is 72 an invalid len? Because it's less than VCE_HEADER_LEN ? ... a 
comment might be helpful here.

...
> +static VCEntry *diag_320_build_vce(const S390IPLCertificate *cert, int idx)
> +{
> +    g_autofree VCEntry *vce = NULL;
> +    uint32_t vce_max_size;
> +    int rc;
> +
> +    /*
> +     * Each field of the VCE is word-aligned.
> +     * Allocate enough space for the largest possible size for this VCE.
> +     * As the certificate fields (key-id, hash, data) are parsed, the
> +     * VCE's length field will be updated accordingly.
> +     */
> +    vce_max_size = VCE_HEADER_LEN +
> +                   ROUND_UP(CERT_KEY_ID_LEN, 4) +
> +                   ROUND_UP(CERT_HASH_LEN, 4) +
> +                   ROUND_UP(cert->der_size, 4);
> +
> +    vce = g_malloc0(vce_max_size);
> +    rc = build_vce_header(vce, cert, idx);
> +    if (rc) {
> +        vce->len = cpu_to_be32(VCE_INVALID_LEN);
> +        goto out;
> +    }
> +
> +    vce->len = cpu_to_be32(vce_max_size);
> +    rc = build_vce_data(vce, cert);
> +    if (rc) {
> +        vce->len = cpu_to_be32(VCE_INVALID_LEN);

So errors are apparently encoded via VCE_INVALID_LEN here...

> +    }
> +
> +out:
> +    return g_steal_pointer(&vce);
> +}
> +
> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
> +                                   S390IPLCertificateStore *cs)
> +{
> +    g_autofree VCBlock *vcb = NULL;
> +    size_t entry_offset;
> +    size_t remaining_space;
> +    uint32_t vce_len;
> +    uint16_t first_vc_index;
> +    uint16_t last_vc_index;
> +    int cs_start_index;
> +    int cs_end_index;
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
> +    /*
> +     * DIAG 320 subcode 2 expects to query a certificate store that
> +     * maintains an index origin of 1. However, the S390IPLCertificateStore
> +     * maintains an index origin of 0. Thus, the indices must be adjusted
> +     * for correct access into the cert store. A couple of special cases
> +     * must also be accounted for.
> +     */
> +
> +    /* Both indices are 0; return header with no certs */
> +    if (first_vc_index == 0 && last_vc_index == 0) {
> +        goto out;
> +    }
> +
> +    /* Normalize indices */
> +    cs_start_index = (first_vc_index == 0) ? 0 : first_vc_index - 1;
> +    cs_end_index = last_vc_index - 1;
> +
> +    /* Requested range is outside the cert store; return header with no certs */
> +    if (cs_start_index >= cs->count || cs_end_index >= cs->count) {
> +        goto out;
> +    }
> +
> +    entry_offset = VCB_HEADER_LEN;
> +    remaining_space = in_len - VCB_HEADER_LEN;
> +
> +    for (int i = cs_start_index; i <= cs_end_index; i++) {
> +        VCEntry *vce;
> +        const S390IPLCertificate *cert = &cs->certs[i];
> +
> +        vce = diag_320_build_vce(cert, i);
> +        vce_len = be32_to_cpu(vce->len);

... but the caller here does not seem to check for VCE_INVALID_LEN ... is it 
OK to simply ignore this? Again, a comment might be helpful.

  Thomas


> +        /*
> +         * If there is no more space to store the cert,
> +         * set the remaining verification cert count and
> +         * break early.
> +         */
> +        if (remaining_space < vce_len) {
> +            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
> +            g_free(vce);
> +            break;
> +        }
> +
> +        /* Write VCE */
> +        if (s390_cpu_virt_mem_write(cpu, addr + entry_offset, r1, vce, vce_len)) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            g_free(vce);
> +            return -1;
> +        }
> +
> +        entry_offset += vce_len;
> +        vcb->out_len += vce_len;
> +        remaining_space -= vce_len;
> +        vcb->stored_ct++;
> +
> +        g_free(vce);
> +    }
> +    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
> +
> +out:
> +    vcb->out_len = cpu_to_be32(vcb->out_len);
> +
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
> @@ -267,7 +585,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>            * for now.
>            */
>           uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
> -                                         DIAG_320_ISM_QUERY_VCSI);
> +                                         DIAG_320_ISM_QUERY_VCSI |
> +                                         DIAG_320_ISM_STORE_VC);
>   
>           if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
>               s390_cpu_virt_mem_handle_exc(cpu, ra);
> @@ -293,6 +612,13 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           }
>           env->regs[r1 + 1] = rc;
>           break;
> +    case DIAG_320_SUBC_STORE_VC:
> +        rc = handle_diag320_store_vc(cpu, addr, r1, ra, cs);
> +        if (rc == -1) {
> +            return;
> +        }
> +        env->regs[r1 + 1] = rc;
> +        break;
>       default:
>           env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
>           break;


