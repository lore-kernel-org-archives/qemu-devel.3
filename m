Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D7CCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESwI-00046i-TI; Wed, 07 Oct 2026 10:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xESvo-0003tM-Jp
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:47:56 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xESvl-0003FO-3U
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:47:44 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6afb793964eso3036566a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791384459; cv=none;
 d=google.com; s=arc-20260327;
 b=sDbRorOeY6hRcyEAtktU/amrdqwVpN8WcSzsj3balzo7c0Y2Hm5QmH1wqu5pb2qoe4
 8/gtpXBxkxe88YsCxqaBWNIkM4XCvnz565iwQ4uJ1jLwoDAZzGK8n1qkBlcualgXZYXF
 k/LJ+s1SYqQhR+IXLwJcBrmCs4ZLaYpSZeXYb8nM3JbcvoG1dwCJZ2guG+cY8NPjxYrf
 tGi9DDJp89MXzgdMwDpSdm+pEqtvOlkS7skoxLHqm8tr6bkN+ntptmlZj0h5lGQj2w3s
 CgWz3G/Z1crm903TlwDPwmw8icHuNpZZu4DEV5f9n9TtlY1yXiYKZ8JAe5wyXbfRTs6O
 gDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=+LxA4EVnwcK1iX84oxsUSNIKtkwXsdKgOLQ/dyPRvTs=;
 fh=Rf2FRz2f6v7UzNXpm/2mOpceTA62539SES2epONmX8A=;
 b=p7e4VoCNR50GlBUPpbavUoW9vIZyJvmDtoQAmd9RleaKaJ7ylTsywDFhk87fCIv+LF
 CC12r6yMcTcAU6ZKYcZ4DVE9Hf1bkt0oqmydA0NZ6SjTuKvAAomNiWhXMZGLDQRJeDwl
 FSVVrXj7/dxwIs822zYp4QBxlSVM6KbDeMP2UM62HasxeZrCIjhe3zfCXFQBnlQi6Ps8
 glYqOfvdQw81xbHlP0XhjG/3jPX0KapOzfVWAhCqdb7mWM4qMKKCbXCx8GAqyfXQJlzn
 xZ7JQW6gljJnu7AYOsLEQ6ro5A4ZOEJNqndIkNV7q5/kshTzT/li8FX/rG7PEgFTtVQH
 IOgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791384459; x=1791989259; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+LxA4EVnwcK1iX84oxsUSNIKtkwXsdKgOLQ/dyPRvTs=;
 b=mVMH3QCBocKn+xPHm3ZL6djv85MBCsHJOIKTOm8CZW+uwBw+rk8HhoJ3tEvvW1+pD2
 cYUFlJFUhOwxy++hhyaE4DbN5WmVKSt4W4JB3zBRb/LhBlTxpVD6/Dqb5gSItKtQuiSJ
 QpU31tOPM/1/wDqTw/os88qf4gN0eya4s7686TgJWYlct8MoNUQg/XJuP0dscuifo4yR
 TwCIy40u+s5x9x3sGjQsntKoIBm9Fw63arxUhRa55zNZ6AM7GX8hmxd1pDqo11c0Gj9Q
 n081IcoJuhDVHqYdN5ja6zakGkDDhZZvFS0/2gE6QAaRAtvgiSSvoJX/9reZpJLv+kVC
 BWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384459; x=1791989259;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+LxA4EVnwcK1iX84oxsUSNIKtkwXsdKgOLQ/dyPRvTs=;
 b=kwQe24seomxwBCvVfHZyp5d2QRRg4YTSDCA6sGZL03sikn+Y8BhAsReSkSS5mMf4Zb
 4BAlMQI0lAEVQfWPZhFrLN5jdes1AlRZ3/egnjE4Z3UIM+yyqh4DHaryhz8snk/52667
 e5W/Fyxh/QW6RnByCZHuJZUWTAgRFMhY2vR8qRmeyxSQnk9I5bFPdaF7TPKQbkaU0kpM
 mU6X40SVolCBWWUt8nFNlojDXdN/KORWIoLfz+q3t8jTLBz/Y1XL4Adwl0QHWyE1WeOg
 hwO8cvhJxM77ph7c8BYQ0bQV6V6kMZSgavpAI4ABxzYQg9pw3Hm+/vXlbHov0xfN4j7J
 QHhA==
X-Gm-Message-State: AFq9FYInGrQDdDAGXDRPkWDkAVpPV4kUAVErL6Pp6Rjg4fUVlWLQ0oYg
 TKLhQyPT98Jk8fouoDBZgLNYwnEaIr/WzwcX8lh/sIXvQNbvEArNM0WHLfAyqYYMiMhe2OnGzfJ
 qeEOkK4N9ujhbX2ZKY7yL1l52KucfBOw=
X-Gm-Gg: AYBFou2jq/cMwWdpA+psN9qHpoY4KqfIT6H8D+2YYsoj13OWudcA0ipXeXozbfLRZlH
 owvoncluLnIp6TV4xl4nsOne5OpSOKzTNjkVxXk/5N2slhfdn2x1mzN7S+IKTGUUU3+OFXlTpsQ
 1fSgs9yacbj9g6+Mor5xJ42jCKR4iBCnWn5UZsnhMAaTBVH42DsM4673qey6sedY9hLz0a2jNzw
 vbTcZlWT3+UCQZXwZJXui5OsYdoTYH9jNECd8bxG7S4vOjN85FYycA0UUM5drNP5KA3njjoBLfS
 G60ZXkC5hOL+KwO3xWF+GI1OupfBLgqaFbAXlG3vtetu+IKBgHzNNQLU
X-Received: by 2002:a05:6402:915:b0:6ab:d416:d479 with SMTP id
 4fb4d7f45d1cf-6aff3903e3emr2375855a12.8.1791384458744; Wed, 07 Oct 2026
 07:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8mDS9dadJzb_rt9ofj+g7T_-Mn20TRMMia0HOeu2bvkw@mail.gmail.com>
 <52b6baff-e692-4379-a724-3e9ae968110c@oss.qualcomm.com>
In-Reply-To: <52b6baff-e692-4379-a724-3e9ae968110c@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 22:47:25 +0800
X-Gm-Features: AclHuK9R8BRApe3QLUo4TmWA_svsciLLNU2tkD2efLw4fr5EEprqw_5onsp6_WU
Message-ID: <CAE2XoE820gUO6q8SE9-2rjaBdz_YwPjKkzPs9qV1e1AZ-5-t8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] meson.build: export TARGET_ARCH_VARIANT in target
 config
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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

On Wed, Oct 7, 2026 at 10:29=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/7/2026 12:48 AM, Yonggang Luo wrote:
> > On Wed, Oct 7, 2026 at 12:03=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
> >> based on endianness, are accessible through TARGET_NAME. However,
> >> TARGET_NAME is a string, and thus can't be concatenated to generate co=
de
> >> and retrieve matching SYS_EMU_TARGET enum entry.
> >> Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
> >> identifier.
> >>
> >> There is one more subtlety, user binaries have extra targets that are
> >> not present in SYS_EMU_TARGET, like armeb.
> >> Thus, for user binaries, simply export TARGET_ARCH.
> >
> >
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  meson.build | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/meson.build b/meson.build
> >> index cae1591cd28..9bcfe84daba 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -3288,7 +3288,14 @@ default_targets =3D 'CONFIG_DEFAULT_TARGETS' in=
 config_host
> >>  actual_target_dirs =3D []
> >>  fdt_required =3D []
> >>  foreach target : target_dirs
> >> -  config_target =3D { 'TARGET_NAME': target.split('-')[0] }
> >> +  target_name =3D target.split('-')[0]
> >> +  config_target =3D { 'TARGET_NAME': target_name }
> >> +  if target.endswith('linux-user')
> >> +    config_target +=3D { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
> >
> > If TARGET_ARCH_VARIANT or just called (TARGET_NAME_ENUM) is just a
> > direct mapping of target_name regardless linux-user/bsd-user/softmmu,
> > the logic would
> > be simpler. That would need add more enum to SYS_EMU_TARGET, the
> > current form is:
> > ##
> > # @SysEmuTarget:
> > #     The comprehensive enumeration of QEMU system emulation
> > #     ("softmmu") targets.  Run "./configure --help" in the project
> > #     root directory, and look for the \*-softmmu targets near the
> > #     "--target-list" option.  The individual target constants are not
> > #     documented here, for the time being.
> > #
> > # @rx: since 5.0
> > #
> > # @avr: since 5.1
> > #
> > # @loongarch64: since 7.1
> > #
> > # @hexagon: since 11.0
> > #
> > # .. note:: The resulting QMP strings can be appended to the
> > #    "qemu-system-" prefix to produce the corresponding QEMU
> > #    executable name.  This is true even for "qemu-system-x86_64".
> > #
> > # Since: 3.0
> > ##
> > { 'enum' : 'SysEmuTarget',
> >   'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386=
',
> >              'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
> >              'mips64el', 'mipsel', 'or1k', 'ppc',
> >              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> >              'sh4eb', 'sparc', 'sparc64', 'tricore',
> >              'x86_64', 'xtensa', 'xtensaeb' ] }
> >
> >
> > The list target names that missing from SysEmuTarget:
> >
> > Comparing the target-name prefixes of `configs/targets/*.mak` with the
> > `SysEmuTarget` enum in `qapi/machine.json`, the following seven names a=
re
> > missing. All are Linux-user-only targets.
> >
> > | Target name | Config |
> > |---|---|
> > | `aarch64_be` | `configs/targets/aarch64_be-linux-user.mak` |
> > | `armeb` | `configs/targets/armeb-linux-user.mak` |
> > | `microblazeel` | `configs/targets/microblazeel-linux-user.mak` |
> > | `mipsn32` | `configs/targets/mipsn32-linux-user.mak` |
> > | `mipsn32el` | `configs/targets/mipsn32el-linux-user.mak` |
> > | `ppc64le` | `configs/targets/ppc64le-linux-user.mak` |
> > | `sparc32plus` | `configs/targets/sparc32plus-linux-user.mak` |
> >
> > All `*-softmmu` and `*-bsd-user` target names match enum entries.
> >
> > This comparison uses names derived from config filenames, not the
> > `TARGET_ARCH` values inside those configs.
> >
> > By doing this I think it would be more consistent.
> > If these target names are removed in future, then just remove it from
> > SysEmuTarget
> > along with. So SysEmuTarget is just a direct mapping of TARGET_NAME. Th=
ough
> > The comment of SysEmuTarget needs updated, it's not just about softmmu,=
 but also
> > for linux-user and bsd-user. But the fact is, with the current
> > changes. *-user also
> > used SysEmuTarget as an enum.
> >
> >
> > And TARGET_ARCH should also be exported by TargetInfo for other usage.
> > And it's enums is the subset
> > of enum SysEmuTarget
> >
>
> I tend to agree, but didn't find a real reason to do this change (yet).
> Also, I would be in favor to rename SysEmuTarget since in EmuTarget,
> since it would now be decoupled from system emulation only.

I think the current patch is enough at the current stage.

A better bsd-user/linux-user support needs much more work.
for example:

enum {
    QEMU_ARCH_ALPHA =3D       (1UL << SYS_EMU_TARGET_ALPHA),
    QEMU_ARCH_ARM =3D         (1UL << SYS_EMU_TARGET_ARM) |
                            (1UL << SYS_EMU_TARGET_AARCH64),
    QEMU_ARCH_I386 =3D        (1UL << SYS_EMU_TARGET_I386) |
                            (1UL << SYS_EMU_TARGET_X86_64),
    QEMU_ARCH_M68K =3D        (1UL << SYS_EMU_TARGET_M68K),
    QEMU_ARCH_MICROBLAZE =3D  (1UL << SYS_EMU_TARGET_MICROBLAZE),
    QEMU_ARCH_MIPS =3D        (1UL << SYS_EMU_TARGET_MIPS) |
                            (1UL << SYS_EMU_TARGET_MIPSEL) |
                            (1UL << SYS_EMU_TARGET_MIPS64) |
                            (1UL << SYS_EMU_TARGET_MIPS64EL),
    QEMU_ARCH_PPC =3D         (1UL << SYS_EMU_TARGET_PPC) |
                            (1UL << SYS_EMU_TARGET_PPC64),
    QEMU_ARCH_S390X =3D       (1UL << SYS_EMU_TARGET_S390X),
    QEMU_ARCH_SH4 =3D         (1UL << SYS_EMU_TARGET_SH4) |
                            (1UL << SYS_EMU_TARGET_SH4EB),
    QEMU_ARCH_SPARC =3D       (1UL << SYS_EMU_TARGET_SPARC) |
                            (1UL << SYS_EMU_TARGET_SPARC64),
    QEMU_ARCH_XTENSA =3D      (1UL << SYS_EMU_TARGET_XTENSA) |
                            (1UL << SYS_EMU_TARGET_XTENSAEB),
    QEMU_ARCH_OR1K =3D        (1UL << SYS_EMU_TARGET_OR1K),
    QEMU_ARCH_TRICORE =3D     (1UL << SYS_EMU_TARGET_TRICORE),
    QEMU_ARCH_HPPA =3D        (1UL << SYS_EMU_TARGET_HPPA),
    QEMU_ARCH_RISCV =3D       (1UL << SYS_EMU_TARGET_RISCV32) |
                            (1UL << SYS_EMU_TARGET_RISCV64),
    QEMU_ARCH_RX =3D          (1UL << SYS_EMU_TARGET_RX),
    QEMU_ARCH_AVR =3D         (1UL << SYS_EMU_TARGET_AVR),
    QEMU_ARCH_HEXAGON =3D     (1UL << SYS_EMU_TARGET_HEXAGON),
    QEMU_ARCH_LOONGARCH =3D   (1UL << SYS_EMU_TARGET_LOONGARCH64),
    QEMU_ARCH_ALL =3D         UINT32_MAX,
};

QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);

/**
 * qemu_arch_available:
 * @arch_bitmask: bitmask of QEMU_ARCH_* constants
 *
 * Return whether the current target architecture is contained in @arch_bit=
mask
 */
bool qemu_arch_available(uint32_t arch_bitmask);

arch_bitmask also needs to be increased to 64bit, and currently
SYS_EMU_TARGET__MAX is 29, very close to 32.


>
> @Daniel: Would you be favor to see such a change? I know that
> introspection/QAPI is related to system emulation, and I'm not
> completely sure adding user targets is the right move at this moment.
>
> >
> >
> >> +  else
> >> +    config_target +=3D { 'TARGET_ARCH_VARIANT': target_name.to_upper(=
) }
> >> +  endif
> >> +
> >>    if target.endswith('linux-user')
> >>      if host_os !=3D 'linux'
> >>        if default_targets
> >> @@ -3372,7 +3379,7 @@ foreach target : target_dirs
> >>        # do nothing
> >>      elif ignored.contains(k)
> >>        # do nothing
> >> -    elif k =3D=3D 'TARGET_ARCH'
> >> +    elif k =3D=3D 'TARGET_ARCH' or k =3D=3D 'TARGET_ARCH_VARIANT'
> >>        config_target_data.set(k, v.to_upper())
> >>      elif k =3D=3D 'TARGET_BASE_ARCH'
> >>        # Note that TARGET_BASE_ARCH ends up in config-target.h but it =
is
> >> --
> >> 2.43.0
> >>
> >>
> >
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

