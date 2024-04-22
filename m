Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20582C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryw4t-00055t-Nu; Mon, 22 Apr 2024 11:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryw4p-00055V-0j
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:59:31 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryw4j-0000WU-0S
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:59:30 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso5725188a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713801562; x=1714406362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTzh/CY5pEAB9F/D4tZJ6UKsdUsJeOrDVK6PgLKaRZ0=;
 b=VBBbld38fKhDeQ4XIuG/Nl42RhWxUTM4K3dfVtYcMbp/57Y2d8jrse4z/GVHctjbCJ
 vixfZ8WuSVPyaUKB1Y6jwx5u0f8yVQkPx/+plwexB8keJU9M8hlfoj0lTxkZo2rrgxFl
 om+pAdBwVq7ePHivdmYe5+5K2oxenOpfpiIvVZblw98WRTCSpk1ttzfNXxq1W787kT8o
 jyktZ1ZAilPAKS/hQYjVBfCisEC9Wgv1coynLiDN/+8kHGiV7pQmGsPkT2fQDoBYC4ne
 7f9q/SVHETizlN6qAioKO32i9TX9hAC04LvA5UIq18pTj1hKfNB48mzGOSLk3tr6E0Rt
 kxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713801562; x=1714406362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTzh/CY5pEAB9F/D4tZJ6UKsdUsJeOrDVK6PgLKaRZ0=;
 b=JFiOJD2pErtgFv4+nhkHchAta8CCbLriM10APt7La2FTdrqiXXp+/im66AWKaY35/j
 9jZ/H4RuSeJWV7loX/VMiI/tjQoM91S8k9Il56L05EPTG+zUizDteRd7h5IiCwF6KBD3
 W/WsdoSgPlaIHKMEJz+zZiHIgh1+jKka48TPqp1TbGMO+oEXOYdR6UKwAAHxJ+D50RXO
 Mw7UqRVugfz2Vcaia6KTewP2BJ7VpeEge0JdXmkHpbZJyXhZ92pF5Zw5nPbEZFhlOWNX
 SgCqIbomsMdptjXPnHxaY2Zs0XDbwYj0jqLk8bV/PWCDL/7ozm67Kr1+av/aw45A0jY/
 9xoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVB/cD6Z6YQ+n2wWgqGE9xCzpGBGzERTolyNjH7SqM7lG5U0pkOfvxI0M509kwzEDdT2Cki77P2hIWwrgJrLSlOiuC0Gs=
X-Gm-Message-State: AOJu0YxQeU/hKM8gtbcWUkmtzLV2hAX/ZKO01AMWk5FG/NWAgBZ8rxnC
 RjWdvWwPCt5fXgc4Xtcrsebcc6R29TEZAJ74xoI5ZnWGTtelNc5fzQ5W9VF5Xx0OLoRKq8UedHN
 Z7x5YzNbndL3vkRhRlbUMLX4FNgP1hZPP2i9fdg==
X-Google-Smtp-Source: AGHT+IFi29CfMisq4XCB6VPT7Jsy5Fqn4gz+P/sn+b7Gb+M5Q7sjH1PNNPKx3lygSIAJmmjlHKUbEQ28LL804uD3p+8=
X-Received: by 2002:a50:ab1a:0:b0:570:4ae1:6534 with SMTP id
 s26-20020a50ab1a000000b005704ae16534mr7614953edc.7.1713801562528; Mon, 22 Apr
 2024 08:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-6-richard.henderson@linaro.org>
 <CAJ307Egu6951WwbdoTERUVff9cr=2qBK70FWgk3Ck-1DCpDtHA@mail.gmail.com>
 <1e4cd671-45fe-4a97-8f76-5bbb07a84c15@linaro.org>
In-Reply-To: <1e4cd671-45fe-4a97-8f76-5bbb07a84c15@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Apr 2024 16:59:11 +0100
Message-ID: <CAFEAcA8RqJXm7aUv-odrDExYzxoWofzmZOT+A0MFtewZpTHJRg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] target/arm: Do memory type alignment check when
 translation disabled
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Idan Horowitz <idan.horowitz@gmail.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 22 Apr 2024 at 16:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/22/24 08:26, Cl=C3=A9ment Chigot wrote:
> > Hi Richard,
> >
> > While testing the future V9, I've some regressions on a custom board
> > using cortex-R5 CPUs.
> > Unaligned data accesses are no longer allowed because of that patch.
> >
> > I've dug into the various documentation and it seems that R-profile
> > CPUs don't have the same default memory type as A-profile. It depends
> > on a default memory map provided in the R-Profile RM in C1.3 [1], even
> > when PMU is disabled.
> >
> >> Each PMSAv8-32 MPU has an associated default memory map which is used =
when the MPU is not enabled.
> >> ...
> >> Table C1-4 and Table C1-5 describe the default memory map defined for =
the EL1 MPU.
> >
> > For our case, Table C1-5 can be simplified as:
> >   |  0x00000000 =E2=80=93 0x7FFFFFFF Normal
> >   |  0x80000000 =E2=80=93 0xBFFFFFFF Device-nGnRE
> >   |  0xC0000000 =E2=80=93 0xFFFFFFFF Device-nGnRnE
> >
> > Therefore, we can't blindly enable strict alignment checking solely on
> > SCTLR bits. We should make it depend on the address targeted. But is
> > it possible to know that address in `aprofile_require_alignment` ?
> > with `mmu_idx` ?
>
> No, this would need to be handled in get_phys_addr_disabled.
>
> > By the way, are R-Profile CPUs the same as those having the `PMSA`
> > feature ? That could mean we can use the `ARM_FEATURE_PMSA` to deal
> > with that, instead of create a new `ARM_FEATURE_R`
>
> No, some armv5 have PMSA.
>
> >
> > Note that the RM I've linked is for ARMv8. But this other link [2]
> > seems to show a similar behavior for arm-v7.
> >
> > cc Jonathan and Ard, though not sure this is the same bug you've
> > reported earlier.
> >
> > Thanks,
> > Cl=C3=A9ment
> > [1] https://developer.arm.com/documentation/ddi0568/a-c/?lang=3Den
> > [2] https://developer.arm.com/documentation/ddi0406/cb/System-Level-Arc=
hitecture/Protected-Memory-System-Architecture--PMSA-/About-the-PMSA/Enabli=
ng-and-disabling-the-MPU?lang=3Den#BEIJEFCJ
>
> Ouch, thanks for the armv7 link.  At the moment it looks like my blanket =
mmu-disabled
> change should be restricted to armv8.

Restricted to A-profile, probably. I haven't cross-checked, but IIRC
for v7A this is IMPDEF and we're OK to fault it.

thanks
-- PMM

