Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA187CFB44D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqx9-0005qF-NB; Mon, 07 Oct 2024 12:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxqx7-0005q6-Q0
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:51:21 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxqx6-0001zq-90
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:51:21 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fad15b3eeeso49827481fa.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728319878; x=1728924678; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jJop2LftYzGa7pWT9XrZIsEoHB2sYtyiw8Lf8ymIv3Y=;
 b=AgEJRRNjQtkneTYKTChA02wiUkNSUOgd+PnJI4sCQoFibJ8KzDjYmchLHTfdNdH9Fu
 kGyislM6p7iWRxcQTqtc3dA/K7vEsNpYxz22xKaeoZCF5zzyr0UcFm1n6sHPKznRknV1
 MrYa8K95fL/Cg3hn2IAqf7JxboG0zoGmULpi6rJaW0LQhH0ZAUpLWhnreBPp1e7c2bw2
 Xt5jKZLcgcCouUmLGzuszLMUTvW2/8NFazUV7CGUVDDIJTS3DlB1P47mgq8WskGLdsDd
 +1wHfbjhf/+gfi+Q+h/BAcxO/mRdAKnYNVQ7sYX2jBK1msGCexE87azh+G6AXCjDxpjo
 WZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728319878; x=1728924678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJop2LftYzGa7pWT9XrZIsEoHB2sYtyiw8Lf8ymIv3Y=;
 b=RjShf8jTlRioyRNSx4zv9WB/9v/OHt21n+e/ev/WuOL2XWyPzM4YxbvrG9BFtrVTt2
 29XZ9aklmKTaAvMKvdpOl+k98OBbpFo7Z4+bgAgIbcSiYkqw0/05rPtodA3ZDZSV9qTg
 SFxpB11bNon9LOFiULi5/pts88wxQHymhl9R+aO3hJ8SHXLHK2NZu/8W+W2zwirTgWMw
 hZenUNcENzetO3E9t7qEjh7dHr9tr/GxQ7mk3vDfn1JNu42Nl7DDhhu+x7DysfL7IweM
 mc/qlaz2oLgTHkPczpQzeBBu+FWdtJ53Ndl/buUoUS5Gt5TiQdH8eWA7CtJJAqvTFxW5
 N1Dw==
X-Gm-Message-State: AOJu0YzVxIP5LdpFnKwuTVtaBhVWQ/wKCnAX4e6wXy2AacTX8k9ZETxM
 WDWEZjEF7uSSMEBVv/lFuCQrH54qZlUWAz1/sUmgO1P3nXgpW/sx+9dpb1wtsZbgiKA5lJuS2jc
 2Cb76isrXTpj793oeX5atw4jRsLZYW4Xu/GXVG2RPgufPLlr4
X-Google-Smtp-Source: AGHT+IFJ3ImhvnP3TWXOnKlqhCfhcYkf0/JUBODy/U8OeU7SN4sFcsF1pkzZfaKLp0vCoiS7jPJ7F+h6zxhtWroa0D0=
X-Received: by 2002:a2e:b889:0:b0:2ef:20ae:d113 with SMTP id
 38308e7fff4ca-2faf3d8a95emr55144021fa.40.1728319877691; Mon, 07 Oct 2024
 09:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241007115027.243425-1-thuth@redhat.com>
 <CAFEAcA8C1K5jXvSAf_DpSFDDzj-hDSuduCsuyLa5N2M1Vu0_kQ@mail.gmail.com>
 <CAFEAcA-aCr8FAFQPJN4a96DPCQ5+7jrZZGvsX=EJdeSy3irH1Q@mail.gmail.com>
 <bfbc94db-f0eb-42dd-b52e-4d1a2a1a9cdc@redhat.com>
In-Reply-To: <bfbc94db-f0eb-42dd-b52e-4d1a2a1a9cdc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2024 17:51:05 +0100
Message-ID: <CAFEAcA-77YmFkY+ffyq=_XTkUsUt2AKMSyv_5UQKgr+-r4HHJg@mail.gmail.com>
Subject: Re: [PULL 00/12] CI fixes and various clean-ups
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Mon, 7 Oct 2024 at 17:41, Thomas Huth <thuth@redhat.com> wrote:
>
> On 07/10/2024 16.13, Peter Maydell wrote:
> >> Some of the other qmp-cmd-test
> >> runs in that job also came close to timing out:
> >>
> >> 102/109 qemu:qtest+qtest-m68k / qtest-m68k/qmp-cmd-test OK 56.56s 65
> >> subtests passed
> >> 105/109 qemu:qtest+qtest-mips64 / qtest-mips64/qmp-cmd-test OK 53.74s
> >> 65 subtests passed
> >> 106/109 qemu:qtest+qtest-s390x / qtest-s390x/qmp-cmd-test OK 45.48s 65
> >> subtests passed
> >>
> >> so maybe we should add it to slow_tests with a 120s
> >> timeout...
>
> Ok, m68k and s390x have been touched by this PR ... but still, it's one
> qtest (qmp-cmd-test) that is failing for multiple targets, so it rather
> sounds like we've got a regression in one of the previous PRs?

I think it's more likely that the k8s runners are just
horrifically inconsistent about speed: they have been
the flaky CI jobs in one way or another at least since
I started doing pullreq handling for this release cycle.

If they reliably ran these jobs in 20s then there would be
no issue, we would have tons of headroom between that and
the 60s timeout. (My local dev box runs them in 13s, and
it's not super high-powered.) If they reliably took 60s
then we'd have fixed up the timeouts already (but that
would imply a very slow CPU).

Our other option would be to use that meson "multiply
all the timeouts by X" feature for the k8s jobs. Of
course if it does go that slowly for the whole job
then we run into the whole-job timeout...

Paolo: do you have any idea why our k8s runner jobs
have such inconsistent performance ?

-- PMM

