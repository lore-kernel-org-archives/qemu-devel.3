Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA611C83F20
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSW-0001RR-7u; Fri, 11 Jul 2025 13:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaHST-0001PL-U4
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaHSR-0002vy-NI
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752254567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKq7s+o9FSe0v9gxOi1oL2fSecjASgBXq6NTvNcZRBQ=;
 b=M2a46hvAeLbjv944Gj1HmLxZihxpIcPxTXwUbqH67Dq77jAahwVG9UDjsn1fC0WF7Q/IFu
 nKQ6MoLTcqMMMJ1eE6CN3p0K69tFg/Hc1i+Gi+PwASAMF3ViVgfo9VKS1/qpyWQtFaya7U
 YF1oSCq9qID/ebh7ulh7iY2SkehIBkA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-kPy_lqiyNpWXlKYAfF2bKg-1; Fri,
 11 Jul 2025 13:22:44 -0400
X-MC-Unique: kPy_lqiyNpWXlKYAfF2bKg-1
X-Mimecast-MFC-AGG-ID: kPy_lqiyNpWXlKYAfF2bKg_1752254561
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 996BA1956095; Fri, 11 Jul 2025 17:22:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D31C319560A3; Fri, 11 Jul 2025 17:22:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45AA121E6A27; Fri, 11 Jul 2025 19:22:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Jiri Pirko <jiri@resnulli.us>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Peter Xu <peterx@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  qemu-trivial@nongnu.org,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Lukas
 Straub <lukasstraub2@web.de>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 1/4] docs/qapi-domain: add return-nodesc
In-Reply-To: <20250711051045.51110-2-jsnow@redhat.com> (John Snow's message of
 "Fri, 11 Jul 2025 01:10:42 -0400")
References: <20250711051045.51110-1-jsnow@redhat.com>
 <20250711051045.51110-2-jsnow@redhat.com>
Date: Fri, 11 Jul 2025 19:22:34 +0200
Message-ID: <87jz4eskv9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> This form is used to annotate a return type without an accompanying
> description, for when there is no "Returns:" information in the source
> doc, but we have a return type we want to generate a cross-reference to.
>
> The syntax is:
>
> :return-nodesc: TypeName
>
> It's primarily necessary because Sphinx always expects both a type and a
> description for the prior form and will format it accordingly. To have a
> reasonable rendering when the body is missing, we need to use a
> different info field list entirely.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-domain.rst | 30 ++++++++++++++++++++++++++++++
>  docs/sphinx/qapi_domain.py |  8 ++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
> index 11238723c2d..204abb72ff4 100644
> --- a/docs/devel/qapi-domain.rst
> +++ b/docs/devel/qapi-domain.rst
> @@ -242,6 +242,36 @@ Example::
>               }
>  
>  
> +``:return-nodesc:``
> +-------------------
> +
> +Document the return type of a QAPI command, without an accompanying description.

Recommend to break the long line.

> +
> +:availability: This field list is only available in the body of the
> +               Command directive.
> +:syntax: ``:return-nodesc: type``
> +:type: `sphinx.util.docfields.Field
> +       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.Field.html?private=1>`_
> +
> +
> +Example::
> +
> +   .. qapi:command:: query-replay
> +      :since: 5.2
> +
> +      Retrieve the record/replay information.  It includes current
> +      instruction count which may be used for ``replay-break`` and
> +      ``replay-seek`` commands.
> +
> +      :return-nodesc: ReplayInfo
> +
> +      .. qmp-example::
> +
> +          -> { "execute": "query-replay" }
> +          <- { "return": {
> +                 "mode": "play", "filename": "log.rr", "icount": 220414 }
> +             }
> +

Same example as in :return:, except for the :return-nodesc: line.  Fine
with me.

>  ``:value:``
>  -----------
>  
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index ebc46a72c61..f561dc465f8 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -532,6 +532,14 @@ class QAPICommand(QAPIObject):
>                  names=("return",),
>                  can_collapse=True,
>              ),
> +            # :return-nodesc: TypeName
> +            CompatField(
> +                "returnvalue",
> +                label=_("Return"),
> +                names=("return-nodesc",),
> +                bodyrolename="type",
> +                has_arg=False,
> +            ),
>          ]
>      )

Acked-by: Markus Armbruster <armbru@redhat.com>


