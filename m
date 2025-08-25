Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE4FCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUxj-0002Lg-JD; Mon, 25 Aug 2025 07:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqUxM-00027W-Av
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:01:44 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqUwy-0001U3-I2
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:01:39 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61c74fc408bso993364a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756119675; x=1756724475; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmV+8BnlwEOlZkRzW5pzkSfYMNFngQ/rFyqp66rkQ/Y=;
 b=HoQcHpIzoUceTEneEVZTC74NuwM5+RgU/Zskt1LiWu9tAx2mKq65rouDh8943tZsZl
 bc5ku5oYn9D+UVsg0XFCPW8BpXDjnGZhZU67exSxiJpBObePCzDB/fDKKUj3+vEcaBss
 YM6W4T1HoJXH14OBEHbnwptZ08yDMKyPzMrr9ij6yWiSKs9ARV12bH2E4cV+0xCwfFiP
 0f7Bs/L2hH0L8rJoq0nxprQ9qZ9+pjr0HhnKeAh7/cJ9T26eLllgy0x9pqI/+bs7apfU
 5LSWfv9pc4mzylQeDcMAHOGZ4veuUdiBqo4tilJxr8bOF0BeHfDx5ScdNcV+fRwRjEQ6
 mT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756119675; x=1756724475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmV+8BnlwEOlZkRzW5pzkSfYMNFngQ/rFyqp66rkQ/Y=;
 b=KF59tEt/mu7wnKLyiv4lSp5nkn26Y29awuapUUGAR9ttBQLE3FtHPkvwUfEc0Ms0PW
 Cbr09xpekEDpI96K7r5XsluSj25nqixF5V/9wjoXvhlnP0suRocjlBp7bHRv+enRNBoi
 doJ3G3TCzqKgGqx8h5xFfPnF+NdSX98CkkFLCVuy+DIYlusnIoh84iulToXtL4vDAZ7i
 sSttvlD/vYfUlRiKShRdZh/lc4b7uB6VaS6UhHV6XhcfFsChsLmgn4EcLr7cEHFn/N5p
 25ILc1TQx9LCSxpDCG7yeTg1sKsX6UuRw3V0hI3hhAaK3ylZRFL9BGx7U28RSUgjNECl
 VtTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEtv6ijRPexpNkzfWjmrMEEZqqQAIc2ZHffCH8JxRGwHt85T/OBTjPoOs618PUahhhvaleQ0llHKv4@nongnu.org
X-Gm-Message-State: AOJu0YyT4p1K/sW+i4N+KwLirFzWMvYgFKzPyrEfinUSNIfiW37HoAnE
 U1+nKrr9QTGJVFxEdSHWemL+MVgj9P5fzym11mtselQSkxb+lOwIqQh3xs4EI3IN7nymkoGQ1CU
 NATjW92aotv0d3t+lqEds2sYXbp6WhJJUBeI5uAogQQ==
X-Gm-Gg: ASbGncvT0IcuCurM6zTq6kvQ3nV9lRz4/e2XM4r5mwUGbbJ0ggWS92FfbBsgXmPqoEH
 9nVl4iQGY+EccFidrQ3aMYvA+C8tMLqa7Hj/mwWpDfF8SX5ZojT5+N+Z4eXcmN8kLXGShgJzAu7
 OO87tus3EkIxmeIRgrIeJDsICtIdpLVAsQqBg46Wo739D+P8VmlKKRkm9immbnJq7h7A7MhRtGh
 bhee6Dsugihn+5AV8s=
X-Google-Smtp-Source: AGHT+IG55e19oOn65bbyHgs8KKzdVtnHUB/PtBKIqQvdKXeFFlIsWC/Pyqg+u/B/HGaNpCw4+E2XNPbUl8GOZWmPea8=
X-Received: by 2002:a05:6402:5107:b0:61c:7743:7f9b with SMTP id
 4fb4d7f45d1cf-61c77438576mr1277608a12.32.1756119675347; Mon, 25 Aug 2025
 04:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
In-Reply-To: <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 14:00:49 +0300
X-Gm-Features: Ac12FXxd0-3gEEy26nBQBTNeeM8BmgBWDNmEkK5aPJgoeEKNtxezgwqVitWv8Yk
Message-ID: <CAAjaMXaS6kpq9uOdd6Jgh7JXu5JUtrFjzPUdz5UfAJ+=ASg14A@mail.gmail.com>
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org, qemu-arm@nongnu.org, 1844144@gmail.com, 
 Jan Richter <jarichte@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, Aug 25, 2025 at 1:31=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 19/08/2025 16.39, Gustavo Romero wrote:
> > The goal of this series is to remove Avocado as a dependency for runnin=
g
> > the reverse_debugging functional test.
> >
> > This test, the last one I=E2=80=99m aware of that relies on Avocado, re=
quires it
> > because of the need for GDB to test reverse stepping and continue.
>
>   Hi!
>
> Please note that there are currently also some efforts going on to extrac=
t
> the GDB part from avocado into a more self-contained python module called
> aautils, which might help here, too:
>
>   https://github.com/avocado-framework/aautils/issues/82
>

There's also https://github.com/cs01/pygdbmi which I have used before,
it seems like it does the same thing as avocado's gdb module but it
could be missing some functionality

> > In this series, we leveraged the run-test.py script used in the
> > check-tcg tests, making it a GDB runner capable of calling a test scrip=
t
> > without spawning any VMs. In this configuration, the test script can
> > manage the VMs and also import gdb from the test script, making the
> > Python GDB API available inside the functional test.
> >
> > The test is kept =E2=80=9Cskipped=E2=80=9D for aarch64, ppc64, and x86_=
64, so it is
> > necessary to set QEMU_TEST_FLAKY_TESTS=3D1 in the test environment to
> > effectively run the test on these archs.
> >
> > On aarch64, the test is flaky, but there is a fix that I=E2=80=99ve tes=
ted while
> > writing this series [0] that resolves it. On ppc64 and x86_64, the test
> > always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
> > part of the test (reverse-continue) does not hit the last executed PC
> > (as it should) but instead jumps to the beginning of the code (fist PC
> > in forward order).
>
> At least the x86 test used to work for me most of the time, it just fails
> occasionally. Same for the ppc64 test if I disable the powernv subtest th=
ere.
>
> > Thus, to run the reverse_debugging test effectively on aarch64:
> >
> > $ export QEMU_TEST_FLAKY_TESTS=3D1
> > $ make check-functional
>
> I gave it a try, but this did not work for me, the test was not run at al=
l
> anymore. Are there any patches needed on top?
>
> Anyway, shifting to a different test harness here makes me wonder whether
> the whole reverse_debug test should maybe be rather moved to tests/tcg
> instead, where we already have the basic support for the stuff from
> tests/guest-debug/ ?
> The aarch64 would require a different guest payload, of course, in that
> case, so not sure whether it's feasible?
>
>   Thomas
>
>

