Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009D8CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ2Ps-0000rd-M6; Mon, 15 Jun 2026 04:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ2Pr-0000of-Jw
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ2Pp-0001jj-GG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781511087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZhA39Yvx0p6sgB3mCXfl0JfeG0XgVFzx7f2+Io1Psp0=;
 b=JRkstwn4M+u3Uhqzb080dtPzOOi6fbIhMdQ7tQBej3HNKzZC8e0jYqv0xruPTujQCZEu2Z
 IHqJjTPp7ynDo83q+ZWBp9XJmcmFZl3zHfmc/EWR+DhSBbdIb+gpxVkNX+zuM1qCVwTAMJ
 4Mlkf1QOK54pWiDcjtU9ZN4ez5IAYi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-Fd5oOG8_MTyymlfQ4pk05Q-1; Mon,
 15 Jun 2026 04:11:26 -0400
X-MC-Unique: Fd5oOG8_MTyymlfQ4pk05Q-1
X-Mimecast-MFC-AGG-ID: Fd5oOG8_MTyymlfQ4pk05Q_1781511085
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DA0119560A1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 08:11:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BA32180049F
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 08:11:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9455021E6A01; Mon, 15 Jun 2026 10:11:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/7] json-streamer: make brace/bracket count unsigned
In-Reply-To: <20260525150503.393743-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 May 2026 17:05:00 +0200")
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-5-pbonzini@redhat.com>
Date: Mon, 15 Jun 2026 10:11:22 +0200
Message-ID: <877bo0rzo5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> It makes no sense to let brace_count and bracket_count go negative,
> also because it immediately ends error recovery and sets them both
> back to zero.  Instead set them to zero *before* choosing
> whether to process the token queue; this makes it possible to
> have the fields as unsigned.
>
> Note that JSON_END_OF_INPUT now forces the parentheses to appear
> balanced, so that the queue is emptied and an error is reported;
> hence, the "type != JSON_END_OF_INPUT" condition can be removed.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/json-parser.h |  4 ++--
>  qobject/json-streamer.c       | 19 ++++++++++++++++---
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
> index 4c3d89f751f..0cf6932ecdc 100644
> --- a/include/qobject/json-parser.h
> +++ b/include/qobject/json-parser.h
> @@ -31,8 +31,8 @@ typedef struct JSONMessageParser {
>      void *opaque;
>      JSONLexer lexer;
>      JSONParserContext parser;
> -    int brace_count;
> -    int bracket_count;
> +    unsigned int brace_count;
> +    unsigned int bracket_count;
>      GQueue tokens;
>      uint64_t token_size;
>  } JSONMessageParser;
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index f3dfdcaea12..b0bf2083ca6 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -41,12 +41,18 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>          parser->brace_count++;
>          break;
>      case JSON_RCURLY:
> +        if (parser->brace_count <= 0) {

Why <= 0?  parser->brace_count is unsigned now...

> +            goto end_error_recovery;
> +        }
>          parser->brace_count--;
>          break;
>      case JSON_LSQUARE:
>          parser->bracket_count++;
>          break;
>      case JSON_RSQUARE:
> +        if (parser->bracket_count <= 0) {

Likewise.

> +            goto end_error_recovery;
> +        }
>          parser->bracket_count--;
>          break;
>      case JSON_ERROR:
> @@ -56,6 +62,15 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>          if (g_queue_is_empty(&parser->tokens)) {
>              return;
>          }
> +    end_error_recovery:
> +        /*
> +         * Cause error recovery to end immediately.
> +         * If not in error recovery, the parser will raise an error
> +         * (due to JSON_ERROR or unexpected JSON_R{CURLY,SQUARE})

What do you mean by "due to JSON_ERROR"?

We get here on unmatched } or ]: that's the gotos
you add above.

We also get here on end of non-empty input: that's when the if right
above doesn't return.

> +         * but error recovery won't be entered at all.
> +         */

This is the only comment on error recovery.  Would a comment giving a
brief overview on error recovery be useful?

> +        parser->brace_count = 0;
> +        parser->bracket_count = 0;
>          break;
>      default:
>          break;
> @@ -83,9 +98,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>  
>      g_queue_push_tail(&parser->tokens, token);
>  
> -    if ((parser->brace_count > 0 || parser->bracket_count > 0)
> -        && parser->brace_count >= 0 && parser->bracket_count >= 0
> -        && type != JSON_END_OF_INPUT) {
> +    if (parser->brace_count > 0 || parser->bracket_count > 0) {
>          return;
>      }

We get here when

* no lexical error, and

* no limits exceeded, and

* the curlies and squares are balanced, either in fact or because
  we passed through end_error_recovery.

Good.

       /* Process all tokens in the queue */
       while (!g_queue_is_empty(&parser->tokens)) {


