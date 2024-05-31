Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BE4C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 10:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCz8z-0004z7-3o; Fri, 31 May 2024 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCz8x-0004yd-8A
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:05:51 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCz8l-0006p2-RD
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:05:50 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a342201ebso561119a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 03:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717149938; x=1717754738; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+K3VQv/btmuTNykkTAoXDdRM7tTxEsXb40k8P3Ewzg=;
 b=ujiINYyLQnkS5tSxQfNn9O605xuZQsdx59B8fFtCBDKVrV6vBmiuoNgwaIVuqp9OOn
 zfo4AV+4tExCCwem0VtxgfUDR4/AjwxP/PpqHZDD+220o87yPv/KGmYMSrkamwIjHhYy
 amNp4y7rsSQJwohEfHqoPxDkNciUmuU5Sb9JzqiuwjSxFZJflACal7GxZzoOiUAIOTz2
 vhyswyIq0Mny+JDtAnwgeCBYaOMDhB2HhqK0NQoZr23cnw4VcPTwVH9q1get5jjKLwI9
 TeL0Yt73/eHSSf4qqUdY1x9vzmv7CZjwB1DiCUjHPvvABKMVQOhyuNuYlW1WrmZrfg63
 GVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149938; x=1717754738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+K3VQv/btmuTNykkTAoXDdRM7tTxEsXb40k8P3Ewzg=;
 b=QaQcIlHIWt3CS8JAo7plv5p5DJ4zUzOMwYSdz7VOFb4AWX5/et1fG3UhdOjd/H0Hcv
 qgYKwVgJ2bRsYvgxQ755wzop7zbpOQqWFbNRqlgQ24ctSbZsQyrdKNVwgOxlOecguKsA
 LpBy0FwKvX9mpDd4AydV1IwepVqHltFkp24QO48iYE4QumAAKBzPWbyxIOx2t5A7N8sC
 eennb67yJlGPLQJh4Nm5QnCF1zlO3u1if0ZTsCGqUq7d57m5f94jrAem0JwcnDb9dA6P
 oLXtmB3yKsdXNCAjUcc42VFVdzg9mKofhVs8qJvSAY47Ag+P2EonyrMIWLVlg/dpcX3C
 N/eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxBdSnNwijHMHtqc4ODqU3Ffd1VBh0psW10zzVY40iT/m2XV7ZLveTPjDrbSXQCVZ87kyiHFTXuQoH7mRVb1MLH/ynlZ0=
X-Gm-Message-State: AOJu0Yy9DJPfTA8YKzCPqNPIMUl6et1QjACmz2wlo0ITv3qXn76dPAdH
 8k7EawrTG3V6VE9PSO35AXyFlEphDw2+EU0ydERtAP+7SQjfBYOHg/Crgl0gmTyb8jLfhn1Fme4
 DXiI/UOLgm6EzvgxsCYqkh38//9jjZgBm6YHd1A==
X-Google-Smtp-Source: AGHT+IGtkQlhDfqFMHTtgNNfuTnqCA/vDfFkUD8YHvN7DGeHEY3v8AEUUeyHBQtB0Il8qG+LLOG0RRWh6xBQBSwgWBw=
X-Received: by 2002:a50:931d:0:b0:579:fb79:309 with SMTP id
 4fb4d7f45d1cf-57a363da21cmr930219a12.10.1717149937908; Fri, 31 May 2024
 03:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240530112332.1439238-1-alex.bennee@linaro.org>
 <20240530112332.1439238-2-alex.bennee@linaro.org>
 <e6bfd903-566e-4e1d-aeaf-efc798b36a92@quicinc.com>
 <875xuucqee.fsf@draig.linaro.org>
In-Reply-To: <875xuucqee.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 11:05:27 +0100
Message-ID: <CAFEAcA8Mc+K=+ebMhRCmcAKDCsVq3hvmTWFOFWmpDOSYzzwhDg@mail.gmail.com>
Subject: Re: [Semihosting Tests PATCH v2 1/3] .editorconfig: add code
 conventions for tooling
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Brian Cain <quic_bcain@quicinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 31 May 2024 at 09:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Brian Cain <quic_bcain@quicinc.com> writes:
> > Related: would a .clang-format file also be useful? git-clang-format
> > can be used to apply formatting changes only on the code that's been
> > changed.
>
> As a pre-commit hook? Or via something like clangd?

I think last time somebody looked at clangd it wasn't quite
flexible enough to format code to QEMU's style preferences.
But that was some years ago, so I might be misremembering or
the situation might have changed.

In terms of project consensus, I think "here's tooling/config
you can use to follow our formatting preferences if you like"
is probably a better place to start than anything that is
an automatically-applied-by-default check.

(For the semihosting-tests I wouldn't bother, because they
get almost no contributions: 8 commits in the last 5 years.)

thanks
-- PMM

