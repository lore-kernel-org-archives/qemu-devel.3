Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC9BCCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIOAw-0003uk-88; Sun, 18 Oct 2026 06:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOAp-0003tz-9d
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:31:28 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOAn-0000jo-If
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:31:26 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8ab432273c5so8920127b3.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 03:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792319484; cv=none;
 d=google.com; s=arc-20260327;
 b=BhvzX61zVdtIFU8h7rwL0V1hye4Tn/K6C4iQDlSs1dJ4zvyzN3+ylvVY3vLgO6tPUt
 5Wj1RDHAPaokeKuh/ZIK9f2+JySIhVgArx8nCsX2i3rt4kVcfARRtcDxpwSlkxikuK0M
 P/9EPG6s/s+/brZMvUyh09QIGnqta2Pw6ZYkMyMBKDpwJJjHzhOZ7YWsNRMRjcQ3LNmo
 TTL9YoSc9AwEltvJp6tLoH4Qoo6zItlJ5C9vrXJ6AZdg6xZUWOfWryg259NKZuOnZVZl
 bMKJaE1qGYLj52fW4zX6aWTUX5T52WBmQCHNu7wOdDldu6lsZWHaVmK/mSTGFbEHYEQv
 bbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HvCn8Yx+NAEkWiIUuKPGId2U8Jj/DfBOaVXjQg2pY+0=;
 fh=dHN1FZJpb1BHRtRBDcpEyrvNB3hUuCjyQs5YK6bCL1Q=;
 b=KNgPUnDKr+SfpHhtABP8HtzetDgyk8jb0NA3Orm89qtN4TLqQONBCY14atBfrOvvst
 gJOvzbbtKYHu3AbxpCsy6doUIOfKyZaSeZfI9hUdebYLwPurAPxl6dsxiI4VWzGsbz69
 FiFtQYiH6L4wd3/dbG0ZtX/VMtScc1CBTyrUvx++mRQsaqptAT7DPopCpQ1bC32XkDgl
 BTN60QOXMvXDYb4fAQ/AKbmoSDajrTb2yRcINBj6OpfJIl/joJ9zw4shi+2rgr8wbQxN
 rmmQnlJTbsSRCV639T6/Lqpfkxg9tgBKoyz9LBs9CsLDtCiqIr8yHp6dJ2bS9N1DkO11
 OgSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792319484; x=1792924284; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HvCn8Yx+NAEkWiIUuKPGId2U8Jj/DfBOaVXjQg2pY+0=;
 b=eKop+5YMzPBjboLApuqlrgBE5yf/fkMA+4RZV0W1ecLHUITbCWnwJ1p/OpT3vTF230
 mv6kHrMDY475JXvr2ypqIjENNIFRmtJlGSaZyYMpU5wKUsozwf0kf6ITHJdBEhX34AUy
 t2dHIVqZWEWqZJ7QfAATfQI/bIQMSPCbHuwHyzXSCJnkRkO0p+dqGbK64E5I2/DR0YjL
 yYZfvi5bJC2sk/NrEczsxWBjyP7Tyi9Bux2xTIPKXWyWJfGJMmtq2Rcy0ikfhELFICxU
 4NwIZkr+JfAb+uLhr2Y+ARIP3W87r8jlq5vcxajLaRixVzHxv9Khx3ixuXO27RJHf/UM
 3mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792319484; x=1792924284;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HvCn8Yx+NAEkWiIUuKPGId2U8Jj/DfBOaVXjQg2pY+0=;
 b=PMliE3a7fjLPT/Yx68sJoidhFzIiRRx8dOzSQq1jkmUiOJub6qvwHJC6sM3hsFrYwn
 emGcvetsLWtWJtvpICeBz3+qri2P1zHlWsQPGR1TYkrM+wRqoFovt0dkA2p3RuYxUN0x
 ZLn/0PavYGb06bLLhGC1ViIQZtN4V1FG0Lcjj6RuaXmuR8B0V2p3mHSJBruolfK4kLYO
 /hRoI9eMvDDMQqeg7nKNaSI/dmJBR7pXCl6rMUQ5Qw9DNfX+HIH/3EZ2eFdw5SzZ5qIE
 JYpr+3OW1t8WPXFiccStfXk4tSjBFil/5Z530Y/mOcITEDN0vwP0Z+nyaa9f//qCdlVw
 Y4iw==
X-Gm-Message-State: AFq9FYLPnZ3ZjqkGj7eYwYyGhf6UiSsPVLzaHYu2ZblZp4UlCdI4HSr7
 4ReZjoC7z+TBvUYFzZoVq2oZ+k2TVqgRLYAfnEIfAkKubRsZq68IF4hHRuGBJMrrqi1ea+9sGYB
 N4lCdAOiVsuV0fWFvXI+oTi6b8WGi0owGPogatXlNYA==
X-Gm-Gg: AYBFou1W2nLWQUgGQ+PwrIDkpJqLGitCAJ6IHE/y9osrx8kj3B8ajp4kwLZSNt0hxxp
 +on6ua/5uu7ivIK6gzhzVgkZjEDq9YVzhA5/HpF6g66Dv9jGClmnL3zQptmKY7DioP/qaQulorf
 BnhzJxKdUVKiLKjyvMv/h6AGv5saGI0umVR1Peor41A5vAVYc26fu6ujL1jIdNzEoSjbOvEwzEu
 QfnDTOcP6sOTwW7EdU/gnN41v9m5fwuuZ003O2EE9c+OZCF9c9s8skjyjAbsUJcXjmgcygSz6Qe
 9TR1CcMmNL3VqgmK0peW9FYYF8oply+6CA3TaYiLxfKag0yaJyfnnb9R0FOOdpz6PyTHsUy56kd
 iHwmk2U6+wcEra/TvqhCKSMjenoFZuwqxAKzffus=
X-Received: by 2002:a05:690c:a594:b0:8ab:6374:561d with SMTP id
 00721157ae682-8b0f218beaamr12196817b3.30.1792319483742; Sun, 18 Oct 2026
 03:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
 <20260918101158.42101-5-corvin.koehne@gmail.com>
In-Reply-To: <20260918101158.42101-5-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Oct 2026 11:31:11 +0100
X-Gm-Features: AclHuK9Chsnsi4n-p4DxZpfHCJzNikDdBdMt9qgoTqFXQJiHn7JmA1NLY8iy380
Message-ID: <CAFEAcA9GcQzUk1TUQaYydxRotyWNWSbqp_-bjHnfsrcE7jkzFA@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] hw/timer,
 cpu: Add Clock API support to A9MPCore timers
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin Koehne <C.Koehne@beckhoff.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Fri, 18 Sept 2026 at 11:12, Corvin K=C3=B6hne <corvin.koehne@gmail.com> =
wrote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Add a clock input to a9gtimer, arm_mptimer and a9mpcore. a9mpcore
> distributes the clock to the other timers. If no clock is
> connected, falls back to 100 MHz for backward compatibility with
> existing machine types.
>
> Frequency calculation now uses the input clock and prescaler
> values according to ARM Cortex-A9 MPCore Technical Reference Manual.
>
> More information about the A9MPCore timers can be found here:
> https://developer.arm.com/documentation/ddi0407/c/timers-and-watchdog-reg=
isters?lang=3Den
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>  hw/arm/xilinx_zynq.c           |  1 +
>  hw/cpu/a9mpcore.c              | 12 ++++++++++
>  hw/timer/a9gtimer.c            | 42 +++++++++++++++++++++++++++++-----
>  hw/timer/arm_mptimer.c         | 19 +++++++++++----
>  include/hw/cpu/a9mpcore.h      |  1 +
>  include/hw/timer/a9gtimer.h    |  1 +
>  include/hw/timer/arm_mptimer.h |  2 ++
>  7 files changed, 67 insertions(+), 11 deletions(-)

Where you add an input Clock to a device, you need to do something
to handle migration -- see the section docs/devel/clocks.rst.
For these devices, care will be required, as I think we would
rather not break migration compatibility.

This patch is also adding Clock handling in multiple places at once:
 * a9gtimer
 * arm_mptimer
 * the wrapper a9mpcore object
 * the zynq board

I think these would be clearer done separately.

> +static inline uint64_t a9_gtimer_ns_to_ticks(A9GTimerState *s, uint64_t =
ns)
> +{
> +    assert(!(s->control & R_CONTROL_TIMER_ENABLE) || clock_get(s->clk) !=
=3D 0);

It's not clear to me why you can assert this, or why it's an
interesting thing to assert. Similarly below and with the
equivalent-looking assert in a9mptimer.

> +
> +    return clock_ns_to_ticks(s->clk, ns) /
> +           a9_gtimer_get_prescale(s);
> +}

-- PMM

