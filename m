Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D721061B0F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Fb0-0008E8-Ji; Mon, 30 Mar 2026 12:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Faz-0008Dn-4D
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:36:09 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Fav-0001JP-4i
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:36:07 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so5912570d50.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 09:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774888563; cv=none;
 d=google.com; s=arc-20240605;
 b=QiPqb4uKn3gDL2xFm2ysPv0K+s0ck7Of4I1DVq8yGfukaTyXgmV+IkTy6cD+bfeSKU
 DUuX4SEWt9TWJVaeJ7k71EBEFA9WE6hBW4NpXpHIv93YgOzgqVsWa2ZzkIkmbuTRVzoF
 mh4+cLslkW8iXsfeiCoftvoRH9jZ/yS/HKUMm4ZGw10zCEde6mNSNFoBody7eJGzPFPs
 vIOxymno5HwsDa5Bb93u9MRLBbQXzfYSniSP2uhECky+FFYHROi4t2L8sMgVClUrnhzd
 HrOf8qRVbJgMGPXzSxqcVlWh4KXa+nrsnMrMbdt9Frquz0jPlfYczVjuFE+I5b8LjZti
 A1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QYWfOkUaIVU2qhF1iKF+8gjo/t2fX3hPitm6nM8sVHE=;
 fh=tNFTkejswgEc8cgNACMB0VSqv/YC+CH1d+OSqqH5zlY=;
 b=KU+9zenlWDnfEBc1WjBDxKjGG8ehoqrNziL6HNOyDpoEnkQbaNl9MbZgMhWsUPgt5e
 BBWXvGfb6p6vTb9qDJ1EjYA+amGmkEve0VSRkQQTucC1DvTk9pZ1kXs/c4uuKhjw44WX
 UYhL3j6piResURUh402J90REPyi7T+RCfoklhJtDZmNuCo2zzwiKJZr28BDjcQ0XVobS
 zNpP4G/hbsFLMaC9uTb82cZFq/oLOIXBgPX4R9E8YfPk1P97s6/b6GzyZg2oZ6Tbh8kt
 ttZL5H5XCvYGj6xHowAEvtjKgYZ/bEIK8RgMG3dvkmjKbdRTz1gah63LVS5Kob0DatQf
 zL5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774888563; x=1775493363; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QYWfOkUaIVU2qhF1iKF+8gjo/t2fX3hPitm6nM8sVHE=;
 b=fzQekSbW/XaxcPuRKHcYF/3Eoe9+l/j0uBvhn7mcX/98jCHq/SwuLXxZCCQR/NpT56
 FCWrPLnrqDCqD7GXnsSkn+Ev/hPBEMKg9EBlftzjK942dch3puozNLmrpQyZW7kwTe8f
 Q/laY+1pSdb3qqaX9UEcPRFiGZKH6JpYl290YbCqBsyx+/1FzILnS7Czz7vrm629LNwH
 FcypQBtv9aXBitUUoCctOOqk1qBdfKinHaAqc3TkFl6MTi02/AsJbxvBMGkg5tea4tb5
 yW54XVDYmXeU3Eo7RclerYjbgxlXphr09O1LcxV4YDvYCPEG8f9dEFY2B5IuABKWtOFz
 i+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774888563; x=1775493363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYWfOkUaIVU2qhF1iKF+8gjo/t2fX3hPitm6nM8sVHE=;
 b=KfkOSjhEA5uHJZSKKjyPYuoNkN61b3J1l1ErMSRvIx77bQAmTG4GUh5EBf05feFAgi
 jrUDGmLd8VMSJ9xvfdERbz4jkwALo4/zAgVPgHl+vDeA0gJUKTs3X6lpk2+8XfJFe/KW
 RFkRmr7xwUGkxhugC5gCzxAEENug9tTHeuY0HzSQcVnBtNLVvwLzXeJTKGhy6PcdiJp3
 GPf1kqK1Bof8qc+isiXaWVLaiUuA91JJcyuGIInZ0/SMIJbAeexd/eKccO8eRdZTqJ+W
 xSrX75lpKU9sDwYm5NQstqSkoUy2fvUt8csZZqbEdrM0S5UpSJJn0pXsfbdoomENgEJg
 9Eaw==
X-Gm-Message-State: AOJu0YwHRy/GGfVwLaSVTwa6kyO93a0+k+A8OwHM69s+goxL5rUZM6NN
 BuFVQdKSKj1wktr01JH0o85ls+ap/3SmjzowXsiCl++V4pPIsKcWqLFVZstLWviSYlqVNdyliG8
 wNLHi6cYzhrUflQwGQNvHrsm8m8tIUj1gUMKZuw5vJQ==
X-Gm-Gg: ATEYQzx0MOrYAiynjxeUX4d5sa7pUnFVidVKbz1Fhw0Tphh8d4pAhK3rEI/NxF+Ctv4
 1xo6pKjJlqErTuOjlxNilcdK1IOymHBP/IeUlX8FmJsgYPMZnC1YaFVd4dFq47XxQPP/8u8knEI
 I3/yek7vkxFzyFGFBj4pjz2EHtnhHZRzEqqtYPe9PKuzgaT3eR+CqyzIaIhAP0eL+HnKg9x2S2o
 QxJgOhcFLlcZ5SanhGLAtN+9DATBOoXLWkjAVA8G6i5C9NlHFI2OPxCe0N/2acAyezHwJz3UFCf
 CO8V+9KjvGSvksGjF4l8ibUuP1GZfd+QCWwGw82+5+HhMTma4eRYak5ph5vtRcnADu3WuY2Kk+9
 uYg==
X-Received: by 2002:a05:690e:12c4:b0:650:1b79:9a14 with SMTP id
 956f58d0204a3-6501b799dbamr4055424d50.13.1774888563423; Mon, 30 Mar 2026
 09:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <ab26760db215ca858141a6252b79f3da@codethink.co.uk>
In-Reply-To: <ab26760db215ca858141a6252b79f3da@codethink.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 17:35:50 +0100
X-Gm-Features: AQROBzAdVNA06xcP-F8WHCdHkkS7MNPC1iDD-Z-JjRJK8X_VrOVogQUNFm2cR7o
Message-ID: <CAFEAcA-qe12nCCe3qMdZVBtmSrqDrhKOPwkCCMBy+QcdXQQQFg@mail.gmail.com>
Subject: Re: QEMU leaks memory when handling pthreads
To: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
Cc: Qemu Devel <qemu-devel@nongnu.org>
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

On Mon, 30 Mar 2026 at 17:19, Lawrence Hunter
<lawrence.hunter@codethink.co.uk> wrote:
>
> Hello,
>
> I discovered when I run an application under qemu-user (10.1.2) which
> uses pthreads if the application cycles create and joining threads then
> under heaptrace it is observable to watch the memory usage continuously
> grow. I've attached the example C program and a heaptrace.
>
> We think this is linked to tcg_register_thread having no antonym to free
> the allocated thread.

This seems unlikely, because the user-mode version of that
function doesn't allocate anything; the TCG context for
a user-mode thread is just a thread-local variable:

void tcg_register_thread(void)
{
    tcg_ctx = &tcg_init_ctx;
}

> I did also spot a previous thread looking at
> implementing a tcg_unregister_thread
> https://lore.kernel.org/qemu-devel/20231204194039.56169-1-philmd@linaro.org/

That thread is about implementing it for system emulation, where
we might be leaking memory on a vCPU hot-unplug.

It definitely is quite likely that there are leaks that we need
to deal with in linux-user when threads exit (I posted some
patches to fix a MIPS-specific one recently, for instance.)

My suggestion for a start would be that you look at current
head of git rather than 10.1.2, and look at it with some tooling
that can give useful backtraces of specific leaks. I've found
the clang address sanitizers helpful here. If you can track
down what exactly is leaking then we can look at fixing it.

thanks
-- PMM

