Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEE8C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKd4k-0003gg-KS; Fri, 21 Jun 2024 08:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKd4i-0003fu-2Y
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKd4e-0005jh-H4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718971738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1suxfA1Pb8Cr6BK3PnDYsB/CX9JVGzcd/uVXG/At4Dk=;
 b=LdNk8qI5lDGbuxkYHGAcVFX8UyPF1/+305XHZvZC9V5+cJGME48Atr23L+wl0HITFC4UYM
 VIretlky0vk+uny2+Ujks+QNQG45zqgBfjsOtDcBGuSuhdG2J5DQQL9TqFyF52+Ue4qGJX
 4MjSn4dli7xppQqZfZPgC57IOfdaaNc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-kc6za-FfMPWqIJ-O7wLITw-1; Fri,
 21 Jun 2024 08:08:54 -0400
X-MC-Unique: kc6za-FfMPWqIJ-O7wLITw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9AF61956089; Fri, 21 Jun 2024 12:08:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17BAE19560AF; Fri, 21 Jun 2024 12:08:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0754821E6621; Fri, 21 Jun 2024 14:08:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Victor Toso de
 Carvalho <victortoso@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Peter Xu <peterx@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,  Jiri Pirko <jiri@resnulli.us>,  Alex Williamson
 <alex.williamson@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
In-Reply-To: <20240619003012.1753577-10-jsnow@redhat.com> (John Snow's message
 of "Tue, 18 Jun 2024 20:30:08 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
Date: Fri, 21 Jun 2024 14:08:47 +0200
Message-ID: <87a5je33cg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> We do not need a dedicated section for notes. By eliminating a specially
> parsed section, these notes can be treated as normal rST paragraphs in
> the new QMP reference manual, and can be placed and styled much more
> flexibly.
>
> Convert all existing "Note" and "Notes" sections to pure rST. As part of
> the conversion, capitalize the first letter of each sentence and add
> trailing punctuation where appropriate to ensure notes look sensible and
> consistent in rendered HTML documentation.
>
> Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and ...
>
> ... Update the QAPI parser to prohibit "Note" sections while suggesting
> a new syntax. The exact formatting to use is a matter of taste, but a
> good candidate is simply:
>
> .. note:: lorem ipsum ...
>
> ... but there are other choices, too. The Sphinx readthedocs theme
> offers theming for the following forms (capitalization unimportant); all
> are adorned with a (!) symbol in the title bar for rendered HTML docs.
>
> See
> https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html#admonitions
> for examples of each directive/admonition in use.
>
> These are rendered in orange:
>
> .. Attention:: ...
> .. Caution:: ...
> .. WARNING:: ...
>
> These are rendered in red:
>
> .. DANGER:: ...
> .. Error:: ...
>
> These are rendered in green:
>
> .. Hint:: ...
> .. Important:: ...
> .. Tip:: ...
>
> These are rendered in blue:
>
> .. Note:: ...
> .. admonition:: custom title
>
>    admonition body text
>
> This patch uses ".. note::" almost everywhere, with just two "caution"
> directives. ".. admonition:: notes" is used in a few places where we had
> an ordered list of multiple notes that would not make sense as
> standalone/separate admonitions.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com> [for block*.json]

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e3..5bfa0ded42c 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -195,12 +195,12 @@
>  #
>  # @typename: the type name of an object
>  #
> -# Note: objects can create properties at runtime, for example to
> -#     describe links between different devices and/or objects.  These
> -#     properties are not included in the output of this command.
> -#
>  # Returns: a list of ObjectPropertyInfo describing object properties
>  #
> +# .. note:: Objects can create properties at runtime, for example to
> +#    describe links between different devices and/or objects.  These
> +#    properties are not included in the output of this command.
> +#
>  # Since: 2.12
>  ##

You move the note.  Commit message doesn't tell why.

>  { 'command': 'qom-list-properties',

[...]


