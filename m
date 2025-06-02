Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F94C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 15:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM78n-0000TL-8g; Mon, 02 Jun 2025 11:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uM78k-0000Sy-Nv
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:31:54 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uM78i-0001XM-4N
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:31:54 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-403407e998eso2714045b6e.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748878310; x=1749483110; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GGEoK/+QIc+qTv25wns84dfmjQtAMU4zYUFc0evEeBY=;
 b=q6208Fxy027GWpisv3Ujd/9uvMjUQOLjDjMIU4nmG9AzKOho+2gVCb6Ns+4A482f4M
 4uGgPaXlP1NduB93SLjPfbg99B98z8/ohsc74XHMMm7b9YKuuaJX3RuGkLnSS49dnBYi
 tXYmHbioVTbQCdcvBzZ4J4jeYtdMQKXnrOB8r3d3Y/HZZ2IneJYSZAJZV9VrCnDsMcMl
 qutWLa8u0+OYapI1oxiQGVRXWBO2M6XyiaNv4wZVTeeka4Z1xMPr8jDZwngruOiqhcGo
 8YI+X61zqbdXgbJseJxSD4Kf/YMh1O8m6AfDi2SbpvS/+DDlRzfETyKCyO4Vfmf6gGNC
 UOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748878310; x=1749483110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GGEoK/+QIc+qTv25wns84dfmjQtAMU4zYUFc0evEeBY=;
 b=NsyaRlBX9A7i9my6aO8fGlHeocKY/t7labi6Qdh8DBIhqJmc9jGKxngH+jS5RcCvfD
 559Jynoes40wO5+BvuXLwKQLnlsINrpqLYcOtrhGoqMEiT6mfORqHEQ+TezpKwpqgH0F
 Kp1DVw542Mxb4om1/P6lcqxBc1Z8VgsHiQt9dkDPpuu7egy4z3p0JmcUS/3lluz3LtQA
 x7FjWmkXyZPihcJWHaImoSXyafrr3yD473TlNVBQNXNWPw6a2nbzxq2lwr8M6pl4qGsm
 AKYYdBB1Zbhv+AA9uqsVheX7PQbrKsbEdaHzH6nHIN6OeVJq6vFTNGSNsd/icj+wAj6s
 ZuTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSMtxmYOdSygSrjzt5G+MXQJrIyIR5JkgvAOK0TjTa2LVrOfOBy4Za6QHLW7pG/EMZfjsCQAkH8ge8@nongnu.org
X-Gm-Message-State: AOJu0Yz6sL2ILB3DEo06ivbbhxLMI1GjPA/EENp1EiblN3AYyK7WPUEx
 59wUEuR1k6LoqrOpCZObf76szjAFWztTwgmJcWPNxsxU2hyuNHIGHjU9DD0d1gljszUJjaV7WmE
 2GPGdciurzA4lYdE71UoepO1lZq01Y56FHdAJaTo7uJ5BlhFJQVeH
X-Gm-Gg: ASbGncs4d73mx3WxID2XjonHGwBXzs+wdYvipRfzLz8FufRv7SLN6gmM9ZYoh25s2j5
 utRhRRlqDS7rEh736oP3negGGPvb4/Bj4LkeaRejMsc3mtWUPGlbBkME3Kss4KYuagqFH9CQHMA
 Sej9lV/zDADBfZSxXSV4c+s9TSsAy9kZ8BIA==
X-Google-Smtp-Source: AGHT+IFm5WEL5t6oKjGkXkv0TartRKIKRcI9pXXOaEOzWJp+ZPlKec06PQUiSp7Ka7RZGPeOgFD628MazO4XjLUXQGs=
X-Received: by 2002:a05:690c:6382:b0:70c:c013:f26 with SMTP id
 00721157ae682-71097e62258mr110272497b3.33.1748878299704; Mon, 02 Jun 2025
 08:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <7aae8238-f7f4-4f3a-9a7e-e9afc99d1d0c@redhat.com>
 <1301bf7e-0e52-43c0-9910-55ea34647a34@roeck-us.net>
In-Reply-To: <1301bf7e-0e52-43c0-9910-55ea34647a34@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jun 2025 16:31:27 +0100
X-Gm-Features: AX0GCFsaNcY7-pGXClrTdQHe0n1lU-lWjnYgeC8uCJzVPJcDZO5vXsu6B4FR8O8
Message-ID: <CAFEAcA_0Hu8+G50sy0FJ2rX-=cNymLddDdrS2nN5ZY-doKiT8w@mail.gmail.com>
Subject: Re: Is anybody still using the "highbank" or "midway" QEMU machines?
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22b.google.com
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

On Mon, 2 Jun 2025 at 15:24, Guenter Roeck <linux@roeck-us.net> wrote:
> On 5/30/25 07:23, Thomas Huth wrote:
> > I was trying to create a functional test for the "highbank" and
> > "midway" arm machines of QEMU, and only succeeded after lots of
> > trial and error to boot something on the "highbank" machine.
> > Peter mentioned on IRC that he also does not test these machines
> > by default, so we started wondering whether anybody is still
> > using these machines? If not, we should maybe start the
> > deprecation process for those instead?

> I don't try to boot midway anymore. Commit log shows:
>
>      midway only works with an antique version of qemu. Stop testing it.
>
> That was back in 2021. The log shows that it needs qemu v3.0.

Might have been fixed by QEMU commit 61b82973e in 2022, which says
# This change fixes in passing booting on the 'midway' board model,
# which has been completely broken since we added support for Hyp
# mode to the Cortex-A15 CPU

> I only test highbank manually (not in automated tests). I have this in my code:
>
>      # highbank boots with updated (local version of) qemu,
>      # but generates warnings to the console due to ignored SMC calls.
>
> I have not run the manual test for ages, so I have no idea if it still works.
> It also looks like I removed the local changes. Those were needed to enable basic
> SMC support for highbank; maybe similar code is now upstream.

> Ok for me to remove both. Not worth the trouble.

Cool. I don't think these machine types provide anything to
users that is particularly interesting (if you just want
"boot an A15 or A9 Linux" then the virt board will do fine,
and the original "test system software for this hardware"
use case is long dead). So I'm in favour of deprecating
these (and eventually dropping them).

There's not actually a lot of highbank/midway specific code
here (no complex SoC modelling, lots of stock Arm peripheral
devices, so just 400 lines in hw/arm/highbank.c, plus another
450 in hw/net/xgmac.c for the ethernet controller), but
if nobody's using it then there's no point keeping it around.

thanks
-- PMM

