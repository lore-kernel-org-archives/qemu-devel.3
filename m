Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2DFC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0mz-0001CX-Sr; Mon, 17 Feb 2025 08:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0mu-0001Bx-Gv
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:03:52 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0mr-0004Bo-SP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:03:52 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6fb0200b193so39814027b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797428; x=1740402228; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N36CzgkxQ/ZEegvCvcDE6yqLGkrsappvLNmw9W/A26w=;
 b=zQFa+bM5cUeM/5BVetYRXM9xATljn7HHo+81XM1TmHfpTHKHfJuH4DRUzlPxNT4adg
 brWXiA5pjhdGrrGiNLsPuFBgejeNGYH6jiSCvCkIeRCtTirz4835n/Im5hzx7I3u7EM9
 4SLpAenV4XfPtT/EadWLfJyygfTuPEQiUKuDkZnbZQchqRaLH5cVorglu+Agu7SET1VQ
 fAr4TCzWMGzWONbB7I/g/wA0PurYfRACe4IA/MXB5OtbkMhnp5XyJ9EMo+7vFWW88MZn
 yErFYDbupl2Ilf51NfR+lbcXFM0d0FI8ClgRLRLmeNlfQBngMxb1nkxc5Rdlwj9YdPE7
 CDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797428; x=1740402228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N36CzgkxQ/ZEegvCvcDE6yqLGkrsappvLNmw9W/A26w=;
 b=mlFUca/LKHgx+tfF26+8C2WcgTuYxKw9DkiWjbrPq6sYEZPp2IjiSZOrPPxTX+XeYS
 uHZ6VvYnsBsvFTrSjboLA7QyY3/XFbQ4FKdNAX0dsqH7K8SfmbDEzHXSa67w6FlcemC7
 y2n5V2fEV9S0QzQk8dMrEjBJ+Bk9OKLYrttBptp45aiY0s91B1BLefyOq41Wkwig5rZ6
 nRTHQSwE2h7IXswwzIPJLwojv70KxGA9k9BMFpzCLabbvDluL2XDZ5apcMbG6atw/lzV
 17+woPJOZI7EerIeRVI1UBLUCjy83xj0rpxuceRCkZSBYwZYB09v84MEibeQWNUxErDh
 pTbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV5mLdJ7IS9vhzVb+yhnQJeCh+7lD/sOBetdCSQMoZVahhy+Dzzuq4B/DwaRL4L1zZiJMQ9DG30ZQs@nongnu.org
X-Gm-Message-State: AOJu0YxQyQKkje8+810EbtQThOQmgrDywY6cJYu3TtyRApvgt8lVLB1N
 p9SiGePm/Qv5BNknJo7NWa+poz+4EinpCCUgWtGsuRsdZeyp0jey/SIVBuzKuekUdCEpxOu6pSB
 lTkAN2H6fWiGMSypY26qJzADJsVCDZKVVwzclNg==
X-Gm-Gg: ASbGncuAtleUz/wz8al8ZmzcmqEuBf3q/fwqSJ+1RkQN0HZffSy0MsES9fDtLr/gM8C
 S/42h4R9u8zauy0/AQGjlbhW6afe67tLVngyM0wXvvP3LcwQpqcd/Dx4ZaB8jLoavrB90InXNHA
 ==
X-Google-Smtp-Source: AGHT+IENE0Cju4mftk2h0n2ehKOp9lk0IWmTzda6lNphejbPUkAkZn+/brOOv93bXVXhZgC1l0fqBmecdM3trT5FJPQ=
X-Received: by 2002:a05:690c:950b:b0:6fb:8e5b:bd16 with SMTP id
 00721157ae682-6fb8e5bc027mr2021957b3.25.1739797427874; Mon, 17 Feb 2025
 05:03:47 -0800 (PST)
MIME-Version: 1.0
References: <6866d6b6-24af-4743-8407-26ae2998dd21@gmail.com>
 <CAFEAcA9B40F21r9RgeDd7k09juy35k9QWewzgkmyNkYVK_K0-g@mail.gmail.com>
In-Reply-To: <CAFEAcA9B40F21r9RgeDd7k09juy35k9QWewzgkmyNkYVK_K0-g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 13:03:35 +0000
X-Gm-Features: AWEUYZnkzrX1v18ZYMZvoZ93bAJK3Nd33aB0NJ3a3785YfVzVmi_SzfJwZGOnTg
Message-ID: <CAFEAcA-U3QTWKhNr4Nd39hX7e+i+HDEyu8EZfSOm37GvvaH-hw@mail.gmail.com>
Subject: Re: ldrd implementation issue?
To: Stu Grossman <stu.grossman@gmail.com>
Cc: qemu-arm@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 11 Feb 2025 at 10:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> (added qemu-devel to the cc list)
>
> On Mon, 10 Feb 2025 at 17:26, Stu Grossman <stu.grossman@gmail.com> wrote:
> >
> > I've been getting SIGBUS cores with a bunch of user apps running under
> > linux 5.15 and qemu-system-aarch64.  These happen to be 32 bit (T32?)
> > programs.

> > The fix is to defer the register stores till after both words have been
> > read from memory.
> >
> > Here is my fix:

[snip patch]

> Yes, this fix looks correct to me. Can you provide a
> Signed-off-by: tag for it? We can't accept it as a patch
> without that. (I can do the other administrative tidying
> up of it into a commit, but the signed-off-by is what says
> you have the legal right and are happy to submit it to QEMU
> under our license (LGPLv2.1+ in this case)).

Hi -- this is just a nudge about whether you can provide
a signed-off-by line for this fix. I'd love to take it,
but can't without a signed-off-by. (Otherwise I'll have to
reimplement it from scratch, which I'll do at some point.)

thanks
-- PMM

