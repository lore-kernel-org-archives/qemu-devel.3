Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B91CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIOYw-0008So-Ch; Sun, 18 Oct 2026 06:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOYu-0008SH-AW
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:56:20 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOYs-00039u-Am
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:56:19 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b09e07e149so8533057b3.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 03:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792320977; cv=none;
 d=google.com; s=arc-20260327;
 b=TLVw3nPZjyiuEDbrxDu9DqpcXs0a2bY2kMyIene9SHY4XG2OaQI1mrNNHrBcfxFJX7
 ZcRLLB0nDWzROzzGtPlFLoNmlVcKnJwQYfCaJBTaV9c5Yhrif7q1C4yWptkWmfV/rrtE
 FI0wsHyZ4qGHq+5BRkW9VjZ5/kEMxZYZLXDIbaUcFbMdmZwj1SItk9Pf6wAY/dcGQfFd
 or24jbPw4XdEUqH/a1wzMfk9psS2JU25TGFAQuh0u5U2EAP2G73RxdKu6A0bL9DZYHme
 JQLaA+T/Z6Ze4RGK69Folf7AVJjjPql/CxaQMSQwm1VsK7OFrPbw1nXcCTp5JpRyOeQn
 VJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QANdJ9Wx0Qdp3s9+/Wbyon45Q4YDAQdyvgVAf7Indvg=;
 fh=dHN1FZJpb1BHRtRBDcpEyrvNB3hUuCjyQs5YK6bCL1Q=;
 b=JxauN9Jx9NRg5Sse4AYFc0i95mah+o6+183N7bp5YSsAF1FvZzqSRwkpolNj7hnwuz
 2IHi09NPN8LnY6YN/Rhg2nKlU8nphGBYp0MmlhcmVGmgj8mOe7HkAEgA1RfUd/xhYGZP
 kGHT1ECGGL87Vubc/8baRyLsc3TIhM3LeHF8mbPU2y0mySlZtn/uFPqlKJShxpTS3L8c
 tmp6mGIEQaqK7StkTwE0l8e/rAGeDJnhZjTtsOUzVDfoQRyk2teB+NrVYjW9o5ywx1qS
 ITbAL/J/gZvSJTSCzw3e1ZOXNISLRNtQx5VAQll4qsBEXnngor3H4DB4lcWlKWiQNom0
 xhrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792320977; x=1792925777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QANdJ9Wx0Qdp3s9+/Wbyon45Q4YDAQdyvgVAf7Indvg=;
 b=c30eaEoRYRBet5jMKR/8V80+jCLVbuMKTB2F8u1Gy9RDehXLn0km/3bQsr5X2Gr4jA
 XeMY7ybQGDJZ3mKLFXd7PbLYMhNUgrc7DNoLzxDA/cbEzjT5A39JZq2dbBlmek0r6jpb
 MT7IkRAxBoeL4GakKOg2IXkgxAcHkGbJEDIex8CJyWssJYTk3kZTSZRMwDtvRupG8Lsn
 6t8KH7DxkN7gu50ND0yhpbOjSWPW8GwfKNBSD18QHID1+VNG/wNVBvJrjtQSRCduKwQJ
 DYHAyuZVvieiFMxIv7fG3LPPAf3D8rT5i4pApRNnPgTi9tg/cphjczu8NoSYHsfa5aan
 sjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792320977; x=1792925777;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QANdJ9Wx0Qdp3s9+/Wbyon45Q4YDAQdyvgVAf7Indvg=;
 b=AzBtvAQ7z0vaj89b9rK0I4IkVLl+7BbkPy6Lg2JG0y08nei2CBmyDFarSB5ffi8NFU
 1mONgk06BuxzK+27EME9aQPV1ZR+W5WmRhyhM2h2pMv1OjUx4UntXms0XquTrhs0W3yy
 XnMeFkFTw54SG1X/6LzrXFxw3kGVlG7L7IoREFVmQmpyq6pf9QUJvzxxCVG/Xq6qdIfH
 GKXK7MwOagZLKa3MZshRvUGhx/lfJmTNY9YIZpF7FILFnl56Kh/GXBXRJ1Mrs2YgPWG4
 LxcCGn+7vGXYTo/etaizTAM/fYOO512uPJ6GcnoTMebzur0JOKOi42F5TRdf+2bIH8+2
 XtPQ==
X-Gm-Message-State: AFq9FYI939Nsmz5Lg7NHcx0xfQiagD6p0rbFaRty4dVyHpl1m8SgXUzc
 maHmttzIvn92UsPhfSXDKRAJQCfr8edezewkYRx0vIN5swIx2TBJMFGIOnnI6ryERzO8u6+iJCu
 yTh4IRIF0INA+pSds+JinDB24vHUQUtlBQqXoRer/VQ==
X-Gm-Gg: AYBFou3st+RLjYaU3RLaXZ+1WuZ7p/HVWC//KoxPtPPK42Hjf4OnoGEnggAz+C/iPfe
 sxaWaHgK6SLXTyQUdKcYG3PBxtkEEfI0UZRknF9oCwTXORkl8xjz98PU7c2ml1/E9xy3+S0CISj
 ZTK4Oj5w5y46ReVm8y2PbC80m+vDznBclUtOlUM/Q9I8jNnhZC+0v3Fzyv8IaNtmJLkjP2O4uB4
 CzCUHC6k7qKLMY6AaAnTNXPqQcqFUNsamVtcD/RFyXOk04JlV4jjDqYDAH/AfxMaLJ1jCLuLERA
 JphGJPrWvGA9cdU1jRfQ/lLdlQS5h3orz/i3+I+kYeE2y52QvK2nTyNSGFoIsmysB0GjxJ1mllv
 1mWEWy7qXLcbzCISlHcP2w17NsTUhsZSGUN2zQ7VE
X-Received: by 2002:a05:690c:e20d:10b0:8b0:9e07:d8b3 with SMTP id
 00721157ae682-8b0f21dc83bmr10084897b3.48.1792320976603; Sun, 18 Oct 2026
 03:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
 <20260918101158.42101-5-corvin.koehne@gmail.com>
In-Reply-To: <20260918101158.42101-5-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Oct 2026 11:56:05 +0100
X-Gm-Features: AclHuK-HZKcyf6s8gcu18mFgDkRq1dyy41wbK1FpU5J5BM9Bw5InPgJ6piSwZfQ
Message-ID: <CAFEAcA-XezAELu7b55coyvBn975+SKtZn=7zmBaMj8aELmNxEw@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] hw/timer,
 cpu: Add Clock API support to A9MPCore timers
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin Koehne <C.Koehne@beckhoff.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 18 Sept 2026 at 11:12, Corvin K=C3=B6hne <corvin.koehne@gmail.com> =
wrote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Add a clock input to a9gtimer, arm_mptimer and a9mpcore. a9mpcore
> distributes the clock to the other timers. If no clock is
> connected, falls back to 100 MHz for backward compatibility with
> existing machine types.
>
> Frequency calculation now uses the input clock and prescaler
> values according to ARM Cortex-A9 MPCore Technical Reference Manual.
>
> More information about the A9MPCore timers can be found here:
> https://developer.arm.com/documentation/ddi0407/c/timers-and-watchdog-reg=
isters?lang=3Den
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

Also, something in this commit has broken the functional test
for the realview board, so "make check-functional" fails
because the boot of that board hangs with no output.
You can run the individual test with
QEMU_TEST_QEMU_BINARY=3Dqemu-system-arm $BUILDDIR/run
tests/functional/arm/test_realview.py
(it won't have a timeout applied like that, so it just hangs).

thanks
-- PMM

