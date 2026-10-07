Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45191CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENpD-0008Sb-Im; Wed, 07 Oct 2026 05:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEMO3-0007ZO-Mh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:48:36 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEMO1-0001lc-1J
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:48:27 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6aff0c4bda3so1381807a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 00:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791359302; cv=none;
 d=google.com; s=arc-20260327;
 b=N5Ezc79mRM1LEl7fyHVclTYOH0VyaQd9DFGEfFI8Rj613peEZegzXxqp22gJQwwWsF
 46iKZbSfWqCghT9QgUJR1/2ZUVVeV1Z1foS0gYnOYilam+8SLnG6ZWqLt6TcxZ7iLeWT
 A9w70SSP5VPOcqhR6AajKXUa0NmJgToY73GVqhdxEzLIBDc/j2ErBjFu9zOKpzUMc6H7
 Xs6X3MaHYhUWAn+DeProvTYZVEdRW+uXhmfnpgyK79EOtj7nxQtpaKmS+bmrCMunbg/2
 Cd1esUd4VKRrIyQtDZrTGcjGOFFaIG0Q6zv/1EE3X+VfqZxOmkPbZhk6RNBWL/UqAeMQ
 BCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=SE8GUun90851LN5/T2Cs9hM2ZAC4j2GZ/nXpVy8lVzQ=;
 fh=Rf2FRz2f6v7UzNXpm/2mOpceTA62539SES2epONmX8A=;
 b=eV1Wd3zJgAm1ulrAgVUUF+aTPycL/aRzrHUEiM8WNvIq/7v7CwtkLi3wxgOu8fc4sD
 sKmuxUfb5ePLfY1Jf90ezwggVpxBXKxGEMzfIcHu6RsZlCTN8oskt/9wEfShqjZmNnVq
 8pib0DnMpqdLQqW6lCWrB43ZyKrqNEhLuLpi1ha1FknLYlw3d7/grAfYecdxFQanjjO0
 PBzTLd5XLwT1MOC/xmgwVcSksocA9avo4+ivEnnynhZrWLHYZNDs/cMveizduClvx6Ye
 s/VviYtth7h4Q2mdeeP2U1zdm9UDvIZDWyx5Zqz5MuQZMLzscRMxb3ux1Vf8Pg8enK2Z
 Xx2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791359302; x=1791964102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SE8GUun90851LN5/T2Cs9hM2ZAC4j2GZ/nXpVy8lVzQ=;
 b=TmoB3yyDPg7QPsRWVsXwlxiqGHVQu/dNDndBJp32xa1snnQ3Ui/N9UJV0XKajflxjL
 sPcpJn2LjItjnNUtsFcgQmIce2vnt6hkafkCPrJfBlyw/b7EpRtB/c40xxMsiGA03rdq
 9iLcmHjO3co/QA5vb8W6b7N4irfvvumc1y3uMEvBGo/BJPDMVcGgmO3qfcPavDp28KD+
 GadiKUnqDWtamcxkk50+LJ8J/rk7uLOeO6dMagykzoqjuGZn9qWh9IysBxlgilr1Rgne
 aAIo/SVYrhElmzX354xTYeGNwN10qzceR+LG8z2Mp4eImyFMd17qqfOV9SGPq5U/nDQ6
 lUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791359302; x=1791964102;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SE8GUun90851LN5/T2Cs9hM2ZAC4j2GZ/nXpVy8lVzQ=;
 b=IElSySEd84N4VR2UtV4rj4T0J4D6v8d8WYscyVaq2pHrw32eF+P/Mp4XCyOdK7egt2
 R9g3AS9Bg/anQJGc8sZGw+w0TS02ctam6bkajY9ZmrNigHxf4vVAZZmUG3x/zTdvue7h
 fKa8JZADZ2BoS8joZ51t8QZsLStPOFqUzF6Hr58qYvMUzO/ALl79ew5kBdRu/nrcEWWc
 9p4EhVm5BShSW4uAkrwbCM5rSTmlixHG/12pOMdYzydnwfdQ8isRmjnS4c89bsOppP/e
 W5nrhSkQSVqXRBQTjYt0QTaGVxPt2eMbNXdYf0+9bBeE8wKq/Cxpsys4PHWHL3U0AxsW
 Bv1g==
X-Gm-Message-State: AFq9FYKarh47s6hKmbBJAqOjAOPe2OFUsRmzKrw4w14J+kGQqQZ7o7y4
 u15c7NpCjpuWiKpps3lywtsW2cwQflyidbNcJdE+iweS7XIuP3AWV4BkFEuW8BwkwwT6IDE5FZU
 uNfvGVfjfVOfOp0EVih4owScVmfI1l80=
X-Gm-Gg: AYBFou1pwYeJiY1pZodkWXJg1+hmfil16X/TkE+93Bfcga+AIBwiRtIHh5dD/k6hSqm
 LFljAhyoNft2zGZis/zu0LuO+PsMr4Z7qOD79utppAYUJdfIiAN+5eYP6eapMmD5VwY6O5a1lEo
 inrYbY6bafVFJP0wruY08TrMhTOkIMRgHyoY301QIulTUzsJKhDTiGyy+DYF8+4gP7DRG0CAVvB
 Qtpg1fHcCTPzTqJiXEICdC599HeHBSBE3ujN0/ekfJbFynFt2ygewjGT+T3R25DP9Y4J2wkMVek
 rhB+Ha7USwES930+kSNniSpBWAFPPZdzs46kyAVXcSwgUdF2mYPSTQc=
X-Received: by 2002:a05:6402:21d0:b0:6aa:f1d2:ddb8 with SMTP id
 4fb4d7f45d1cf-6aff3966326mr1185547a12.23.1791359301755; Wed, 07 Oct 2026
 00:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 15:48:08 +0800
X-Gm-Features: AclHuK9jA_IDOdgHBG_x3kzQkVuk73VQrXwEmV6aL9NiXsYQqNt9atU6-zPp5hE
Message-ID: <CAE2XoE8mDS9dadJzb_rt9ofj+g7T_-Mn20TRMMia0HOeu2bvkw@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
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

On Wed, Oct 7, 2026 at 12:03=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
> based on endianness, are accessible through TARGET_NAME. However,
> TARGET_NAME is a string, and thus can't be concatenated to generate code
> and retrieve matching SYS_EMU_TARGET enum entry.
> Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
> identifier.
>
> There is one more subtlety, user binaries have extra targets that are
> not present in SYS_EMU_TARGET, like armeb.
> Thus, for user binaries, simply export TARGET_ARCH.


>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  meson.build | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index cae1591cd28..9bcfe84daba 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3288,7 +3288,14 @@ default_targets =3D 'CONFIG_DEFAULT_TARGETS' in co=
nfig_host
>  actual_target_dirs =3D []
>  fdt_required =3D []
>  foreach target : target_dirs
> -  config_target =3D { 'TARGET_NAME': target.split('-')[0] }
> +  target_name =3D target.split('-')[0]
> +  config_target =3D { 'TARGET_NAME': target_name }
> +  if target.endswith('linux-user')
> +    config_target +=3D { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }

If TARGET_ARCH_VARIANT or just called (TARGET_NAME_ENUM) is just a
direct mapping of target_name regardless linux-user/bsd-user/softmmu,
the logic would
be simpler. That would need add more enum to SYS_EMU_TARGET, the
current form is:
##
# @SysEmuTarget:
#     The comprehensive enumeration of QEMU system emulation
#     ("softmmu") targets.  Run "./configure --help" in the project
#     root directory, and look for the \*-softmmu targets near the
#     "--target-list" option.  The individual target constants are not
#     documented here, for the time being.
#
# @rx: since 5.0
#
# @avr: since 5.1
#
# @loongarch64: since 7.1
#
# @hexagon: since 11.0
#
# .. note:: The resulting QMP strings can be appended to the
#    "qemu-system-" prefix to produce the corresponding QEMU
#    executable name.  This is true even for "qemu-system-x86_64".
#
# Since: 3.0
##
{ 'enum' : 'SysEmuTarget',
  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
             'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
             'mips64el', 'mipsel', 'or1k', 'ppc',
             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
             'sh4eb', 'sparc', 'sparc64', 'tricore',
             'x86_64', 'xtensa', 'xtensaeb' ] }


The list target names that missing from SysEmuTarget:

Comparing the target-name prefixes of `configs/targets/*.mak` with the
`SysEmuTarget` enum in `qapi/machine.json`, the following seven names are
missing. All are Linux-user-only targets.

| Target name | Config |
|---|---|
| `aarch64_be` | `configs/targets/aarch64_be-linux-user.mak` |
| `armeb` | `configs/targets/armeb-linux-user.mak` |
| `microblazeel` | `configs/targets/microblazeel-linux-user.mak` |
| `mipsn32` | `configs/targets/mipsn32-linux-user.mak` |
| `mipsn32el` | `configs/targets/mipsn32el-linux-user.mak` |
| `ppc64le` | `configs/targets/ppc64le-linux-user.mak` |
| `sparc32plus` | `configs/targets/sparc32plus-linux-user.mak` |

All `*-softmmu` and `*-bsd-user` target names match enum entries.

This comparison uses names derived from config filenames, not the
`TARGET_ARCH` values inside those configs.

By doing this I think it would be more consistent.
If these target names are removed in future, then just remove it from
SysEmuTarget
along with. So SysEmuTarget is just a direct mapping of TARGET_NAME. Though
The comment of SysEmuTarget needs updated, it's not just about softmmu, but=
 also
for linux-user and bsd-user. But the fact is, with the current
changes. *-user also
used SysEmuTarget as an enum.


And TARGET_ARCH should also be exported by TargetInfo for other usage.
And it's enums is the subset
of enum SysEmuTarget



> +  else
> +    config_target +=3D { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
> +  endif
> +
>    if target.endswith('linux-user')
>      if host_os !=3D 'linux'
>        if default_targets
> @@ -3372,7 +3379,7 @@ foreach target : target_dirs
>        # do nothing
>      elif ignored.contains(k)
>        # do nothing
> -    elif k =3D=3D 'TARGET_ARCH'
> +    elif k =3D=3D 'TARGET_ARCH' or k =3D=3D 'TARGET_ARCH_VARIANT'
>        config_target_data.set(k, v.to_upper())
>      elif k =3D=3D 'TARGET_BASE_ARCH'
>        # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
> --
> 2.43.0
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

