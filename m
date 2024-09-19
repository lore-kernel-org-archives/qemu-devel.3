Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7CDCE8D78
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 11:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srFQB-0006tI-NX; Thu, 19 Sep 2024 07:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srFQA-0006sm-AR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 07:34:02 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srFQ8-0005EM-Kn
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 07:34:02 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53661ac5ba1so743518e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726745637; x=1727350437; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TX+YKdgsNY4eHwiANJL05KwePN0Q1NSwu/+CMRm+C3o=;
 b=WvXf62zbfdDjH/LIT7kOtffYLeEcaKSS+rEX5h2yv+zbe5C41IxOR+UjqXmIW+FCqO
 V9mMKWQ0PwyBgPe2/gxJ0rryen5SN+LOuXt68pCcyZkhdr1N52zUqPY/eYNyXJyN3nri
 8e9EWj2rQsteBY8QiuCmkHBhuhGCpU+/Vnl99jwtQn6iJkkxzmamq49kk9wSfOGF08Kz
 57MlFc4v3TMWblSw1uydUcskzzXmevLPebjMuL9PvCsafMoGqCzwNjwdqxnrCH3T1+kQ
 ygQmGY41FzluDo5Bu0OWXzu8WDPVPtZr9Ck3qK9dKEYK62MhO3G+2CnA6fanBMMw4meq
 YLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726745637; x=1727350437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TX+YKdgsNY4eHwiANJL05KwePN0Q1NSwu/+CMRm+C3o=;
 b=EPllj3S8I2FjcT6vmMCbKQGAGi0nDlubJkBktflLahhD/IWkXwxfCwtEM5hWNhWzZE
 LSbSlV9exQbJ9XchHp914jE0t8X6jdWuMIfSJdw8lV+SPuM5O0IT7koxBlx2i+gvJj8n
 hp57ebPl6J9nhzFLLt/JNSWPBGEhoszlffbciEpLP/b9lrOleLsZPaH19z3I92fnBEeA
 Qq1mC/wrZS0GYjzxaJeg/ASsEhxrYqSWQoaXlyQijFl7pgeAxn3oGBuPHqOSqwvOmbIM
 rDVuqHzE6xGE8ze3c1oug8c06uivhzgIk5eSpSbldJl1/JED64vhXgGyEBDvD+SScV3k
 5eHQ==
X-Gm-Message-State: AOJu0Yz5kOKYcdsfLY8pTUCT+uffd+IPSfZVN1+vcd4svpSZQ1I6/8cs
 puYuI/y/t+9cm9Am3BVYwurRvKwRCiOk0nj8+aV5dy+J3hGsDcK7qEYJjFrGnfdNfHDuIo/NhgB
 5yLmLgBjCTJzmYOhVfLtpOstPBh8kQOoFXbm23Q==
X-Google-Smtp-Source: AGHT+IE9qHFVb5ssOqMGRsPMjvWZMH1qMM4u+wfVXdFHvfbGKTKSO8NSgidp+AeIqvG7wZXkrsZhsnUhuRHitqJ5KXU=
X-Received: by 2002:a05:6512:4381:b0:536:9efb:bb1a with SMTP id
 2adb3069b0e04-5369efbbbd5mr3902560e87.38.1726745637272; Thu, 19 Sep 2024
 04:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240917141641.2836265-1-peter.maydell@linaro.org>
 <c8902f79-0094-4821-99ab-ec0eba5e870d@linaro.org>
In-Reply-To: <c8902f79-0094-4821-99ab-ec0eba5e870d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 12:33:45 +0100
Message-ID: <CAFEAcA_2+qRM85UKxp0vgASnhzjR7CtVPJyCwdYhONifZ2_QEw@mail.gmail.com>
Subject: Re: [PATCH] tests/fp: Make mul and div tests have a longer timeout
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Wed, 18 Sept 2024 at 15:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/17/24 16:16, Peter Maydell wrote:
> > At the moment we run all fp-test tests except for the muladd ones
> > with the default meson test timeout of 30s. This is plenty for
> > most of the test cases, but for multiplication and division we
> > can sometimes hit the timeout if the CI runner is going slow.
> >
> > Add support to meson.build for a way to override the timeout on
> > a per test basis, and use it to set the timeout to 60s for
> > fp-test-rem, fp-test-div and fp-test-mul. We can use this new
> > generic mechanism also to set the timeout for mulAdd rather
> > than hardcoding it.
> >
> > Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> > ---
> > On my local system these tests finish in less than 5 seconds
> > each, but on the cross-i686-system CI job they can take 5 or 6
> > times as long. Example:
> > https://gitlab.com/qemu-project/qemu/-/jobs/7844908223
> > ---
> >   tests/fp/meson.build | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; I've applied this directly to see if it helps with
some of the CI flakiness.

-- PMM

