Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83274F44845
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBAT4-0002rN-D4; Fri, 10 Apr 2026 07:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAT3-0002r6-G0
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:56:09 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAT1-0000NP-Rq
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:56:09 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6501e465a8eso2113169d50.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 04:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775822167; cv=none;
 d=google.com; s=arc-20240605;
 b=EgkjVg8wRUeuD1OywPWZZY7LpIKS6XZxMQogKVHkO1vy67W1oVyxrsfMKOuv1i870r
 H07ekGOa8olastzKopymX4s7biRc+1sqnFEzJH/190npD3TsGZCfqEEr2PtAt5ujvyLv
 6p1rklQCCTem4qdLtp/CNoiXKds5tblmDYV6SS+Gdq+OF6mhNvhqmYsrz5lH6uutt3cs
 mly6Cpt0jEJ6EcNs+248PDsuvqqaBsOYTRhW9o81G0c1JRK7+IWXfuzE2+IMgEQ56Skx
 bJR+A2NAbedErgroP1vG7oKwLg9IvlP0Vy9eSzj37lpFhFO4wwtm9IbYZCNKplEm94tR
 mlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NdWMmMWUhhEGrUOqELcQVtZVpKdSCUAiC9k4sIWwu1U=;
 fh=MCYs63c1J/uMicm9XnZ/T9KqDXlYdeXMwasUnrNkbYo=;
 b=k3btY+nNtCAj3kJxJ11AE5RDu/bJ9+x40cpsOt8mATap3TdqSbN2XeUfVRGAC1QgMk
 chI4xkepLdFi/M18BFawuYeOnmLQE8UZDi7sq5mOfZmyOBCLx6ac4nK6vXP6VAL75iOL
 7X2zuibPY/amwZr5UZ4YrwBu+LbVJ1TwhTPFOalDvIp2/4SdM7PYxorZwTk0rl7w5Xgr
 kKWqptdZHuaeqNxtW7jxISaBh4tRd6j+SkUojtnshBo5tjWjP+H9EZydAX1TwfwXR0A9
 iJcPiKcZ4As5soO0fJWK7uPYdmcvM0BbVqTkJZ9OIqUK8K4zdCNlwa/XL42kXZSwDno6
 gzIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775822167; x=1776426967; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NdWMmMWUhhEGrUOqELcQVtZVpKdSCUAiC9k4sIWwu1U=;
 b=iEiEDJ1l/dtcrCFGmjGZWCDN5sk32EwMFgokDDUlpzDDTE48ed/HJdrpQ1d8tGzLvT
 aOdwSCr3fG3HxB6zX0sUgTV8RUo+azIYr0nxMqhnL28MG3o2W05AU1yUyuBLlCxhEqIe
 OL9EvOCicUA/KUtt05MPIhxe0LYTKpOxGf+edXgSKNDjFGextAXrb/NZeByFZjztnUrI
 WE9aIxlGwJQiwsBZAs6ydSw013pLT32T+WdEu8e1WyeDcQRfa/1mUR0oir1lufV8HNwM
 aml9Tc6XUqZLed8tJVhTaJyDuEyxtnSeAiSew2ve1Erj640zx2liobLm8XWXLPRTI0gs
 Z19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775822167; x=1776426967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdWMmMWUhhEGrUOqELcQVtZVpKdSCUAiC9k4sIWwu1U=;
 b=fxGqL5eFCfdN5QBwkPZOVhwG9uOKYxSUiuUGQMvGWCHY+/Wp3ZVBQniHZMwUQrc2fF
 7AvrHmBw7l2Jy/TFzLX3vjgcJaMTuIicxQj7xPAV1CjIZAbWQ7qQ3iJ6knljwzh6yTvb
 pUXDWm86ta7TKrqGosxwnZLxFqqA9aJaZ8y1CI9687bjYUapLXBnD9wC6u+IfZF0hDyF
 NGwbuBzT0r4TcmEgKU34L+NrsOFUs201zintB8n9bQObyH/Spp2Tsrwtzo3yePyHoNV8
 j5fazWlzoBIXLIF7qxBIuHU7/LNFveWyk6+23rfEvfdbznMD0j0LayxH6LE2pIajnS2x
 arBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtFne2FIfrtN8pB3y2D6i3TXTz9QyMWZVG2oV8WDTpq9kZlpVaamzQacE1t2PeiaLtcB1BEE06mr0n@nongnu.org
X-Gm-Message-State: AOJu0YxecetKEkWUPPYtsLQWEUBvmn5atBkG51JvSRk2Cttg2SpSbjwQ
 H4imjC5rZpdOf7E5/c5h6PxjxigYKkJ73ewSyQXUM1Das4Ngr5JC6GdSTnywQCedXpmmR2MLe+i
 +tBP5rNLph4siq/ATFYjgjQfe00a/3lzEge3ed42mPQ==
X-Gm-Gg: AeBDieuzfLimLVhi6YSJn53BxZma72Yy49iL1pZKhSlPd4oJjI5u6bUF/6s1wMYCJdM
 PFlIOn1h2j+K8Yc5TnLsQfvRqGIEKjVC4stMnCCQX5x883UBe25SNsQLk3s2tTzztCdPQnZ3IW9
 MmRy7rRLyAy7i/vMoXRhkX3oTa+QDKGQroMJdgOwOVmxU31S9BsroRrGx5/hXeFgfQGZLDC95qq
 sMQhcq9rMprSg3Dv6Y/NJrBWNRmIQcOK9c4EhU/0BnHMS+QTByGWcDde7bRMn6tQq/HoCzsGFNy
 3T+uteZ3XuJY626BtDpKGwSu9NmUct47tO6yotjDMg0i7ZpBJcxl6FXnLtG3bYzXP7HCSxqvp0F
 EqQ==
X-Received: by 2002:a05:690e:43c6:b0:650:1cbb:50a8 with SMTP id
 956f58d0204a3-6518721b5demr4182585d50.26.1775822166656; Fri, 10 Apr 2026
 04:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260306150302.203112-1-eric.auger@redhat.com>
 <20260306150302.203112-3-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 12:55:54 +0100
X-Gm-Features: AQROBzBNIVO6Wda42HxiLDzM4XQTy-kVpgBVZ-_bCNRZVmYIAfz1zuXD3wRTgg4
Message-ID: <CAFEAcA9=y-Vtu-hPSRpYtdO7ZoP96PUroMB6XLbCHKjMHitHrA@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] target/arm/machine: Take account cpreg mig
 tolerances in case of mismatch
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 6 Mar 2026 at 15:03, Eric Auger <eric.auger@redhat.com> wrote:
>
> If there is a mismatch between the cpreg indexes found on both ends,
> check whether a tolerance was registered for the given kvmidx. If any,
> silence warning/errors.
>
> Create dedicated helper functions that print the name of the culprit reg
> and analyze whether a tolerance is set. According set the level of traces
> and analyze whether the migration must eventually fail.

This patch isn't creating any new functions -- is this a bit of
commit message that is left over from a previous revision and
needs rewording?

>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/machine.c    | 21 +++++++++++++++------
>  target/arm/trace-events |  2 ++
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 476dad00ee7..fa236431a8b 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -1065,25 +1065,34 @@ static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
>  {
>      g_autofree gchar *name = print_register_name(kvmidx);
>
> +    if (arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
> +                                          0, 0, ToleranceNotOnBothEnds)) {
> +        trace_tolerate_cpreg_missing_in_incoming_stream(name);
> +        return;
> +    }
>      warn_report("%s: %s "
>                  "expected by the destination but not in the incoming stream: "
>                   "skip it", __func__, name);
>  }
>
>  /*
> - * Handle the situation where @kvmidx is in the incoming stream
> - * but not on destination. This currently fails the migration but
> - * we plan to accomodate some exceptions, hence the boolean returned value.
> + * Handle the situation where @kvmidx is in the incoming
> + * stream but not on destination. This fails the migration if
> + * no cpreg mig tolerance is matched for this @kvmidx
> + * Return true if the migration shall eventually fail

"should"

>   */

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

