Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05EACDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbxtq-0002HW-UN; Tue, 23 Jun 2026 05:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbxtj-00025x-Fj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:58:28 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbxth-0003ql-LU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:58:27 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-662ccb916c5so5769231d50.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 02:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782208704; cv=none;
 d=google.com; s=arc-20240605;
 b=MhA/LyN9bjwYXJnFL0aMoKfsfDDLNbQo+UfPYkK/TIkz0p+LqKNdoefxT7if/T/meR
 cDQc+/53OHXjI3pbJM/Gp5/WDF/MRTQ9eaxTb0LCccwdbPAM1sJhhYFPUAM1NeAHF7F+
 brkpZWjqkbdLBcqPMNlCAKikwon9HBQd+rVE/xJPPsXeeviqTGJ3NGALZE6jL/6CfbZP
 mNzuDbAezMvSxvobqpJ7MQ6jbBIwDrKvN7eBDciopcosTLfcJ+qtj+6UfWUmsCgX4jJN
 wEPb27DLY7xt0p2p1M6KGi/Sss+0rfmpnbVqHsRe8RJZYOTQCtNCm+HQE80ir32h/YHW
 TPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CN0sgZs/Z2c/OuY78K6140lWC88c5VJ5Aa1hxqkyJl0=;
 fh=F0sny4r9Hvu0n452iyAYT8AihxyJ7K8oGAohiXFHCCk=;
 b=AN7XQGvAYiNCYrY8k2MQZa+zSjd9DI7GKjBfVsb5pIEnOrVTDUemFUT40NY/d/0B57
 TgG77JF8P4DRh8UBbDz9/IfBHS+o0Z2Dn71AIbFPaHoSttu24eYXbfdasCYMWs2vDSRI
 kA1Ji+HxTL3EguW8gRpXmV+vRURe0JGN2dZyKKYst6i0U62J9cYMzjdISaUk9DwoR3dt
 QK1EagGy0sOJsGknq0q+/Tju/tKpL6fp0VMN38+wQqHlYpXT0pfWlQ227npHQ4HXK70A
 ZZu31av85SQMC4tRt9iLNojewMNwCopZFIWLPWwRWZkTCc5l3BvkKO65dQ+k0dpGqzYf
 Wcmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782208704; x=1782813504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CN0sgZs/Z2c/OuY78K6140lWC88c5VJ5Aa1hxqkyJl0=;
 b=AYJ2RCQdU0K86O2Gy9En2jUACP9ZH9siR7r7/K//7Nu/zQ78fF6avqSb7BUbhgxmdO
 pxmTpvMpRIq0g/vpMfMUtjfnAGtfNnLM6fdbilRX3i6yKUp3Rlbf0/3qFgK+dAU7rvgf
 8N0HIft5He+7q+ZtaXn2U7V7F4X6KhrmOXXdBYxYDpBnp2TM62jrWmf9xWO2OOqEyaq+
 WaiOPEwSJ9/sauPmo+rw3xvjwuuEa3Kp72W5o1e/tYJqVCYnepRhA9UllG5GBNpdCNCW
 WvIV4je6F9gOnWBhZv8ET8dc26gKTwWwFagYMHswvhVLjsYlNNBZEfhLWhLN6nywHvBf
 sEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782208704; x=1782813504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CN0sgZs/Z2c/OuY78K6140lWC88c5VJ5Aa1hxqkyJl0=;
 b=NsEO4CY59+SVyqqjQK5ThflGZFd/OzOU6Iu7VUtEvGVfbbmSWwxbEpD34FWGTv2bqI
 xjUsDcAtxjy9t8WFywSGWMCufC9T6GG5u0vxjIU21vYMq2ak2NPH3EisugbIpDk+llRM
 6RIADkD3ucCVW0bW+yqM2EpfTsoDJaJgd9rubH3a5uI8OID0NM3COPcKtey3+b+url0b
 AiVpG9HzxRV2Hy6fF7xQfx6DprFa1E7U9UmUnRLyDF+sfR0DOY2yG8AhNIY5cxosf18O
 5nsa+LwABT0gRQeuJRgc44pAKOOIAQ/TW34kL/W0x1bcBgSfxwmOTwrE6X4mr4FoLazV
 n10g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqih4odYQGDap9YbPdP1/tvpT6gTs2tdCXB4voh4bwREKq2lZkMOxE/bmt8R7R/KVpe5DvtlbSy1LI6@nongnu.org
X-Gm-Message-State: AOJu0YzQBl/hCPaN2YkOkqm7MRP5G6IOSRnWWvSbB3w3zKR5vgQaAtEa
 DnXl51mzWXQgmC98x3q0H0dCVBauNKqBN8dfly1cVLnYw3I56XnyrX6x6pS4BXAh19cV5l5viNg
 buzB6HnLJnVw8W/ZpXTAX/qFQSkkM91J4tbWflvGn8g==
X-Gm-Gg: AfdE7cn5fdKUA/Qc5X3h2W6Ic25kvPj5Uxjcfzl3gyL1DxMZdrPoLmKCR7Z1Qc2ObPc
 ETa+6QV2Ebe2maD+vNvegyh6mgeTU97sgATZEaPkomBfdPGjmD1b2/wi7jGFs99AfW7/FLJEW7+
 teO39JxsKfi2bL6SUEKavzaduGgiuvcAGwSt/R456oVyOSNsQMLxucjPqul0Y+k+ovOyPfcVYou
 nRGXVyUA9PMj6QjzXB/QkWZ4OTn6Ifd7gO8FKczRJ99W5J0GV6iqtUO5nbky5qTGYOl5zh81NP+
 N++ix+jafQgHz1bd2MHXygSKzK1Y93ubo4pgCpIHzDR0OFq62Azl3Ya/
X-Received: by 2002:a05:690e:1381:b0:65d:8f98:6bb4 with SMTP id
 956f58d0204a3-6635d72e814mr1093959d50.29.1782208703589; Tue, 23 Jun 2026
 02:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
 <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
 <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
 <9d2737e3-34f0-4f68-813b-37059615bced@oss.qualcomm.com>
In-Reply-To: <9d2737e3-34f0-4f68-813b-37059615bced@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 10:58:11 +0100
X-Gm-Features: AVVi8Cdj2oU9XywSN7RDoPYCoiBarMycYnT8aLCPpsjbBIavMsmU68HA35WyeT4
Message-ID: <CAFEAcA8660BZOmX_KXeF7JJaJwgKO3zSRDEmJURg27FK=tqbZg@mail.gmail.com>
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 23 Jun 2026 at 10:49, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 6/22/2026 6:34 PM, Pierrick Bouvier wrote:
> > On 6/22/2026 2:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 22/6/26 22:52, Pierrick Bouvier wrote:
> >>> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
> >>>> Hello,
> >>>>
> >>>> This series looks scary but it's mostly trivial and mechanical work.
> >>>>
> >>>> It is yet another attempt at fixing --disable-tcg.  We have a recent
> >>>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
> >>>> Phil's work didn't get merged and it's now too hard to rebase and
> >>>> revive, the most recent attempt got misled into the 'what is common =
code
> >>>> between TCG and KVM' dungeon.
> >>
> >>
> >>> It seems like series does not apply on top of master, would that be
> >>> possible to rebase it?
> >>
> >> For some reason the RISC-V series are handled distinctly than the
> >> rest of QEMU, Alistair queues work on his repository and developers
> >> are custome to base their series on top of it (otherwise Alistair
> >> can not apply them on his tree and asks for reposts), see the
> >> riscv-to-apply.next branch on https://github.com/alistair23/qemu.
> >
> > Unfortunately, it makes it hard to run any kind of automated testing,
> > especially for series like this that target specific configs.
>
> Don't we have ways of saying in the commit message "these patches applies
> on top of these other patches" and then the tooling would deal with it?
> I remember patchew doing stuff like that with that "Based-on: <message-id=
>"
> tag.

Yes, Based-on: is our convention for marking "this patchset needs some
other one to be applied first". But that should be the exception rather
than a common case -- if patchsets regularly need to be based on
something other than head-of-git, this is I think a sign that
maintainers are not sending out pull requests frequently enough.

I would prefer it if QEMU didn't develop kernel-style "subsystems
have their own particular workflows" fragmentation -- I don't
think we're big enough or that sub-parts of QEMU are sufficiently
well separated for it to work out well.

thanks
-- PMM

