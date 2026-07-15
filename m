Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC738C4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 04:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjrbC-00048G-Qj; Wed, 15 Jul 2026 00:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjrb9-00047J-2W
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 00:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjrb7-00054P-8x
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 00:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784091112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1bJTrOfAg3tdRBHAxF5th//uds1t5x3ElLTXXm8cmE=;
 b=gjT4C8z0DI7fUNSqhAb4RsU0YfsxsYiJ/wTMu3CQU+9+IclIDwz8sNprPbYjKn0xPBVDDu
 1P2C6q7GbeVJt9eFUsErUreHNkB5YWB1t0l9h83EOQ8HCGjaw4btbOe87bYOmVJlwZH/N8
 9CENSJsI9mr2puihSu9PBalpV4I5Hhw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-RYFA5gQHNPKqCvVmdg_VmA-1; Wed,
 15 Jul 2026 00:51:48 -0400
X-MC-Unique: RYFA5gQHNPKqCvVmdg_VmA-1
X-Mimecast-MFC-AGG-ID: RYFA5gQHNPKqCvVmdg_VmA_1784091106
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CA391800576; Wed, 15 Jul 2026 04:51:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A076C403; Wed, 15 Jul 2026 04:51:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10D6621E6920; Wed, 15 Jul 2026 06:51:41 +0200 (CEST)
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
Subject: Re: [PATCH v2 07/17] crypto/cipher: Add GCM to QCryptoCipherMode
In-Reply-To: <20260715033311.1648424-8-jamin_lin@aspeedtech.com> (Jamin Lin's
 message of "Wed, 15 Jul 2026 03:33:23 +0000")
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-8-jamin_lin@aspeedtech.com>
Date: Wed, 15 Jul 2026 06:51:41 +0200
Message-ID: <87o6g8j1nm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

> Introduce the GCM cipher mode so authenticated encryption can be built
> on top of the existing qcrypto_cipher API. GCM is an IV-based mode, so
> register it in mode_need_iv. No backend advertises it yet, so it stays
> unsupported until a backend and the AAD/tag helpers are added in the
> following patches.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Same person giving Reviewed-by and Acked-by is odd.  Daniel, is this
what you want?

> ---
>  qapi/crypto.json | 4 +++-
>  crypto/cipher.c  | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 2b55befef9..6e3a98ff68 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -121,10 +121,12 @@
>  #
>  # @ctr: Counter (Since 2.8)
>  #
> +# @gcm: Galois/Counter Mode (Since 11.2)
> +#
>  # Since: 2.6
>  ##
>  { 'enum': 'QCryptoCipherMode',
> -  'data': ['ecb', 'cbc', 'xts', 'ctr']}
> +  'data': ['ecb', 'cbc', 'xts', 'ctr', 'gcm']}
>=20=20
>  ##
>  # @QCryptoIVGenAlgo:

Acked-by: Markus Armbruster <armbru@redhat.com>


[...]


