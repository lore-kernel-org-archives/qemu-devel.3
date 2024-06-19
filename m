Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F00BC2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJv2W-0004Nb-Ab; Wed, 19 Jun 2024 09:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJv2U-0004Mw-Tt
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJv2S-0003M7-TN
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718802467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jMZtSsnnNrY2nuyorhx1AWOVHMPA0edOHE53uKhMOb0=;
 b=Vv9SxaSeiam6Vflw/PL1T3q8keNYFkYqThjCz9Ce/jIfb7YRk/ahKqPD5G+w7roAQxsLzR
 rjZGCDUH0fMrPunZ7+QZhZzYQ9v00L0F7bZ/gv+CWGzGRb2Hfx/FyzZTbv7pGwO/wuWe0J
 HFmZGh0XxOBLzR3BbMTlWd86wy45vok=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-_xACPqQUMj6LVqDhSHqumw-1; Wed,
 19 Jun 2024 09:07:44 -0400
X-MC-Unique: _xACPqQUMj6LVqDhSHqumw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 053A019560B0; Wed, 19 Jun 2024 13:07:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBCBD3000218; Wed, 19 Jun 2024 13:07:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EE9721E6757; Wed, 19 Jun 2024 15:07:38 +0200 (CEST)
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
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Peter Xu <peterx@redhat.com>,  Igor
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
Date: Wed, 19 Jun 2024 15:07:38 +0200
Message-ID: <87zfrhxeqt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> diff --git a/qapi/control.json b/qapi/control.json
> index 10c906fa0e7..59d5e00c151 100644
> --- a/qapi/control.json
> +++ b/qapi/control.json
> @@ -22,14 +22,13 @@
>  #          "arguments": { "enable": [ "oob" ] } }
>  #     <- { "return": {} }
>  #
> -# Notes: This command is valid exactly when first connecting: it must
> -#     be issued before any other command will be accepted, and will
> -#     fail once the monitor is accepting other commands.  (see qemu
> -#     docs/interop/qmp-spec.rst)
> +# .. note:: This command is valid exactly when first connecting: it must
> +#    be issued before any other command will be accepted, and will fail
> +#    once the monitor is accepting other commands.  (see qemu
> +#    docs/interop/qmp-spec.rst)
>  #
> -#     The QMP client needs to explicitly enable QMP capabilities,
> -#     otherwise all the QMP capabilities will be turned off by
> -#     default.
> +# .. note:: The QMP client needs to explicitly enable QMP capabilities,
> +#    otherwise all the QMP capabilities will be turned off by default.
>  #
>  # Since: 0.13
>  ##
> @@ -150,8 +149,8 @@
>  #          ]
>  #        }
>  #
> -# Note: This example has been shortened as the real response is too
> -#     long.
> +# This example has been shortened as the real response is too long.
> +#

Here's one way to transform the elision note, ...

>  ##
>  { 'command': 'query-commands', 'returns': ['CommandInfo'],
>    'allow-preconfig': true }

[...]

> diff --git a/qapi/pci.json b/qapi/pci.json
> index 08bf6958634..f51159a2c4c 100644
> --- a/qapi/pci.json
> +++ b/qapi/pci.json
> @@ -146,8 +146,8 @@
>  #
>  # @regions: a list of the PCI I/O regions associated with the device
>  #
> -# Notes: the contents of @class_info.desc are not stable and should
> -#     only be treated as informational.
> +# .. note:: The contents of @class_info.desc are not stable and should
> +#    only be treated as informational.
>  #
>  # Since: 0.14
>  ##
> @@ -311,7 +311,8 @@
>  #           ]
>  #        }
>  #
> -# Note: This example has been shortened as the real response is too
> +#     Note: This example has been shortened as the real response is too
>  #     long.
> +#

... and here's another way.  Same way would be better, wouldn't it?
They actually are after PATCH 13:

  -#     Note: This example has been shortened as the real response is too
  -#     long.
  +# This example has been shortened as the real response is too long.

Move that hunk here, please.

>  ##
>  { 'command': 'query-pci', 'returns': ['PciInfo'] }

[...]


