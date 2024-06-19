Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76125C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 12:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJu2O-00047K-BQ; Wed, 19 Jun 2024 08:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJu2M-00044n-BR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJu2K-0008UP-Do
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718798614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5nubeqjkg+iQie1bg106h5b3LAFLV+qnnUeg5mB7c0=;
 b=dhem1EPG94EsyXf/8O47UHCr9kwDU2kt+AINe8TFTdYsX7YMrK0e6Db+ntRxjZV+tKlrYK
 1sxsESqqt/7TGDtun7dHd/TkMOEBvpz6voIbUrxlniExkn2nDybQGO4qYXD1uY3zilFTjU
 zx3Js5mn+q0Ow5KOR70w8ed/7ydPojs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-bdkIpipRMxGJ94W3q_mE2g-1; Wed,
 19 Jun 2024 08:03:31 -0400
X-MC-Unique: bdkIpipRMxGJ94W3q_mE2g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE8F41956074; Wed, 19 Jun 2024 12:03:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EE3219560B4; Wed, 19 Jun 2024 12:03:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C0B421E6687; Wed, 19 Jun 2024 14:03:20 +0200 (CEST)
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
Subject: Re: [PATCH 04/13] qapi/parser: preserve indentation in QAPIDoc
 sections
In-Reply-To: <20240619003012.1753577-5-jsnow@redhat.com> (John Snow's message
 of "Tue, 18 Jun 2024 20:30:03 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-5-jsnow@redhat.com>
Date: Wed, 19 Jun 2024 14:03:20 +0200
Message-ID: <878qz12l87.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

> Change get_doc_indented() to preserve indentation on all subsequent text
> lines, and create a compatibility dedent() function for qapidoc.py to
> remove that indentation. This is being done for the benefit of a new

Suggest "remove indentation the same way get_doc_indented() did."

> qapidoc generator which requires that indentation in argument and
> features sections are preserved.
>
> Prior to this patch, a section like this:
>
> ```
> @name: lorem ipsum
>    dolor sit amet
>      consectetur adipiscing elit
> ```
>
> would have its body text be parsed as:

Suggest "parsed into".

> (first and final newline only for presentation)
>
> ```
> lorem ipsum
> dolor sit amet
>   consectetur adipiscing elit
> ```
>
> We want to preserve the indentation for even the first body line so that
> the entire block can be parsed directly as rST. This patch would now
> parse that segment as:

If you change "parsed as" to "parsed into" above, then do it here, too.

>
> ```
> lorem ipsum
>    dolor sit amet
>      consectetur adipiscing elit
> ```
>
> This is helpful for formatting arguments and features as field lists in
> rST, where the new generator will format this information as:
>
> ```
> :arg type name: lorem ipsum
>    dolor sit amet
>      consectetur apidiscing elit
> ```
>
> ...and can be formed by the simple concatenation of the field list
> construct and the body text. The indents help preserve the continuation
> of a block-level element, and further allow the use of additional rST
> block-level constructs such as code blocks, lists, and other such
> markup. Avoiding reflowing the text conditionally also helps preserve
> source line context for better rST error reporting from sphinx through
> generated source, too.

What do you mean by "reflowing"?

> This understandably breaks the existing qapidoc.py; so a new function is
> added there to dedent the text for compatibility. Once the new generator
> is merged, this function will not be needed any longer and can be
> dropped.
>
> I verified this patch changes absolutely nothing by comparing the
> md5sums of the QMP ref html pages both before and after the change, so
> it's certified inert. QAPI test output has been updated to reflect the
> new strategy of preserving indents for rST.

I think the remainder is unnecessary detail.  Drop?

> before:
>
> 69cde3d6f18b0f324badbb447d4381ce  manual_before/interop/qemu-ga-ref.html
> 446e9381833def2adc779f1b90f2215f  manual_before/interop/qemu-qmp-ref.html
> df0ad6c26cb4c28b85d663fe44609c12  manual_before/interop/qemu-storage-daemon-qmp-ref.html
>
> after:
>
> 69cde3d6f18b0f324badbb447d4381ce  manual/interop/qemu-ga-ref.html
> 446e9381833def2adc779f1b90f2215f  manual/interop/qemu-qmp-ref.html
> df0ad6c26cb4c28b85d663fe44609c12  manual/interop/qemu-storage-daemon-qmp-ref.html
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py         | 29 ++++++++++++++++++++++++-----
>  scripts/qapi/parser.py         |  5 +++--
>  tests/qapi-schema/doc-good.out | 32 ++++++++++++++++----------------
>  3 files changed, 43 insertions(+), 23 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index e675966defa..f2f2005dd5f 100644
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
> @@ -53,6 +54,21 @@
>  __version__ = "1.0"
>  
>  
> +def dedent(text: str) -> str:
> +    # Temporary: In service of the new QAPI Sphinx domain, the QAPI doc
> +    # parser now preserves indents in args/members/features text.
> +    # QAPIDoc does not handle this well, so undo that change here.

A comment should explain how things are.  This one explains how things
have changed.  Suggest:

       # Adjust indentation to make description text parse as paragraph.

If we planned to keep this, we might want to explain in more detail, as
I did in review of v1.  But we don't.

> +
> +    lines = text.splitlines(True)
> +    if re.match(r"\s+", lines[0]):
> +        # First line is indented; description started on the line after
> +        # the name. dedent the whole block.
> +        return textwrap.dedent(text)
> +
> +    # Descr started on same line. Dedent line 2+.
> +    return lines[0] + textwrap.dedent("".join(lines[1:]))
> +
> +
>  # Disable black auto-formatter until re-enabled:
>  # fmt: off
>  
> @@ -176,7 +192,7 @@ def _nodes_for_members(self, doc, what, base=None, branches=None):
>              term = self._nodes_for_one_member(section.member)
>              # TODO drop fallbacks when undocumented members are outlawed
>              if section.text:
> -                defn = section.text
> +                defn = dedent(section.text)
>              else:
>                  defn = [nodes.Text('Not documented')]
>  
> @@ -214,7 +230,7 @@ def _nodes_for_enum_values(self, doc):
>                  termtext.extend(self._nodes_for_ifcond(section.member.ifcond))
>              # TODO drop fallbacks when undocumented members are outlawed
>              if section.text:
> -                defn = section.text
> +                defn = dedent(section.text)
>              else:
>                  defn = [nodes.Text('Not documented')]
>  
> @@ -249,7 +265,7 @@ def _nodes_for_features(self, doc):
>          dlnode = nodes.definition_list()
>          for section in doc.features.values():
>              dlnode += self._make_dlitem(
> -                [nodes.literal('', section.member.name)], section.text)
> +                [nodes.literal('', section.member.name)], dedent(section.text))
>              seen_item = True
>  
>          if not seen_item:
> @@ -272,9 +288,12 @@ def _nodes_for_sections(self, doc):
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
> index 7b13a583ac1..43167ef0ab3 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -437,6 +437,7 @@ def _match_at_name_colon(string: str) -> Optional[Match[str]]:
>          return re.match(r'@([^:]*): *', string)
>  
>      def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
> +        """get_doc_indented preserves indentation for later rST parsing."""

A proper function comment explains what the function does.  This one
merely points out one minor aspect.  Easy fix: delete it.  Alternative
fix: write a proper function comment.

>          self.accept(False)
>          line = self.get_doc_line()
>          while line == '':

[...]

Just commit message and doc nitpicks, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>


