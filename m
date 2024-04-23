Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031E5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 12:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzFC2-0008Nu-I5; Tue, 23 Apr 2024 08:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzFBz-0008NO-Ji
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzFBx-0000jx-6b
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713875046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fiqphxhYJargMMyLa5pQpnAo6EBJ91EbXVeBFXykreM=;
 b=PoYiWvJ0AUVQ7oTgy661iPmpWJpDwX8S++PxNdGSeRa/zZQYmHA7zgqtk8I/kCW/cbHH6C
 xb4hPV8oIdbjG5VhFKDcVFPngR0luCqr4YJscpypyC3xgp9HY3OOR1/7PxbrWVsXHamCV3
 IJlntONmFLT6C9zBf5kY4c5ZMJdY9ys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-mn02n3XQPyO058_wGItq9Q-1; Tue, 23 Apr 2024 08:23:57 -0400
X-MC-Unique: mn02n3XQPyO058_wGItq9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BB988001B2;
 Tue, 23 Apr 2024 12:23:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE6B0406D72A;
 Tue, 23 Apr 2024 12:23:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E691C21E66E5; Tue, 23 Apr 2024 14:23:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: peter.maydell@linaro.org,  richard.henderson@linaro.org,
 philmd@linaro.org,  pbonzini@redhat.com,  alex.bennee@linaro.org,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 15/22] target/arm/kvm-rme: Add measurement algorithm
 property
In-Reply-To: <20240419155709.318866-17-jean-philippe@linaro.org>
 (Jean-Philippe Brucker's message of "Fri, 19 Apr 2024 16:57:03 +0100")
References: <20240419155709.318866-2-jean-philippe@linaro.org>
 <20240419155709.318866-17-jean-philippe@linaro.org>
Date: Tue, 23 Apr 2024 14:23:55 +0200
Message-ID: <87o7a0b738.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Jean-Philippe Brucker <jean-philippe@linaro.org> writes:

> This option selects which measurement algorithm to use for attestation.
> Supported values are SHA256 and SHA512. Default to SHA512 arbitrarily.
>
> SHA512 is generally faster on 64-bit architectures. On a few arm64 CPUs
> I tested SHA256 is much faster, but that's most likely because they only
> support acceleration via FEAT_SHA256 (Armv8.0) and not FEAT_SHA512
> (Armv8.2). Future CPUs supporting RME are likely to also support
> FEAT_SHA512.
>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: use enum, pick default
> ---
>  qapi/qom.json        | 18 +++++++++++++++++-
>  target/arm/kvm-rme.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 91654aa267..84dce666b2 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -931,18 +931,34 @@
>    'data': { '*cpu-affinity': ['uint16'],
>              '*node-affinity': ['uint16'] } }
>=20=20
> +##
> +# @RmeGuestMeasurementAlgo:
> +#
> +# @sha256: Use the SHA256 algorithm

Let's have a blank line here.

> +# @sha512: Use the SHA512 algorithm
> +#
> +# Algorithm to use for realm measurements
> +#
> +# Since: FIXME

9.1

> +##
> +{ 'enum': 'RmeGuestMeasurementAlgo',
> +  'data': ['sha256', 'sha512'] }
> +
>  ##
>  # @RmeGuestProperties:
>  #
>  # Properties for rme-guest objects.
>  #
> +# @measurement-algo: Realm measurement algorithm (default: sha512)
> +#

We tend to avoid abbreviations in QMP: @measurement-algorithm.

May want to rename the type to RmeGuestMeasurementAlgorithm for
consistency.

>  # @personalization-value: Realm personalization value, as a 64-byte hex =
string
>  #     (default: 0)
>  #
>  # Since: FIXME
>  ##
>  { 'struct': 'RmeGuestProperties',
> -  'data': { '*personalization-value': 'str' } }
> +  'data': { '*personalization-value': 'str',
> +            '*measurement-algo': 'RmeGuestMeasurementAlgo' } }
>=20=20
>  ##
>  # @ObjectType:

With these issues addressed, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


