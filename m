Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E2AC9EC97
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJQh-0007PS-VI; Mon, 12 Jan 2026 10:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vfJQ7-000745-UL
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:01:38 -0500
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vfJQ2-0002V9-50
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:01:25 -0500
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-121a0bcd376so2067223c88.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 07:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768230080; x=1768834880; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ThEvLJuoQlbDVp/MjfS1IGPuOj7tAq/NpjKIyC7cYWg=;
 b=lxbbE79Icr1MB2pk0UDpduEa/9V6fBlz0WtKmOZDrabqEzzHtV05EOymSzSRx9ISrI
 Rq6TDDRAsjG+p68ceZTatU1z1hcrH49lY6kzY6E2QTSaUzJlr3KJd1QGpXWe3TWEXdtm
 +TLWvaWrHcg6u/iQgjmGCWauRveRucdwhtxC5YzTD7wpdHBbJtALjd4dn3ZXZgqdzit4
 3EWqNj06j6FnPJf7O2/I1TpvlX2TmsOmcXUa308xyOIjRRkr0fScy/cr6WkDGV+uWXJa
 K1uL6BldZf4I32C9RVP0a12Ho5WJw4xMp7peWRfwith+lt4aP7XFaPzNVw+dKzQPcTRU
 W9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768230080; x=1768834880;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ThEvLJuoQlbDVp/MjfS1IGPuOj7tAq/NpjKIyC7cYWg=;
 b=HXPrdH9RZk+wc6MaRUbBEpMBgS6k9dtlsQS1SxZmtg254d9AiZNIPkhQcVcCcj1PUe
 9Eo0l7+5kwmhbcJmGR/STMqKgavFzkZqOWdk8VLgNaIFG7mUwAw8RH0VFWw0JRzb8he9
 Ok+QZmJDNkPnK7If33Qxiv6UnAfj4tyFONckUgMbYILm462HX0NSqA4fK/leCZOgSinA
 gb+MF+ll2GwPd6OIcNAzTxtpkIThIdlSKYMjB5wR0KEQL18lN4ibeILrBV3n9/0CDe2H
 /n5HJ10ByFxofwQWmo0c2IbSP4knwzbvyfqmoulSRi4e+61jIeMQnxY1zsBL2UNElkFh
 QF3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Z9AbBNDI+tCnpgjk1PknNFM/ElaVIKAKF16SOL4HNbuM6nlzVqnesBsAU5aYSvuvVHJXSJ3QfNTu@nongnu.org
X-Gm-Message-State: AOJu0YwqNpfoJoYvh3npqj8kgsHijon8X/ntUzGPBWXj6MvReCMWucms
 FgJMpULnfX+WSVFk9DvIpwhJHfmQbQBTLwvDkR7IaliXgiRd9tOX9D5sAZy7zWzuVVzQoKTYGUA
 Z03U1VwjxWJsXJCFWphuooGMlj4ioOJf4SvjLF7M=
X-Gm-Gg: AY/fxX55yEg8brp29uz+anshnGRWqCzZ/yzt6EhoodBo+o/mJFOWzb1G3/i4z4daBE5
 DaSQ8F5nZzF/Hzehh9t+mFxiak4ukZ1JaKBovmdKScsb1Q0Sm+iwI53sOltxioNT32cRFwrms4D
 +J97HTbqO2eZrP56ARJGKWaTgn7Lv2jopxe+SL30gRq8tKkDUBKONRc1In5YJPgx9DsypHu7Al1
 6ATesuN8NRZLtLwxqILbVL47+097ZmhMyQyPXnN2VwlOdEFzohg/iMp953x+MwohGbMrXDPNgCN
 U7+UbGpPynA/f4aNCcplClrX8Q==
X-Google-Smtp-Source: AGHT+IFZbX++dUbLcLky7wC/90mrS5u2Egrh+/ayMfkgvQNJZda1O+AyESeK5wHKdfDX9qbSSHXI1dHVMxyZodlP3Sw=
X-Received: by 2002:a05:7022:6b92:b0:11d:fcb2:3311 with SMTP id
 a92af1059eb24-121f8b43bfdmr13486242c88.27.1768230077303; Mon, 12 Jan 2026
 07:01:17 -0800 (PST)
MIME-Version: 1.0
References: <3b5ddc4e-f631-4412-9fd6-ebbf49c55ab2@redhat.com>
 <afa3adb6-a94d-4ed8-b5fb-50071b5d4b22@gmail.com>
 <f30d20ff-ca96-48eb-b837-b3332ef4559e@redhat.com>
In-Reply-To: <f30d20ff-ca96-48eb-b837-b3332ef4559e@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 13 Jan 2026 00:01:04 +0900
X-Gm-Features: AZwV_QidRHUe9OhX7_gnKG0P65KHRk-FDTDEq7Zs7BPHSnaQBZa2m_iMrm9JjlU
Message-ID: <CAEDrbUaTn3r_nmE8=nQQgeSy5WJNWzf9ZA8xAoRx4RYrGtuJFw@mail.gmail.com>
Subject: Re: [PATCH 00/50] Remove 32-bit host support
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a38d170648322523"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x1236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a38d170648322523
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

> What is the performance of lowered 64-bit vs. the TCG_VADDR_BITS
> approach?

For comparison, I ran a gzip compression on 500KB data using an x86_64 guest
[1]. The TCG_VADDR_BITS approach was 1.14 faster than with -sMEMORY64=2
(approximately 18.8 s vs 21.4 s).

> Also, Emscripten's -sMEMORY64=2 is okay for TCI but it would
> not work for TCG; you'd still need TCG_VADDR_BITS to be able to produce
> wasm32 at runtime, which makes -sMEMORY64=2 only a stopgap.

Yes, the Wasm TCG backend needs to be aware of the target host configuration
(i.e. -sMEMORY64=1 or 2) so the current Wasm TCG patch set [2] propagates
-sMEMORY64 value to the TCG backend via a macro.

> So I think we should go for TCG_VADDR_BITS anyway.  It's surprisingly
> *un*invasive.
>
> I assume wasm32 has CONFIG_ATOMIC64?

It has CONFIG_ATOMIC64.


[1]
https://github.com/ktock/qemu-wasm/actions/runs/20913930555/job/60082798942#step:4:14
[2]
https://patchew.org/QEMU/cover.1756724464.git.ktokunaga.mail@gmail.com/a507277f4b40617655ba1c94963ef42c78ebbcca.1756724464.git.ktokunaga.mail@gmail.com/

Regards,
Kohei

--000000000000a38d170648322523
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Paolo,<br><br>&gt; What is the perform=
ance of lowered 64-bit vs. the TCG_VADDR_BITS<br>&gt; approach?<br><br>For =
comparison, I ran a gzip compression on 500KB data using an x86_64 guest<br=
>[1]. The TCG_VADDR_BITS approach was 1.14 faster than with -sMEMORY64=3D2<=
br>(approximately 18.8 s vs 21.4 s).<br><br>&gt; Also, Emscripten&#39;s -sM=
EMORY64=3D2 is okay for TCI but it would<br>&gt; not work for TCG; you&#39;=
d still need TCG_VADDR_BITS to be able to produce<br>&gt; wasm32 at runtime=
, which makes -sMEMORY64=3D2 only a stopgap.<br><br>Yes, the Wasm TCG backe=
nd needs to be aware of the target host configuration<br>(i.e. -sMEMORY64=
=3D1 or 2) so the current Wasm TCG patch set [2] propagates<br>-sMEMORY64 v=
alue to the TCG backend via a macro.<br><br>&gt; So I think we should go fo=
r TCG_VADDR_BITS anyway.=C2=A0 It&#39;s surprisingly<br>&gt; *un*invasive.<=
br>&gt; <br>&gt; I assume wasm32 has CONFIG_ATOMIC64?<br><br>It has CONFIG_=
ATOMIC64.<br><br><br>[1] <a href=3D"https://github.com/ktock/qemu-wasm/acti=
ons/runs/20913930555/job/60082798942#step:4:14">https://github.com/ktock/qe=
mu-wasm/actions/runs/20913930555/job/60082798942#step:4:14</a><br>[2] <a hr=
ef=3D"https://patchew.org/QEMU/cover.1756724464.git.ktokunaga.mail@gmail.co=
m/a507277f4b40617655ba1c94963ef42c78ebbcca.1756724464.git.ktokunaga.mail@gm=
ail.com/">https://patchew.org/QEMU/cover.1756724464.git.ktokunaga.mail@gmai=
l.com/a507277f4b40617655ba1c94963ef42c78ebbcca.1756724464.git.ktokunaga.mai=
l@gmail.com/</a><br><br>Regards,<br>Kohei<br><br></div></div>

--000000000000a38d170648322523--

