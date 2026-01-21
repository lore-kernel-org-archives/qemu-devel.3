Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13BAC4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYZ4-0008WA-Vu; Wed, 21 Jan 2026 08:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viYZ3-0008IR-53
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:48:05 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viYZ1-0003aA-EQ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:48:04 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79407df9391so20498427b3.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 05:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769003282; cv=none;
 d=google.com; s=arc-20240605;
 b=iMPEfv0PPuvfDHGSkn1z7dhwSM/zBnuKwLz+PG4Ap8QnKgTTQ1UJyb+9S1xZqEolpX
 G6BSJHH5bpKuJIVk4WVCb3Q5vYzbABJFmbR8EPZs8V8iN4vJrZn9kJhADHmqrUoL1NOY
 zldZXmBGs2kUrpUx7Di3f8G49vYjH2SyUf0o6U1sR+stTpprsuzQj3Cbha5cj38tFMQA
 z82H8PAsXU+HesrpWoc5kKPrVsI2iAeh098oz1E3it9vfhuZsp/HO+BRpi0JiEXglxwy
 TD1iCBYDI31vslTQqPhMW66aBB5Uhq2ovIUEiJfQGFo5Onixf6xVhE0k6NxLo8VelD83
 YkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7G6h10Tk4dC5c9iAjzf7lbA5mXcsy/TE9Bg8F3/aNUY=;
 fh=h5XwtwbFZRZ1FUOtZRgdKZteGKilXmRo+GqhpTRH7tM=;
 b=JaD+q7FWFsmIMs3SRvRGBU3U9ZajOUQjVDkWznK/UIOr0URafcmmjfeQaz2RSUfLKU
 6dNLLb/A+VzX/36J6bE0eiMcmcA10Eeag9L/EgTiFXJfYN6gRBGfX+HV3XBcnJNZRC+e
 gkZeiPfsPrSb0GlyvdjE5Eh+ZvKemIGDNhgceX0oHys7ft4GAsp/t3pyJ4K+r4aoPk04
 zvKONjbT0aoT2KJi2luO5K2guna/DRL4EPvwHnN1sPErC4yfEUlEnpSAJt4FeYTgrqLQ
 R3glakqaHDxbXAqc7eheLhESLbKe+Z25rcaNoDdxAVrMdZof4hls1D5SM1M9H2yJu8rY
 TOHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769003282; x=1769608082; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7G6h10Tk4dC5c9iAjzf7lbA5mXcsy/TE9Bg8F3/aNUY=;
 b=WFYRVqmeVnWjTBm91K1KLLx8RDaPEDffm1FZjJEaaPcBWIZ3zsLui9UoQKLv5+umXR
 6C9yK/qtNAZb1zhfG+CvCBfCKpPj+aQ7tPy+0GC5swjp7j7UYk4/P1F7XgQ2MZd6xYbH
 sBjXS5UrdEOTXD2bH5vBE2owOmC/33HnW1iBp2EwyVzn2KEHYeY4GV8lEj3Lbo8OQ19Y
 SAtuYH3dB43r5OmdvqiNvNNfCfmmI+gDx6YMYm6TgCTFKACpPAlOXK+eEaIa39wy6IDb
 mX7rg0qBDWdNg/os4LZUtx6KhxO7ZBKUlt2j3gJNyQVg1EGpUM9/ne/UNAr8jMxexVc+
 g+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769003282; x=1769608082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7G6h10Tk4dC5c9iAjzf7lbA5mXcsy/TE9Bg8F3/aNUY=;
 b=uWcui2iKVog0iw/9H0utxmWebSazHO70Ke8qZna3yAF73nws8Vk/UARTk/xXx/baog
 K9ggHdUkUdZdfrC9lf1YtejLDJcuROK6f8JdumgrJioG80YBHq6QpBl2wDXiNBlIhFLA
 BDEVDm0qb/aPJm3vmg4iEmI0DATXXfpgd6OeVOpVbUHoV2N/8xqHHeiC+qHcQFntRahz
 VfTQCGATa6+kE4VT/GfR3ArXO5Df9VHcHfehFrNvFox8lBGRiWbdyZu5dr/MSRA3dg7m
 /XgV+nw0TwZvBjm0JOHJDa2YJykpyr4WnAjJLBGY0j4F70nAp9GPdb/VP2YvEA4ELjzP
 m+fg==
X-Gm-Message-State: AOJu0Yw+Bmzolnh6gcStqDM2+Jt9ejH0tlbEj26cgrL2YgmC80euc9HJ
 cnmT/dpKshKZ6huewdy8kpIF4JLg4VR81aq2rvDu3913H2NftElzRcYbW2yYm83rzo+kSgGfZBE
 r+ZGtvbsz9qXIuJ4XbsnrLW86EtkIff2KdEUG3/F3Vw==
X-Gm-Gg: AZuq6aJ8WDzKy/VRRzdiIdR4qNKQWTh8nYo16r8w+Lg82DW0/covMpfWBpv5gkH6Vi1
 6uMy0rGnGW87RQ+YY/AwEMXO36XnHSxAlqV9dmkMDk1JczxBIlboxj72l3n7C6ALY9MQipiDomK
 F1spSlaUVX7ISQoyo9USsvBYmOsrnvBPCx0QOQY+t4s8GZSnpnnGtlLevH/QQid011X8JuxF6y8
 GG9qpBdPVkQ0V0KSRvqzqMcfesTj2WzsLKMLOBGEEEOYaftcfWfDxVFmhXDxg17Q1SUXw==
X-Received: by 2002:a05:690c:3701:b0:794:35b:af87 with SMTP id
 00721157ae682-794035bb38dmr51554407b3.63.1769003282063; Wed, 21 Jan 2026
 05:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
 <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
 <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
 <CAFEAcA9JC1HRboZ=722dsT7a4nDQNF_ECjLK+z84T5MJisfppg@mail.gmail.com>
 <2FD2C3C6-8FBA-4833-B890-5E81637BE7EE@unpredictable.fr>
 <CAFEAcA-MAsQpaaUx0dJHRHjUJ6bEWwnf58VZN965Npmi7_kHXQ@mail.gmail.com>
 <FF6F91A9-9A09-48B1-8857-FF213C9A4644@unpredictable.fr>
 <CAFEAcA9FMiNZXgRP8OZgvAyPJXfBphXXs4eB1kBZtDgqYDTYUQ@mail.gmail.com>
 <0A38F8AC-2756-4BDD-AA0A-AD1502E2F715@unpredictable.fr>
In-Reply-To: <0A38F8AC-2756-4BDD-AA0A-AD1502E2F715@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 13:47:50 +0000
X-Gm-Features: AZwV_QgTvi0cQAzlH-24fX5AUKxoWQb0Y4mn03noKYc10-t8ZmyNF4k7S7bIhOA
Message-ID: <CAFEAcA8iQu7qatYhW8M2Ud1tow-adb6743XRbGEN--NLQqK0cA@mail.gmail.com>
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 21 Jan 2026 at 12:27, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
>
>
> > On 21. Jan 2026, at 13:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 21 Jan 2026 at 12:00, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> >>
> >>
> >>
> >>> On 21. Jan 2026, at 12:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>>
> >>> which I think means we do need
> >>> the its option to be an on/off/auto one
> >>
> >> Hello,
> >>
> >> Would this be ok instead?
> >>
> >> typedef enum VirtMSIControllerType {
> >> VIRT_MSI_CTRL_NONE,
> >> /* This value is overriden at runtime.*/
> >> VIRT_MSI_CTRL_AUTO,
> >> /* Legacy option: its=off provides a GICv2m when using GICv2.*/
> >> VIRT_MSI_LEGACY_OPT_ITS_OFF,
> >> VIRT_MSI_CTRL_GICV2M,
> >> VIRT_MSI_CTRL_ITS,
> >> } VirtMSIControllerType;
> >>
> >> Combined with:
> >>
> >> static void finalize_msi_controller(VirtMachineState *vms)
> >> {
> >> if (vms->msi_controller == VIRT_MSI_LEGACY_OPT_ITS_OFF) {
> >> if (vms->gic_version == 2) {
> >> vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
> >> }
> >> else {
> >> vms->msi_controller = VIRT_MSI_CTRL_NONE;
> >> }
> >> }
> >
> > Is this with the idea that the its option get/set
> > functions would set msi_controller (to ITS_OFF or ITS) ?
> >
> Yes, vms->its is completely gone in my tree.

That sounds like a good cleanup -- I was hoping to get
rid of vms->its but didn't quite see the way to doing it.

> Going to post a rev with it soon, would you prefer to have
> it separate instead of a whole WHPX series?

If these cleanup patches are at the start of the series
you might as well post the whole lot with the WHPX patches.

thanks
-- PMM

