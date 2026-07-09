Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE41C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoaK-0006N1-10; Thu, 09 Jul 2026 09:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1whoaI-0006Lt-OJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1whoaG-0003iX-Je
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783602871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ff9of3gQAf3TrcAOpc8NcVn26B1exStJ8KAobCH3mME=;
 b=XkJYuHxHdlX5RUA08Li9qEifCFULYO4KqzG13vd55WiYnnc7xOq8cYeiVMLxFFI8YLTVxY
 u9+A0wZ3bXkaMxmGV6a4yodP+KbgusSeIDOUcUxHBf2wSeyhA1eTtkCZjrQfj+UjltRB1z
 ItbzH9DY02I50PN7DaUYhPIYfcWtcfU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20--uUpS1WmOxmEk_1ha1nkYQ-1; Thu, 09 Jul 2026 09:14:27 -0400
X-MC-Unique: -uUpS1WmOxmEk_1ha1nkYQ-1
X-Mimecast-MFC-AGG-ID: -uUpS1WmOxmEk_1ha1nkYQ_1783602866
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47df02a953dso965102f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602866; cv=none;
 d=google.com; s=arc-20260327;
 b=dFO1K6rQTat+5SNnK3oUAOn4ujhy9PcHaIJDBdQYUp67P908NEaOzHQEKTDPDruPaQ
 sxi337aZzFhvhEl1N8pfhhAZTRdQlgYj855aK5Pl020uSJQ8RBoJZNwYnNVLpBoZhECQ
 C9uB67zvADFTpbkbCcK+xV0IQBs0riJ2j4z1stp6V19QkrIO9HPtdPGIRiDDqwEhrW7W
 ZSQODLxtWy4vDrjNsRDaxi5fOZ28XF0Kbhb6Cgn38sKu88mharo6ltIHqwtolB3Qzt3q
 rRiJcfnZfxyOTJ0OdbV6jegUilvVicQPReK3wm5oNNIM82DQsYtp6tVvtgEghlHQRMKK
 dKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ff9of3gQAf3TrcAOpc8NcVn26B1exStJ8KAobCH3mME=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=dVEWW6IeQP74OwB2fn5cXLXThS4TI2MyhphgkIOOD3aplVNPhZP/eTimzByBW/h4WF
 +1Os4jMLovYrxcu28UxC1Y5Mp8u3U2OgS4pNiPzdNPG5mmncri5G0GZ0KK2BOIEkDEcr
 kDRx+6EE4jNgzOYYp/Vpvyf4uY3AbhKvm75kqkrxCImM7AhKmRUdSyvpGI/iq2aQwZcz
 0UcSmE8HS0Su2eTOse5q23KSoTHEuAoO8BdVMf8zdsCOhBeu2O899XNcFrHQzsmY2DKI
 0I05FTBe6RB0y9mzGfXdRTy2icWQaVJIIQkjc2UIbAjHtcASJrLTFPpQHxfhlHZnYf8S
 +9GA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783602866; x=1784207666; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ff9of3gQAf3TrcAOpc8NcVn26B1exStJ8KAobCH3mME=;
 b=pfh/7lCfc+JPNtIKi4gZQQpudHvBBu/TQzU9ZK9elPJqNtLNOFLr9mOiLkkSe6h9BV
 Y53sbgO8gKpql+YRMdb7uuQZUxIwIpNoMwpx1Cwywne4JCdhuayDH//J8CNLK6UCMsbc
 lEtOUZfv77rKO0rAs5UlGrMALovYrFZcMTg3k14Fzb78lXpPhjvAW+4+pPE/D3tqusjb
 8eOingo3r0T7GV5rHU8cTt4VIKjJQwvM9uZtS4eZLVfui2QAfGm1n9oVlAqhdiWidDxh
 oQPlLRkriX1pnpEqToS2x903VxKSyCoA1aRHzfJkrovCe4dUq1UIOpC5Bk46uX7zzb8j
 ZL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783602866; x=1784207666;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ff9of3gQAf3TrcAOpc8NcVn26B1exStJ8KAobCH3mME=;
 b=hWyHK4KHT9uW+9lfdvf8r6mwXqgHa3KJ0UwcfOYvwcUP9xnyMr6G57L6+NSQ7peoUS
 U639Bzqv2KiYh+LLaf9H5BxsITTzJvxfZaxBhrzXRTvvfAU3JvXZ/YK+bQrNuosEY54n
 XR0x+wcC/KwWA99LzNTeo4IJpELhaK6hbnINzs2CDU1APs4HF8gUM04ynlcTdtdTy7qS
 NnS78hCGK24PRNSkq7esnrGUkTfojTnSYxwdo3jGYzRqaRjZB+7lLccIFUgaiIJWJXwY
 aJUAoKXHIR4QCN+3y1lugM+eN3H9u7jznquY4GzgPBdy7UWbIM6TabzifUV8ZkBS2GI8
 h+9Q==
X-Gm-Message-State: AOJu0YylssnF2xy2C5xkvgQWQq3zpQJogwicIz3mnCwQVywCqcDJrY3z
 KBfE+UEsouGHlEGlgg6zXM81xb4YLDQXMMsUQJYbafPgbW33AQnVLQfle0tcHG1RMKcVFs1m/la
 yi+7r5xwdBh7ZBiVjTtrG84a7XWyuaLmkDgCwrDcdEkNoWqoqwuoMoBLIcOEofHwPmoCSely/vo
 zZEe0AFd4zTqlDcWShW8S4biEIpn8uzDavVU/MQZY=
X-Gm-Gg: AfdE7ckyTfvhA5prJi+rb6znCTLACbqZ1XBXntogEWYqxN9C80rU5Wv7TtquvAf8NDy
 Qfpz3wit0lop3UItdQKbwdwSb3a152MdR253qnWV9smgUAoq+8FY+xlNTdnaE7djgMv5wxH+qda
 hqyWGBbz2+3wBMFX6+2GpK60Lb99LEF95x88LDLrq6CtlAz1EUpW15qkPPa4sWNZw2C+K4LoTJJ
 s98b5CvdeN0iHxtnoyXOpBVeiNXrUZNEFNzC2+YP40WxiiyBoptDt8vCMs61bscVbCDhQ==
X-Received: by 2002:a05:6000:2509:b0:475:da0e:744d with SMTP id
 ffacd0b85a97d-47df754dbc2mr3206708f8f.8.1783602865604; 
 Thu, 09 Jul 2026 06:14:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2509:b0:475:da0e:744d with SMTP id
 ffacd0b85a97d-47df754dbc2mr3206640f8f.8.1783602864663; Thu, 09 Jul 2026
 06:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260626101727.1727389-1-pbonzini@redhat.com>
 <877bnhts6s.fsf@pond.sub.org>
In-Reply-To: <877bnhts6s.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Jul 2026 15:14:11 +0200
X-Gm-Features: AUfX_myPi1KClK-HEUK7-J8O9tD1ELxH2FnKhEwqV2RhcZq0iC-vYapIHk87mJM
Message-ID: <CABgObfawRL4Tvx2mrUE9iGHbeUBywsA56SUbX4_07SjbpXE79g@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] qobject: switch JSON parser to push
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002b809506562d6779"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--0000000000002b809506562d6779
Content-Type: text/plain; charset="UTF-8"

Il lun 29 giu 2026, 15:03 Markus Armbruster <armbru@redhat.com> ha scritto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > This rewrites the json-parser to use a push parser aka state machine.
> > While push parsers are inherently more complex than recursive descent,
> > the grammar for JSON is simple enough that the parser remains readable.
> > There is therefore no need to use e.g. QEMU coroutines.
> >
> > Unlike the suggestion in commit 62815d85aed ("json: Redesign the callback
> > to consume JSON values", 2018-08-24), I kept the json-streamer concept.
> > It helps in handling input limits, it performs error recovery, and it
> > converts the token-at-a-time push interface to callbacks---all things
> > that are more easily done in a separate layer to keep the parser clean.
> > However, there is no need anymore for it to store partial JSON objects
> > in tokenized form, because the current state is stored in the push
> > parser's stack.
> >
> > Another benefit is that QEMU can report the first parsing error
> > immediately, without waiting for parentheses to be balanced or for a
> > lexing error.  Error recovery then proceeds as before (i.e., the next
> > parse still starts after balanced parentheses or a lexing error).
> >
> > On top of the benefits intrinsic in the push architecture, it so happens
> > that it's really easy to add a location to JSON parsing errors now, so
> > do that as well.
> >
> > The diffstat is unfavorable, but most of the new lines delta is really
> > new comments explaining the grammar and state machines.
>
> I found an unintentional, harmless limit change by one, and suggested a
> few further comment tweaks.
>
> With the limit change reverted or mentioned in the commit message,
> series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Revert or mention as you prefer.

>
> I volunteer to do the pull request, since I have another patch for
> qobject/ queued up already.  I'd apply the changes I suggested, less
> ones you disagree with.  Let me know!
>

Sure! Thanks very much for the review(s).

Paolo


> [...]
>
>

--0000000000002b809506562d6779
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
&gt; This rewrites the json-parser to use a push parser aka state machine.<=
br>
&gt; While push parsers are inherently more complex than recursive descent,=
<br>
&gt; the grammar for JSON is simple enough that the parser remains readable=
.<br>
&gt; There is therefore no need to use e.g. QEMU coroutines.<br>
&gt;<br>
&gt; Unlike the suggestion in commit 62815d85aed (&quot;json: Redesign the =
callback<br>
&gt; to consume JSON values&quot;, 2018-08-24), I kept the json-streamer co=
ncept.<br>
&gt; It helps in handling input limits, it performs error recovery, and it<=
br>
&gt; converts the token-at-a-time push interface to callbacks---all things<=
br>
&gt; that are more easily done in a separate layer to keep the parser clean=
.<br>
&gt; However, there is no need anymore for it to store partial JSON objects=
<br>
&gt; in tokenized form, because the current state is stored in the push<br>
&gt; parser&#39;s stack.<br>
&gt;<br>
&gt; Another benefit is that QEMU can report the first parsing error<br>
&gt; immediately, without waiting for parentheses to be balanced or for a<b=
r>
&gt; lexing error.=C2=A0 Error recovery then proceeds as before (i.e., the =
next<br>
&gt; parse still starts after balanced parentheses or a lexing error).<br>
&gt;<br>
&gt; On top of the benefits intrinsic in the push architecture, it so happe=
ns<br>
&gt; that it&#39;s really easy to add a location to JSON parsing errors now=
, so<br>
&gt; do that as well.<br>
&gt;<br>
&gt; The diffstat is unfavorable, but most of the new lines delta is really=
<br>
&gt; new comments explaining the grammar and state machines.<br>
<br>
I found an unintentional, harmless limit change by one, and suggested a<br>
few further comment tweaks.<br>
<br>
With the limit change reverted or mentioned in the commit message,<br>
series<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Revert or mentio=
n as you prefer.</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quo=
te_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I volunteer to do the pull request, since I have another patch for<br>
qobject/ queued up already.=C2=A0 I&#39;d apply the changes I suggested, le=
ss<br>
ones you disagree with.=C2=A0 Let me know!<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Sure! Thanks very much for the re=
view(s).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--0000000000002b809506562d6779--


