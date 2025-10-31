Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9813CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErf1-0005gw-JK; Fri, 31 Oct 2025 12:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vErf0-0005ge-5L
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEres-0007cV-1X
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761926834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeTqUdaKdQrBcljpwLINjnNGrBy9auTaME3fmMdCZ2M=;
 b=Toig6mttuMA7Wmxvfg/jIamDHZwdW2wCoSG2fhZwrKYB9IO1mEJIk9uI/ixZTtvyqNePp5
 nTcKs7Hg6zAucBqLJrJbrDdD1i84Hn4lfSzLZ32V8KDNg4JxxvO4/V/g5cGziTBlaJS5/O
 FqjKlWxDEeZRN6p27Ap7+wYCPI0yk4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-6206OdsSO3uw1r6nxDcJDg-1; Fri,
 31 Oct 2025 12:07:10 -0400
X-MC-Unique: 6206OdsSO3uw1r6nxDcJDg-1
X-Mimecast-MFC-AGG-ID: 6206OdsSO3uw1r6nxDcJDg_1761926829
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFD3E19560A1; Fri, 31 Oct 2025 16:07:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAFF918004D4; Fri, 31 Oct 2025 16:07:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E75221E6A27; Fri, 31 Oct 2025 17:07:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: michael.roth@amd.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4] qapi: Add documentation format validation
In-Reply-To: <20251031115517.79032-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Oct 2025 14:55:17 +0300")
References: <20251031115517.79032-1-vsementsov@yandex-team.ru>
Date: Fri, 31 Oct 2025 17:07:05 +0100
Message-ID: <874irf5a3a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> Example sections and literal :: blocks (seldom case) are excluded, we
> don't require them to be <= 70, that would be too restrictive. Anyway,
> they share common 80-columns recommendations (not requirements).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> Hi all!
>
> v4: apply suggestions by Markus:
>  - smart regexps
>  - simpler error messages
>  - hack to move cursor at the place of error
>  - support :: blocks
>
> This is based on
> [PATCH 0/8] A QAPI schema doc markup fix, and style cleanup
> Based-on: <20251031094751.2817932-1-armbru@redhat.com>
>
>  scripts/qapi/parser.py | 44 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 9fbf80a541..2c244a3608 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -108,6 +108,10 @@ def __init__(self,
>          self.exprs: List[QAPIExpression] = []
>          self.docs: List[QAPIDoc] = []
>  
> +        # State for tracking qmp-example blocks and simple
> +        # :: literal blocks.
> +        self._literal_mode = False
> +
>          # Showtime!
>          self._parse()
>  
> @@ -423,12 +427,50 @@ def get_doc_line(self) -> Optional[str]:
>              if self.val != '##':
>                  raise QAPIParseError(
>                      self, "junk after '##' at end of documentation comment")
> +            self._literal_mode = False
>              return None
>          if self.val == '#':
>              return ''
>          if self.val[1] != ' ':
>              raise QAPIParseError(self, "missing space after #")
> -        return self.val[2:].rstrip()
> +
> +        line = self.val[2:].rstrip()
> +
> +        if re.match(r'(\.\. +qmp-example)? *::$', line):
> +            self._literal_mode = True

This doesn't match the contracted form of literal blocks

    lorem ipsum ::
        dolor sit amet

We don't use this form right now.  We can worry about matching it when
we do.

> +        elif self._literal_mode and line and not line.startswith(' '):
> +            # ReST directives stop at first non-blank non-indented line
> +            self._literal_mode = False

This can miss the end of the literal block when the line with '::' is
indented.  To reproduce ...

> +
> +        if not self._literal_mode:
> +            self._validate_doc_line_format(line)

... tack a debug print here

           else:
               print('@@@', line)

and run

    $ pyvenv/bin/python3 /work/armbru/qemu/scripts/qapi-gen.py -o docs/qapi-firmware/ ../docs/interop/firmware.json

Relevant part of input:

    # @executable: Identifies the firmware executable.  The @mode
    #     indicates whether there will be an associated NVRAM template
    #     present.  The preferred corresponding QEMU command line options
    #     are
    #
    #     ::
    #
    #         -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
    #         -machine pflash0=pflash0
    #
    #     or equivalent -blockdev instead of -drive.  When @mode is
    #     @combined the executable must be cloned before use and
    #     configured with readonly=off.  With QEMU versions older than
    #     4.0, you have to use
    #
    #     ::
    #
    #         -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
    #

Relevant part of output:

    @@@     ::
    @@@         -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
    @@@         -machine pflash0=pflash0
    @@@     or equivalent -blockdev instead of -drive.  When @mode is
    @@@     @combined the executable must be cloned before use and
    @@@     configured with readonly=off.  With QEMU versions older than
    @@@     4.0, you have to use
    @@@     ::
    @@@         -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format

Save the indentation of the line containing the '::'.  A line with less
indentation ends the literal block.

> +
> +        return line
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
> +            if re.match(r' *(https?|ftp)://[^ ]*$', line):
> +                pass
> +            else:
> +                raise QAPIParseError(
> +                    self, "documentation line exceeds 70 columns"
> +                )
> +
> +        single_space_pattern = r'(\be\.g\.|^ *\d\.|([.!?])) [A-Z0-9(]'
> +        for m in list(re.finditer(single_space_pattern, line)):
> +            if not m.group(2):
> +                continue
> +            # HACK so the error message points to the offending spot
> +            self.pos = self.line_pos + 2 + m.start(2) + 1

I have an idea for a non-hacky solution.  I'll post it when ready.
Until then, don't worry about it.

> +            raise QAPIParseError(
> +                 self, "Use two spaces between sentences")

Note this check is somewhat prone to false positives.
@single_space_pattern matches 'e.g.' to avoid the false positive
'e.g. FLAT' in block-core.json.  The same could happen for other
abbreviations.

We could add more sophisticated heuristics to reduce the risk of false
positives.  Meh.  I'd rather KISS for now.  We can deal with the problem
once we have it.

We may want to add a hint, though.  Something like:

               raise QAPIParseError(
                    self, "Use two spaces between sentences\n"
                    "If this not the end of a sentence, please report the bug")

>  
>      @staticmethod
>      def _match_at_name_colon(string: str) -> Optional[Match[str]]:

Negative tests would be nice, one for each new error.  Feel free to ask
me to write them.


