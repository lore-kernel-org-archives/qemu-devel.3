Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6C7CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGTji-0007qf-3h; Tue, 13 Oct 2026 00:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGTjf-0007q9-Jg
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 00:03:31 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGTjc-0008Ll-DO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 00:03:30 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso2869712a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 21:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791864206; cv=none;
 d=google.com; s=arc-20260327;
 b=hClMqxiOQPNkU+NJ0TUs93fpckD9i4yLPP3I2WD4P63EYPxotAb+gSI0Ils2tAK8w0
 vAXh9G2pQP1kX09QHNwcUj10aTR5emVkvB23Y5dLuxfpiQfcY4kGpT1K54UpFYdcx1pg
 Md7s+24DiT/PtMk9zi7ddY9PFsbd5/SRS6OQFjOjKyBQ4cQ5WiSIJMKwQ5zdm++JAGgs
 gKIXC59uIJrR+UbHKTL2wH4WSoCh7dFHS62fwpPu6c5dwvyhz8ZzFDJ+5xEfmjo6+Qll
 V+pdAvc8NH3PrYZvy+3axI28PgwekE428aGUtnRhOhTtfBrVhzcClfwTM1QvUzkPiz32
 NVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=hGJYbaGu+cCzQrPsnI0c9EENhMDFFGQ36XoIzvnK+UE=;
 fh=1+Uc/F6C/Eh7l5RDLZ0D1fa/8Xv3ib+DBeU3qcrQU+E=;
 b=qe0GW0iL0dCC9+ffwOTe3WM7Sfr86eVkNAS1D/dY6UNBNKYc0Zyp3izB46T4QA6rHJ
 MneJdtBU7KfHR8eiu2bwqlcRwX5F7bm7NwSevngwHU7Tca39KwLqp282kst1jnEFMCSD
 Irh3fyhiBTR7jPE98qT/MgKgxuTfQoGZe+srUxXUgiM6QcXHErVeod8DCshdz+cJboEo
 SnXvJeL+9FqbBXdiqx4tYEL39QZGBq+2eCJD/gZZbRbR+0yZg6DOEUtrgReznOriakqf
 NCaYTGi6wBCcfxmwsexZ9Q83gyj9M4Qh4xZ2vUL5L1gSt3QepcDpraIfC8SabiT2jtWK
 uFLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791864206; x=1792469006; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hGJYbaGu+cCzQrPsnI0c9EENhMDFFGQ36XoIzvnK+UE=;
 b=s92P2EnQ694uZx/eRYzPwaOXrTedRq3WFtYpKyE/lORGF6Ia+XrlLO6Fcj7HaUHuoa
 q1MA1b0cGEeAwhRaXv2Q0T38J1CxaIjf7Ja0rynhfFhH6p0oqvrF71xzG5Uq5aZZT4tI
 ISS/ZWqZv+Ka1mCWvVf0U2dcvTQBHhaUK1+HWCxktodvWdHeb/rW2siH9U7QzoCrwjIx
 Gr6bHfpEHzkbatH56w/MSty22OV/fR1S5dbpwqb0DmV6jP/GT+hM703E/+SaB6NeTlDK
 lKNcxcWoYA9oQEliN0JqayG7u0S5LYoWG1M2GM5IxklAP+gml3drX9/2xF4eBz2nGvk8
 RX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791864206; x=1792469006;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hGJYbaGu+cCzQrPsnI0c9EENhMDFFGQ36XoIzvnK+UE=;
 b=NJbllOaAT8ovp+hC5BHbqwA5oXv9/kuqkS7glBWLENGzcjUYMdyqzX4MsViiCH4l3V
 HuVdp+O6DYyRKuWYs8OULaS/Xukb1oOeaOR/ANkOiAalhxmDH7K/LMzV9Vwrt+XbDaQb
 WgunvGlRz0NrxAQPBnGh2LlotqqAxIJA92Ml3xLj0NN90MswuTTHQAyCmVC/q71omOVq
 /kdBipN6EuGV5WkPRSFa8z0eL2xsbjziR+Qly+zKX5u1e98rVZHU2AigE/TrYHN4/ggQ
 u9UGC9z5jgzdemAZArZfe90egRfiRiY70M08l3fPOYtcB698G+FVQ2KnSraGOGYXLwPG
 FZzg==
X-Forwarded-Encrypted: i=1;
 AKwUvByfdURRnuKxApoJCf3yV8bate3Ao21hRGJRWr02dFuR0gt+rfF5I/VhhPmLr6dPT3YJ/zkQBR6SO+Pa@nongnu.org
X-Gm-Message-State: AFq9FYJ30XAWTCTFu3+y/bDfxzCxu+4+TztKRYHiJIp/aazhFP5UPnC6
 Cyf4LKni/xmzcJ1jDPImdtPwIpuvOgAJcb2qghUDanxDNOJvRRWKdXwVjbvG2ALMt+J/92Ntyx1
 gImCwb+KxfwkGhbV5r+A8fcKa/YydvAQ=
X-Gm-Gg: AYBFou1PnAHP7JhAVZnbq+klOPi5t397w1jnQjrmaIQq7boLjr+gWhnIgLx76FQl20N
 EtJXiUm7/IZ2sKsgOasQaR/SQBY3fUAv37f8qvFaGY7ieqRkr6CsNd38ONtaoW7cAdrsUxW2CNq
 nzKKgBXVRg6oAwjolRkCFxjz702JPHRnDFH7YlqGGbzPaMSr4KEdopAe7teLPWp/UPbxWx/aa9I
 ylhcEYsjwON5OQMRqc6AWVALnnMWb+9JeaaPhQKHQtGxnvyjUXLRPXDCX+hNlqYd73swNgaDArP
 3XMO32m0GG5XN0Ew3GHhHPAPSiK9JzHoL6s/ErCjKp5EL8gweJT5w34=
X-Received: by 2002:a05:6402:4489:b0:6b1:ef6b:f3e4 with SMTP id
 4fb4d7f45d1cf-6b1ef6c008bmr274714a12.14.1791864205500; Mon, 12 Oct 2026
 21:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
 <asdlbOZBSYIaCMIh@redhat.com>
 <CAE2XoE91XxoJRFpQ_1jhmX6LdxMyN16CF7RXxM62C5Ctkc1tig@mail.gmail.com>
 <42fd67c0-c20d-4bc4-bede-79073e4be4a1@oss.qualcomm.com>
 <CAE2XoE-gN5-vmE8r00Ds_Z=E1WePSFi_MJXjmy9ZuXEU_=o31g@mail.gmail.com>
 <3034c146-0697-4db7-acd4-8076b317a09e@oss.qualcomm.com>
 <CAE2XoE-gCTrpEeCROz9JMpPnTQXQ+AnBTR4RwdQhYizkExjK9w@mail.gmail.com>
 <8cb24445-b659-4bd4-9497-888ce152e82d@oss.qualcomm.com>
 <1a477877-516a-41b8-8548-598bfad74f25@oss.qualcomm.com>
 <CAE2XoE_MotPuxBBkLFWmcDf6ACva2r7y-7sRbQ3DNNwZvXcJFQ@mail.gmail.com>
 <ae0dcb2d-1488-4cea-8bc0-2a0cb2cd74be@oss.qualcomm.com>
 <CAE2XoE9B8RXg6=6kofVA=d6C5OBXT9GZ2cPceWUUDa4m9=_fRg@mail.gmail.com>
 <bfa70b6e-fc66-4607-bd45-b55ae2951d57@oss.qualcomm.com>
In-Reply-To: <bfa70b6e-fc66-4607-bd45-b55ae2951d57@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 13 Oct 2026 12:03:11 +0800
X-Gm-Features: AclHuK85NEW-X_1qjebNgB1T24kIfLBw6QOaZ-0B3KS5zgoFrwUZT-R_Ia0R27I
Message-ID: <CAE2XoE-9w1-3-kFvWXdZZz=sc-Eor3goUr09vANbaqyNrtJGdg@mail.gmail.com>
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 13, 2026 at 11:53=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/12/26 7:43 PM, Yonggang Luo wrote:
> > On Tue, Oct 13, 2026 at 9:26=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/11/26 9:26 PM, Yonggang Luo wrote:
> >>> On Mon, Oct 12, 2026 at 10:25=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/11/26 7:13 PM, Pierrick Bouvier wrote:
> >>>>> On 10/11/26 1:22 PM, Yonggang Luo wrote:
> >>>>>> On Fri, Oct 9, 2026 at 2:34=E2=80=AFAM Pierrick Bouvier
> >>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>
> >>>>>>> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
> >>>>>>>> On Fri, Oct 9, 2026 at 12:06=E2=80=AFAM Pierrick Bouvier
> >>>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
> >>>>>>>>>> On Thu, Oct 8, 2026 at 5:42=E2=80=AFPM Daniel P. Berrang=C3=A9=
 <berrange@redhat.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wr=
ote:
> >>>>>>>>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> >>>>>>>>>>>>> This allows a combined binary to register machine types fro=
m all its targets.
> >>>>>>>>>>>>> Consequently, QMP `query-machines` can return machine entri=
es from every
> >>>>>>>>>>>>> target, even when `none` is selected. For example, a client=
 can query the
> >>>>>>>>>>>>> combined machine list with:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> ```json
> >>>>>>>>>>>>> { "execute": "query-machines" }
> >>>>>>>>>>>>> ```
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The returned list includes the registered machine classes f=
rom all linked
> >>>>>>>>>>>>> targets. This is separate from selecting a machine: with `-=
target none`,
> >>>>>>>>>>>>> `-M virt` reports the targets that provide `virt` instead o=
f choosing one
> >>>>>>>>>>>>> arbitrarily:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> ```text
> >>>>>>>>>>>>> qemu-system -target none -M virt
> >>>>>>>>>>>>> unsupported machine type: "virt" for target "none"
> >>>>>>>>>>>>> Available for targets:
> >>>>>>>>>>>>>       aarch64
> >>>>>>>>>>>>>       arm
> >>>>>>>>>>>>> ```
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>     From the long conversation on a previous thread, I thoug=
ht we reached
> >>>>>>>>>>>> the conclusion that if we didn't expose any ambiguous name, =
then -target
> >>>>>>>>>>>> option is unnecessary, or maybe I got lost on track of this =
thread.
> >>>>>>>>>>>>
> >>>>>>>>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.c=
om/
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'm not sure which semantic we want to have with -target non=
e. If there
> >>>>>>>>>>>> is no ambiguous name registered, we just don't need it at al=
l. It's a
> >>>>>>>>>>>> win-win IMHO.
> >>>>>>>>>>>
> >>>>>>>>>>> Yes, if we expose unique names for every machine, then -targe=
t is then
> >>>>>>>>>>> redundant.
> >>>>>>>>>>
> >>>>>>>>>> so how to diff riscv32-virt and risv64-virt? oh so for this ma=
chine we
> >>>>>>>>>> needs two name?
> >>>>>>>>>> "virt" needs register twice for it? or register only a single =
time,
> >>>>>>>>>> but we prefix the target_name()
> >>>>>>>>>> automatically? for example machine::name =3D=3D=3D "virt", but=
 we can use
> >>>>>>>>>> "riscv32-virt" "risv64-virt" to reach it?
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Yes, ideally we should have different variant of virt for 32/64=
 bit.
> >>>>>>>>> Same goes for cpu max types.
> >>>>>>>>>
> >>>>>>>>> QOM type is always registered unambiguously ("$arch-virt"). The=
n, for
> >>>>>>>>> the "alias" name, which is virt, in case multiple matches are f=
ound,
> >>>>>>>>> command line can return an error with list of unambiguous names=
 to call it.
> >>>>>>>>>
> >>>>>>>>> $ qemu-system -M virt
> >>>>>>>>> Multiple virt machines are available. Please choose one of them=
:
> >>>>>>>>> - aarch64-virt
> >>>>>>>>> - riscv64-virt
> >>>>>>>>>
> >>>>>>>>> There is no "parsing" of the argument, it's just the real QOM t=
ype. Then
> >>>>>>>>> we can find which target it implements from mc->targets.
> >>>>>>>>> And then, we can automatically choose which cpus should be avai=
lable
> >>>>>>>>> based on that, thanks to cpu->targets.
> >>>>>>>>>
> >>>>>>>>> For existing binaries, nothing change.
> >>>>>>>>
> >>>>>>>> Good, I think we found a clean way now, is_available should be
> >>>>>>>> removed, and TypeInfo::targets and TypeImpl::targets should be a=
dded.
> >>>>>>>
> >>>>>>> It goes into MachineClass only for now.
> >>>>>>>
> >>>>>>>> I think
> >>>>>>>> for "virt" we can add a shared hw/machine-virt.c instead, and fo=
rwarding to
> >>>>>>>> the $arch specific virt. so that we only have a single "virt" re=
gistered.
> >>>>>>>> And it's
> >>>>>>>> targets is
> >>>>>>>> QEMU_ARCH_I386 |
> >>>>>>>> QEMU_ARCH_ARM |
> >>>>>>>> QEMU_ARCH_RISCV |
> >>>>>>>> QEMU_ARCH_LOONGARCH |
> >>>>>>>> QEMU_ARCH_M68K |
> >>>>>>>> QEMU_ARCH_OR1K |
> >>>>>>>> QEMU_ARCH_XTENSA |
> >>>>>>>> QEMU_ARCH_HEXAGON
> >>>>>>>>
> >>>>>>>> So that we won't have a list of conflict QOM names for "virt" ma=
chines.
> >>>>>>>> As now we indeed have only a single "virt" machine that redirect=
s to
> >>>>>>>> different targets.
> >>>>>>>>
> >>>>>>>
> >>>>>>> The idea looks appealing, but I don't think it solves the problem=
 to
> >>>>>>> have multiple virt variants available at the same time.
> >>>>>>>
> >>>>>>> The "alias" idea you introduced before is good, we just need to a=
dd a
> >>>>>>> check if an alias is really unique, else return an error, as expl=
ained
> >>>>>>> previously.
> >>>>>>>
> >>>>>>> If "-M aarch64-virt" works for both the new and existing binary, =
and -M
> >>>>>>> virt only for existing binaries (and ambiguous for new one), I th=
ink
> >>>>>>> that's a safe approach.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> For other types also conflict can be handled in the same way, su=
ch as
> >>>>>>>> "-cpu host" "-cpu max"
> >>>>>>>> maybe others, but I think they all have the same way to deal wit=
h.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> That's why  TypeInfo::targets and TypeImpl::targets better than =
sole
> >>>>>>>> Machine::targets
> >>>>>>>>
> >>>>>>>
> >>>>>>> One step at a time.
> >>>>>>> Let's keep focused on declaring targets for a single machine firs=
t.
> >>>>>>> Then we can iterate to solve the "virt" problem.
> >>>>>>> Then convert all the existing machines and add a check in machine=
-target.c
> >>>>>>> Then, and only then, we can see what happens with cpus.
> >>>>>>
> >>>>>> I tried this idea, but I faced a fatal error, because the
> >>>>>> target_info() is not available until
> >>>>>> the machine selected(the target arch will be select just along wit=
h
> >>>>>> the machine selected), so basically
> >>>>>> all calls to target_info() would raise an error(null pointer), how=
 to
> >>>>>> deal with it?
> >>>>>>
> >>>>>
> >>>>> I see. Indeed, since we can't set a target before registering all t=
ypes,
> >>>>> it implies that all the types class_init can't use target_* functio=
ns.
> >>>>>
> >>>>>
> >>>>> - register_accel_target_type
> >>>>> - cpu_max_v8_register_type
> >>>>>
> >>>>
> >>>> Sorry, mail sent to early.
> >>>>
> >>>> For the is_available callback usage, it should be easy to do the swi=
tch,
> >>>> since it's basically the same information that what we are trying to=
 do
> >>>> - we can leave them for now.
> >>>>
> >>>> Some types (like accel and max mentioned above), explicitly change t=
heir
> >>>> definition depending on the target. It's a behavior we can't rely on
> >>>> anymore, and it means we need proper distinct types instead of a sin=
gle
> >>>> one with dynamic definition driven by target-info.
> >>>>
> >>>> I think that's the preliminary work needed, before being able to go
> >>>> further: convert all existing usage in class_init with distinct type=
s +
> >>>> is_available, and then we can do the switch from is_available to the=
 new
> >>>> .targets approach.
> >>>
> >>> Hi Pierrick,
> >>> I have already tried that introducing new QOM names just to make clas=
s_init
> >>>    target-independent is too broad(means all usage of it should be ha=
ndled)
> >>> and could complicate compatibility(changed too much code).
> >>> Can we avoid new names by some new means(ideas welcome)?
> >>>
> >>
> >> As a first step, I don't think we need new names, is_available can be
> >> used to selectively register one definition or another and avoid any
> >> clash. What is missing at the moment though, is that some types (like
> >> cpu max above) change their definition based on target definition.
> >
> >
> >>
> >> So for cpu max, we would have two distinct types, both named max, but
> >> one with is_available(target_arm), and other one with
> >> is_available(target_aarch64), so they are never registered at the same=
 time.
> >
> >>
> >> Same for virt machines. It's already what we have, duplication is
> >> handled at the moment with distinct is_available callbacks.
> >>
> >> Then, see below.
> >>
> >>>
> >>>>
> >>>> It's probably worth having the conversion in its own series (only
> >>>> cleanup usage of target_* in class_init), before trying to get rid o=
f
> >>>> is_available.
> >>>
> >>>>
> >>>> For the implementation, you can use the multi-targets.c binary test =
to
> >>>> drive the change. Remove the module init for target info (leaving no
> >>>> target set), and add a hacky patch to skip call to is_available (and
> >>>> return true instead) and allow double definition (which will rely on
> >>>> is_available). Then, fix all the segfault. Once it compiles and runs=
,
> >>>> only double definition will be left, which can be handled by inserti=
ng
> >>>> the right is_available callbacks. Then in a subsequent series, the
> >>>> switch to .targets can be made.
> >>>
> >>>
> >>> Still have no clean clue about how to remove is_available , as we hav=
e many
> >>> "virt" machines. Do you means all "virt" machines with "virt-machine"=
 QOM names
> >>> are inserted to the table? How to get it working because the "key" is=
 string.
> >>>
> >>
> >> Once we have type definition which only depends on is_available, we ca=
n
> >> convert this to .targets, which would contain the same information.
> >> For the rest, I have some ideas, but I would like first we do the firs=
t
> >> part (convert to is_available), which is already a huge work in itself=
,
> >> and a series of its own.
> >
> > Indeed I am confused .targets only exists on Machine, how is it
> > related to -cpu host -cpu max?
> >
>
> We can introduce cpu.targets after machine.targets.
> First step is just to get something that works with is_available and
> does not require any target info to be set.

Feels weird, what's wrong with this method:
 target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 65f851f2006..d7323ab431c 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
 #endif
 }

+static void max_v8_tcg_initfn(Object *obj)
+{
+    if (target_aarch64()) {
+        aarch64_max_v8_tcg_initfn(obj);
+    } else {
+        aarch32_max_v8_tcg_initfn(obj);
+    }
+}
+
 static void cpu_max_v8_register_type(void)
 {
-    static const ARMCPUInfo max_v8[2] =3D {
-        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_initfn },
-        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_initfn },
+    static const ARMCPUInfo max_v8 =3D {
+        .name =3D "max-v8",
+        .initfn =3D max_v8_tcg_initfn,
     };
-    arm_cpu_register(&max_v8[target_aarch64()]);
+    arm_cpu_register(&max_v8);
 }
 type_init(cpu_max_v8_register_type)


>
> >
> > I already have a working copy that does not depend on target_info()
> > and selects target_info() when the machine
> > is selected, no QOM name introduced. only for machines, we will have
> > $target_name-$machine_name as a name for selecting
> > the exact machine.
> >
> > The cpu max cpu host is dealt by moving the choose code out of
> > class_init, into object_init. I really did not get your idea by use
> > is_avaiable. because when I try to get all QOMs to be registered. then
> > I won't call is_available at all.
>
> As a first step, we rely on is_available, to work on distinguishing
> proper types per target and break the dependency of multiple class_init
> to target_info. Then, we can replace is_available with .targets.
>
> > because "is_available" depends on target_info(),(we won't have
> > target_info() till the machine is selected).
> >
>
> We can imagine registering types in different buckets per target, which
> would allow for duplication.


So your idea is multiple hash-tables for QOM types? key is the target_arch?

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

