Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB6ACA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7cN-0002ht-Vd; Mon, 12 Oct 2026 00:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xG7cJ-0002gy-6l
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:26:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xG7cG-0002Du-JM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:26:26 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso2361276a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791779182; cv=none;
 d=google.com; s=arc-20260327;
 b=TqoJBg79oINisMG54G6HmkyJg51Omtpp2pcCgMA5yyAPYK6zhoCNBHAKYOHbCOhqQ4
 O4yS8pTMZ8XuY/Y6rUlhZzZPk3MczQf56Qe31FUUG0dlFrffHo5blmHWkcjHhSUkVL13
 eKcC9kMUptzIOlAprL8Y1bUH3ft7p8bxZQ9i3w0gCInMloLdpRAthPMFu0exvqdIwEFM
 a2FEirQiFSIzMfyFemOsYVbSLE/+/TqRAFDT8BSLFPuk4KPGByts2HPsMiQae7LqhR43
 DGP1e433IdMgOkiG+BTQNXOZ+L/01+4rKqpJkUwFQCqlkQMsk7Cukc4nbfJOlW/0h/Gz
 gppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=tZocVQ6Rzh5SBuw1zPlgeJ0k0sYL5o3kj7hYBaiFxTs=;
 fh=dH4Um8MsQB5IHjzPOsOu+4squnl93PS6zGkiRVQW9Oo=;
 b=o5fpV6u75rPWGbNuQeoM3lXSTCIvcPRR+mC/Uh40NigwzCcdPbf7AykhfauhOlvX8V
 xT8Q/kVk5RK06TUfmCLO3uqc1N/3PZ3+dBwG5+gk4LRjvTzH1qJUuLYHo6q088YdaT/y
 8v6M4n1p2QwbB4F9TKlPT6Gs0BZPEBC2uWyi6IKgCYTaJjZEmZrFPsx0wdBzej4fxiu7
 9Y/AdhU4aCZuRub27USfEzC7Ek6vJxV6Se+chOzAmyHCupCV34IZq8T3YwwR30g63vDm
 p+P4bAuiSG1kfuIlJsGqm0rxhKTsBs4Fd+yaEENXSWPZkDqHLt3bjWKCRscAhy8xih6t
 jDcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791779182; x=1792383982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tZocVQ6Rzh5SBuw1zPlgeJ0k0sYL5o3kj7hYBaiFxTs=;
 b=jpkK8KfWRG0Xv3ND6QIFj27G3q9ab8UHEJurmPQmGbLeZcqEsdmPLW/KNakTmtINXN
 Shgc4miyY5MVeWibB+U/r7eMFNtwzCU75sbN9rzLDsy5FyI2ktz1R/l7pocIyPCZLMA/
 xKTN7YfjmT7rT0MzKTBEhFlhlLNNwd7XxV6yJQgEhgYdbH3sJh0KnVEDCLssUOrnLp4f
 iIRSIzSUS3/kPq8gmNrYLCn+9WuVQjIVK2RBlmzLM3OLVOh3eXJo7ctluHKOJ3kdfPn3
 rKxzGtp73BUJGD0eELmoavH+3LUM8hgNBe9bw1pzHl2zTIKzsqNLEHPrDzxkhGJsUj0F
 1pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791779182; x=1792383982;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tZocVQ6Rzh5SBuw1zPlgeJ0k0sYL5o3kj7hYBaiFxTs=;
 b=b70UeB+G7wNuY3CUVCO4LeUedbInpmi0YQ+9KvjCRj76ifx7kTSx6xYhri+CXLcVm4
 rKRRir7Yuwhal5FZ6/ZWPkW7T5wu2PqUVSjGKpjTuGOivZ715Tm0hu2EZ0M43qnJj8ft
 3DR4/WuZGc3TCqPdFNOqRbtrlThwRULCyvyYXVsntAqDQD5IWGxzEnZHLl04YLo/dp9N
 m8479mJ+uJ8rls80iRjefHgoi3u+W4/10oAi/WnpaU5772MpBplnyNwc5pGv4DkCxXS2
 IDHSJx2T+tIpgGbIUCQmWaIRg2fdaH+qVUEw7/C3dT3ZhukLX3e7PC3G9CXEZ/d/z52J
 nmXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZWzr/sVrauBAtvYBKBW2K21uBW6avz39xi3BHYqGhqCuVf3c/O3wSossaJtwflvKkw3YXnzsSkvsd@nongnu.org
X-Gm-Message-State: AFq9FYIswiVImbpEn6GcnNkFBBYhiHoQUrQ3ynkBXmGVngKGlETzW1jc
 pgq15EoWtiDJXlv9Rm1ndUmmLxNsHp0yYqDXjJbCy8rjXvMXmk1YIjY74Cf7BPtK3KbP/VuDeb8
 +rx2dynGCkGCzIvFd11e6LM0btXeP+r8=
X-Gm-Gg: AYBFou3QRPlb5LSZ8+U1ZP88TJ3jH/uFnzyoyT0xkZqp/9A/7mY8kNiWA/dCTKUGrt/
 XSJArG81ZhUL5JgpYChgq4SQRKUJvR0Sh7s77tDOQDIbPopKuTe6jB/sULbgIPQlNCnqdlI34r0
 Jjnaf9YkJ+LBztjeMA6S23m/Iw73dsyyDDfTUQFGS6lpliEh6WonSckkmkwX+hIvzzOj9O6bg37
 uwxVVe6DarjfaxOFzrYQdNyN6Fi7pwiZOTf4iMolvXHr1y0andSOgQmdSIDQU+e/fzamPuIAvar
 bW3rGMdm93VJqyVfUCNKJXsu1C25nxDSAmR24+9BSE4Vv+h2V40YzFw=
X-Received: by 2002:aa7:d6c9:0:b0:6aa:ece2:ae5b with SMTP id
 4fb4d7f45d1cf-6b17aecac88mr5638137a12.20.1791779181989; Sun, 11 Oct 2026
 21:26:21 -0700 (PDT)
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
In-Reply-To: <1a477877-516a-41b8-8548-598bfad74f25@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 12 Oct 2026 12:26:09 +0800
X-Gm-Features: AclHuK9DqIqjrf0x2TaIgk8wy8lPCE8mYFSvPRLrByeuTuxLBOzhw49kGB_Ez3E
Message-ID: <CAE2XoE_MotPuxBBkLFWmcDf6ACva2r7y-7sRbQ3DNNwZvXcJFQ@mail.gmail.com>
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
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 12, 2026 at 10:25=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/11/26 7:13 PM, Pierrick Bouvier wrote:
> > On 10/11/26 1:22 PM, Yonggang Luo wrote:
> >> On Fri, Oct 9, 2026 at 2:34=E2=80=AFAM Pierrick Bouvier
> >> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>
> >>> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
> >>>> On Fri, Oct 9, 2026 at 12:06=E2=80=AFAM Pierrick Bouvier
> >>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>
> >>>>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
> >>>>>> On Thu, Oct 8, 2026 at 5:42=E2=80=AFPM Daniel P. Berrang=C3=A9 <be=
rrange@redhat.com> wrote:
> >>>>>>>
> >>>>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
> >>>>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> >>>>>>>>> This allows a combined binary to register machine types from al=
l its targets.
> >>>>>>>>> Consequently, QMP `query-machines` can return machine entries f=
rom every
> >>>>>>>>> target, even when `none` is selected. For example, a client can=
 query the
> >>>>>>>>> combined machine list with:
> >>>>>>>>>
> >>>>>>>>> ```json
> >>>>>>>>> { "execute": "query-machines" }
> >>>>>>>>> ```
> >>>>>>>>>
> >>>>>>>>> The returned list includes the registered machine classes from =
all linked
> >>>>>>>>> targets. This is separate from selecting a machine: with `-targ=
et none`,
> >>>>>>>>> `-M virt` reports the targets that provide `virt` instead of ch=
oosing one
> >>>>>>>>> arbitrarily:
> >>>>>>>>>
> >>>>>>>>> ```text
> >>>>>>>>> qemu-system -target none -M virt
> >>>>>>>>> unsupported machine type: "virt" for target "none"
> >>>>>>>>> Available for targets:
> >>>>>>>>>     aarch64
> >>>>>>>>>     arm
> >>>>>>>>> ```
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>>   From the long conversation on a previous thread, I thought we =
reached
> >>>>>>>> the conclusion that if we didn't expose any ambiguous name, then=
 -target
> >>>>>>>> option is unnecessary, or maybe I got lost on track of this thre=
ad.
> >>>>>>>>
> >>>>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
> >>>>>>>>
> >>>>>>>> I'm not sure which semantic we want to have with -target none. I=
f there
> >>>>>>>> is no ambiguous name registered, we just don't need it at all. I=
t's a
> >>>>>>>> win-win IMHO.
> >>>>>>>
> >>>>>>> Yes, if we expose unique names for every machine, then -target is=
 then
> >>>>>>> redundant.
> >>>>>>
> >>>>>> so how to diff riscv32-virt and risv64-virt? oh so for this machin=
e we
> >>>>>> needs two name?
> >>>>>> "virt" needs register twice for it? or register only a single time=
,
> >>>>>> but we prefix the target_name()
> >>>>>> automatically? for example machine::name =3D=3D=3D "virt", but we =
can use
> >>>>>> "riscv32-virt" "risv64-virt" to reach it?
> >>>>>>
> >>>>>
> >>>>> Yes, ideally we should have different variant of virt for 32/64 bit=
.
> >>>>> Same goes for cpu max types.
> >>>>>
> >>>>> QOM type is always registered unambiguously ("$arch-virt"). Then, f=
or
> >>>>> the "alias" name, which is virt, in case multiple matches are found=
,
> >>>>> command line can return an error with list of unambiguous names to =
call it.
> >>>>>
> >>>>> $ qemu-system -M virt
> >>>>> Multiple virt machines are available. Please choose one of them:
> >>>>> - aarch64-virt
> >>>>> - riscv64-virt
> >>>>>
> >>>>> There is no "parsing" of the argument, it's just the real QOM type.=
 Then
> >>>>> we can find which target it implements from mc->targets.
> >>>>> And then, we can automatically choose which cpus should be availabl=
e
> >>>>> based on that, thanks to cpu->targets.
> >>>>>
> >>>>> For existing binaries, nothing change.
> >>>>
> >>>> Good, I think we found a clean way now, is_available should be
> >>>> removed, and TypeInfo::targets and TypeImpl::targets should be added=
.
> >>>
> >>> It goes into MachineClass only for now.
> >>>
> >>>> I think
> >>>> for "virt" we can add a shared hw/machine-virt.c instead, and forwar=
ding to
> >>>> the $arch specific virt. so that we only have a single "virt" regist=
ered.
> >>>> And it's
> >>>> targets is
> >>>> QEMU_ARCH_I386 |
> >>>> QEMU_ARCH_ARM |
> >>>> QEMU_ARCH_RISCV |
> >>>> QEMU_ARCH_LOONGARCH |
> >>>> QEMU_ARCH_M68K |
> >>>> QEMU_ARCH_OR1K |
> >>>> QEMU_ARCH_XTENSA |
> >>>> QEMU_ARCH_HEXAGON
> >>>>
> >>>> So that we won't have a list of conflict QOM names for "virt" machin=
es.
> >>>> As now we indeed have only a single "virt" machine that redirects to
> >>>> different targets.
> >>>>
> >>>
> >>> The idea looks appealing, but I don't think it solves the problem to
> >>> have multiple virt variants available at the same time.
> >>>
> >>> The "alias" idea you introduced before is good, we just need to add a
> >>> check if an alias is really unique, else return an error, as explaine=
d
> >>> previously.
> >>>
> >>> If "-M aarch64-virt" works for both the new and existing binary, and =
-M
> >>> virt only for existing binaries (and ambiguous for new one), I think
> >>> that's a safe approach.
> >>>
> >>>>
> >>>> For other types also conflict can be handled in the same way, such a=
s
> >>>> "-cpu host" "-cpu max"
> >>>> maybe others, but I think they all have the same way to deal with.
> >>>>
> >>>>
> >>>> That's why  TypeInfo::targets and TypeImpl::targets better than sole
> >>>> Machine::targets
> >>>>
> >>>
> >>> One step at a time.
> >>> Let's keep focused on declaring targets for a single machine first.
> >>> Then we can iterate to solve the "virt" problem.
> >>> Then convert all the existing machines and add a check in machine-tar=
get.c
> >>> Then, and only then, we can see what happens with cpus.
> >>
> >> I tried this idea, but I faced a fatal error, because the
> >> target_info() is not available until
> >> the machine selected(the target arch will be select just along with
> >> the machine selected), so basically
> >> all calls to target_info() would raise an error(null pointer), how to
> >> deal with it?
> >>
> >
> > I see. Indeed, since we can't set a target before registering all types=
,
> > it implies that all the types class_init can't use target_* functions.
> >
> >
> > - register_accel_target_type
> > - cpu_max_v8_register_type
> >
>
> Sorry, mail sent to early.
>
> For the is_available callback usage, it should be easy to do the switch,
> since it's basically the same information that what we are trying to do
> - we can leave them for now.
>
> Some types (like accel and max mentioned above), explicitly change their
> definition depending on the target. It's a behavior we can't rely on
> anymore, and it means we need proper distinct types instead of a single
> one with dynamic definition driven by target-info.
>
> I think that's the preliminary work needed, before being able to go
> further: convert all existing usage in class_init with distinct types +
> is_available, and then we can do the switch from is_available to the new
> .targets approach.

Hi Pierrick,
I have already tried that introducing new QOM names just to make class_init
 target-independent is too broad(means all usage of it should be handled)
and could complicate compatibility(changed too much code).
Can we avoid new names by some new means(ideas welcome)?


>
> It's probably worth having the conversion in its own series (only
> cleanup usage of target_* in class_init), before trying to get rid of
> is_available.

>
> For the implementation, you can use the multi-targets.c binary test to
> drive the change. Remove the module init for target info (leaving no
> target set), and add a hacky patch to skip call to is_available (and
> return true instead) and allow double definition (which will rely on
> is_available). Then, fix all the segfault. Once it compiles and runs,
> only double definition will be left, which can be handled by inserting
> the right is_available callbacks. Then in a subsequent series, the
> switch to .targets can be made.


Still have no clean clue about how to remove is_available , as we have many
"virt" machines. Do you means all "virt" machines with "virt-machine" QOM n=
ames
are inserted to the table? How to get it working because the "key" is strin=
g.


>
> It's a work we'll need to do for heterogeneous anyway, I was just hoping
> to delay that until there, but seems we need to deal with it now.
> A good thing is that it means target-info won't have to be registered
> before all QOM types anymore, so it's worth the effort IMHO.
>
> Thanks,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

