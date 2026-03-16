Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790B9F53D71
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Aw6-0002eT-B1; Mon, 16 Mar 2026 12:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2Avl-0002dm-DK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:36:38 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2Avj-0001FZ-Ta
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:36:37 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-649278a69c5so4183410d50.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773678994; cv=none;
 d=google.com; s=arc-20240605;
 b=UJba6nZV8fWNYp2yVH7n7lK7VYDmOuutkgJapel2K3Ux0phUtlaV3OKTiuae+gHsf3
 xwY0SkZb5zo+AbfSBR+sUryeQJ2rzIwHzBm3LEL+ASVCv8wVjxP0ywll4gtwe2zCTPWz
 zZUxue8gdkLQ8ycg6mWECKY8MTw2khS1qePTwXMrjh2sWTLeqV8DgBMLt75pituV7kOX
 JSgRdcrepuQOiHzl7Ln5JenLPub9d9LL+G2AwnK+ONZBqCNe9RIcxU5cHBOyUp0F4tuH
 dn0GUTIAVSLK6pPwcda+f0mfcmG/8K8mV+b+ljyRafAKxCEjJxNwNnKClPhaD4QRqaVE
 DEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vJu9SwOO2jHdPl6Xx7CnxryV1/3wmQfZZZ78aCAQYIM=;
 fh=T50mxbVhr5ng+ZFVLAdwfr7XwGM1gjA3hOqQQhVdADc=;
 b=de0d7X4YAQz06Iswm/ryegn/7cHQ1slmc50Fu98st9+QzyJwCaGgY1bO2uSViLFmSZ
 gWY5bJ3sBNVt2SPdlBsGfEiOW7H1HZu7nY/maSjbtf4desNOfICW8gn0rhtIqYQZlXuC
 TlKcJ7HKueU7sWzOwFS94xm664abw0lP9psDv5bf7ejsJyQop2sDc6f8ulri7ONLbp9H
 2nkCkzK6oeL+YR+t/RL1KS+spvt6F5AFJC27LxiMb+bf2/xd7jdPemNcUvT7Qtifj1Sh
 3EdmAOaQvkhgN6My9rNVhHTc9R7c1Z2ZY47QYtDT5X6x42qUoaU0kJaSb3VJ1+bIzdqd
 fehA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773678994; x=1774283794; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vJu9SwOO2jHdPl6Xx7CnxryV1/3wmQfZZZ78aCAQYIM=;
 b=Hnb9DAtuLWXaPugG9uwvReVOi9DUjGBC9JPRzgtFt899oVd13c3oyRQ1CNBTPBrQww
 iM4qHVn4W5qd1rOKTpIDJ7qOff2JgApNMOFCOu+Jg3dEriTLRN53coBB8j+QM7i8oeNW
 6o6U5nVcLJTC7nYOkNfe76XYb0f/7SRV7krArkMoCADLW09S3zC1hiZph3HPhKNeCQRQ
 ZLTazrjR70Zb0FDo8h+xHZrgdv0QJp4GT7HgH4QDIjPcYnhqLl93kgiqRAdn61ZHHd6N
 SpqAfJNXNMxPH/uWYbCMACV32J9ZiJpyGCSPkw6y/nYOVdK2MeANKrtPdRJVewOL8j8U
 9+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678994; x=1774283794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJu9SwOO2jHdPl6Xx7CnxryV1/3wmQfZZZ78aCAQYIM=;
 b=WHgh9RWhilzNeXk2zWDUmaTgtHq+/V6XbOOoIgFyEKhGz1JmrQmP8hc891qZ6pA9G+
 GyFAm3Jlz0OJ6PLN/4zMQEeFTArD4iY2uM2uT/m3Arcr7sacYmpkHJz+k139gBedh/Ap
 Wkrc2ph8gxB+dFPhBkJGFqmZ4kgXPPjK6D2gPwf0ZqIO0Of88ImJwrhyksuNc+q/4lvF
 jETAq399J5EBz10VbYnc+I4HdQpi+XQMQauC0y4MzZ3oI9G7B6AwrwKTRgFbpM3qIECn
 M9YIzs2uqztITxEpLQLjsF1tvM/iFaRoi1yaKMGVYKd+RMp+ZIsa7z9jYPtOVbFp1nvA
 O2JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPPpkp5NcmtXxO68jQMnSFzQin7se9YivzAjPRsWxJgwJp2uBeDQhGH+rfqpKhlWSZfZHPh+dqJTzY@nongnu.org
X-Gm-Message-State: AOJu0YwqM7R3qQoyOTA9SVnFWF670Uv+Hdm2Kh1uoCNllLB21k+9yShR
 Jj7kwPIcXaRWIEEQCLHWXJK7bPh98+725m37vHUZ9pjNOcv4/KnrZytRJSYAfc/u7QyS1Fz+tNI
 2qsFAe3NTxTCwEtX0Kor13mGMDeJvw07QH38DLZGpQA==
X-Gm-Gg: ATEYQzwKo8Qtxq5difdKWN4oYj+MmyPMlFfLREDweyDe4WA4+oE2KXYeeN5mzUH6qSg
 gtNA7rYxhg6wJreKP2g3IfbXNgUv03L8w9o6DODrZS3yXv4GUa4tvIIlbFgr9u71zFpgSU4Bv2L
 PfzYYeaZ2l/fmSnWEfxB12CJSi8CR5cEFIEDTjkQtTHAmiqTC3zgp6WTuEG4fN5hpIo4Eh0pLlQ
 nrQwIsydkOQNKG9hjd0084eforjniZ+fLEP3K4PD4o5lzTVrTUe1OUgyA1pgYUx5jnWNEfcQEMM
 /jGhImS44+F1nFpdQdMZV+aHltrttHhSe5zqew3l2cK1aL1ZRh0DbKSOKQME/alqX9I9s5OaEFx
 uRQ==
X-Received: by 2002:a53:d60a:0:b0:64c:561a:1dff with SMTP id
 956f58d0204a3-64e630887e3mr10667266d50.65.1773678994497; Mon, 16 Mar 2026
 09:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
 <abgqjKVFHKxuKupP@x1.local>
 <e596bcf2-962b-4857-addc-1200702fe455@redhat.com>
In-Reply-To: <e596bcf2-962b-4857-addc-1200702fe455@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 16:36:23 +0000
X-Gm-Features: AaiRm52gi2e5L5tor2gOGn3ja1IMSkFqOindBUlzTYmnG7swKY4iBYn4x1Bm1RQ
Message-ID: <CAFEAcA-n2EW=deU=jVcLd=6PysNZd5m7WTYrHLtQkxMo=KWBPw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 16 Mar 2026 at 16:23, Thomas Huth <thuth@redhat.com> wrote:
>
> On 16/03/2026 17.06, Peter Xu wrote:
> > On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
> >> Due to aux-ram-share property qemu_ram_alloc_internal dereferences
> >> current_machine which is not set during init when inspecting the
> >> device. This causes the qtest/device-introspect-test to fail since a
> >
> > Does it has anything to do with aux-ram-share?  I thought it's because the
> > qom introspect test will create yet another sun-tcx device, causing double
> > registration?
>
> I think it happens because the test starts QEMU with the sun4m machine (or
> whichever machine uses this device by default), and then creates another
> instance of the device for introspection (without realizing it). You can
> easily recreate the bug manually like this:
>
>   $ ./qemu-system-sparc -M SS-20 -display none -monitor stdio
>   QEMU 10.2.50 monitor - type 'help' for more information
>   (qemu) device_add sun-tcx,help
>   RAMBlock "tcx.prom" already registered, abort!
>   Aborted (core dumped)
>
> An instance_init() function should not change the global state of QEMU, so
> registering memory regions this way is a no-go. This has to be done in
> realize() instead.

Ah, and previously we created the MR in instance_init but did
the vmstate_register_ram_global() in realize, so we didn't see this.

I'm a little surprised that this causes a problem, though -- I
thought that we constructed the RAM idstr not just from the
provided string but also including the qdev path, so that
you could have multiple devices of the same type. I guess that
we don't get that happening correctly because the device isn't
sufficiently created to have a qdev path yet when we haven't
even finished instance_init ?

thanks
-- PMM

