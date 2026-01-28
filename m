Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B3ED46BE0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 17:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl9ef-0001C0-0V; Wed, 28 Jan 2026 12:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl9eY-00019n-MM
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:48:31 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl9eW-0001iP-Sb
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:48:30 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-435903c4040so114661f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 09:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769622507; x=1770227307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bj5ufOGr/9lEHh2xwuGdrDse0fcL/BvnanZmIrsO+rg=;
 b=Dy0km1IDq0O81ntQ3cLsE3wN648ht+iySK6Qj6sH6sXASYIlP277SxKAlbNfW0bDC2
 TU7e1PcTgyVPS4Br2DOUkJVA67SOd0tZ73IEs//IuwEhGGnvaSRZw04pA6XrusxFqYJK
 i4JuiJmkUr9LWV3pJYK3vJT+LDtANqKQq1tunPwDc90Jsd/mLGbtc2pD42wzKMAWhXuj
 FUSA+rxx4s6bhR/6lkCQYrfNvC8PFwTUnyqFbVDt5R4Rvxt+3/FZOXhH3DLapmW2Uzuh
 Epan2PweyZPgynCfv9/KkwkwYC6qzNwQOxBj/2xFyaurv4yAPZJqlubGP4tKh5XWXYcX
 dkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769622507; x=1770227307;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bj5ufOGr/9lEHh2xwuGdrDse0fcL/BvnanZmIrsO+rg=;
 b=XrtqQwrt79c7STrAjLHS3ajAsH5g5Suy/uxekarrpJeyurgZBsIO+SvubysRZMhZet
 cuTc5iUm10j10QvV9xOJLAeTF6jOCl6wNkxxrAGw+Xs5x33LEaXBFESBn2mDZGpCW37M
 e3JRPT4fwLtv3VTM78uXfs3QMTdH5r3uIgEq7LYwE9HRUT0fgZtZFw08gzETwFwgPssA
 vyD2/N3SLP9MSP5ytHgG2KRp3dZkC40DH3O6r/rcqUhRR7iT1XvOEmjDI8dnAAa389D/
 9XqpsI60fBflpMQpzK4lQFvzklZmVd2nGTx2lx66VLPX6RTe9eG2vwVGPrljut4InPe7
 PwAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT7UQdVxb/2d7vps94vG9Yhle4wQRT3QCJ5wJpVLC81hFFRc1yFv12v7fX0e3ym6UqkT5bjtY60/qI@nongnu.org
X-Gm-Message-State: AOJu0Yx1+iV8ifUe5WBsOh4X4IpqKqSF3xS9MbXNye77CA+OK+59++Um
 dqOPwEBJ2CLgvRJAt2GlwdJWjGIQukZbgnTNxBcz3tpRRbykBjaYUMl0COnavWtRHAc=
X-Gm-Gg: AZuq6aKZzQRDgdN0DaFBDkj3lCtAespXFfF/FF0nt066s3Ur4DWgr2RmR4khcWY6rgZ
 Tk5+k7UwJKE+H3CnTEqPCCne9qdfVhpGl8ZPid+btYHE2ViT0Ng80mxQnsUVk0i2iTpKwVJQ1+N
 XE1ZHBmQ2dJfMNASgyzWiYYqXYbdnFVrkKVZrTEq6VYSF2ZpMD3r6I0wsPnTFbHOqg56mcj1Ac0
 P9GeLtdt4iFBcTh+M6DwHFnQg/TY09EdwTP4B5I/d54ef8Fs/rS4Uhhj8WVLKJRuGGnuc7Yk40M
 oK8zqoMJ95fnU1v+6xCzPr5tOUjJ7fmTqv8R2lGJeX4r+UmvmHr5cJJ7dzQpKVP8K1kpPh8k2b0
 X13fcrC7OzJBGc+lrjHzsQk+QWjkBdblqAjLi+f7oXPdsiZ5FKtOkIDrsIxQbwSa339cc/tvOMq
 whi1JI7riGqR7V3i7fvIshdw==
X-Received: by 2002:a05:6000:2081:b0:432:dfa8:e1b6 with SMTP id
 ffacd0b85a97d-435dd0b6a75mr9548688f8f.39.1769622506629; 
 Wed, 28 Jan 2026 09:48:26 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfd4sm8218361f8f.25.2026.01.28.09.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:48:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3D155F895;
 Wed, 28 Jan 2026 17:48:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com,  takahiro.nakata.wr@renesas.com,  "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>,  Ruslan_Ruslichenko@epam.com
Subject: Re: [PATCH 00/27] hw/arm: Add generic FDT-based machine and
 infrastructure
In-Reply-To: <CAN-aV1EjYwSRfV87YQdtfqU5CH8Bsssr3EvStPWL2_VFOs4N4w@mail.gmail.com>
 (Ruslan Ruslichenko's message of "Tue, 27 Jan 2026 19:18:10 +0100")
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
 <CAN-aV1EjYwSRfV87YQdtfqU5CH8Bsssr3EvStPWL2_VFOs4N4w@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 28 Jan 2026 17:48:24 +0000
Message-ID: <87ecn9aas7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:

> On Tue, Jan 27, 2026 at 11:03=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
>>
>> On Mon, 26 Jan 2026 at 17:43, Ruslan Ruslichenko
>> <ruslichenko.r@gmail.com> wrote:
>> >
>> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>> >
>> > This patch series introduces new ARM machine model, arm-generic-fdt, a=
nd the underlying infrastructure required to instantiate a QEMU machine fro=
m a Device Tree.
>>
>> I'm afraid this has been a feature that has been suggested from
>> time to time, but which I don't think is workable in general.
>>
>> Device tree files are designed to provide enough information to
>> the guest kernel to allow it to find non-probeable hardware. They
>> are not designed to provide enough information to QEMU to allow
>> it to create and wire up all the hardware present on the system.
>>
>> There are specific niches where it can be made to work -- I think
>> Xilinx have or had a setup where they were generating an FPGA
>> model and a device tree and a guest kernel all from the same
>> single data source, so they could put everything necessary into
>> the dtb, for example -- but I don't think it works in the
>> general case. As one simple example, the DTB doesn't generally
>> have any information about how the Secure world works in an Arm
>> system, because Linux doesn't care about the Secure world. It
>> also doesn't usually have information that the guest OS can
>> probe for itself at runtime.
>>
>> There has been periodic discussion of more flexible user-driven
>> board creation, but that has generally been with the idea of using
>> the QMP monitor to orchestrate creation and connection of device
>> models.
>>
> I agree that a guest Device Tree is insufficient for describing a
> complete QEMU machine model.
> However, we separate the guest configuration from the machine
> definition. The -hw-dtb option allows the user to provide a
> QEMU-specific system description.
> Those hw-dtb would not be passed to Linux Guest VM.
>
> The fact that this workflow has been successfully used in production
> by AMD/Xilinx demonstrates that FDT is a feasible format.

Where are the extensions to the FDT used for hw-dtb documented? How does
it deal with PCI devices and the Secure world?

> In contrast, QMP usage may end up even more complex and less
> maintainable for the task of full system modeling.
> To my understanding, this would need to generate too long configs,
> which may eventually require some intermediate format by itself.
>
> I am proposing to use FDT as a serialization format to describe a
> machine configuration. Theoretically we can use other formats, like
> XML, but in my opinion FDT perfectly matches the requirements.

The QMP interface is self-documenting and introspectable and used for
the management of QEMU including things like hotplug. It is also QOM
aware so a natural fit for dealing with the underlying QOM machinery.

Previous discussions have entertained the idea of making the parsing of
hw-dtb an external script which would then translate into QMP commands
to build up the machine.

>
> BR,
> Ruslan Ruslichenko
>
>
>> thanks
>> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

