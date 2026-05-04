Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1AFCD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 09:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJpwn-0006iQ-To; Mon, 04 May 2026 05:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJpwl-0006iE-8Z
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJpwj-0002Wg-LZ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777888236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gtnPxqJTx0Ke5jCFVlBpf/Tf36x5rqwpEnXbQbv8buY=;
 b=SQQrbDcZYky2pivC7V9zo9eF1u0Itq7fUPSskoRBU1GzOHtIuZtatsYZp5yE4YbXd2dUxl
 tlYnCt2k6IRNklmUSBRtiWl129kCaSFvAtJBA+uq7YpMatKiKZ/BbL/QdiL4k4jq2T4zh/
 fBXKegofR67qWwi1QrijWaQU/C6tZWw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-grW38DUiMCCtEXfBvMsHNw-1; Mon,
 04 May 2026 05:50:33 -0400
X-MC-Unique: grW38DUiMCCtEXfBvMsHNw-1
X-Mimecast-MFC-AGG-ID: grW38DUiMCCtEXfBvMsHNw_1777888231
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38C66195608B; Mon,  4 May 2026 09:50:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5325B1800357; Mon,  4 May 2026 09:50:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BE2721E6A01; Mon, 04 May 2026 11:50:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 01/13] tests/qapi: generate output in source order
In-Reply-To: <20260429192611.1581223-2-jsnow@redhat.com> (John Snow's message
 of "Wed, 29 Apr 2026 15:25:59 -0400")
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-2-jsnow@redhat.com>
Date: Mon, 04 May 2026 11:50:28 +0200
Message-ID: <87lddzbj17.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Rewrite the test doc generator to produce output in source order instead
> of arbitrarily by section name.

Yes, please!  Looks like leftovers from commit 8d789c8cdb8 (docs/sphinx:
remove legacy QAPI manual generator).
>
> This patch removes our last use of the "body" field, which has an effect
> on how the first plaintext section of each test documented is printed:

What do you mean by "test documented"?  The sentence makes sense to me
if I drop "documented".

> we now print "section=Plain" followed by the section text instead of
> "body=[...]".
>
> This patch is motivated by a desire to move the QAPIDoc API away from
> named fields for specific sections in a bid to force all users to simply
> iterate through all_sections in order, instead - and to remove the named
> subsections.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qapi-schema/doc-good.out | 26 +++++++++++++-------------
>  tests/qapi-schema/test-qapi.py | 15 ++++++++-------
>  2 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 04a55072646..e2be6f96bbf 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -54,15 +54,15 @@ event EVT_BOXED Object
>      boxed=True
>      feature feat3
>  doc freeform
> -    body=
> +    section=Plain
>  *******
>  Section
>  *******
>  doc freeform
> -    body=
> +    section=Plain
>  Just text, no heading.
>  doc freeform
> -    body=
> +    section=Plain
>  Subsection
>  ==========
>  
> @@ -106,7 +106,7 @@ Examples:
>  - *verbatim*
>  - {braces}
>  doc symbol=Enum
> -    body=
> +    section=Plain
>  
>      arg=one
>  The _one_ {and only}, description on the same line
> @@ -119,13 +119,13 @@ a member feature
>      section=Plain
>  @two is undocumented
>  doc symbol=Base
> -    body=
> +    section=Plain
>  
>      arg=base1
>   description starts on a new line,
>   minimally indented
>  doc symbol=Variant1
> -    body=
> +    section=Plain
>  A paragraph
>  
>  Another paragraph
> @@ -138,15 +138,15 @@ a feature
>      feature=member-feat
>  a member feature
>  doc symbol=Variant2
> -    body=
> +    section=Plain
>  
>  doc symbol=Object
> -    body=
> +    section=Plain
>  
>      feature=union-feat1
>  a feature
>  doc symbol=Alternate
> -    body=
> +    section=Plain
>  
>      arg=i
>  description starts on the same line
> @@ -157,11 +157,11 @@ description starts on the same line
>      feature=alt-feat
>  a feature
>  doc freeform
> -    body=
> +    section=Plain
>  Another subsection
>  ==================
>  doc symbol=cmd
> -    body=
> +    section=Plain
>  
>      arg=arg1
>      description starts on a new line,
> @@ -210,7 +210,7 @@ Note::
>      section=Since
>  2.10
>  doc symbol=cmd-boxed
> -    body=
> +    section=Plain
>  If you're bored enough to read this, go see a video of boxed cats
>      feature=cmd-feat1
>  a feature
> @@ -223,7 +223,7 @@ another feature
>  
>     <- ... has no title ...
>  doc symbol=EVT_BOXED
> -    body=
> +    section=Plain
>  
>      feature=feat3
>  a feature
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
> index cf7fb8a6df5..27885147b4d 100755
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -19,6 +19,7 @@
>  from io import StringIO
>  
>  from qapi.error import QAPIError
> +from qapi.parser import QAPIDoc
>  from qapi.schema import QAPISchema, QAPISchemaVisitor
>  
>  
> @@ -116,13 +117,13 @@ def test_frontend(fname):
>              print('doc symbol=%s' % doc.symbol)
>          else:
>              print('doc freeform')
> -        print('    body=\n%s' % doc.body.text)
> -        for arg, section in doc.args.items():
> -            print('    arg=%s\n%s' % (arg, section.text))
> -        for feat, section in doc.features.items():
> -            print('    feature=%s\n%s' % (feat, section.text))
> -        for section in doc.sections:
> -            print('    section=%s\n%s' % (section.kind, section.text))
> +        for section in doc.all_sections:
> +            if section.kind == QAPIDoc.Kind.MEMBER:
> +                print('    arg=%s\n%s' % (section.name, section.text))
> +            elif section.kind == QAPIDoc.Kind.FEATURE:
> +                print('    feature=%s\n%s' % (section.name, section.text))
> +            else:
> +                print('    section=%s\n%s' % (section.kind, section.text))
>  
>  
>  def open_test_result(dir_name, file_name, update):

The loop body could be dumbed down further:

               if isinstance(section, QAPIDoc.ArgSection):
                   print('    %s=%s' % (section.kind, section.name))
               else:
                   print('    %s' % section.kind)
               print(section.text)

Expected output changes a bit more then.  I don't mind.


