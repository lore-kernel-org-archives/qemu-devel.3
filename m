Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C744C52D6D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawxu-000206-8T; Mon, 05 Aug 2024 08:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sawxr-0001x5-LV
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sawxl-0004oz-Vo
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722861440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=jP8DNkmFIktrKqhi7j2MBsUuwQRMyGSuxCal0dtHbgg=;
 b=TypQOcH4/koUhQ61vosfq8SUoKk/oSpm/VKBFLDjEj3Pt4DrQYiUjoZQ/zDdWdxyz2T3rH
 ZW8yu0b+II+uKRXPAPw+Pv9Z4SKY86zEyJf0TY35U5pzWEyjqkY3FwbEQ1d7qFcBtjCha9
 U980GNMKf+cwfpwAjpmQiB9lm3tiIHQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-gmiL1z23OTW5Eev9LK0GZg-1; Mon,
 05 Aug 2024 08:37:18 -0400
X-MC-Unique: gmiL1z23OTW5Eev9LK0GZg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 772B51955F0A; Mon,  5 Aug 2024 12:37:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF85219560AA; Mon,  5 Aug 2024 12:37:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BD2221E6692; Mon,  5 Aug 2024 14:37:14 +0200 (CEST)
Resent-To: michael.roth@amd.com, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 05 Aug 2024 14:37:14 +0200
Resent-Message-ID: <87a5hrno1x.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH 1/6] qapi: change 'unsigned special_features' to
 'uint64_t features'
In-Reply-To: <20240801175913.669013-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Aug 2024 18:59:08
 +0100")
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-2-berrange@redhat.com>
Date: Mon, 05 Aug 2024 13:53:38 +0200
Message-ID: <87h6bzp4n1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The "special_features" field / parameter holds the subset of schema
> features that are for internal code use. Specifically 'DEPRECATED'
> and 'UNSTABLE'.
>
> This special casing of internal features is going to be removed, so
> prepare for that by renaming to 'features'. Using a fixed size type
> is also best practice for bit fields.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

>  static void forward_field_complete(Visitor *v, void *opaque)
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 65a7d18437..3d849fe034 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -37,19 +37,19 @@ static bool compat_policy_input_ok1(const char *adjec=
tive,
>      }
>  }
>=20=20
> -bool compat_policy_input_ok(unsigned special_features,
> +bool compat_policy_input_ok(uint64_t features,
>                              const CompatPolicy *policy,
>                              ErrorClass error_class,
>                              const char *kind, const char *name,
>                              Error **errp)
>  {
> -    if ((special_features & 1u << QAPI_DEPRECATED)
> +    if ((features & 1u << QAPI_DEPRECATED)

Before the patch, both operands of & are unsigned.  The patch changes
one of them to uint64_t.  Shouldn't we change the other one, too?

>          && !compat_policy_input_ok1("Deprecated",
>                                      policy->deprecated_input,
>                                      error_class, kind, name, errp)) {
>          return false;
>      }
> -    if ((special_features & (1u << QAPI_UNSTABLE))
> +    if ((features & (1u << QAPI_UNSTABLE))

Likewise.

>          && !compat_policy_input_ok1("Unstable",
>                                      policy->unstable_input,
>                                      error_class, kind, name, errp)) {

[...]

> diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
> index 74770edd73..8902287caa 100644
> --- a/qapi/qobject-output-visitor.c
> +++ b/qapi/qobject-output-visitor.c
> @@ -210,13 +210,13 @@ static bool qobject_output_type_null(Visitor *v, co=
nst char *name,
>  }
>=20=20
>  static bool qobject_output_policy_skip(Visitor *v, const char *name,
> -                                       unsigned special_features)
> +                                       uint64_t features)
>  {
>      CompatPolicy *pol =3D &v->compat_policy;
>=20=20
> -    return ((special_features & 1u << QAPI_DEPRECATED)
> +    return ((features & 1u << QAPI_DEPRECATED)

Likewise.

>              && pol->deprecated_output =3D=3D COMPAT_POLICY_OUTPUT_HIDE)
> -        || ((special_features & 1u << QAPI_UNSTABLE)
> +        || ((features & 1u << QAPI_UNSTABLE)

Likewise.

>              && pol->unstable_output =3D=3D COMPAT_POLICY_OUTPUT_HIDE);
>  }
>=20=20

[...]


