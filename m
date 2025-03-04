Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76297C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 11:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpQXM-0005yp-UF; Tue, 04 Mar 2025 06:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpQXC-0005xK-1g
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:34:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpQX2-0000E8-1e
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:33:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso12200185e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 03:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741088026; x=1741692826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZTRssEfu3AyHXnDinjBrT53ZXkFaFbkBJjFPQxffWg=;
 b=xNCCS5UxgS9vQnU2PYI6EXssqG+BZuMMQd0tp9WBNg04F9jRFUT0Cpgg+vz8xyy5NH
 ED1ghNqtMl1WTpQxpRwf93EEHGV2W33qogLkeYhauI2IkhUjOyBQJWaaGc5xFAS39ueS
 u8wLrJUHCJjw+t5G+1Bi+LDhAZcfK5CsG7jPO7rvPHOlEKBU2O+1XCoajTEMYDR4WEaG
 QBA+JgnJfKlv+9HP1UOMUcyOQdqVU7R4JVwgN+/84hTN2u1b4GuZOYgAFxq7aTS4OKHj
 BEZDVtUgkWwdRzDwMzAsY0AdeCN2kV7eOyPH3bZQFQDbJcTrGMfm9wb7JocU8UmoiP8W
 4PzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741088026; x=1741692826;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZTRssEfu3AyHXnDinjBrT53ZXkFaFbkBJjFPQxffWg=;
 b=jIIUV7jXPeDSnsfiWJNwdB9ekEcQ18qKIz9/RTzwQCkaWPWO+8n/tjyhoop8QUWgUg
 xej2J8Qg71Z98+Dl6iqoxa1Up4+sewR+HbgiKCcO5n9a51bSTj0jMP3jNspXrIWfjiiq
 9Iyl2SvdlP5ksJnjxHsTRWiioMcU+g5xQ0V4xKhKflRWnctq71Fs0Bfjx9KfDiHNP1Em
 /cLlM22w3jHID5nmB4tW4a45dP4AcbJbjF9NayRFa5vro1AK87+/uk4XES/7ceF5uidp
 t6HdW0NgqG0Pgf4nYS5C0DliLhhJdabpoowspuWQi3Fp4yZ8yu4zr51CcLJfVpZUaJgp
 thVg==
X-Gm-Message-State: AOJu0YzWnZlBenvZC1wgUEDBcxIQqQyOABlHTcVFJqoRJdaVo0h3HJix
 26mtpcL0ilwyuGuLK4eA3BVhqG2mm2kx30huckq6cHAda1Jhgqnm0svyaSkMU0Q=
X-Gm-Gg: ASbGncvLdoa22qThG7kW1hA7oewU8gGMKyAzKY1MoBJ6wJh51Cyyee1OhMIX4YKX1kk
 3stAuCEVCJLtTJjrsFeritll1ZemmsKx9uCOc9vo6GOvpPMrPJbX7rsj/SdzyMzXMnvcMh83Shd
 dPLnDmBYNZMy8ie/Oa3x2VApvSXHvMs6enaknu43oZyOSlUs3pso1qcufOTzBKNJbqq1+ZRqi6c
 lIfuPKfNf4VHyeTv7CuLKMoXZxkMUCjZmMMUm6fXrzdO7lwlttzPJKI4S175NK4xmFNMvBJydh1
 tznTXlvBCRoomfRDxqNe68kh8rW9VOqlw2v7Y112kAPlwKI=
X-Google-Smtp-Source: AGHT+IHWqNE+DH/xarn+BIWPBqEIEgVzHsQOym5YfVRDgahXvXmgmstX5uKodo2pmITuwfiQLFbvgg==
X-Received: by 2002:a05:600c:3507:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-43bcc3c620amr18143785e9.15.1741088025734; 
 Tue, 04 Mar 2025 03:33:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc06eba55sm73315145e9.21.2025.03.04.03.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 03:33:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 44FC15F93C;
 Tue,  4 Mar 2025 11:33:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] meson.build: add -gsplit-dwarf to default cflags
In-Reply-To: <Z8bTy54Jgaddg6V3@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 4 Mar 2025 10:19:55 +0000")
References: <20250303221703.1291078-1-alex.bennee@linaro.org>
 <Z8bTy54Jgaddg6V3@redhat.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 04 Mar 2025 11:33:44 +0000
Message-ID: <87tt8958tj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Mar 03, 2025 at 10:17:03PM +0000, Alex Benn=C3=A9e wrote:
>> This option is supported by both gcc (since 4.7) and clang (since
>> 7.0). Not only does this make the linkers job easier by reducing the
>> amount of ELF it needs to parse it also reduces the total build size
>> quite considerably. In my case a default build went from 5.8G to 3.9G.
>
> I've not come across this option before, but the docs say
>
>   =E2=80=98-gsplit-dwarf=E2=80=99
>      If DWARF debugging information is enabled, separate as much
>      debugging information as possible into a separate output file with
>      the extension =E2=80=98.dwo=E2=80=99.  This option allows the build =
system to avoid
>      linking files with debug information.  To be useful, this option
>      requires a debugger capable of reading =E2=80=98.dwo=E2=80=99 files.
>
> In Fedora and RHEL we build QEMU will full debug enabled, and then a feat=
ure
> of the distro RPM build config will post-process all ELF files to extract
> the debug info into files that we store under /usr/lib/debug. eg for
> /usr/bin/qemu-system-x86_64, we get a separate
> /usr/lib/debug/bin/qemu-system-x86_64-9.1.3-1.fc41.x86_64.debug, and
> tools like GDB, etc know to look for these separate files.

A modern gdb can certainly handle fetching the debug out of the .dwo
files when debugging.

>
> When I test our RPM build process with this -gsplit-dwarf flag added,
> we fail to find any debug symbols in the QEMU binaries and thus the
> whole RPM package build aborts.

Do you know if you build the kernel the same way? That has had the
option to do split dwarf files for awhile.

The tools dwp and dwz are used to collect the split files and generate
the final (optionally compressed) dwarf symbol file.

>
> IOW, if we add this to QEMU, my best guess currently is that we're
> going to have to revert it downstream.
>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> RFC:
>>   - currently and RFC because it should also apply to test binaries
>> ---
>>  meson.build | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/meson.build b/meson.build
>> index 4588bfd864..a936d1b422 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -363,7 +363,7 @@ endforeach
>>=20=20
>>  qemu_common_flags =3D [
>>    '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=3D64', '-D_LARGEFILE_SOURCE',
>> -  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
>> +  '-fno-strict-aliasing', '-fno-common', '-fwrapv', '-gsplit-dwarf' ]
>>  qemu_cflags =3D []
>>  qemu_ldflags =3D []
>>=20=20
>> --=20
>> 2.39.5
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

