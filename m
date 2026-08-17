Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA74C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzJF-00037R-U2; Mon, 17 Aug 2026 11:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzIu-00035Q-Uz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:31:15 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzIt-0006Mp-9l
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:31:12 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7dbcb505578so32844897b3.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786980670; cv=none;
 d=google.com; s=arc-20260327;
 b=kzRmrxES2nTYIZHoWVPogbJy4fqqLi5fVpeVHVIW3+gpqT29E5zChRAMylxMjb1Q7A
 WgdP5kxeX9g+kEluY/wtaaYGaB+nIppPITk7yBa6Rl4T3i77pYXZgOnV88tCCStge0uG
 FMY4E9vVjCjlnLcZtVtf4tO91A+Bl3GHElE6zyynyJAe6YhwN2MkXOXDZ4CPIs7rYEZv
 orNI8IdOqRrbAofE67upDo8YiEwFVyT6jJqS+bL1Dhrhqh3LH5TlAzwI0irViYQhb6LV
 sXX3i8kMYUtc6YW/p9NTn8GQhRfbt+lOJCzPxNERAGwYVcJsmmNFdjjYurQ1cS7GaT2G
 EEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S6wGBVU06qe/b4pIsOtBQkIo7D1P6Ei01iPcP21zDQ4=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=UO3GaaFfvdAEvdwZ3ftaRw2L8M3zIH78dKltBx/TAixIgTfLjbicc+NFEFl6IKIqFQ
 xCV02zDnAwSPPvG7oi4zRNFExTA3oUlbuWPMfAF8xvyP9390B6+lYEWa2tcgCVVhOb2d
 vW9z7XvTeln7W0z6sYBknSxA3OgCo5AWJIbVTceR0aw6qwrdyTSOcDD0YeFjvQGzJ6Xx
 J36uOn8iczAqJmyEQgmL/bt2azb57uw/ee132M2oTjQKlGuRTxnLvJSTeEq157a6EOsJ
 TuWGrV50mYIgozupVYVhIaWaLnBHH+cRpuh+TZ6hx8NaVYcvB/oAqwnanoHVs9o3r3p/
 Pq5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786980670; x=1787585470; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S6wGBVU06qe/b4pIsOtBQkIo7D1P6Ei01iPcP21zDQ4=;
 b=BctK1wiDBGc4UaFIkXXqQMdT5/x5/0BafuFVPYBPOwkxLxDbpg0/JcKgtnpRiVhZ7J
 QXyJ8/9FrP2zZhxg357n7b2z0RZPIjmWIvZouTUVTlyeNzKjCxy+wezsNkzLc2zD8VlX
 WKuepTLdtHIj3KCG6tDBdRX1edGtvoH+3lAeEeNLRsNyCGE5EXvuuVPiXSt7gI8cb5mG
 mobqcmM1nq+awzIsD0kez2qHOa7iABDvjuTvcJcCcq+rj7PuX9bOWfSLAFrHqf12ZHfX
 +40IBvHBBeDZqsIoV9yp8N5RU8XqY/oCcyI81cdDzU0eeQ6Da6oKbJlDE1sLHId93/2z
 l65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786980670; x=1787585470;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S6wGBVU06qe/b4pIsOtBQkIo7D1P6Ei01iPcP21zDQ4=;
 b=nXsWHjhuY8wM0wVdwNUgS+ITKz2sbIEKk2Hfd0R6QqlhbPaZ7F2V/jXyM0ld//ab0p
 9brAbCGcgL2jLoKjs0iHiz4byphbp2YrcMa7q4QL8suqfpi8eDLiMxGfm8kpunBxewih
 KKzuE4WbF53aJqRi441CtWymK3ipBD8IkWHlTA8FyxhJkael6fs0vbLvVdIalrmoJyRK
 cH/MFDxVAof5+CJAp1wzsRgGjYo33YVJbQLm5CvjLx3BfwGMTLLifcEWFhsr1Who+KsQ
 gQ3/57hQFWa04SB6HNI7+fe5NHZ2tiEhWjOp9nnyE6Hq76469L1OoHlPErwzO6xRcD53
 tGtw==
X-Gm-Message-State: AOJu0Yz7SYJGZ/+02wDgGE7Q1LuJ4KIs9PxvYS4mI3InpPOzSg7Mpzy3
 FYe802j5RPM1LRdD6A3bSZjxMxwAl2QPlu4J1K0qT/x1a/4GYd0Sjr5xVDOuZL5DeTdbYp0j3SI
 TCH4yJP80K/mrXL7myHuGpjtWv+JzEvMjoICA8on2IQ==
X-Gm-Gg: AR+sD10ekKvMvi+cJOV3TmKf+afYUygaCRHapyCiW+ju1kvrkzyIl3QXfr1CTs9Mgr0
 3R6kQoZ62ZJnKzcMSQfiFQuTAyksCuFua/Bd3QJXxZreAn4FM475PqX8LaMkTlOm+ULftFRm/Z3
 BXbetHft5yYLV6O2UFXy4hDUcRkMJf2keXG9nXOJ3MhHeFnE9YTbUiDjRQ2KOJ0SZZUFdi/bPPZ
 26Z59cO1OX7APXPEcMazTG6JLXqi1sW+OPftJAMhwkxPMwHp11zT7l9wzYnichSy9sp0VXKnT+s
 E2ZwWsNLR0MTLPPm4WMc2AXvsO/hpR+IlATmM5GrRqAxJygyP9bqJyaMgGQ/GvcnrEpOae0fa4L
 muW37SAbIOKHA+rXE2TfcljhpdsnH
X-Received: by 2002:a05:690c:6893:b0:812:996f:176d with SMTP id
 00721157ae682-8370d40c556mr80311837b3.9.1786980669460; Mon, 17 Aug 2026
 08:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
 <20260805153005.9989-4-simonxhy0404@gmail.com>
In-Reply-To: <20260805153005.9989-4-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:30:57 +0100
X-Gm-Features: AcwNN1XszKOs2g9pjFMLJkd0BoYPwf2SNBrcIcQ9MFVlPDArd6FUb87k52Jg0O0
Message-ID: <CAFEAcA-jYZz1Ak4w5vgWGuzJnP4N=ikthmxRswY5=ZZzXWiRzw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] hw/misc/iotkit-sysctl.c: add SSE-310 support
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 5 Aug 2026 at 16:30, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add SSE-310 case statements for reads and writes.
> Add new SSE-310 PIDR and CLIDR values.
> Add new SSE-310 PPUINTSTAT register as RAZ with LOG_UMIMP on reads and
> RO on writes.
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
> v1 -> v2
>         Add PPUINTSTAT register
>         Make sure comments don't separate case statements

>  static const VMStateDescription iotkit_sysctl_sse300_vmstate = {
> diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sysctl.h
> index ce72258a84..8e1cf0012d 100644
> --- a/include/hw/misc/iotkit-sysctl.h
> +++ b/include/hw/misc/iotkit-sysctl.h
> @@ -53,6 +53,7 @@ struct IoTKitSysCtl {
>      uint32_t initsvtor1;
>      uint32_t nmi_enable;
>      uint32_t ewctrl;
> +    uint32_t ppuintstat;
>      uint32_t pwrctrl;
>      uint32_t pdcm_pd_sys_sense;
>      uint32_t pdcm_pd_sram0_sense;

If we add a new field to the state struct here, we need to
add it to the vmstate data structures for migration. That
means a new subsection with an sse310_needed() function
so we migrate the field for SSE310 only.

But since this field is only ever zero because the register
is read-only, I think it's simpler to just have "r = 0;" in the
register-read codepath, and drop the field entirely. If anybody
ever needs to implement the register to have real functionality
they can add whatever fields/migration handling they need for it
then; we don't need to try to guess now what that will be.

thanks
-- PMM

