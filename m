Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8956C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoZV-0006Hi-7W; Thu, 09 Jul 2026 09:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1whoZT-0006HL-HO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1whoZQ-0003UK-Sk
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783602818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4aG4rCZ7q2DOBS0L2Qs0LRkNftIUP8S0Gv4CW6FRysI=;
 b=RJZqX5Ht/lT3qh3pHFYmZi5QDVSTDc7Fcr39eOwZMtiKtT+fCtVLXWKtusJxUxVwLP0KLl
 UzEITMXfSGOyGjRIf4X1bhLcOta9ZVRGQMNOs7zDZk8kLoG0i6JhGgpiwwUrZ6az/xl5Uy
 BAyO/V8+SHMRKo3zF2k9RhRd/+/xOgg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-GNnij79hOuiuTX7dzNMn9Q-1; Thu, 09 Jul 2026 09:13:36 -0400
X-MC-Unique: GNnij79hOuiuTX7dzNMn9Q-1
X-Mimecast-MFC-AGG-ID: GNnij79hOuiuTX7dzNMn9Q_1783602816
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47407691804so1554666f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602815; cv=none;
 d=google.com; s=arc-20260327;
 b=RjdJFdBlLtEwN0PUv1508kZuqbG+vO23iScYbXRur3V1UCBJ3jopZ1xgK/dO52VAzn
 nX0Qwmh2BLg5P1kggGt9+cseHJ9loUlYAz7KwoPKv2PGy3KyAf23e0ce4Ju9TysDQ0In
 22HaRFNJUkU6goTeBLVmR54TqrRDfvITBr7Gux7xGS4v0VeqsmLUgBYtRebjqjfyU7gB
 7Opkfe7QDcaBSsZLnrO37xdw3XmP6P25dgmtEp6ccFk1v5L5P/Fm5L6Hk6JVBWBOPG54
 iM0S4ef05UPeOVOU8ncHdQtmxAh5Y1bHi90rIxaGQHn+QYsGTv9D92PDtTbvrUWRjs2a
 jhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4aG4rCZ7q2DOBS0L2Qs0LRkNftIUP8S0Gv4CW6FRysI=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=goDVYQsE0eFkdIIbKfGGlGqbaYN+oE7K6r5JPGt8bIcNAgO2gwdCTgH+OPtSwWJbmX
 jejZOaF9V/tdLs58i4uBQ6D20MsbJj8clmayI9b99YMoNl61oV9XILVJpbjRD9RD+JWd
 GvvfBbp4oSi6N1rsCCWtUN61rPq+rc3F3csK9Jsbj934LOEiytRAxK+qQo/Zdbn5KIvu
 Imr2YGdvFRrzzqYIYN5CmVG/PqvcGFU7zOGnTUGbLXKZhC2aBfRYeou2poqzviWioM+5
 Y3xSwevEUnsjovfrv9Oqo0sCFQtRDNvAYcjk/uqQZwQTy6AsV88SBznyYIax16QUfleI
 mTOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783602815; x=1784207615; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4aG4rCZ7q2DOBS0L2Qs0LRkNftIUP8S0Gv4CW6FRysI=;
 b=TYLyAOdWQDOkDrJLKjrfX4QlIaSatdme9dQJLbZ2FFirgnJcVQm0/UoXF+kacuhaCl
 FmY1VbBGqaYoYQN2PKMusWGq9PoYvVVIG/yhCbGdTtu57kpscVqnyow+5j9E2DgG/dyv
 uUhcUQwHX6dW53oDq4GIpyAsqF6dugdsbTOotPRZQPGonG7Acx+aSIWfbiH2qa2EVUQy
 5llP+Fgsfn9d0t6K1U3BZylMVVFtIrcD0Jkkv2VvnwbPmGRj321eDoe9EcuJuMYnMety
 JfoQzAq7Nf9pORh3WVkUvU3R16NUlMsqykGsGIAVHGRKzXpOAjZcXXl+aw6rBuOMvDpJ
 Cg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783602815; x=1784207615;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4aG4rCZ7q2DOBS0L2Qs0LRkNftIUP8S0Gv4CW6FRysI=;
 b=L67DBqdUCgQpAaMSej+zcwcFPAOiz4DDTycNIqtnQWSHZM5PdFJ8ppJ3jCBpX+qVdp
 WhVGiH31L7JOl39s+LP6ZydWTu61z/TyEboybW5ms4cbJ/WnJgIqDGv9xU5wDI2UT0Mi
 RSvbdnT5xIsdP8JpvpKYGgJ32INohtLMxtlnIO0V9TL3oOyB7iiVSS0rE9VxGv2fOUyT
 xBlEJmghFhKCvNLjqQGScSmCh46EDLQoVbREaKEU4+/aZRVov5opQatRoMUHC3qbOahE
 Zf1nWEKu9D6m0HcjoPiH2Fux8V58EVwujVpMiD4+LQhz6rTOBbussC+k2OBdRwQwC6C4
 gHow==
X-Gm-Message-State: AOJu0Yxm4QIJQRINCHguWDb8Vu8l8Hz/VG3FEZXqlMUU6Demtp/IMNEI
 qPoyW2+nfozbwzz9a8zvgkQxdr+WnZx6fcIhVX+YdpyaTktod+On40rdrYNwkdsjqd/UVgmZQmF
 pJL0ngFjpwhYrIFZIPNcZxVkpz3dUbTFZwyV3viMIJpCAEVJ+Uvlg5QyIytYdOrIwHvXfpmZUPt
 /NMNgY7kALHYGOd4vMv9gZ4zrYr+fdlPwbCS2py0I=
X-Gm-Gg: AfdE7ckgnfJ8f4Aw1v2a+wCIpkyz2XCSBnQ/i2M5Mo3m6uk1uJbsjAYVdht/PsRa0MR
 yykFCUkEkBd5suc3pyYmpU7bgdDVpN6iJaw5nHgUwMit3hjiygvxSATtM8EsvahR2KygJinqs/v
 GQPYSFdFshVzUVSgqg9HfdBGWkBDkksKZ/C4GyovOYb6bWnIAc2RBnJu9iyoLcP9m9UbDeKpKAg
 otxS8M6ebVAfN+9SVjTSrxAEgPi2ePXd4ZvhtiPS0rAoemE1nogNwfhRE/sfh4UjkoU5A==
X-Received: by 2002:a05:6000:41fe:b0:46f:8cc5:454b with SMTP id
 ffacd0b85a97d-47df077aae8mr6889219f8f.43.1783602815502; 
 Thu, 09 Jul 2026 06:13:35 -0700 (PDT)
X-Received: by 2002:a05:6000:41fe:b0:46f:8cc5:454b with SMTP id
 ffacd0b85a97d-47df077aae8mr6889199f8f.43.1783602815069; Thu, 09 Jul 2026
 06:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260626101727.1727389-1-pbonzini@redhat.com>
 <20260626101727.1727389-5-pbonzini@redhat.com>
 <878q7xts77.fsf@pond.sub.org>
In-Reply-To: <878q7xts77.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Jul 2026 15:13:21 +0200
X-Gm-Features: AUfX_myesE2Bi2Db1VHAuZzne-SABkOBDtwY3l-meIBzq2vCrMoi8p3IOZ-ew4U
Message-ID: <CABgObfZhH2NaSuscqfvV+T4Sd5U3ngg__75a4XvcN=aQojia-A@mail.gmail.com>
Subject: Re: [PATCH 4/6] json-streamer: remove token queue
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000368fad06562d649d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000368fad06562d649d
Content-Type: text/plain; charset="UTF-8"

Il lun 29 giu 2026, 15:03 Markus Armbruster <armbru@redhat.com> ha scritto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Now fully exploit the push parser, feeding it one token at a time
> > without having to wait until braces and brackets are balanced.
> >
> > While the nesting counts are retained for error recovery purposes,
> > the system can now report the first parsing error without waiting
> > for parentheses to be balanced.  This also means that JSON_ERROR
> > can be handled in json-parser.c, not json-streamer.c.
> >
> > After reporting the error, json-streamer.c then enters an error recovery
> > mode where subsequent errors are suppressed.  This mimics the previous
> > error reporting behavior, but it provides prompt feedback on parsing
> > errors.  As an example, here is an example interaction with qemu-ga.
> >
> > BEFORE (error reported only once braces are balanced):
> >
> >    >> {"execute":foo
> >    >> }
> >    << {"error": {"class": "GenericError", "desc": "JSON parse error,
> invalid keyword 'foo'"}}
> >    >> {"execute":"somecommand"}
> >    << {"error": {"class": "CommandNotFound", "desc": "The command
> somecommand has not been found"}}
> >
> > AFTER (error reported immediately, but similar error recovery as before):
> >
> >    >> {"execute":foo
> >    << {"error": {"class": "GenericError", "desc": "JSON parse error,
> invalid keyword 'foo'"}}
> >    >> }
> >    >> {"execute":"somecommand"}
> >    << {"error": {"class": "CommandNotFound", "desc": "The command
> somecommand has not been found"}}
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  include/qobject/json-parser.h |   3 +-
> >  qobject/json-parser.c         |   4 ++
> >  qobject/json-streamer.c       | 106 +++++++++++++---------------------
> >  3 files changed, 47 insertions(+), 66 deletions(-)
> >
> > diff --git a/include/qobject/json-parser.h
> b/include/qobject/json-parser.h
> > index 0cf6932ecdc..3479e637588 100644
> > --- a/include/qobject/json-parser.h
> > +++ b/include/qobject/json-parser.h
> > @@ -33,7 +33,8 @@ typedef struct JSONMessageParser {
> >      JSONParserContext parser;
> >      unsigned int brace_count;
> >      unsigned int bracket_count;
> > -    GQueue tokens;
> > +    unsigned int token_count;
> > +    bool error;
> >      uint64_t token_size;
> >  } JSONMessageParser;
> >
> > diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> > index 845da3699aa..484956deae4 100644
> > --- a/qobject/json-parser.c
> > +++ b/qobject/json-parser.c
> > @@ -673,6 +673,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt,
> const JSONToken *token,
> >
> >      assert(!ctxt->err);
> >      switch (token->type) {
> > +    case JSON_ERROR:
> > +        parse_error(ctxt, token, "stray '%s'", token->str);
> > +        break;
> > +
> >      case JSON_END_OF_INPUT:
> >          /* Check for premature end of input */
> >          if (!g_queue_is_empty(ctxt->stack)) {
> > diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> > index 9e1f650bad8..9526f815f00 100644
> > --- a/qobject/json-streamer.c
> > +++ b/qobject/json-streamer.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * JSON streaming support
> > + * JSON parser - callback interface and error recovery
> >   *
> >   * Copyright IBM, Corp. 2009
> >   *
> > @@ -19,23 +19,16 @@
> >  #define MAX_TOKEN_COUNT (2ULL << 20)
> >  #define MAX_NESTING (1 << 10)
> >
> > -static void json_message_free_tokens(JSONMessageParser *parser)
> > -{
> > -    JSONToken *token;
> > -
> > -    while ((token = g_queue_pop_head(&parser->tokens))) {
> > -        g_free(token);
> > -    }
> > -}
> > -
> >  void json_message_process_token(JSONLexer *lexer, GString *input,
> >                                  JSONTokenType type, int x, int y)
> >  {
> >      JSONMessageParser *parser = container_of(lexer, JSONMessageParser,
> lexer);
> > -    QObject *json = NULL;
> >      Error *err = NULL;
> > -    JSONToken *token;
> >
> > +    parser->token_size += input->len;
> > +    parser->token_count++;
> > +
> > +    /* Detect message boundaries for error recovery purposes.  */
> >      switch (type) {
> >      case JSON_LCURLY:
> >          parser->brace_count++;
> > @@ -56,19 +49,9 @@ void json_message_process_token(JSONLexer *lexer,
> GString *input,
> >          parser->bracket_count--;
> >          break;
> >      case JSON_ERROR:
> > -        error_setg(&err, "JSON parse error, stray '%s'", input->str);
> > -        goto out_emit;
> > -    case JSON_END_OF_INPUT:
> > -        /*
> > -         * Force the parentheses to appear balanced and the queue
> > -         * to be emptied, causing a parse error if it wasn't.
> > -         */
> > -        if (g_queue_is_empty(&parser->tokens)) {
> > -            return;
> > -        }
> >      end_error_recovery:
> >          /*
> > -         * We goto here due to receiving either JSON_ERROR or a
> > +         * We come here due to receiving either JSON_ERROR or a
>
> Line was added in the previous commit.  Squash the change into it?
>

The change is minor but intended in the sense that end_error_recovery is
reached also as a case label, not just a goto.

> -    if (parser->token_size + input->len + 1 > MAX_TOKEN_SIZE) {
>
> Left operand of > is unincremented token_size plus increment plus 1.
>
> > -        error_setg(&err, "JSON token size limit exceeded");
> > -        goto out_emit;
> > -    }
> > -    if (g_queue_get_length(&parser->tokens) + 1 > MAX_TOKEN_COUNT) {
> > -        error_setg(&err, "JSON token count limit exceeded");
> > -        goto out_emit;
> > -    }
> > -    if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
> > -        error_setg(&err, "JSON nesting depth limit exceeded");
> > -        goto out_emit;
> > -    }
> > +    if (parser->error) {
> > +        /* error recovery, eat tokens until parentheses balance */
> > +    } else {
> > +        /*
> > +         * Safety consideration, we limit total memory allocated per
> object
> > +         * and the maximum nesting depth that a message can force.
> > +         */
> > +        if (parser->token_size > MAX_TOKEN_SIZE) {
>
> Left operand of > is incremented token size.
>
> I believe this is one less than before the patch.
>
> If you'd prefer not to change the code, mention the change in the commit
> message.
>

Mentioned in v3 I think, the inconsistency was before this patch not after.
A change of 1 isn't really making any difference since the maximum token
size is just a number off the original author's hat.

Paolo

--000000000000368fad06562d649d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 29 giu 2026, 15:03 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; Now fully exploit the push parser, feeding it one token at a time<br>
&gt; without having to wait until braces and brackets are balanced.<br>
&gt;<br>
&gt; While the nesting counts are retained for error recovery purposes,<br>
&gt; the system can now report the first parsing error without waiting<br>
&gt; for parentheses to be balanced.=C2=A0 This also means that JSON_ERROR<=
br>
&gt; can be handled in json-parser.c, not json-streamer.c.<br>
&gt;<br>
&gt; After reporting the error, json-streamer.c then enters an error recove=
ry<br>
&gt; mode where subsequent errors are suppressed.=C2=A0 This mimics the pre=
vious<br>
&gt; error reporting behavior, but it provides prompt feedback on parsing<b=
r>
&gt; errors.=C2=A0 As an example, here is an example interaction with qemu-=
ga.<br>
&gt;<br>
&gt; BEFORE (error reported only once braces are balanced):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 &gt;&gt; {&quot;execute&quot;:foo<br>
&gt;=C2=A0 =C2=A0 &gt;&gt; }<br>
&gt;=C2=A0 =C2=A0 &lt;&lt; {&quot;error&quot;: {&quot;class&quot;: &quot;Ge=
nericError&quot;, &quot;desc&quot;: &quot;JSON parse error, invalid keyword=
 &#39;foo&#39;&quot;}}<br>
&gt;=C2=A0 =C2=A0 &gt;&gt; {&quot;execute&quot;:&quot;somecommand&quot;}<br=
>
&gt;=C2=A0 =C2=A0 &lt;&lt; {&quot;error&quot;: {&quot;class&quot;: &quot;Co=
mmandNotFound&quot;, &quot;desc&quot;: &quot;The command somecommand has no=
t been found&quot;}}<br>
&gt;<br>
&gt; AFTER (error reported immediately, but similar error recovery as befor=
e):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 &gt;&gt; {&quot;execute&quot;:foo<br>
&gt;=C2=A0 =C2=A0 &lt;&lt; {&quot;error&quot;: {&quot;class&quot;: &quot;Ge=
nericError&quot;, &quot;desc&quot;: &quot;JSON parse error, invalid keyword=
 &#39;foo&#39;&quot;}}<br>
&gt;=C2=A0 =C2=A0 &gt;&gt; }<br>
&gt;=C2=A0 =C2=A0 &gt;&gt; {&quot;execute&quot;:&quot;somecommand&quot;}<br=
>
&gt;=C2=A0 =C2=A0 &lt;&lt; {&quot;error&quot;: {&quot;class&quot;: &quot;Co=
mmandNotFound&quot;, &quot;desc&quot;: &quot;The command somecommand has no=
t been found&quot;}}<br>
&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/qobject/json-parser.h |=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 qobject/json-parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A04 ++<br>
&gt;=C2=A0 qobject/json-streamer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 106 ++++++++=
+++++---------------------<br>
&gt;=C2=A0 3 files changed, 47 insertions(+), 66 deletions(-)<br>
&gt;<br>
&gt; diff --git a/include/qobject/json-parser.h b/include/qobject/json-pars=
er.h<br>
&gt; index 0cf6932ecdc..3479e637588 100644<br>
&gt; --- a/include/qobject/json-parser.h<br>
&gt; +++ b/include/qobject/json-parser.h<br>
&gt; @@ -33,7 +33,8 @@ typedef struct JSONMessageParser {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 JSONParserContext parser;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned int brace_count;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned int bracket_count;<br>
&gt; -=C2=A0 =C2=A0 GQueue tokens;<br>
&gt; +=C2=A0 =C2=A0 unsigned int token_count;<br>
&gt; +=C2=A0 =C2=A0 bool error;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t token_size;<br>
&gt;=C2=A0 } JSONMessageParser;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/qobject/json-parser.c b/qobject/json-parser.c<br>
&gt; index 845da3699aa..484956deae4 100644<br>
&gt; --- a/qobject/json-parser.c<br>
&gt; +++ b/qobject/json-parser.c<br>
&gt; @@ -673,6 +673,10 @@ QObject *json_parser_feed(JSONParserContext *ctxt=
, const JSONToken *token,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(!ctxt-&gt;err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (token-&gt;type) {<br>
&gt; +=C2=A0 =C2=A0 case JSON_ERROR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_error(ctxt, token, &quot;stray &#39=
;%s&#39;&quot;, token-&gt;str);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case JSON_END_OF_INPUT:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check for premature end of input =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_queue_is_empty(ctxt-&gt;stack=
)) {<br>
&gt; diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c<br>
&gt; index 9e1f650bad8..9526f815f00 100644<br>
&gt; --- a/qobject/json-streamer.c<br>
&gt; +++ b/qobject/json-streamer.c<br>
&gt; @@ -1,5 +1,5 @@<br>
&gt;=C2=A0 /*<br>
&gt; - * JSON streaming support<br>
&gt; + * JSON parser - callback interface and error recovery<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* Copyright IBM, Corp. 2009<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; @@ -19,23 +19,16 @@<br>
&gt;=C2=A0 #define MAX_TOKEN_COUNT (2ULL &lt;&lt; 20)<br>
&gt;=C2=A0 #define MAX_NESTING (1 &lt;&lt; 10)<br>
&gt;=C2=A0 <br>
&gt; -static void json_message_free_tokens(JSONMessageParser *parser)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 JSONToken *token;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 while ((token =3D g_queue_pop_head(&amp;parser-&gt;toke=
ns))) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(token);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 void json_message_process_token(JSONLexer *lexer, GString *input=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 JSONTokenType type, int x,=
 int y)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 JSONMessageParser *parser =3D container_of(lexer, =
JSONMessageParser, lexer);<br>
&gt; -=C2=A0 =C2=A0 QObject *json =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 JSONToken *token;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 parser-&gt;token_size +=3D input-&gt;len;<br>
&gt; +=C2=A0 =C2=A0 parser-&gt;token_count++;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Detect message boundaries for error recovery purpose=
s.=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (type) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case JSON_LCURLY:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;brace_count++;<br>
&gt; @@ -56,19 +49,9 @@ void json_message_process_token(JSONLexer *lexer, G=
String *input,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;bracket_count--;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case JSON_ERROR:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;err, &quot;JSON parse err=
or, stray &#39;%s&#39;&quot;, input-&gt;str);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_emit;<br>
&gt; -=C2=A0 =C2=A0 case JSON_END_OF_INPUT:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Force the parentheses to appear b=
alanced and the queue<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to be emptied, causing a parse er=
ror if it wasn&#39;t.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_queue_is_empty(&amp;parser-&gt;toke=
ns)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 end_error_recovery:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We goto here due to receiving eit=
her JSON_ERROR or a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We come here due to receiving eit=
her JSON_ERROR or a<br>
<br>
Line was added in the previous commit.=C2=A0 Squash the change into it?<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The =
change is minor but intended in the sense that end_error_recovery is reache=
d also as a case label, not just a goto.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; -=C2=A0 =C2=A0 if (parser-&gt;token_size + input-&gt;len + 1 &gt; MAX_=
TOKEN_SIZE) {<br>
<br>
Left operand of &gt; is unincremented token_size plus increment plus 1.<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;err, &quot;JSON token siz=
e limit exceeded&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_emit;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 if (g_queue_get_length(&amp;parser-&gt;tokens) + 1 &gt;=
 MAX_TOKEN_COUNT) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;err, &quot;JSON token cou=
nt limit exceeded&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_emit;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 if (parser-&gt;bracket_count + parser-&gt;brace_count &=
gt; MAX_NESTING) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;err, &quot;JSON nesting d=
epth limit exceeded&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_emit;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (parser-&gt;error) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* error recovery, eat tokens until paren=
theses balance */<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Safety consideration, we limit to=
tal memory allocated per object<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and the maximum nesting depth tha=
t a message can force.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (parser-&gt;token_size &gt; MAX_TOKEN_=
SIZE) {<br>
<br>
Left operand of &gt; is incremented token size.<br>
<br>
I believe this is one less than before the patch.=C2=A0=C2=A0<br>
<br>
If you&#39;d prefer not to change the code, mention the change in the commi=
t<br>
message.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Mentioned in v3 I think, the inconsistency was before this patch =
not after. A change of 1 isn&#39;t really making any difference since the m=
aximum token size is just a number off the original author&#39;s hat.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--000000000000368fad06562d649d--


