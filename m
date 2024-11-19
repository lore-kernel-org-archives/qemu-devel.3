Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E676FD44141
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDLsD-0007cp-Mu; Tue, 19 Nov 2024 05:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLsC-0007cT-2B
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:54:20 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLsA-0005ic-7s
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:54:19 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cfc19065ffso873524a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 02:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732013656; x=1732618456; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NXsqw6tNanTm5ecOz9lyMVAlyFpfeZ/RJ3zJ22UZAks=;
 b=cDvguUfvzbisg4S8S5s/lY3ml+E38586I2kWejgrGjhFb4suO8aKs+PuR2Brz6jpmD
 mDPJhDcUGyjUP/WQH6bUN28sU/6HNOzjFtf3+Z4npDxU9C/hYlGZZfLfM5YfePUJnPSh
 MieyYjoBeV4yO7m8+SJPkKLEEhSYTIFXN0XZI3sTlU3vVzeF0YEcYdpKeNV44uOk5WNf
 MfSu1UQOx7RM8CTR21ZJssTTQeHhWPf6PQpPyR8qAsaCP1reHTXHepFqTACHhVCJNBgr
 2l6mv2pGV9OzN4b/Klzdh0MmvERNgFNWASGdx24R7g2BLD9xaTeysIPKO1eqqWfJ9ZAz
 QawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732013656; x=1732618456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXsqw6tNanTm5ecOz9lyMVAlyFpfeZ/RJ3zJ22UZAks=;
 b=OKNM4AvHQ5/epIeaqMht/9XoM++bOgTo7CNx7zy9P/pbU7WWySeqyB9y7NhuCY+fEZ
 9akD6haI9J3UFMiL4q5f9PXuP6RtByLKGXOgYqz8zImX24bJLc3tNN7/YVrMXon9ZDKF
 j28OdE1mqYIcn/q6RE9Bgt8/gHc36+pjNmtTUiXUR7dzk7tbq52C5M/GGpiu+8/FEYsF
 n6buwtuNrKNHac/DaUk7lm8KnpJhB5mR+M9qUnDl8JgSl1iXvyieipma5X+A+bWWwlEW
 y8nuVJ6b92Nmbf7fkOQ+0MEtQ4XFGT5uPBVqV1po8EOLCx1jFD+yawWvlsH8w6ZTckMq
 2rtA==
X-Gm-Message-State: AOJu0Yzr4f2dHcu5cutdcQ9F4+UvbdZpMxGnzkVxy7+f9YPCUlx8uqFc
 x5igIDqqMa/COlwQgvaCfQJJ0xeP6EglylhcjQ+xtRarIHFLFVr1phJnG3wyTYxGPugCwC5+wEY
 iQ3bQNXQGvLAUFLLArMejDRNPnOYTqX+ER/SVfno4e3rUmyyx
X-Google-Smtp-Source: AGHT+IGqB1mSAnZ+IleZ77oEsCK+PzqFvPZwQSMQb+wlvYKcP74C3JVl+uEO5KmTkEJZ4yWj0SnEw/JSydpDN7zUZzs=
X-Received: by 2002:a05:6402:358e:b0:5cf:a1c1:527e with SMTP id
 4fb4d7f45d1cf-5cfa1c1571cmr10408262a12.8.1732013655902; Tue, 19 Nov 2024
 02:54:15 -0800 (PST)
MIME-Version: 1.0
References: <51442716-467b-46c2-b2f7-8ffdeeca320e@linaro.org>
 <CAFEAcA_eL+F572fZpFW2+Tz6xx5Mx5ux-axe3HR_fEf43_GLRA@mail.gmail.com>
In-Reply-To: <CAFEAcA_eL+F572fZpFW2+Tz6xx5Mx5ux-axe3HR_fEf43_GLRA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 10:54:04 +0000
Message-ID: <CAFEAcA_nBH0E6-0rnsMj6sGo+2i23kk59LJwoRyASaee3P=6+w@mail.gmail.com>
Subject: Re: Status of some Arm features
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 19 Nov 2024 at 10:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 18 Nov 2024 at 23:33, Pierrick Bouvier wrote:
> > 8.4:
> > - FEAT_CNTSC, Generic Counter Scaling (hw/timer/sse-counter.c)
>
> This is optional, and we don't implement it yet. (There's an
> open ticket for it in Linaro JIRA at
> https://linaro.atlassian.net/browse/QEMU-309 )

Oh, and I didn't notice you mentioning sse-counter.c here.
That source file is for an M-profile device, which performs
a similar function to but is not the same as the A-profile
memory-mapped counter which FEAT_CNTSC is an extension for.

The A-profile memory-mapped counter is technically architecturally
required but in practice none of the guest software we're
running on the board models we implement cares about it.

We don't model the A-profile memory mapped counter, because
so far we haven't had a real need to. Modelling this is not
completely trivial, because in a system with the memory
mapped architectural counter/timer modules, all the CPU
generic timers (accessed via system registers) are supposed
to take their source of time from the memory-mapped
counter (and so for instance if you write to the memory mapped
counter to stop it from counting then the CPU generic timers
also must stop counting). So you need something similar to
what I implemented in sse-counter.c where it provides an
interface that other timer devices can use to consume its
count (sse_counter_register_consumer(), sse_counter_for_timestamp(),
sse_counter_tick_to_time() -- these are used by the M-profile
hw/timer/sse-timer).

I do actually have a hacked-together prototype of this for
A-profile that I did for something a while back, but it's not
really in a state to be able to post upstream currently
(I just did the bits I needed and didn't really finish it
out or test it very much). So if we need this (e.g. if
we decide it makes sense to implement in the sbsa-ref
board) we could do it. But there doesn't really seem to
be any requirement to do this work right now.

-- PMM

