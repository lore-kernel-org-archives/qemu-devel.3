Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FD8EE2085
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJUI-0000zY-He; Fri, 06 Feb 2026 05:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voJUG-0000zF-Mx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voJUB-0002zZ-O2
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770375289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvEETymdod3uwfeU/b+XHkoReYj+MHSbv9O0pi4K8lo=;
 b=c6UKcLB1rnX2J5jM9OSsqgocFVbnujM8HBo0MpwkPlEm6iiJgQfQaHfgtxtuUccO5gwoTo
 Sn161zk2KOBjArxKvhr2j9DbzXhqkbvN56CE6yn1K6t/XiXAtmCbIlpr7ZbXP3EW8zxpVs
 4JkjyVcdMBnqj6sOYvH36XeSuFSgOmI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-8qmCp6rCM5WyrJidGrCvHg-1; Fri, 06 Feb 2026 05:54:48 -0500
X-MC-Unique: 8qmCp6rCM5WyrJidGrCvHg-1
X-Mimecast-MFC-AGG-ID: 8qmCp6rCM5WyrJidGrCvHg_1770375287
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso1774606f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 02:54:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770375286; cv=none;
 d=google.com; s=arc-20240605;
 b=OiKLaGWWQLRMlu5/7XPg1fR5FgVIcHmdZu0vCyWBhvWifkA72qmAJa0fgnOEnT61Ck
 17oh47DUQtYQso6qHa57i/k3Nvt6a3G2ghlKA8bENQGao3xi52rhkbdf2WF3+vaELTvI
 K9srw3R2WqMErXyB04YQArNGXVqu7xbTjHAXk59wPkb8Gs0VaSeGrg/PmU0SAcWTMTX8
 X+jTj40xm16GEA2yt20hgaFBRlwGOwoMCEfz31K42M/TSX9aIhnMCQCFO2ihvHvwkemB
 du/3YZh3ZLducVB4NpNcmg1c+tXPQc3Xv+I+5kkWJZz5xS1dqsGvPQErokTf/aUvAX+C
 Rf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mvEETymdod3uwfeU/b+XHkoReYj+MHSbv9O0pi4K8lo=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=S7IepHbYE6leSyBVG2hXMuOslLP0TrZFOCz9Eze6QWwtO8S0wtaL9K+e+RgDIxMkuq
 7yHSysFeuO4CGgyCuHNg+MoDU80x6wdlX+o09SRGyAjfvLgHyKN7TKPzgpGJ7KtmNH1X
 jMhaHrOZt89xu2om5lO0Abdyl1U9yw3mOCuhtwBKq/EqLLGo/lU7NQzuB9oUBNsZ4R9J
 RQV4HW/hL/oe3MkyMSlh4Gitq5/SCN24He6vt32YW9Si8+XKvNY6XgZMuaDN0A+d0AFa
 Qy4CfXj+mnkRYWSG+VhcNNYBYWGMZFdqlmI6s6i5eWV5IEz6U743XajvM69k89oFGELs
 Wlng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770375286; x=1770980086; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvEETymdod3uwfeU/b+XHkoReYj+MHSbv9O0pi4K8lo=;
 b=kYch1jXTGcLvrlEeOuoAxM27YHf6r+4X4ILL9y1jTzQgoLGg499Dfh1FQMiZyZ4BA4
 5uPm+scTsTNe+TQ/Y7zjdxvt6qrGmgvedsi1CnzHOIRZIBSxsx4le71x0wFdhxRDn6Wn
 xFAR5zL7HSAlmGK3PS5aUxriTMn3Rr1h8SO+9KSHTLSoEZxiZv3Fll4XJ6dnT/4wthF4
 7okpezEQfn70hu3TLw2FqCYUO8Rur+9umJAATOiAV2jJMm2bBB1Dgg+vQKLiaufGSl6Q
 ga9pFgVA3lOP48b/08PXI2vDfpZ1hFnISMbygQNbihCUvJqMyshB8tc7kZzN7dr6jPz9
 rCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770375286; x=1770980086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mvEETymdod3uwfeU/b+XHkoReYj+MHSbv9O0pi4K8lo=;
 b=N0tVtPzgU/BAhhYDTvHUOdjmlv7HOJQ6XwBZAsnpv/2XQ4T2MiCS/OmaUOQx82Hwp6
 MFzo9snK+rJoqGsVzWrM2b1qQnUSYsy++aqfcsAViOc6ekDhPLHhiuApFo8BQPrxPzKy
 byqNOn+HgOrwswPPKOkM+eeQQwNHiAvtgfbS55sLRZaz0TChTQyoiwELROVb5OxdOt6w
 cXAAleUFppSJecSyDDoMErUYPFNk291ekNnqWVhfxlbG/elIgPCdAgR1FRXj6qV7Xb9R
 d446SF3Y/WhEhAcV9FMmESpnUGxdauoHeATPW+UnjYa6ouzn/2VJg0lJG8ww8fk8RfoJ
 1yHQ==
X-Gm-Message-State: AOJu0Yx8UYH1ggvyXbWKCj/ZX36xPWBrN/TyNhskmhT78p7vxznHBC5I
 C6dv+363do9aRv+IaUXtG8ufkXRS7Ifxl4ZXh7dSxtI5ZPd3NTnu8p4e9QVBfMH/4It2YZWZ+fU
 /GVSmqKHK3DYuuDSZ7WwZGqbZTV9W8mmbfOIEaSoFlm+d4XvQsyROCOEHFYZxITuj9gEsk7j6q1
 P38inuS1+AJncPcvk5zA1aLWeXIHmCk83GaPQLDQ0=
X-Gm-Gg: AZuq6aL7vGy/st8xRYF2Jm/tZR5oTWUurJ36b+cqsmJ1S9fZO15VSwnByDN7Qr3Xy/Q
 W1X5+xT9qK097MlR2IX+BtOqC6vUA7E1Vp4SnRtqyek81YIzwjhagE2ypZBuBS59vpI1TYRDUGM
 hC0yB8MFDGou1scFzCXKlI1gZqzQhlyPruPXXeFmCIOklnAuYzXa+Mr10G8cMJ3V1eshY5WD6fF
 lx2vljuMYypUR1nFnSD7lJLvA3RwvRqy0gXrhSZ92eUjd0552+Sy5XJWHreCV84Bw6m0Q==
X-Received: by 2002:a05:6000:2303:b0:435:97f6:4f44 with SMTP id
 ffacd0b85a97d-436293b2300mr3452143f8f.56.1770375286605; 
 Fri, 06 Feb 2026 02:54:46 -0800 (PST)
X-Received: by 2002:a05:6000:2303:b0:435:97f6:4f44 with SMTP id
 ffacd0b85a97d-436293b2300mr3452104f8f.56.1770375286162; Fri, 06 Feb 2026
 02:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-2-pbonzini@redhat.com>
 <871piyw3o9.fsf@pond.sub.org>
In-Reply-To: <871piyw3o9.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Feb 2026 11:54:33 +0100
X-Gm-Features: AZwV_Qh5pNIMMYuH4TqP7wLQAGbRBX8NThKnEbTnLHmaTBUFzu-rct_HeoacCjI
Message-ID: <CABgObfYCPzUxDhc=1WWeyc0kTJobTEsFBqe6tELOOP=84HA7+Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] json-parser: pass around lookahead token, constify
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Fri, Feb 6, 2026 at 11:46=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
> > In particular, because parse_array() and parse_object() can assume
> > that the opening bracket/brace is not anymore in the token stream, it
> > is now apparent that the first entry of an array incorrectly used the
> > '[' character (stored in "token") as its location.
>
> For a value of "apparent".  Not sure I would've seen it without your
> heads up.

Me neither - I found it only while reviewing my own changes. :)

> I believe you're talking about
>
>         obj =3D parse_value(ctxt);
>         if (obj =3D=3D NULL) {
>             parse_error(ctxt, token, "expecting value");
>             goto out;
>         }
>
> where @token indeed holds the array's '['.

Correct.

>         parse_error(ctxt, NULL, "premature EOI");
>
> These bad arguments are all masked by parse_error() completely ignoring
> its argument!  We tell users what's wrong with the input, but telling
> them where it's wrong has been TODO since the initial commit in 2009[*].
> I see your PATCH 5 finally takes care of it.

Yep, the clearer distinction between the parser and streamer helps a
little in that respect.

> > -    key_obj =3D parse_value(ctxt);
> > +    key_obj =3D parse_value(ctxt, token);
> >      key =3D qobject_to(QString, key_obj);
> >      if (!key) {
> > -        parse_error(ctxt, peek, "key is not a string in object");
> > +        parse_error(ctxt, token, "key is not a string in object");
> >          goto out;
> >      }
> >
>
> @peek isn't exactly a great name, but @token tells me even less.
> @first_token?

Possibly - though it all goes away since the parser becomes a state
machine, and the only separate functions that survive are for
one-token literals; which is why I just went simply with "token"
everywhere (as in, "next token" or "lookahead that led the parser to
call this function").

> >  static QObject *parse_object(JSONParserContext *ctxt)
> >  {
> >      QDict *dict =3D NULL;
> > -    JSONToken *token, *peek;
> > -
> > -    token =3D parser_context_pop_token(ctxt);
> > -    assert(token && token->type =3D=3D JSON_LCURLY);
> > +    const JSONToken *token;
>
> Before the patch, parse_object() parses the entire object, as its name
> indicates, with the precondition that the lookahead is '{'.
>
> After the patch, it parses the part of the object after the '{'.  Hmm.
>
> We could pass it the first token, like we do for all the other parsing
> functions except this one and parse_array(), and keep the assertion.
> I'd prefer that, but it's a matter of taste.

I see, yes we could. I can do this in v2, since I'm sure you'll
(rightly) find something in the other patches that warrants a resend.

> This is the only call of parser_context_pop_token() that isn't
> immediately followed by "if it returned null, report "premature EOI".
> I went "let's factor this out", then realized the next patch replaces
> all this.  Nevermind!

Yeah, not an excuse for being sloppy but perhaps an excuse for not
being too picky. :)

> * parse_pair() and parse_value() now receive the first token as
>   argument.  Popping the first token moves to their callers.
>
> * parse_keyword(), parse_interpolation(), and parse_literal() now
>   receive the token as argument.  Popping it moves to their callers.
>   parse_string() works like this even before the patch, and is not
>   changed.
>
> * parse_object() and parse_array() now parse the part after the object's
>   / array's first token.
>
> Works.

Good :)

Paolo


