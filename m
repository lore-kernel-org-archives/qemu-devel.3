Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BC3C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 10:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR871-00046E-QT; Tue, 09 Jul 2024 06:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR86y-00041T-Mc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR86w-0006sk-Fx
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720521012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13l+XdibeN8Ugh8Z/PhcEGLLswIiksn0uO+mw1BvWQc=;
 b=MYZ6ADNKj0fpTomNTIxhba4pAoguLGSmTzO7UqUSaap3whgHQsGnMKQWRVChfn1T4zJyLu
 E4sppeu7PG8AndAvyfksay+9g5NUNtKtzNJzwtcm2LhhrU8nvifCkhclT2xD2s+FyAL/ro
 r+S7Y4zd8PFYlfL4D6yMQ+gfKSJK9s8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-AeyNH3g8NxaDSklOUzImTg-1; Tue,
 09 Jul 2024 06:30:07 -0400
X-MC-Unique: AeyNH3g8NxaDSklOUzImTg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 066841955BE7; Tue,  9 Jul 2024 10:30:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E74BB1955F3B; Tue,  9 Jul 2024 10:29:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BE7B21E6693; Tue,  9 Jul 2024 12:29:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Ani Sinha <anisinha@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Alex Williamson
 <alex.williamson@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 2/8] docs/qapidoc: create qmp-example directive
In-Reply-To: <20240703210144.339530-3-jsnow@redhat.com> (John Snow's message
 of "Wed, 3 Jul 2024 17:01:37 -0400")
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-3-jsnow@redhat.com>
Date: Tue, 09 Jul 2024 12:29:56 +0200
Message-ID: <87cynmj1sr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

John Snow <jsnow@redhat.com> writes:

> This is a directive that creates a syntactic sugar for creating
> "Example" boxes very similar to the ones already used in the bitmaps.rst
> document, please see e.g.
> https://www.qemu.org/docs/master/interop/bitmaps.html#creation-block-dirty-bitmap-add
>
> In its simplest form, when a custom title is not needed or wanted, and
> the example body is *solely* a QMP example:
>
> ```
> .. qmp-example::
>
>    {body}
> ```
>
> is syntactic sugar for:
>
> ```
> .. admonition:: Example:
>
>    .. code-block:: QMP
>
>       {body}
> ```
>
> When a custom, plaintext title that describes the example is desired,
> this form:
>
> ```
> .. qmp-example::
>    :title: Defrobnification
>
>    {body}
> ```
>
> Is syntactic sugar for:
>
> ```
> .. admonition:: Example: Defrobnification
>
>    .. code-block:: QMP
>
>       {body}
> ```
>
> Lastly, when Examples are multi-step processes that require non-QMP
> exposition, have lengthy titles, or otherwise involve prose with rST
> markup (lists, cross-references, etc), the most complex form:
>
> ```
> .. qmp-example::
>    :annotated:
>
>    This example shows how to use `foo-command`::
>
>      {body}
>
>    For more information, please see `frobnozz`.
> ```
>
> Is desugared to:
>
> ```
> .. admonition:: Example:
>
>    This example shows how to use `foo-command`::
>
>      {body}
>
>    For more information, please see `frobnozz`.
> ```
>
> Note that :annotated: and :title: options can be combined together, if
> desired.
>
> The primary benefit here being documentation source consistently using
> the same directive for all forms of examples to ensure consistent visual
> styling, and ensuring all relevant prose is visually grouped alongside
> the code literal block.
>
> Note that as of this commit, the code-block rST syntax "::" does not
> apply QMP highlighting; you would need to use ".. code-block:: QMP". The
> very next commit changes this behavior to assume all "::" code blocks
> within this directive are QMP blocks.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


