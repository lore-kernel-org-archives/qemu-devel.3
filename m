Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BBED2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoj4-00049T-5M; Tue, 27 Jan 2026 14:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkoiz-00043b-CP
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkoiw-0008O2-OU
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769542057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7C87c+oXop3Nrxoq35ExOCav6W87ao0ehs1QscFFxOA=;
 b=NHp0fQKqvAd0GDfZBszo+fpe9shjWgNJq0+JRs6B1E4oONnd9B7vX32IhTgdTOYNqUGZ2b
 g4/sYU/sESFEzrUug711O4dLiLcdnb92Pvpv9enxAuHtPJR5nzvFEyi5/txCfhOKH4/x0L
 hn824xU87jpqkq7T2PDQwA2FmLZP7s0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-WaAwQviFOhKsZXRHNH_dPg-1; Tue, 27 Jan 2026 14:27:33 -0500
X-MC-Unique: WaAwQviFOhKsZXRHNH_dPg-1
X-Mimecast-MFC-AGG-ID: WaAwQviFOhKsZXRHNH_dPg_1769542053
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4804157a3c9so62709255e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 11:27:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769542052; cv=none;
 d=google.com; s=arc-20240605;
 b=lE7JseR2zUFAfEGI8z5iMfIo58OoTHuAPKyK/tsZCpap3bndkfB1SnN5HAzq4EZC/s
 IErel7PCT/oeVEoaZrGtI5afYyGuLRVDyI8nFXJLFeq7NtswsTOFYnaOMxl10Ev0BCkK
 DcuQJr9EmzHrtRcUF3Unavib0zq7kdpw+n9F/oxh6MORMKlQluKIUmcPbCwX/jjdYgM0
 2VuC4UzzhnfMjAOv1SldIqzUy4lIE0GdikvzgUBgJW6BfI5DaMp6GqtZ2LGLAWff9cPS
 wFxmDKM8FtG2JvDYezH+wNqtH58OkTpkDyVqArBuI+CXmPWNrZ/4HzaB8IUS3jhjwlod
 zaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7C87c+oXop3Nrxoq35ExOCav6W87ao0ehs1QscFFxOA=;
 fh=3KLjqEvM5FT2I6thDr/rJoFSAGNSId2rT4Qt37s6ei4=;
 b=F7Cf2ncmrFCdY7qMhu+BozZouQvHBzZJkriWBIA/gDaYz6XYJ0r+8OKTFCROngEeSq
 4sij/MXUkxZvFEw5j8PMP8+5ctNVweF6eZFvfHgkfDkB9lSzV5jo9ltPM0dq2iz1o7fh
 yLiE0Rsyt39d2OJppxs++cipfeni0TB3zRdQCH5I3ID8s79hRiSaSZyubeTiCd2XAMSw
 oFsU8OLMrDJafTdAqFNRTf84+fjybjoTbqFwMY22mlPnoZ81T40icOHnVb5LXJqafAiL
 dKUGon0EszZA5MGx7oWENWY1xPcgrV5PhjbXwhxwGj4x8WN8LD27TJG9zsbfnyIXB5PR
 weUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769542052; x=1770146852; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7C87c+oXop3Nrxoq35ExOCav6W87ao0ehs1QscFFxOA=;
 b=iOF/6PlX7B40QVlLT3whIFqBa+0azZi+l2g4wfjYuW3l9jwnA71wxQTAXQAndIIUvN
 mUcxa27pZz8U/2gOlpJO2LsQPX3g2ZvnHU+YmyKv92b3yGCBFOCBRC556yyKHC/fTTky
 yrQ9PUVfwDMQU1NiobbvlhCyiQpWKuZnhOHjRafeiqlOJxMPg4WBI4EJmW/+eVq9WRQS
 0J/CsDsrryFB8pv6CxxF5h9Z/eZnH99CRfJK8E/l8r9mP8P3WQG5kszjIHCMuJ+umpk4
 XcPcZ0eT8R55NfJ066U77sWsU6pX9eAxhv3K1dJU5bybpDl/PfWYy/EEnGfkJ5hVfX1U
 NpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769542052; x=1770146852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7C87c+oXop3Nrxoq35ExOCav6W87ao0ehs1QscFFxOA=;
 b=SnRqgA94rQ9TglCs76WH1f2azbgHwG45jSzrWmrqluALlJe1asoDqhqC2Vz4aKs2n4
 tsNBQkxgy0LQzoKUqtUgWXEW2w2vrnF35x1eH4vHK4KXHmd0CaOJ4HFZXtCg6zgLoJxK
 pfvRGlx/zLHq9PFjSO72vViSlWDA6NWFnMzhiUJpdaZI5G9+7doELusQHqwKF7e+RfBR
 qOVzDgfryktzKS2udMG4h9+Ng0XnPvSrq41LovNZjSHnHMnV3YkAyiT7YU8vcoCvXaQX
 GgbGcydp6z2H8SsYECd87pgvD+e7WPiCf6Tpx2ZqI3cvCkAoSm3pAF42pRTM2IHn4/XL
 rGkQ==
X-Gm-Message-State: AOJu0Yyo6AVpG+MTq7G7wtmtQzv/f6IN/OI2JMpg/B7UOEZjfDawRaE4
 nrebGAwiSNFrm6LArOYNPF3BL/88z0KrwTTAeUcFaeR49JglRotvOi2qu84hlUqVJuNwidD23/L
 jO+oJXg4/+JC73hRjOy37CBzoo+qweHjYuTJOuRq/EY41HpNZYNFZlmaMgCByARp6EF9tRsg0nR
 ZTLCiT54CzV6HZ0kvZqac3uCHI3MzMXMgdXckTZXQ=
X-Gm-Gg: AZuq6aI/2TQX9SKbFmersz2zivk6AhbuU6qcq/cis3cW1RKNI9i7Imd7/ZkQAeAgTyV
 Yq4MzYr9mhMu4svU28YsnZJDY07VbWOiQ4fdqHSQCQaki1RlU46IuK3+1cPafnesSriRcSsUb/y
 WqfPCdBcYR8oZppJCo6LdPgKLhGRgB4R9v52JFnyFccNiIpXr81C5dqifEp/sUmPI5uCf/sHG7c
 gwKkCIIGscER7lSUUaEOy5Fh6u1Q3EL/ujuetWtCg70fDQxXT/Dd6HocykX22LUWFHLxg==
X-Received: by 2002:a05:600c:4081:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-48069c1b310mr24307125e9.9.1769542052179; 
 Tue, 27 Jan 2026 11:27:32 -0800 (PST)
X-Received: by 2002:a05:600c:4081:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-48069c1b310mr24306935e9.9.1769542051767; Tue, 27 Jan 2026
 11:27:31 -0800 (PST)
MIME-Version: 1.0
References: <CACSvEXYX1fNYT1jgcob9TSUJptUBEvZRu-DKC6yDFhRHFK3rCw@mail.gmail.com>
In-Reply-To: <CACSvEXYX1fNYT1jgcob9TSUJptUBEvZRu-DKC6yDFhRHFK3rCw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Jan 2026 20:27:19 +0100
X-Gm-Features: AZwV_Qj9GN6lNePmvZIxA6ru0lPj8t0v8H23dXwiM6eLwwE0hEWRRtySo811hjk
Message-ID: <CABgObfbQdES=pw9unxqFgw7AhD22Aa0vRbGf5tsE9QPd6CXaDQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add CMSDK APB Watchdog device
To: Mohd Kashif Khan <kashif04x@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000069409d0649639d55"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000069409d0649639d55
Content-Type: text/plain; charset="UTF-8"

Il mar 27 gen 2026, 19:20 Mohd Kashif Khan <kashif04x@gmail.com> ha scritto:

> Hello,
>
> Here is the updated version addressing the BqlRefCell and Kconfig changes.
>

Wait a minute... I have now read the patch from top to bottom, and it makes
absolutely *zero* sense.

Suffice to say that there is no watchdog functionality.

All this means only one thing, that you are using an LLM to generate this
code and:

1) not telling us (bad)
2) not bothering to test it (not acceptable)
3) in fact barely looking at it (disrespectful)

Even ignoring that QEMU has a policy not to accept AI-generated
contributions... just don't do this.

Paolo

v2 Changes:
> - Switched to BqlRefCell for thread-safe register access.
>
- Added Kconfig/Meson switches to allow selecting between C and Rust
>   implementations (matching PL011 pattern).
>
> Thanks,
> Mohd Kashif Khan
>

--00000000000069409d0649639d55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 27 gen 2026, 19:20 Mohd K=
ashif Khan &lt;<a href=3D"mailto:kashif04x@gmail.com">kashif04x@gmail.com</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div dir=3D"ltr">Hello,<br><br>Here is the updated vers=
ion addressing the BqlRefCell and Kconfig changes.<br></div></div></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Wait a minute=
... I have now read the patch from top to bottom, and it makes absolutely *=
zero* sense.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Suffice to =
say that there is no watchdog functionality.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">All this means only one thing, that you are using an L=
LM to generate this code and:</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">1) not telling us (bad)</div><div dir=3D"auto">2) not bothering to te=
st it (not acceptable)</div><div dir=3D"auto">3) in fact barely looking at =
it (disrespectful)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Even =
ignoring that QEMU has a policy not to accept AI-generated contributions...=
 just don&#39;t do this.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div dir=3D"ltr">v2 Changes:<br>- Switched to BqlRe=
fCell for thread-safe register access.</div></div></blockquote></div></div>=
<div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"=
>- Added Kconfig/Meson switches to allow selecting between C and Rust<br>=
=C2=A0 implementations (matching PL011 pattern).<br><br>Thanks,<br>Mohd Kas=
hif Khan</div></div>
</blockquote></div></div></div>

--00000000000069409d0649639d55--


