Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F1CFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIQws-0002jd-IY; Thu, 30 Apr 2026 08:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIQwh-0002fa-84
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 08:56:51 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIQwP-00023g-Vs
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 08:56:42 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6501c9903edso855285d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 05:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777553600; cv=none;
 d=google.com; s=arc-20240605;
 b=VNb0JsX5tJBm4iEBZkWDhxCuq8Yl27aMVU91LmHi5CANOcGW/xBNTEPRT6+tG5SyIU
 IO+tIPui74FbzrDLMrwVpqD+uQTLg/zMVALp9ngWV/stw/yBNial8ynGqQ5CeLsGpIsS
 zWU5UhmsEGa2sBqYWA40GCuDFC6PxDyrh1mrg9KaH0WPYrM518bOtTMG+xu/biGweOSz
 q28os7lI3GjLQQn2RnZZrZeyEtUzQWP0aSuShUcdFyCjHO0wq6Ppi+Tx0G7ABnGM2EDm
 6W4Xo+e/ZBgU83kmCQ+Hqr00x+jlXpSHwrdDN3VkljaSxEXq/B/Uduaxsz1I8vGQ3/8r
 OvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ME7HLLhzC10o6ABCcHdFB+3uD7M7E8y0wuOZ5UflQjw=;
 fh=nH2vikJTNJ8PsEauiNJL9M2UiQhZrSHgqkZE6ewNIp8=;
 b=TQuOH+NRBA3EF9KmkgDfR1PWdS39En/Dy2uExyIgMbpdjM4Ua9lMYu4kK2O+ciZY2o
 xdNQhWyqYygKTOpw/MTL6k11u2oE8EAq7+Pe0gUJ84sH8n0UwJccyNlFEmIFtbAvhR8T
 zM7MyptbBkTrk2WM/uJBRJWspug3pknd/R6swXrrI2uOokociPaaFlXmShR0DfzBmaYR
 T/3vxG0UYCG/d3sJOJOBGETFab/npvwrywrmd33C10trkmL/y6YGJQoLuv2V7bbumPEt
 Jdqxr7ST8GmSlznazDfuvUL8NQplCgMnxNlsQxDmOh0Hp9TFVMeA6PaCW0pyQm1kLhnU
 Mpgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777553600; x=1778158400; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ME7HLLhzC10o6ABCcHdFB+3uD7M7E8y0wuOZ5UflQjw=;
 b=DDPtFddTl3AnoKF5Ush4wpHCY+5WgS2Z62Ao+icBgE7ShDKmwutjXmSFWo5B23JyhZ
 2WEGCYapveFJOvhZjKzlrjb9zyzL4fazQIEbalKehJJXLPc0DocI8Nz6kpdIXTWOu6q5
 jduwcUxTX8gTan7QO3qeKplh5jC1WYGtUCOIBKHMkc/YOmcSIZq3rejk5vRCM+X+zJmo
 YDD1sthSKDorbIdCt0UJe2TQZNNK1PL2Tjs4ZT0IE3YCihRx3yBx522VLxKutsnQuOuL
 5kORYIcm0RMcwu+CYqgww9qISgO1bK5LV3uriuoQCtQtFB/BrG1SlmCxsvKWIg3aFty2
 8vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777553600; x=1778158400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ME7HLLhzC10o6ABCcHdFB+3uD7M7E8y0wuOZ5UflQjw=;
 b=S/y5CJMvjo93+9nhhziPZXv6MoHxQyEgI/0z8AAOEpvtI9h7DOVGgc9FpcCtk2xAxa
 Rq8/hi9eO0WrfWCwZnhFL296Lh+82GPLNTPMD3iakwKunhLye5n7msWR0K4nkJ4ypHmq
 J+hLP2yjd+jvEdD3+mOHDhmABlxyDZO+OVp6D+FOHrl3ywXx4whpRZaT+hyUb+QFhvF/
 FTr7SFS2AvkvXZmdehoPOf0qNy53dsZgoJJ9VfR86uqWxM2TAZdXjkPVmimFizNBDxpV
 0pf++Ow+yIbe1BTlSzx5Y8pLIo9N3BId3f/XqeWsGPqzC9iRiLhpuGLqm0xKMsv7iUuZ
 xPDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qXX8IeK41tofaoq9VGaGaZwCasJ4LQVrJlbsmz1tB6JrmN2exP85SFHmLkyRITfauo4RyFSVbANnN@nongnu.org
X-Gm-Message-State: AOJu0YyL59Qi/A/5i7QhrYxT6S3FRJ1bhQ0cYa5HNaFV3j5h+8gvu74X
 KIH0T4zKuiA2OOyY8CDm7ilmyYAi++jaOYPy+LItn6pT/ClEUf2gzcoVKmq+3dVzXHADID3630s
 dSrxlja/txoTKPXvReSYQ7jTLlLZOthNiqAc78673vA==
X-Gm-Gg: AeBDiettDEaTUaqKtMSIw6qpO15nkENtiW09NMm4Nbq03IjimbOUjAEu014+FTjBn9U
 vJ5AY2+/wdOeww8aV5LddWm5/7Mfl7jf4uoDmn+y0h3LakKIs/LpyhhIGMu3HQtfmzgNph3Hqbv
 s797q1V1mDcdrEO8QFduh07L1QE1L0+jiE5rYooxDXpcF5W5dxJhbHNJC6Fp0cX2UUjcOzgHLyG
 0eYhpclxjWbe0OlCviRONiFPxY63WYf6bUAGbsfxWsxPR2pUVGSk19b4mZhT4GN9AfDhXYDiShh
 0sL0Pcxy48u7IklInJEtbWcR50ustG0NEql/w5aESUWdX1PQNzjXXgloUkqaiCKGmeDAE6xtNoO
 Slg==
X-Received: by 2002:a53:ac9e:0:b0:65c:1a0f:d8b6 with SMTP id
 956f58d0204a3-65c1a0fe276mr1928014d50.19.1777553599834; Thu, 30 Apr 2026
 05:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260114013257.3500578-1-ruanjinjie@huawei.com>
 <8a9bb7a8-a45b-ecb1-4a16-b48bb6b9f856@huawei.com>
 <62ee8716-5aff-4164-b1d7-dee89f955822@huawei.com>
In-Reply-To: <62ee8716-5aff-4164-b1d7-dee89f955822@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 13:53:07 +0100
X-Gm-Features: AVHnY4JaSZbEl_pQ5dGnNfOWlE79s7zDDx6-QcZPDQyaF9xY-HYFToviURinx8k
Message-ID: <CAFEAcA9FNqHTWrBd-eakJ0OvVRsTaCBsF-a1uCFt4vVcovBPzg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 22 Apr 2026 at 04:08, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 3/18/2026 3:03 PM, Jinjie Ruan wrote:
> > Gentle ping.
> >
> > On 2026/1/14 9:32, Jinjie Ruan wrote:
> >> In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
> >> "NANOSECONDS_PER_SECOND" may overflow the uint64_t type, which will
> >> cause the QEMU Linux Virtual Machine's RTC time to jump and in turn
> >> triggers a kernel Soft Lockup and ultimately leads to a crash.
> >>
> >> Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
> >> because get_guest_rtc_ns() is used either take the remainder of
> >> NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.
> >>
> >> Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> ---
> >> v2:
> >> - Add comment for get_guest_rtc_ns().
> >> - Update the commit message.
>
> Hi, peter, do you have any further suggestions for this version, or is
> it ready to be merged? Thanks!

As the mc146818's main user is the x86 PC models, this ought
to be reviewed by one of their maintainers. Paolo ?

thanks
-- PMM

