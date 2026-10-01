Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1FECA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCE7B-0001B4-Fc; Thu, 01 Oct 2026 06:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCE7A-0001Ai-4v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:34:12 -0400
Received: from mail-ed2-x0c.google.com ([2a00:1450:4864:33::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCE77-0000qx-Up
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:34:11 -0400
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb91ecaccso4143726a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 03:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790850848; cv=none;
 d=google.com; s=arc-20260327;
 b=FHKbblVDQ8QnYbzLIRi7OO+QLjr46m/l2B0hzyiE1LDI77ExfnusL+c4XhRR+Co99t
 7stLmC+HjdsTq7QPz/T6K/5GIf5o1NUlcdMDr/nJBTMd5w4L8aNlLG9YEEaflVYjs4SX
 g/JMcO7l60G0L9ibv0lxgF2AZcNivzXz9IyszwwQK1DINGC+PFcdiDTrfU56Og9OkJle
 XSe6RLj5gt1HVM18aASSiiuRIB0MWwGAFRY0loeF/awWiujJJ0Cf5bx98BsuYLbiSQ09
 XVHZfDo3S9DlrxGek70m07B9U1dTYcQWHH9O7kIbcPpupD9xtdVZSZKRtG7UzO/T7Z70
 q1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=BrUg2wuu2EwjYgIabj0UHM8634WA9ZKlGIgP4zayc6Y=;
 fh=oW4QhpQUW+SPQzu/JZLerrFm+/l2t/ufJ41gj2Jkv28=;
 b=FTEbTDGQSLq/YiyK9kKBj219smbrmj0K+1AXFu6XLs8vi1UMrReyL4azXt8NhL9h0d
 h/vghy9oMUFEcWfNkU/fQb8kYNtr5LwJrGwT01lpTDxWHkX6gkpVjS3i9tqDrSRqHp1W
 6S/TY3WZPlVQgiScEcK4v/xqxUGWJKgxGbDzxQdW61V52UNogEWV0bu6hahhlVNV0y1w
 HnQ7ci+Uhonk2Zs2Y0io22lha4xnZ7w6t1l4IuzzhqGpGl06MbvhE8UuZWuPH0A+h/Xh
 czNsgNM47axCMLBxq3+AzWJ4/zanlaAvAsyBApUDCKo9h25pWsjOrqpFcxFZ3F4m30A2
 QYgw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790850848; x=1791455648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BrUg2wuu2EwjYgIabj0UHM8634WA9ZKlGIgP4zayc6Y=;
 b=a5sH9yxXOLk7vAqCmh/EVMEE0SbluVjFSUdgLVV9YQMJmxujn6/xwD2mt2ACKdVieV
 7jnri661jDDTAultTra4EvkS7xkNWc1adbxnQKLY74j66S+ijqSeqb4m/NVnyW38xxvR
 ccevYwNtDa0mytfxJNtg2gDccfyjZ9cTH9ywaj3Tu/Rhq3x4CNVwcvctFprgt2J19bGK
 LxDQp/UYQPAZ0BE7bxnGBnKVwIJsVRwWKfj22nbl1cGHCEX5ZvrnfSGaCzxo6a+xzTm2
 10vGzT/zfb/BzFnxWz5m/KbykWi4u6c8X/xziuZ1lWQW52gO+vbDK+hzF9kpTjAMtIGe
 wiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790850848; x=1791455648;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BrUg2wuu2EwjYgIabj0UHM8634WA9ZKlGIgP4zayc6Y=;
 b=hiAiv9cAbZVTPDcN8sIMOJDo0llm+cSRMwReZq/WGNEa+6vd9rKptwZ4oBtVmXv2cq
 HssDlZBfeiQrXrlnUMFTX0v2Uum9RoKKe7WbrEw1fbYAy5f/+r2cR4cWApj6iy0XDzkL
 PvKAuhD/phSg9fpF4dW52GTGIT+QFzoNIUElzxKuK1mkwPykKheGxRtD5of67UcRC5Zk
 syQxjT0r4w7cqtCSSGcqTTGLtqWvBXOjgyGItcHPlSs7IGaEDiBAUSJqv6dSYN9/4mio
 h3jViHNVq/UAaqjXp1JiTakiDu6AV0vSX2UpDSu42gZH3iSAA/+ShB6cKysU7YdxH54v
 xG3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2CJUwYQYMeAysaT4D3CX91+p4IyIpuQ8ktOE1SNSVBDifj+YBjMwKNCD2KQL8rS8oFdLk2nhWpHeU@nongnu.org
X-Gm-Message-State: AFq9FYKyQyM9JCiioB2sv6ketm5WafPJhM0Dcib+h9slor6HvKb1abTy
 oPrS25R4cwJhR8xRKPK58JVZg1sDmQbCyU524xnnmK9DYUM8q2+AUqITfREx9A1LzmLDqrOXiN2
 yLEXUlq888957saeaFMHRYbStIRyliTE=
X-Gm-Gg: AYBFou0E9I833GWIyh1No0Ly8sAqJmuzy0301xi0jt1Z0msOylWMKdmlYb2C8KICLI2
 /ulIltIiXj7uM4foijhKsPMQemE/M6xvt7H5HyOIpgxdjjsH/6/xamQ1D64e2L3fy8RGD1wV/NP
 fB8Ibqv2XoObJGMoHMgxshXT1I19F/6MrJhaUF9aZq7YzSTpGKbFLhperuHuYVBQKe9JmAysObh
 VtfXYPDAS0Tev9C7CvPpPhR1frpeEsDvXvWCFokpPvG5tdBvpxn7l5LbDxRFseXOG8BWhswa+eJ
 9t7csWFn2PBIFGmjCPuorM3XYi9VkZT7mZh1+bZSC7/6KiEvGKW3sxE=
X-Received: by 2002:a05:6402:23c3:b0:6aa:ff76:3076 with SMTP id
 4fb4d7f45d1cf-6ae1994e02cmr3302015a12.32.1790850847583; Thu, 01 Oct 2026
 03:34:07 -0700 (PDT)
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
Date: Thu, 1 Oct 2026 18:33:54 +0800
X-Gm-Features: AclHuK99GMx9xSoWV4k_I6ncYLqs2a6XDkmFpJ-LJsXcstUN6sJJ-_GTYOe9dI0
Message-ID: <CAE2XoE-CKGP3y=LvkDwMPG_h5T6+Z3sWUP3TfJuu8YCFZdJTqA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:33::c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0c.google.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Philippe,
Fair point. Users shouldn=E2=80=99t need to know about other targets to use=
 ARM
virt. Keep the machine name as virt; target selection in a combined
binary should be separate from -machine. This series doesn=E2=80=99t choose=
 that
interface. With no target selected, help can list machines across targets,
but QEMU must not choose one arbitrarily.

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
> - enforce with CLI -target
> - not expose any machine
>
> That said I asked you multiple times what you are trying to
> achieve to understand and get a consensus or pick the best
> approach (we do not want to compete here, the point of the
> community is to join efforts).
> You are ignoring my questions, so this post is my last try
> before I ignore you on your future contributions. Sorry if
> it sounds unfriendly but you are about to reach the end of
> my patience, exhausting my review time.
>
> If you have AI power, please have a look at semcode + lore
> to dig in the mailing list archive and summarize the previous
> work and discussions we had before offering distinct single
> binary alternatives.
> https://github.com/facebookexperimental/semcode/blob/main/docs/lore.md
> Once installed and configured, you only need to run:
> $ semcode-index --lore qemu-devel/3
>
> >
> >>
> >> Inferring from the binary name would be acceptable too, as that can
> >> be thought of a syntax sugar for "-target aarch64".
>
> Yes. Better for my mental health to defer the merge of this work
> to you Daniel, since you already had a look a reviewed it. But
> please compare with Pierrick approach before doing so:
> https://lore.kernel.org/qemu-devel/20260930020108.217892-1-pierrick.bouvi=
er@oss.qualcomm.com/

Hi Philippe,

You=E2=80=99re right: I haven=E2=80=99t clearly explained what I=E2=80=99m =
trying to achieve, and
I=E2=80=99m sorry for not answering your questions sooner.

My goal is specifically to let a combined binary list all target-specific
machines when the target is none. This is for inspection, not for
selecting an arbitrary machine to run. Today, linking machines from
different targets hits QOM type-name conflicts. This series gives the
machine classes unique QOM names while preserving their familiar machine
names.

Pierrick=E2=80=99s series adds targets to a single linked binary and filter=
s
machines according to the selected target. Its do not care about
machine listing for target "none". These patches address that separate
case and the QOM-name conflicts; they are not intended to conflict with
Pierrick=E2=80=99s target-selection work.

I=E2=80=99m not proposing argv-based target inference or a new -target inte=
rface
in this series. qemu-system-$arch is currently a separate executable,
not a symlink to qemu-system, so argv-based selection is outside this
work. This series do not conflict with either "-target $arch -machine $mach=
ine"
or "-machine $arch:$machine"


>
> Regards,
>
> Phil.



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

