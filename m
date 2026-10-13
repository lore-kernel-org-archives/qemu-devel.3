Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4F9CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 02:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGSUu-0002di-JD; Mon, 12 Oct 2026 22:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGSUm-0002c4-S0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 22:44:06 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGSUj-0008Jq-Ds
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 22:44:03 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso3615207a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 19:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791859440; cv=none;
 d=google.com; s=arc-20260327;
 b=BF6/71QKAXA7uRkh1LcID5g787TqjBQGmJABTFhfvOijlGHBnpksg5DhjKFP9+8ykc
 AuBFgu8obcneuUjEbKyrDBwM2R3sXi3OM4shEGs1nXl1143Nfz3iv7QPxPo9K/E/6NxM
 yS8lO1ADZkSB+GCgAsiEjTX+8lT7EjjEfXsqdGqbvdWIz7JhP/jgTMY5FZydf3aWz09r
 t7t15zyKZ+QJ0hi1WItx/R1s7cw0nf2GEJlwV2pBEd+g6l8lbrrQ4nDksZ6w2kn/cYwx
 RwRA4d44WPEVLXNvADJyZVFuWvM6Yi5zWZum4xF2slBBhlzVRB51hVkmwI7QI3UDWyIS
 4Exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Y7gkPMEVzzW21UVYNugAEa18gFl3PM/FhZ5WgMxgA2M=;
 fh=VgrlbNwHCNphq916crJ1EiFcw0GAwOmGpsNZ4QWfjGY=;
 b=TR2Juo9RuS+JwWarDERa1WURQ388cZJ1FHeLtGCQPjY4gFKVcb+cuG75bNmDrU1Z0n
 Q/WcX7yAcWbs/9jhTv2mjy5v8EM/+uQ/y30qL9epACV7SpaKrytojzxJVIuCLL4blrnj
 6Eh1imSTJ6CT1uN0EEFBPQvyye3AjzbhupH5HTdGUxKVDUZ19yr9grX1CkutdYGCAy8h
 aX8HkqrCAYsmPyl/ntcllUgQ1tmHCtvmxoWhKKkKoaw7cJap5ACfHRg6YNDM7mkWnyIZ
 d5G9zz+W5tE8iqjH0dN/OUS4kyfD6TzFNOzKHXsKRFccxnZU7Z0V9kQh3lmap5yTlc9d
 D//A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791859439; x=1792464239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y7gkPMEVzzW21UVYNugAEa18gFl3PM/FhZ5WgMxgA2M=;
 b=FUMYesXrYyMHe12qbcF9L4GK37dQ23PBDhs8EC3FtHEaSVr7EXvlLK+z9Vu5orksgn
 +OSLI0yvm8apNrIIGjPmbbz+zE1pcH5aBB+7bvoikW8ZVxfZaDAGkQdIqqUenDWa1N9X
 NfNyfYg/hcGso23VWFVSe2xLBCS6DAoD7ODLNlo1i00bStVoL+hyNYDU5n2oGVGQn0AW
 Lma3NEKkQN2XLIcnxnmccmSYt0Qwlusvj9OeutMPdI+D/6IzK91pWmMsIghIqXTLowiS
 t61INTklP/JOrW65IdI2GkruitSbfqfegxIb+/ziN6aCyCpZhBYLNai6gdEIv+iFPzXz
 LxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791859439; x=1792464239;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y7gkPMEVzzW21UVYNugAEa18gFl3PM/FhZ5WgMxgA2M=;
 b=rv66e6IE4AUu5uUw4hALzhipnA7CyetR/J+W0/xlPZMBG2lOgb/VQAZwKCs4YyB5ES
 WooUT2WyhFMqnhpZyN/ipfJLizc2tj/XD5fmTBai/m4npRgFys/xVMsxe91XqMD6gk2u
 uvLtwKLAAbzUzWfH2SQv3iXFq0hY2ciIVD0u42/174pzpBbOj7eQy5jzaxVBGd5PMqzt
 rZh8akFyPk6o+EPzdUjcvQT43tJvsSR7zN/hRYit/iBHjDF5iL0uKS0QEAG/FRw/rbFF
 AyzJnRKD7sd1ytVZpwCrgkJMJ01YRiqGUtCLJ72uzjYHfGUxf1T14/FUMCwFxSOMcMOt
 k8Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmM0Ra7oI2J5g9KGyKk8h89g7/qzim1fyV3BsMZjCe9Cmi0oiyAkbDH+NNWDN2HwTpKQrxijJIPqOX@nongnu.org
X-Gm-Message-State: AFq9FYJub0/7bdDWvOPLyyhYQrrBzjZoTcOFnS+DvuXtZBnAtbJNeG9r
 OqyxXuK8w8+mnMDpI2nwH8kvfW1vWoykf9p4DJXJOZpQ3NQ4LPoQCMrSbMA2LPupPIZKCdkeTBa
 MLeHykDTwqNUKwQrvmArH0wkIRgxlH4U=
X-Gm-Gg: AYBFou0u9pFpHDzHWSfpolTbfoBgF9ub75b2yGhpQ9wX/qxKIqjhKW4ZkVbwh8i6oIX
 SR7YaKE8tvMxsTiJWPqev6zj/KHSmJf/F0tFSbyBKeRNnect7THxEp+VxL70X8cFBkFLi3oS33r
 dLeZgPw7Zx4cA41omfjGidU8K4f+DCjI/UMpWZXfm2zStm8Pev/XsK2Rn805njLXKoLj8TKuaT1
 VKlvpVY4LXUcSxzQbwrCF58nzeYcqxff+IykKzgbwDxnhsGsikWVeJEN+Ncv2/IH8VEh3rwYcfB
 EtlnUnz88UkhTKu9RB/q2RIvdBvvvgttMQVYcRPdtfuj5uSmI3Y5bfs=
X-Received: by 2002:a05:6402:4486:b0:6aa:f630:f846 with SMTP id
 4fb4d7f45d1cf-6b17c26a90fmr9728221a12.31.1791859439355; Mon, 12 Oct 2026
 19:43:59 -0700 (PDT)
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
In-Reply-To: <ae0dcb2d-1488-4cea-8bc0-2a0cb2cd74be@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 13 Oct 2026 10:43:46 +0800
X-Gm-Features: AclHuK9jmhqYMCRki5xsSX5FQKfrLz1BtUZP9c2TRveS9rt10eKENNqWPDFZ2Ec
Message-ID: <CAE2XoE9B8RXg6=6kofVA=d6C5OBXT9GZ2cPceWUUDa4m9=_fRg@mail.gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 13, 2026 at 9:26=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/11/26 9:26 PM, Yonggang Luo wrote:
> > On Mon, Oct 12, 2026 at 10:25=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/11/26 7:13 PM, Pierrick Bouvier wrote:
> >>> On 10/11/26 1:22 PM, Yonggang Luo wrote:
> >>>> On Fri, Oct 9, 2026 at 2:34=E2=80=AFAM Pierrick Bouvier
> >>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>
> >>>>> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
> >>>>>> On Fri, Oct 9, 2026 at 12:06=E2=80=AFAM Pierrick Bouvier
> >>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>
> >>>>>>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
> >>>>>>>> On Thu, Oct 8, 2026 at 5:42=E2=80=AFPM Daniel P. Berrang=C3=A9 <=
berrange@redhat.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrot=
e:
> >>>>>>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> >>>>>>>>>>> This allows a combined binary to register machine types from =
all its targets.
> >>>>>>>>>>> Consequently, QMP `query-machines` can return machine entries=
 from every
> >>>>>>>>>>> target, even when `none` is selected. For example, a client c=
an query the
> >>>>>>>>>>> combined machine list with:
> >>>>>>>>>>>
> >>>>>>>>>>> ```json
> >>>>>>>>>>> { "execute": "query-machines" }
> >>>>>>>>>>> ```
> >>>>>>>>>>>
> >>>>>>>>>>> The returned list includes the registered machine classes fro=
m all linked
> >>>>>>>>>>> targets. This is separate from selecting a machine: with `-ta=
rget none`,
> >>>>>>>>>>> `-M virt` reports the targets that provide `virt` instead of =
choosing one
> >>>>>>>>>>> arbitrarily:
> >>>>>>>>>>>
> >>>>>>>>>>> ```text
> >>>>>>>>>>> qemu-system -target none -M virt
> >>>>>>>>>>> unsupported machine type: "virt" for target "none"
> >>>>>>>>>>> Available for targets:
> >>>>>>>>>>>      aarch64
> >>>>>>>>>>>      arm
> >>>>>>>>>>> ```
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>    From the long conversation on a previous thread, I thought =
we reached
> >>>>>>>>>> the conclusion that if we didn't expose any ambiguous name, th=
en -target
> >>>>>>>>>> option is unnecessary, or maybe I got lost on track of this th=
read.
> >>>>>>>>>>
> >>>>>>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com=
/
> >>>>>>>>>>
> >>>>>>>>>> I'm not sure which semantic we want to have with -target none.=
 If there
> >>>>>>>>>> is no ambiguous name registered, we just don't need it at all.=
 It's a
> >>>>>>>>>> win-win IMHO.
> >>>>>>>>>
> >>>>>>>>> Yes, if we expose unique names for every machine, then -target =
is then
> >>>>>>>>> redundant.
> >>>>>>>>
> >>>>>>>> so how to diff riscv32-virt and risv64-virt? oh so for this mach=
ine we
> >>>>>>>> needs two name?
> >>>>>>>> "virt" needs register twice for it? or register only a single ti=
me,
> >>>>>>>> but we prefix the target_name()
> >>>>>>>> automatically? for example machine::name =3D=3D=3D "virt", but w=
e can use
> >>>>>>>> "riscv32-virt" "risv64-virt" to reach it?
> >>>>>>>>
> >>>>>>>
> >>>>>>> Yes, ideally we should have different variant of virt for 32/64 b=
it.
> >>>>>>> Same goes for cpu max types.
> >>>>>>>
> >>>>>>> QOM type is always registered unambiguously ("$arch-virt"). Then,=
 for
> >>>>>>> the "alias" name, which is virt, in case multiple matches are fou=
nd,
> >>>>>>> command line can return an error with list of unambiguous names t=
o call it.
> >>>>>>>
> >>>>>>> $ qemu-system -M virt
> >>>>>>> Multiple virt machines are available. Please choose one of them:
> >>>>>>> - aarch64-virt
> >>>>>>> - riscv64-virt
> >>>>>>>
> >>>>>>> There is no "parsing" of the argument, it's just the real QOM typ=
e. Then
> >>>>>>> we can find which target it implements from mc->targets.
> >>>>>>> And then, we can automatically choose which cpus should be availa=
ble
> >>>>>>> based on that, thanks to cpu->targets.
> >>>>>>>
> >>>>>>> For existing binaries, nothing change.
> >>>>>>
> >>>>>> Good, I think we found a clean way now, is_available should be
> >>>>>> removed, and TypeInfo::targets and TypeImpl::targets should be add=
ed.
> >>>>>
> >>>>> It goes into MachineClass only for now.
> >>>>>
> >>>>>> I think
> >>>>>> for "virt" we can add a shared hw/machine-virt.c instead, and forw=
arding to
> >>>>>> the $arch specific virt. so that we only have a single "virt" regi=
stered.
> >>>>>> And it's
> >>>>>> targets is
> >>>>>> QEMU_ARCH_I386 |
> >>>>>> QEMU_ARCH_ARM |
> >>>>>> QEMU_ARCH_RISCV |
> >>>>>> QEMU_ARCH_LOONGARCH |
> >>>>>> QEMU_ARCH_M68K |
> >>>>>> QEMU_ARCH_OR1K |
> >>>>>> QEMU_ARCH_XTENSA |
> >>>>>> QEMU_ARCH_HEXAGON
> >>>>>>
> >>>>>> So that we won't have a list of conflict QOM names for "virt" mach=
ines.
> >>>>>> As now we indeed have only a single "virt" machine that redirects =
to
> >>>>>> different targets.
> >>>>>>
> >>>>>
> >>>>> The idea looks appealing, but I don't think it solves the problem t=
o
> >>>>> have multiple virt variants available at the same time.
> >>>>>
> >>>>> The "alias" idea you introduced before is good, we just need to add=
 a
> >>>>> check if an alias is really unique, else return an error, as explai=
ned
> >>>>> previously.
> >>>>>
> >>>>> If "-M aarch64-virt" works for both the new and existing binary, an=
d -M
> >>>>> virt only for existing binaries (and ambiguous for new one), I thin=
k
> >>>>> that's a safe approach.
> >>>>>
> >>>>>>
> >>>>>> For other types also conflict can be handled in the same way, such=
 as
> >>>>>> "-cpu host" "-cpu max"
> >>>>>> maybe others, but I think they all have the same way to deal with.
> >>>>>>
> >>>>>>
> >>>>>> That's why  TypeInfo::targets and TypeImpl::targets better than so=
le
> >>>>>> Machine::targets
> >>>>>>
> >>>>>
> >>>>> One step at a time.
> >>>>> Let's keep focused on declaring targets for a single machine first.
> >>>>> Then we can iterate to solve the "virt" problem.
> >>>>> Then convert all the existing machines and add a check in machine-t=
arget.c
> >>>>> Then, and only then, we can see what happens with cpus.
> >>>>
> >>>> I tried this idea, but I faced a fatal error, because the
> >>>> target_info() is not available until
> >>>> the machine selected(the target arch will be select just along with
> >>>> the machine selected), so basically
> >>>> all calls to target_info() would raise an error(null pointer), how t=
o
> >>>> deal with it?
> >>>>
> >>>
> >>> I see. Indeed, since we can't set a target before registering all typ=
es,
> >>> it implies that all the types class_init can't use target_* functions=
.
> >>>
> >>>
> >>> - register_accel_target_type
> >>> - cpu_max_v8_register_type
> >>>
> >>
> >> Sorry, mail sent to early.
> >>
> >> For the is_available callback usage, it should be easy to do the switc=
h,
> >> since it's basically the same information that what we are trying to d=
o
> >> - we can leave them for now.
> >>
> >> Some types (like accel and max mentioned above), explicitly change the=
ir
> >> definition depending on the target. It's a behavior we can't rely on
> >> anymore, and it means we need proper distinct types instead of a singl=
e
> >> one with dynamic definition driven by target-info.
> >>
> >> I think that's the preliminary work needed, before being able to go
> >> further: convert all existing usage in class_init with distinct types =
+
> >> is_available, and then we can do the switch from is_available to the n=
ew
> >> .targets approach.
> >
> > Hi Pierrick,
> > I have already tried that introducing new QOM names just to make class_=
init
> >   target-independent is too broad(means all usage of it should be handl=
ed)
> > and could complicate compatibility(changed too much code).
> > Can we avoid new names by some new means(ideas welcome)?
> >
>
> As a first step, I don't think we need new names, is_available can be
> used to selectively register one definition or another and avoid any
> clash. What is missing at the moment though, is that some types (like
> cpu max above) change their definition based on target definition.


>
> So for cpu max, we would have two distinct types, both named max, but
> one with is_available(target_arm), and other one with
> is_available(target_aarch64), so they are never registered at the same ti=
me.

>
> Same for virt machines. It's already what we have, duplication is
> handled at the moment with distinct is_available callbacks.
>
> Then, see below.
>
> >
> >>
> >> It's probably worth having the conversion in its own series (only
> >> cleanup usage of target_* in class_init), before trying to get rid of
> >> is_available.
> >
> >>
> >> For the implementation, you can use the multi-targets.c binary test to
> >> drive the change. Remove the module init for target info (leaving no
> >> target set), and add a hacky patch to skip call to is_available (and
> >> return true instead) and allow double definition (which will rely on
> >> is_available). Then, fix all the segfault. Once it compiles and runs,
> >> only double definition will be left, which can be handled by inserting
> >> the right is_available callbacks. Then in a subsequent series, the
> >> switch to .targets can be made.
> >
> >
> > Still have no clean clue about how to remove is_available , as we have =
many
> > "virt" machines. Do you means all "virt" machines with "virt-machine" Q=
OM names
> > are inserted to the table? How to get it working because the "key" is s=
tring.
> >
>
> Once we have type definition which only depends on is_available, we can
> convert this to .targets, which would contain the same information.
> For the rest, I have some ideas, but I would like first we do the first
> part (convert to is_available), which is already a huge work in itself,
> and a series of its own.

Indeed I am confused .targets only exists on Machine, how is it
related to -cpu host -cpu max?


I already have a working copy that does not depend on target_info()
and selects target_info() when the machine
is selected, no QOM name introduced. only for machines, we will have
$target_name-$machine_name as a name for selecting
the exact machine.

The cpu max cpu host is dealt by moving the choose code out of
class_init, into object_init. I really did not get your idea by use
is_avaiable. because when I try to get all QOMs to be registered. then
I won't call is_available at all.
because "is_available" depends on target_info(),(we won't have
target_info() till the machine is selected).

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

