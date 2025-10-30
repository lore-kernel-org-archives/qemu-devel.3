Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D97CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETEP-0003Ru-Ac; Thu, 30 Oct 2025 10:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vETEL-0003Pl-4I
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vETEB-0002S8-JW
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761832921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=81HW2gZc6DxiHXRSen0iVn++IiUXH8j/g0Xrco8dG/s=;
 b=GHkcg6sCpTIUzAf55A6gp2f/xCT8LayrzIas/L8pGA+itHjvZ0BMFAprFpFQChtIBcOepo
 lxXeUX9FYorm3pzcyqbv/iYlsmYGEkuYG1qLTBTuHxRSbbC3502ZYBnwvNgw1AqfuXqjoq
 HZ2rOqAp2OyFCb09/Cw6dE7Fxh1Z0fM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-eLCukxU4NhGtkJMa7dXy1w-1; Thu,
 30 Oct 2025 10:01:57 -0400
X-MC-Unique: eLCukxU4NhGtkJMa7dXy1w-1
X-Mimecast-MFC-AGG-ID: eLCukxU4NhGtkJMa7dXy1w_1761832916
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 491FA183450E; Thu, 30 Oct 2025 14:01:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AB2019560B6; Thu, 30 Oct 2025 14:01:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CACF121E6A27; Thu, 30 Oct 2025 15:01:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: michael.roth@amd.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3] qapi: Add documentation format validation
In-Reply-To: <20251029173059.378607-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 29 Oct 2025 20:30:59 +0300")
References: <20251029173059.378607-1-vsementsov@yandex-team.ru>
Date: Thu, 30 Oct 2025 15:01:52 +0100
Message-ID: <87ms58fpyn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Add explicit validation for QAPI documentation formatting rules:
>
> 1. Lines must not exceed 70 columns in width (including '# ' prefix)
> 2. Sentences must be separated by two spaces
>
> Example sections are excluded, we don't require them to be <= 70,
> that would be too restrictive.
>
> Example sections share common 80-columns recommendations (not
> requirements).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> Hi all!
>
> This substitutes my previous attempt
>   "[PATCH v2 00/33] qapi: docs: width=70 and two spaces between sentences"
> Supersedes: <20251011140441.297246-1-vsementsov@yandex-team.ru>
>
> v3:
> 01: ignore example sections
> other commits: dropped :)
>
> Of course, this _does not_ build on top of current master. v3 is
> to be based on top of coming soon doc-cleanup series by Markus.

I'll post this today.

>  scripts/qapi/parser.py | 46 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 9fbf80a541..b9d76fff39 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -108,6 +108,9 @@ def __init__(self,
>          self.exprs: List[QAPIExpression] = []
>          self.docs: List[QAPIDoc] = []
>  
> +        # State for tracking qmp-example blocks
> +        self._in_qmp_example = False
> +
>          # Showtime!
>          self._parse()
>  
> @@ -423,12 +426,53 @@ def get_doc_line(self) -> Optional[str]:
>              if self.val != '##':
>                  raise QAPIParseError(
>                      self, "junk after '##' at end of documentation comment")
> +            self._in_qmp_example = False
>              return None
>          if self.val == '#':
>              return ''
>          if self.val[1] != ' ':
>              raise QAPIParseError(self, "missing space after #")
> -        return self.val[2:].rstrip()
> +
> +        line = self.val[2:].rstrip()
> +
> +        if line.startswith('.. qmp-example::'):

This matches how we spell the directive, but ReST appears to accept
additional spaces.  Let's use

    re.match(r'\.\. +qmp-example *::', line)

> +            self._in_qmp_example = True
> +
> +        if not self._in_qmp_example:
> +            self._validate_doc_line_format(line)
> +
> +        return line

self._in_qmp_example is initialized to False at the beginning of a doc
comment block, becomes True at the first '.. qmp-example::' line, then
remains True until the end of the doc comment block.  This isn't quite
right.  Consider qapi/control.json:

    ##
    # @qmp_capabilities:
    #
    # Enable QMP capabilities.
    #
    # @enable: An optional list of `QMPCapability` values to enable.  The
    #     client must not enable any capability that is not mentioned in
    #     the QMP greeting message.  If the field is not provided, it
    #     means no QMP capabilities will be enabled.  (since 2.12)
    #
    # .. qmp-example::
    #
    #     -> { "execute": "qmp_capabilities",
    #          "arguments": { "enable": [ "oob" ] } }
    #     <- { "return": {} }
    #
    # .. note:: This command is valid exactly when first connecting: it
    #    must be issued before any other command will be accepted, and
    #    will fail once the monitor is accepting other commands.  (see
    #    :doc:`/interop/qmp-spec`)
    #
    # .. note:: The QMP client needs to explicitly enable QMP
    #    capabilities, otherwise all the QMP capabilities will be turned
    #    off by default.
    #
    # Since: 0.13
    ##

ReST directives like '.. qmp-example::' and '.. note::' stop at the
first non-blank non-indented line.  We need to change
self._in_qmp_example from True to False at such a line.

> +
> +    def _validate_doc_line_format(self, line: str) -> None:
> +        """
> +        Validate documentation format rules for a single line:
> +        1. Lines should not exceed 70 columns
> +        2. Sentences should be separated by two spaces
> +        """
> +        full_line_length = len(line) + 2  # "# " = 2 characters
> +        if full_line_length > 70:
> +            # Skip URL lines - they can't be broken
> +            stripped_line = line.strip()
> +            if (stripped_line.startswith(('http://', 'https://', 'ftp://')) and
> +                ' ' not in stripped_line):

Avoidable long line:

               if (stripped_line.startswith(('http://', 'https://', 'ftp://'))
                   and ' ' not in stripped_line):

But I'd prefer

               if re.match(r' *(https?|ftp)://[^ ]*$', line):

instead.

> +                pass
> +            else:
> +                raise QAPIParseError(
> +                    self, f"documentation line exceeds 70 columns "
> +                    f"({full_line_length} columns): {line[:50]}..."

The resulting error message is rather long, the meaning of the
parenthesis is not immediately obvious, and quoting the tail of the line
doesn't feel worthwhile.  I think "documentation line exceeds 70
columns" or "documentation line longer than 70 characters" suffices.

> +                )
> +
> +        single_space_pattern = r'[.!?] [A-Z0-9]'

This pattern matches possible sentence ends that lack a second space:
sentence-ending punctuation, single space, capital letter or digit.

The pattern avoids common false positives in the middle of a sentence,
such as "i.e." here:

    # Describes a block export, i.e. how single node should be exported on
                                ~~~~~

Good.  There's still a risk of false positives, though: a capital letter
need not be the start of a sentence, it could also be a proper noun, or
the pronoun "I".  I figure the latter is vanishingly unlikely to occur
in technical documentation.  Example of the former:

    # @format: Extent type (e.g. FLAT or SPARSE)

You filter these out below.

Digits are even more ambiguous than capital letters: they can occur in
the middle of a sentence as much as at the beginning.  Do they occur?

    $ git-grep '\. [0-9]' \*.json
    docs/interop/firmware.json:#                of SMRAM. 48MB should suffice for 4TB of guest-phys

Yes, but only in a QAPI schema we don't actually parse.  We should
probably update these to conform to conventions.  Not today.

Let's keep the digits in the pattern for now.

The pattern misses sentence ends like this one:

    # @children: Information about child block nodes. (since: 10.1)
                                               ~~~~~~~

As far as I can tell, all misses are before "(".  Let's simply add "("
to the pattern: [A-Z0-9(].

> +        for m in list(re.finditer(single_space_pattern, line)):
> +            left = line[0:m.start() + 1]

@left is the line left of the match plus the first character of the
match, i.e. the punctuation character.

> +            # Ignore abbreviations and numbered lists
> +            if left.endswith('e.g.') or re.fullmatch(r' *\d\.', left):
> +                continue

Skip if we matched "e.g. " or a numbered list item.

We saw above why we need the former: "e.g. FLAT".

We need the latter for

    #     1. The guest may be in a catastrophic state or can have
    #        corrupted memory, which cannot be trusted

Whenever I see regexp match followed by string split followed by more
matching, I wonder whether a single match would do.  Here's my try:

        single_space_pattern = r'(\be\.g\.|^ *\d\.|([.!?])) [A-Z0-9(]'
        for m in list(re.finditer(single_space_pattern, line)):
            if not m.group(2):
                continue

This uses a common regexp trick: match exception | ... | (wanted), then
check whether the group containing wanted matched.

> +            raise QAPIParseError(
> +                 self, f"documentation has single space after sentence "
> +                 f"ending. Use two spaces between sentences: "
> +                 f"...{line[m.start()-5:m.end()+5]}..."

Again, the error message is rather long:

    ../qapi/block-core.json:162:1: documentation has single space after sentence ending. Use two spaces between sentences: ...ormat. If e...

The error message consists of two parts: the complaint, and a hint on
how to fix it.

We can separate the two by embedding a newline, like expr.py's
check_keys() does:

            raise QAPIParseError(
                 self,
                 "documentation has single space after sentence ending"
                 "\nUse two spaces between sentences: "
                 f"...{line[m.start(2)-5:m.end(2)+5]}...")

This results in

    ../qapi/block-core.json:162:1: documentation has single space after sentence ending
    Use two spaces between sentences: ...ormat. If e...

Better, but the "...ormat. If e..." part is still odd.

Ideally, the error message location would point right to the trouble
spot, like so:

    ../qapi/block-core.json:162:47: bla bla

Sadly, it points to the beginning of the line instead: "162:1:" instead
"162:47".  This is because the error is reported for the parser's
current position, and the current position is the beginning of the
token, i.e. the '#' starting the comment.

I can offer a disgusting hack:

            # HACK so the error message points to the the offending spot
            self.pos = self.line_pos + 2 + m.start(2) + 1
            raise QAPIParseError(
                 self, "Use two spaces between sentences")

This results in

    ../qapi/block-core.json:162:47: Use two spaces between sentences

Emacs then takes me right to the offending single space.

> +            )
>  
>      @staticmethod
>      def _match_at_name_colon(string: str) -> Optional[Match[str]]:


