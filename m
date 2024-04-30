Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157BBC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oDl-0008KD-Ih; Tue, 30 Apr 2024 10:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1oDj-0008Jn-Qg
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:12:35 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1oDh-0005Dn-6d
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:12:35 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e6affdd21so2291432a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714486351; x=1715091151; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+c0a+HMJqB2l8tJ8VFh7s1TOI4yHvMqGBFIiTJbQjlo=;
 b=rOGsmx/tGPJ3PvBsDkfhG1ADT2+NwtZh+vQOI+fWpZY/clKYsYcwc/UedUg+8szwoB
 p93OP/ZMm5qDvq74ARW7o9ncrKpeRgA68dG9L+ACcFBGARe7qiR0ynYRA9GqtfpjtO73
 OSPx8VUUxTFKaf8EG0TJszxVSbG5lwXoeBNC0VYvf9Qtw6kq42Y1+o/M+VKtGnj78sFI
 6csEwczczFpfDHluDQjBCCHTXoWcf2w3y7ARTXgNR2+QnUOvtScqaUMYANvJpOZ9nplm
 eB3zXYqnuOWj3MBIfBUJzYA0Rbtd6Dvj/2+ZbXwZ3wiaag76/nkwBMLNpSgmxCeiMa16
 tmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714486351; x=1715091151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+c0a+HMJqB2l8tJ8VFh7s1TOI4yHvMqGBFIiTJbQjlo=;
 b=StUqvkE5s4mCGkgkBCcqh/sl0oQOgOhcBuGkNvPmau9nY+4MuazKeVV3+8ZUZccNsu
 xzGX0QdPSJQKYo3YLOxRGv8pShPIpVB1RbXDLd7pj0z7YJty2lGzUCP9tZEY6Ph+Q+RO
 RI1Feua5g/7TPmRsuoYjX7g4eoi878QCwn923M/syR6hN5bqa2LIG4Lzo8dMw40uzw3C
 nPzx7mV+njfEMEreIkaqxEwLT47VUGARnFjLBK2EfHSQ2+1G5fGFfkn3/BiCn3m/1fbE
 kfn7+5QclxSlsROwyoGII2jjt2U7yQY7hooqpyIEdilfPP0rmHS5CgRa9Sx6CT6TuZpK
 lHDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1rSQ45fdDH8NdQvyu9P8Ct9hYtckTGjIQO1rZ5DY0MuHpv/ZbXNWTtqGMbA60LSzkVyzZnRe51fnNYziDRM9oYoFjjiI=
X-Gm-Message-State: AOJu0Yxh3kVWrMjVInp+n+7KfhJwEeq+Vgl9L8maRR6D5rl5wMzaQlWN
 eU5lTQZIVVxFU5mPeqanyxAs6jzCCNsG/ZAZZhtmzpHZiIqWQq/UJp/pi3LjTObcFkVzknz11M4
 G4dO7fJ/HK7SM/VDJThN0MSqEvQra+ngNEUPStA==
X-Google-Smtp-Source: AGHT+IFn1ssdxRjyP0eKordp6842dVgwri0kXUuLwWyurvmp2MYNqQ2W/RG9E2lDNrpzBpn8ZzsaEvjWdEQeptHAlMo=
X-Received: by 2002:a50:9e87:0:b0:572:7d75:a70e with SMTP id
 a7-20020a509e87000000b005727d75a70emr6457454edf.25.1714486351368; Tue, 30 Apr
 2024 07:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240415151845.1564201-1-peter.maydell@linaro.org>
 <CAFEAcA86Frw=GcWdjOgXsbP+9dgGjQpxP79k=nKshPm9LK0QVQ@mail.gmail.com>
 <CABtshVRrPv8uUuX3C2k1BPkS4-_0HQH6aKiMFmLr1B1bck-+Pg@mail.gmail.com>
 <CAPan3Wp7jzm+ErEi0LR+F0acOggt94FPfJCYb-VEUGriiZnPtw@mail.gmail.com>
In-Reply-To: <CAPan3Wp7jzm+ErEi0LR+F0acOggt94FPfJCYb-VEUGriiZnPtw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 15:12:19 +0100
Message-ID: <CAFEAcA8FS=6mn754LGs6KGDahm0vyifiK9P2i57i_TsKvPqUOw@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: update sunxi kernel from armbian to 6.6.16
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: Strahinja Jankovic <strahinjapjankovic@gmail.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Beniamino Galvani <b.galvani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 29 Apr 2024 at 21:40, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> Hi Peter, Strahinja,
>
> I can confirm that the orangepi-pc and cubieboard based tests are working OK using the newer kernel 6.6.16:
>
>   $ ARMBIAN_ARTIFACTS_CACHED=yes AVOCADO_ALLOW_LARGE_STORAGE=yes ./build/pyvenv/bin/avocado --show=app,console run -t machine:orangepi-pc -t machine:cubieboard tests/avocado/boot_linux_console.py
>   ...
>   RESULTS    : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 1
>   JOB TIME   : 177.65 s
>
> So for this patch:
> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Great, thanks. (I'll put this patch into an upcoming arm pullreq.)

> About the BootLinuxConsole.test_arm_orangepi_bionic_20_08 test, I'd be happy to provide a patch to revive that test.
> Since that test is no longer working without having the image available, this could also be a good moment to re-consider if armbian is really the best input for testing
> the orangepi-pc board. The image is relatively larger and slower compared to other images, like the two openwrt based tests for cubieboard and bpim2u.
>
> After some searching I've found that Openwrt also has orangepi-pc support:
>   https://openwrt.org/toh/xunlong/orange_pi_pc
>
> That image works fine with our emulated orangepi-pc board:
>
> $ qemu-system-arm -M orangepi-pc -sd openwrt-23.05.0-sunxi-cortexa7-xunlong_orangepi-pc-ext4-sdcard.img -nographic

> Using openwrt also for the orangepi-pc test instead of armbian also gives some consistency between the various tests, to some degree. What are you opinions on this?

Yeah, seems reasonable. My main thing to think about would be
that to understand what extra coverage this gives us that we
don't already have (there's no point running a ton of tests
which all amount to "boot a Linux kernel to a shell prompt").
It looks like what we get from this one is that we are testing
the "boot off an SD card image via u-boot" flow -- is that right?

thanks
-- PMM

