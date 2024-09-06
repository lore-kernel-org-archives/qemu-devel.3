Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27445CE7B1B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZxX-00040f-C6; Fri, 06 Sep 2024 10:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smZxV-0003zd-6W
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:29:09 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smZxT-0006UX-FM
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:29:08 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so2728810a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725632945; x=1726237745; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PEJ2L0JPpxtq4batFHOWALGWo5a9P7CquvYsjYDJPSM=;
 b=f5ocuPaVJg9qg+dFQ1/kc+HcRsEe2yLAcW1INC+p4CI6B12OzOf+pzfHto4b6mC0lf
 hllIC15Z2aXv4nuxzK/PCb7VukUyP/ubC6GhP6pdlDuxOlZxIwtmDlXW455WzlbRTNKg
 UEqGQ7/6eJK+eTH3zKr3UxDS4rJ7ry3lXBn/9hBoDOK9+aKsUlmQfgQnGNEwteHMNcyV
 6YvMxxvxcX6Ocsa8CEm4KBQ+WGl78GKKdhw0194/a/I0NHUBnuyPu0hU45PVU/H1ku5o
 3tZC/hD+O/TQwjQi49TSAEeTgAifaSnWRS9SacrOeiRRQYPh9dK4vC5rmx8J/udgUEVB
 Joxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725632945; x=1726237745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PEJ2L0JPpxtq4batFHOWALGWo5a9P7CquvYsjYDJPSM=;
 b=GZUC0qSfsMwDFrsY/Hv65BFWIxL17sLDdTfEP/FNac+lRCLJrGJPFMgHTYaucuEVqY
 Y+s5vYxBT6X0fXDxhwR32a5+XNa+mtg7J7abs0fGxNI/eK7ri6TAvUu6w2ee5B3/td+S
 +rQExDTPR2qj6x2b2J5igNbjEEQaA6M6m/ucsSQh99Vm8x6ZeyivScceWzofXz6pPjRm
 +q+i/haOrd/KG5Vo0B2IXXI8REUtODw1gZf8jdTWy8FQCPjKn+jwiykbAc6PyBn9YoYr
 MJEg8Zy8vWC/P7Nrcd9gJnd0lTvLB7vttNM1oxJgDBXElA9z8m8ryuCBCoDZm1w1MjAz
 Jrbw==
X-Gm-Message-State: AOJu0Yz+4jVl8fysNo6bCGwXmNmeThtt7x4l7prJWswkSR02kFLp5IU5
 d+jr/ivUW6p/ESeQg9aYpCR+cOWdTNe+tz2CBB11ONiwtog8epRn26KvUsC9C7MyRuKjkf+ItXR
 eW0FhTv6OMPpoHjE5yD9OUKKXBZOIpC4FU4Jm3YGFLUIdh2P8
X-Google-Smtp-Source: AGHT+IGST03vL3poJKsVkbGA9Mwu5+Xf1kjCfo/yy7OXDT7rkXsJXBhL7MymfJYfEpOk8L8CwEoE0ogYMX5hLc4cdYI=
X-Received: by 2002:a05:6402:3885:b0:5c2:4c8a:a8ba with SMTP id
 4fb4d7f45d1cf-5c3dc7903e6mr2118640a12.8.1725632945222; Fri, 06 Sep 2024
 07:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240905165554.320577-1-peter.maydell@linaro.org>
In-Reply-To: <20240905165554.320577-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 15:28:54 +0100
Message-ID: <CAFEAcA9C1qOFp5Q1k4iQ_bsYRT1GwgbGmzmxYywtWcJTuf0few@mail.gmail.com>
Subject: Re: [PATCH 0/2] tests/qtest: Fix problems running with make
 vm-build-openbsd
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 5 Sept 2024 at 17:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> I noticed that 'make vm-build-openbsd' had bitrotted a bit:
>  * two tests for the stm32l4x5 forgot a qtest_quit(), which meant
>    they would pass all their subtests but then timeout because the
>    underlying QEMU process never exited
>  * the ahci-test timeout was a bit aggressive
>
> This patchset fixes these.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   tests/qtest: Add missing qtest_quit() to stm32 tests
>   tests/qtest: Bump timeout on ahci-test

I've applied these directly to master to fix the
test failures when I apply a pullreq.

thanks
-- PMM

