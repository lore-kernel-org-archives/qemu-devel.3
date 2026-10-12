Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95330CA9EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5fU-0002Oc-Ie; Sun, 11 Oct 2026 22:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xG5fC-0002LQ-RC
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 22:21:22 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xG5fA-0005BH-GX
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 22:21:18 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so794525a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 19:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791771675; cv=none;
 d=google.com; s=arc-20260327;
 b=g8K953ex6oaCcz3T4Lop+5oDu+jAZHe2iW9IPsFfYjaWnmNRStuWtnESg8ew6ygoXZ
 f97ZWWS+F+fyN2eUm1RbYwac2ZwFvrDLlY405DY1hVgzZJLRisJNl1GHf9wptkKqBLvJ
 LSo5ivlV/znLKNKlcDNKoWNjF2H8Y+bRAQrzxjP+5aNCrh4yIYxVgQrlX8/NMhJQ7jOb
 GwpBWvoZ6+ksGCjbgHiuDytA1J408FQyk8N1wy/mcU/3+otwGWyJrNXOp71UYHPLQawH
 kAEsXFcFpDbWaOW3ZXU6+LqYBEoJSuDl9pfsDj0Sk+icZ6yzwtAfC4N8U6Y8OZu+Nk5G
 IOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ovQ/oJNPl4ewc3byDU6T9X6sfX9a5IpLb3zhsfLiI8Y=;
 fh=L72Db3obxlifReEXQb+uH6frX4M3iTm6DtZ0aNaqQBY=;
 b=QCj9QQEVi8rdOqsEEM5sH0DJyW3QKps43FSi5EMWFKbtlQ6L9IhYR4JWnYEKV+D6SN
 C4z4UDrNGG+w9CR6u8urAnDhesMeEmniaeHq4D/MTZ35ZTRPs9uSNZ5uf/EeFKoHUM9E
 JH0QhlrOO5I3lxMK6NHdg5q/x7a5nADR+F8UHu0n+1Jh8PrypiWfMJ2aUkZxF/6cghA8
 ZHFOZzb99nSweLQXVSjM5GYWDKi+3tiYn4k1xDqCXXhsbKPsht10gyqErV6w9FgDgMby
 gDkvBFaIpldxiLfBdRew42U3wQ7NDR3UxV7b/ii9YsKBFH7zhQoc9BeUw3ohdM37X8mZ
 2e5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791771675; x=1792376475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ovQ/oJNPl4ewc3byDU6T9X6sfX9a5IpLb3zhsfLiI8Y=;
 b=MH51EROv5QRiObZkFrssr+dZh7TFzYqHVGLiTIlT3y4XX5YGbyPWyeAdPje3M0vpoW
 BzIpz/8rF6KkrnZ27bMCakz9CPgMLj5Z/p70EHBpOJqo7KwawI4+APYrZhtuNPmMbeCt
 3VnZS+yDTOPbsTHKIGOBCly5GYOksdGW8v8ii6Uiqx4tQZYtOTx0ipDToXNbXcQpyOrl
 kN4myflZAkNifZewjeaVk2CpwCIzh/3VTQpVnTqSFJvSk3+hg+95FpN8N88KOXWQ1ALk
 K3hmr0i84Dry7KyLnU49qjIUM0DiYNE1zhjp/SIW+lnCtyXKwPDUZDQ9DzUe/GGkxI8e
 i7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791771675; x=1792376475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ovQ/oJNPl4ewc3byDU6T9X6sfX9a5IpLb3zhsfLiI8Y=;
 b=oHWOXeHk62ylk3GBwwnJ1XCR/1e9JjTFI+c9u5OmbOReeN97fFAJElBLlTqoXB56Zt
 0wVUs9cDXZVMpEOnbfHA00vyYWQTTUR+/BYlsDWvWuPWVzBz6ueeMZ7j++98Lr/sqVt5
 /bNVxGnHt5KyYX05HLadzc+AtcmP+bOLaE3R726rTmZVSVDkqDl16zhygvUas4/vlRG+
 x05BmCT72XGt83IJN9LAZEG1ealig0MFGj68nFmbuYPt4g/6uUxestZvP4wGY8EOK4oh
 YSAHxDDCdr/hl2GKgypsXniAGyFgC62xJWtbg+6YupTHw4REZaRLy0Y5r/yyhd3yaIUg
 MAdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByXWdCgy1eET01zvpuXTgmTmnYT2swmdD+gzb+rbTQD4LssVfg41RRFzLakRCgtnuehvnyxekxWn0LD@nongnu.org
X-Gm-Message-State: AFq9FYLWtF6nivpyEF9mK3byxwV+cw2gxOPaRh+yUKiCtMSBgXJFTpug
 4SiKVE6WbOmFu4bW1wzcArnTmX+Ytyzyop6SfxXVadPk1xY3GWWjwjNGA2nNSj9jl5O/NVfTrMm
 Ij7SwSexxcBh06w1GexZJbJ/YHodlhuA=
X-Gm-Gg: AYBFou2flmaaGeVgPEsQtI2DAwcw+0ABEUCoHW93u9cojTG9QC7l1j8JoSr1ntrioJ4
 57xvgKCibCTjuWbizLT401/uE4K8cmZV7JcI9e7ygE0hfWP3iu33Ir2616o2/TpMkax4uAqT8s4
 iLhRbdAplILFMXmY83J9L5QSZEegTvtDoIH3NCSPDUR3bxrdjtSYKSxVCqMJ/iURnsg3O+RRRLF
 RYnqkdgNzhmYupywWE0S8vtw2gc3F/D8HX3QwlGMlpnBEzwYj2BFOLLJoyCfOa7ySS8kltjZuCT
 15/BtP6yPjtdXJL9XwEmryZzkiIviyFNx1iViMeZIDq3EnbpaeJpwHLw
X-Received: by 2002:a05:6402:46c6:b0:6b1:c265:a5ad with SMTP id
 4fb4d7f45d1cf-6b1c265a835mr1088089a12.32.1791771674461; Sun, 11 Oct 2026
 19:21:14 -0700 (PDT)
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
In-Reply-To: <8cb24445-b659-4bd4-9497-888ce152e82d@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 12 Oct 2026 10:21:01 +0800
X-Gm-Features: AclHuK8fDYqLvheVbFYZWZMEHuUoQ3qrUAbW2GNHe2LS3LWycroaN8fd7hP9lrI
Message-ID: <CAE2XoE98=8yCac1-Q=gghGWqAScDMvJD_Os6fNf=aJzhZMfnTQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52b.google.com
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

On Mon, Oct 12, 2026 at 10:13=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/11/26 1:22 PM, Yonggang Luo wrote:
> > On Fri, Oct 9, 2026 at 2:34=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
> >>> On Fri, Oct 9, 2026 at 12:06=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
> >>>>> On Thu, Oct 8, 2026 at 5:42=E2=80=AFPM Daniel P. Berrang=C3=A9 <ber=
range@redhat.com> wrote:
> >>>>>>
> >>>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
> >>>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> >>>>>>>> This allows a combined binary to register machine types from all=
 its targets.
> >>>>>>>> Consequently, QMP `query-machines` can return machine entries fr=
om every
> >>>>>>>> target, even when `none` is selected. For example, a client can =
query the
> >>>>>>>> combined machine list with:
> >>>>>>>>
> >>>>>>>> ```json
> >>>>>>>> { "execute": "query-machines" }
> >>>>>>>> ```
> >>>>>>>>
> >>>>>>>> The returned list includes the registered machine classes from a=
ll linked
> >>>>>>>> targets. This is separate from selecting a machine: with `-targe=
t none`,
> >>>>>>>> `-M virt` reports the targets that provide `virt` instead of cho=
osing one
> >>>>>>>> arbitrarily:
> >>>>>>>>
> >>>>>>>> ```text
> >>>>>>>> qemu-system -target none -M virt
> >>>>>>>> unsupported machine type: "virt" for target "none"
> >>>>>>>> Available for targets:
> >>>>>>>>    aarch64
> >>>>>>>>    arm
> >>>>>>>> ```
> >>>>>>>>
> >>>>>>>
> >>>>>>>  From the long conversation on a previous thread, I thought we re=
ached
> >>>>>>> the conclusion that if we didn't expose any ambiguous name, then =
-target
> >>>>>>> option is unnecessary, or maybe I got lost on track of this threa=
d.
> >>>>>>>
> >>>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
> >>>>>>>
> >>>>>>> I'm not sure which semantic we want to have with -target none. If=
 there
> >>>>>>> is no ambiguous name registered, we just don't need it at all. It=
's a
> >>>>>>> win-win IMHO.
> >>>>>>
> >>>>>> Yes, if we expose unique names for every machine, then -target is =
then
> >>>>>> redundant.
> >>>>>
> >>>>> so how to diff riscv32-virt and risv64-virt? oh so for this machine=
 we
> >>>>> needs two name?
> >>>>> "virt" needs register twice for it? or register only a single time,
> >>>>> but we prefix the target_name()
> >>>>> automatically? for example machine::name =3D=3D=3D "virt", but we c=
an use
> >>>>> "riscv32-virt" "risv64-virt" to reach it?
> >>>>>
> >>>>
> >>>> Yes, ideally we should have different variant of virt for 32/64 bit.
> >>>> Same goes for cpu max types.
> >>>>
> >>>> QOM type is always registered unambiguously ("$arch-virt"). Then, fo=
r
> >>>> the "alias" name, which is virt, in case multiple matches are found,
> >>>> command line can return an error with list of unambiguous names to c=
all it.
> >>>>
> >>>> $ qemu-system -M virt
> >>>> Multiple virt machines are available. Please choose one of them:
> >>>> - aarch64-virt
> >>>> - riscv64-virt
> >>>>
> >>>> There is no "parsing" of the argument, it's just the real QOM type. =
Then
> >>>> we can find which target it implements from mc->targets.
> >>>> And then, we can automatically choose which cpus should be available
> >>>> based on that, thanks to cpu->targets.
> >>>>
> >>>> For existing binaries, nothing change.
> >>>
> >>> Good, I think we found a clean way now, is_available should be
> >>> removed, and TypeInfo::targets and TypeImpl::targets should be added.
> >>
> >> It goes into MachineClass only for now.
> >>
> >>> I think
> >>> for "virt" we can add a shared hw/machine-virt.c instead, and forward=
ing to
> >>> the $arch specific virt. so that we only have a single "virt" registe=
red.
> >>> And it's
> >>> targets is
> >>> QEMU_ARCH_I386 |
> >>> QEMU_ARCH_ARM |
> >>> QEMU_ARCH_RISCV |
> >>> QEMU_ARCH_LOONGARCH |
> >>> QEMU_ARCH_M68K |
> >>> QEMU_ARCH_OR1K |
> >>> QEMU_ARCH_XTENSA |
> >>> QEMU_ARCH_HEXAGON
> >>>
> >>> So that we won't have a list of conflict QOM names for "virt" machine=
s.
> >>> As now we indeed have only a single "virt" machine that redirects to
> >>> different targets.
> >>>
> >>
> >> The idea looks appealing, but I don't think it solves the problem to
> >> have multiple virt variants available at the same time.
> >>
> >> The "alias" idea you introduced before is good, we just need to add a
> >> check if an alias is really unique, else return an error, as explained
> >> previously.
> >>
> >> If "-M aarch64-virt" works for both the new and existing binary, and -=
M
> >> virt only for existing binaries (and ambiguous for new one), I think
> >> that's a safe approach.
> >>
> >>>
> >>> For other types also conflict can be handled in the same way, such as
> >>> "-cpu host" "-cpu max"
> >>> maybe others, but I think they all have the same way to deal with.
> >>>
> >>>
> >>> That's why  TypeInfo::targets and TypeImpl::targets better than sole
> >>> Machine::targets
> >>>
> >>
> >> One step at a time.
> >> Let's keep focused on declaring targets for a single machine first.
> >> Then we can iterate to solve the "virt" problem.
> >> Then convert all the existing machines and add a check in machine-targ=
et.c
> >> Then, and only then, we can see what happens with cpus.
> >
> > I tried this idea, but I faced a fatal error, because the
> > target_info() is not available until
> > the machine selected(the target arch will be select just along with
> > the machine selected), so basically
> > all calls to target_info() would raise an error(null pointer), how to
> > deal with it?
> >
>
> I see. Indeed, since we can't set a target before registering all types,
> it implies that all the types class_init can't use target_* functions.
>
>
> - register_accel_target_type
> - cpu_max_v8_register_type

Hi Pierrick

These two I can handle it properly, only for the "virt" machine I can
not handle it properly
What you suggest, it's a must-be requirement now.


for example, cpu_max_v8_register_type can be handle in such way:

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



register_accel_target_type:

 accel/accel-common.c             | 21 ++++++---------------
 include/accel/accel-cpu-target.h |  3 +--
 include/accel/accel-cpu.h        |  2 ++
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 00a400243f0..c4c365f38c7 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -126,21 +126,12 @@ static const TypeInfo accel_types[] =3D {
         .instance_size  =3D sizeof(AccelState),
         .abstract       =3D true,
     },
+    {
+        .name           =3D TYPE_ACCEL_CPU,
+        .parent         =3D TYPE_OBJECT,
+        .abstract       =3D true,
+        .class_size     =3D sizeof(AccelCPUClass),
+    },
 };

 DEFINE_TYPES(accel_types)
-
-static void register_accel_target_type(void)
-{
-    g_autofree char *name =3D g_strconcat("accel-", target_cpu_type(), NUL=
L);
-    const TypeInfo accel_cpu_type =3D {
-        .name =3D name,
-        .parent =3D TYPE_OBJECT,
-        .abstract =3D true,
-        .class_size =3D sizeof(AccelCPUClass),
-    };
-
-    type_register_static(&accel_cpu_type);
-}
-
-type_init(register_accel_target_type);
diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-tar=
get.h
index 6feb344e29b..cf33ebd79fc 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -24,8 +24,7 @@
 #include "accel/accel-cpu.h"
 #include "cpu.h"

-#define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
-#define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
+#define ACCEL_CPU_NAME(name) (name "-accel-" CPU_RESOLVING_TYPE)
 DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)

 #endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 9e7eede7c3c..5cfc2b24223 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -12,6 +12,8 @@
 #include "qom/object.h"
 #include "hw/core/cpu.h"

+#define TYPE_ACCEL_CPU "accel-cpu"
+
 typedef struct AccelCPUClass {
     ObjectClass parent_class;


>
>
> >>
> >> Regards,
> >> Pierrick
> >
> >
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

