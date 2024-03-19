Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C824EC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmf6n-0001Rl-A9; Tue, 19 Mar 2024 15:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmf6k-0001PI-Dh
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:26:46 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmf6b-0006FY-9u
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:26:46 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-568a53d2ce0so7219391a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710876395; x=1711481195; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HpQ3X6Lgu0pz4QjyV48H9UCXm4tRHs7K2dJ1EJJ4V8I=;
 b=m0Ddcer0QW3Pmi3mDN210k46W5ALv/4AvpAuGTMAkElcktzTx+KEy0JBSRDPwPuA+P
 qAMEWPcfAQZdgme7bDzjCKw/FYOfQ6p1xypX2hLoExAXC5nXZrYfi0DiP02muxP4yHih
 e0Lz/t+gKp9zPjUdz0G3H/kjTjPrVYAa4ODKeDXYGW1L2Wl3yUR90UdeIBqkfxID3B5i
 BYWchzocuKsnG2XvBATfX5bJW75BW0jv4ZVfCemVKnbLflTeFCixwQq6bYg8kevhV7rv
 dW8X0sM+wjPjn62HzI8eRi4m4KZ5zh5G8Y4HWjeM4C2DOGW7CQSANyHy6WMBk8TrFcT7
 MwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710876395; x=1711481195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HpQ3X6Lgu0pz4QjyV48H9UCXm4tRHs7K2dJ1EJJ4V8I=;
 b=w4Sus7b7NzHt04RaSUA4tEQpO2HmldfdszJ7TL0scdKT+CcKYfoUXwoP5x805qyJd0
 N30IWfxHBcbvy+pz75BjazUQCGjAz1FrEIpu3DQxkiBuSJw6AOS1BLQ5WXVX7UBb9hXq
 PbRDTeFTTNz9GFcqtxMSY7SXeHc562FpbuQv7E52rhmp2Ja85DfcO0IdMgngD1cY+ow2
 N4+6fx3SigQA/q3GyoM3KXYKox7KWXSFIjZyp+uSG1kQ4m8bmOMIkW6DzcMFye704nrf
 RqsB/sVep052Aemv7NOjwnwXjI4B3NZdio/f3uRgmHXEFKIRaFVccyA3kSILsmw5rtin
 E7Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzEW+mp4H7D++Z1i/Fiamy31EbV+LA8VTd5P4uODwJCFe8J6QjImv9dDrsyAB8swbsMyys3yK0C9u6d4KVXW9fs7jgO0Q=
X-Gm-Message-State: AOJu0YxmODXAYb2zwaQaw1wTl7bmvZk7U9EuJiwlBUQCvCPEqbz43oRB
 WKuoWd7IpZxWglPnvBbNrQKulsMtF7h9wZQNByJ+PsuuBTn2ljGRcHwRfxG6UNWqvptyOMHPRnV
 SayZPOkFWdZQId9EmygpeF1+EeQbRVi0w0wviDA==
X-Google-Smtp-Source: AGHT+IG4ZF3cWAzRY7YgIF+dYGJPkPnZ8xbwNXkWqBPvQ0bqq8woquO55aFViv+MN84xJybg2x15SbvTU09Gl5bxWv4=
X-Received: by 2002:a05:6402:5001:b0:567:fb9b:37d5 with SMTP id
 p1-20020a056402500100b00567fb9b37d5mr10656218eda.32.1710876395101; Tue, 19
 Mar 2024 12:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-7-ruanjinjie@huawei.com>
 <CAFEAcA_xSHAJnn0_O9=zGo9u8omzhuB_WvuMo9gf7wKt8OVDmw@mail.gmail.com>
 <cb5d981a-6db4-479c-9eaa-bca49c40bc72@linaro.org>
In-Reply-To: <cb5d981a-6db4-479c-9eaa-bca49c40bc72@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 19:26:24 +0000
Message-ID: <CAFEAcA9bKcu0FrfqRGg6bbtNX1kYR04_oian_5YXaduq_a3W3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v8 06/23] target/arm: Add support for Non-maskable
 Interrupt
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 19 Mar 2024 at 18:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/19/24 07:28, Peter Maydell wrote:
> >>       switch (excp_idx) {
> >> +    case EXCP_NMI:
> >> +        pstate_unmasked = !allIntMask;
> >> +        break;
> >> +
> >> +    case EXCP_VNMI:
> >> +        if ((!(hcr_el2 & HCR_IMO) && !(hcr_el2 & HCR_FMO)) ||
> >> +             (hcr_el2 & HCR_TGE)) {
> >> +            /* VNMIs(VIRQs or VFIQs) are only taken when hypervized.  */
> >> +            return false;
> >> +        }
> >
> > VINMI and VFNMI aren't the same thing: do we definitely want to
> > merge them into one EXCP_VNMI ?
>
> We do not, which is why VFNMI is going through EXCP_VFIQ.  A previous version did, and I
> see the comment did not change to match the new implementation.

Why do we put VFNMI through VFIQ, though? They're not
the same thing either... I think I would find this less
confusing if we implemented what the spec says and distinguished
all of (IRQ, FIQ, IRQ-with-superpriority and FIQ-with-superpriority).

> > The use of the _eff() versions of the functions here is
> > correct but it introduces a new case where we need to
> > reevaluate the status of the VNMI etc interrupt status:
> > when we change from Secure to NonSecure or when we change
> > SCR_EL3.EEL2 or SCR_EL3.HXEN. We either need to make sure
> > we reevaluate when we drop from EL3 to EL2 (which would be
> > OK since VINMI and VFNMI can't be taken at EL3 and none of
> > these bits can change except at EL3) or else make the calls
> > to reevaluate them when we write to SCR_EL3. At least, I don't
> > think we currently reevaluate these bits on an EL change.
>
> We re-evaluate these bits on EL change via gicv3_cpuif_el_change_hook.

Only if the GIC is connected to the VIRQ and VFIQ interrupt lines,
which it doesn't in theory have to be (though in practice it
usually will be). Plus it feels a bit fragile against
somebody deciding to put in a "this line hasn't changed state
so don't bother calling the handler again" optimization in the
future.

thanks
-- PMM

