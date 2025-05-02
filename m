Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AF8C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 15:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAs5A-0008VM-Lp; Fri, 02 May 2025 11:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAs58-0008Ud-Rc
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:13:42 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAs4z-0001fn-8J
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:13:42 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e733b858574so1988914276.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746198811; x=1746803611; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7UYMjEhnNH7vgGII2Yo9ggSocmhMPsxr4ywyyhf/Hw=;
 b=jJa8TsAPNlsiaAU3TypROvCtg75tGsT87AvBIHfSX4j/d/bH0zgeqPNajUPRWg3Xn6
 NUV4DnOhHK+cp5upvKb00DLBvWj8fZB85BR3QgPSCsBKYfljc4r17IrFqKyoKlP++J6g
 FVeZOrzsZXS2gv1Ke4RryBRnpgSjUpPvHYNmBxISR0RkujfJK0VadAh7VbhyEfWAqEd6
 WXClHsEX5y+CpzX/a1MJsm90BpRaz8HfXROM1/UamjpmaGTcb74M6543i3aTlRIShQ2F
 wFprMAzLWhtlrw1Z1Z5CsKp7sVOVGS6/Md1DTjYyXOQFSxUWZI+MmbDt/3B+nTNaL1q4
 UgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746198811; x=1746803611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7UYMjEhnNH7vgGII2Yo9ggSocmhMPsxr4ywyyhf/Hw=;
 b=NiR9DmReGf1J6gqj/k9FRzsQiDkMQH4mM47aPOy2LtfcRXFZ0ymmxDykojAoEPEJDC
 P378tWb8qTV2IcBMVEMHeGylOeQg42s+EryOG8aVdf+czVlwEPST5bhoZpKt7FCX+1bj
 93yAamBfw9z/wnE+z4gUnvO5FyAaop8atFNoUUaYfO6VbW9S+fI2Uk3tN6w0KWKLEkmb
 +P3h9hCAEzKtrvdEJsFzWswXg/7jm8zdQir3aNLnXjgRGq3Q1xP/PFD9Z0+yb2uvEft0
 x7xCX3+qsFZTrDeW7vVyxiKLFgKF0OER/WgW23LKioR4OwX6G8f2XvFrK9+TatwiPAaB
 qnDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw8LaJDwf5iK2II7a4fqD5G0clsnDyO5OLuHtCvkXz13gUcwjhyHvbx+WlC5CqowDPOR7k8zWulMSj@nongnu.org
X-Gm-Message-State: AOJu0YzJgzOnJytlbaxky/MSN0Pj1o+LbCGkjnUqocAno8ETkx3001G0
 GCledq5He59FhvzzRyVHevqhZKzBisUDWOF2knguwzb4BT0zsUGUY8oVRXxkOuMy6lWS2K63Tge
 q8WtHxcskxViec7zZndohvh0lKL0kDwjmVO6oVw==
X-Gm-Gg: ASbGncsCjDzg7R1gz6MhGXjwrzu6lUo6zlq8J/Ocay8GP8fyA5x+A8CAGvAKq4hV/lb
 W1wHT6yGc48YiUZirbX01zfby8zwB6n4eYt1jb2Hdw17XEdiQCABPav3ZJd747hdRUp5Q+TwEKt
 97DuEJyALRehuzfapBIwqRkzE=
X-Google-Smtp-Source: AGHT+IG+J6OU6z7N9RRSQib+3qERqyIDMRH94uoU6Klesuwp0GfiM7QnX0TWEZuqGaPCNTuLQo0Bc2tcG2P+mJZpshI=
X-Received: by 2002:a05:6902:2204:b0:e72:89ac:b7c6 with SMTP id
 3f1490d57ef6-e75656760b5mr4548741276.47.1746198811268; Fri, 02 May 2025
 08:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250409202630.19667-1-shentey@gmail.com>
 <aa47d49a-b81a-46cf-811a-2045e453f4bf@redhat.com>
 <6621A6A6-83F8-476C-973C-FE3D1918E061@gmail.com>
 <2c725cbc-6ba0-4e07-8863-acacbb45e121@redhat.com>
 <e3ea2723-126f-45af-8bdd-602ee512b51f@linaro.org>
In-Reply-To: <e3ea2723-126f-45af-8bdd-602ee512b51f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 16:13:19 +0100
X-Gm-Features: ATxdqUF0amAkHum-tWhxXjDtX0NMijOIdnf-93R9jKjg42ZbYJKu6A6MsXw-goE
Message-ID: <CAFEAcA9AENXW-YzA6SUaB6D-q9SkMRiq6fsL_Moh-Y_D8rC--w@mail.gmail.com>
Subject: Re: [PATCH-for-10.0? v2] tests/functional: Add test for imx8mp-evk
 board with USDHC coverage
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Wed, 23 Apr 2025 at 12:31, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Thomas,
>
> On 23/4/25 11:40, Thomas Huth wrote:
> > On 23/04/2025 11.31, Bernhard Beschow wrote:
> >>
> >>
> >> Am 10. April 2025 06:05:35 UTC schrieb Thomas Huth <thuth@redhat.com>:
> >>> On 09/04/2025 22.26, Bernhard Beschow wrote:
> >>>> Introduce a functional test which boots Debian 12 on the imx8mp-evk
> >>>> board. Since
> >>>> the root filesystem resides on an SD card, the test also verifies
> >>>> the basic
> >>>> operation of the USDHC.
> >>>>
> >>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >>>>
> >>>> --
> >>>> v2:
> >>>> * Make test file executable (Thomas)
> >>>> * Omit fetch() (Thomas)
> >>>> * Omit "-accel tcg" (Thomas)
> >>>> * Add "snapshot=3Don" to make potential future tests independent
> >>>>
> >>>> Supersedes: 20250405214900.7114-1-shentey@gmail.com
> >>>> ---
> >>>>    MAINTAINERS                                 |  1 +
> >>>>    tests/functional/meson.build                |  1 +
> >>>>    tests/functional/test_aarch64_imx8mp_evk.py | 66 ++++++++++++++++
> >>>> +++++
> >>>>    3 files changed, 68 insertions(+)
> >>>>    create mode 100755 tests/functional/test_aarch64_imx8mp_evk.py
> >>>>
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index d54b5578f8..4ceffa89dc 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -833,6 +833,7 @@ F: include/hw/arm/fsl-imx8mp.h
> >>>>    F: include/hw/misc/imx8mp_*.h
> >>>>    F: include/hw/pci-host/fsl_imx8m_phy.h
> >>>>    F: docs/system/arm/imx8mp-evk.rst
> >>>> +F: tests/functional/test_aarch64_imx8mp_evk.py
> >>>>    F: tests/qtest/rs5c372-test.c
> >>>>      MPS2 / MPS3
> >>>> diff --git a/tests/functional/meson.build b/tests/functional/
> >>>> meson.build
> >>>> index 0f8be30fe2..aaaf3472f1 100644
> >>>> --- a/tests/functional/meson.build
> >>>> +++ b/tests/functional/meson.build
> >>>> @@ -75,6 +75,7 @@ tests_aarch64_system_quick =3D [
> >>>>      tests_aarch64_system_thorough =3D [
> >>>>      'aarch64_aspeed',
> >>>> +  'aarch64_imx8mp_evk',
> >>>>      'aarch64_raspi3',
> >>>>      'aarch64_raspi4',
> >>>>      'aarch64_replay',
> >>>> diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/
> >>>> functional/test_aarch64_imx8mp_evk.py
> >>>> new file mode 100755
> >>>> index 0000000000..62fee74044
> >>>> --- /dev/null
> >>>> +++ b/tests/functional/test_aarch64_imx8mp_evk.py
> >>>> @@ -0,0 +1,66 @@
> >>>> +#!/usr/bin/env python3
> >>>> +#
> >>>> +# Functional test that boots a Linux kernel and checks the console
> >>>> +#
> >>>> +# SPDX-License-Identifier: GPL-2.0-or-later
> >>>> +
> >>>> +from qemu_test import LinuxKernelTest, Asset
> >>>> +
> >>>
> >>> In case you respin (due to other reasons), please add a second empty
> >>> line before the "class" statement (that's the style that we use in
> >>> the other tests, too).
> >>>
> >>> Anyway:
> >>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >>
> >> Ping (not for 10.0)
> >
> > Peter, should this go through your arm tree, or shall I pick it up with
> > other functional test patches for my next PR?
>
> My preference would be like with previous Avocado tests: when a
> (functional) test concerns mostly a dedicated subsystem, I'd rather see
> the dedicated subsystem maintainers to take it, so they get familiar
> with the test. Except if the maintainers are busy or unresponsive of
> course.

I don't care much either way, and in this case I was away, so I'd
have been happy for Thomas to take this via the test tree in my
absence.

But I'm back again now, so I've applied this to target-arm.next.

Since on my machine it takes 42s to run on a clang-sanitizer
build, and 96s on a debug build, I have added this to
tests/functional/meson.build in the hope of avoiding timeouts
on slow systems:

--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -12,6 +12,7 @@ endif
 # Timeouts for individual tests that can be slow e.g. with debugging enabl=
ed
 test_timeouts =3D {
   'aarch64_aspeed' : 600,
+  'aarch64_imx8mp_evk' : 240,
   'aarch64_raspi4' : 480,
   'aarch64_reverse_debug' : 180,
   'aarch64_rme_virt' : 1200,


thanks
-- PMM

