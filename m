Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D455FFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrvY-0002ih-IR; Mon, 04 May 2026 07:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJrvX-0002iR-3E
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJrvV-0006xN-4A
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777895848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vg4NTO936wLHfdT06QcNUqlKni6goV2wgASRmpFjn3w=;
 b=dEb1q2kjq5HaCy6bVnawhk0WYIMGLAF4oTVfTk33UaCT36yX/71hooRp/bUW513pOhIQAO
 X6kFnoeIaXjZ5/znLdxXvlikWkgRfR9uqmOfhKEnv5FoRwQ1p2CZoelxgjlv/YSM54v8m6
 KSLYx++6Wy9ANReb9VPnk7zYRLdaxZI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-2B4AgHoNNZyRxlAG4BPYFg-1; Mon,
 04 May 2026 07:57:25 -0400
X-MC-Unique: 2B4AgHoNNZyRxlAG4BPYFg-1
X-Mimecast-MFC-AGG-ID: 2B4AgHoNNZyRxlAG4BPYFg_1777895844
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42BCF1956064; Mon,  4 May 2026 11:57:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88DCA30001A1; Mon,  4 May 2026 11:57:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2720D21E6A01; Mon, 04 May 2026 13:57:21 +0200 (CEST)
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 07/13] qapi/docs: add "Intro" section parsing
In-Reply-To: <20260429192611.1581223-8-jsnow@redhat.com> (John Snow's message
 of "Wed, 29 Apr 2026 15:26:05 -0400")
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-8-jsnow@redhat.com>
Date: Mon, 04 May 2026 13:57:21 +0200
Message-ID: <875x539yla.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Add parsing for explicit Intro section syntax.
>
> A side effect of this patch is that we will always create an empty Intro
> section, similar to how we used to have an empty Plain section. The
> tests are adjusted accordingly, rendered document output does not change
> at all.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst            | 17 +++++----
>  scripts/qapi/parser.py                  | 47 ++++++++++++++++++-------
>  tests/qapi-schema/doc-good.out          | 18 ++++++++++
>  tests/qapi-schema/doc-missing-colon.err |  2 +-
>  4 files changed, 64 insertions(+), 20 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 3a632b4a648..a8175934d52 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -862,7 +862,7 @@ documentation comment.
>  If the documentation comment starts like ::
>  
>      ##
> -    # @SYMBOL:
> +    # @SYMBOL: [...]
>  
>  it documents the definition of SYMBOL, else it's free-form
>  documentation.
> @@ -984,11 +984,11 @@ definition it documents.
>  When documentation is required (see pragma_ 'doc-required'), every
>  definition must have documentation.
>  
> -Definition documentation starts with a line naming the definition,
> -followed by an optional overview, a description of each argument (for
> -commands and events), member (for structs and unions), branch (for
> -alternates), or value (for enums), a description of each feature (if
> -any), and finally optional tagged sections.
> +Definition documentation starts with a description naming the definition
> +with an optional overview, a description of each argument (for commands
> +and events), member (for structs and unions), branch (for alternates),
> +or value (for enums), a description of each feature (if any), and
> +finally optional tagged sections.
>  
>  Descriptions start with '\@name:'.  The description text must be
>  indented like this::
> @@ -996,6 +996,11 @@ indented like this::
>   # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
>   #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
>  
> +Definition descriptions are special: the optional introductory overview
> +describing the definition will not be inlined when referenced by other
> +definitions (such as when using 'base' to include members from another
> +definition), while other descriptions and tagged sections will be.
> +

Isn't this premature?  We're not inlining anything just yet.

>  .. FIXME The parser accepts these things in almost any order.
>  
>  .. FIXME union branches should be described, too.
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 6612f471bb8..c23fd26aaa7 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -24,6 +24,7 @@
>      Match,
>      Optional,
>      Set,
> +    Tuple,
>      Union,
>  )
>  
> @@ -524,6 +525,30 @@ def get_doc_paragraph(self, doc: 'QAPIDoc') -> Optional[str]:
>                  return line
>              doc.append_line(line)
>  
> +    def _get_doc_intro(
> +        self,
> +        line: str,
> +        info: QAPISourceInfo
> +    ) -> Tuple['QAPIDoc', Optional[str]]:
> +        match = self._match_at_name_colon(line)
> +        if not match:
> +            raise QAPIParseError(self, "@name must end with ':'")
> +
> +        # Invalid names are not checked here, but the name
> +        # provided *must* match the following definition,
> +        # which *is* validated in expr.py.
> +        symbol = match.group(1)
> +        if not symbol:
> +            raise QAPIParseError(self, "name required after '@'")
> +        doc = QAPIDoc(info, symbol)
> +

Drop the blank line.  For what it's worth, you do it already in PATCH
13.

> +        doc.ensure_untagged_section(info, QAPIDoc.Kind.INTRO)

Hmm.

.ensure_untagged_section() extends the current section if we have one
and it is of kind .INTRO, else creates a new one of kind .INTRO.

But there is no current section here!  Why not simply create one?

> +        text = line[match.end():]
> +        if text:
> +            doc.append_line(text)
> +
> +        return doc, self.get_doc_indented(doc)
> +
>      def get_doc(self) -> 'QAPIDoc':
>          if self.val != '##':
>              raise QAPIParseError(
> @@ -532,18 +557,9 @@ def get_doc(self) -> 'QAPIDoc':
>          self.accept(False)
>          line = self.get_doc_line()
>          if line is not None and line.startswith('@'):
> +

Drop the blank line, please.

>              # Definition documentation
> -            if not line.endswith(':'):
> -                raise QAPIParseError(self, "line should end with ':'")
> -            # Invalid names are not checked here, but the name
> -            # provided *must* match the following definition,
> -            # which *is* validated in expr.py.
> -            symbol = line[1:-1]
> -            if not symbol:
> -                raise QAPIParseError(self, "name required after '@'")
> -            doc = QAPIDoc(info, symbol)
> -            self.accept(False)
> -            line = self.get_doc_line()
> +            doc, line = self._get_doc_intro(line, info)
>              no_more_args = False
>  
>              while line is not None:
> @@ -751,8 +767,13 @@ def end(self) -> None:
>                  raise QAPISemError(
>                      section.info, "text required after '%s:'" % section.kind)
>  
> -    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> -        kind = QAPIDoc.Kind.PLAIN
> +    def ensure_untagged_section(
> +        self,
> +        info: QAPISourceInfo,
> +        kind: Optional['QAPIDoc.Kind'] = None,

Why not = QAPIDoc.Kind.PLAIN here, so ...

> +    ) -> None:
> +        if kind is None:
> +            kind = QAPIDoc.Kind.PLAIN

... you don't need this?

>  
>          if self.all_sections and self.all_sections[-1].kind == kind:
>              # extend current section

Hmm.

QAPIDoc.ensure_untagged_section() extends the current section if we have
one and it's "untagged", else creates a new "untagged" section.

In the beginning, there was just one kind of "untagged" section.  Its
encoding eventually became "Section.kind is QAPIDoc.Kind.PLAIN".  So
what the function does was clear enough.

This patch adds a second kind: QAPIDoc.Kind.INTRO.
.ensure_untagged_section() now takes a kind argument.  It ensures *that*
kind of section.

I think the function name becomes misleading.  It can now ensure *any*
kind of section, not just "untagged".

Rename to ensure_section() and make the @kind argument mandatory?

> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 6fcc8175cfe..bc89853765f 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -106,6 +106,8 @@ Examples:
>  - *verbatim*
>  - {braces}
>  doc symbol=Enum
> +    section=Intro
> +
>      arg=one
>  The _one_ {and only}, description on the same line
>      arg=two
> @@ -117,10 +119,14 @@ a member feature
>      section=Plain
>  @two is undocumented
>  doc symbol=Base
> +    section=Intro
> +
>      arg=base1
>   description starts on a new line,
>   minimally indented
>  doc symbol=Variant1
> +    section=Intro
> +
>      section=Plain
>  A paragraph
>  
> @@ -134,10 +140,16 @@ a feature
>      feature=member-feat
>  a member feature
>  doc symbol=Variant2
> +    section=Intro
> +
>  doc symbol=Object
> +    section=Intro
> +
>      feature=union-feat1
>  a feature
>  doc symbol=Alternate
> +    section=Intro
> +
>      arg=i
>  description starts on the same line
>      remainder indented the same
> @@ -151,6 +163,8 @@ doc freeform
>  Another subsection
>  ==================
>  doc symbol=cmd
> +    section=Intro
> +
>      arg=arg1
>      description starts on a new line,
>      indented
> @@ -198,6 +212,8 @@ Note::
>      section=Since
>  2.10
>  doc symbol=cmd-boxed
> +    section=Intro
> +
>      section=Plain
>  If you're bored enough to read this, go see a video of boxed cats
>      feature=cmd-feat1
> @@ -211,5 +227,7 @@ another feature
>  
>     <- ... has no title ...
>  doc symbol=EVT_BOXED
> +    section=Intro
> +
>      feature=feat3
>  a feature
> diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schema/doc-missing-colon.err
> index cbcea007153..bd5862b30f3 100644
> --- a/tests/qapi-schema/doc-missing-colon.err
> +++ b/tests/qapi-schema/doc-missing-colon.err
> @@ -1 +1 @@
> -doc-missing-colon.json:4:1: line should end with ':'
> +doc-missing-colon.json:4:1: @name must end with ':'

Let's not change this error message in this patch.  For what it's worth,
PATCH 13 changes it right back.


