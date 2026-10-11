Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68112CA9ECF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 20:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG0E1-0003d7-DU; Sun, 11 Oct 2026 16:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xG0Dz-0003cl-4M
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 16:32:51 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xG0Dv-0001jN-ST
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 16:32:49 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6ac76a02368so1102128a12.2
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 13:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791750765; cv=none;
 d=google.com; s=arc-20260327;
 b=LDXWuzEuoHWlmrKEbv9Ow6XG1rH9vUoitEammyj8B/pZ5bO1Dyqg07QaD5k2QxQYBQ
 hXIhzzvr9nLeVFuSjAIUsrvpjBhXDEZ64vzSLKkyyfxd9D+U+nD39aX3Slt5X6ggbTfB
 flAyZkGNOmPG8RF9XKFfkjTnljU7Ttb8N93yQ5y7+h/8ERfEjAh79h24AODCaWWbRyPT
 gmDRbKBFpDXWkJsnbc40I4kTJAx75BQFtO7dLZoD1KfdP+LWbNUwKSb6DuFZFpAsDrMZ
 VC0l8lIrVxf7AnxcGo7BTcO2ArsXvIOdcOGMnw2L7xoZ/It4W7WZqwwcs9g50gJ/9pfz
 KCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=cEIGX/lN2ilyLErZ7Upx2nuXbBDLMHMN1r7odP0Mjo8=;
 fh=lAN1XCLZ9lAIsAGNaiTyC3g0Z2KnSxoipppU4o4IrWk=;
 b=qx6fyESfeWkLqNTWLhkmM/wzJ1S66aDoprI86jADl6ATS3jtC5l0FcY7brtYZWqNNn
 45BXi+ACeiYEi0LYHZyhWjXgwIWfi0K4UMXJOgKaXArRwsBJN50lkNy/A3uloAAKa0B6
 DDbc5/IepF+s5CnkoNkH0SvrnM5svJj8Fl8pRWjJWUyaNESA1D27JWO7MKpTjg0kF/R2
 nivr4eeSTvsNmjoeRwbRGGmYay+gJu33WpwOwHZJMbP+ZHfZl6t8hL6XPnqMBmNHEHya
 726elGn2hrqjO+YRj6PuS/rPOS6svWBvXsHUtJevqBUz9Q2fVhubFNJDsKtMMG8s0xjT
 FxxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791750765; x=1792355565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cEIGX/lN2ilyLErZ7Upx2nuXbBDLMHMN1r7odP0Mjo8=;
 b=WjKMrQ4sp3Jvv2TvZGOvzLv4alKRiN1VrhkW3gFzlFrsy4fTh16y7dq1T3r3GzfjHA
 dYNvSEq4xc9I0DNcUiP7R1qBADLs42uaH0SBIFK/ZE2fPEXcbcFnzKteKVKw0Trio6y0
 V5jMYLtUGZT/Jf/ZxkN+lh2TSvKIjPv2ThJ8VAHqD4H3xYp3JplJ56xiPXFpk2t+mxfd
 0CzM5cRZtJ99sQR8qCb9NLuXvO0Qs24md1KTk5Cz/ReDQdZJ+EX90fzJdPInqTaoCFyd
 9YBFraIx67892OecbowizLLy2AmJT9JBw/fjgJ4jTc/sUoXJtGROQJqttWg6eqF1/f7Q
 1mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791750765; x=1792355565;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cEIGX/lN2ilyLErZ7Upx2nuXbBDLMHMN1r7odP0Mjo8=;
 b=XJXQ0lCDTZbaVT4ThpInn+qEAm1Sc1iKLPWyt8z6x7uu+P3BiLXiQhxgGtbbx2Dzi1
 vJ/k9KASw9VJZjtYg6eiwg1baoNp0o4gFi6d8yGKhe+6ntHvmI4fEjN4/PnTUYreOww1
 +q06qEq/P8YPn9SqZQNvAB0tqGIe7TD36oGxbyN1P06DkstM6he4tBf7pnOnDdkEXOm3
 R2yzY1eSDYtISA0WLiEhlfUHpmXUQFRQnhp79Tz2qZwLZo2bnARSFbKJo4ZAiG+TH7Hv
 C05hEpAw+BJGXYGIEoOOF4xQunlmRnFkSfvWhBhhvgte2fkvSCatPtiMNMvuhVpha7ZF
 Xzxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLsTGCnEg7ykPeQXzEOwyZyCXTou3+DaLqXdmrwhSoCrerXVcr2g5ktfGEo8Z9E8C6//lyMyPQR9j6@nongnu.org
X-Gm-Message-State: AFq9FYIKP3wNI6txyG1CwZQ9nxGiOq2FV/oibXF0ZleR8B/3gubPbLfO
 siNvmnKbjYnAp4B5fWYi4k7+qPqRkq4MzHBmXYZHPqz2KrS4AxOSdHwrqdF4uN1iv9/kVHif8Pe
 76VkwFYAPXZWP+4cb5e0mN4qCq4uTKBg=
X-Gm-Gg: AYBFou3//nDiUiv7PniSqdmTuPR5W6+o1swK3m65XcJ/R0hoAGIJXvsH2FMm6hsuHv5
 bo7vWWn+7Cn20rpHdrBxrrG/8mfxi3XeqbeYYg+/MaUE+OAqSBMsYzHyFJPUnjFDkI6xjAWYG4m
 CD072Lj4ch/hMBe1u6GXQn96rYG1jWMwOzOqoYb5CWQzn4jf0WZELl3EShQ2E4z5kJ+UakvnOvL
 cR+/A5xKl9wF4ZSIJbONK+QIMb59R9d2x9nYPW4edmAmeyBVCIhgEnN7m/We7zsWomXpOxiyOh1
 ddk6OSYfINtw2Wc2ARdkPTO9fmF5ELAbSmxMs5isn0qDT0tleXtmge3i
X-Received: by 2002:a05:6402:2347:b0:6b1:b75e:e0ba with SMTP id
 4fb4d7f45d1cf-6b1b75ee465mr1857977a12.28.1791750764936; Sun, 11 Oct 2026
 13:32:44 -0700 (PDT)
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
Date: Mon, 12 Oct 2026 04:32:31 +0800
X-Gm-Features: AclHuK-DbvKsBc31ioL7oMP1d7zCCHbO-PJVsXFTLKscW8NwOYJGAoqTVGqD64A
Message-ID: <CAE2XoE9aUkRPO=+1VQHGfkjnBLXMTbp_OqNZpu7xtGciB+Z8pg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x530.google.com
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
> Let's keep focused on declaring targets for a single machine first.
> Then we can iterate to solve the "virt" problem.
> Then convert all the existing machines and add a check in machine-target.=
c
> Then, and only then, we can see what happens with cpus.
>
> Regards,
> Pierrick

Hi Pierrick,
this is something I have to do, please have a look

 target-info.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/target-info.c b/target-info.c
index 6c5c732eba9..b5d0dce1a87 100644
--- a/target-info.c
+++ b/target-info.c
@@ -43,55 +43,61 @@ bool target_big_endian(void)
     return target_endian_mode() =3D=3D ENDIAN_MODE_BIG;
 }

+static bool target_arch_matches(uint64_t mask)
+{
+    return target_combined_binary() ||
+           (mask & (1ULL << target_arch())) !=3D 0;
+}
+
 bool target_base_arm(void)
 {
-    return (QEMU_ARCH_ARM & (1ULL << target_arch())) !=3D 0;
+    return target_arch_matches(QEMU_ARCH_ARM);
 }

 bool target_arm(void)
 {
-    return target_arch() =3D=3D EMU_TARGET_ARM ||
-           target_arch() =3D=3D EMU_TARGET_ARMEB;
+    return target_arch_matches((1ULL << EMU_TARGET_ARM) |
+                               (1ULL << EMU_TARGET_ARMEB));
 }

 bool target_aarch64(void)
 {
-    return target_arch() =3D=3D EMU_TARGET_AARCH64 ||
-           target_arch() =3D=3D EMU_TARGET_AARCH64_BE;
+    return target_arch_matches((1ULL << EMU_TARGET_AARCH64) |
+                               (1ULL << EMU_TARGET_AARCH64_BE));
 }

 bool target_m68k(void)
 {
-    return target_arch() =3D=3D EMU_TARGET_M68K;
+    return target_arch_matches(1ULL << EMU_TARGET_M68K);
 }

 bool target_or1k(void)
 {
-    return target_arch() =3D=3D EMU_TARGET_OR1K;
+    return target_arch_matches(1ULL << EMU_TARGET_OR1K);
 }

 bool target_base_ppc(void)
 {
-    return (QEMU_ARCH_PPC & (1ULL << target_arch())) !=3D 0;
+    return target_arch_matches(QEMU_ARCH_PPC);
 }

 bool target_ppc(void)
 {
-    return target_arch() =3D=3D EMU_TARGET_PPC;
+    return target_arch_matches(1ULL << EMU_TARGET_PPC);
 }

 bool target_ppc64(void)
 {
-    return target_arch() =3D=3D EMU_TARGET_PPC64 ||
-           target_arch() =3D=3D EMU_TARGET_PPC64LE;
+    return target_arch_matches((1ULL << EMU_TARGET_PPC64) |
+                               (1ULL << EMU_TARGET_PPC64LE));
 }

 bool target_s390x(void)
 {
-    return target_arch() =3D=3D EMU_TARGET_S390X;
+    return target_arch_matches(1ULL << EMU_TARGET_S390X);
 }

 bool target_riscv64(void)
 {
-    return target_arch() =3D=3D EMU_TARGET_RISCV64;
+    return target_arch_matches(1ULL << EMU_TARGET_RISCV64);
 }


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

