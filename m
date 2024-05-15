Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1326C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 11:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7D9k-0005wy-Vb; Wed, 15 May 2024 07:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7D9g-0005uH-BC
 for qemu-devel@nongnu.org; Wed, 15 May 2024 07:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7D9d-0008NN-U3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 07:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715773840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YvQw/C4PEnQpEb7SjxsAudsQ3RUBrDI5u8Povlb5lc=;
 b=afMsshyRjPjUVXfjApIECdwLLWciWSHx3WksPcpoM9uxB3dMBYzys6W5CyZWPiw7GqQ0H/
 g7wv5espfP8hnDLCWPzEhMlZ/pzWt7VtS5oTt2fSctLwgaCF0xj2Seq5pMlY4byfSRcCTG
 NuRfYRXfTnvBakuiiZxPpcCC8RSCD1g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-hUgzguZTNUq9glQL0s9Qlw-1; Wed, 15 May 2024 07:50:29 -0400
X-MC-Unique: hUgzguZTNUq9glQL0s9Qlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59DF88030A5;
 Wed, 15 May 2024 11:50:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C8E2103A3AA;
 Wed, 15 May 2024 11:50:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71CE221E668B; Wed, 15 May 2024 13:50:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Ani
 Sinha <anisinha@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Mads Ynddal
 <mads@ynddal.dk>,  Jason Wang <jasowang@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH 04/20] qapi/parser: preserve indentation in QAPIDoc
 sections
In-Reply-To: <20240514215740.940155-5-jsnow@redhat.com> (John Snow's message
 of "Tue, 14 May 2024 17:57:23 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-5-jsnow@redhat.com>
Date: Wed, 15 May 2024 13:50:26 +0200
Message-ID: <87msorthtp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Prior to this patch, a section like this:
>
> @name: lorem ipsum
>    dolor sit amet
>      consectetur adipiscing elit
>
> would be parsed as:
>
> "lorem ipsum\ndolor sit amet\n  consectetur adipiscing elit"
>
> We want to preserve the indentation for even the first body line so that
> the entire block can be parsed directly as rST. This patch would now
> parse that segment as:
>
> "lorem ipsum\n   dolor sit amet\n     consectetur adipiscing elit"

I'm afraid it's less than clear *why* we want to parse the entire block
directly as rST.  I have just enough insight into what you've built on
top of this series to hazard a guess.  Bear with me while I try to
explain it.

We first parse the doc comment with parser.py into an internal
representation.  The structural parts become objects, and the remainder
becomes text attributes of these objects.  Currently, parser.py
carefully adjusts indentation for these text attributes.  Why?  I'll get
to that.

For your example, parser.py creates an ArgSection object, and sets its
@text member to

    "lorem ipsum\ndolor sit amet\n  consectetur adipiscing elit"

Printing this string gives us

    lorem ipsum
    dolor sit amet
      consectetur adipiscing elit

qapidoc.py then transforms parser.py's IR into Sphinx IR.  The objects
become (more complicated) Sphinx objects, and their text attributes get
re-parsed as rST text into still more Sphinx objects.

This re-parse rejects your example with "Unexpected indentation."

Let me use a slightly different one:

    # @name: lorem ipsum
    #    dolor sit amet
    #    consectetur adipiscing elit

Results in this @text member

    lorem ipsum
    dolor sit amet
    consectetur adipiscing elit

which is re-parsed as paragraph, i.e. exactly what we want.

> This understandably breaks qapidoc.py;

Without indentation adjustment, we'd get

    lorem ipsum
       dolor sit amet
       consectetur adipiscing elit

which would be re-parsed as a definition list, I guess.  This isn't what
we want.

>                                        so a new function is added there
> to re-dedent the text.

Your patch moves the indentation adjustment to another place.  No
functional change.

You move it so you can branch off your new rendering pipeline before the
indentation adjustment, because ...

>                        Once the new generator is merged, this function
> will not be needed any longer and can be dropped.

... yours doesn't want it.

I believe it doesn't want it, because it generates rST (with a QAPI
extension) instead of Sphinx objects.  For your example, something like

    :arg name: lorem ipsum
       dolor sit amet
         consectetur adipiscing elit

For mine:

    :arg name: lorem ipsum
       dolor sit amet
       consectetur adipiscing elit

Fair?

The transition from the doc comment to (extended) rST is straightforward
for these examples.

I hope it'll be as straightforward (and thus predictable) in other
cases, too.

> (I verified this patch changes absolutely nothing by comparing the
> md5sums of the QMP ref html pages both before and after the change, so
> it's certified inert. QAPI test output has been updated to reflect the
> new strategy of preserving indents for rST.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py         | 36 +++++++++++++++++++++++++++++-----
>  scripts/qapi/parser.py         |  8 ++++++--
>  tests/qapi-schema/doc-good.out | 32 +++++++++++++++---------------
>  3 files changed, 53 insertions(+), 23 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 1655682d4c7..2e3ffcbafb7 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -26,6 +26,7 @@
>  
>  import os
>  import re
> +import textwrap
>  
>  from docutils import nodes
>  from docutils.parsers.rst import Directive, directives
> @@ -51,6 +52,28 @@
>  __version__ = "1.0"
>  
>  
> +def dedent(text: str) -> str:
> +    # Temporary: In service of the new QAPI domain, the QAPI doc parser
> +    # now preserves indents in args/members/features text. QAPIDoc does
> +    # not handle this well, so undo that change here.
> +
> +    # QAPIDoc is being rewritten and will be replaced soon,
> +    # but this function is here in the interim as transition glue.

I'm not sure we need the comment.

> +
> +    lines = text.splitlines(True)
> +    if len(lines) > 1:
> +        if re.match(r"\s+", lines[0]):
> +            # First line is indented; description started on
> +            # the line after the name. dedent the whole block.
> +            return textwrap.dedent(text)
> +        else:

pylint gripes

    docs/sphinx/qapidoc.py:65:8: R1705: Unnecessary "else" after "return", remove the "else" and de-indent the code inside it (no-else-return)

> +            # Descr started on same line. Dedent line 2+.
> +            return lines[0] + textwrap.dedent("".join(lines[1:]))
> +    else:
> +        # Descr was a single line; dedent entire line.
> +        return textwrap.dedent(text)
> +
> +
>  # fmt: off
>  # Function borrowed from pydash, which is under the MIT license
>  def intersperse(iterable, separator):
> @@ -169,7 +192,7 @@ def _nodes_for_members(self, doc, what, base=None, branches=None):
>              term = self._nodes_for_one_member(section.member)
>              # TODO drop fallbacks when undocumented members are outlawed
>              if section.text:
> -                defn = section.text
> +                defn = dedent(section.text)
>              else:
>                  defn = [nodes.Text('Not documented')]
>  
> @@ -207,7 +230,7 @@ def _nodes_for_enum_values(self, doc):
>                  termtext.extend(self._nodes_for_ifcond(section.member.ifcond))
>              # TODO drop fallbacks when undocumented members are outlawed
>              if section.text:
> -                defn = section.text
> +                defn = dedent(section.text)
>              else:
>                  defn = [nodes.Text('Not documented')]
>  
> @@ -242,7 +265,7 @@ def _nodes_for_features(self, doc):
>          dlnode = nodes.definition_list()
>          for section in doc.features.values():
>              dlnode += self._make_dlitem(
> -                [nodes.literal('', section.member.name)], section.text)
> +                [nodes.literal('', section.member.name)], dedent(section.text))
>              seen_item = True
>  
>          if not seen_item:
> @@ -265,9 +288,12 @@ def _nodes_for_sections(self, doc):
>                  continue
>              snode = self._make_section(section.tag)
>              if section.tag and section.tag.startswith('Example'):
> -                snode += self._nodes_for_example(section.text)
> +                snode += self._nodes_for_example(dedent(section.text))
>              else:
> -                self._parse_text_into_node(section.text, snode)
> +                self._parse_text_into_node(
> +                    dedent(section.text) if section.tag else section.text,
> +                    snode,
> +                )
>              nodelist.append(snode)
>          return nodelist
>  
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 7b13a583ac1..8cdd5334ec6 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -448,7 +448,10 @@ def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
>          indent = must_match(r'\s*', line).end()
>          if not indent:
>              return line
> -        doc.append_line(line[indent:])
> +
> +        # Preserve the indent, it's needed for rST formatting.

I'm not sure we need the comment.

> +        doc.append_line(line)
> +
>          prev_line_blank = False
>          while True:
>              self.accept(False)
> @@ -465,7 +468,8 @@ def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
>                      self,
>                      "unexpected de-indent (expected at least %d spaces)" %
>                      indent)
> -            doc.append_line(line[indent:])
> +            # Again, preserve the indent for ReST.

Likewise.

If you want to document the fact that .get_doc_indented() preserves
indentation, a function comment or doc string would the proper place.

> +            doc.append_line(line)
>              prev_line_blank = True
>  
>      def get_doc_paragraph(self, doc: 'QAPIDoc') -> Optional[str]:

Correctness argument:

0. This patch merely moves an indentation adjustment from parser.py to
   qapidoc.py.

   Checks out: you remove indentation adjustment in parser.py, add it in
   qapidoc.py, and that's it.

1. The new indentation adjuster in qapidoc.py behaves just like the old
   one in parser.py did.

   parser.py's .get_doc_indented() is used to parse what follows certain
   sections' first line.  It's users store the text on this first line,
   if any, with leading whitespace stripped, then call
   .get_doc_indented() to eat the section's remaining lines.  All
   non-blank lines eaten must be indented at least as much as the first
   non-blank line.  .get_doc_indented() appends the lines eaten to the
   stored text with the first non-blank line's indentation stripped from
   all the non-blank lines.

   Your patch drops this stripping of indentation from non-first lines.
   This is what must now be done in qapidoc.py.

   If the section's first line has no text, the first non-blank line's
   indentation must be stripped from all non-blank lines.

   If the section's first line has text, the next non-blank line's
   indentation must be stripped from all lines but the first.

   How can qapidoc.py detect whether the section's first line has text?
   Fortunately, such a line will be unindented, i.e. start with a
   non-blank character, and all remaining lines will be blank or
   indented.

   qapidoc.py's dedent() seems to remove indentation common to all
   non-blank lines.  Except when there are multiple lines, and the first
   one is not indented, it removes common indentation from the remaining
   lines.

   Common indentation works, because all lines are indented at least as
   much as the one whose indentation we want to remove.

   The conditional doesn't quite match the "if the section's first line"
   above.  This simpler dedent() does, and also works in my testing:

def dedent(text: str) -> str:
    lines = text.splitlines(True)
    if re.match(r"\s+", lines[0]):
        # First line is indented; description started on
        # the line after the name. dedent the whole block.
        return textwrap.dedent(text)
    # Descr started on same line. Dedent line 2+.
    return lines[0] + textwrap.dedent("".join(lines[1:]))

   What do you think?

2. The new one is applied exactly when the old one was.

   The old one is applied to the sections starting with @FOO: and the
   tagged sections (Returns:, Errors:, ...).

   The new one is applied in ._nodes_for_members(),
   ._nodes_for_enum_values(), _nodes_for_features(), and
   ._nodes_for_sections().

   It is not applied to the text of untagged sections, including the
   body section.

   Good.

> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 716a9a41026..435f6e6d768 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -117,8 +117,8 @@ doc symbol=Base
>      body=
>  
>      arg=base1
> -description starts on a new line,
> -minimally indented
> + description starts on a new line,
> + minimally indented
>  doc symbol=Variant1
>      body=
>  A paragraph
> @@ -145,8 +145,8 @@ doc symbol=Alternate
>  
>      arg=i
>  description starts on the same line
> -remainder indented the same
> -@b is undocumented
> +    remainder indented the same
> +    @b is undocumented
>      arg=b
>  
>      feature=alt-feat
> @@ -158,11 +158,11 @@ doc symbol=cmd
>      body=
>  
>      arg=arg1
> -description starts on a new line,
> -indented
> +    description starts on a new line,
> +    indented
>      arg=arg2
>  description starts on the same line
> -remainder indented differently
> +    remainder indented differently
>      arg=arg3
>  
>      feature=cmd-feat1
> @@ -178,16 +178,16 @@ some
>      section=TODO
>  frobnicate
>      section=Notes
> -- Lorem ipsum dolor sit amet
> -- Ut enim ad minim veniam
> + - Lorem ipsum dolor sit amet
> + - Ut enim ad minim veniam
>  
> -Duis aute irure dolor
> + Duis aute irure dolor
>      section=Example
> --> in
> -<- out
> + -> in
> + <- out
>      section=Examples
> -- *verbatim*
> -- {braces}
> + - *verbatim*
> + - {braces}
>      section=Since
>  2.10
>  doc symbol=cmd-boxed
> @@ -198,9 +198,9 @@ a feature
>      feature=cmd-feat2
>  another feature
>      section=Example
> --> in
> + -> in
>  
> -<- out
> + <- out
>  doc symbol=EVT_BOXED
>      body=

The indentation change is nicely visible here.


