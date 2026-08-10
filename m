Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD89DC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSRO-0007sX-SB; Mon, 10 Aug 2026 12:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtSQl-0007q1-DY
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:00:57 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtSQf-0001QS-2V
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:00:47 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-80cebd41372so28684757b3.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 09:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786377642; cv=none;
 d=google.com; s=arc-20260327;
 b=bUiveSWDdUcWuAyQmwXt529GxmqWRxZkJ0NCc+C5UhQJLYOOh91zYZjju0kUTxd1t8
 qi/wStSJrjvKTI5U0T2UCncEHaBx3S3UcCLM5zOzn5nzMe5TMtpfgqkHGfbElomZRI+g
 bzCenPOTo2U6tw6pSv/qIULnp4g83cD5uoANVuJOB8HBCzugaDi0k7w160HuY51XK7EJ
 jR0zJ7nUhm24SbB/amd5wPVna9QvdOR0vbcJvQXx8attGcqKNhwRBe0x1quKkJ9pqTKs
 aGITw2Tsa9xV23Js1fdiuog90/D+kEisKiuJO8W2iPzb/Sf7tkmWQc2GwObVsXy78+gq
 D1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZM2M+4vSKk+ehuW26k9cv74na2+OzusaTrgKyysV0gk=;
 fh=yQJexhFxNZ8AQrdz0beskElJZDvKl1BlTBoJLzFI/rM=;
 b=X0ts8liJ7t8PyQvCJy1GPgEH5EcanrtS0S5XlHAupRyeIHxdJN2dII2biiQnYtiRQ4
 aBiGMtRLlbQ4W9RNv4lcGmCCvXhyvZn73Awc2OUteqsjI9vv6NXIsnuBh9JxZG8Me9Rl
 BmLkogQa7jVMjftn62YBGkgxi0cpWY2QaGlLZHgSuQImmoNR1BuzCtfB4t16LRmZckE5
 O7c8rW/YvDiAxiHacPsxEZOrcimC7UiE2cXbG1GV2tCjdhOSRH1amm2P2yoUl7wanVfl
 bR1p0AmHPmZSI2R5tkTKW+mIg07C0FInRGr3TeY+WGnaPxiw+Cd8S14gqu3WPtEDKTc8
 Yi8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786377642; x=1786982442; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZM2M+4vSKk+ehuW26k9cv74na2+OzusaTrgKyysV0gk=;
 b=b5wGDO24WNSegeQz/YV+Zbwjr+fVEVAEdzR3r1zp4ZqKjbS9YY/y0hOvZlFbKygPPR
 b9/HeewwyoOwmOL+6FoQ0P2UdlcDD3cU8Cl44VPviHht2M9FSpQxlsJD0HSOJXd4udj3
 gAdDGowyVBn0C0E/++6S7Z27XLxA+wnrH/o9hV1fmsLCfPkECrIWBqoQWwT0rnbSkYtk
 4nhVvCDviEpJ9ClT+iumJfzt0QvBhpDFya9MOLNIiEzzuIGfG6FI5pvhDRxIoL3JqXiN
 sw8hbnzi6j/2htFz9uKhf5q3UqHOiuWsTMBmzAHZuFAhLhbD3pzDMS7iuqOFGwtAjpCC
 WO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786377642; x=1786982442;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZM2M+4vSKk+ehuW26k9cv74na2+OzusaTrgKyysV0gk=;
 b=pCB5Kw+scOQ1J0bRPspzoQ1mvxSw8Ia9YflPkokHmDthgUemsjFtUcFpuV8R8TczqC
 CikY3BjiAjIWg/wSY329RQxHaCo7yHPvV406vpzlGkmlhtqPxzhRy2mf9bgZFJgfcUQO
 xS/PozdcC867WHtrkbhmSRvrSGy6pY/UVYo+7xZiBTqTT4Nf7FGARbjg5khaJZMSayNY
 Imj8grwYBULRb5wJhAk9NHpqwPAjvwf5uQjcJYPelF6+DAddftj3KQVMqQcMRp1Jf546
 /k9EGMtpByubhqKKEqxEAQxz31x9PMipHPMDmQgHLS0AZqMbBMlirh7Wo8cXGzL7VVzY
 lo7g==
X-Gm-Message-State: AOJu0YxAOYjg+AztyTVkDu0j7vuU/Zrs2JTYCMsUsmiWFAFP9B5wZYAZ
 B8Gig33X8VYTwWE/rw7dS/feaUFvGKzeEe87JK3VKJp4Kmuw072anzLPl8rCDYHv5WSRvXhecD9
 VCcdJYayMrTJ2Om31JJowIG8ZLYDCQIGSlUPirOi+3w==
X-Gm-Gg: AR+sD12hugQHEr1ktsZjuHd/c52olnqi/SKQaNeKz6sKTWp0B198TWkSDEPyEVxORzC
 iUu+BTAO1Qz4HZsQwAPjfGtQhfG06Q4XVJvO/bQ/gxn0Qg8CLLqECk7kgOU43LnueKBxwkxQkMb
 O+dSEPCvMv/5CkrUopqWNJIpvNRk9ODCbKvH1+Qx52Wb+AgUeqV5PM+FJHrr1nEjS8ZUZAFuwIO
 ENOeymcOfPqxFDlpbpDydxGLc/jX+aq0f9kwOEocI+wiByJjUUEdaV96jNDfk1HgYAF4+NRTJ1k
 GqLXy6TnPDtU13Ub0tGtnfqd3oFOc4w42UTP/pq2kGwyv23x7dVqrWWMNdnGDG7lVlA1UODzr4f
 GzHcfn0kiEZrxabYaq+LXDRHE2jt0Bg==
X-Received: by 2002:a05:690c:f:b0:80e:5236:b930 with SMTP id
 00721157ae682-82d2eae9b99mr14693577b3.36.1786377642284; Mon, 10 Aug 2026
 09:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <CAFEAcA_h7t7hF=i0xSh1DLq9Dmy-VL+fBa09R5RS6BOTFXLj=g@mail.gmail.com>
 <e4f25ac5-2817-456e-9ea7-f03ff8f625f3@oss.qualcomm.com>
In-Reply-To: <e4f25ac5-2817-456e-9ea7-f03ff8f625f3@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2026 17:00:30 +0100
X-Gm-Features: AUfX_mxwy0f-_r5se_ujCh3ZwnTGc-v99M28TWhhJkiMKWS-5Fo3ag8YzG_jdHQ
Message-ID: <CAFEAcA85VMpWbi1y_P7ScSLBRar4AnjVAzi1KLyk8GKH0jNUYQ@mail.gmail.com>
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Mon, 10 Aug 2026 at 16:55, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 8/10/2026 8:46 AM, Peter Maydell wrote:
> > On Fri, 24 Jul 2026 at 01:09, Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> Now that we can link a single-binary with at least two targets (arm, aarch64),
> >> we want to make sure that we expose the same set of machines (later devices and
> >> cpus) than target binaries. For that, we implemented a static filtering based on
> >> target interfaces that each machine will implement to declare which targets have
> >> this machine.
> >>
> >> However, we discovered that this static filtering is not enough. Indeed, some
> >> machines and devices do not depend only on target, and their presence can depend
> >> on Kconfig or host/target combination. Thus, our static approach can't work, and
> >> we need something more flexible.
> >
> > Do you have some specific examples of where the static filtering isn't
> > sufficient? I can certainly believe that we have some at the moment,
> > but I'm curious about how much of that is "just by accident because
> > ifdefs were the easy thing to do" versus when the filtering makes
> > sense for avoiding showing the user things that won't work.

> As you can see in the series, machines nitro and x-remote are concerned
> (they depend on host/guest combination - summarized by a target config
> entry). There are additional devices I found also (igpd bus, plus nitro
> devices), but I wanted to validate approach on machines first.
> I didn't observe any cpu (yet) that needs this extra flexibility.
> This is only for arm/aarch64 combination, I expect we'll have other
> cases as we add new archs in single-binary.
>
> Also, there is a benefit to register *all* types and filter them
> afterward: we can identify conflicting QOM types with any combination,
> and not only depending on which targets gets enabled.
> Finally, this approach is much less verbose than adding an if (cond) {}
> on every type_register_static location.
>
> Do you have an alternative suggestion that would retain all those
> benefits, but would be better in your option?

No, I'm not particularly strongly opinionated about the approach,
I was just trying to understand the background motivation for it.

thanks
-- PMM

