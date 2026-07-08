Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF243C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOjQ-0004Vi-Va; Wed, 08 Jul 2026 05:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whOjA-0004Uh-Gc
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 05:38:01 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whOj8-0004iC-3y
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 05:38:00 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664d78637f8so630654d50.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 02:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783503476; cv=none;
 d=google.com; s=arc-20260327;
 b=Kez5gtNNF4bEba5ijtB1nF0W6PmO2UmM8nbeeVy4UgIFxNhvyEs+wHMouY+TO7I29P
 412pljCyJoMav206HiWr93/cBqL1nMQtOS5v7UlEn4fSSsivP+tXGAXD1DDfG183zAaE
 HoOg0qtBG1LtT0qvORd/yQHjdUx+UQOtXgflt9g7l/JS3nA9sft9pTsToTTJSp9aw6gn
 p70mjw8bYXIysRxMm9IHm1Y0X/V9u63AgpI0yDIrIJRibs5x5V1z0TVEBWpO1BuwSW3U
 An1ihxkohutSly2/HoVTTtVlch+0egN20iYiQZx62E3eas0XcWrZolizy83PfEHMMnw2
 6uQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3ZosDczUsYDn9EnHnudkr5uhgqTzQvnYPXxjPGK2rnc=;
 fh=AczoLcRjG3rzPwgtqapMl8UXTRUf6wkH5c/QZLmAzWg=;
 b=rPaPM5pRgNeJz5dOq+dTsN1EjBy9XJA82ODYjiOa6hPC/9dxV3AfJ1wHKlZPWzDO9V
 hrOS3UiWLT0bqKzHoJTDGUybu+3SDyJVE29Xr6eGRa50c0wkACKOPr5dkFSlsKaZiZz8
 DSe34SLZCiXlCBGj4h+JjfUeHo6p8vlXkT0TrmfqJQz0MB+x+8IQfR5NeVDMZToA6t/Z
 ypZEdB98wEF5NJ/AX8i70BMQVNrgfUHoptjeZpW3bVm1HJmQoxgSJoSszAkRdYZdjTc6
 4/PLWBpWSWgnTkHBdh2SDNEh6Y8GLgHWohaN0rTz8CoOSEd3Tv5aVTyBRMRVnq4XVED6
 +k9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783503476; x=1784108276; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3ZosDczUsYDn9EnHnudkr5uhgqTzQvnYPXxjPGK2rnc=;
 b=eOz3qw8ZFgxG7X9QwCfiw0q0oiRdLqw5dGkUxQGIzM4r6BMsjZ5ZS6TEVmgAtsEXEW
 ug8b9iRBReP8wm8VizPLtUyaXxHpfH10prJR0Aw6Od8WwhkpLVBhs8fFfw+WTZRs43pZ
 QqRsOb8038PHzFk74m4ksRpROfvSQE/O7K1LEaP4t7hMzy/8TYhFkWrm5tOileGR9cbS
 57ix2yxMT6PZQneJ8USMwTof/MccXuDxPsWpT+gUDZ13+5tuVoPJanXPsJrixoRhLUiN
 /TZdux3zvcsmluHJY7kGYxPpPfpzzLyTQVN9362oDKnbl4r/ovEkWWjpUkJKIgm96sfW
 8r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783503476; x=1784108276;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3ZosDczUsYDn9EnHnudkr5uhgqTzQvnYPXxjPGK2rnc=;
 b=O83GURjvbhYuyPt3B9tEOtlRNDugEnnOQvc+Sgrrtf+rEVM49dZGLIFS3ONHMzQE/c
 dkw4tItD4lKCTbcf1rlQ/6OpzKquISwrgpsubBNnDolkvhL8ZF8czimLUxdQ+XuhyyZz
 6O3c9dZ6PKmhhFn/zLCiAJlnk6NF//Tq/CllpZpihuQY0vlofBrluYhw5qVWdbL0hrBs
 jbqU4CRXK0g8FwVdve22rqMKyEalCqI05N50Eua+4HfMf+41E9Kb2OACfs+98frpEfU+
 HUGBc5jEWbwqbeCjN+AG3ALyU2fDXaoRhbc9udogxT8Qf5mauP/TK+ah4XEQKBXMDHEZ
 xY2g==
X-Gm-Message-State: AOJu0YwK3YyFd5LiN/6hroRbAoQrR9ylgfymhJJe5oMbR5aO2HXSbcVo
 R2oxeyi7Ohp1IiG8Id9vJqiNmvno3yQXTOvbellqjH7bDSzB9appXpBejPp6OUKoUD+3A5/gWdQ
 PWbbEAt/D8xqKOHOxrvNe4qK9qCZFxa1IXE9wKYAJAw==
X-Gm-Gg: AfdE7ckt3n8Bd3xlVPjYY5FfXKM9ZaV9Hk9OmgTro+B7+29xJxzSYiXpIsq4+oXI/Ht
 v12uSlPs0nZWU8WFVBgvjHoG/W0wNPe6IeLZbtbOKWaVd6JzEyVgrRWIcd+b6pw3Ls22BePgSOt
 +fp84srRgluv9q4FXQ7dgC1Ec+wIEGMcUMVJapkGLV7Z9NKXjAvPYueOZa3d5Sz0QF+SBtFClMb
 HCzIPc3qeMBQ1VgPcDOib82Uz0sFUvhLEavSQP5qkvkOQolvUxb2fvk0bbC3xlDCUsfCX3lZ278
 gYJ1NMxsYx6PeqIFPrxzH/3QqWOSmy8lj7AZcp5f7GtP42Swb8Rlvqrw
X-Received: by 2002:a05:690e:440d:b0:664:ae6b:b48d with SMTP id
 956f58d0204a3-6679f1b3175mr890337d50.66.1783503476357; Wed, 08 Jul 2026
 02:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260706224426.14156-1-its@irrelevant.dk>
 <20260706224426.14156-2-its@irrelevant.dk>
In-Reply-To: <20260706224426.14156-2-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2026 10:37:44 +0100
X-Gm-Features: AVVi8CfzBwd_Ewqb3Li2YKgJVBt-noDC0AQiLxaYYgZXkI47PiAlfrsmhsGUU5o
Message-ID: <CAFEAcA_Z39ga7EZY8yW=k=hK6ytiAxS1zrSFFJKsdgD5S8YXVQ@mail.gmail.com>
Subject: Re: [PULL 01/11] hw/nvme: fix FDP set FDP events
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Jesper Wendel Devantier <j.devantier@samsung.com>,
 qemu-stable@nongnu.org, 
 jaeyeong <fin@spl.team>, Jesper Wendel Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>, 
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 6 Jul 2026 at 23:44, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Jesper Wendel Devantier <j.devantier@samsung.com>
>
> Addresses an issue reported whereby user-provided event type values
> could trigger two issues:
>
>  1. if provided event_type == 0xff -> out-of-bounds access
>
>  2. if provided event_type > 7 -> generate a value too large for the
>     u8 event mask.
>
> This patch fixes (1) by correctly adjusting the length of the look-up
> array to be 256 values.
> This patch fixes (2) by:
>   a. changing the event_type mask to 64bit, matching
>      NvmeRuHandle.event_filter

Hi; this change has caused Coverity to notice another
pre-existing problem in this code (CID 1663674):

> @@ -6492,9 +6488,9 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
>      uint8_t noet = (cdw11 >> 16) & 0xff;
>      uint16_t ret, ruhid;
>      uint8_t enable = le32_to_cpu(cmd->cdw12) & 0x1;
> -    uint8_t event_mask = 0;
> +    uint64_t event_mask = 0;

event_mask is (now) 64 bits...

>      for (i = 0; i < noet; i++) {
> +        /*
> +         * We ignore requests to enable tracking of unsupported FDP event types
> +         */
> +        uint8_t event_type = events[i];
> +        uint8_t shift = nvme_fdp_evf_shifts[event_type];
> +        if (!shift && event_type) {
> +            continue;
> +        }
>          event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);

...but the shift here is done with 32-bit arithmetic.
So for the cases in the table where the shift count is
32 or 33 we will shift the 1 bit off the top of the
value and lose it.

Using "1ULL << ..." fixes this.

thanks
-- PMM

