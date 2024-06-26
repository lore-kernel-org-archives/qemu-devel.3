Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25978C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 05:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sML33-0000Fn-AN; Wed, 26 Jun 2024 01:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sML31-0000FX-B4
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 01:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sML2z-0007YO-Gz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 01:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719379097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BIeCWZG3Ip7zpggbu/qB+rIpsHFCg2ZZ9DDZKETRaSk=;
 b=fNMd+vyN49FjoTMg2qhURRV2XNgVgnzJYgOZHbIRZoN7hOsav/vgm+u6HNStnjm4MTgEox
 8ZhQ/Ux5P5sxScxjubNvkM4bPiweKApsr0EBIrkmqGG4/RK4Lfq1zKdBT6VXjLmRPjkXa2
 5YQF89dzD7VSJLRKgZGF08y1AcTg34Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-lvBES073MFu_IMKpd_rZlg-1; Wed,
 26 Jun 2024 01:18:10 -0400
X-MC-Unique: lvBES073MFu_IMKpd_rZlg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 937FE19560B3; Wed, 26 Jun 2024 05:18:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E49EE19560AD; Wed, 26 Jun 2024 05:17:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDDCF21E5EC0; Wed, 26 Jun 2024 07:17:57 +0200 (CEST)
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
Subject: Re: [PATCH 13/13] qapi: convert "Example" sections to rST
In-Reply-To: <20240619003012.1753577-14-jsnow@redhat.com> (John Snow's message
 of "Tue, 18 Jun 2024 20:30:12 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-14-jsnow@redhat.com>
Date: Wed, 26 Jun 2024 07:17:57 +0200
Message-ID: <875xtwwad6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

> Eliminate the "Example" sections in QAPI doc blocks, converting them
> into QMP example code blocks. This is generally done in this patch by
> converting "Example:" or "Examples:" lines into ".. code-block:: QMP"
> lines.

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 85a14bb4308..849358b6387 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json

[...]

> @@ -336,7 +338,35 @@
>  #           }
>  #        }
>  #
> -#     5. Migration is being performed and XBZRLE is active:
> +# .. code-block:: QMP
> +#    :caption: Example: Migration is being performed and XBZRLE is active
> +#
> +#     -> { "execute": "query-migrate" }
> +#     <- {
> +#           "return":{
> +#              "status":"active",
> +#              "total-time":12345,
> +#              "setup-time":12345,
> +#              "expected-downtime":12345,
> +#              "ram":{
> +#                 "total":1057024,
> +#                 "remaining":1053304,
> +#                 "transferred":3720,
> +#                 "duplicate":123,
> +#                 "normal":123,
> +#                 "normal-bytes":123456,
> +#                 "dirty-sync-count":15
> +#              },
> +#              "disk":{
> +#                 "total":20971520,
> +#                 "remaining":20880384,
> +#                 "transferred":91136
> +#              }
> +#           }
> +#        }
> +#
> +# .. code-block:: QMP
> +#    :caption: Example: Migration is being performed and XBZRLE is active
>  #
>  #     -> { "execute": "query-migrate" }
>  #     <- {

Example accidentally duplicated.


[...]

> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
> index 4b338cc0186..2774a7ce14d 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -46,11 +46,13 @@
>  #
>  # Duis aute irure dolor
>  #
> -# Example:
> +# .. code-block:: QMP
> +#    :caption: Example:

See [*] below.

>  #
>  # -> in
>  # <- out
> -# Examples:
> +# .. code-block::
> +#

Likewise.

>  # - *verbatim*
>  # - {braces}
>  ##
> @@ -172,12 +174,13 @@
>  #
>  #  Duis aute irure dolor
>  #
> -# Example:
> +# .. code-block::
>  #
>  #  -> in
>  #  <- out
>  #
> -# Examples:
> +# .. code-block::
> +#
>  #  - *verbatim*
>  #  - {braces}
>  #
> @@ -196,7 +199,7 @@
>  # @cmd-feat1: a feature
>  # @cmd-feat2: another feature
>  #
> -# Example:
> +# .. code-block::
>  #
>  #  -> in
>  #
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 2c9b4e419cb..347b9cb7134 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -93,11 +93,13 @@ Notes:
>  
>  Duis aute irure dolor
>  
> -Example:
> +.. code-block:: QMP
> +   :caption: Example:

[*] This demonstrates the "Example: ..." is *not* recognized as a
"Example" section before the patch (compare to the change we get for
recognized sections below).

I pointed out the same issue for "Note" in review of PATCH 9, and
suggested ways to resolve it.  Pick a way there, and use it here as well

>  
>  -> in
>  <- out
> -Examples:
> +.. code-block::
> +
>  - *verbatim*
>  - {braces}
>  doc symbol=Enum
> @@ -184,10 +186,14 @@ frobnicate
>   - Ut enim ad minim veniam
>  
>   Duis aute irure dolor
> -    section=Example
> +
> +.. code-block::
> +
>   -> in
>   <- out
> -    section=Examples
> +
> +.. code-block::
> +
>   - *verbatim*
>   - {braces}
>      section=Since
> @@ -199,7 +205,9 @@ If you're bored enough to read this, go see a video of boxed cats
>  a feature
>      feature=cmd-feat2
>  another feature
> -    section=Example
> +    section=None
> +.. code-block::
> +
>   -> in
>  
>   <- out
> diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
> index b89f35d5476..1bd31f0938d 100644
> --- a/tests/qapi-schema/doc-good.txt
> +++ b/tests/qapi-schema/doc-good.txt
> @@ -35,7 +35,10 @@ Duis aute irure dolor
>  
>  Example:
>  
> --> in <- out Examples: - *verbatim* - {braces}
> +-> in <- out .. code-block:

Looks like Sphinx didn't recognize the .. code-block: directive.
Generator bug?

> +
> +   - *verbatim*
> +   - {braces}
>  
>  
>  "Enum" (Enum)
> @@ -219,17 +222,9 @@ Notes:
>  
>  Duis aute irure dolor
>  
> -
> -Example
> -~~~~~~~
> -
>     -> in
>     <- out
>  
> -
> -Examples
> -~~~~~~~~
> -
>     - *verbatim*
>     - {braces}
>  
> @@ -260,10 +255,6 @@ Features
>  "cmd-feat2"
>     another feature
>  
> -
> -Example
> -~~~~~~~
> -
>     -> in
>  
>     <- out

Rendering to text now loses the "Example" heading.

We render to manual pages in addition to HTML.  Looks like we don't lose
"Example" there.  Odd.

We render to text only for diffing purposes.  The loss there could
perhaps be tolerated.  Still, could you avoid it with reasonable effort?


