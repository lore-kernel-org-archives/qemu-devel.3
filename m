Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12B1C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 05:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRlnV-00067H-Sf; Wed, 18 Jun 2025 01:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRlnT-00066v-LW
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 01:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRlnR-0001sx-Cg
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 01:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750226235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OE7GF1RfPrXpIDwIVk1HwySUidW9UejewyM/hBvRrg=;
 b=hxDrRV996tbA86p8qiVCZ8939PdHSCHbYil2IMVYL43X3E0BfVZDr6Hk4YfFfFOiBGtdcb
 /p1yREyinxjsMyYoE9oWOD84REqHitEOz9lnZ+XI484Lgs9Chcks9Djvt7CnjhTHOUztc1
 v6HQQQyNh1aK+WXRhNRLbyG65ICV8tE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-SLZYQN-DMzW-aSTfalS9VA-1; Wed,
 18 Jun 2025 01:57:11 -0400
X-MC-Unique: SLZYQN-DMzW-aSTfalS9VA-1
X-Mimecast-MFC-AGG-ID: SLZYQN-DMzW-aSTfalS9VA_1750226230
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9D271956096; Wed, 18 Jun 2025 05:57:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ED2930001B1; Wed, 18 Jun 2025 05:57:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7590921E6A27; Wed, 18 Jun 2025 07:57:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 david@redhat.com,  pbonzini@redhat.com,  walling@linux.ibm.com,
 jjherne@linux.ibm.com,  jrossi@linux.ibm.com,  pasic@linux.ibm.com,
 borntraeger@linux.ibm.com,  farman@linux.ibm.com,  iii@linux.ibm.com,
 eblake@redhat.com,  qemu-s390x@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 02/28] crypto/x509-utils: Add helper functions for
 certificate store
In-Reply-To: <41e788ad-77e2-46d2-a384-2c8f524391c2@linux.ibm.com> (Zhuoying
 Cai's message of "Tue, 17 Jun 2025 10:57:23 -0400")
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-3-zycai@linux.ibm.com>
 <87sejyskgj.fsf@pond.sub.org>
 <41e788ad-77e2-46d2-a384-2c8f524391c2@linux.ibm.com>
Date: Wed, 18 Jun 2025 07:57:06 +0200
Message-ID: <87wm99r3rh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

Zhuoying Cai <zycai@linux.ibm.com> writes:

> On 6/17/25 6:58 AM, Markus Armbruster wrote:
>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>> 
>>> Add helper functions for x509 certificate which will be used in the next
>>> patch for the certificate store.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

[...]

>> Ignorant question: why are these QAPI enums?
>> 
>> If they need to be QAPI enums, then I'll have some requests on the doc
>> comments.
>> 
>
> Hi, thanks for the feedback.
>
> The helper functions in x509-utils.c either take QAPI enum values as
> parameters or return them. These enums are used later within QEMU.

Let's look at the first one I found:

    int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
                                    QCryptoCertFmt fmt, Error **errp)
    {
        int rc;
        int ret = -1;
        gnutls_x509_crt_t crt;
        gnutls_datum_t datum = {.data = cert, .size = size};

        if (fmt >= G_N_ELEMENTS(qcrypto_to_gnutls_cert_fmt_map)) {
            error_setg(errp, "Unknown certificate format");
            return ret;
        }

        if (gnutls_x509_crt_init(&crt) < 0) {
            error_setg(errp, "Failed to initialize certificate");
            return ret;
        }

        rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
        if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
            goto cleanup;
        }

        ret = 0;

    cleanup:
        gnutls_x509_crt_deinit(crt);
        return ret;
    }

All it does with its @fmt argument is map it to the matching
GNUTLS_X509_FMT_*.

There's just one caller, init_cert_x509_der() in hw/s390x/cert-store.c:

    is_der = qcrypto_check_x509_cert_fmt((uint8_t *)raw, size,
                                         QCRYPTO_CERT_FMT_DER, &err);

QCRYPTO_CERT_FMT_DER gets mapped to GNUTLS_X509_FMT_DER.  Why not pass
that directly?  We don't need enum QCryptoCertFmt then.

If we need enum QCryptoCertFmt for some reason I can't see, why does it
have to be a QAPI type?  Why not a plain C enum?

Similar questions for the other QAPI enums added in this series.


