Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E8DC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 04:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWqFS-0001cP-Of; Sun, 04 Feb 2024 23:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWqFK-0001Wj-Hv; Sun, 04 Feb 2024 23:06:15 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWqFF-0000er-8y; Sun, 04 Feb 2024 23:06:14 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4c021a73febso210308e0c.2; 
 Sun, 04 Feb 2024 20:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707105967; x=1707710767; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJIl3R1YvulEQPprrGTaMHTYgQBIuMEMWnv83UZpR1c=;
 b=IlTrW8SBShSYuL5zspYftjtKmYmhvZU7YFdYVo5ZIaUcOuskj62iFzCT0bX4B9v+Pc
 usPMToApbKbr9znWqdDWyTdUMzsfYtKE2/Z35DKS+jW7yyt/9PaZ1/BG7BiwTajKzANA
 nmMGoOstIjWLV1J5o5mdHTokXtwr0MNT0TpAMnZvm9AnK8CbjK7qKWkzzi4l5MleDeP3
 MFXVCye9ymO9tPBd+2ByorPa4MUtPNz92gBC3HePt2cklrBhrrNKCkO3wuC00ewFXeab
 nWaDHHSiWu1wgtaSeZFc7+ZYwjBw87zw43OmzRgFroI37pNHZGvRSGma9k3CBTCrFyRE
 4rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707105967; x=1707710767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJIl3R1YvulEQPprrGTaMHTYgQBIuMEMWnv83UZpR1c=;
 b=CdUPVruawdRbXVyFBkAEqalI2e3txwi6UuOH34PepZQ2RxZxk+fSS9KH24TnhQD1w8
 voPsw/JiNhWCG+8SFvob755zRtRJf/YENGnCKc3S5zjnEs8F0mduvdKhMFrXDxQfr8Wo
 siYlVQImgGVy4RHb28ZCu29P+sxamQOj38DwI7vRFRrmFyNuxUh0C0Gnrl3D/JmocatC
 dq2DSnI+aXhYgCY90ptiGhGvku/wYo1YgI+NFVNiKACg8WlHl/bzBn50uP6H7eucLCku
 I4/e1NmpRBcPEK7QsiqQ9DMhcxeJl9Qe5BWowQ2UdYQ097VuFYMmvaOwS/qgFqx/Pe4G
 K4tQ==
X-Gm-Message-State: AOJu0Yx0/4tjJNWtFRFzCE/XemR0nF2e0aT64HZLRqek3jUlhjDqpnzR
 q3VIg8kYs+MarSDZcRDqBA51NJPAsuM1A3TCbtBgQ0D+23z48zczWH+7kmGvpNidxLSXeR5cC+h
 qbHPhlBa6pNA9SeH48gISXzIa7IU=
X-Google-Smtp-Source: AGHT+IFFv8IUGKNbaQcu3PlX8GiADzlZIHB/XBu7BttG+2n2mjM/hl7jYwUjt0HmFDZSoOQL/ThGtN9CqJpdpsy5+2A=
X-Received: by 2002:a05:6122:2a0d:b0:4b6:be94:acc6 with SMTP id
 fw13-20020a0561222a0d00b004b6be94acc6mr12990001vkb.10.1707105966650; Sun, 04
 Feb 2024 20:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
 <e2763db2-fade-482d-b433-1bfce6acf7d3@ventanamicro.com>
 <CAKmqyKOA6OtixYoMJ_qtXj_u0t6rMdHawg0VEvq3-=mK4q6_XQ@mail.gmail.com>
 <3c091744cd4bafeb7c1d177455fa9789822e7209.camel@rivosinc.com>
 <CAKmqyKPkjBBo-2EAL25-3qACSv4c4naGT8V-F5e5as4D=WVa9g@mail.gmail.com>
 <20240122-29d7d206e9ea3ecd46fad930@orel>
In-Reply-To: <20240122-29d7d206e9ea3ecd46fad930@orel>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 14:05:40 +1000
Message-ID: <CAKmqyKPibo3wp8mPu2+W5aGaxsPx3Ko2pcotv1H2Ddj6uhZDiw@mail.gmail.com>
Subject: Re: Re: [PATCH 0/2] Export debug triggers as an extension
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Rob Bradford <rbradford@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Himanshu Chauhan <hchauhan@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 22, 2024 at 7:16=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Mon, Jan 22, 2024 at 03:42:10PM +1000, Alistair Francis wrote:
> > > > From memory the "debug" property is for the original debug spec:
> > > > https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_v=
ote
> > > >
> > > > That was ratified and is an official extension. AFAIK this is what =
is
> > > > in physical hardware as well.
> > > >
> > > > The actual PDF says draft though, I'm not sure what's going on ther=
e.
> > > >
> > > > The debug spec doesn't have a Z* name, so it's just "debug", at lea=
st
> > > > AFAIK.
> > > >
> > > > "sdtrig" seems to be a new backwards-incompatible extension doing
> > > > basically the same thing. What a mess
> ...
> > >
> > > I've done a bit of digging and I agree things are quite messy. Here a=
re
> > > my discoveries:
> > >
> > > The debug option and the code for triggers was added in these commits=
:
> > >
> > > c9711bd778 target/riscv: cpu: Enable native debug feature
> > > 38b4e781a4 target/riscv: machine: Add debug state description
> > > b6092544fc target/riscv: csr: Hook debug CSR read/write
> > > 1acdb3b013 target/riscv: cpu: Add a config option for native debug
> > > 95799e36c1 target/riscv: Add initial support for the Sdtrig extension
> > >
> > > In March 2022 - since the commit refers to the Sdtrig extension name
> > > and from the date this was an implementation not of the ratified 0.13
> > > debug spec (which did not have Sdtrig as a separate extension) but
> > > rather a version of the in development 1.0 debug spec.
> >
> > Yeah... We used the "stable" from master. That is our mistake there.
> >
> > I'm pretty sure we targeted the 0.13. The "Sdtrig" was only added in
> > the v4 as the changelog says: "mention Sdtrig extension in the commit"
> >
> > >
> > > It's not trivial to tell if it's closer to the ratified 0.13 version =
or
> > > the (hopefully soon to be frozen) 1.0 version.
> > >
> > > As the only part of the debug specification to be implemented is the
> > > triggers then effectively the debug option is x-sdtrig.
> > >
> > > I don't think there is any way for code running on the machine to
> > > identify what version of the debug is implemented - the appropriate
> > > register is only available for external debug. Once 1.0 is frozen the=
n
> > > the presence of Sdtrig isa string would indicate 1.0 trigger support =
is
> > > available.
> > >
> > > According to JIRA - https://jira.riscv.org/browse/RVS-981 the debug
> > > specification should freeze this month.
> > >
> > > How about considering this as a solution:
> > >
> > > - Add a new x-sdtrig option that defaults to false
> > > - Deprecate debug option - but retain it with default on
> >
> > We can't deprecate a ratified spec. The 0.13 just seems to call it
> > "debug" so that's what we are stuck with
> >
> > > - Add warning if triggers are used and x-sdtrig is not enabled
> > > - Update the trigger implementation to match frozen spec
> >
> > We will need to support two versions, as there are two ratified specs.
> >
>
> We'll likely want to be allowed to deprecate ratified extensions as riscv
> evolves. Despite best intentions, extensions may be designed and ratified
> which ultimately fail to be of much utility, and new extensions will
> supersede old extensions. If QEMU keeps every extension it adds, then
> we'll slow progress on new extensions by maintaining old extension code.
> The old extensions will also bitrot or waste CI resources getting tested
> for no reason.

I agree that we might need to deprecate extensions.

I'm not sure the debug extension is there though. The debug extension
is used in current shipping hardware and has been ratified. The Sdtrig
isn't even ratified yet
(https://lists.riscv.org/g/tech-announce/message/320)

Right now I feel that we should at least wait for hardware that
supports Sdtrig to start to come out. Then we can look at deprecating
debug. Deprecating it now seems a bit premature.

Alistair

>
> I don't know the history of 'debug' and 'sdtrig', other than what I've
> read above, but, to me, it looks like 'debug' might be one of the first
> extensions which should be deprecated. Assuming we have a long enough
> deprecation period, then I think it's always safe to attempt a
> deprecation. If somebody shouts, then it can always be taken back off the
> chopping block.
>
> Thanks,
> drew
>

