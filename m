Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55634108B91E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZFO-0004Hh-5s; Fri, 20 Mar 2026 08:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3ZFL-0004HH-U0
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3ZFI-0000PR-8y
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774010790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bD+nMc1TA608d6ErugCw51PJWxYh7LFIfsisCXnAss=;
 b=HlDzn7oiY6xPYDZkZmNiSmSopgKO/Sze5iJ/MUYYRjdgsIr6LLLqql9PTjQj+ioB6mOWfW
 nzDjjOz+nqnN/2zEWT4cHAEF+lnlSKmODebs48UksZeqAv5Ne4vQSXC9dNS/RGmoSomGwO
 CvBxJVof8ViTfBq8lylfGPsoOvKGZso=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-NSIgT6WpMl6twN3eib9A-A-1; Fri,
 20 Mar 2026 08:46:23 -0400
X-MC-Unique: NSIgT6WpMl6twN3eib9A-A-1
X-Mimecast-MFC-AGG-ID: NSIgT6WpMl6twN3eib9A-A_1774010780
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F8A01955D86; Fri, 20 Mar 2026 12:46:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A137D1800361; Fri, 20 Mar 2026 12:46:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D7F0D21E6937; Fri, 20 Mar 2026 13:46:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Jason
 Wang <jasowang@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Peter
 Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Alex Williamson <alex@shazbot.org>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Yanan
 Wang <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 2/8] qapi: prohibit 'details' sections between tagged
 sections
In-Reply-To: <20260316182608.148628-3-jsnow@redhat.com> (John Snow's message
 of "Mon, 16 Mar 2026 14:26:01 -0400")
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-3-jsnow@redhat.com>
Date: Fri, 20 Mar 2026 13:46:15 +0100
Message-ID: <87h5qa7joo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

John Snow <jsnow@redhat.com> writes:

> This patch prohibits plain documentation sections from appearing between
> "tagged" sections. The two existing uses of this pattern are patched
> out.

One real use, and one just for test coverage.

> This is being done primarily to ensure consistency between the source
> documents and the final, rendered HTML output. Because
> member/feature/returns/error sections will always appear in a visually
> grouped element in the HTML output, prohibiting plain paragraphs between
> those sections ensures ordering consistency between source and the final
> render.

Is consistency an actual problem being fixed, or a future problem being
avoided?  I'm guessing the latter, based on my review of qom.json below.

> Additionally, prohibiting such "middle" text paragraphs allows us to
> classify all plain text sections as either "intro" or "details" sections,
> because these sections must either appear before structured/tagged
> sections ("intro") or afterwards ("details").

Huh?

The previous patch already classified all plain text sections as either
INTRO or DETAILS.

I think the paragraph would make sense if this patch came before the
previous one.

> This keeps the inlining algorithm simpler with fewer "splice" points
> when merging multiple documentation blocks.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/qom.json                   |  4 ++--
>  scripts/qapi/parser.py          | 17 +++++++++++++++++
>  tests/qapi-schema/doc-good.json |  4 ++--
>  tests/qapi-schema/doc-good.out  |  4 ++--
>  tests/qapi-schema/doc-good.txt  |  8 ++++----
>  5 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c653248f85d..1b47abd44e9 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -243,12 +243,12 @@
>  #
>  # @typename: the type name of an object
>  #
> +# Returns: a list describing object properties
> +#
>  # .. note:: Objects can create properties at runtime, for example to
>  #    describe links between different devices and/or objects.  These
>  #    properties are not included in the output of this command.
>  #
> -# Returns: a list describing object properties
> -#
>  # Since: 2.12
>  ##
>  { 'command': 'qom-list-properties',

Rendered documentation before the patch:

    Command qom-list-properties (Since: 2.12)

       List properties associated with a QOM object.

       Arguments:
          * typename (string) -- the type name of an object

       Note:

         Objects can create properties at runtime, for example to describe
         links between different devices and/or objects.  These properties
         are not included in the output of this command.

       Return:
          [ObjectPropertyInfo] -- a list describing object properties

Afterwards:

    Command qom-list-properties (Since: 2.12)

       List properties associated with a QOM object.

       Arguments:
          * typename (string) -- the type name of an object

       Return:
          [ObjectPropertyInfo] -- a list describing object properties

       Note:

         Objects can create properties at runtime, for example to describe
         links between different devices and/or objects.  These properties
         are not included in the output of this command.

Fine.

[Skipping the Python code in my first pass...]

> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
> index fac13425b72..9103fed472e 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -165,12 +165,12 @@
>  # @cmd-feat1: a feature
>  # @cmd-feat2: another feature
>  #
> -# .. note:: @arg3 is undocumented
> -#
>  # Returns: @Object
>  #
>  # Errors: some
>  #
> +# .. note:: @arg3 is undocumented
> +#
>  # TODO: frobnicate
>  #
>  # .. admonition:: Notes
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 04e29e8d50f..6a0167ad580 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -175,12 +175,12 @@ description starts on the same line
>  a feature
>      feature=cmd-feat2
>  another feature
> -    section=Details
> -.. note:: @arg3 is undocumented
>      section=Returns
>  @Object
>      section=Errors
>  some
> +    section=Details
> +.. note:: @arg3 is undocumented
>      section=Todo
>  frobnicate
>      section=Details

The Details section is still between tagged sections.  The code
prohibiting it must have a hole :)

> diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
> index 74b73681d32..ded699dd596 100644
> --- a/tests/qapi-schema/doc-good.txt
> +++ b/tests/qapi-schema/doc-good.txt
> @@ -120,16 +120,16 @@ Command cmd (Since: 2.10)
>  
>        * **cmd-feat2** -- another feature
>  
> -   Note:
> -
> -     "arg3" is undocumented
> -
>     Return:
>        "Object" -- "Object"
>  
>     Errors:
>        some
>  
> +   Note:
> +
> +     "arg3" is undocumented
> +
>     Notes:
>  
>     * Lorem ipsum dolor sit amet


