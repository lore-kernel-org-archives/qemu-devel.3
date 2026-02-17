Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ECDE68144
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsGIO-0005zV-9c; Tue, 17 Feb 2026 03:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsGII-0005yu-35
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsGIF-00014o-Pj
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771316329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwsgwrUKaFwOxXO5xyIH0WtaqDzd4Qf2LUG1u8LSqds=;
 b=MvcOA+5ZwpJBOsCBouWWzjLIhKenFCBmm7jHRQvQlRlE2l7VOQW+U/c4mfRR7UhFTiKIsY
 tmYrj16pt28IddXKZscZDsJ4q59QvcmLSbjoR8rVW1bpocoAQab8i8Lt0/D5/RvEKPNr7B
 XnLbpyTEyNInP2vVewYG2jtrgYdMx/c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-oB8Tgf-LN2mgkfdZxrnELw-1; Tue,
 17 Feb 2026 03:18:45 -0500
X-MC-Unique: oB8Tgf-LN2mgkfdZxrnELw-1
X-Mimecast-MFC-AGG-ID: oB8Tgf-LN2mgkfdZxrnELw_1771316323
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19C24195DE50; Tue, 17 Feb 2026 08:18:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88B3519560A2; Tue, 17 Feb 2026 08:18:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1517421E692D; Tue, 17 Feb 2026 09:18:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 jrossi@linux.ibm.com,  qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,
 david@kernel.org,  walling@linux.ibm.com,  jjherne@linux.ibm.com,
 pasic@linux.ibm.com,  borntraeger@linux.ibm.com,  farman@linux.ibm.com,
 mjrosato@linux.ibm.com,  iii@linux.ibm.com,  eblake@redhat.com,
 alifm@linux.ibm.com,  brueckner@linux.ibm.com
Subject: Re: [PATCH v8 09/30] s390x/diag: Implement DIAG 320 subcode 2
In-Reply-To: <20260212204352.1044699-10-zycai@linux.ibm.com> (Zhuoying Cai's
 message of "Thu, 12 Feb 2026 15:43:30 -0500")
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-10-zycai@linux.ibm.com>
Date: Tue, 17 Feb 2026 09:18:40 +0100
Message-ID: <874infpyu7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zhuoying Cai <zycai@linux.ibm.com> writes:

> DIAG 320 subcode 2 provides verification-certificates (VCs) that are in t=
he
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
> The key ID and hash are extracted from the raw certificate by the crypto =
API.
>
> Note: SHA2-256 VC hash type is required for retrieving the hash
> (fingerprint) of the certificate.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

[...]

> @@ -235,8 +237,324 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, =
uint64_t addr, uint64_t r1,
>      return DIAG_320_RC_OK;
>  }
>=20=20
> +static bool is_cert_valid(const S390IPLCertificate *cert)
> +{
> +    int rc;
> +    Error *err =3D NULL;
> +
> +    rc =3D qcrypto_x509_check_cert_times(cert->raw, cert->size, &err);
> +    if (rc !=3D 0) {
> +        error_report_err(err);

Does not build for me:

    ../target/s390x/diag.c: In function =E2=80=98is_cert_valid=E2=80=99:
    ../target/s390x/diag.c:249:9: error: implicit declaration of function =
=E2=80=98error_report_err=E2=80=99; did you mean =E2=80=98error_report=E2=
=80=99? [-Wimplicit-function-declaration]
      249 |         error_report_err(err);
          |         ^~~~~~~~~~~~~~~~
          |         error_report

> +        return false;
> +    }
> +
> +    return true;
> +}

[...]


