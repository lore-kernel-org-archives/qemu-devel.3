Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE963CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaFo-0007ZC-S5; Thu, 28 May 2026 08:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaFm-0007YJ-Eg
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:54:26 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaFk-00079v-SF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:54:26 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7dc18e2498bso13359687b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779972863; cv=none;
 d=google.com; s=arc-20240605;
 b=VGnwMsKfwUpHU+wmnfi6mW5uP5+nqweV51TSFouwGTbikpYb/zwTe8mGTCDZWhg9Kf
 kIaCDH9mhQWtzDJ2LlJBr27QMuEOS/SkgVmBX0ijkQ+mJfiwQ1VqUV+TWYXjddxubi67
 mg7cvx1l7WxzZEJORpM6+ZV8QQTIeCmbKM2q5vV5i3Kh4X/NXM11OKdQLBi136bL9guM
 4XePxgDhLRSWVBORHJKl/EZZQLnnsDnXieDLYmzfst5nW/ztpt+cG38ZgngSOrgmA0sa
 Z7s3W/AtS6LT5nGCmRQhAuCTSvTShGKo3MJE1PN28kp6/oTzbcrZ29v/nh0Yho6uoDv8
 hM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DAv25ndm3MvnTR5ZhnygaG9HStfvAseM/0GXjVRpQAo=;
 fh=uCmUPCW8pkfAYUb2TNqBA1N8JsXLaq44DlF1L+QbvNc=;
 b=ZuJGscp0/I9O6A68Quekv1hAjC+BwCKm7lkpoFARDsDSxSkPOpdUFX3RWEamTK/L0q
 hQL5PxgCP1g2/SDF7XSfOVufq1qEY43S9cBbhMSfCeTHhSLkIHZi7tGkKdnVPFw+aEQs
 7Yz6HxAMC6cZ310QECi7jzw1ZsLaWEaMB4oIjjWHTjWgsRQTK/ftcYGtIbD9fN7DFIXN
 a50xDi4rqhXKJB6z/KxQg3ngtKJk+NhunzTWtZUIdnfHK0+qbydWkPzTzjb6A59+/wKZ
 PuKZ6ap5E9FxGwBAaa2hJ4Op2EAjo4jFdaMLun2zwwvzkfee4GxA+MyRdiokglKFY/PK
 1Prg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779972863; x=1780577663; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAv25ndm3MvnTR5ZhnygaG9HStfvAseM/0GXjVRpQAo=;
 b=gPTQzvaXiuqBIkY+aBJlI2YhccX8GGiLfbKsQm3j18EwIkbYSsf08UWFdFY36Kr2Hd
 RpMw7zvsLJbEEUZeWQ1Av9f0eg4E/hYij1ByVLgDT+4V7rSEke7H5VEUp6CTdn0IOCHy
 bFPOPBEwMGgKeLZKtO+P067syNVmE/3fGeQ04m6kCx6xkNrMTrFM1y5V74bDq0G7/aef
 oL3jwW9IOopYjxGc3ivFobqQxmSr3c462+Nr7LP4ddxnPddUG1KJEb444mzwdo7MlzV4
 btDncYas1+bxwfYacOIAo/qpcpJR/8Iis6Qf0afuT8Fw6DpXF3tayXf15oKnwZsKVJJc
 Cy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779972863; x=1780577663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DAv25ndm3MvnTR5ZhnygaG9HStfvAseM/0GXjVRpQAo=;
 b=Vq9WIRd/YSebcXaz+4Q0VuhvK6rYE11OC6DrQWaf9Qq5pybYsYYDn/O/LUUBfpl+LZ
 PxSE3pazew9vnP99N3GvVdll3h2CXw1+LUNoaFfqnybIWTA5AsZsurRlGOqWAVUsyxdy
 d+91KEC6iYGYuKWHRWYJ4kn99GfjJfcsBO5hRCAp1ZGUKJ9ce/addlnlIt7CV0otxfG7
 9C3TBE++dymOqrkNoF3+jCU1sy4Qh9wI1E6/GMrlwU5fAc413qzJLn3u5XC+S6FqOl+Z
 kYfokRGPj3Sjcf7BROfdYv2dHr0VdBVxF6jfq54l47aPiOIu/hX4sDFqVob7bp8Jj0i2
 /XJw==
X-Gm-Message-State: AOJu0YxLcjdcwP/DTPgiT7aDmtslcbrnbMeotWBNX/P94t5pP2c6fAIJ
 6y3Her19jj5qCbnovtWPE5EH4H3Bb4MlXCJto8QHp4TqXz6oRCC5xWZYXZwJF9LPaxFFDFa0goY
 h4cisE94w21gF0KhM5vClg8CDeKEFC27pK6kY7tjtlw==
X-Gm-Gg: Acq92OGysVXTV4fu9lrdwC2TLsMFRufjbxa+wTZJc5QJbnwFML/1DEhj7PnvBwpimbb
 UoZ8A/vUKNqNN2swKT6hYmSMyaxXUPmD1mP/SdIT7kQCPa3NVcoowciJKWda6tslv6YjacJy2NM
 FoXXbEoOPpKUnE7H+7eJnR3QkvOmEug9yhjQJ1AganZOKZVjeJk9Ye7Vy1s6gxnPju+iqLw5Cox
 qbd4VjTx5vU1By5+yxAun8nuKesDanekeWQdfE11c4JfhbkX4zifRkK1LmxKdchVpizSvSDOKTC
 imCcCAXUUTX9U1UQROGMwYJCjF14/l0zwLg8uEBczjWPxFSsFCt+anvwFOtownIvb3xxptQcLBI
 ScA==
X-Received: by 2002:a05:690c:8f:b0:7dc:605d:7a9a with SMTP id
 00721157ae682-7dc606cc504mr29399047b3.12.1779972863322; Thu, 28 May 2026
 05:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
 <20260518073401.11279-14-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-14-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 13:54:10 +0100
X-Gm-Features: AVHnY4IreIkBoesA2_tEVETtj4-KfeK-IdJBI6F4ZpWadK6mhQ4ymOFms6DVOqs
Message-ID: <CAFEAcA_CKm+wjtMh1nQTiVK8W4GDgBXbzugCaoqCvyjXHrVbJQ@mail.gmail.com>
Subject: Re: [PATCH v7 13/16] hw/timer,
 cpu: Add Clock API support to A9MPCore timers
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
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

> -/* Return conversion factor from mpcore timer ticks to qemu timer ticks.=
  */
> -static inline uint32_t timerblock_scale(uint32_t control)
> +static inline uint32_t timerblock_scale(TimerBlock *tb, uint32_t control=
)
>  {
> -    return (((control >> 8) & 0xff) + 1) * 10;
> +    uint64_t prescale =3D (((control >> 8) & 0xff) + 1);
> +    uint64_t clk_hz =3D clock_get_hz(tb->clk);
> +    assert(clk_hz !=3D 0);
> +    return muldiv64(prescale, NANOSECONDS_PER_SECOND, clk_hz);
>  }


This causes "make check" to fail, because we hit the assertion
in various of the qtests. Could you investigate, please, and make
sure you have a clean pass of "make check" and "make check-functional"?

thanks
-- PMM

