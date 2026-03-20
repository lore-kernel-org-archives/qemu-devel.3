Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0806F108B912
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3YuW-0005lD-QD; Fri, 20 Mar 2026 08:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3YuU-0005h6-HJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3YuS-0002K2-0U
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774009498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7qh0rVpW1YvZuidsqMRR4n7j7DsSIC/EK2u35AhmMnY=;
 b=McQd6n1mawe7KfaNLAOYlazeVQeAa/8GlXoczBkT0qxksNW0gdFoDvumGowt1opnim+fNB
 RK7k0OXAbQZ1YDi/eKjVXWx6Wgi+AFtH9GRn4IuSMMTeJtQc0VAWplYvwJE0hIEQlZ2ure
 MlpHivTKJsh6Mag8bcbaB2e05MSYe70=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-3kF8HO8RN4GmlNDAcExYzg-1; Fri,
 20 Mar 2026 08:24:53 -0400
X-MC-Unique: 3kF8HO8RN4GmlNDAcExYzg-1
X-Mimecast-MFC-AGG-ID: 3kF8HO8RN4GmlNDAcExYzg_1774009491
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32854195605E; Fri, 20 Mar 2026 12:24:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9692D1800766; Fri, 20 Mar 2026 12:24:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 87D3C21E6937; Fri, 20 Mar 2026 13:24:45 +0100 (CET)
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
Subject: Re: [PATCH 1/8] qapi: differentiate "intro" and "details" sections
In-Reply-To: <20260316182608.148628-2-jsnow@redhat.com> (John Snow's message
 of "Mon, 16 Mar 2026 14:26:00 -0400")
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-2-jsnow@redhat.com>
Date: Fri, 20 Mar 2026 13:24:45 +0100
Message-ID: <87se9u7koi.fsf@pond.sub.org>
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

> This patch begins distinguishing "Plain" sections as being either
> "Intro" or "Details" sections for the purpose of knowing when/where/how
> to inline those sections.
>
> The Intro section is always the first section of any doc block. It may
> be empty or any number of paragraphs. It is interrupted by any other
> non-plaintext section, i.e.; Members, Features, Errors, Returns, Since,
> and TODO.
>
> The details section, when present, is either the last section or the
> second-to-last section when a "Since:" section is present. It consists
> of any plain text in the doc block that follows any named sections if
> present.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

The commit message explains what kinds INTRO and DETAILS are, but not
why they're useful.  My guess:

1. Represent the future "Details:" marker: the plain section before it
is of kind INTRO, the one afterwards is of kind DETAILS.

2. Future programming convenience?  With just PLAIN, code may have to
understand the section's context to make decisions, and with INTRO and
DETAILS is doesn't.

Guess close enough?

The commit message covers PLAIN sections at the beginning and at the end
(modulo Since:).  It doesn't cover PLAIN sections between tagged
sections / member descriptions.  You disallow these in PATCH 2.  You can
either cover them here, or get rid of them by swapping PATCH 1 and 2.

Hmm, is your description of DETAILS accurate?  Looks like it isn't; see
my review of tests/qapi-schema/doc-good.out below.

> ---
>  docs/sphinx/qapidoc.py         |  2 +-
>  scripts/qapi/parser.py         | 35 +++++++++++++++++++++++-----------
>  tests/qapi-schema/doc-good.out |  8 ++++----
>  3 files changed, 29 insertions(+), 16 deletions(-)

[Skipping the Python code in my first pass...]

> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 04a55072646..04e29e8d50f 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -116,7 +116,7 @@ The _one_ {and only}, description on the same line
>  Also _one_ {and only}
>      feature=enum-member-feat
>  a member feature
> -    section=Plain
> +    section=Details
>  @two is undocumented

The section containing "@two is undocumented" changes from PLAIN to
DETAILS.  Doc source:

    ##
    # @Enum:
    #
    # @one: The _one_ {and only}, description on the same line
    #
    # Features:
    # @enum-feat: Also _one_ {and only}
    # @enum-member-feat: a member feature
    #
    # @two is undocumented
    ##

It is at the end.  Good.

>  doc symbol=Base
>      body=
> @@ -175,7 +175,7 @@ description starts on the same line
>  a feature
>      feature=cmd-feat2
>  another feature
> -    section=Plain
> +    section=Details
>  .. note:: @arg3 is undocumented

The section containing "@arg3 is undocumented" changes from PLAIN to
DETAILS.  Doc source:

Doc source:

    ##
    # @cmd:
    #
    # @arg1:
    #     description starts on a new line,
    #     indented
    #
    # @arg2: description starts on the same line
    #     remainder indented differently
    #
    # Returns: @Object
    #
    # Errors: some
    #
    # Features:
    # @cmd-feat1: a feature
    # @cmd-feat2: another feature
    #
    # .. note:: @arg3 is undocumented
    #
    # TODO: frobnicate
    #

It is *not* at the end.  Is the commit message inaccurate?

>      section=Returns
>  @Object
> @@ -183,7 +183,7 @@ another feature
>  some
>      section=Todo
>  frobnicate
> -    section=Plain
> +    section=Details
>  .. admonition:: Notes
>  
>   - Lorem ipsum dolor sit amet
    - Ut enim ad minim veniam

    [some section body text elided for brevity...]

   Note::
       Ceci n'est pas une note
       section=Since
   2.10

The section starting with the adminition and ending after "Ceci n'est
pas une note" changes from PLAIN to DETAILS.  Doc source continued:

    # .. admonition:: Notes
    #
    #  - Lorem ipsum dolor sit amet
    #  - Ut enim ad minim veniam
    #
    [same text elided...]
    #
    # Note::
    #     Ceci n'est pas une note
    #
    # Since: 2.10
    ##

It is second-to-last, and the last section is SINCE.  Good.

> @@ -216,7 +216,7 @@ If you're bored enough to read this, go see a video of boxed cats
>  a feature
>      featurec=md-feat2
>  another feature
> -    section=Plain
> +    section=Details
>  .. qmp-example::
>  
>     -> "this example"

This one is also at the end.  Good.


