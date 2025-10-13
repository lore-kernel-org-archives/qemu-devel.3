Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18A9CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ny1-0003qL-MV; Mon, 13 Oct 2025 15:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8Nxw-0003pc-9n
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:12:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8Nxt-00017V-HT
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:12:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so3663504f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760382731; x=1760987531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7sAeE6ZRiykKCEkDs1SFojPKVezFylpvC4URewkPZs=;
 b=XVhrmOWhBhJVwztEq/9stYxauTnJ4YeOqISCWu8KtNVaCApRLIOLUBZouadmEQxvoK
 QqdhUhhsQWQddjAMuEfCB/IHJudAyYs5V8PJKkwnmqPXTbX00OjNx0mSzHKEOoTG4gCI
 ZttwH2iIWCVimONhJxPqm4AcJtWVvlnprFNamjG2w1f5boHccEiOYT13l+iMWMBteo9g
 ekQu/9Tcq7yndHX1uAd382Zq8BSOx/y/1LGwx7pnsremhhmDryIGQJkgfNEkuGc4VFuG
 zxC/eB0UN4awzDToHySU05yhAW/lp9063sUiMsqzabj/hjv1DR7yZlsLg8K8wvgFrG1Z
 Aykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760382731; x=1760987531;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7sAeE6ZRiykKCEkDs1SFojPKVezFylpvC4URewkPZs=;
 b=i3vWybmcpAIBWiws4mC8H0tMZNTzhGFCjdpYTfkNrkL77yVDnY1U1s56d9fVBWAgaZ
 HgNGdKYxKT6inbhEulXQEJe0lXJ+UiGXyi7JwcZ1bGZbR4/A1vjBiu8/LwFZhAjEOzOo
 XQd4tRAf9NpxYe5CVwTMvL7M5TPjaINJFagBDvA0cCgLHR4ga4k+pfkGB9Abl3BPabkl
 60exXRd/mVxOLRBKkCruZ9V8yJCecl6rOYxADvuXguJIRel+5pN3RtjM8qMxbNVBMTLa
 9ed2kg8+WufS7aUmTLAE/p+q4c3KcTAPGOwccJvGbPvQ6dcjA41peHIV7Ai6vLQEpwRo
 6ehA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsI9Iwr4abUhjRpJW6w0LQM6L56ZStW11tClT51JFWHt/IfEpwtuQwDYFZYm7zpe1Q9pSxsBHw3sYo@nongnu.org
X-Gm-Message-State: AOJu0Yyfrw4+sECz7xB35Vn+EhEGoYLZdVAIBx7he78l3QsRiKPCD1gh
 KpYQa9N5+/ftZSsRxWg3bWI4vYyTBX3exm6f4zcvFYK5H196v7P66uex
X-Gm-Gg: ASbGnctlyx/XlEypN+FB8q38hvrpmqlTHxVGDN0N0xYj96AZzJwkeK1taIZ74hp3wwF
 +rfX/HAp3WiZ0o51jhMLe3dKp0lPRmMrZ1ZvRlHVoHeOtW0f6+y3ogjwsQ9F4pfsBZ/mmFQCqJ/
 +sFg17XUZKmpBfhfgHjnJSpP1Pb7KA7TpGvDvSLq4o9yQp/yOFS0py5ByEeC+txL873Iwdc618/
 MXjsThmIP92SAjnyN9J6sLJ/ukFkfXYIhXi+kTaYdgBJ55StrthI7GArRjMbFq+kgSLXn7IhfxD
 BlOH3VZxbj2D3BQP51rKx3PLEobl2e4bVqAv7WC+vminlPvtvKovn+Q1yquIKVElKzM+1xSLSlR
 CtYtoDLhBuT4VDiGKkGObz7XGAN8fe3xdZZojnSxvUwBmXhdCHdjGDrcDhvxopgubGKnj+I5ac2
 yvCHqxyuqjzZ/hezGifNoRm9dDXsGMysBvClhB90GL7Bjbv+wf
X-Google-Smtp-Source: AGHT+IEPRebfH85J+4qB0ozj4pfu2DmPsermSpmQlWFyKWR5e1qvU2oltas4kbaNLv1Wa91oxulLAA==
X-Received: by 2002:a05:6000:24ca:b0:3e5:47a9:1c7f with SMTP id
 ffacd0b85a97d-4266e7df708mr14050639f8f.47.1760382731382; 
 Mon, 13 Oct 2025 12:12:11 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400a0afdc243fcb5392.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:a0af:dc24:3fcb:5392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cc0esm19771379f8f.6.2025.10.13.12.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 12:12:10 -0700 (PDT)
Date: Mon, 13 Oct 2025 19:12:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
CC: marcandre.lureau@redhat.com
Subject: Re: [PATCH] ui/pixman: Fix crash in qemu_pixman_shareable_free()
In-Reply-To: <2831438d-9ca2-4629-b708-65874cf3a4a7@linaro.org>
References: <20251013112102.2396012-1-armbru@redhat.com>
 <2831438d-9ca2-4629-b708-65874cf3a4a7@linaro.org>
Message-ID: <89FEEF71-F31C-4544-A3BC-7ABF335EC245@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 13=2E Oktober 2025 14:11:32 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 13/10/25 13:21, Markus Armbruster wrote:
>> Reported-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pixma=
n_shareable_free())
>> Signed-off-by: Markus Armbruster <armbru@redhat=2Ecom>
>> ---
>>   ui/qemu-pixman=2Ec | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/ui/qemu-pixman=2Ec b/ui/qemu-pixman=2Ec
>> index e46c6232cf=2E=2Eaea09755b9 100644
>> --- a/ui/qemu-pixman=2Ec
>> +++ b/ui/qemu-pixman=2Ec
>> @@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable ha=
ndle,
>>       Error *err =3D NULL;
>>         qemu_win32_map_free(ptr, handle, &err);
>
>Slightly better if qemu_win32_map_free(), as per commit e3fe3988d78
>("error: Document Error API usage rules") recommended style:
>
>+ *  We recommend
>+ *   =E2=80=A2 bool-valued functions return true on success / false on f=
ailure,
>+ *   =E2=80=A2 pointer-valued functions return non-null / null pointer, =
and
>+ *   =E2=80=A2 integer-valued functions return non-negative / negative=
=2E

Now I see: Since qemu_win32_map_free() returns void, the pattern is to che=
ck for the error pointer=2E Could be mentioned in the commit message for ed=
ucational porposes=2E

Anyhow,
Tested-by: Bernhard Beschow
Reviewed-by: Bernhard Beschow

>
>Anyhow,
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>
>> -    error_report_err(err);
>> +    if (err) {
>> +        error_report_err(err);
>> +    }
>>   #else
>>       qemu_memfd_free(ptr, size, handle);
>>   #endif
>

