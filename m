Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367CECD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5bX-0003IZ-7x; Mon, 15 Jun 2026 07:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ5bW-0003IR-Dy
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ5bU-0004D8-KU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781523342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n+cp09LRmP/dKibHz5SYtyCHhsz4aHp8tdSrIyAyY3U=;
 b=fsK5wyAUdEyH0Ug4ucg0i3IqTpVXNhrX/VDAw1oIbWAC/FnQzC72nhSelNy4e1HFPdgL0o
 EVlcbtijwF7qQ/v48Yd2Slq812TwNiw+0WtAxUV1xtrK/qsPpsr4f72oYlonoHIacttZBT
 vZAqZOnSd2Qj7J90TDdeU1/UJ8zxKgc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-axJGjKPCP3qEoRyJ6asyww-1; Mon,
 15 Jun 2026 07:35:40 -0400
X-MC-Unique: axJGjKPCP3qEoRyJ6asyww-1
X-Mimecast-MFC-AGG-ID: axJGjKPCP3qEoRyJ6asyww_1781523340
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E85241805A05
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:35:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66CA01800351
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:35:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEC4321E6A01; Mon, 15 Jun 2026 13:35:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 7/7] json-parser: add location to JSON parsing errors
In-Reply-To: <20260525150503.393743-8-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 May 2026 17:05:03 +0200")
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-8-pbonzini@redhat.com>
Date: Mon, 15 Jun 2026 13:35:36 +0200
Message-ID: <8733yoqbnb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> to the message.  As far as I can see the two important TODOs (better
> errors and better EOI handling) are done, and the others (token range
> information and "parsed size"?) do not really matter or are handled
> better by json-streamer.c.  So remove the list, which had sat unchanged
> since 2009.
>
> This needs some adjustments to provide a good x and y for error messages.
> First of all, they switch from zero-based to one-based, which is safe
> because they were both sitting unused.  Second, right now the x and y
> are those of the *last* character in the token.  Modify json-lexer.c to
> freeze tok->x and tok->y at the first character added to the GString.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

QMP errors become obviously better, e.g.

    -> {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    <- {"return": {}}
    -> {"execute": "query-commands"]
    <- {"error": {"class": "GenericError", "desc": "JSON parse error, expected ',' or '}'"}}

improves to

    <- {"error": {"class": "GenericError", "desc": "JSON parse error at line 2, column 29, expected ',' or '}'"}}

The change to CLI errors is a mixed bag, e.g.

    $ qemu-system-x86_64 -S -blockdev '{"driver": "host_cdrom", "node-name": "blk0", "filename": "/dev/sr0"'
    qemu-system-x86_64: -blockdev {"driver": "host_cdrom", "node-name": "blk0", "filename": "/dev/sr0": JSON parse error, premature end of input

becomes

    qemu-system-x86_64: -blockdev {"driver": "host_cdrom", "node-name": "blk0", "filename": "/dev/sr0": JSON parse error at line 1, column 69, premature end of input

I fear this is confusing.  If you understand what's happening here, the
"column 69" part has value.  The "line 1" part is mostly noise.

Might be less of an issue with more compact location information.  See
below.

> ---
>  include/qobject/json-parser.h |  1 +
>  qobject/json-lexer.c          | 11 +++++++----
>  qobject/json-parser.c         | 12 ++----------
>  3 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
> index 3479e637588..e078b36b2d5 100644
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
> index faf3a9142bd..8c58ae0349a 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -126,15 +126,6 @@ typedef struct JSONParserStackEntry {
>  
>  #define BUG_ON(cond) assert(!(cond))
>  
> -/**
> - * TODO
> - *
> - * 0) make errors meaningful again
> - * 1) add geometry information to tokens
> - * 3) should we return a parsed size?
> - * 4) deal with premature EOI
> - */
> -
>  static inline JSONParserStackEntry *current_entry(JSONParserContext *ctxt)
>  {
>      return g_queue_peek_tail(ctxt->stack);
> @@ -172,7 +163,8 @@ static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
>      va_start(ap, msg);
>      vsnprintf(message, sizeof(message), msg, ap);
>      va_end(ap);
> -    error_setg(&ctxt->err, "JSON parse error, %s", message);
> +    error_setg(&ctxt->err, "JSON parse error at line %d, column %d, %s",

The usual format used by code parsing tools such as compilers is like

   "%d:%d: JSON parse error: %s, token->x, token->y, message

Should we use it?

> +               token->y, token->x, message);
>  }
>  
>  static int cvt4hex(const char *s)


