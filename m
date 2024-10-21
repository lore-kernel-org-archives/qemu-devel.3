Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6BDD15DB1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2uVO-000689-2M; Mon, 21 Oct 2024 11:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2uVK-00067x-Q0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:39:36 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2uVJ-0007Pf-1h
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:39:34 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a5f555cfbso297323066b.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729525171; x=1730129971; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KlqBo5yyWI9pKI4BFQg3HraJh7LcTBTsFqQP8+xG12k=;
 b=ZmRHo2tKc3ABSerytoWvYk640lgGNBrtWXXWArSIpcvRbxm4qS9j7oB07ObIS5uzCm
 pvbsLtjKSUELXDCoHQrF9HnpbfoKTMiuC8i6mtnjR/N1IwZTk4KFSilfcb6k9JthCb6a
 ujKr8lsL4lNyR1aMMkvAX7bTSXbLP1AJLuOfupKPLa8HM+706glL77qNOHN+HxrSA+RV
 n+b0v/iY0/GwVF3Kpoy/THqEbjn7Gn68qBZeVqX48BiQGDJyr2YUeZ7MuZb6/YhxRQmA
 Z4AgJ5e4UIuA+T5iF67yHWM/+MDA08MpUDPhxhIvrGG7UunlB2lGg8EjT9OH3ITnmb5f
 UyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729525171; x=1730129971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlqBo5yyWI9pKI4BFQg3HraJh7LcTBTsFqQP8+xG12k=;
 b=a0D/NfnQ6dQtF0B7NCznTwiWDLApmzv0/pcKP9WloJJX4H4T3DisYpQeczHhozKARg
 IJ3UmrOk5NG1QYEn5eQBm0GJHnFMxA5VQriLtZ++E5jhxgxAcRMAMuIzQO9I5r+Xl9ni
 96G1gauNHoY/80uzsoFfe75/2ypGx3fCbV3V//Dx/LGK6w9N/3zd0J9eEgtYKEqsiC6J
 kFaWPFZILXVBkwFLRjjlZlEl4EkhSrqeEhrkqTw63oS34OiN7hzFZlRzQviXpqEYoiEa
 FiD8RzUb+7fEzRzlv0Hsse432VWxArXlRS92VeCK3n0nCTXlHW5nIpFclD0Fb1d8AWzr
 qhuA==
X-Gm-Message-State: AOJu0YwsCBWo9zot0U//x+ELtBjCf5e6XGoGLfbAToDuVXLh8fL5ZeRp
 rKhMwjxIpGUNC+uvP4D/wchM/FSndV0bkv66logEjPeRnBiE6jjKgMKrbIkXnmfJoNXfcDbvBOH
 Y5i/ByMbqhSOYk8mRf8ohPfy++JHue0jvvdvxsg==
X-Google-Smtp-Source: AGHT+IEoHxTRcNgC7HzDllJBVDrQ8753IcJx/7jdrRQozxFggpck1a8XMbGwv1a8dFEzWBTvkpQpI5NLLMGo3YLtDL0=
X-Received: by 2002:a05:6402:2681:b0:5c8:8290:47bf with SMTP id
 4fb4d7f45d1cf-5ca0ac6e40dmr10719599a12.21.1729525170698; Mon, 21 Oct 2024
 08:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113500.122500-1-thuth@redhat.com>
 <CAFEAcA9VKkjfYgnv=x5kp+KUZ4rC0y9-KiCWBG+F84MBh7rxPw@mail.gmail.com>
 <a8bbb335-55f4-4c34-b56f-76482391c80e@redhat.com>
 <d5db0cb8-0ec3-4f41-a14c-7d07cbe6f4ec@redhat.com>
 <CAFEAcA8xdxdzXeX7YfZgz45sRqzEsDSWxrhkz11VOSWfVhQ3Dg@mail.gmail.com>
 <9a267d01-1259-4e2a-8ad6-e963923bed2c@redhat.com>
In-Reply-To: <9a267d01-1259-4e2a-8ad6-e963923bed2c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 16:39:19 +0100
Message-ID: <CAFEAcA-otzGP7ZB+rsj_x1oStcsT+N3ypuhtVzKHwvUBPbMLPw@mail.gmail.com>
Subject: Re: [PULL 00/21] Test updates (tuxrun tests, new QTest maintainer,
 ...)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Mon, 21 Oct 2024 at 15:11, Thomas Huth <thuth@redhat.com> wrote:
> Looking at the log files of the job, I can see in
> https://gitlab.com/qemu-project/qemu/-/jobs/8141649069/artifacts/browse/build/tests/functional/aarch64/test_aarch64_tuxrun.TuxRunAarch64Test.test_arm64be/
> console.log:
>
> 2024-10-21 13:20:32,844: Run /sbin/init as init process
> 2024-10-21 13:20:34,043: EXT4-fs (vda): re-mounted. Opts: (null). Quota
> mode: none.
> 2024-10-21 13:20:34,350: Starting syslogd: OK
> 2024-10-21 13:20:34,423: Starting klogd: OK
> 2024-10-21 13:20:34,667: Running sysctl: OK
> 2024-10-21 13:20:34,739: Saving 2048 bits of non-creditable seed for next boot
> 2024-10-21 13:20:34,966: Starting network: blk_update_request: I/O error,
> dev vda, sector 5824 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> 2024-10-21 13:20:35,028: blk_update_request: I/O error, dev vda, sector 8848
> op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> 2024-10-21 13:20:35,051: OK
> 2024-10-21 13:20:35,088: blk_update_request: I/O error, dev vda, sector
> 12936 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> 2024-10-21 13:20:35,149: blk_update_request: I/O error, dev vda, sector
> 17032 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> 2024-10-21 13:20:35,181: Welcome to TuxTest
> 2024-10-21 13:20:35,882: tuxtest login: blk_update_request: I/O error, dev
> vda, sector 21128 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> 2024-10-21 13:20:35,882: blk_update_request: I/O error, dev vda, sector
> 25224 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> 2024-10-21 13:20:35,882: blk_update_request: I/O error, dev vda, sector
> 29320 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> 2024-10-21 13:20:35,887: root
>
> So this is indeed more than just a timeout setting that is too small...
> I don't get the virtio errors when running the test locally, though.
> I guess this needs some more investigation first ... maybe best if I respin
> the PR without this patch for now 'til this is understood and fixed.

I guess big-endian is one of the setups most likely to be
broken :-)

-- PMM

