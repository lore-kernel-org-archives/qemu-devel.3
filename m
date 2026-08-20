Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05531C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwykx-0005W3-9M; Thu, 20 Aug 2026 05:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwykw-0005Vq-Ck
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwykv-0005rJ-0v
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787216892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uecjAU2gYRvxn8fyHC3pgm+iKARx1K9M8EVQ6QBZHVE=;
 b=Cl7EDWY3CI1skWolSVlEGuJfsLTz5FCCFJTqq1o5gicZp8wSaKujcDgwyl+lZ6bmuL1SiG
 O0AvKDTLLBkkVQTEv/u/K5MwM+6z3V37bEql0iFZbjiybi/y9C2dXk04lAoBfV6L2CF5+F
 imxVcHD7+7LXOs1JFuyJXYhOoOgqKx8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-Dl9Q59jZN1mD5EGFayX7Gw-1; Thu,
 20 Aug 2026 05:08:04 -0400
X-MC-Unique: Dl9Q59jZN1mD5EGFayX7Gw-1
X-Mimecast-MFC-AGG-ID: Dl9Q59jZN1mD5EGFayX7Gw_1787216882
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36B7A180049D; Thu, 20 Aug 2026 09:08:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEEB7180034F; Thu, 20 Aug 2026 09:07:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D0C521E6920; Thu, 20 Aug 2026 11:07:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Peter Maydell <peter.maydell@linaro.org>,  Steven Lee
 <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,  Kane Chen
 <kane_chen@aspeedtech.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,  Eric Blake <eblake@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "open list:All patches CC here"
 <qemu-devel@nongnu.org>,  "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v1 1/8] qapi/crypto: Add ECDSA algorithm and curve id
In-Reply-To: <20260818092249.602137-2-jamin_lin@aspeedtech.com> (Jamin Lin's
 message of "Tue, 18 Aug 2026 09:22:53 +0000")
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
 <20260818092249.602137-2-jamin_lin@aspeedtech.com>
Date: Thu, 20 Aug 2026 11:07:57 +0200
Message-ID: <87h5kp2m8i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Jamin Lin <jamin_lin@aspeedtech.com> writes:

> Introduce a new asymmetric cipher algorithm, ECDSA, a curve identifier
> enum (prime256v1 / NIST P-256 and secp384r1 / NIST P-384) and the
> per-algorithm ECDSA options. This is the QAPI groundwork consumed by the
> crypto akcipher backends in the following patches.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Why do you need this algorithm?  Oh, the cover letter explains.  Please
add a suitable brief explanation to this commit message, too.

> ---
>  qapi/crypto.json | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 6e3a98ff68..016d7c65bf 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -557,10 +557,26 @@
>  #
>  # @rsa: RSA algorithm
>  #
> +# @ecdsa: ECDSA algorithm

Missing (since 11.2)

> +#
>  # Since: 7.1
>  ##
>  { 'enum': 'QCryptoAkCipherAlgo',
> -  'data': ['rsa']}
> +  'data': ['rsa', 'ecdsa']}
> +
> +##
> +# @QCryptoCurveID:
> +#
> +# The supported elliptic curves.
> +#
> +# @prime256v1: NIST P-256 curve (prime256v1)
> +#
> +# @secp384r1: NIST P-384 curve (secp384r1)
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'QCryptoCurveID',
> +  'data': ['prime256v1', 'secp384r1']}
>  
>  ##
>  # @QCryptoAkCipherKeyType:
> @@ -605,6 +621,18 @@
>    'data': { 'hash-alg':'QCryptoHashAlgo',
>              'padding-alg': 'QCryptoRSAPaddingAlgo'}}
>  
> +##
> +# @QCryptoAkCipherOptionsECDSA:
> +#
> +# Specific parameters for the ECDSA algorithm.
> +#
> +# @curve-id: the elliptic curve to use
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'QCryptoAkCipherOptionsECDSA',
> +  'data': { 'curve-id': 'QCryptoCurveID' }}
> +
>  ##
>  # @QCryptoAkCipherOptions:
>  #
> @@ -618,4 +646,5 @@
>  { 'union': 'QCryptoAkCipherOptions',
>    'base': { 'alg': 'QCryptoAkCipherAlgo' },
>    'discriminator': 'alg',
> -  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
> +  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA',
> +            'ecdsa': 'QCryptoAkCipherOptionsECDSA' }}

With the missing since corrected, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


