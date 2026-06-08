Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BE7CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaOF-0005Il-HW; Mon, 08 Jun 2026 09:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWaOB-0005II-IV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:51:39 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWaO9-0004Di-Ot
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:51:39 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66077e90382so4050400d50.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780926696; cv=none;
 d=google.com; s=arc-20240605;
 b=YW2fTLS69i0f0/k8E0kUqAZFglP4XK6ZdfZv8lqmRmk4lpVbl3htwtyuvU1Rdx1bL2
 KBrWuAYVJoiD3LahJATO1zpC+7tQfNKWGfDPIuC+oBHlmehBT35Y6cW160+QbmA3uzY9
 IYBLua1YK6f9FcLMtN8p7ZT3k4IbWiA2vEvKeBujOnjdSGj6fiBLUrS7PP5EK+9zTuZO
 1q9rMLDSsC5SuZRXS6qPq4W1O3iMv1cZ8rkYgrfgET1B38FgeSk2vlRdF4LmxMitU4mz
 bFtJQhM5AdZSfa4kAn6O7Zubhqo88g6DdulP5g1rZyaR2A4cy2TMMWSZSl22un3Dbkqu
 xnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bKUj751TeY4nkEZpPo0FTWcTQnR2+/cwe6ZT7/QhNuQ=;
 fh=27JGi1vXTNl9hrhX20mPbsADtWPes3gHon/d+U8mG1k=;
 b=WuFY3s53pUJM4kCVxy5vpQ5h0m4wq7YWZ+7nAvdBRYmAxjrpLixdQDKImBQuyvgfv2
 6oqNVHC2WdrUyYIWJbOSl/4bRbdCdN8qhEd/+0yFadzQKl18dzg03I27B5Oa9QIvvVQm
 rXMqRea6ZGa0CV490rXJ+jFMzH0YBsC+2diFJ0N9/gTF4pFgFRwhITZ+Shxw/o5wAiPN
 Q8YdoZ73OmurIQx+Nut/XXqSOOze3GKvxkBcRRLfuXsAuDiVNQPRNehUK87fxrOAMmXf
 O/oGzCc75cerCUczNSaDvjJClquYl3eNa8/oPWvN3NvoPYV8q63kyDQsG9zB4Up7ninr
 XWAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780926696; x=1781531496; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKUj751TeY4nkEZpPo0FTWcTQnR2+/cwe6ZT7/QhNuQ=;
 b=gQ0IeJXXbtyS9VpiqvrTumtn8VbVTEmW8wq+OCdBeww1rO/i2OaX3mzN5hKE8GzxkZ
 bX6gyqOYTq16WJwulXR1/dDMkr2KtLB4YTMn52y/GZP+MTlgX/T5A0d/re9dqzraRmHd
 YrnkRIfg36XwqcoNvQV0LHSPg7O6IE4efRMns6gQv0FoXjFu49We+Jede+0e9IO/HDHI
 jiuC05u1JZZlsAtJixVAwvHiazWANRId3hwq9L7nMmf/25AiyuoEx99aLOjNsUxK77sj
 YpKqPJoqnbKT6q92QrKRCpJksWKEO7mePaFhETBWHKpSCmFozAu1udNQpxdOWlDDLfPp
 sUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926696; x=1781531496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bKUj751TeY4nkEZpPo0FTWcTQnR2+/cwe6ZT7/QhNuQ=;
 b=GupKXxb181/cgC1f1CH1ANuRn1Eo16xfjb3lYqtTMdnsrf1uapLuyzMgIcoRrWqxWT
 N9DcxCVyjW/rsdW1TcdGd7whfz7WplzFeeq3K1hnD6R+6tKkr8NsHP0GZMDgjlFaA+i5
 6B5VmjmcZvBRq7vudnFHjUGo7Q1M3eq+T445P86Minc6tEXCy47sSeQzv/uaulIkZpE5
 1VvEkCxdK6wDIQGClsg8sLSs8SUMSbjhUbU54ixBSx5h9GNYxAt5F7moKtAsS06KTKeO
 r7IAlHe+j4ImYWwp/XCga64uiaDE+hfnO+zWZN/oVq3HbKPFPDW1HgIM/k2qV5fu+OLm
 cVKQ==
X-Gm-Message-State: AOJu0Yw7dHn0MuW9hvWLmrTxbdpQkzmrCpAXRsNd2bsoHvIbgcEzMvqD
 pTIeAGSt2O76ko5ARtK/NhBmq6hv46SrEtwHQ7il+2sT7dRekJ7Rdl+G8Ordc6Cx861Un7Gn/3+
 FRJu1b6u6HZzVf21wFJV8s0DgYi2wDlPV6XVobcj/ug==
X-Gm-Gg: Acq92OHqYO4O3ttfK+/+xv+kj7BzEsg3YHlBcDSPk06v6rxvkF0D29G1Jotg5qGIvSP
 US+lK9UngSR7CO7F1dIHE3ZCPc9iKDhoWaiojaPwFCi+w96TtBzxtFmryGlHvw2V7YUA8kW7n6Z
 IDj218rMp45xBNDELhLgzBF7TTs7waVcHeuLcyuHR1ybalEJ59DcHq7nFRGJwRv4/Sd0v7APwRo
 LO40xYOFBkZaJY14tG9HPdXHXUSPdWbJUmbn0qwlZfRYw6FH/ZmZrBWmuSkbCZepQWplS4xairK
 LrbwWgYP48hRh0BUq2dT/iMl5gW1M8PAQUy7IyAKiOdl85k93kdQbepEuznoCb0RFD3t3kiFkHA
 jmw==
X-Received: by 2002:a53:ac87:0:b0:661:1307:3d49 with SMTP id
 956f58d0204a3-66113074155mr12044887d50.7.1780926696345; Mon, 08 Jun 2026
 06:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:51:24 +0100
X-Gm-Features: AVVi8CfELuu63-8QEYfJ12bzRvsrYJpzmkWaV0Rztq1EKICzbROxPC3RaYFy1rw
Message-ID: <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for
 A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This series fully models the behaviour of WFxT instructions. We
> already had support for WFE for M-profile but we left off A-profile as
> it has more potential sources of wake-ups. The main one is the event
> stream which includes events from significant bits of the timer
> ticking over.
>
> The refactoring from the previous iterations of the patch have now
> been merged.
>
> I've dropped trying to fully model the global monitor in favour of
> taking advantage of the architectural flexibility to have an IMPDEF
> event wake up for any reason. We treat the setting of exclusive_addr
> as such a reason because it indicates the current vCPU is in a ldstx
> exclusive region and we don't want the guest to deadlock. This does mean
> the system won't sleep on WFE enabled locks but people shouldn't be
> relying on QEMU to model real world sleep patterns anyway given the
> efficiency of emulation compared to real HW.
>
> I've written a test case using kvm-unit-tests:
>
>   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
>   Date: Wed, 27 May 2026 12:18:21 +0100
>   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>
>
> All patches are now reviewed.



Applied to target-arm.next, thanks.

-- PMM

