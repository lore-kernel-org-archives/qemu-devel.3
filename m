Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE19C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 11:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdTWf-0000jT-Pp; Fri, 23 Feb 2024 06:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdTWe-0000jE-RR
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:15:32 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdTWb-0003BG-T0
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:15:31 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso736846a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 03:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708686928; x=1709291728; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lmHQxMRvhUF4S4WlFFjnyvmRFPE9JIxE/feTAO1ztYA=;
 b=s/StazRWJVj6NZwX7zXtMpaGahqoNw0JCJmNpbjyxSpiSvAUVXga6TwasJMb5AeA0U
 UvF02aExcEaRsndXQc8BzUkq2xaj99YoTkcxOeNpg6v9Jyiam2vJIQEJeGTxETk6V6Oo
 rE3AJ+CYeRZQHWv8FH+kFr5j9OZCd1ItDeQj/qKhayYsIJJ1v0eLApknyyLXunKWJSDN
 id93sNTqtL9Js9WTEl00pcRzT8sBJMXwOLiMo01X/en+I8OmnKInH7uEBCLcZdpZiZiF
 QZqUkPT48sCWeYEWNS+QJ2QEHsDhjNqsALQM1LhBj0sFE3fHkk7rEuGF2Upb29ZfkSeU
 frug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708686928; x=1709291728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lmHQxMRvhUF4S4WlFFjnyvmRFPE9JIxE/feTAO1ztYA=;
 b=tVeIa/2fb6oWV6c1p/DoH47yIrTiyt/8DTsftwv/lrxwzf35gjTuyLtebwm1HKX3jZ
 zUkw00UsAHpr5pCqs0AXogKKg97Kud209R08uPJSh/woHr3ts3R9ho7mhxRVCjPGLS4l
 Nb39CUBaQrQMSa8YNq6EB4SqqDKRhf0RZxvGDnJ+jJWK5JpWnrKDx7WZuoUJP1YH6l+L
 /MkDgLyzvna2LZrKJrRfEBpYWtGiZbkiJh5YT5QgLoxnx+Y3ct4b/7QpRVwIU4Q7CzJg
 WsV0GV90KPb5aZJ/WBey7p/QmUjC/a0ty8qbHF3NqHyNjaVNfFww/74g3XVbd0oRdcyF
 iusA==
X-Gm-Message-State: AOJu0YxnzDDY+O+rkaW+OfWBWp59P6dt3phutkzHzJKEVwgmVR0+NyRn
 /3yTyW9jyRitZEsobjF589BrO48MvMXjkI5UuvNl/Zic9UorxLYU+/kSSj3/QdTCPd4A1cC6K/n
 y6KnlzTpWNl4p8QwVv9SmjpzKzxR5Mz3NT19A8Q==
X-Google-Smtp-Source: AGHT+IHhChLB4aTxk9sYQBCYCZtRCBo1DRBxHFeITFAbPwCmM5CC3WU092xf+tTXKWpzjDJurTNLRaTtEDlMMxGwP94=
X-Received: by 2002:a05:6402:14d2:b0:565:eb8:f3d2 with SMTP id
 f18-20020a05640214d200b005650eb8f3d2mr835245edx.21.1708686927942; Fri, 23 Feb
 2024 03:15:27 -0800 (PST)
MIME-Version: 1.0
References: <ZdhyX0eufxK1M8og@cormorant.local>
In-Reply-To: <ZdhyX0eufxK1M8og@cormorant.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 11:15:16 +0000
Message-ID: <CAFEAcA_jnw2iocRMT8OBx0fWP5tct3H-g13KASib-yzCMsvz4w@mail.gmail.com>
Subject: Re: Clarification on cross-version compatibility requirements
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 23 Feb 2024 at 10:25, Klaus Jensen <its@irrelevant.dk> wrote:
>
> Hi all,
>
> Yesterday, a bug but in hw/nvme (#2184) was filed
>
>         https://gitlab.com/qemu-project/qemu/-/issues/2184)
>
> The reporter ran into an issue with hibernating a guest from QEMU v4.1.0
> and trying to resume it on v8.2.1. hw/nvme has received some changes
> since then, including a change in the BAR layout which causes the boot
> to fail.
>
> Now, hw/nvme is marked 'unmigratable'. I realize that this is only
> observed and checked under live migration, but I honestly did not know
> that hw/nvme were expected to ensure that the kind of "hibernation
> migration" works.
>
> I already have a potential fix for the issue (because I don't just want
> to say "wontfix", I'd like to fix it), but it got me thinking about what
> the general requirements are. And I couldn't find any good documentation
> on it.
>
> So, my question is: when is an emulated device required to support such
> version compatibility? I'm asking because we've also deprecated some
> stuff, like the device originally using an internal Intel PCI device id
> that we wanted to get rid of. But now, I don't think I can actually
> remove that parameter, I need to keep it around for hw/core/machine.c to
> set if necessary.

So I think the answer is roughly "if it can be sensibly used in a
versioned machine type" (we might make exceptions for obviously
prototype/testing/whatever devices). It doesn't come up very often,
because there aren't that many parts of device behaviour that are
observable across hibernate-and-resume an the parts that are are
usually nailed down by the hardware specification.

-- PMM

