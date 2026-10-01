Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE51CA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJR5-0000IZ-Dk; Thu, 01 Oct 2026 12:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCJR0-0000Hf-7m
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:15:02 -0400
Received: from mail-ed2-x2b.google.com ([2a00:1450:4864:33::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCJQw-0007s4-QW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:15:01 -0400
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae19319854so3069612a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790871297; cv=none;
 d=google.com; s=arc-20260327;
 b=F/F4xfmUHjAyrpOiO0Cu3qUbPy+UDOo355KYloKMMwTXORD1UIfaZVBXPlTT3IjKgr
 Lyc5LMHjrlc8nARaZ4MJUJq3yo5+LNduAJs4c+vSQUi8uoqet4aYk4qvRu8AGnljcYUV
 k2hvLolTAJxpg7MRS7VQYzycaDzMToWx2FJnkEqlDLbKiy1EfzbdGAD25Js1+sa1G28g
 hH8+IYoy6qD9tq3Y39fJZiIgWv6HghuV3dxoPsOa5a6cjJma+6F75AO/tLkHs2UQOPd/
 LaDZv4hSao2mE/Y4VIA7NpNS/v03A5eru6AxX3mmD1/gUkMeWIGMY1J2AjeJvGY7X5S/
 k4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=h61SxJHQbKLBPIa+vMeaBSUVLyfBLOowqJpHxdYzXjQ=;
 fh=980pRR6w/ZF4byD0QcznpH3OXpMh/qo0TJv9f8GPe+o=;
 b=PNGWc1IUeReuIrh1KaupRSuJWS5Ox9JNUXj7tfFMszP0e4zYTiGOh9tkI7M84pxWty
 HzKglGOjLH3nHJxK5cIEYI1J+tZ3lJ3grAuaWOhaZP+4ClA8wocbO6MWcBtOfP2dhvNR
 wv6t+r4iSNiwhu6q4GBOyVF2n4UhWNcnXl/th26fH42Q+fOsrFn1C3gR1wRLaTHGMeOv
 2DkBIW5roVKcVK306G9cBAg5JdB6TdGFC77oaGlSXLVyHiPWxrrthDH1fzztad7S9Unp
 Y7myLRa+Hzk5gPKNf4lHB2Afra1PEDurIn4qxgo+jZVm/FRR2Osln59GnNoFK6+Xe7Iy
 XKJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790871297; x=1791476097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h61SxJHQbKLBPIa+vMeaBSUVLyfBLOowqJpHxdYzXjQ=;
 b=EcgcncDTRnnqxEtTDs5QT/Qt5ZS2SrTanVE6rkx7e/iuXnywZiMo+ViyKO8JbKWgEB
 ogzP8qt4tTs+iZUhJPN+UXqJD511zVlRRdo2Pnycuo82Ef81mnpACOUOkfuyk7t7Phpi
 kn05BvxMuN+QFhlyaAy2gJ9wBv1GmP43w2DZ0JkxihSFw5O+gFN1aqbU3R8HjwzESAQC
 GCZLdurJAPsqFMtcVVM8H1k6UPRYYbpQYYp9oDC1xjn1+EwgOAA0By9dMLJROIZDFQvz
 b3Kr9xCIq82gslZtr2OKP2yfeclA6c2QZJO0sg57CGRWmoCaJS9SsyasVt9zicMVQ/7U
 OGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790871297; x=1791476097;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h61SxJHQbKLBPIa+vMeaBSUVLyfBLOowqJpHxdYzXjQ=;
 b=fWIa+X6Wu0XJZP/RVehCNjEkLN3Aotj5QHRCNzh0wusiKWvKsNgAti4K1VRH389+mh
 jo6kDt6izja5BGoN1T3hQBVBJg/nrNWP3kj1cQCDMTYtEi0/masPRba9PpD/aDd4dGSs
 8cSP6Z2KpBVIVYiLYT9ZHMoX5we8XaCSzJfRiBsCg96KqfmjCt95e4J7t0zskY8tT+Gd
 yvTtMLCf9wtBI7Kto50z85/o+eVmi56AtY3j2kCxTxSZU72aN5OKLRp083Td85IVI4nf
 CyvRVyj9h1/DZID0I99bbmEt3nVKfLEqLAh3M1CiPBxMT1Zq5Sx7Bq6s2xJqwzCfPbiV
 /fSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzArNca58SA5AouhzYPWtPlWXh8+13DMkcVFvCrYQOMo2kfnkeNKZWhGgc0tdGEVM072YifRnoAskGK@nongnu.org
X-Gm-Message-State: AFq9FYIUq3rFtBNvU3Ujxc1eSsd11xoW9HEsowJI3FTBnZ9ttTUC3IQO
 ilbGeinfkrU9J0bx7NcrM0radJCJYNfFbaUt7t6gDklbKoCZaYPvKhNu0EhvSs0rlGmYCFaGWNx
 SQO2Fifb2GkD9joJb8sM+wKOH2E7UjxU=
X-Gm-Gg: AYBFou1VT2KbAqGeHZ9K8lpdz0I6QVMRTrBfLO8U6SdtGU1zdbFSQMwLF9/fkS6ShEy
 nfo8Hw49GgubGBo9AuuZcHTMEgJj7vlwp+FBGFjFKNZgKo9LE/ncRx0ZphCne0dnrEgp6D7fsYo
 s6PCzmIsgweBf3mpNqVCg4JcTXuHq9sjbcahi4e0IiHeoTJGwXZN+SsREQJL1rAOikQ6rr2urb9
 n9Hq/TJ0ZPpGGX8w2vBThFG2toNOVO4NmYIms9Rnnwc2aYI9PQZ9RHKT2xlIBpT2oZp0eqlel9g
 hILw2GrjkQCPMUvLHC1hK36eUUj3QAPSyp4YKVIAljX6/vg1KXQUrTQ=
X-Received: by 2002:a05:6402:3221:b0:6ac:c82f:3caa with SMTP id
 4fb4d7f45d1cf-6ae198649c8mr4684651a12.1.1790871296876; Thu, 01 Oct 2026
 09:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
 <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
 <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
 <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
 <ar4TQtKqfXX5Ul9O@redhat.com>
 <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
In-Reply-To: <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2026 00:14:44 +0800
X-Gm-Features: AclHuK_r0ApGeCNqbP4rIfGlGP3RO4FHen8QDNUwQEQ3-PaHKWIv238fUFuikOk
Message-ID: <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Song Gao <17746591750@163.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::2b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x2b.google.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 THIS_AD=2.699 autolearn=no autolearn_force=no
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

On Thu, Oct 1, 2026 at 4:44=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 1/10/26 10:13, Yonggang Luo wrote:
> > On Thu, Oct 1, 2026 at 4:01=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> >>
> >> On Wed, Sep 30, 2026 at 09:23:50PM -0700, Pierrick Bouvier wrote:
> >>> On 9/30/26 6:55 PM, Yonggang Luo wrote:
> >>>> On Thu, Oct 1, 2026 at 2:19=E2=80=AFAM Pierrick Bouvier
> >>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>
> >>>>> On 9/26/26 1:15 AM, Yonggang Luo wrote:
> >>>>>> - Add machine_class_set_name() so boards can keep a stable -M name
> >>>>>>      when the QOM type is uniquified. machine_class_base_init stil=
l
> >>>>>>      defaults the name to the QOM type without -machine.
> >>>>>> - Document that MachineClass::name is the -M name, not the QOM typ=
e.
> >>>>>> - Sort -M help by MachineClass::name so order matches the printed =
names
> >>>>>>      when QOM types are prefixed (arm-virt-11.1-machine vs virt-11=
.1).
> >>>>>>
> >>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>>>>> ---
> >>>>>>     hw/core/machine.c        |  6 ++++++
> >>>>>>     include/hw/core/boards.h | 12 +++++++++++-
> >>>>>>     system/vl.c              |  8 +++-----
> >>>>>>     3 files changed, 20 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>
> >>>>> First, I'm not opposed to this series, and if anyone wants to pull =
this,
> >>>>> I'm ok with that decision. It's just unclear for me what will be
> >>>>> direction after this step.
> >>>>>
> >>>>> If I understand correctly, the goal here is to allow to register
> >>>>> multiple "virt" machines, while still having distinct QOM types beh=
ind
> >>>>> the hood, which does no affect behavior of current binaries who hav=
e
> >>>>> only a single "virt" type at most.
> >>>>>
> >>>>> That said, if we project in the future where we have a binary with
> >>>>> multiple of those "virt" machines, how will the current series help=
? The
> >>>>> situation we'll have is distinct QOM types, that all answer to the =
name
> >>>>> "virt", so we have no way to select them individually.
> >>>>>
> >>>>> Slightly worse, find_machine() will just pick the first machine nam=
e
> >>>>> virt, which is a non-deterministic order at the moment.
> >>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_=
type=3Dheads#L846
> >>>>
> >>>> That will handle it properly. For single-target binary qemu-system-$=
arch.exe,
> >>>> this won't be an issue, as there is no conflict as they won't be com=
piled in.
> >>>> For multi-target binary qemu-system.exe, we will choose the target t=
hrough
> >>>> -M $arch:$machine, and when no $arch is specified, the default to ar=
ch
> >>>> to be "none",
> >>>> so still won't be non-deterministic.
> >>>>
> >>>
> >>>> "when no $arch is specified, the default to arch to be "none",so sti=
ll >
> >>> won't be non-deterministic.
> >>>
> >>> That's my point, the current abstraction will create something ambigu=
ous by
> >>> design. When people will specify -M virt, without $arch:, a random ma=
chine
> >>> will be selected. At least, maybe this series should ensure there is =
only
> >>> one virt alias, or make it forbidden and uses unambiguous names only.
> >>
> >> Yes, if there are multiple choices, we should not pick an arbitrary on=
e
> >> non-deterministically, we must require the user to narrow the choice
> >> explicitly in some manner.
> >>
> >>> "$arch:" is just a workaround to not add -target option, except that =
it
> >>> comes with additional problems, creating inconsistent command lines.
> >>> I already expressed my skepticism about the "machine prefix" based ap=
proach,
> >>> being more in favor to strongly filter types per target with an unamb=
iguous
> >>> -target option. I'll accept the community's choice on this, but just =
wanted
> >>> to see this explained before someone hits the pull button on this ser=
ies, so
> >>> they know what will come down the road.
> >>
> >> Historically, QEMU do alot of things like this where we invented magic
> >> syntax that needed custom parsing of the command line. Over time we
> >> came to the conclusion this ad-hoc parsing was a bad idea, and we
> >> should always explicitly model things, even if it is more verbose.
> >>
> >> Thus I would not want to see "$target:$machine" as something that is
> >> parsed into two pieces.
> >>
> >> IOW, "aarch64-virt" would be OK as a unique name which treated as an
> >> opaque string, but "aarch64:virt" as something split into "aarch64"
> >> (target) and "virt" (machine) would be a bad idea.
> >>
> >> An acceptable way of modelling the latter would be to use
> >>
> >>    '-machine name=3Dvirt,target=3Daarch64'
>
> Why mix target information parsing at machine level when the
> machine already know it is target specific? People wanting to
> use the ARM virt machine don't want to know (and don't care)
> about the M68k virt machine.
>
> >
> >>
> >> or
> >>
> >>    -machine virt -target aarch64
> >
> >
> > That's made me confused, as different people propose different ways to
> > handle it.
> > Can we just choose one first?
> > '-machine name=3Dvirt,target=3Daarch64' is introducing new options, so =
is
> > '-machine virt -target aarch64'
> > I can not argue which is better, my suggestion may land one first. Both
> > "-machine virt -target aarch64" and "-machine $arch:$name" I have
> > already implemented. And currently I chose
> > "-machine $arch:$name" according to
> > https://patchwork.ozlabs.org/project/qemu-devel/cover/20260828225901.36=
7438-1-pierrick.bouvier@oss.qualcomm.com/#3749257
>
> You still did not explained what you are trying to achieve
> with all your contributions, so my view is surely biased by
> what we envisioned 3 years ago when we started to pave our
> way for heterogenous emulation.
>
> My options so far for a single binary:
>
> - infer from argv[]
This can be easy to implement and can be defer till the qemu-system-$arch
is symbolic link to qemu-system.

> - enforce with CLI -target

I want to post my personal options, I'll prefer the -target options as
it's far easier to implement than "-machine $arch:$machine".
-machine $arch:$machine is very complicated to implement correct.

> - not expose any machine

I think not exposing any machine in the command line is a good option,
as it's easier to
implement and clean for the user. But I think this series is still needed.
As we want the means to inspect all machines and devices for all
targets(that need all of them
to be registered into the QOM type hash table).

>

> Phil.



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

