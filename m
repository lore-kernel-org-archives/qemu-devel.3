Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CBEC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 21:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXRq4-0008D2-6Y; Mon, 13 Jan 2025 16:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXRq2-0008CY-By
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 16:19:10 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXRq0-0004My-KJ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 16:19:10 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so3455947f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736803146; x=1737407946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjKB5oJke8uVsQxmOfT+7Dya+60dP1X1LfJeAurdE2k=;
 b=TNS85Tik0dSE+n7cqdv4e9nwfiC7xT68hZZXvrVqYZs1QrxsYSULPDeH3J0/GXOZhD
 /9DUqlx2DLZkENJiGwEypMLYBQr3aigQu2JgTu85HgSFeLdJnu07bVSIBqOtC6VaoiKo
 akQ++KfbBZn2Bm7vuGMyl+ezNOGr/KjGUBki6MhmH598WZUVkvZl9yMGILPf/pmRUwWP
 dm8YB5OGVQbtPVA/v0rQv0u2xZtD67c9LER/jaNzxwi22Ny6GHbNSqNXkKyzje4NiteC
 aBh7LvwbW4T3q8L18wJe4mH1B0yfHMG8yhUpub4U9oPwPKBnV4cdgDS81kq8Q3QBcSqB
 HRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736803146; x=1737407946;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KjKB5oJke8uVsQxmOfT+7Dya+60dP1X1LfJeAurdE2k=;
 b=PL3yWvRl5oGM0ubHVh0YbF0hLYXSPJqUVBYFCNlYF0Y4pqqZrQKUGStvXPsXGyIuF2
 yBEs9bVOKH4VweHAx2iUoDCK8F7uHxyBtAgAobahX1qnTnEnOFNwQADHGxvEtz0kE4tO
 HfX1JRV94iMUO4SXWhftac9a7NaRfuegTVuTxOsOmWwpkv36muo9T4BA22s+kKkfaR0A
 U5WxPJ2/aGQj1OWTh6wABtSW0HEI5pQVnaSeEOXJmXg+SjWbSpoBAnVceTNneMev7W5w
 LeJMMmVJqwDTiyqRbLmzeXR4EoN6emM6rmfPOj4ZYdp5sT6YzWaP6RyRJL1G09cH+YsQ
 vGSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZSk0GWTVe539V8kUgIA2C8IpwvfRdJ12jg+jrD1b7XGqZQ4UCnxhPVxQt4aUPLJRcyN/hJcu7xRK4@nongnu.org
X-Gm-Message-State: AOJu0YwYOjoOK+pGTNjStO3hYVnk07Y0Y0HhmGx2wU+9Jkd98jYY0QjE
 +07ORaYyiTgVJize4pwIxW8NyAAlLWi8926UCLVSOOoVWaAna1UmcpT5H3qbPWI=
X-Gm-Gg: ASbGncuJHxstOXftg67YlBYNvtuEBAAx/CmbxxUDpxqt+oRyYpLatog9ywgskpMBF/Z
 0SJeUD9TnV9dX4AEFNXpq4ih6Rl4BvRCwjRY8JcGAuDN8dW0EzjjjVzIjndaV9/Ycl8wakGT4eA
 JG+oLGFiTJ1PVWTgJ6/rm16CZXvbqybUr47ayXCt6IkUgpMBWbTrDDTW642dzIgLlulal5SrHPS
 Tv9+hPcp/3OyIePXZqnDzL+5WPU0gtwTOmTqf6AM7PRBbBirV1OPGc=
X-Google-Smtp-Source: AGHT+IHjOshyA3OmhnHW2Y65ISQCuXaxhgURrs3telKrEhqEyq6bJi2Y3O6ZPVFB8/SzHcTbVJwpSg==
X-Received: by 2002:a05:6000:2a2:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38a89066f45mr22272679f8f.38.1736803145861; 
 Mon, 13 Jan 2025 13:19:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80d4sm12791158f8f.85.2025.01.13.13.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 13:19:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BDC15F8AB;
 Mon, 13 Jan 2025 21:19:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Markus Armbruster <armbru@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
In-Reply-To: <6adc2994-e762-4923-9033-54efe165aaea@linaro.org> (Pierrick
 Bouvier's message of "Mon, 13 Jan 2025 12:17:27 -0800")
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <73fd2f38-76a0-4274-875a-6f96faed79f6@linaro.org>
 <bc22d713-201e-414c-838e-6c0dc1fb3807@linaro.org>
 <876fe41d-df26-4a13-a465-feeee0004746@redhat.com>
 <6adc2994-e762-4923-9033-54efe165aaea@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 13 Jan 2025 21:19:03 +0000
Message-ID: <87y0zejttk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/12/25 22:26, Thomas Huth wrote:
>> On 11/01/2025 16.47, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 10/1/25 21:37, Pierrick Bouvier wrote:
>>>> On 1/10/25 12:33, Pierrick Bouvier wrote:
>>>>> For now, it was only possible to build plugins using GCC on Windows.
>>>>> However,
>>>>> windows-aarch64 only supports Clang.
>>>>> This biggest roadblock was to get rid of gcc_struct attribute, which =
is not
>>>>> supported by Clang. After investigation, we proved it was safe to dro=
p it.
>>>>>
>>>>> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and
>>>>> aarch64
>>>>> hosts.
>>>>>
>>>>> v1 contained warning fixes and various bits that have been upstreamed
>>>>> already.
>>>>> The only bits left in this series are the gcc_struct removal, and fix=
ing the
>>>>> plugins build with clang.
>>>>>
>>>>> This series is for 10.0, as we decided to not include the gcc_struct
>>>>> removal is
>>>>> 9.2 release.
>>>>>
>>>>> All patches are now reviewed, so this series can be pulled. I'll repo=
rt
>>>>> that to
>>>>> MSYS2 too, so we can enable clang environments for QEMU.
>>>>>
>>>>> v1: https://patchew.org/QEMU/20241031040426.772604-1-
>>>>> pierrick.bouvier@linaro.org/
>>>>>
>>>>> v2:
>>>>> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
>>>>> - add a section about bitfields in documentation
>>>>>
>>>>> v3:
>>>>> - explain why gcc_struct attribute matters in packed structs in commit
>>>>> message
>>>>> - reword the bitfields documentation with suggestions given
>>>>>
>>>>> v4:
>>>>> - edit for bitfields doc requested by Philippe
>>>>>
>>>>> Pierrick Bouvier (3):
>>>>>  =C2=A0=C2=A0 win32: remove usage of attribute gcc_struct
>>>>>  =C2=A0=C2=A0 docs/devel/style: add a section about bitfield, and dis=
allow them for
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 packed structures
>>>>>  =C2=A0=C2=A0 plugins: enable linking with clang/lld
>>>>>
>>>>>  =C2=A0 docs/devel/style.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 20 +++++++++++++++++++
>>>>>  =C2=A0 meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
>>>>>  =C2=A0 include/qemu/compiler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 7 +------
>>>>>  =C2=A0 scripts/cocci-macro-file.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +-----
>>>>>  =C2=A0 subprojects/libvhost-user/libvhost-user.h |=C2=A0 6 +-----
>>>>>  =C2=A0 contrib/plugins/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>>  =C2=A0 plugins/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 24 +++++++++++++++++++----
>>>>>  =C2=A0 tests/tcg/plugins/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
>>>>>  =C2=A0 8 files changed, 48 insertions(+), 26 deletions(-)
>>>>>
>>>>
>>>> It would be nice if a maintainer could pull this, so we can get this
>>>> merged upstream.
>>>
>>> That'd be Thomas or Alex I suppose.
>> This touches plugins, so I think it should go through Alex' tree?
>>    Thomas
>>=20
>
> It's touching plugins, but it does a system wide change as well (which
> is the most important part).
>
> It's not really important who merges this, but it would be better if
> the series could be pulled as a whole, instead of breaking it into
> multiple subsystems.

I'll look at it tomorrow when going through my maintainer queue.

>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

