Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592EAD73E83
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 20:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlYXE-0005EK-R4; Thu, 29 Jan 2026 15:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vlYX6-000580-Rq
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 15:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vlYX2-0003gn-EI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 15:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769718142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QM/gqFGcfq+LdAu+4JjERcoBvS4MaCtU+lGY/3Ix/0=;
 b=PSfdvOPxI5+cmj79ugwnGkVKKASsBWgEV+4jSxsgRVo8wPDcbhXboSw0Y6iJ7LILc3sv28
 EzzCQ5h+Ew6Nv0+3NkJAYWGomeDxr+DQfQZBk1D8d+kHuJXMpSu4STEGohS93iUL2ih50l
 w4Q9hG6kgYPhj7CJzG8ZTjublvMWldU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-bZGXmYYxMViGJ3JPIZOBhg-1; Thu, 29 Jan 2026 15:22:21 -0500
X-MC-Unique: bZGXmYYxMViGJ3JPIZOBhg-1
X-Mimecast-MFC-AGG-ID: bZGXmYYxMViGJ3JPIZOBhg_1769718140
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430f57cd2caso1283892f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 12:22:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769718140; cv=none;
 d=google.com; s=arc-20240605;
 b=PKLge7fnd9u+mMV9WxX46rXH2UNYlopG3XeZGe/UcvpMO0igVxiWXQb5zZ7zHqMk9Z
 6vOl8DnWjKhpF+Yymg3asEtZfxyMxyRKPUuP3hoQb5FXG9A366ciVtGkLJbauIRvNa3a
 x5lyxsFqCl9T5JvPwcDd2TjIOgNKHLiKB/1to9GhypAOqMCf+OziiWVsJLeNgDu/Pji2
 GWlI1vJvzDi28l0ZbSRa19bsGtSZjWtLCPCDVGDPClf6MH07tp4gthCg9wEJ0rxxjPUo
 00dMtKQjg+xem7P+lmzYn/Vjplyt6Y5b7Eaz9e1bF3LlwiD5G1XCdVNrgRixl9soz9q4
 v4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0QM/gqFGcfq+LdAu+4JjERcoBvS4MaCtU+lGY/3Ix/0=;
 fh=V2W8sTfabQNmr4acpzcUDhhoALT6OAdwHmyPQbZOdT8=;
 b=B9p7y8wwxxNuuIvtY2ODYZAVrsHtZR09RdFATgsO6Mo3j10+/eqNtXUb4koytz420E
 2A/lEbe0x4SdaF+O0ae2YlCm13QOZ0JTpxdSjCpUehdEcBjNcYMU1gyRIJAudZQMeaYm
 Mkcmd0415VLix4YQsSlUVmtKfFQJu4b0qDLf5fiXouY5P5uyhaUECeSRRRVFoRs/swFt
 ST0o68aS9Et43B/PjMQiKncx1awk7CCNsIKyuXmb1wlmebAogMnokMVBdyRFziRfFM/T
 08XMX/keO7S1XGkd53jgo7Oejc6pf0Dluq4hI9IhgHmMZQSbUJeD1SZwyYSL0EvZbFmA
 ZI+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769718140; x=1770322940; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0QM/gqFGcfq+LdAu+4JjERcoBvS4MaCtU+lGY/3Ix/0=;
 b=ZkBsHJ+xGERSre/t7lmUGjX6my/q0Q8TsoRcBpNWDP2iQ52ROImr9oFUO5WyAV4Q5j
 q0NKOnT2xsZMFx85Caigy+l1NSZK8bbFIHimFgTbSw1g3gwwQGPPxF4wIInO72XuWqjL
 iVw16o0hfIyjICS9mYbut96zHhSzKSejSpsi3bs+VlRUpCMlibHPm1j/r3K9QWi5DIFy
 AmHgGlTBU/eU+6Y0YrzkCS/ZjwWwahlIB6Xx/41XR0W46Zy0yXZ9ylgufnigffr0wGXb
 2ZJ/p5aN26KNCXPD0VtYkERpVSXA4pbDCqkvSLVPw0x4bJDpUQg8Mt1sMOSy/XfgCYmP
 ti1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718140; x=1770322940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QM/gqFGcfq+LdAu+4JjERcoBvS4MaCtU+lGY/3Ix/0=;
 b=AvPNopVXV+qa23pxgjZbxmB+6GhashfG6upWirkuYJQwNVVyCEdFEbcpZkvhL1j+wv
 uk+dD/NthZpzmk0g7KsbK7TjDuKzkM1hkTgdxyprWBhumlgEDvE5Xq45/7xPinF0C0i4
 x0rvvxmuQlhfl4ePZzmKuVVJJB8yIPOw/qHtxRUePxvgb50z/LbIIrsCXmmXuChp2u/P
 btIHocUQLTyF0gdGYPRFX8O/jUkYBOf5GMKBhyyJ+PgqbYxpCaKIxjZauHMzqW/UHHbX
 uPIk1+aSgGtDhDG6e4x3DSiYzCO7d8FcSmIIUiBe4blwKQFWJQjtHULTlP02uXA404aQ
 Dc1g==
X-Gm-Message-State: AOJu0YzhHF6K/Mx76IqcWpCJ7of0aSvXOnBsPXOTHb0bge4G5HUFzJo2
 k4gTRff3tDtsWLBMAPkX4YwKfcjrZ5BaEj52fxhinDfxj7PnkVCJ4QYx855bO/crip9aSuvQE00
 aDfkS3oP8+3djsFgiMwYIzLZCjNXcLpMFWbruk5MYwbWcO2/yRBNAK2GvJKTUvVpAiwwutL1k6+
 3SIxAdGdF9+Kj7nsU5AP0QcQKCeD4i17Y=
X-Gm-Gg: AZuq6aJX1OvfaBoIbw4rwb4v8QVqN9MOe8P2CzEM2L+ii2EBrssZtByDFlcK80RVnE0
 1AIRlcUUvpdePhqzSh7MTv6pFJ37ILzpyUgvaDDu2EUmuB3zUPJ93SMn2oMqnQY4EAWWVv59D1J
 QaLQzdWSQm1Y7C5iY/o5QmQ4PRqI+pXuvM2k4g4lrNNoqBL1pdUan14CwhBJLIB6Qr0xgLhdjpm
 xIYAva1WmJVccFTzJZnwFzigBjOyx/xKxK94l9/BMTSW8uAAa9QKHRHRbKVV3oQ4UokgQ==
X-Received: by 2002:a05:6000:2889:b0:435:a0ca:bdca with SMTP id
 ffacd0b85a97d-435f3abb3b0mr1168491f8f.57.1769718139699; 
 Thu, 29 Jan 2026 12:22:19 -0800 (PST)
X-Received: by 2002:a05:6000:2889:b0:435:a0ca:bdca with SMTP id
 ffacd0b85a97d-435f3abb3b0mr1168467f8f.57.1769718139344; Thu, 29 Jan 2026
 12:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20250908101241.2110068-1-pbonzini@redhat.com>
 <20250908101241.2110068-20-pbonzini@redhat.com>
 <mvmqzr8hjrp.fsf@suse.de>
In-Reply-To: <mvmqzr8hjrp.fsf@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Jan 2026 21:22:06 +0100
X-Gm-Features: AZwV_QiiJRdK-3YeftWr-8G76n62uiUnGP7I8qeWYutsieQy-aotVYe9Q3fMBas
Message-ID: <CABgObfYWC1OHHyfWCxzV92K9jAfpOGnpNLNoA-FC0-_yKNRAFA@mail.gmail.com>
Subject: Re: [PATCH 19/19] tcg/user: do not set exit_request gratuitously
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000c707106498c9d02"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000000c707106498c9d02
Content-Type: text/plain; charset="UTF-8"

I assume you have already tried to revert it?

Thanks,

Paolo

Il gio 29 gen 2026, 10:11 Andreas Schwab <schwab@suse.de> ha scritto:

> On Sep 08 2025, Paolo Bonzini wrote:
>
> > Whenever user-mode emulation needs to go all the way out of the cpu
> > exec loop, it uses cpu_exit(), which already sets cpu->exit_request.
> >
> > Therefore, there is no need for tcg_kick_vcpu_thread() to set
> > cpu->exit_request again outside system emulation.
>
> This breaks go.  If you run go build in a loop, it eventually hangs
> uninterruptible (except -9) with a couple of zombie children left over.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
>
>

--0000000000000c707106498c9d02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I assume you have already tried to revert it?<div dir=3D"=
auto"><br></div><div dir=3D"auto">Thanks,<div dir=3D"auto"><div dir=3D"auto=
"><br></div><div dir=3D"auto">Paolo</div></div></div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">Il gio 29 gen 2026, 10:11 Andreas Schwab &lt;<a href=3D"mailto:schwab@sus=
e.de">schwab@suse.de</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Sep 08 2025, Paolo Bonzini wrote:<br>
<br>
&gt; Whenever user-mode emulation needs to go all the way out of the cpu<br=
>
&gt; exec loop, it uses cpu_exit(), which already sets cpu-&gt;exit_request=
.<br>
&gt;<br>
&gt; Therefore, there is no need for tcg_kick_vcpu_thread() to set<br>
&gt; cpu-&gt;exit_request again outside system emulation.<br>
<br>
This breaks go.=C2=A0 If you run go build in a loop, it eventually hangs<br=
>
uninterruptible (except -9) with a couple of zombie children left over.<br>
<br>
-- <br>
Andreas Schwab, SUSE Labs, <a href=3D"mailto:schwab@suse.de" target=3D"_bla=
nk" rel=3D"noreferrer">schwab@suse.de</a><br>
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE=C2=A0 1748 E4D4 88E3 0EEA =
B9D7<br>
&quot;And now for something completely different.&quot;<br>
<br>
</blockquote></div>

--0000000000000c707106498c9d02--


