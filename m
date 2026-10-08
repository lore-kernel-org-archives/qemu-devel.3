Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D2ECA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEtB0-0001D4-TR; Thu, 08 Oct 2026 14:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEtAz-0001CB-BZ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:49:09 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEtAx-0005UE-5x
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:49:09 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so4878231a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791485345; cv=none;
 d=google.com; s=arc-20260327;
 b=nP+hhOUWRmMLzVCmYznDw8ufyF8jNNK/aXpMQTsox38ZLNJ+EaA7syZhbAcnNmP+gx
 ACLocK07XZci+5Z2yc40m65BBjisb88/S09byWkAc86yRERr6tIIDw3egb37KHCqKgNM
 pjAT8IoFndRjrZDQv4+ZCvLPMzPIDRlw0+xP+qEwnRwJ7zURM+6MGnJRtKoBICkJfyRQ
 x72NtWV3DaM3f2YuNoX7HyKru8XG5x5bcPJsht7twaHDhuqFKn1Slr3DC42/4M2fDzHh
 WxokJGPvAgW6YPOJ1CNDwcMNvitw/ahZjj18cOPzgc2KDN4TUBE4MKs7KdYREA/W97kH
 QJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=RmbGXzV9zMVZxwLqUR9DoGzwi162+nZzsHvmu2tWYkA=;
 fh=H6tIlo7FcHF7vRsrHAdO1vWwEHEqiJRT7e9a23enmrU=;
 b=Ifvi1XdqAFfC8OO3DXvQlUXUL1Z/VpZzaKszQp/QCExBaJLeZnpx2WYvuwPW060RpS
 UKyrvHd2dFKH2qsnqcsDe9ogIVz8gaWo4JPUoJO+nAV1xSBZJIGbYV2hrtsc+gcgqz+z
 DZqyL9R6A59oACdakIVxaoB8rFj+2fUpP2cxfKL5MQVewlet4AsK42t9yAsLeP9Q7FeI
 QTVj9ZJbfrJiehQn4GUY3BacXX+R1xGb1t5QS+a5+Omxf1Trv8c/7M8WP1BU3tj+ZPzd
 VRdnDFe2gFn0bBJ3HM6uCxGNAohI7o3z9t6aPJ5PqfPnp6xhQzP9NR9FnVuKc4LO/6zN
 87Pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791485345; x=1792090145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RmbGXzV9zMVZxwLqUR9DoGzwi162+nZzsHvmu2tWYkA=;
 b=dynmMDQEeHS5jL+nym6+0Z1xijetGld5xcAxS+0rDJEApt8acdFZDVO/CTWJ/zMJ9T
 fiNOApQUCHBjovdSizdRGX2jcvE8kG8XehisC7wdctUco8pnDbhnGa3veDHxYMrwEBrZ
 +yw/LexFsj27u1V5yUSvuxfzDRHbNtQ7mFZvP2+9usFAbn+NGkDpGFrlsCId3WYbZpTh
 cmw4sMrSVRAtbfCy8vFBzg5G7Li666HnHt97/ZrUOFub8FWdsj1lJu33sJuvVbWBaQBZ
 t5wrKXod8yFmV+c+gs7XeksSVbgYBr+hBCJr37LijmOJjePgN5l63P43XhY7eiXMyJVR
 aFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791485345; x=1792090145;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RmbGXzV9zMVZxwLqUR9DoGzwi162+nZzsHvmu2tWYkA=;
 b=vpKCofv1uy/5jfX0PSepX2zUIrChDj7kyB36DWlXQk2NXubX1oSC/Xn8X6v/kKgwvg
 AmDAoUgv4+Uqq45ySkjXDW4UDI8nqatm97XV/w0n9H2n9kaznQjwJJ5TwH6aGKJcG1+E
 mhP6JaWd8vcX05lbGB/x3UBIDOcB5ogaoGf4wUV4cqiooCUYxBdppfFeSltuJy9gQ9AI
 +YtR6pmrd0kFbd5hh050MlcxTBCG3BhDjtwK9Edb/2U+zIbkx9zZh9SOXh0lg55SZ4re
 YQ7fbw0jsx2hwCeE1Fvg2U0TZMyiPZzN5h1PhaqvNGDm/oNromw5/jS1jepTGi1C1gUd
 qrzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCi6GovqeeLFseJpbe87t+iODbkkqwK51BkdNxnjuF82a2m7ue3/6XOf3LsJw2NnQQIEUVslXeahKJ@nongnu.org
X-Gm-Message-State: AFq9FYLlHUH5YF/hxdvAvi55Vlp9HRbaEBwDB09dpmEXAw+S2KxLneM0
 iO6NVA4z0hzeTyijd5ac9tDhNANDAAnfoq+4KdFHgjCdPuZxtSGy5KqomfbYwlM0PFNkeUw7fQI
 AcuHw6DFIlex95fjGv4yLGfls1MBspdU=
X-Gm-Gg: AYBFou3JSkDM9ELIx3o0mjUftcp4Pqnjy+TVzAhZfI6LcV1PnN4nudhAX4Jx4t0FUIB
 hHLSOt1hfz8x6PcgTu5Gosi9feM0HSgMLGywoLUsjruYt8z8qkPvhSn7A5t+FSkRhPsABZC1XH3
 lXCt39bM7oNMfwrCfgaQQcCgFGT847vNsVy2FjkY/P4fejtsAomyIz+WvS3RMtn11lqysfqgzuj
 5Y0Ug4+do/FSIiOZz9k80olQS6TcQW+m+NYdifS/TQSuZmdYtKtKY7qYNIadlObzANVqfea6LPq
 hX5m0unhW5pEx8YJoPB8/w8NU1Lb/eQMpo9RGviqqzQSNk5hA5aPcbc=
X-Received: by 2002:a05:6402:27c6:b0:6a9:a1a1:60fe with SMTP id
 4fb4d7f45d1cf-6aff374f73cmr5972050a12.3.1791485345389; Thu, 08 Oct 2026
 11:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
 <asdlbOZBSYIaCMIh@redhat.com>
 <CAE2XoE91XxoJRFpQ_1jhmX6LdxMyN16CF7RXxM62C5Ctkc1tig@mail.gmail.com>
 <42fd67c0-c20d-4bc4-bede-79073e4be4a1@oss.qualcomm.com>
 <CAE2XoE-gN5-vmE8r00Ds_Z=E1WePSFi_MJXjmy9ZuXEU_=o31g@mail.gmail.com>
 <3034c146-0697-4db7-acd4-8076b317a09e@oss.qualcomm.com>
In-Reply-To: <3034c146-0697-4db7-acd4-8076b317a09e@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2026 02:48:52 +0800
X-Gm-Features: AclHuK8JPXD8u5JDwNcHLvnwr0BBJonFnbxnnA-_gqfv0WsZFRE1d0jQSxYLNzs
Message-ID: <CAE2XoE8QMnFtnuAdxb5jQSCm325ZeRoffsyHw23oUZL_Ve-qTA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x529.google.com
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

On Fri, Oct 9, 2026 at 2:34=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
> > On Fri, Oct 9, 2026 at 12:06=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
> >>> On Thu, Oct 8, 2026 at 5:42=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> >>>>
> >>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
> >>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> >>>>>> This allows a combined binary to register machine types from all i=
ts targets.
> >>>>>> Consequently, QMP `query-machines` can return machine entries from=
 every
> >>>>>> target, even when `none` is selected. For example, a client can qu=
ery the
> >>>>>> combined machine list with:
> >>>>>>
> >>>>>> ```json
> >>>>>> { "execute": "query-machines" }
> >>>>>> ```
> >>>>>>
> >>>>>> The returned list includes the registered machine classes from all=
 linked
> >>>>>> targets. This is separate from selecting a machine: with `-target =
none`,
> >>>>>> `-M virt` reports the targets that provide `virt` instead of choos=
ing one
> >>>>>> arbitrarily:
> >>>>>>
> >>>>>> ```text
> >>>>>> qemu-system -target none -M virt
> >>>>>> unsupported machine type: "virt" for target "none"
> >>>>>> Available for targets:
> >>>>>>   aarch64
> >>>>>>   arm
> >>>>>> ```
> >>>>>>
> >>>>>
> >>>>> From the long conversation on a previous thread, I thought we reach=
ed
> >>>>> the conclusion that if we didn't expose any ambiguous name, then -t=
arget
> >>>>> option is unnecessary, or maybe I got lost on track of this thread.
> >>>>>
> >>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
> >>>>>
> >>>>> I'm not sure which semantic we want to have with -target none. If t=
here
> >>>>> is no ambiguous name registered, we just don't need it at all. It's=
 a
> >>>>> win-win IMHO.
> >>>>
> >>>> Yes, if we expose unique names for every machine, then -target is th=
en
> >>>> redundant.
> >>>
> >>> so how to diff riscv32-virt and risv64-virt? oh so for this machine w=
e
> >>> needs two name?
> >>> "virt" needs register twice for it? or register only a single time,
> >>> but we prefix the target_name()
> >>> automatically? for example machine::name =3D=3D=3D "virt", but we can=
 use
> >>> "riscv32-virt" "risv64-virt" to reach it?
> >>>
> >>
> >> Yes, ideally we should have different variant of virt for 32/64 bit.
> >> Same goes for cpu max types.
> >>
> >> QOM type is always registered unambiguously ("$arch-virt"). Then, for
> >> the "alias" name, which is virt, in case multiple matches are found,
> >> command line can return an error with list of unambiguous names to cal=
l it.
> >>
> >> $ qemu-system -M virt
> >> Multiple virt machines are available. Please choose one of them:
> >> - aarch64-virt
> >> - riscv64-virt
> >>
> >> There is no "parsing" of the argument, it's just the real QOM type. Th=
en
> >> we can find which target it implements from mc->targets.
> >> And then, we can automatically choose which cpus should be available
> >> based on that, thanks to cpu->targets.
> >>
> >> For existing binaries, nothing change.
> >
> > Good, I think we found a clean way now, is_available should be
> > removed, and TypeInfo::targets and TypeImpl::targets should be added.
>
> It goes into MachineClass only for now.
>
> > I think
> > for "virt" we can add a shared hw/machine-virt.c instead, and forwardin=
g to
> > the $arch specific virt. so that we only have a single "virt" registere=
d.
> > And it's
> > targets is
> > QEMU_ARCH_I386 |
> > QEMU_ARCH_ARM |
> > QEMU_ARCH_RISCV |
> > QEMU_ARCH_LOONGARCH |
> > QEMU_ARCH_M68K |
> > QEMU_ARCH_OR1K |
> > QEMU_ARCH_XTENSA |
> > QEMU_ARCH_HEXAGON
> >
> > So that we won't have a list of conflict QOM names for "virt" machines.
> > As now we indeed have only a single "virt" machine that redirects to
> > different targets.
> >
>
> The idea looks appealing, but I don't think it solves the problem to
> have multiple virt variants available at the same time.
>
> The "alias" idea you introduced before is good, we just need to add a
> check if an alias is really unique, else return an error, as explained
> previously.
>
> If "-M aarch64-virt" works for both the new and existing binary, and -M
> virt only for existing binaries (and ambiguous for new one), I think
> that's a safe approach.
>
> >
> > For other types also conflict can be handled in the same way, such as
> > "-cpu host" "-cpu max"
> > maybe others, but I think they all have the same way to deal with.
> >
> >
> > That's why  TypeInfo::targets and TypeImpl::targets better than sole
> > Machine::targets
> >
>
> One step at a time.

That makes sense, I am afraid I have no time to trace it currently(at
least a month).
At least we now have a good agreement. So it should be much easier,
otherwise it's really frustrating.

> Let's keep focused on declaring targets for a single machine first.
> Then we can iterate to solve the "virt" problem.
> Then convert all the existing machines and add a check in machine-target.=
c
> Then, and only then, we can see what happens with cpus.
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

