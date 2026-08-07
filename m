Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E126FC5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 09:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsGrr-00049o-FB; Fri, 07 Aug 2026 05:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsGrq-00049Q-7R
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 05:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsGro-0005a8-3O
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 05:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786094870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Srqkj+gU7lIh2jdsDohaYTsCGp2UPYERlP+ycDtDo6w=;
 b=Ht/dajIKKE88TnYOk8yOeXGpxr+ebQDmqT4Yjv6hNhCqB2Yfu9V+CtUEdRWWMk7XgXxev+
 BmYgDFyyEZMpsGZGvyoKyxVVxqF2nujO/FxU/jll3Qiux+ketwWJxvBSkWQnIxmQpqQgqp
 hdh+yl2wrOsrqUKIghAeHl4xDaODMu8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-0QGRZnLUMea1JmABpCSejA-1; Fri,
 07 Aug 2026 05:27:47 -0400
X-MC-Unique: 0QGRZnLUMea1JmABpCSejA-1
X-Mimecast-MFC-AGG-ID: 0QGRZnLUMea1JmABpCSejA_1786094866
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CC42195608B; Fri,  7 Aug 2026 09:27:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 214DC18005AC; Fri,  7 Aug 2026 09:27:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF8BB21E6920; Fri, 07 Aug 2026 11:27:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 08/53] qapi/qom: add qapi-type field to
 ObjectPropertyInfo
In-Reply-To: <20260616-qom-qapi-v2-8-cc9396b9c18c@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 16 Jun 2026 00:37:34 +0400")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-8-cc9396b9c18c@redhat.com>
Date: Fri, 07 Aug 2026 11:27:42 +0200
Message-ID: <87ik5mqnzl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add an optional 'qapi-type' field to ObjectPropertyInfo and
> ObjectPropertyValue. When present, it contains the masked type name that
> can be looked up in query-qmp-schema output. Absent for properties
> without a QAPI type association.

Always absent at this point, isn't it?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/qom.json | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index dd45ac1087c..a655be0beaa 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -35,6 +35,11 @@
   ##
   # @ObjectPropertyInfo:
   #
   # @name: the name of the property
   #
   # @type: the type of the property.  This will typically come in one of
   #     four forms:
   #
   #     1) A primitive type such as 'u8', 'u16', 'bool', 'str', or
   #        'double'.  These types are mapped to the appropriate JSON
   #        type.
   #
   #     2) A child type in the form 'child<subtype>' where subtype is a
   #        qdev device type name.  Child properties create the
   #        composition tree.
   #
   #     3) A link type in the form 'link<subtype>' where subtype is a
>  #        qdev device type name.  Link properties form the device model
>  #        graph.

The description of @type is problematic, and will need an update at some
time.

>  #
> +# @qapi-type: if the property was registered with a QAPI type
> +#     association, the type name as it appears in the output of
> +#     ``query-qmp-schema``.  Absent for properties without a QAPI
> +#     type association.  (since 11.1)

Whether "the property was registered with a QAPI type association" is
implementation detail.

Maybe

   # @qapi-type: the name of the property's type name as it appears in
   #     the output of ``query-qmp-schema``.  Absent if the type does not
   #     occur there.  (since 11.2)

This is inaccurate now --- it can also be absent when we haven't gotten
around to fix the property --- but it hopefully becomes accurate soon,
and should be good enough until then.

> +#
>  # @description: if specified, the description of the property.
>  #
>  # @default-value: the default value, if any (since 5.0)
> @@ -44,6 +49,7 @@
>  { 'struct': 'ObjectPropertyInfo',
>    'data': { 'name': 'str',
>              'type': 'str',
> +            '*qapi-type': 'str',
>              '*description': 'str',
>              '*default-value': 'any' } }
>=20=20
> @@ -55,6 +61,11 @@
>  # @type: the type of the property, as described in
>  #     `ObjectPropertyInfo`.
>  #
> +# @qapi-type: if the property was registered with a QAPI type
> +#     association, the type name as it appears in the output of
> +#     ``query-qmp-schema``.  Absent for properties without a QAPI
> +#     type association.  (since 11.1)
> +#

Likewise.

>  # @value: the value of the property.  Absent when the property cannot
>  #     be read.
>  #
> @@ -63,6 +74,7 @@
>  { 'struct': 'ObjectPropertyValue',
>    'data': { 'name': 'str',
>              'type': 'str',
> +            '*qapi-type': 'str',
>              '*value': 'any' } }
>=20=20
>  ##


