Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3424F3C240
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZNU-00036c-1s; Mon, 09 Mar 2026 08:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzZNQ-00035Z-Js
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:06:25 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzZNO-0005qW-Rs
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:06:24 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso11303807d50.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773057981; cv=none;
 d=google.com; s=arc-20240605;
 b=XdSfW4zXRzZP+p/PE341YuBLSWMmUXaAsp0hzTK9muWrPrjadhiNXmvsDOXGLVeYJm
 nQ/ClTk6N5XK+Fe19XlBCDZkifbFQPbYpQ0aLi/lwmhj1jSTwy4y7+Nj1iyeqhTwXLaF
 IUD9TWiI7e8Y5Td6N8HSLBmqsUdgTnkamHB8S6iF2j3BiieqWxTjuLIw7VAMEySN7Pjy
 kjZs21B26OV2iiqbXj6MT7QTwxDpqTUNSV990c6yJHg28jaLncUnq3xc1IkH3SayJqBd
 3D2gTNlnnh4R8n9uYpFDWbWNoK6ffCITK1936b5S2tZ8o09yF5suKadSrt/pjZbbAimS
 cKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4CxPVupeIOY69vn+jkf+i/BHARhYPW/cuQALMx0nziI=;
 fh=JtbQu1TRHF7VU9bZI0WR34n/4H0k9GtkHEVI7cK/9SU=;
 b=Ou94jFE7fSF1pZmKCL2JesgMHyU7/AGyk6vx0n8uIN41M5XQogCGtGPPYy7dZSZUtl
 84ar34MIpXeHyuYba0zXS6XnWyZ7Z7jfVGt+Rzzv8ZG7iO+GagK7MbDVVF/cN09/mT0I
 eD8PS2XoN3xbhFoGI2wGQr5otwZHgUhC9BxyINKZ3iNjTQwVyG2XujQkxmwGuK2EOCbr
 QJOKNzw3H9YWonNkk8mh+ZS1v212YhsFuYwdDrFa5fW4PQJ1x39skHpnmGI+33f4wH3s
 WtCc1GOkuBIiVkssmhIE0l3JxaJGKKo8IY3npk5GgcGuV/juS83CxRPYa33is4zQNYkE
 MzMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773057981; x=1773662781; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4CxPVupeIOY69vn+jkf+i/BHARhYPW/cuQALMx0nziI=;
 b=J0K+lhDWTVDhIkqHtWyJTksAZsItrxYI90B4HzYuhbPoSCpov+q2ZvYXBazK9QkS9L
 b488K3MaEwc9T2vXhIGJKyLO11JwnAAZmX/o3DRzbfoVp9VOshlHhPzfEbBjqhCtvHA8
 y9FqSS/YR+0aVem+qDndgCbbVrRMm91kPmaRRbi2moUmmqC88TmrRttH9Lv5Ybvgobqk
 IOT7yNT/43gEXfw0pl/J2oAPw2vHEt23Q9cg1B0vxy+5SV+VzEhWPqNlRxLX7LluLK1q
 AqvCI3lKb3W3/uPCvuY9x4E5RFTfxNEd/7yFg8ZbgDh0kEMRyGswxpi2q1vOUt0HQg6c
 ipvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773057981; x=1773662781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CxPVupeIOY69vn+jkf+i/BHARhYPW/cuQALMx0nziI=;
 b=rGrapxj+o6wUFKUq+nCLYFwHUWK82bigGE3vFM57uwXcNGSHtSaY2bEJBXDMZmEfyw
 yAyUFG7IkrN86A5OhBUfOlQZO8GN9U/gGPlSknCVEyH79hDShtac6lZ7dnWwDegiOsQl
 GB5xkKFAz0GwTv9nokEQ5EKdZyrh2n9jgCGJg/sBgwG+8D0HgkXgggrF0EQV4H/xUGGk
 CLHxungaNBcFkZCDVQvEhn2tvHUangSDPoKV2eEGRKqGg2RPPK98T7i4M8t08cqdxJNF
 I0UpRc9GkESwryk7Bjqn0fcFMasNuFxHix0zr3y17iL9tRiRUtkDT7zUYid0vbDHZdOD
 aKIQ==
X-Gm-Message-State: AOJu0YyYjT2JCjIu7lMs7cL6KE5DZ7P1iqMX2EEXBaqan585BOAAGRZY
 BJrlJSKpNIEL8cWT7hN5BTH/PWgEVETRI8EOuNLjApnyJzlutkdvCg9xC8fbcGasbxGO2bb8yK+
 hJ5w//pDO43q1GjNilOAUixgfIsSghrf5QT1kHJCgCA==
X-Gm-Gg: ATEYQzzqv/QvULoH++V4Fwvc7fb5J7adkNIHyhRyWs5LfuQEKIA61Ku+jWBw1S4QY3D
 QVAbBLA5uuWGvf75xiFdtk4CHaWIZEQ9YJ1/fgPaX8NUrBGbdxPuMSeBlIcRkPCre/tPKtYwXqh
 gSzieJ6HQNGeVnk7kK2XBW9sZWm9NXz6L8Ygtw0AmToIIA92xVOBvfOWxqnPA7YUERF4r6LmyVy
 hJ42+qjqXqrVCyCcm0uQgq4GtW4qY+HXdvQOI4sXwow/KBYUN52nK31fsbIF/xBNNaeSWeT+fQw
 KWeiLPgSmWKMICnze12iBBfKLIw6jhWNDPzkHegrvMEz0BvwkM+Lp1nHDYWCizDVoRw=
X-Received: by 2002:a05:690e:b88:b0:64c:ed48:dc84 with SMTP id
 956f58d0204a3-64d14301eafmr9737481d50.63.1773057981483; Mon, 09 Mar 2026
 05:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8FhiJZy6NqRUVnWQ+L6=fE8Ssqs9FEW2eO2eAVTrL=_w@mail.gmail.com>
 <e49b6dd2-857e-4b71-84c7-57ccf16bcd25@redhat.com>
In-Reply-To: <e49b6dd2-857e-4b71-84c7-57ccf16bcd25@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 12:06:09 +0000
X-Gm-Features: AaiRm50TwB7u-QyNJ1I6WeUO7krqGHJOBoGSNG07-2U9dECV7ivFCEGtYfTVuoI
Message-ID: <CAFEAcA_U-xyRiouHHJdHwdtMKbrDaLZ2m=hpFeZ8CmdHY_+XvQ@mail.gmail.com>
Subject: Re: running a single functional test: where do the logs go?
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 9 Mar 2026 at 12:03, Thomas Huth <thuth@redhat.com> wrote:
>
> On 09/03/2026 12.55, Peter Maydell wrote:
> > The functional test documentation suggests running a single test
> > with the build/run script. But if you do this where do the logfiles go?
> > As you can see from this transcript, they don't seem to get written
> > into the place that a "make check-functional" run puts them:
> >
> > $ ls -l build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
> > total 16
> > -rw-r--r-- 1 pm215 pm215 3084 Mar  9 10:51 base.log
> > -rw-r--r-- 1 pm215 pm215  825 Mar  9 10:51 console.log
> > -rw-r--r-- 1 pm215 pm215  235 Mar  9 10:54 default.log
> > drwxr-xr-x 3 pm215 pm215 4096 Mar  9 10:51 scratch
> > $ date
> > Mon Mar  9 11:20:13 GMT 2026
> > $ time QEMU_TEST_QEMU_BINARY=./build/san/qemu-system-arm
> > ./build/san/run tests/functional/arm/test_emcraft_sf2.py
> > TAP version 13
> > ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
> > 1..1
> >
> > real    3m24.394s
> > user    3m21.314s
> > sys     0m3.100s
> > $ ls -l build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
>
> I think the functional tests log their output according to the current
> working directory, so have a look at
> $PWD/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
> instead of
> $PWD/build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/

No, there's nothing there (no directories created under
tests/functional/arm/). Also having build/test write to
the source directory rather than the build directory would be
surprising -- if it does that then we should definitely
alter the recommended command line in the docs to not
suggest running the 'run' script from the source directory.

thanks
-- PMM

