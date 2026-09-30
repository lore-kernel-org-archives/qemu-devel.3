Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7F1CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBsh8-0001aq-9g; Wed, 30 Sep 2026 07:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBsh6-0001ZH-1p
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:41:52 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBsh3-0005ea-61
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:41:51 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-895eaf31683so51454177b3.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 04:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790768506; cv=none;
 d=google.com; s=arc-20260327;
 b=jgNTNnd8g0A2tbxB+N+VhngKwNBwVySHUl2D6C6zaU4m+moNfWYtsNL22tQ3FTT6qf
 1rPnh9OxaLxHYZEyhx8YwblbJ8yioxiurltkom5ySxCfkxeME5XQcYwoSUuVhYB75w80
 o1cG26Kp7jSiKIsdi3GCSB81geO5vQ0oBxQfU60EdaZYFd339iQrrf7Ww8vyUSv+XRCt
 vUei0skgIgfnlv+i6JDxKew6tJsoDpFDkDaDorIG/7u5tZBFo7HZkCh1p7B2+/pYq/kt
 LkGNzMUPLgC9QfE262UdcW9RF9Putc+UIZ8I/drk1GkGjhT0m+5FiYUyMcrVzKiynFVF
 wMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wiakC44092UwtolGmldq2paoAbPU6s6+vx4SY3K0vos=;
 fh=GD9mEVhX/cisAwkDFRqXvvgy1fxAoo874ZV1tPLN/5E=;
 b=fgaF296RvOduuFD+NkVRoo0AtgpNKnyQe/fTvnlFaDAOTq+QsC6nE1TifiqR7xNEgt
 S/4ztPdH4iGZKpv2L3FSbRx4/GFDJOhIRZI3b/IOqGz7++tK3vqzOPFmbu2mxism2/AG
 8hCJyxTW4eibgQuiCcLXydr5TuU4xXwznf39M9A1MkkXBibEnreEAibp8pRVYrykApDb
 URw5MEEttQuOrFqWrfwc5zwNAnc3k0IaQdbexCa9vQwQJQFn27DVgd+iovYT0QHd4lU5
 nmnW973KkyPIkWSwwA+dMGmZL2DCPF6TCZE2lJq/DXC7d7A3DmKLOKDsSlMKycKePHCe
 6zrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790768506; x=1791373306; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wiakC44092UwtolGmldq2paoAbPU6s6+vx4SY3K0vos=;
 b=HeSh2QthZEKLgV4cpoMbRRfVZ6adyw9kspwoW4QBagCvkPcIfTV1D2KBxWVieMijPk
 oFzUT9T6UAgLC/nUSTRbFwKDj4BDTILlGYYmncKXvjlPwwWOcReOfqlSkrW4CRouy1+B
 a07oZunWwyRtcaXdHBfL0UqiEfcYT5KvvdgYzjoxFL6+hgxtbiKadLkwmTBgZYV1C/yc
 Ir0izLYzQUYcDD51DtCkq1044S1esk3u/fjAaBXt2LZWUe0AxQRuZvZa/IR2L2J8t0e8
 3UYmpC9c0/Y1LTK8ICr3YVWb4w9b7+YSiUMiUshbrzluhlvaJhJYrYRD3iRMwJS9EeJu
 fQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790768506; x=1791373306;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wiakC44092UwtolGmldq2paoAbPU6s6+vx4SY3K0vos=;
 b=xq01RHN9jdgWuoL3yMqPa6lXWssnMBf9kDOadzBdtVqDchQkZzq44vqMAqrKLhuMrX
 KxCNi/rFRkh+jhWJTrYmFT4RYeODOXuLm7zzTTwabcBJsFBmySK/gTJhnO7ESOhJ0VSM
 E8NGDAI1zrCtTdQubzC731UvtAZrFbA6MgB9ZSrgRofuB4dDf6Fr720FFzDvqDmZ4mMc
 IX3A+cM3AjxdQqvG3UFeLBI+DvXdeqeXJ1Fm/Uz0fYvjrWO6rGkVIXL2qFF1f1VW23ao
 NMhbkh+S5ePJ/JrzNSO7xdz9kn16VUyMj0LVFgZzNSuoGX4ji9i7kdNUYzKUmHdY0b8W
 0iUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTSjl5bm3/YVZvNb6b4rxpzqLHeFvCgsWbNnQ8JmOUQvTPGPCPOw7X1BA+M7FV6wpHaWI+BKBnECwA@nongnu.org
X-Gm-Message-State: AFq9FYL+/MqseBrcEC221HXtVzIrw+U4WEpjw4N/atRlj5DpYjnRoWhG
 Bzs4wWezkSK8V4k9jrAHeikUzG86T7LT5H88I4BIFbW3PFMsX2jKYmLBMnEEpSDlzhqWZTosY3a
 6e3ZYDtMtCyqvFq6/Fn9Lg4Z3oyXysjCRBqNWiJWLdQ==
X-Gm-Gg: AYBFou2xc//FGvxwK3gLyKQCJQ7N7VYDeHH3iyE8Qe5qd76U4NbZIYET5HZxkO4+9pF
 SEmOApUV8BmC3qb2hxK9FcwQUUWWfFhuIzMHFBnRQB5mQDK+jWHX9J5At6lg/Vtab3YPVxgI5KL
 0xxjFN6QrO4W3/T/pIBBk4l2RP6kNedFyXMInf9WtqQRJloLWpXaXzjDTdL0Yoh9QGqEN6RATDa
 Jb8JQSE9/GMU+yUjhXK8ASqTh3VcGpod4dxSnmvglfxFmjUuz7W3S6s+0PvzIDjqQN2y/nG9sPP
 W0MuF1yqLk9zo47rUE4YqOo5eWz5TYO/lKcIpr9H4EJIDp7GnMpxr7S5kG5/gLfcRnLopLi1xhn
 hc83bXwVkFGx+zL+0EQjkdxIZPkrTEK9/OQxrRq0=
X-Received: by 2002:a05:690c:dc7:b0:873:17c9:b054 with SMTP id
 00721157ae682-8ac9341f375mr2294117b3.21.1790768506180; Wed, 30 Sep 2026
 04:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260921074451.3158645-1-fuad.tabba@linux.dev>
 <20260921074451.3158645-3-fuad.tabba@linux.dev>
 <5eb74929-f605-4acf-875b-e561385182f0@tls.msk.ru>
In-Reply-To: <5eb74929-f605-4acf-875b-e561385182f0@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Sep 2026 12:41:34 +0100
X-Gm-Features: AclHuK8hwDgyXHr-z2aiWpkLgQD4iZFZy5EtVm9BkdmUmjHVZaIl5VVJcmeq6C0
Message-ID: <CAFEAcA88ZjsNmCPp6N-DX=wcVPhOgRiq9HS_9VHWziYBzkoJMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Fix WFxT timeouts when the offset puts
 the count ahead
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Will Deacon <will@kernel.org>,
 Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0f.google.com
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

On Wed, 30 Sept 2026 at 09:56, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> [This has been applied to the master branch as 998b6db69e3ec58fd52ddc7a06ece6cf286f3c77]
>
> On 9/21/26 10:44, Fuad Tabba wrote:
> > The WFIT and WFET helpers arm the wakeup timer at count == timeout +
> > offset, treating an overflow of that sum as "beyond the counter's
> > wrap" and arming at INT64_MAX. As in gt_recalc_timer(), that reading
> > is valid only when offset <= count: with a CNTVOFF_EL2 that puts the
> > virtual count ahead of the physical count, the sum overflows for
> > every timeout still in the future and the wrapped value was the
> > correct wakeup. The CPU then waits until an interrupt or event
> > instead of waking at its timeout. A Linux guest uses WFIT and WFET in
> > __delay() when FEAT_WFxT is present, which -cpu max advertises.
> >
> > Arm cntval + (timeout - cntvct) instead, so only a physical count past
> > 2^64 is "never", and add a tcg system test that issues WFIT and WFET
> > with such an offset, with a timer interrupt 1s out so a broken WFxT
> > still returns: before this change both wake at the interrupt, after
> > it at their timeout.
> >
> > Fixes: a96edb687e76 ("target/arm: Implement FEAT WFxT and enable for '-cpu max'")
> > Fixes: da9b86c35fa8 ("target/arm: implement WFET")
>
> Hi.
>
> For stable-10.0.x LTS series, which does not support WFET (commit
> da9b86c35fa8), I'm picking up just the first half of this patch,
> and half of the test.
>
> An alternative is to pick da9b86c35fa8 ("target/arm: implement WFET")
> for 10.0.x, which does not actually look bad.  It will probably require
> v11.0.0-332-g4575da5ecb7 "target/arm: report register in WFIT syndromes"
> too.

The WFET implementation relies on the preceding set of patches
which implement the event stream, SEV and SEVL (and on some
later patches that fix a bug or two). I think the feature as
a whole is a bit large to try to backport, especially since the
failure mode for "we forgot one of the bits it depends on" is
"the guest silently hangs because it doesn't get woken up from
the WFE when it should".

thanks
-- PMM

