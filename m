Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EBFF8D758
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOLr-000164-2W; Thu, 16 Apr 2026 11:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDOLo-00015G-47
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:09:52 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDOLl-0001F4-Kt
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:09:51 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-649278a69c5so6777955d50.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 08:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776352188; cv=none;
 d=google.com; s=arc-20240605;
 b=Uq60F+P3oV2AvEc/o+QmtXxJkVz4+95I0l8wJ65NzHzb3Z4DtrGYHfC4JcPQ+Lx7GO
 qebZvcXD1MVXCEO8oFcmqtjFo0fsd6YwY4q1q2PmQTn023Tyk7EOKb3IrZ++kmSoZBkN
 hA6QU82424fvDjYyyGH9fBa/zp19NtIkkXaOYRVJWm8rJpOt45IJv70jD1/VsSl6mQRN
 +H0ROOw4RJ84nPHODX7Is60y/e9iWYdzKV3csbDFf9xTXZmWR/8XrEK1wj7tjcoOlWPP
 /ZtmlIsG2GbNAPmf6T+VewaRI5hwy9sRN3NFTjj+lvjXYOt/Ul/zRevC4udk9Io6w1ca
 Sp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bLA/rAadm/yc1USjm6l1SxXZl5g88QyOODPYo62B8tg=;
 fh=Au+jGT3xffWA1pWHWE+FnwvF8oqIhjEYOwMidNenEGs=;
 b=NaKZdDpPL8aZlIiM6uBAaq62Q9MCoygNf3AYAOm8qpRIdY4O5S5zjkGckxkPMta+qV
 2/YcrGwhBmw2XMt/ND9XSHkrZkmUuueUXx90KBynXlvHmI778kO2rCeocuGq10ZLIH4b
 lalYliZWdkVU3B0wqIXFMKWKei3rmUzCgl963ACt65MKSENp2xaUdJbK7cay75bYLjDP
 geyDS7mOU0jykLOcSRyd8j9JupgMA+zNkjVFfnVObnBHtiuitiqNcPm3Bx7XKNsxrWWX
 1ewP+iCXD4ZdPdJTIi8x6JSPy11tIWpZ17S7UZ9PH7rIFlpR5GzpUPFoD9e3bqCnhINC
 SSpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776352188; x=1776956988; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bLA/rAadm/yc1USjm6l1SxXZl5g88QyOODPYo62B8tg=;
 b=cLsgUzMiOeLm722yF75MhAYkqO+D+aHYqLOaEJZ8c3LC1DJJzuLt+xoGs/HoIeLkp3
 0BKTp9KOE5fBGPCRJ8hqWHweDcer3NBGf5TD2uFVTNKB/5HxbiXgqJEDQ+CS+oZxC7xX
 INFFY1qxICodiuxW4yF7b/M7YpcqxRNZkTXRxnd4cdg9G8RNKaS7RI+u9Vyh32nX3yA8
 GbYcio3+Zkac0mu/oS0EBZCWK1y+LFeRWEpuMbsxMv1IqBBlX3Bp7+AIbrF3Wjiqiu7z
 pVe+Sano/K2i1/zdSgMAp2LiDxFEhnM3QZETsQB7S6GBzZifpfH/diin5W5B+eS9IyLZ
 CQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352188; x=1776956988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLA/rAadm/yc1USjm6l1SxXZl5g88QyOODPYo62B8tg=;
 b=WVMVMIbSNy4aV0ybyAF7kVt9l58NNyw3lKIyIjG6vG/LoZttW4Notq+HgkX+3/kZ8Z
 mimWEkH+a7mW5+T/mpqWEJt3DmpRzGwFnsyheiXFHGbpxfSwFnwDeFk9bYk2Cc5Fdm4a
 f79RYSsGjWVY6AjtcVNHvGoLJU6YfsoB+sg7O9+6I94j7X+pYZxwyCw82MLy4Ud5D1q5
 8Twr5nSQOSSX3JBkEZWnhk9IQtX1LWU90kARQ4MKYEqfIjOy3h79Pfal+dSaigZI8Zkl
 SwBmJZmfX+zYN6wnjwVz82onX09Qq6+OIPhV9CMmHe+QprYlYDTQ0RAbTzJa/m9aAOKJ
 ADaw==
X-Gm-Message-State: AOJu0Yz3ZFCsQx3dZntystzp2i9/hXvWpmEHSd0ITSW+opz1Py1S4+6g
 0/i2HofvvtqPVq3tI7K5OJqkLMDrcXdM6i5cbx1n+GOceVVpWqwDrVBz5sqn7YIlLL4IwfZ+WiV
 /F3RHWrr+L6JxBG8w1Tr9cTYDDJSIbRnZcqSIdyOpOw==
X-Gm-Gg: AeBDieuvgohQ41GI+D2UkCiRWBWeSvUikAFghLG5QS/tbMw3tmfEt1DEmSWfEcdBSOR
 fm0XKV/e/TJiq3YsdafbvkWWc70xuoVtyOj0lLfqLyg/tbm0VpV886u6aMHxjfoJM7jsyaTKAqW
 qj53NmGkXMop4/uiAS7m8LZkigfLFewV5CS5MnepiEUQCGR2W5TJJ0j6b5xtAeC887v8Ni/2F1H
 zGoBmZN79DNqgk+O0nyvx/uH01ibTyuYLAtBQNeJI1V1kH1U2B2eqptwm5CPlMGnKle3yhWL4Gp
 AI6APJgWFAKy91i01eAuQToGb1NP3s1Gx+Rd/ceLBtvRHCNhUemcKwb4FnpD/xhz9bXtAwrLQ92
 h1A==
X-Received: by 2002:a05:690e:484f:b0:650:16fb:e7f3 with SMTP id
 956f58d0204a3-65198c7ca80mr15834486d50.59.1776352187896; Thu, 16 Apr 2026
 08:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-18-peter.maydell@linaro.org> <aeD7NZS8slZ-ki4a@antec>
In-Reply-To: <aeD7NZS8slZ-ki4a@antec>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2026 16:09:36 +0100
X-Gm-Features: AQROBzD4qqLQSNsL94KSpA9JHZeL84kSD0wrECHRW_KtUhFfFgcqmBAdCehEplc
Message-ID: <CAFEAcA94djCNnf7nxJWwE8uiOGb8vVZEiGQc7JpJQGRpk=K2qw@mail.gmail.com>
Subject: Re: [PATCH 17/28] MAINTAINERS: Remove Jia Liu
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 16 Apr 2026 at 16:07, Stafford Horne <shorne@gmail.com> wrote:
>
> On Thu, Apr 16, 2026 at 10:16:43AM +0100, Peter Maydell wrote:
> > Jia Liu has not posted to qemu-devel in some years and did not
> > respond to a query about whether they still wished to be listed in
> > our MAINTAINERS file.  Remove them, on the assumption that they are
> > no longer active in QEMU.
> >
> > This makes the or1k-sim OpenRISC machine orphan.
>
> This looks ok to me, the time I have worked on the the project I have never
> heard from Jia.
>
> I think I would like to mark myself as maintainer on this and the other OpenRISC
> machines.  Should I sent a patch on top of your series after it is merged?

Yes, I think that's probably the easiest way to manage it.
I'll try to merge this series early in the 11.1 cycle.

-- PMM

