Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C97C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXWj-0008Mo-3l; Tue, 20 Feb 2024 16:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcXWg-0008Mb-V2
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:19:42 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcXWf-00019r-Fd
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:19:42 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5648d92919dso3459755a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708463979; x=1709068779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wax8OEADFyujbQ5rl75TkVpgcrBubP2k/60rzBnDK6w=;
 b=vwswrbH+m1zrxJGnEK/u0fPwibNvITT5yB+I8ZhdvcYJx5KY3Xyq3WYfe9KAWoPAtZ
 KAM7vtCe5JjIbzn25A4XhLHh3q4ksAFG/hARBT69s3+CTgZizr2DZJX9hevWyWkukiiX
 XqkcZHR2/Wjqyf/LtXd/3GJks7rHGYem0nW34F1Mttfl+EcCYmCm9AxNoRQ+2hAkpq9W
 uDyTa9nUiZ4ZJ+OsBQOmqXBXEoAIegTmta6T6rzyT4nsPt6sIVLNqWvFU5OCqUcRnKUW
 mspzjfv22MRa+ZnUnS3/6I+T7cD3Z98s1JyECjvHoMCe5/62HNn+3zuJiOzhvzONHwEr
 h4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708463979; x=1709068779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wax8OEADFyujbQ5rl75TkVpgcrBubP2k/60rzBnDK6w=;
 b=c5UGlGj+zkngCHXlYOOh66wRDsMjy1xBCqHq6GoLt6cnlUHLQAg53MrTCdvZAw/kTO
 C0zIaO1xslQtPwHEQXz2g/FQyvgg/QqgSYS+/bRxbj+W1Twf/3+FzOBgR0aQFk0jRknJ
 rDKiDBYC1vforD1+FbIs7tS4cHkq1dvH8FQmD6gW5pZFgpQcwRvZRZHiWYu4Wi+x8Ed8
 3olB3hSX3H9XvAEQremhU8WFD0I2gnavjm8QSpLxQQBfTMgcNrOqQjbCgeJmgD3UJ3DV
 JfqzcBXuT6CkU4SWKP15Kh7zG3pGu7QUvEX0LJJLtoU0j8khJyTzX5EXT+WLSTiqQ1Ns
 RRew==
X-Gm-Message-State: AOJu0YzJ2KK7zW/4VF8jjI9sYOBldEzs5g8qkVCKEXa+xrNy9+rEXrDC
 5rQ7/hXEu+zHV0yJSkdzEejDIzGzK/JM2z38hcS58OhOzCD+dVXfGBRWxIAGTgY0+Ml4Ttz18rG
 YEMZSZiuP8449DklhAoPtz3IYU/7Zsecf37ozyQ==
X-Google-Smtp-Source: AGHT+IHdFAjDpOAc5m3a+TrO5pNeWPWFg4sZRIDeFaNS3kXQf7et/Y/viG0lYqqEvaw25aNqYK8NPow/nuYnDUFdP4s=
X-Received: by 2002:a05:6402:34f:b0:564:66d3:530f with SMTP id
 r15-20020a056402034f00b0056466d3530fmr4783269edw.28.1708463978659; Tue, 20
 Feb 2024 13:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-3-peter.maydell@linaro.org>
 <1b3708f7-b962-41f5-809c-23f9e48c151a@linaro.org>
In-Reply-To: <1b3708f7-b962-41f5-809c-23f9e48c151a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 21:19:27 +0000
Message-ID: <CAFEAcA8JpNs0vmFb5LZ2M1+1zSuLtDq+ito8GYdGho4HazDdJA@mail.gmail.com>
Subject: Re: [PATCH 02/10] hw/i386/pc: Do pc_cmos_init_late() from
 pc_machine_done()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Feb 2024 at 19:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/20/24 06:06, Peter Maydell wrote:
> > -static void pc_cmos_init_late(void *opaque)
> > +static void pc_cmos_init_late(PCMachineState *pcms)
> >   {
> > -    pc_cmos_init_late_arg *arg = opaque;
> > -    MC146818RtcState *s = arg->rtc_state;
> > +    X86MachineState *x86ms = X86_MACHINE(pcms);
>
> We've already done the X86_MACHINE resolution in pc_machine_done -- why not just pass it in?

We want both the PCMachineState and X86MachineState and I think
our usual style is not to pass in two arguments that are the
same object under different pointer types.

-- PMM

