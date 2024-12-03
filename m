Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87A5E64AB4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 14:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITwO-0007Lb-CJ; Tue, 03 Dec 2024 09:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tITwI-0007Kt-Fr
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:31:46 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tITwG-0008KW-Q0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:31:46 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d0c8ba475bso4285300a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733236303; x=1733841103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RULPXet0f0k+m6u+itxid+ZNXVMuaDQI1KW72E46lvI=;
 b=ppmC4pltxQxo7HMP8qmG/ESw3PW+lhfV9SX/JjoyL976jQT0Nsyla6RL9aKA45DJsM
 S8hrW7KKX4TaPA4Q5v4CmQw3U55VNhrhpeV/e8zz3AkyukWDxbHhtMtDw3LLJq6IAVo5
 O4V64NwMiRrjDz9xqNsX3eFOfQWiUIJAtHYSmxWwIFWkhGmcopFYgEdaI9Z+/fVbiKm8
 dSnlZRYPAmZmXMEyy0xKQ22CXB9mdi+FqbyFb1zLFn0f1Am/MiPSUCYNOiuO+k9dwwca
 6U5GfAWjxoh+3yX9wdPK9jXmuW33HCJzi6cI3tVV54mM3sukTcpsoLd/jLLHsWxOSPiQ
 knlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733236303; x=1733841103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RULPXet0f0k+m6u+itxid+ZNXVMuaDQI1KW72E46lvI=;
 b=jZAdwPlXwTSHIAT7ECCeH+qvWnR2F+2OvmyIbouAvyBzNhsFck+Du62So09mQYuzad
 lQGmscV/OcuY65wgmb7+mNnZXhSPZXwHXss/HRov92rtkzJGf1n3Uv/Y7wfcPUWDTBxO
 AW5ElD7hoSK3ZcOJ4zeOyoO12PXuiQP2AT6QgwFqLl7yQ1/Y7OPTB50k4ZEoupKm0e6r
 8vfc5OrKWGS+8RWa0zFGNMo49JTe9SBTZajPCsSAc2VK8OtQsEN/Vboqso1tEazHxkbN
 dQos59uZbCOiKyQP+7/UKiNc+XBzNVXxaU58Gpakcj80ZgX7pB7HVrU9MF4ligFKnqp0
 H1SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpulwAgM9Kyh02LZmSQ0WqwXV+8eXz4TbEzWdMrEEeR6Ch0LTC6Mf4cMXjMWr5M1dijya1oDFfokol@nongnu.org
X-Gm-Message-State: AOJu0YyD6h6ilosKuJyTrSpQGWikH+kyYJyZyqeUWYLlhHT1GRgA7odq
 rd60EyqHYp2je+fXk/ZvmBep1aiI8psJDOUSEOT63eii8FrTwMBaTzLGYwdLQSusrNNGLz5P8Jt
 Aj0CzPShSoDdQ83QYjCx6YSKs4gl4zHMTK3THRg==
X-Gm-Gg: ASbGncvTRQ19/wf0yOB+ZHzjeNV6LfspALxRLxl6bYT21mutzL3yRZdMeRcRe9Px1Nd
 8JF9lUMK4ngs5vL+ajBiNGcvdsXf78W2m
X-Google-Smtp-Source: AGHT+IF26OykpQ9IuB7A37dQbvje5mCSSXvxhkVs9xySx0ZN8hKJctSWk8N3Ftu43kPct8S7qL//JYWpGeTWqzM0CFU=
X-Received: by 2002:a05:6402:354c:b0:5d0:cfad:f6c with SMTP id
 4fb4d7f45d1cf-5d10cb81008mr2212069a12.21.1733236302967; Tue, 03 Dec 2024
 06:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20241123164641.364748-1-bcain@quicinc.com>
 <20241123164641.364748-2-bcain@quicinc.com>
 <014e9959-4995-4bf2-9a2c-ace318673804@linaro.org>
 <c559ec82-2ed2-4d38-93b4-9b5076181c9b@oss.qualcomm.com>
In-Reply-To: <c559ec82-2ed2-4d38-93b4-9b5076181c9b@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 14:31:31 +0000
Message-ID: <CAFEAcA_C5HXvMzVXQvQEpcFS67AZCa0dJL0Ek4X4tXtQfA6z+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: update email addr for Brian Cain
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, 
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, 
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, alex.bennee@linaro.org, 
 quic_mburton@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 3 Dec 2024 at 14:23, Brian Cain <brian.cain@oss.qualcomm.com> wrote=
:
>
>
> On 12/2/2024 2:43 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 23/11/24 17:46, Brian Cain wrote:
> >> From: Brian Cain <brian.cain@oss.qualcomm.com>
> >>
> >> Also: add mapping for "quic_bcain@quicinc.com" which was ~briefly
> >> used for some replies to mailing list traffic.
> >>
> >> Signed-off-by: Brian Cain <bcain@quicinc.com>
> >> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >> ---
> >>   .mailmap    | 2 ++
> >>   MAINTAINERS | 2 +-
> >>   2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> Forgive my ignorance here -- this T-b is - stronger than a R-b? or
> weaker than a R-b?  Or wholly orthogonal to R-b?

They mean different things -- T-b says "I tested this patch
and it works for me", and R-b says "I looked at the code
change and think it's a good change with no bugs".

T-b is a slightly odd thing to have on a MAINTAINERS
change, though I'm guessing Philippe might mean they tested
that the .mailmap change affected the commits the way it
was supposed to.

> Should I still seek a R-b before making a pull request with this change?

Philippe put this into his pullreq he just sent out, so you
don't need to do anything more on your end.

thanks
-- PMM

