Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE24C282DE
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Mar 2025 06:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tthjJ-0003t5-EQ; Sun, 16 Mar 2025 02:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tthjD-0003pE-5T
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 02:44:08 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tthjA-000052-Q9
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 02:44:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso2206293a12.0
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742107442; x=1742712242; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL+GNOWVhkYvcOAATTjiaghKFZ38IYqr+XCZ/CnogQg=;
 b=gaHMXXUTN/NLc9PKvayvGPODJOyqUXRg7RJaeiInYBmcpSYd6EHmw6PGwqpXEiQL90
 u1SqivqcL3MxQ7CkyE9sPQriIMgEQHg3NPxVh6yODuQF20cmXPk8/hexCnN+Rho8+pIb
 RCgvWOb++2+hNb+vVir+n0NafBGpQ3nCZV6S38mGAcUdIx5gJ8Hrt4/4+WWfg4f6OGOt
 pxMjDBmK15GO1cXlEHHm5EC+3Md6Eskk+XE+rYCqef96FDsVW36WZfCsZKiR5G9UD66h
 mmFkBPYttvAd56B+V0sal1dsYFJDKyW/VB9tc3eiqBiUxZEqlj8uoqcO0GQpKF3glWC/
 T/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742107442; x=1742712242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KL+GNOWVhkYvcOAATTjiaghKFZ38IYqr+XCZ/CnogQg=;
 b=dCW1Rlrqj72qh5kFuSggjPNnVc+9Bus2dB+Rdm8LjveOi9UdVXmO/UdCnyz8MK/b05
 50G0zFmanux21Sp4NhqPDU8yCQtLpgG4HSBbfR999XfaywexRJRS26+Qb2ttlOCLABcg
 eXGNarO+viFdT/7FXEuaInfZMfFdQmFHsdz7CuFQ3mv/intXlq+upvU4ah6kIcS/IfYZ
 nysvm6J79+6NfetRVuUNrbAVX0mehO0Hj1E2HQgDCJ7a4d8nA2bLE41vjhVTTzIQcsJm
 uxchUlQIH9EfY5FF3FpZ5ix/+LKey5YSzNe50rFaYAGAjGOxTCtoQbAHVAbpd8sOcVNB
 /+7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXddyWNcbCrOYfixIGf4W7QV9sK5aIdHzb8lcVgyIF2Y7pPIxzOHWtEdcjDEDkUGB8pHlVuKHXGh8dU@nongnu.org
X-Gm-Message-State: AOJu0YxNddLrHejYb/L8Zqju+yIyB1XBMCi3ov5A0hWWIOghr9nZfhWA
 fq6Al2XowTteNdLg33eOap+IKfoaGZevvXHbmos3Yr7TLZcb9GkAmxE3EixHQOWGE1ZKI2QO/1z
 IErfWanv3oDkllY3uEW66iEDQsEc=
X-Gm-Gg: ASbGnctR7tGAtTDvquVMunULrWkuZQo362JelcjIIrY1ZGzd/WMKRe/HV/odK5Z550z
 fry4P0vJh0blyOr+b5EZHESD6w12xfZVlhT7GGTgnw4G5bcIdnwafhazCQ7EfTgVP0Rwilm2qBb
 P4sEIqe/cTnb4bvURCa/WEn3H6
X-Google-Smtp-Source: AGHT+IFhSNaQ2wZj+MASoogyZiNQijk2t0DTiLI4nKA9ChEge7XqAyMUgw9bL8sjM9QeaZAbRPdYbcLRbEwkL/fIQ9c=
X-Received: by 2002:a05:6402:518b:b0:5e5:ea02:1223 with SMTP id
 4fb4d7f45d1cf-5e8a0c10a10mr7891060a12.31.1742107442226; Sat, 15 Mar 2025
 23:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWKnLDsVUbqO_kNB7GiZPU0-YpOU8T4BNCgyNBi54dtDQ@mail.gmail.com>
 <12d09c42-e6b2-49d1-9b06-e5a26acc2c5b@redhat.com>
 <CAJSP0QUWkeaSsVmdfrXNAaSqB_uMUxqAD+GR7Xm4FHEgwYArNg@mail.gmail.com>
 <CAPan3Wozs=BX2pYxgBR3R_TtV75Pk8T=TNXZjgRHajzYw47Y-A@mail.gmail.com>
 <CAPan3WqR_UmrJMtYEe02K6vKy4joNE5frGDMW1KWFH-so24nbw@mail.gmail.com>
In-Reply-To: <CAPan3WqR_UmrJMtYEe02K6vKy4joNE5frGDMW1KWFH-so24nbw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 16 Mar 2025 02:43:50 -0400
X-Gm-Features: AQ5f1JpdQBfpEnZae4W0-zXLE3cQdiH9oDIAbnANAZCFW793DVV6hpAlnRljdoE
Message-ID: <CAJSP0QV7JK5UhzvSobb10TXUKKcvvdfW4uCydYgQxrggSWP5qg@mail.gmail.com>
Subject: Re: Broken NetBSD Orange Pi image URL in QEMU tests
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
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

On Sat, Mar 15, 2025 at 5:01=E2=80=AFPM Niek Linnenbank
<nieklinnenbank@gmail.com> wrote:
>
> Hello Stefan,
>
> As of today, it seems the URL is working properly again. I've done a few =
downloads without any error.
> What I did notice is that NetBSD provides a 'cdn.netbsd.org' also, but I =
can't see any noticable difference yet.
>
> Tests are also running OK now, at least on my local system:
>
> $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 pyvenv/bin/python3 ../tests/functiona=
l/test_arm_orangepi.py
> TAP version 13
> ok 1 test_arm_orangepi.BananaPiMachine.test_arm_orangepi
> ok 2 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_armbian
> ok 3 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_initrd
> ok 4 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_sd
> ok 5 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_uboot_netbsd9
> 1..5
>
> Can you confirm the URL is working again properly on CI also?

Thanks, Niek. The URL is working again for me.

Stefan

>
> Regards
> Niek
>
> On Thu, Mar 13, 2025 at 10:22=E2=80=AFPM Niek Linnenbank <nieklinnenbank@=
gmail.com> wrote:
>>
>> Hello Stefan, Thomas,
>>
>> Thanks for reporting this. I'll try to spend some time to figure out the=
 issue and perhaps propose a new image for this test, if needed.
>>
>> Regards,
>> Niek
>>
>> On Thu, Mar 13, 2025 at 8:39=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
>>>
>>> On Thu, Mar 13, 2025 at 1:48=E2=80=AFPM Thomas Huth <thuth@redhat.com> =
wrote:
>>> >
>>> > On 13/03/2025 03.22, Stefan Hajnoczi wrote:
>>> > > Hi,
>>> > > CI jobs that run test_arm_orangepi.py are failing:
>>> > > https://gitlab.com/qemu-project/qemu/-/jobs/9390048284#L1138
>>> > >
>>> > > Please consider how to resolve this so the CI job passes again. If =
you
>>> > > are in contact with the archive.netbsd.org administrators, maybe
>>> > > contacting them will lead to a fix. Otherwise please update the QEM=
U
>>> > > test to use a URL that works or remove the test.
>>> > >
>>> > > The NetBSD Orange Pi image fails to download cleanly:
>>> > >
>>> > > $ curl -O 'https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0=
/evbarm-earmv7hf/binary/gzimg/armv7.img.gz'
>>> > >    % Total    % Received % Xferd  Average Speed   Time    Time     =
Time  Current
>>> > >                                   Dload  Upload   Total   Spent    =
Left  Speed
>>> > >    0  303M    0 2048k    0     0  1098k      0  0:04:42  0:00:01  0=
:04:41 1098k
>>> > > curl: (18) end of response with 315646186 bytes missing
>>> >
>>> > FYI, Nicholas already provided a nice patch series to skip the test i=
n case
>>> > of such incomplete downloads:
>>> >
>>> >   https://lore.kernel.org/qemu-devel/20250312130002.945508-1-npiggin@=
gmail.com/
>>> >
>>> > I'll try to assemble a pull request with these patches today.
>>>
>>> Thank you!
>>>
>>> Stefan
>>
>>
>>
>> --
>> Niek Linnenbank
>>
>
>
> --
> Niek Linnenbank
>

