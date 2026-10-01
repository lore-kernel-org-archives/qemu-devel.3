Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC26CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCBvb-0000rH-T9; Thu, 01 Oct 2026 04:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCBvX-0000qh-U7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:14:03 -0400
Received: from mail-ed2-x2b.google.com ([2a00:1450:4864:33::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCBvU-0001dr-M3
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:14:03 -0400
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae3a72e02eso937600a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 01:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790842437; cv=none;
 d=google.com; s=arc-20260327;
 b=BJCW4iRvURkrv2VlWAggkACYBZg2QVKY/iGJPCXwwgrZojqj33zIR33b4G2bZbwnQu
 nMx1e6Xd2BTOGoypontk++aLaYLnSh52T/XZ+on0o8d31oLcKfedse4cMRTvPkKvuL1p
 bdxN/4/l24d60HPPFiw3+0Bpu+dGqBLE5Km0UQssxj0gdgGNF0BlNHpz1KtLRMXpOM9w
 Sv8ts1CGmdG+BmAlQpNcpg4PDLBrEFlmrfzsEALz0Vi0p8tySTjvcXbwcNl1hXCH2KUX
 k9otlxEBgP50dtMg6oXqOkdJNYGVPU8Y3Yfx9pEVevjiLWYPRKYIuPNaw4UdxqprYtQK
 Wd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=fvwBTziuJil7awK1BirVtL95VwyAIpQoQ8DrI2HQrgk=;
 fh=YLuOKcb4ECdbeHgPcrOvvsN+RDbUWH2o6WcOot6rc7A=;
 b=WqdPm5KU5CUCULkvdHuYzkWMtI/ukv/FtcbcvGvvNjCZH4V8EwDtVrtRWzeveYJqdM
 lcqEW1KrBG42Ze6JayAYmeGqTADM8kdobXwbBRl8kbu41hCMJYQeq8YAOx2Y9vwQmmG/
 8RDQqsXZAC2YiMIPfQl49M0oqwO8svQOT20uC6F3eja4y6tneUlFJVrBhM0EX7jXzjVd
 7vOkWum9/5Em9iX7a7WN/83fGaeJ7opi48MfQgsQnyTV5HTglmZXF93D0Bf3+VsQM1rH
 McC04FNSzxCepsnuSj3Vwt6NJiFMXZZvFwkZDc/9auhWC/8I8qwCooJcp3edgos88VL9
 0yCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790842437; x=1791447237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fvwBTziuJil7awK1BirVtL95VwyAIpQoQ8DrI2HQrgk=;
 b=FyAAOGuuqAF6W0npB7Ml2CQBfHIBgywiLHEzNwOmPxtwLjvSUdEBA7T/s52C3DJxNX
 ddlhtwdGIAK8r5T+RhRTmAJAF5eDMAIFaF02Vc+NagkCITCdUdUi9BSuY27k7ZyBqUap
 WFHgRtYyJxzh1OOSP16WfJMlgBL5SNJapbj6hyZpOJyqaoSLPqms4PtdU417S5chay2u
 UnHCUuEOvkwG7JKr4G8WnhQ4R4P21ZKt/AiIudfYCS8PUWYBek1pVaShtDuZ/utdQsV4
 XaDdrCVEkTVp8izxM58LCesHsznSrBMnfg1+Ech8SdaEQjlvOXlgPOeio27siEtc8m2Q
 2nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790842437; x=1791447237;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fvwBTziuJil7awK1BirVtL95VwyAIpQoQ8DrI2HQrgk=;
 b=iFBoiEkSg+4sZ8YTnX38lBC512afoi57vNf/NJgJWkE7SfxkX0qzoAqv1lg7a6dNPs
 s2OWX9SvUxrzQ3gQQ0beyyvyCYCka71g+gXsr6nT7eivoOoMMrCx2oISo8JiJLqP5s1A
 rIvVcumwBW3kXvwJ8iKd8cqO1jisNnBbnJ/QUs/VlyoRjUyw7vCFCyezVJxUmxwR0unO
 gT79F4RrPo2LuZ0DIc3AyZsEyFl5CzopFlorePcbR1NRTCcjnnf1I4Kx/z+YVYpJE51x
 7oZrgIzPD14YJuN6997jM6VD9tQYpnTiH5HcH5Pxl/5Osmf3Du0x0/U/xZzQ/i4iIIRv
 +Yrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcL+ERHOj8HIW+/6YkwRfqoKKOB7Bijb8YtB88JlIV4hv/xnL9VapeTkjtPv5XAz9g7MH89xYJsjwM@nongnu.org
X-Gm-Message-State: AFq9FYJ/6NoLkhCm34B6k7rF0SSaBH5QCMe19Wem0LFY2+rhK9e1ORhN
 Ot3GkP/EDWNjUuhjpm0+tt+KnxaLISrNkjZmZ+137lnvmn05ccsCe5pin53KMFtXPpUAOR40Kgi
 UbIr1cchlW27eSvtfWOgdzNKwaf4hpVI=
X-Gm-Gg: AYBFou2edkIoXjPz6lN7pY77nBowVW0+/QPIAPw8yze2Xhu3M53rxGn+o5yXpTJ7eLK
 5I6vOth47CgrUSFRCHO0UizfXAiRWDrg88OOOXogKktHRMlu+4mQSIzbqMVwnD3eYWVrzRxIPgM
 y6ALfVwcSGi7ediSUJeVeD0ctBXS9lyDPMyhl8yBSg2+kS1jNtc4pZBdah3e6HAdRTaxNDLpiym
 ltxuWDriTjfRi0Pdqu/uoe+M4sQWsQfkRydHze3V53OSHqxntK5yrIRENtBocpX4dN5Zr2Ydwvo
 zQu/wixKF+IWIVhVaD0LiSqlpPeDsMrN8BhfcRYYv3TlB1y/ItQTWvw=
X-Received: by 2002:a05:6402:a247:20b0:6ae:27e8:d115 with SMTP id
 4fb4d7f45d1cf-6ae27e8eaeamr1827313a12.39.1790842436582; Thu, 01 Oct 2026
 01:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
 <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
 <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
 <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
 <ar4TQtKqfXX5Ul9O@redhat.com>
In-Reply-To: <ar4TQtKqfXX5Ul9O@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 1 Oct 2026 16:13:44 +0800
X-Gm-Features: AclHuK8OOCj8p_L1pER-N4NEuAKz8EEYKZb0Hm2GItLOFEaa8VXJt9YkmlVpqTA
Message-ID: <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Stafford Horne <shorne@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Fabiano Rosas <farosas@suse.de>,
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
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 THIS_AD=2.599 autolearn=no autolearn_force=no
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

On Thu, Oct 1, 2026 at 4:01=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Sep 30, 2026 at 09:23:50PM -0700, Pierrick Bouvier wrote:
> > On 9/30/26 6:55 PM, Yonggang Luo wrote:
> > > On Thu, Oct 1, 2026 at 2:19=E2=80=AFAM Pierrick Bouvier
> > > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > > >
> > > > On 9/26/26 1:15 AM, Yonggang Luo wrote:
> > > > > - Add machine_class_set_name() so boards can keep a stable -M nam=
e
> > > > >     when the QOM type is uniquified. machine_class_base_init stil=
l
> > > > >     defaults the name to the QOM type without -machine.
> > > > > - Document that MachineClass::name is the -M name, not the QOM ty=
pe.
> > > > > - Sort -M help by MachineClass::name so order matches the printed=
 names
> > > > >     when QOM types are prefixed (arm-virt-11.1-machine vs virt-11=
.1).
> > > > >
> > > > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > > > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > > > ---
> > > > >    hw/core/machine.c        |  6 ++++++
> > > > >    include/hw/core/boards.h | 12 +++++++++++-
> > > > >    system/vl.c              |  8 +++-----
> > > > >    3 files changed, 20 insertions(+), 6 deletions(-)
> > > > >
> > > >
> > > > First, I'm not opposed to this series, and if anyone wants to pull =
this,
> > > > I'm ok with that decision. It's just unclear for me what will be
> > > > direction after this step.
> > > >
> > > > If I understand correctly, the goal here is to allow to register
> > > > multiple "virt" machines, while still having distinct QOM types beh=
ind
> > > > the hood, which does no affect behavior of current binaries who hav=
e
> > > > only a single "virt" type at most.
> > > >
> > > > That said, if we project in the future where we have a binary with
> > > > multiple of those "virt" machines, how will the current series help=
? The
> > > > situation we'll have is distinct QOM types, that all answer to the =
name
> > > > "virt", so we have no way to select them individually.
> > > >
> > > > Slightly worse, find_machine() will just pick the first machine nam=
e
> > > > virt, which is a non-deterministic order at the moment.
> > > > https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_=
type=3Dheads#L846
> > >
> > > That will handle it properly. For single-target binary qemu-system-$a=
rch.exe,
> > > this won't be an issue, as there is no conflict as they won't be comp=
iled in.
> > > For multi-target binary qemu-system.exe, we will choose the target th=
rough
> > > -M $arch:$machine, and when no $arch is specified, the default to arc=
h
> > > to be "none",
> > > so still won't be non-deterministic.
> > >
> >
> > > "when no $arch is specified, the default to arch to be "none",so stil=
l >
> > won't be non-deterministic.
> >
> > That's my point, the current abstraction will create something ambiguou=
s by
> > design. When people will specify -M virt, without $arch:, a random mach=
ine
> > will be selected. At least, maybe this series should ensure there is on=
ly
> > one virt alias, or make it forbidden and uses unambiguous names only.
>
> Yes, if there are multiple choices, we should not pick an arbitrary one
> non-deterministically, we must require the user to narrow the choice
> explicitly in some manner.
>
> > "$arch:" is just a workaround to not add -target option, except that it
> > comes with additional problems, creating inconsistent command lines.
> > I already expressed my skepticism about the "machine prefix" based appr=
oach,
> > being more in favor to strongly filter types per target with an unambig=
uous
> > -target option. I'll accept the community's choice on this, but just wa=
nted
> > to see this explained before someone hits the pull button on this serie=
s, so
> > they know what will come down the road.
>
> Historically, QEMU do alot of things like this where we invented magic
> syntax that needed custom parsing of the command line. Over time we
> came to the conclusion this ad-hoc parsing was a bad idea, and we
> should always explicitly model things, even if it is more verbose.
>
> Thus I would not want to see "$target:$machine" as something that is
> parsed into two pieces.
>
> IOW, "aarch64-virt" would be OK as a unique name which treated as an
> opaque string, but "aarch64:virt" as something split into "aarch64"
> (target) and "virt" (machine) would be a bad idea.
>
> An acceptable way of modelling the latter would be to use
>
>   '-machine name=3Dvirt,target=3Daarch64'



>
> or
>
>   -machine virt -target aarch64


That's made me confused, as different people propose different ways to
handle it.
Can we just choose one first?
'-machine name=3Dvirt,target=3Daarch64' is introducing new options, so is
'-machine virt -target aarch64'
I can not argue which is better, my suggestion may land one first. Both
"-machine virt -target aarch64" and "-machine $arch:$name" I have
already implemented. And currently I chose
"-machine $arch:$name" according to
https://patchwork.ozlabs.org/project/qemu-devel/cover/20260828225901.367438=
-1-pierrick.bouvier@oss.qualcomm.com/#3749257

>
> Inferring from the binary name would be acceptable too, as that can
> be thought of a syntax sugar for "-target aarch64".
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

