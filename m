Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3437BCA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEks5-0007RR-1r; Thu, 08 Oct 2026 05:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEks0-0007Qe-Ph
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:57:00 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEkry-0006Ow-LA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:57:00 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6ab006eb282so7236044a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791453417; cv=none;
 d=google.com; s=arc-20260327;
 b=B2G8wZOzamewDNPi0vwyipX5+UUtkidfzT/5X9qza0r4R18qg5v5bslHGcj3GsYNqR
 HFzw/NAZQBozlSZCuTNgIXPhNOt0LMlIVo5Jk+zaQc8kCWmxCK1DydEtsgmyjLxzXzjG
 zwa4GURXLJo4tuLR/6F7GcncnYmrmTjdb7QzSEa5HxB0woIjr64xqLjB7Az9k8iXPmSz
 LYxP1M2eWOR8ITnbvmFgEBc5I6UQbi1/26fwdX4521zAs6d8ZC7VNh52/+1tiIqi+HtP
 5pegloQ3GXujC4HUmHv7zhOiHO6ibk4oYkX2HIQVNstZfNTHqs0u/4uhskRfXS5hRPBd
 vTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=GMQtsqQ1FJDRF98PcaOkHl7URCcYm64RX1SkqUFOO9g=;
 fh=A4k036sXYQHlw40TlUzspd0/Yof+MScpYbmq/1f5Ye4=;
 b=C8ffYpOY/UBVPvAETpmPlzGsibTEhscMN2fIcsPVXpc5cadOSRx0OlAd3pYQk+gvot
 aY0QiUDfyIUzwOym2OVAn/QFYtxPV8cZLKzLgffSioxjAEoN9bei5xCqlyX1QDLNpg8z
 Mk5qCA86SNGAoAbgvpOh7Kx4RqtTMtrG5VGJ+CXKWf+UUoNRaC2bRszehu+kYCWwaw7D
 WoQI2iOWQIBBp/oItMQheYtRSiTjtyLaPYwAUvCTyOhEzkX+E3uyP+hiI7FJPGysihep
 ySN9LRxyOM8KtsvOn5r2sfFmGT/tBfIZDTYcf/1+ssev+i/gfjISrZ91SD/k/gng4qJw
 A3FA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791453417; x=1792058217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GMQtsqQ1FJDRF98PcaOkHl7URCcYm64RX1SkqUFOO9g=;
 b=Mo+wlr1ucu8MvqLTQOT9RujfRsfUSVZRlCpTRql45lumpEhRaCvSt2Cktd4NR4WzaF
 fGmBmNEJIBKUpldJ75N+xf8QRlipDvm4YiYR6StzO0jWnJ7YcE0qNHx9G21Qc4gnjPGy
 7k0bTk683UcsIm5CpAQsiE9NKqnovII8uW17wCDYQwJ1yGaIw9UnLcBrwFU+63iff+HQ
 R/+3tju0vSs1DH4cUF6x9no67d07gWL45dVnOvdBRONxHkMPIPBm5WtWLSiweBzKSQgO
 l6sJvS198eZJHEvrYEN4beGzBbzzv+6JKILVd/qqrZ77ZlNHK6O2M9zSgdVO8VQoaIS0
 SQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791453417; x=1792058217;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GMQtsqQ1FJDRF98PcaOkHl7URCcYm64RX1SkqUFOO9g=;
 b=10IWIG1/XHPbtAXn2dpiMH52fJepxp6sZsLOY7ICt2nJc5D9HSH0chxHfQnlVb3fI7
 TQy/KJdzK/OUnTfWKPBmMlRtC4fWkWAOSBdOunYeoY0ByNnxEWcCMF41AhlAprLLBhxr
 Tumtcy8oVSZ5X6KyNPhfKEiQ1HvtvxyA/b3jYAFVp5N1kweUHUuG1CQjbBKa2rPIoGug
 uwY+Q6lGpbMi/mXwUZtmC5i3SZKWSWeuxnbDX0SaEfF1Q7kfbubBJpv/qPK5mZwN/NwH
 +8r2bz31RQU/oVFw+nI/L2aQwJ3x8EEEb61s5dMvLe1/soQGLVJoG+KOKbafJ4dypptJ
 vx5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwaL6D5J/775Cj97/gWvv+5nhGUIaljfibQFm8S2ldMMlax1xlUVeZnjTeiB6wOdbWHuXUrSknKknN@nongnu.org
X-Gm-Message-State: AFq9FYLFkJ+bVDQ8t5dtYiJBFnwb7IDpz4yFloh/OMtvEaDBowjBCWri
 +bYhU002IVcNN9qvr4xkuenC8ftNHYQiiaVGCSiP7dL9XfhBfDXdgVUKerWmebcDJV6WFb4rUXt
 HNcTQtmE+e/BlZmRojgA8XS1+MjdxIGE=
X-Gm-Gg: AYBFou1Kf6ryvyBY7Qj40tozmLHgTFAKhEloqaqliUF8lXkL0R1CRupF5M3uJPOn63E
 T76lxwJlr+pkMsTuod2TNBL2EhYPRac1w0LGKn5T/BJR6Nwj52p+BKv9lEysSneUZ1+zJdOWX+r
 gDWAxJibuHzWY7OwF8m/h8fI08Q6rQPAOiMplaQU99HWeHEwd01JCRYxtk2BtDY8DDHQBh+o1mt
 DjklLpazuOWsbTrxtxQnZP4kwP96PkQMAeYf2XuTO1uPqNVbr+vCR+FRfyCafZeJ33t9guuXMgF
 pLKBXZndVTdwmdQV0pYyUGJE0Y5U/lA/GQkSjA97lLpcK5HGcjnmIns=
X-Received: by 2002:a05:6402:21d6:b0:6ac:bbd3:5b42 with SMTP id
 4fb4d7f45d1cf-6aff377cac9mr4180458a12.11.1791453416755; Thu, 08 Oct 2026
 02:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-9-luoyonggang@gmail.com>
 <7fc0d377-a994-41f4-aa98-7ed56db11447@oss.qualcomm.com>
 <CAE2XoE8K+3e8h6H9NrPk1WWMmJfG807bN_Kh5qje-5pKWUUg5w@mail.gmail.com>
 <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
 <asdkF80SJzF2W3sD@redhat.com>
In-Reply-To: <asdkF80SJzF2W3sD@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2026 17:56:42 +0800
X-Gm-Features: AclHuK98ELtHsN7moD9Gh9l_YO5uyMakIWJzdpFSeXsEC2WYMYEMNGXjyRe2Y-Y
Message-ID: <CAE2XoE-Vc+CaE-3FerW3eXtTgspwxZJ6ZT0CZyg3ZYpoJ8xYXw@mail.gmail.com>
Subject: Re: [PATCH 8/8] qom: pass TargetInfo to is_available for later use
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52d.google.com
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

On Thu, Oct 8, 2026 at 5:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Oct 07, 2026 at 05:00:06PM -0700, Pierrick Bouvier wrote:
> > On 10/7/2026 2:42 PM, Yonggang Luo wrote:
> > > On Thu, Oct 8, 2026 at 4:44=E2=80=AFAM Pierrick Bouvier
> > > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > >>
> > >> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> > >>> Change TypeInfo.is_available to the new TypeIsAvailable type, which
> > >>> takes a const TargetInfo *. Registration passes target_info(), so
> > >>> behavior is unchanged. object.h only forward-declares TargetInfo.
> > >>>
> > >>> Switch the existing users (raspi, raspi4b, ast27x0 evb and fc) and =
the
> > >>> generated machine parents to the matching target_is_<arch> helpers.
> > >>>
> > >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > >>> ---
> > >>>  hw/arm/aspeed_ast27x0-fc.c  |  2 +-
> > >>>  hw/arm/aspeed_ast27x0_evb.c |  4 ++--
> > >>>  hw/arm/raspi.c              |  4 ++--
> > >>>  hw/arm/raspi4b.c            |  2 +-
> > >>>  hw/arm/virt.c               |  4 ++--
> > >>>  hw/m68k/virt.c              |  4 ++--
> > >>>  hw/or1k/virt.c              |  2 +-
> > >>>  include/qom/object.h        | 12 +++++++++++-
> > >>>  qom/object.c                |  3 ++-
> > >>>  9 files changed, 24 insertions(+), 13 deletions(-)
>
> snip
>
> > >>> @@ -167,7 +168,7 @@ static TypeImpl *type_register_internal(const T=
ypeInfo *info)
> > >>>          abort();
> > >>>      }
> > >>>
> > >>> -    if (info->is_available && !info->is_available()) {
> > >>> +    if (info->is_available && !info->is_available(target_info())) =
{
> > >>>          return NULL;
> > >>>      }
> > >>>
> > >>
> > >> ```
> > >> info->is_available(target_info())
> > >> ```
> > >>
> > >> or
> > >>
> > >> ```
> > >> is_available() {
> > >>   TargetInfo ti * =3D target_info();
> > >>   ...
> > >> }
> > >> ```
> > >>
> > >> Are doing the exact same thing today.
> > >>
> > >> So what is the future goal requiring to introduce this?
> > >
> > > From Daniel P. Berrang=C3=A9's
> > > requesthttps://lore.kernel.org/qemu-devel/apAszS1ewxM0Y1XU@redhat.com=
/
> > >         I forgot to mention that this is also pretty important for ma=
king
> > >         introspection work, as we need to be able to say
> > >
> > >           'qemu-system --machine none -qmp ...'
> > >
> > >         and connect to QMP to introspect the binary. Having to add a
> > >         '--target <name>' into that mix is undesirable, as it creates
> > >         a chicken & egg problem. You don't know what targets are buil=
t
> > >         into qemu-system without introspecting it and you can't
> > >         introspect it without selecting a target to introspect.
> > >
> > > From Pierrick's review
> > > https://lore.kernel.org/qemu-devel/557262df-b8e7-49b5-a245-ae46b8885b=
30@oss.qualcomm.com/So,
> > > for existing binary: -M virt works as before.
> > >
> > >         For new multi binary:
> > >         $ qemu-system -M virt:
> > >         Multiple machines were found, select one among:
> > >         - aarch64-virt
> > >         - riscv64-virt
> > >
> > >         Does it matches what you would expect?
> > >
> > > From Daniel's review
> > > https://lore.kernel.org/qemu-devel/aro93NuZBXYGbD33@redhat.com/
> > >         We already have  'QemuTargetInfo' struct which is used
> > >         with 'query-target', that should also be used with the
> > >         new 'query-targets' command.
> > >
> > >         We need to add the 'endianness' field to QemuTargetInfo.
> > >
> > >         I don't think that we need to report machines though.
> > >         We already have 'query-machines' which gives much broader
> > >         information on the machines. "MachineInfo" needs to
> > >         gain
> > >
> > >         "targets": ["SysEmuTarget"]
> > >
> > >         to list which target(s) a machine can be used with.
> > >
> > >
> > > To achieve these, we needs add TypeInfo parameter to it so that we ca=
n do
> > >
> > > static void report_unsupported_machine_type(const char *name, Error *=
*errp)
> > > {
> > >     g_autoptr(GSList) machines =3D machine_class_get_list(true);
> > >     g_autoptr(GString) targets =3D g_string_new(NULL);
> > >     TargetInfoNode *node;
> > >     GSList *el;
> > >
> > >     error_setg(errp, "unsupported machine type: \"%s\" for target \"%=
s\"",
> > >                name, target_name());
> > >     QLIST_FOREACH(node, target_info_list(), next) {
> > >         for (el =3D machines; el; el =3D el->next) {
> > >             MachineClass *mc =3D el->data;
> > >
> > >             if ((!strcmp(mc->name, name) || !g_strcmp0(mc->alias, nam=
e)) &&
> > >                 object_class_get_is_available(OBJECT_CLASS(mc))(node-=
>info)) {
> > >                 g_string_append_printf(targets, "  %s\n",
> > >                                        node->info->target_name);
> > >                 break;
> > >             }
> > >         }
> > >     }
> > >     if (targets->len) {
> > >         error_append_hint(errp, "Available for targets:\n%s", targets=
->str);
> > >     }
> > > }
> > >
> > > That is we can iterate on all target-list, and check if it's can be f=
itlered.
> > >
> >
> > Ok, I finally see where this is going.
> >
> > So, based on all the previous conversations, we agreed to have a
> > qemu-system binary with all the QOM types available (for all targets).
>
> ack.
>
> > I personally think that if we go this way, we should not have any
> > -target option, and even less a -target none option.
>
> If we don't have a compelling need for -target to exist now, then
> dropping it as a concept is good.
>
> > The current is_available() approach was made with filtering per target
> > in mind, which predates where things are now. So, it's a good time to
> > reevaluate how to do it.
> >
> > This leaves us with (at least) two options:
> > - keep the callback and add TargetInfo parameter (what is done here)
> > - remove is_available, and adopt a more declarative approach
> >
> > How about we (re)-explore the second one?
> >
> > It's what we did in the past
> > (https://gitlab.com/qemu-project/qemu/-/commit/5de9216064d32eaac125dac4=
de1878486c16d73e),
> > and that I removed recently, in favor of is_available.
> > My rationale was that it was incomplete, since we needed to filter type=
s
> > per config also, and not only target.
> > Now that direction is to not filter anything, filter per config is
> > unneeded, and switching back to declarative instead of callback makes
> > total sense. Using interfaces like we did has its own issues, and I
> > would not like to see this coming back.
> >
> > I'll do one very concrete proposal:
> >
> > ```
> > How about letting machines (and machines only first), have a new field
> > 'targets', being a uint32_t mask with an array of EMU_TARGET?
> > machine->targets =3D EMU_TARGET_X | EMU_TARGET_Y;

To be explicit state what, I give you a pseudo code to compute
machine->targets from TypeInfo::is_available(TargetInfo*)
let targets=3D0
foreach ti of TargetInfo list:
   if (machine::TypeImpl::is_avaible(ti))
         targets |=3D 1 << ti->target_arch
   fi
endif
So they basically have equivalent effect, and is_available will handle
other code-needed condition properly such as
CPU/AccelClass. not restrict to targets, we can also attach the
KConfig into TargetInfo, so is_available(TargetInfo*)
also works for Kconfig. that's why I insist this way, it's solved all
the issues around.

so  machine->targets =3D EMU_TARGET_X | EMU_TARGET_Y; is a good idea,
and it can be implemented with TypeInfo::is_available(TargetInfo*)
without much burden. and targets can be saved into a (machine or
TypeImpl) for fast access when needed, we can compute it
when the program starts.


> > ```
> >
> > @Daniel, IIUC, this is exactly the approach you proposed a few weeks
> > ago, just before I got frustrated and lost my patience against you. I
> > think it's more clear for me where you wanted to go. Sorry it took such
> > a large detour.
>
> Not a problem. We were coming at the debate with different ideas of
> where we were heading, so talking past each other at times.
>
> >
> > Yonggang, does that sounds good for you?
> > Daniel, does that sounds good for you also?
>
> Works for me.
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

