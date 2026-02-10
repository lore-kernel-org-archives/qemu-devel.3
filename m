Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F424EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjw3-0005yL-QF; Tue, 10 Feb 2026 04:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpjw2-0005th-HD
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpjw0-0006CD-9f
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770715287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QzkESXlFbDIXmbrOhEjaTNHDcxPRqUxBhSo6/jof8qA=;
 b=c/p/JOVlOYpBhNq/EEjhJprdLF45RLd15gnhSSy5D77fFiMglz9W1dTMK5KrvLXbVvt1aD
 CHg7BvAdAqfnQ/7x7SA/sPTg7XN2b/01u+SaDoKmf4g2EU1wtWUfncHTDXUW9/uoTVeFp9
 OyDZ0wtb9rcwfxAIdBVbCp+AEdDQ7Hc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-jtXOcOXcOM-FNBmDs68WGg-1; Tue,
 10 Feb 2026 04:21:25 -0500
X-MC-Unique: jtXOcOXcOM-FNBmDs68WGg-1
X-Mimecast-MFC-AGG-ID: jtXOcOXcOM-FNBmDs68WGg_1770715285
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1BDC195608D
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 09:21:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6018D19560A3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 09:21:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E004621E692D; Tue, 10 Feb 2026 10:21:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] json-parser: add location to JSON parsing errors
In-Reply-To: <20260107084840.150843-6-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 7 Jan 2026 09:48:40 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-6-pbonzini@redhat.com>
Date: Tue, 10 Feb 2026 10:21:21 +0100
Message-ID: <87cy2d7y3y.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Now that all calls to parse_error have a token, add the line and column

Enabled by PATCH 2 pushing the JSON_END_OF_INPUT to the parser.  Before,
the parser detected end of input by running out of tokens.  It passed a
null token to parse_error() then.

> to the message.  As far as I can see the two important TODOs (better
> errors and better EOI handling) are done, and the others (token range
> information and "parsed size"?) do not really matter or are handled
> better by json-streamer.c.  So remove the list, which had sat unchanged
> since 2009.

Adding my remarks to the patch hunk below.  May lead to commit message
adjustments.

An example showing error before and after would be nice.

> Note however that right now the x and y are those of the *last* character
> in the token.  Modify json-lexer.c to freeze tok->x and tok->y at the
> first character added to the GString.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/json-parser.h |  1 +
>  qobject/json-lexer.c          | 11 +++++++----
>  qobject/json-parser.c         | 12 ++----------
>  3 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
> index 923eb74ca00..98fe1371a85 100644
> --- a/include/qobject/json-parser.h
> +++ b/include/qobject/json-parser.h
> @@ -17,6 +17,7 @@
>  typedef struct JSONLexer {
>      int start_state, state;
>      GString *token;
> +    int cur_x, cur_y;
>      int x, y;
>  } JSONLexer;
>  
> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> index 51341d96e49..7753ba6c092 100644
> --- a/qobject/json-lexer.c
> +++ b/qobject/json-lexer.c
> @@ -277,7 +277,8 @@ void json_lexer_init(JSONLexer *lexer, bool enable_interpolation)
>      lexer->start_state = lexer->state = enable_interpolation
>          ? IN_START_INTERP : IN_START;
>      lexer->token = g_string_sized_new(3);
> -    lexer->x = lexer->y = 0;
> +    lexer->cur_x = lexer->cur_y = 1;
> +    lexer->x = lexer->y = 1;

Not mentioned in the commit message: we switch @ and @y from zero-based
to one-based.  Pefectly safe, because they're both unused before this
patch.

Suggest to rename to line and col.

>  }
>  
>  static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
> @@ -285,10 +286,10 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
>      int new_state;
>      bool char_consumed = false;
>  
> -    lexer->x++;
> +    lexer->cur_x++;
>      if (ch == '\n') {
> -        lexer->x = 0;
> -        lexer->y++;
> +        lexer->cur_x = 1;
> +        lexer->cur_y++;
>      }
>  
>      while (flush ? lexer->state != lexer->start_state : !char_consumed) {
> @@ -316,6 +317,8 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
>          case IN_START:
>              g_string_truncate(lexer->token, 0);
>              new_state = lexer->start_state;
> +            lexer->x = lexer->cur_x;
> +            lexer->y = lexer->cur_y;
>              break;
>          case JSON_ERROR:
>              json_message_process_token(lexer, lexer->token, JSON_ERROR,
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 2fede59842f..93b737511d1 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -57,15 +57,6 @@ typedef struct JSONParserStackEntry {
>  
>  #define BUG_ON(cond) assert(!(cond))
>  
> -/**
> - * TODO

These go back all the way to the initial commit.

> - *
> - * 0) make errors meaningful again

The errors weren't meaningless, just bad.  The "again" is kind of funny,
considering it's the initial commit.

I agree with removing the line, but i wonder what exactly improved
beyond line and column ("geometry information").

> - * 1) add geometry information to tokens

Tokens had "geometry information" x, y since day one.  Delete.

> - * 3) should we return a parsed size?

Why we'd be interesed in the parsed size we no longer know.  Delete.

> - * 4) deal with premature EOI

Fixed in commit 11e8a46cc35 (json-parser: detect premature EOI) almost
fourteen years ago.  Delete.

> - */
> -
>  static inline JSONParserStackEntry *current_entry(JSONParserContext *ctxt)
>  {
>      return g_queue_peek_tail(ctxt->stack);
> @@ -105,7 +96,8 @@ static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
>      va_start(ap, msg);
>      vsnprintf(message, sizeof(message), msg, ap);
>      va_end(ap);
> -    error_setg(&ctxt->err, "JSON parse error, %s", message);
> +    error_setg(&ctxt->err, "JSON parse error at line %d, column %d, %s",
> +	       token->y, token->x, message);

The usual format used by code parsing tools such as compilers is like

   "%d:%d: JSON parse error: %s, token->x, token->y, message

Should we use it?

>  }
>  
>  static int cvt4hex(const char *s)


