Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C6EC02187
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 09:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taAxC-0008ID-Dk; Tue, 21 Jan 2025 04:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1taAxB-0008Hr-B9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 04:53:49 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1taAx9-0004xu-KF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 04:53:49 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e39779a268bso7971602276.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 01:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737453226; x=1738058026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6zxenglKOdTpDVqosoVEBzl8yzpYtl1OVk+4VG4qggA=;
 b=FZrni0EP5jSALZJEXUN4yhO/v53U6gWZQo18JQvHWxs0sX/sJ2sbCjNF/NxPP1G6z6
 /UyJNfV3hHj/3hQfIbsZaxadwmMNGVmXidnz4coSQRoSvb+L7HIMX96Tbt3fii4CmCEP
 HFBInfC0AG2+3Es8i/Hjxag6vplCNSnVXHVKGRHzupj967CgkV3DJ3ivzmGgnOgCIjlI
 RepreKBoNjO8i7grmppKtMzftH93WQYki2RG+rV3IiuV+xIj5U6BQmOH5i7gNDGm61sB
 lNNqC9KTAIdU86YgTD/F6NdWhV1I+LWaA+jco+t5iSU7q2aiJRUnykt2GJ3D8/vkydb+
 mYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737453226; x=1738058026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zxenglKOdTpDVqosoVEBzl8yzpYtl1OVk+4VG4qggA=;
 b=be2jFau0MfAth3NRJtUgRbK9guVM78u/O4scsQYw72b3q30ITNcZKLH8dhWxOVRbjP
 srtg7SfTRkIjNiXNH1umy+5rX7S5nHMJUx1oJN/eVYAEMG96VC7iqYMGPrfuR9UrzJS2
 CaefNfXlJYB+VczFHzNwtC75YwpcVh8Ps7a8wkGuc+jkV5mv0MlprFgyB1gLjy4j5uZW
 047vhnBz4Td2AxJ6zMmLpYtQnSs/HuaSvkZdh66CqcXZ0HklpVB8iO9sqI+1fyujRqwp
 nDvSyFx2PoIgQ/eguscTtKQZi/Wl/EGzp1jFcThArYm5/yNgCUfYe+xV0vcNtLgKYtHC
 yKWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBYgudiw0Jk+WFQxfovb5X7cYSG6cPr1e9rju46N0VDqcGkA2Mtsdp48Byi9ycFJ/q+6Dp7KxMjlNB@nongnu.org
X-Gm-Message-State: AOJu0YzCcMqGtl3gXwqwZ9e2BI1J2GTeQVKd1JbxncmpTmtuAad06guk
 x5WCMUTiK5uYahJnQ0lJMwU2L9GM4T0EhugEdfFpykkyeXFQZh21Q4Zc58AoVCvVSfD7cZSL0Yy
 Snlz41ig0wn5ZTGPQbP2A9VB7zF7BjHAWlsfgYA==
X-Gm-Gg: ASbGncumd7KHbxyLlC/KaH8sZerj+gjVGK6+U4pKUtftzTkTa0+iNQM1+Z64CtE0P89
 D3sXJptq4mfZbunerzUkkmcAjgCD8ZYOgnuo7WbWygqdNiGNJX/Dr
X-Google-Smtp-Source: AGHT+IGdCPU3gdOsfU895As7ssY8E+ToGbAOFY0yFs/FX+th2jo3nT8og/h9HJQNJvDIBXEAfoQ/Z9rL+Ep6p0dpQps=
X-Received: by 2002:a25:aa11:0:b0:e58:a85:e812 with SMTP id
 3f1490d57ef6-e580a85ea1amr276968276.18.1737453226307; Tue, 21 Jan 2025
 01:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20250120150049.3611864-1-alex.bennee@linaro.org>
 <CAGcCb10gHVZdN6CbUm02w7jTaUUoBH4-VTohmy+yiP1OLWFBxg@mail.gmail.com>
In-Reply-To: <CAGcCb10gHVZdN6CbUm02w7jTaUUoBH4-VTohmy+yiP1OLWFBxg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jan 2025 09:53:35 +0000
X-Gm-Features: AbW1kvZ3JzgpvXIxnIqLALOIGSov5VWxAWAKw90iss4Q0iUbMI_Y11L1lpboUkk
Message-ID: <CAFEAcA93xPuBTN6LSHLjXGfzar2ZUZsBBxJVzLOPM9_FooS5Sg@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/qtest: don't step clock at start of npcm7xx
 periodic IRQ test
To: Hao Wu <wuhaotsh@google.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Mon, 20 Jan 2025 at 23:52, Hao Wu <wuhaotsh@google.com> wrote:
>
> Have you tried that the test can pass with this? If I remember correctly, interrupt won't trigger properly if not advancing the timer
>
> If the test passes it's probably fine to remove that.

This specific clock_step_next() call is done immediately after
resetting the timer device, so there *is* no pending interrupt.
(That's why it's a problem -- it says "step the clock forward
to the next pending timer expiry", and there is no next
pending timer expiry.)

There's another clock_step_next() just after the context
in this patch, and that one is fine, because it's after
the test enables the timer and so there will be a
next pending expiry to step forward to.

thanks
-- PMM

