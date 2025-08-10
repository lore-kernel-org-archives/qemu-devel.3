Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14982C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 13:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul6A4-00031x-Aq; Sun, 10 Aug 2025 09:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ul69m-0002yX-SU
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 09:32:16 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ul69j-0005KW-Uh
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 09:32:13 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71bce78e14fso36812717b3.1
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754832728; x=1755437528; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4a+1rRJDKqWQsRx2A+SIAn0OH7mlg7e4jUDSAR3Hw+k=;
 b=XAiRz0GAsFjq8eica40TkfNawzh+2tW/pns0DBPdeZBLtIuOqcAPhPsCUG4HfPUT/R
 qG+C1g3nowGwHjFQGu4nsWhTtfyOIq0+vcPo0SncEZ3S7WRcXJqdECiukP2agwrSnB+p
 gmaKBUH0AP292Zcx+IRQFLJ5Y0M7KwvFtvwUoy83B7viOCpsXexUv1ZG0MofN+hN9j4v
 XwKTIEfX9xZErhLVbcQPe1CJ2+txBK47dWXCdb7pR6GAMT95RgEHeLNv95LJFBco9JCx
 vBZiiwSmz4Um8RNX7p4b/0rGMxsJ17PosD8Pzf87wm3/NFcbztqXjyWHgY38rv1iZOh/
 ZOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754832728; x=1755437528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4a+1rRJDKqWQsRx2A+SIAn0OH7mlg7e4jUDSAR3Hw+k=;
 b=WN5DhcTJ0igUFExWlsdXL6vySsSO6n1TL3uJSrJt6mgBLVUfKun3NB8x87E8hbMpoq
 aHxY33UTPXwAOP7RYcM8QXf7fT0cF6S9AlBuzrc3cMO5cT77SchpEVBB4W4vTQCqqoJf
 sflH/xJXl4ljKejwVoNB58NyWKDueVRAaZuzLtLmizsDz9zhAkeLAbhe1J9kndsHGivD
 pNGwk8yEGb6RkEngIfO5W/nKdjE9BldLuBQy6QKBZKBhsS9atJ2vOWWH+qPvGs5pvggF
 XelTYCxgWLho9IAmWeov5uFgaWf/WsTfN2XfvTV5DfeviSMlGvYcuBl7ufCebGtpM1TY
 xKgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJmVMWuzov2eg3ZtHYJNknBrbt0YUmk4+KTS3TA2boOk4C2io09HLJakuTtMEtcXUDPg0qr2ppWk7C@nongnu.org
X-Gm-Message-State: AOJu0Yz3aWAqf9mhudu8mUh0wXp4HIzGe2eL+iFA7aS6BKDmmC8dgkw7
 YLwMErVcYybemCv/wk0pWBVuFkHwXcDJi4Qg6ce8ZdJ5TpAUb5XQ+CcLm4AYrzJiYKpjHmGKueu
 K3Zwjk0IVRAxiAX7eE2sdN9nvxDdWxMrRwjkfIuCqDw==
X-Gm-Gg: ASbGncutrYzDsNah1AZcQb6HG0PTExeQ93oza4ij8kpsKz6T29UO6GRkC/YAvUvUrU+
 9eSH3JGp9pjklSaa7J3jejSKMDC4ArVgqdlOLU8e+XwGyQTaLM85s29+Tr/nUnvB8sUtuFxFfxm
 nlfSTmKlX61cB+UvXtqAMjIkNIicuucsbMxlS2AJExeXt5nLkCQCP290Jy5TQdsQOS6Waa7dQx/
 IzVwAgC
X-Google-Smtp-Source: AGHT+IEx48t+wkyr4+LjxZfbUnm88FeFcnOAvFmsR1/1vXSfQsWvW+ehtfUpT/tjPsMDQONHVmRZvn/PIpwnoHyLDFA=
X-Received: by 2002:a05:690c:6202:b0:71b:69ed:50ba with SMTP id
 00721157ae682-71bf0e34ademr115573397b3.23.1754832727807; Sun, 10 Aug 2025
 06:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250722131925.2119169-1-smail.aider@huawei.com>
 <b06c4273-650b-4ba3-bf35-9af16bfc70e7@tls.msk.ru>
In-Reply-To: <b06c4273-650b-4ba3-bf35-9af16bfc70e7@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Aug 2025 14:31:56 +0100
X-Gm-Features: Ac12FXzLkhVWjMVKKkhJaN0zTN4oPQ-dKieb8tSk8HP8x82ek4RQBd2pTs7-Wq8
Message-ID: <CAFEAcA8oSaNp3bKeOF-xcfNnWhm-vYnbwr9_yrpHDQcDwOmwDQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Smail AIDER <smail.aider@huawei.com>, qemu-devel@nongnu.org, 
 alexander.spyridakis@huawei.com, zhangyue165@huawei.com, qemu-arm@nongnu.org, 
 liuyutao2@huawei.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Sun, 10 Aug 2025 at 08:57, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 22.07.2025 16:19, Smail AIDER via wrote:
> > Trap PMCR_EL0 or PMCR accesses to EL2 when MDCR_EL2.TPMCR is set.
> > Similar to MDCR_EL2.TPM, MDCR_EL2.TPMCR allows trapping EL0 and EL1
> > accesses to the PMCR register to EL2.
>
> Ping?
>
> Has this patch been forgotten?

This is v1, it got code review comments, and there is a v2 on list.

The v2 on my list but it's passed the "worth putting into 10.1"
point already and hasn't yet been reviewed. I was assuming RTH would
review as he looked at v1.

-- PMM

