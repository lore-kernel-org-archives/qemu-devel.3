Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC52BCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDoTu-00089n-0f; Mon, 05 Oct 2026 15:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDoTr-000896-14
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:36:11 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDoTo-0000wj-7c
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:36:10 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6aa5d092211so3477581a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 12:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791228966; cv=none;
 d=google.com; s=arc-20260327;
 b=cb1COXdZlA1BLnBkC3kt9qH9GQCvvMKph0iQE4dRqcG5Zu3Pft4PT9yD4/QYf0H026
 fgfIa0xUi0ciNZMta+CnLhMVZZTlWDmexcVflB1lK8Rno++qPtDSmlU5hxTN2EMsztWV
 gkeDbc/13JamwJ+Jdu3jofS58uHBs+x8hH08ZuGQAysKl/voRjOaofnzUXe26J1YhuXm
 FSfa3GZidG+gNBtL0qbdh+hNRDd0A3ey7nTTys2xf+g56GoAMyHsRyNlbH2xxkZa5ANN
 stH8ubu51HOPBRiFdDtALU/nAT59SWd2mZtHrkr238av9W+LY3DcaIMkqnFAeFxMpCMX
 SVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=fCNoTCKX6u5EMBiV9qj0aGXtFoj1YDiSHgHyV+VfjfU=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=srDb44EdRv/xvOcqUQMXXRegOoOXSV6dyGx8/mOdWN0+3uXL1DcPUm/A2amSKG39yX
 qNM5uJgdL02H5o1PYg+4X0PtSVBNPFwEt59TqVBUuR/vnz1FK/4nnHQ79Pcn90vnfQSz
 CumEOnx7ILck7tQQMf4WCqj97iwJaFPmMNwhOswRj1opgJTEjcHLjuszQv6AnFRY1OZh
 SKQdwYayoLopKELomdei4WM1hy5R1xLE6Xs/E/oJjTOU3XzPwCjfHB3XSvBdJMSqsO4p
 0G3GDI4Cof86KbXliKyOLdRpB3TCOfGiljSi6o2ETHjPWs6XRjzVsJ7hO4kjmfBjcdAC
 5jYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791228966; x=1791833766; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fCNoTCKX6u5EMBiV9qj0aGXtFoj1YDiSHgHyV+VfjfU=;
 b=le8KhIaLGiiKWdyjk34BV/dQLusPR4bcZwQtg/wZph9l1Q48m2bsDM4ed1DIBqAZC3
 /998QiSFLypLXqne1qXVvZZNVELEqpSMlA2LvFMPILYzFymm9cKAYjeN5JLENLyWyWj3
 yDTUwcf2S08EviL0ACrXB+GHqow2X+bgj/PG8SIdfv0RwhujLkK0fWfXVEH+GE7uoEbg
 WPE4khf91tFKtOFNeP1XUHV8EWJTrOOZP4Krj78rhO3xMUQCiQzrU/qEWlGv+udJYass
 oJCbHyUqN8i3XoKvtXtyNEHdQsLQPHoWzqAetYJZtlooko3aSCWnb9Swwc1pbQH+seG1
 Dexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791228966; x=1791833766;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fCNoTCKX6u5EMBiV9qj0aGXtFoj1YDiSHgHyV+VfjfU=;
 b=i4Z3FMRV0wrmA9TY6f9e8pKZrqMy6RUSlU1az9WMzjl/7ryBkUrqKKagMOMr8ZDI3S
 ziWa146Yc5JJHeJwHFCF3zW2r9mYCTVu4+Nz61bDFHdvh13p9Ylnbc8TKFa2BHb8yk9M
 hPjtfVlO3Xs+I8QLUFygBSlA49af097pwkEEkSi7kILhVvPSLcBGt1S34AA+YaMxOnOE
 5ee9Sq2dyzX8RWuhFWFBhmtzjl+nRvuU0Mgz9nRDTeQNGDMIk8EWKTik2pX5kR1Jroix
 HKQHbnfl9ccfIDBzeA8bNoizTZZINABnwmktk9lbi8UNgpnEjqiRZPhy6k3rT/h+qVRP
 lHCw==
X-Gm-Message-State: AFq9FYIzzUgq1UVsoJ0DQkVKx58bBa7PiAzwNpfWOz4WtQ0zSW4bpjIm
 cxk1s4cLbC++bH44XLVeITuywXca8N3KNnrokXTOhxHlUYC+jqSepkFvI7PsfSkuidM6b2+VZsk
 xPBQ//va6sLqoMFh97UxlSpiNzJH8ads=
X-Gm-Gg: AYBFou0q4YnJ581cRR6pJoUQvcUh6EnLQULzESPLhJmKkIoWQeDc+9U10LiQVq2nP/m
 GjvP9nsxIgRuQvhUPt0BJiD0g3Lic4xUnDW6j+a4ODRGmDIWpDeELF9WvtMt1sTGvoNoYiSMgME
 ztuPI2iM6K/Z8BGAWcocWPZ6t7wI8CH9RCUqugJuu1LyO0lq0qUkbKdWexeKjPGoA09tuEO9zhx
 X++7ANOa/M7tDbf77TSOB/X81RMrQjw/qc0g+DfpAEi2xzGbsvvUEnvvaUUvanPcSF2LnlrCeYI
 wXjt6B7wDyNL2rl2OFcQrnhYfH/P8uzlz+RAHQXxBAS7m70GoBw3+Cs=
X-Received: by 2002:a05:6402:20ce:20b0:6af:bc82:e126 with SMTP id
 4fb4d7f45d1cf-6afca043e6dmr2899334a12.44.1791228966056; Mon, 05 Oct 2026
 12:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <CAE2XoE-89zTC4wPnyi_ZUu_dcVuLmwr4uyp-txkxEYQ29Y8uvw@mail.gmail.com>
 <b361fbd9-7dce-4364-bc3b-bb98fed52bb4@oss.qualcomm.com>
In-Reply-To: <b361fbd9-7dce-4364-bc3b-bb98fed52bb4@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 03:35:50 +0800
X-Gm-Features: AclHuK--3H-FQ_3R-heZEM6zP8YjMZHmyjoh9l-qywLsbxvYwJZUPfHi9HwN-Bw
Message-ID: <CAE2XoE-U_UZPX26u+Nd2jbwX=rZTWxH0cpCn8NuHK4Se+0x64Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
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

On Tue, Oct 6, 2026 at 3:15=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/5/2026 12:06 PM, Yonggang Luo wrote:
> > On Tue, Oct 6, 2026 at 2:52=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
> >>> On Tue, Oct 6, 2026 at 2:06=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
> >>>>> On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick Bouvier
> >>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>>
> >>>>>>>> Ok, but I'm not sure it answers the why.
> >>>>>>>> Could you explain the benefits?
> >>>>>>>
> >>>>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-b=
inary because
> >>>>>>> The following original code would return -1 for some user-binary
> >>>>>>> +    SysEmuTarget arch =3D target_info()->target_arch;
> >>>>>>> +
> >>>>>>> +    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
> >>>>>>> +        arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_na=
me(), -1,
> >>>>>>> +                               &error_abort);
> >>>>>>> +    }
> >>>>>>> +    return arch;
> >>>>>>> So basically assigning any value for the user binary is valid.
> >>>>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysE=
muTarget.
> >>>>>>> -1 is another option but easy to confuse.
> >>>>>>>
> >>>>>>>
> >>>>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> >>>>>>> "target-info: Statically initialize target_arch"
> >>>>>>> doing that, I am not sure.
> >>>>>>>
> >>>>>>
> >>>>>> I guess there is a (good or bad) reason for which sub variants of
> >>>>>> targets are not reflected in SYS_EMU_TARGET enum. We should double=
 check
> >>>>>> that before doing any change, as it might have other consequences.
> >>>>>
> >>>>>
> >>>>> You=E2=80=99re right to ask, and I need to correct my earlier sugge=
stion:
> >>>>> leaving user-mode target_arch
> >>>>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by AR=
M
> >>>>> code shared with user-mode builds,
> >>>>> including cpu-max-v8.c, where its result indexes a two-entry array.
> >>>>> For aarch64-linux-user, the sentinel could therefore cause an
> >>>>> out-of-bounds access during type registration.
> >>>>>
> >>>>> I checked the distinction: softmmu needs the full system-target
> >>>>> identity, including variants such as mipsel;
> >>>>> user-mode variants such as aarch64_be use their base TARGET_ARCH
> >>>>> (aarch64) for this enum. I=E2=80=99ll keep the full TARGET_SYS_EMU
> >>>>>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
> >>>>> than leave the field at SYS_EMU_TARGET__MAX.
> >>>>>
> >>>>
> >>>> That's technical details, but not an answer to the initial question =
of
> >>>> why we need to change anything for user binaries, compared to what e=
xists.
> >>>
> >>> The first two patches revert the current static initialization so the
> >>> token can be replaced. They are not a user-mode behavior change.
> >>>
> >>> Compared with current QEMU, user-mode still uses TARGET_ARCH.
> >>> qemu-mipsel already reports mips, and it still will. Names such as
> >>> aarch64_be are not SysEmuTarget values, so user-mode cannot use the
> >>> full target name for this field; keeping TARGET_ARCH preserves today'=
s
> >>> value and avoids the runtime parse.
> >>>
> >>
> >> Why should we need to expose this precise information?
> >> So far, if those targets were not exposed (and aliased to 32/64 bit
> >> variant), it's probably we didn't need it.
> >
> > because for different SysEmuTarget, the machine list is different.
> > return a wrong SysEmuTarget would cause a mismatch between SysEmuTarget
> > and the machine list. for example:
> >
> > static const char * const mips_machines[] =3D {
> >     "malta",
> >     "none",
> > };
> >
> > static const char * const mips64_machines[] =3D {
> >     "magnum",
> >     "malta",
> >     "none",
> >     "pica61",
> > };
> >
> > static const char * const mips64el_machines[] =3D {
> >     "boston",
> >     "fuloong2e",
> >     "loongson3-virt",
> >     "magnum",
> >     "malta",
> >     "none",
> >     "pica61",
> > };
> >
> > static const char * const mipsel_machines[] =3D {
> >     "malta",
> >     "none",
> > };
> >
> >
>
> I see, in this case, I would invite you to first work on how to declare
> for which target a machine is available, as discussed with Daniel on a
> previous thread.
>
> What comes out of this will give the answer about how to deal with sub
> variants.
>
> If it's a callback, it should be easy to use:
> is_available_mips64el() {
>   target_mips64() && target_big_endian()
> }

That again triggers another issue, the query-machines need to return
the endianness/target_arch() pair
for checking if the machine filtering is implemented valid to match
existing qemu-system-$arch binaries.

>
> If it's a static list of SYS_EMU_TARGET, then the easiest path will
> probably be to extend list of targets in this enum.


No, adding every user-mode target to SYS_EMU_TARGET is not necessary for th=
is
 softmmu machine-availability work. All configured softmmu targets already =
have
matching enum values. The missing variants (aarch64_be, armeb,
microblazeel, mipsn32, mipsn32el, ppc64le, and sparc32plus)
are user-mode-only here, so include them only if the availability
mechanism is intended
 to represent user-mode targets too.



>
> In all cases, that's the first thing to work on before any other step.
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

