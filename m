Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C707C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1refPr-0001GJ-Vn; Mon, 26 Feb 2024 13:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1refPr-0001G5-97
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:09:27 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1refPm-0004Ah-EP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:09:27 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so4020141a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 10:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708970961; x=1709575761; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kNlpHvNe0Knj79P6hKrLjJzShYzrgiIlFsdVWAIh1Xk=;
 b=Z0uNuejBLD/p0urJ+Bd+nUj92x2S6hF+aRrgSjkSaTYlKKA2ehn+rCDZJ8607Ziodk
 Rc+2Oc8fLrLOKq9VxkKFq6InmskB8Tx8RFM8cq2l0GBOm6xHIBpW3QHvNp1kIeFwbJLC
 QMhG4SP7FmdN3+8KmRQF/pZWEwYJTR03UjTWP/pJNBMD2dAYtk27s/1FBSaBbqnWUyUr
 oG+rwLXbwbPzNr0p4XZUCKhfFdCu4qsw4FjOs6pRXK3HPBGmUpL80xN0T2NR22RWOEqZ
 DLHMKgKmRf4A3EPlP5JO1rFXWrqBiRFivLEMkSGm8GQl2+KfYr1GguZ7sZem5kYzQtgZ
 EjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708970961; x=1709575761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kNlpHvNe0Knj79P6hKrLjJzShYzrgiIlFsdVWAIh1Xk=;
 b=tFAXkZ5Ybae6gTatSNZZw3txU+JCBExHMLnKqdJlIrAtBANfciAPPqGPBGftssBfUj
 mrbwIzvoIB0iJjEznm5RIDY3iAwL9MipZ58LNUmE4wbmcJbEm3KBl49hJsX8qVhIrF65
 CR9a6OxHeVZpZB3fmBfVzRzmzdSDxJfyrYjXteSmVaQLUvuxtbaii6gqyJL9mWVjLzG0
 id+CfIJQyD1AL09gx0ebX4mlFKotW2cVDffucIFX4gDYhfNwWhhYZHhfAUiLzD/+s0mr
 jPZvDckZfggVRrc5rR/WQpRvtxFomCHKYaGFlD/LALgen0gsjZTBJNNJdBcTb6kNOyu0
 /GNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoFQd+a2VjgBgkAOaHeP5ar5xQzIxKbd3l+0xxl3oYreIsPKLsML1tKLRGuxsTb6GzGZ8tNjuUHGt0TkxB9W4PDLSHxtc=
X-Gm-Message-State: AOJu0Yyl8Su4Dv336Ibawl9nPUshIuDbIeiFjNZhw8TMK/RfSlFYGGWE
 F5uuUKQGwv7LCGElu9TBWJQ+q/l38J6bmXlyXIdaf2Yty4+TKzJw19HcjTQXPc4Vee7MNIHbF92
 m+CnfmXNfiSuqiqdiX4Kkc+d4its6XmdUl0b7jQ==
X-Google-Smtp-Source: AGHT+IFh5LnA0ODXKR8OX0exO2R1PqVsEyzr8j3Nv+amg7lc6944DQvTe+4VLQnR1BzqzaCK+q6l0oXvewe1cqW/PkA=
X-Received: by 2002:a05:6402:3411:b0:564:bcb1:45f6 with SMTP id
 k17-20020a056402341100b00564bcb145f6mr5348223edc.15.1708970960788; Mon, 26
 Feb 2024 10:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 18:09:09 +0000
Message-ID: <CAFEAcA_brkckzDZh_-UJ-KFfBGvjPozPHNmG-bWFO0Xa63R0Gg@mail.gmail.com>
Subject: Re: [PATCH v6 00/41] Raspberry Pi 4B machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 00:04, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Introducing Raspberry Pi 4B model.
> It contains new BCM2838 SoC, PCIE subsystem,
> RNG200, Thermal sensor and Genet network controller.
>
> It can work with recent linux kernels 6.x.x.
> Two avocado tests was added to check that.
>
> Unit tests has been made as read/write operations
> via mailbox properties.
>
> Genet integration test is under development.
>
> Every single commit
> 1) builds without errors
> 2) passes regression tests
> 3) passes style check*
> *the only exception is bcm2838-mbox-property-test.c file
> containing heavy macros usage which cause a lot of
> false-positives of checkpatch.pl.
>
> I did my best to keep the commits less than 200 changes,
> but had to make some of them a bit more in order to
> keep their integrity.
>
>
> Sergey Kambalin (41):
>   Split out common part of BCM283X classes
>   Split out common part of peripherals
>   Split out raspi machine common part
>   Introduce BCM2838 SoC
>   Add GIC-400 to BCM2838 SoC
>   Add BCM2838 GPIO stub
>   Implement BCM2838 GPIO functionality

I've just noticed that the commit messages in this series
are missing the conventional prefix that indicates what part
of the codebase they apply to (hw/arm, hw/gpio, etc). I
propose to add those in on my end for the patches I'm taking
into target-arm.next.

I think the one question I have left is the name of the
board: currently it's "raspi4b-2g", but should we name
it just "raspi4b"? None of the names we use for the other
raspi boards we model have a suffix like the "-2g" here.
Philippe, do you have an opinion here ?

-- PMM

