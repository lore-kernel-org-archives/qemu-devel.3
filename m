Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E643C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJvEi-0007y6-OY; Wed, 19 Jun 2024 09:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJvEg-0007xF-Pt
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJvEe-0005al-Us
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718803223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yuqA+QThPNBmo5koU2E66mFhPIza5EKzCc076mvico8=;
 b=bc9ngluL62ETM8rS8WcslkamDj9GHVtRugCImP9BSRmVouix3OQxWrCcTlKiGZgvuB+PZ1
 S4dqPAtup3cPpxHLBZE3OTTnttF2NGxJSc2EuJjNYLsgkoKeofww/q7+ssYy582ZhTaSe8
 s1PIkHXu3P9lRErdMtgtNjCBlY5ZXDY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-xhmAC8ydP328-sbY1VEfBw-1; Wed,
 19 Jun 2024 09:20:21 -0400
X-MC-Unique: xhmAC8ydP328-sbY1VEfBw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3728E1955EA0; Wed, 19 Jun 2024 13:20:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0053A1956087; Wed, 19 Jun 2024 13:20:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6E7421E64CD; Wed, 19 Jun 2024 15:20:13 +0200 (CEST)
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
Subject: Re: [PATCH 13/13] qapi: convert "Example" sections to rST
In-Reply-To: <20240619003012.1753577-14-jsnow@redhat.com> (John Snow's message
 of "Tue, 18 Jun 2024 20:30:12 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-14-jsnow@redhat.com>
Date: Wed, 19 Jun 2024 15:20:13 +0200
Message-ID: <87sex9xe5u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> Eliminate the "Example" sections in QAPI doc blocks, converting them
> into QMP example code blocks. This is generally done in this patch by
> converting "Example:" or "Examples:" lines into ".. code-block:: QMP"
> lines.
>
> The old "Example:" or "Examples:" syntax is now caught as an error; but
> with the previous commit, "Example::" is still permitted as explicit rST
> syntax. ('Example' is not special in this case; any sentence that ends
> with "::" will start an indented code block in rST.)
>
> The ".. code-block:: QMP" form explicitly applies the QMP lexer and will
> loosely validate an example as valid QMP/JSON. The "::" form does not
> apply any lexer in particular and will not emit any errors.
>
> It is possible to choose the QMP lexer with the "::" form by using the
> Sphinx directive ".. highlight:: QMP" in the document above where the
> example appears; but this changes the lexer for *all* subsequent "::"
> style code-blocks in the document thereafter.
>
> This patch does not change the default lexer for the legacy qapidoc
> generator documents; future patches for the new qapidoc generator *may*
> change this default.
>
> This patch has several benefits:
>
> 1. Example sections can now be written more arbitrarily, mixing
>    explanatory paragraphs and code blocks however desired.
>
> 2. "Example sections" can now use fully arbitrary rST.

Do the double-quotes signify something I'm missing?

>
> 3. All code blocks are now lexed and validated as QMP; increasing
>    usability of the docs and ensuring validity of example snippets.
>
>    (To some extent - This patch only gaurantees it lexes correctly, not
>    that it's valid under the JSON or QMP grammars. It will catch most
>    small mistakes, however.)
>
> 4. Each code-block can be captioned independently without bypassing the
>    QMP lexer/validator.
>
>    (i.e. code blocks are now for *code* only, so we don't have to
>    sacrifice annotations/captions for having lexicographically correct
>    examples.)
>
> For any sections with more than one example, examples are split up into
> multiple code-block regions. If annotations are present, those
> annotations are converted into code-block captions instead, e.g.
>
> ```
> Examples:
>
>    1. Lorem Ipsum
>
>    -> { "foo": "bar" }
> ```
>
> Is rewritten as:
>
> ```
> .. code-block:: QMP
>    :caption: Example: Lorem Ipsum
>
>    -> { "foo": "bar" }
> ```
>
> This process was only semi-automated:
>
> 1. Replace "Examples?:" sections with sed:
>
> sed -i 's|# Example:|# .. code-block:: QMP|' *.json
> sed -i 's|# Examples:|# .. code-block:: QMP|' *.json
>
> 2. Identify sections that no longer parse successfully by attempting the
>    doc build, convert annotations into captions manually.
>    (Tedious, oh well.)
>
> 3. Add captions where still needed:
>
> sed -zi 's|# .. code-block:: QMP\n#\n|# .. code-block:: QMP\n#    :caption: Example\n#\n|g' *.json
>
> Not fully ideal, but hopefully not something that has to be done very
> often. (Or ever again.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com> [for block*.json]

[...]

> diff --git a/qapi/pci.json b/qapi/pci.json
> index f51159a2c4c..9192212661b 100644
> --- a/qapi/pci.json
> +++ b/qapi/pci.json
> @@ -182,7 +182,8 @@
>  #
>  # Since: 0.14
>  #
> -# Example:
> +# .. code-block:: QMP
> +#    :caption: Example
>  #
>  #     -> { "execute": "query-pci" }
>  #     <- { "return": [
> @@ -311,8 +312,7 @@
>  #           ]
>  #        }
>  #
> -#     Note: This example has been shortened as the real response is too
> -#     long.
> +# This example has been shortened as the real response is too long.

Squash into PATCH 09.

>  #
>  ##
>  { 'command': 'query-pci', 'returns': ['PciInfo'] }

Otherwise looks good to me except for the somewhat ugly rendering in
HTML mentioned in the commit message.

[...]


