Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72BBCD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7Rr-0008Py-Rz; Mon, 15 Jun 2026 09:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZ7Rm-0008MI-Pq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZ7Rj-00073b-En
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781530425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwN73iI5BwKeqzvn9l77NPsOkKx0RpBb4mLTp+Y4ec8=;
 b=iYhChbhWOwyI5t40hAdeNEl8v1q3FbRRoRHa0mr290beyrRA+5TWC00Ga/SRjdssN4c8QS
 ETi5MzmJXxaNQbp6jYoR8pi09KfUSns5iq8pDSsQ5To7og/DRcb4Gs+/CTu7NsdsMPlnwT
 iVy82g5mNq3arTQH5wTsv6KNmRQ2Fr0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Q-dSDKekOF6bWx-X3HY3UQ-1; Mon, 15 Jun 2026 09:33:44 -0400
X-MC-Unique: Q-dSDKekOF6bWx-X3HY3UQ-1
X-Mimecast-MFC-AGG-ID: Q-dSDKekOF6bWx-X3HY3UQ_1781530423
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eec2ba533so2196370f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 06:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781530423; cv=none;
 d=google.com; s=arc-20240605;
 b=IVJ4hX5Wply2HaFG4dOwr7ghM3AOf2TPKod/1OUpxzyiGgSy0F9/tocJWNsLFCvh+T
 7i2KYZmdNyuCOVY/7FRzq+v6zr9tW91UnFYzUBN+TmhQ7Rb75wB/CXALpMw/o+LMCpTQ
 PmfjHZ0Cb+LJuviD7JVPwKOLDy23BUMRphPxECSY4huI4G23x/mPJ4knQ3hC+WenXHOb
 NIrGp4obsCRKo1pcXXoE4P7ZkCO/n49K4owS46mxdnFfNiAzpwE2SVzzSqf+flBEQfHu
 2zhb3o1zEZFhl20PT9FCZfT4YQz5rTrca3bwV3YeDtIfdlQqC0MEFz+RdYirL8Jeel9N
 MxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZwN73iI5BwKeqzvn9l77NPsOkKx0RpBb4mLTp+Y4ec8=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=Am/9gmDOUjeebXDYdGJvpJC9F/9JeZ91TvMeWIBVceSBEfvmCS8q7QBjn0gDbNxs0V
 zDHRc52aYlkHKaNQfNLLgUjdbtA+IBznKYx1X/v4AoRMTFaXjpoWh6fRxdQ+HKnEuEvP
 KmWileL9hgEYJlo4Y/2htE0bZWh1ckSpGP/hLK9k7XRMsZ3ptYIu6fxbR15cxby53Utd
 1FQRgb4W0iOI+D3+VGbuNtqKFb98JJbPYcMuIXOOvExC6+IKQYmDsKw0XN8u5+0g06ZR
 NSwp4hlMlKR0jgN/bT0681GelQuKlLISS0cu8hNxwKjMuviFamUjIe7I3VQTbOdC3GE+
 TTZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781530423; x=1782135223; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwN73iI5BwKeqzvn9l77NPsOkKx0RpBb4mLTp+Y4ec8=;
 b=aSVY4JxrSNNOgcsV/IJz58BeKbn6gEUtSLl35eDt1A89E0xpR9OVQ2hEiAebE0kGEv
 84IO4vUCruAkuLHHHIcY3U4sGOfSQwideMmvdtCldIO9/uCBaDbfshugsE2/lndMsE+G
 2kOz2hkm1NEJEf5Wgj5EpcT17KPdpygSsRr2U4AgaYj5RU2nWN8ZovOMAoh5dfV41nG/
 bi6PrW2KYGQ4iqROIlUfgpj/4tj+w6nlDTzMnTeM5CFHfLwY671k5VhCY3dMlyefneeY
 NHzSrN2R2QmMyH3Z7pTW/Mt9g0DM6c/TN/W6GcAzrbRZynxcZeDwyZ8dBW3fRJUyV2Ik
 1lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781530423; x=1782135223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZwN73iI5BwKeqzvn9l77NPsOkKx0RpBb4mLTp+Y4ec8=;
 b=HkyKLSG3jf1ZcEe9Z3OlXxbJobMphBNKlaZ9RBct3s7KW5bKcMzmoWYTjnlI1DtHMp
 DGAiNZ9/DGzpVx+QuKKCSAggBkFyF2NHYn+DCkEI+3mtx9kfKbBolwb0zJoQawS6WhvT
 RXKVRBM+sT1/DXHn0Boe7wNBNTnQn1hjluykgRbfEnnamLhgsFe3iEfIqBinTSxmcGfs
 EA1s5EMEsmEoLMAmzoO9utXkQcxiSsvHAlSJy1AW0GKFgrJlER/cihHe9qxS40EfVdOz
 wVt+NpcwT31xOHBn/LfZgvlE8XcBxpnaYFItSITJCpFfsCQRY8tPzPwU5rKvSlrAKq3f
 iX9Q==
X-Gm-Message-State: AOJu0YxLV9w5xqmdZuv+WKJL0j5znATMqoSaBCDQhW0wkduyPCtiGIuY
 BpjlwT8OaN+1U8PpFtQViz9+zrnUrxfzm5k4uKxJ8wvGifGz64A9QZC/KsaxI0hw5c/6lcCyIyY
 +2/jaSKTYNcuMPd+TywY6nkslC1fY8VfFmDvA+TBqPTYO2nCfLHz97uB9lnHpMFFJN4WQMy5Hia
 lSSUfXJdjj7f0HG6IETJ5jXzqkbHRmR8qDtZHEQ91txw==
X-Gm-Gg: Acq92OHR+F5esuMNjb/QFR+qJuKfLU2BjBKIoZuzI1tU2OUC29CwHwysYiCb81tChTp
 WyvhTRamH6g5OjZ62PXlw4+HoEIcl4e3QJVZ6fY/vJFgY1BZmYjw63KvcRuseJvZ5jc7pJdNU1K
 nJ4LIHhkxSvauPjDZq8RTDOpV1i7T2R41ZQ/5eEv2ARQkQ61PmxIK1OJ2q3UC1EIVMZ3ZZ3fhi1
 /JXSZWAOU36aIPBO3/UDJE2wx2XHumfaCtjSgc7rQ8Xf/eXadJ7etPK71fWLIVTCYlSu+TwAxd1
 C4Cv0JU=
X-Received: by 2002:a05:6000:402a:b0:460:f4e:a481 with SMTP id
 ffacd0b85a97d-4607ebee2ccmr15546862f8f.34.1781530422757; 
 Mon, 15 Jun 2026 06:33:42 -0700 (PDT)
X-Received: by 2002:a05:6000:402a:b0:460:f4e:a481 with SMTP id
 ffacd0b85a97d-4607ebee2ccmr15546791f8f.34.1781530422211; Mon, 15 Jun 2026
 06:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-6-pbonzini@redhat.com>
 <87y0ggqdcy.fsf@pond.sub.org>
In-Reply-To: <87y0ggqdcy.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jun 2026 15:33:29 +0200
X-Gm-Features: AVVi8CcTv_SvM1ervCDcWrHRl9xKjY2feg-PQ5yni72bUhkeck9zathw5DPs9Ec
Message-ID: <CABgObfbAH_CiiGCF+BtLgkpxwQXS=8WMi8O2tqhC9=+TN5kfFw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] json-streamer: remove token queue
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Mon, Jun 15, 2026 at 12:58=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
> > +    parser->token_size +=3D input->len;
> > +    parser->token_count++;
>
> Note for later: @token_size and @token_count are incremented early
> rather than late.

Yes.

> > -    /*
> > -     * Security consideration, we limit total memory allocated per obj=
ect
> > -     * and the maximum recursion depth that a message can force.
> > -     */
> > -    if (parser->token_size + input->len + 1 > MAX_TOKEN_SIZE) {
>
> Left operand of > is unincremented token_size plus increment plus 1.
>
> > -    if (g_queue_get_length(&parser->tokens) + 1 > MAX_TOKEN_COUNT) {
> > -        error_setg(&err, "JSON token count limit exceeded");
> > -        goto out_emit;
> > -    }
> > -    if (parser->bracket_count + parser->brace_count > MAX_NESTING) {
> > -        error_setg(&err, "JSON nesting depth limit exceeded");
> > -        goto out_emit;
> > -    }

...

> > +         * Safety consideration, we limit total memory allocated per o=
bject
> > +         * and the maximum nesting depth that a message can force.
> > +         */
> > +        if (parser->token_size > MAX_TOKEN_SIZE) {
>
> Left operand of > is incremented token size.
>
> Isn't this one less than before the patch?

Yes.

> > +            error_setg(&err, "JSON token size limit exceeded");
> > +        } else if (parser->token_count > MAX_TOKEN_COUNT) {
>
> Likewise.

Not here, g_queue_get_length() was incremented before g_queue_push_tail().

The MAX_NESTING comparison is pre-incremented both before and after my patc=
h.

In the end the only difference between before and after is for
MAX_TOKEN_SIZE.  I honestly didn't notice, but it seems to me that the
difference is irrelevant and the new code is more consistent.

I'm not sure if the code before was written to mimic the two
pre-incremented conditionals, but either way the first "+ 1" does not
make much sense logically:

    if (parser->token_size + input->len + 1 > MAX_TOKEN_SIZE) {
    if (g_queue_get_length(&parser->tokens) + 1 > MAX_TOKEN_COUNT) {

and (unlike the second) would be better written as >=3D.

Paolo

> > -out_emit:
> > -    parser->brace_count =3D 0;
> > -    parser->bracket_count =3D 0;
> > -    json_message_free_tokens(parser);
> > -    parser->token_size =3D 0;
> > -    parser->emit(parser->opaque, json, err);
> > -    json_parser_reset(&parser->parser);
> > +    if ((parser->brace_count =3D=3D 0 && parser->bracket_count =3D=3D =
0)
> > +        || type =3D=3D JSON_END_OF_INPUT) {
>
> We need to check for JSON_END_OF_INPUT, because this is the one error
> that cannot go through normal error recovery "eat tokens until curlies
> and squares balance or we ate JSON_END_OF_INPUT".  Took me a few minutes
> to figure out.
>
> > +        parser->error =3D false;
> > +        parser->brace_count =3D 0;
> > +        parser->bracket_count =3D 0;
> > +        parser->token_count =3D 0;
> > +        parser->token_size =3D 0;
> > +        json_parser_reset(&parser->parser);
> > +    }
> >  }
> >
> >  void json_message_parser_init(JSONMessageParser *parser,
> > @@ -128,9 +109,10 @@ void json_message_parser_init(JSONMessageParser *p=
arser,
> >  {
> >      parser->emit =3D emit;
> >      parser->opaque =3D opaque;
> > +    parser->error =3D false;
> >      parser->brace_count =3D 0;
> >      parser->bracket_count =3D 0;
> > -    g_queue_init(&parser->tokens);
> > +    parser->token_count =3D 0;
> >      parser->token_size =3D 0;
> >
> >      json_parser_init(&parser->parser, ap);
> > @@ -146,12 +128,10 @@ void json_message_parser_feed(JSONMessageParser *=
parser,
> >  void json_message_parser_flush(JSONMessageParser *parser)
> >  {
> >      json_lexer_flush(&parser->lexer);
> > -    assert(g_queue_is_empty(&parser->tokens));
> >  }
> >
> >  void json_message_parser_destroy(JSONMessageParser *parser)
> >  {
> >      json_lexer_destroy(&parser->lexer);
> > -    json_message_free_tokens(parser);
> >      json_parser_destroy(&parser->parser);
> >  }
>


