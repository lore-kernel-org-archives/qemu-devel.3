Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1776FD7F94
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 11:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvvae-0000Yn-Qp; Fri, 27 Feb 2026 06:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvvad-0000Yc-KN
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:00:59 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvvaa-0006BE-2J
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:00:59 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-437711e9195so1402614f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 03:00:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772190054; cv=none;
 d=google.com; s=arc-20240605;
 b=VQdANAWvMifA/Cm5vYlQLqnyo8PG98E4RIprKrX6P8rQGEyUHLUHkIdgq2jyeuCp9J
 E4Dw7XCuE9XEdEOT0qnG3xRCFssFNm7/dy3cnRFYEn1JWp6wZVzoGAgde2cvhwwN9hiN
 Yl1CDktPwerunZ2BF6tBt60F1eLIsjzsZ7c7HXGJNhpuhu9CT4AwxWywuqGdltt46zQq
 yQmlGn7ZCYJMlMj7VgN0H+D2LP3nE+B+9gTn1zh8pG6nP9LaXcQd04InbpOmJLOfPTX6
 K5uZXyeLObUPYIwlXJRgXRqlymNig9pUQy7g2KzOBl8PXe3hN7qszbgRp1E79UWiSN+e
 QpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AMOQ0d1EuHWb/+Y9eyK4CjyJq369p7OcdUO+FR/5DRs=;
 fh=YTxI/2B0tIA4OGE8g1nLoHfXTEPH/KCzPpRqw/hY+Dc=;
 b=ELwcKth+X6Vd0KKRWZ9KFfhP0q6cyfhs6hLCxqZP/MWbPvGMWFBTs1mn5Ma2+yJD7o
 WzWXnok7LuXI0yfXFAZ2P5k/lhDlyj6D3sEzKL2eYqLNkPaAbpzolwn/6fhM4+kcLVj4
 MVwV/hIYYALbLsFphnzYE8qNkOkLu2yMtr1G/L4x3pF9V6w4uzwUHl4+O4ETKFnvUFUr
 8X8/PPqUb3gl/nnmiioXLgUfsCd/aUw0z1oz309T374n/V+C3yM4bhevUfRw9Jy1Jdnj
 OZYT27VeFKRwRJqgwDnTXbtn5mlduLFpdZEld8MhUC9qcEl4BKtqB4IvBpXvYVOcZqzC
 xB/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772190054; x=1772794854; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMOQ0d1EuHWb/+Y9eyK4CjyJq369p7OcdUO+FR/5DRs=;
 b=IkHhlg3JPX9qT002fJyjONM0Ftqmbm/4ZHljrcvS7rYcm3BK3damZdbVcCL49fCrSW
 U+BTcKpU64auKLdpObA81rb9ZbHCHr2hBRH0dCimM1KAooHKuPIhnXLHQsHw/SZQ8b5N
 wl0l7IKFnwYYAA0cJBasdL+5CC/Vx8IDXv/tF7hVoVbVELzJq0X5JG+k521m/2eKEXRN
 2N2lVo02bykQkKnMW2TE16B/J0syEUBzMHU0b+hiRz6+G9EZLC68mxxRNWVXpQXUIZbX
 xOZLrAJMFhHTngi4GeORnGP5CSAzZKaP8funeMpEmrHwGxqlqE4/vE1OxfJIukRunF42
 WeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772190054; x=1772794854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMOQ0d1EuHWb/+Y9eyK4CjyJq369p7OcdUO+FR/5DRs=;
 b=o3W5s5nHWxy9EzL49Z3bpMfB2rPpVvqKVfdx3YIBu6pRcEzJVtwdupV8fRtgx6NRSA
 s7F27Yu+piy/P+K/qHiXdJX/oAb4gU4SqGQXJ2zjcVoTQBnzI6qyd5Rx1W775mRdDlki
 1h9eaO93opxZ5ztxOcKwknIHgbAVj4twDXZI0RtMk7yroGqv3THHz2uSr6rnzkfiMzcN
 yydsiE4Aw+0u8pE2v/Sn4ztPKScMs5UqNxukhJxGiLBQsn7tpHcQjSUeXVKR65dwbXaR
 ziBKtLtFnLgMJhgeNMZNN9fN2fr6HBiR2/rxninxeDOhHt/IM8LpDqEIvvt71hePbxFq
 YGnA==
X-Gm-Message-State: AOJu0Yy+cam1eUp77Vyml2YnyJ6/13a67oPZrnsn0iItu0qI4oIbfEqB
 FXsNuayqIgWmGwt3FvZjxGj3ZqMKcwddaf1kgV3Vr6e+dc6B1UOm+/usob+aKWkBsGEP92Smxca
 jiLc4LbeDn7XEF4UjUs++/Z5wxCWHRdJZXzTHc/qrRQ==
X-Gm-Gg: ATEYQzyUjQINT3BgK+5ANTwCjdP9dIHjxXIe2U8pAg4JLzQytxK9XhFL4RCA8vIj3zM
 UgrpiDcW+pctvtAbPeFVJHikpq18frPECkMicmtfU7SR2DgdTcmp82txvHUMdUiFcHMw3FvsJjf
 iZYgR8NQ20TjZGI2rgstDXTKGGtpzX2UB4UfrM/3TkYQRiC89C4ZOq2ANYN4gh9VhekOiN9mdLh
 GxHOo3vu35F5st4BdQWuKIqDNqDW/pRuLDVACdrB3pNqEShr4EUUJxxRuk9VbkaRBd+mzfDapJp
 OSE5Ct9ATwPcLxM8ypLk76ktmACZFQgRvuVgkfvwIq63iePuvg==
X-Received: by 2002:a05:6000:1786:b0:436:1946:c186 with SMTP id
 ffacd0b85a97d-4399dde5f65mr4054746f8f.10.1772190053920; Fri, 27 Feb 2026
 03:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-3-philmd@linaro.org>
In-Reply-To: <20260227104314.81038-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 27 Feb 2026 13:00:27 +0200
X-Gm-Features: AaiRm52nHksodom4WLk4l_jzhi2IDoT5eYIeks5eyaDYV48bApE9IPjRhbDnP90
Message-ID: <CAAjaMXbs9a6jt38AqHGCngtoXN-fYYAjjy42RtFu65B_KsDJoQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] gdbstub: Remove 'gdb-xml/' directory prefix in
 TARGET_XML_FILES
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 27, 2026 at 12:44=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All GDB XML files are in the gdb-xml/ directory. No need to be
> so verbose in TARGET_XML_FILES, let meson prepend the directory.
>
> Except meson.build lines, this is a mechanical change done running:
>
>  $ sed -i -e s,gdb-xml/,,g $(git grep -l gdb-xml configs/targets/)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  configs/targets/aarch64-bsd-user.mak        | 2 +-
>  configs/targets/aarch64-linux-user.mak      | 2 +-
>  configs/targets/aarch64-softmmu.mak         | 2 +-
>  configs/targets/aarch64_be-linux-user.mak   | 2 +-
>  configs/targets/alpha-linux-user.mak        | 2 +-
>  configs/targets/alpha-softmmu.mak           | 2 +-
>  configs/targets/arm-bsd-user.mak            | 2 +-
>  configs/targets/arm-linux-user.mak          | 2 +-
>  configs/targets/arm-softmmu.mak             | 2 +-
>  configs/targets/armeb-linux-user.mak        | 2 +-
>  configs/targets/avr-softmmu.mak             | 2 +-
>  configs/targets/hexagon-linux-user.mak      | 2 +-
>  configs/targets/i386-bsd-user.mak           | 2 +-
>  configs/targets/i386-linux-user.mak         | 2 +-
>  configs/targets/i386-softmmu.mak            | 2 +-
>  configs/targets/loongarch64-linux-user.mak  | 2 +-
>  configs/targets/loongarch64-softmmu.mak     | 2 +-
>  configs/targets/m68k-linux-user.mak         | 2 +-
>  configs/targets/m68k-softmmu.mak            | 2 +-
>  configs/targets/microblaze-linux-user.mak   | 2 +-
>  configs/targets/microblaze-softmmu.mak      | 2 +-
>  configs/targets/microblazeel-linux-user.mak | 2 +-
>  configs/targets/microblazeel-softmmu.mak    | 2 +-
>  configs/targets/or1k-linux-user.mak         | 2 +-
>  configs/targets/or1k-softmmu.mak            | 2 +-
>  configs/targets/ppc-linux-user.mak          | 2 +-
>  configs/targets/ppc-softmmu.mak             | 2 +-
>  configs/targets/ppc64-linux-user.mak        | 2 +-
>  configs/targets/ppc64-softmmu.mak           | 2 +-
>  configs/targets/ppc64le-linux-user.mak      | 2 +-
>  configs/targets/riscv32-linux-user.mak      | 2 +-
>  configs/targets/riscv32-softmmu.mak         | 2 +-
>  configs/targets/riscv64-bsd-user.mak        | 2 +-
>  configs/targets/riscv64-linux-user.mak      | 2 +-
>  configs/targets/riscv64-softmmu.mak         | 2 +-
>  configs/targets/rx-softmmu.mak              | 2 +-
>  configs/targets/s390x-linux-user.mak        | 2 +-
>  configs/targets/s390x-softmmu.mak           | 2 +-
>  configs/targets/sparc-linux-user.mak        | 2 +-
>  configs/targets/sparc-softmmu.mak           | 2 +-
>  configs/targets/sparc32plus-linux-user.mak  | 2 +-
>  configs/targets/sparc64-linux-user.mak      | 2 +-
>  configs/targets/sparc64-softmmu.mak         | 2 +-
>  configs/targets/x86_64-bsd-user.mak         | 2 +-
>  configs/targets/x86_64-linux-user.mak       | 2 +-
>  configs/targets/x86_64-softmmu.mak          | 2 +-
>  meson.build                                 | 6 +++++-
>  47 files changed, 51 insertions(+), 47 deletions(-)
>
> diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch=
64-bsd-user.mak
> index 7f42e060477..3a839b301e4 100644
> --- a/configs/targets/aarch64-bsd-user.mak
> +++ b/configs/targets/aarch64-bsd-user.mak
> @@ -1,4 +1,4 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
> -TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb=
-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
> +TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml a=
arch64-sme2.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aar=
ch64-linux-user.mak
> index bf328b3b80c..ddfacc092dd 100644
> --- a/configs/targets/aarch64-linux-user.mak
> +++ b/configs/targets/aarch64-linux-user.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
> -TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb=
-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml
> +TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml a=
arch64-mte.xml aarch64-sme2.xml
>  TARGET_HAS_BFLT=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
> diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch6=
4-softmmu.mak
> index d14bcfc4900..9a20187e2c1 100644
> --- a/configs/targets/aarch64-softmmu.mak
> +++ b/configs/targets/aarch64-softmmu.mak
> @@ -1,7 +1,7 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
> -TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb=
-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-=
sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-pr=
ofile-mve.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
> +TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vf=
p.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m=
-profile-mve.xml aarch64-pauth.xml aarch64-sme2.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/aarch64_be-linux-user.mak b/configs/targets/=
aarch64_be-linux-user.mak
> index 284430add7b..83209fa2ae5 100644
> --- a/configs/targets/aarch64_be-linux-user.mak
> +++ b/configs/targets/aarch64_be-linux-user.mak
> @@ -1,7 +1,7 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb=
-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml
> +TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml a=
arch64-mte.xml aarch64-sme2.xml
>  TARGET_HAS_BFLT=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
> diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha=
-linux-user.mak
> index 2f1312f0362..fbb9c680915 100644
> --- a/configs/targets/alpha-linux-user.mak
> +++ b/configs/targets/alpha-linux-user.mak
> @@ -2,6 +2,6 @@ TARGET_ARCH=3Dalpha
>  TARGET_SYSTBL_ABI=3Dcommon
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_LONG_BITS=3D64
> -TARGET_XML_FILES=3D gdb-xml/alpha-core.xml
> +TARGET_XML_FILES=3D alpha-core.xml
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-so=
ftmmu.mak
> index 5c6af0eafc1..fb412d1b53f 100644
> --- a/configs/targets/alpha-softmmu.mak
> +++ b/configs/targets/alpha-softmmu.mak
> @@ -1,5 +1,5 @@
>  TARGET_ARCH=3Dalpha
>  TARGET_LONG_BITS=3D64
> -TARGET_XML_FILES=3D gdb-xml/alpha-core.xml
> +TARGET_XML_FILES=3D alpha-core.xml
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/arm-bsd-user.mak b/configs/targets/arm-bsd-u=
ser.mak
> index 472a4f9fb11..b520819e776 100644
> --- a/configs/targets/arm-bsd-user.mak
> +++ b/configs/targets/arm-bsd-user.mak
> @@ -1,3 +1,3 @@
>  TARGET_ARCH=3Darm
> -TARGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm=
-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-pr=
ofile.xml gdb-xml/arm-m-profile-mve.xml
> +TARGET_XML_FILES=3D arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysreg=
s.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/arm-linux-user.mak b/configs/targets/arm-lin=
ux-user.mak
> index bf35ded7fea..3793782d067 100644
> --- a/configs/targets/arm-linux-user.mak
> +++ b/configs/targets/arm-linux-user.mak
> @@ -1,7 +1,7 @@
>  TARGET_ARCH=3Darm
>  TARGET_SYSTBL_ABI=3Dcommon,oabi
>  TARGET_SYSTBL=3Dsyscall.tbl
> -TARGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm=
-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-pr=
ofile.xml gdb-xml/arm-m-profile-mve.xml
> +TARGET_XML_FILES=3D arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysreg=
s.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml
>  TARGET_HAS_BFLT=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
> diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmm=
u.mak
> index 6a5a8eda949..35af7da79f2 100644
> --- a/configs/targets/arm-softmmu.mak
> +++ b/configs/targets/arm-softmmu.mak
> @@ -1,5 +1,5 @@
>  TARGET_ARCH=3Darm
> -TARGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm=
-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-pr=
ofile.xml gdb-xml/arm-m-profile-mve.xml
> +TARGET_XML_FILES=3D arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysreg=
s.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/armeb-linux-user.mak b/configs/targets/armeb=
-linux-user.mak
> index 35fa4d91b3c..536bc95af71 100644
> --- a/configs/targets/armeb-linux-user.mak
> +++ b/configs/targets/armeb-linux-user.mak
> @@ -2,7 +2,7 @@ TARGET_ARCH=3Darm
>  TARGET_SYSTBL_ABI=3Dcommon,oabi
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm=
-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-pr=
ofile.xml gdb-xml/arm-m-profile-mve.xml
> +TARGET_XML_FILES=3D arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysreg=
s.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml
>  TARGET_HAS_BFLT=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
> diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmm=
u.mak
> index baf20fb7f2f..0a00f128749 100644
> --- a/configs/targets/avr-softmmu.mak
> +++ b/configs/targets/avr-softmmu.mak
> @@ -1,4 +1,4 @@
>  TARGET_ARCH=3Davr
> -TARGET_XML_FILES=3D gdb-xml/avr-cpu.xml
> +TARGET_XML_FILES=3D avr-cpu.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hex=
agon-linux-user.mak
> index 6763e2111d5..51fde5d60e6 100644
> --- a/configs/targets/hexagon-linux-user.mak
> +++ b/configs/targets/hexagon-linux-user.mak
> @@ -1,5 +1,5 @@
>  TARGET_ARCH=3Dhexagon
> -TARGET_XML_FILES=3Dgdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
> +TARGET_XML_FILES=3Dhexagon-core.xml hexagon-hvx.xml
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_SYSTBL_ABI=3Dcommon,32,hexagon,time32,stat64,rlimit,renameat
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/i386-bsd-user.mak b/configs/targets/i386-bsd=
-user.mak
> index 70e098da491..485f571cb6c 100644
> --- a/configs/targets/i386-bsd-user.mak
> +++ b/configs/targets/i386-bsd-user.mak
> @@ -1,3 +1,3 @@
>  TARGET_ARCH=3Di386
> -TARGET_XML_FILES=3D gdb-xml/i386-32bit.xml
> +TARGET_XML_FILES=3D i386-32bit.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-l=
inux-user.mak
> index ea68a266fce..a3ea4c39c52 100644
> --- a/configs/targets/i386-linux-user.mak
> +++ b/configs/targets/i386-linux-user.mak
> @@ -1,5 +1,5 @@
>  TARGET_ARCH=3Di386
>  TARGET_SYSTBL_ABI=3Di386
>  TARGET_SYSTBL=3Dsyscall_32.tbl
> -TARGET_XML_FILES=3D gdb-xml/i386-32bit.xml gdb-xml/i386-32bit-linux.xml
> +TARGET_XML_FILES=3D i386-32bit.xml i386-32bit-linux.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-soft=
mmu.mak
> index 19ef4a6690d..38a8f85201f 100644
> --- a/configs/targets/i386-softmmu.mak
> +++ b/configs/targets/i386-softmmu.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Di386
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_KVM_HAVE_RESET_PARKED_VCPU=3Dy
> -TARGET_XML_FILES=3D gdb-xml/i386-32bit.xml
> +TARGET_XML_FILES=3D i386-32bit.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets=
/loongarch64-linux-user.mak
> index 4ea12794705..63b0bfc07b8 100644
> --- a/configs/targets/loongarch64-linux-user.mak
> +++ b/configs/targets/loongarch64-linux-user.mak
> @@ -1,7 +1,7 @@
>  # Default configuration for loongarch64-linux-user
>  TARGET_ARCH=3Dloongarch64
>  TARGET_BASE_ARCH=3Dloongarch
> -TARGET_XML_FILES=3Dgdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xm=
l gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
> +TARGET_XML_FILES=3Dloongarch-base64.xml loongarch-fpu.xml loongarch-lsx.=
xml loongarch-lasx.xml
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_SYSTBL_ABI=3Dcommon,64
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/lo=
ongarch64-softmmu.mak
> index 38c0f68ddbc..476407f9413 100644
> --- a/configs/targets/loongarch64-softmmu.mak
> +++ b/configs/targets/loongarch64-softmmu.mak
> @@ -1,7 +1,7 @@
>  TARGET_ARCH=3Dloongarch64
>  TARGET_BASE_ARCH=3Dloongarch
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
> -TARGET_XML_FILES=3D gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base6=
4.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch=
-lasx.xml
> +TARGET_XML_FILES=3D loongarch-base32.xml loongarch-base64.xml loongarch-=
fpu.xml loongarch-lsx.xml loongarch-lasx.xml
>  # all boards require libfdt
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/m68k-linux-user.mak b/configs/targets/m68k-l=
inux-user.mak
> index 2d9bae22707..b64f33e759a 100644
> --- a/configs/targets/m68k-linux-user.mak
> +++ b/configs/targets/m68k-linux-user.mak
> @@ -2,6 +2,6 @@ TARGET_ARCH=3Dm68k
>  TARGET_SYSTBL_ABI=3Dcommon
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3D gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-c=
ore.xml gdb-xml/m68k-fp.xml
> +TARGET_XML_FILES=3D cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml
>  TARGET_HAS_BFLT=3Dy
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/m68k-softmmu.mak b/configs/targets/m68k-soft=
mmu.mak
> index bacc52e96a9..0bc889f326e 100644
> --- a/configs/targets/m68k-softmmu.mak
> +++ b/configs/targets/m68k-softmmu.mak
> @@ -1,4 +1,4 @@
>  TARGET_ARCH=3Dm68k
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3D gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-c=
ore.xml gdb-xml/m68k-fp.xml
> +TARGET_XML_FILES=3D cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/microblaze-linux-user.mak b/configs/targets/=
microblaze-linux-user.mak
> index 37727797695..31150f980c8 100644
> --- a/configs/targets/microblaze-linux-user.mak
> +++ b/configs/targets/microblaze-linux-user.mak
> @@ -3,5 +3,5 @@ TARGET_SYSTBL_ABI=3Dcommon
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_HAS_BFLT=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-=
protect.xml
> +TARGET_XML_FILES=3Dmicroblaze-core.xml microblaze-stack-protect.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/mic=
roblaze-softmmu.mak
> index cf635798c90..f2b6ab93fbe 100644
> --- a/configs/targets/microblaze-softmmu.mak
> +++ b/configs/targets/microblaze-softmmu.mak
> @@ -2,6 +2,6 @@ TARGET_ARCH=3Dmicroblaze
>  TARGET_BIG_ENDIAN=3Dy
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-=
protect.xml
> +TARGET_XML_FILES=3Dmicroblaze-core.xml microblaze-stack-protect.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/microblazeel-linux-user.mak b/configs/target=
s/microblazeel-linux-user.mak
> index a51a05488d3..5dcd4b5b183 100644
> --- a/configs/targets/microblazeel-linux-user.mak
> +++ b/configs/targets/microblazeel-linux-user.mak
> @@ -2,5 +2,5 @@ TARGET_ARCH=3Dmicroblaze
>  TARGET_SYSTBL_ABI=3Dcommon
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_HAS_BFLT=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-=
protect.xml
> +TARGET_XML_FILES=3Dmicroblaze-core.xml microblaze-stack-protect.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/m=
icroblazeel-softmmu.mak
> index 52feb957b48..56adbaa5ad4 100644
> --- a/configs/targets/microblazeel-softmmu.mak
> +++ b/configs/targets/microblazeel-softmmu.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Dmicroblaze
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-=
protect.xml
> +TARGET_XML_FILES=3Dmicroblaze-core.xml microblaze-stack-protect.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-l=
inux-user.mak
> index 9f8c178ef10..ecb95253680 100644
> --- a/configs/targets/or1k-linux-user.mak
> +++ b/configs/targets/or1k-linux-user.mak
> @@ -2,6 +2,6 @@ TARGET_ARCH=3Dor1k
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_SYSTBL_ABI=3Dcommon,32,or1k,time32,stat64,rlimit,renameat
>  TARGET_SYSTBL=3Dsyscall.tbl
> -TARGET_XML_FILES=3D gdb-xml/or1k-core.xml
> +TARGET_XML_FILES=3D or1k-core.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-soft=
mmu.mak
> index 24d89bc3e65..c3ca0a2c6ba 100644
> --- a/configs/targets/or1k-softmmu.mak
> +++ b/configs/targets/or1k-softmmu.mak
> @@ -2,7 +2,7 @@ TARGET_ARCH=3Dor1k
>  TARGET_BIG_ENDIAN=3Dy
>  # needed by boot.c and all boards
>  TARGET_NEED_FDT=3Dy
> -TARGET_XML_FILES=3D gdb-xml/or1k-core.xml
> +TARGET_XML_FILES=3D or1k-core.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/ppc-linux-user.mak b/configs/targets/ppc-lin=
ux-user.mak
> index 970d04a5ba1..5ddec598760 100644
> --- a/configs/targets/ppc-linux-user.mak
> +++ b/configs/targets/ppc-linux-user.mak
> @@ -2,5 +2,5 @@ TARGET_ARCH=3Dppc
>  TARGET_SYSTBL_ABI=3Dcommon,nospu,32
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3D gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml=
/power-altivec.xml gdb-xml/power-spe.xml
> +TARGET_XML_FILES=3D power-core.xml power-fpu.xml power-altivec.xml power=
-spe.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmm=
u.mak
> index 9bfa7df6c36..867898bd47c 100644
> --- a/configs/targets/ppc-softmmu.mak
> +++ b/configs/targets/ppc-softmmu.mak
> @@ -1,5 +1,5 @@
>  TARGET_ARCH=3Dppc
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
> -TARGET_XML_FILES=3D gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml=
/power-altivec.xml gdb-xml/power-spe.xml
> +TARGET_XML_FILES=3D power-core.xml power-fpu.xml power-altivec.xml power=
-spe.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/ppc64-linux-user.mak b/configs/targets/ppc64=
-linux-user.mak
> index 461f1c67d15..fcedce1b4e0 100644
> --- a/configs/targets/ppc64-linux-user.mak
> +++ b/configs/targets/ppc64-linux-user.mak
> @@ -4,5 +4,5 @@ TARGET_ABI_DIR=3Dppc
>  TARGET_SYSTBL_ABI=3Dcommon,nospu,64
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-x=
ml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
> +TARGET_XML_FILES=3D power64-core.xml power-fpu.xml power-altivec.xml pow=
er-spe.xml power-vsx.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-so=
ftmmu.mak
> index 74572864b36..10d7a2681e7 100644
> --- a/configs/targets/ppc64-softmmu.mak
> +++ b/configs/targets/ppc64-softmmu.mak
> @@ -2,7 +2,7 @@ TARGET_ARCH=3Dppc64
>  TARGET_BASE_ARCH=3Dppc
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
> -TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-x=
ml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
> +TARGET_XML_FILES=3D power64-core.xml power-fpu.xml power-altivec.xml pow=
er-spe.xml power-vsx.xml
>  # all boards require libfdt
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/ppc64le-linux-user.mak b/configs/targets/ppc=
64le-linux-user.mak
> index cf9d8a400d9..b5a81b58868 100644
> --- a/configs/targets/ppc64le-linux-user.mak
> +++ b/configs/targets/ppc64le-linux-user.mak
> @@ -3,5 +3,5 @@ TARGET_BASE_ARCH=3Dppc
>  TARGET_ABI_DIR=3Dppc
>  TARGET_SYSTBL_ABI=3Dcommon,nospu,64
>  TARGET_SYSTBL=3Dsyscall.tbl
> -TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-x=
ml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
> +TARGET_XML_FILES=3D power64-core.xml power-fpu.xml power-altivec.xml pow=
er-spe.xml power-vsx.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/ris=
cv32-linux-user.mak
> index a0ef03c0c3f..f069ab9a0f9 100644
> --- a/configs/targets/riscv32-linux-user.mak
> +++ b/configs/targets/riscv32-linux-user.mak
> @@ -1,7 +1,7 @@
>  TARGET_ARCH=3Driscv32
>  TARGET_BASE_ARCH=3Driscv
>  TARGET_ABI_DIR=3Driscv
> -TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.=
xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
> +TARGET_XML_FILES=3D riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-=
fpu.xml riscv-32bit-virtual.xml
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
>  TARGET_SYSTBL_ABI=3D32
> diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv3=
2-softmmu.mak
> index 7476e596082..26080599be7 100644
> --- a/configs/targets/riscv32-softmmu.mak
> +++ b/configs/targets/riscv32-softmmu.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Driscv32
>  TARGET_BASE_ARCH=3Driscv
> -TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.=
xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
> +TARGET_XML_FILES=3D riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-=
fpu.xml riscv-32bit-virtual.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv=
64-bsd-user.mak
> index c6348a79629..bc85d9ed04e 100644
> --- a/configs/targets/riscv64-bsd-user.mak
> +++ b/configs/targets/riscv64-bsd-user.mak
> @@ -1,5 +1,5 @@
>  TARGET_ARCH=3Driscv64
>  TARGET_BASE_ARCH=3Driscv
>  TARGET_ABI_DIR=3Driscv
> -TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.=
xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
> +TARGET_XML_FILES=3D riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-=
fpu.xml riscv-64bit-virtual.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/ris=
cv64-linux-user.mak
> index aac7568305d..bca08645124 100644
> --- a/configs/targets/riscv64-linux-user.mak
> +++ b/configs/targets/riscv64-linux-user.mak
> @@ -1,7 +1,7 @@
>  TARGET_ARCH=3Driscv64
>  TARGET_BASE_ARCH=3Driscv
>  TARGET_ABI_DIR=3Driscv
> -TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.=
xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
> +TARGET_XML_FILES=3D riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-=
fpu.xml riscv-64bit-virtual.xml
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
>  TARGET_SYSTBL_ABI=3D64
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv6=
4-softmmu.mak
> index f836f08c5b9..5059c550480 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -1,7 +1,7 @@
>  TARGET_ARCH=3Driscv64
>  TARGET_BASE_ARCH=3Driscv
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
> -TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.=
xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml gdb-xml/ris=
cv-32bit-cpu.xml gdb-xml/riscv-32bit-virtual.xml
> +TARGET_XML_FILES=3D riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-=
fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.=
mak
> index 281a165873a..1959d1b4ccc 100644
> --- a/configs/targets/rx-softmmu.mak
> +++ b/configs/targets/rx-softmmu.mak
> @@ -1,5 +1,5 @@
>  TARGET_ARCH=3Drx
> -TARGET_XML_FILES=3D gdb-xml/rx-core.xml
> +TARGET_XML_FILES=3D rx-core.xml
>  # all boards require libfdt
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/s390x-linux-user.mak b/configs/targets/s390x=
-linux-user.mak
> index e3723f5dc54..2dbcae0a6e2 100644
> --- a/configs/targets/s390x-linux-user.mak
> +++ b/configs/targets/s390x-linux-user.mak
> @@ -2,6 +2,6 @@ TARGET_ARCH=3Ds390x
>  TARGET_SYSTBL_ABI=3Dcommon,64
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xm=
l/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xm=
l gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
> +TARGET_XML_FILES=3D s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.x=
ml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-so=
ftmmu.mak
> index 544657cfe2d..e273075f1a9 100644
> --- a/configs/targets/s390x-softmmu.mak
> +++ b/configs/targets/s390x-softmmu.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Ds390x
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
> -TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xm=
l/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xm=
l gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
> +TARGET_XML_FILES=3D s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.x=
ml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc=
-linux-user.mak
> index 01446e28783..2b6f8077399 100644
> --- a/configs/targets/sparc-linux-user.mak
> +++ b/configs/targets/sparc-linux-user.mak
> @@ -2,6 +2,6 @@ TARGET_ARCH=3Dsparc
>  TARGET_SYSTBL_ABI=3Dcommon,32
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/sparc32-cpu.xml gdb-xml/sparc32-fpu.xml gdb-x=
ml/sparc32-cp0.xml
> +TARGET_XML_FILES=3Dsparc32-cpu.xml sparc32-fpu.xml sparc32-cp0.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-so=
ftmmu.mak
> index ed846735f41..126ce12abb0 100644
> --- a/configs/targets/sparc-softmmu.mak
> +++ b/configs/targets/sparc-softmmu.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Dsparc
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/sparc32-cpu.xml gdb-xml/sparc32-fpu.xml gdb-x=
ml/sparc32-cp0.xml
> +TARGET_XML_FILES=3Dsparc32-cpu.xml sparc32-fpu.xml sparc32-cp0.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets=
/sparc32plus-linux-user.mak
> index cf49c53ce44..a1d8530ecfd 100644
> --- a/configs/targets/sparc32plus-linux-user.mak
> +++ b/configs/targets/sparc32plus-linux-user.mak
> @@ -5,6 +5,6 @@ TARGET_ABI_DIR=3Dsparc
>  TARGET_SYSTBL_ABI=3Dcommon,32
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-x=
ml/sparc64-cp0.xml
> +TARGET_XML_FILES=3Dsparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/spa=
rc64-linux-user.mak
> index 81d18fcc85b..c48a03aeb9e 100644
> --- a/configs/targets/sparc64-linux-user.mak
> +++ b/configs/targets/sparc64-linux-user.mak
> @@ -4,6 +4,6 @@ TARGET_ABI_DIR=3Dsparc
>  TARGET_SYSTBL_ABI=3Dcommon,64
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-x=
ml/sparc64-cp0.xml
> +TARGET_XML_FILES=3Dsparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc6=
4-softmmu.mak
> index 602783ef0f6..4e621fb8e39 100644
> --- a/configs/targets/sparc64-softmmu.mak
> +++ b/configs/targets/sparc64-softmmu.mak
> @@ -1,7 +1,7 @@
>  TARGET_ARCH=3Dsparc64
>  TARGET_BASE_ARCH=3Dsparc
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3Dgdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-x=
ml/sparc64-cp0.xml
> +TARGET_XML_FILES=3Dsparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64=
-bsd-user.mak
> index d62d656f2c6..d754186347f 100644
> --- a/configs/targets/x86_64-bsd-user.mak
> +++ b/configs/targets/x86_64-bsd-user.mak
> @@ -1,4 +1,4 @@
>  TARGET_ARCH=3Dx86_64
>  TARGET_BASE_ARCH=3Di386
> -TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml
> +TARGET_XML_FILES=3D i386-64bit.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_=
64-linux-user.mak
> index b093ab5a167..7f9527fd1de 100644
> --- a/configs/targets/x86_64-linux-user.mak
> +++ b/configs/targets/x86_64-linux-user.mak
> @@ -2,5 +2,5 @@ TARGET_ARCH=3Dx86_64
>  TARGET_BASE_ARCH=3Di386
>  TARGET_SYSTBL_ABI=3Dcommon,64
>  TARGET_SYSTBL=3Dsyscall_64.tbl
> -TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-linux.xml
> +TARGET_XML_FILES=3D i386-64bit.xml i386-64bit-linux.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-=
softmmu.mak
> index 151862158c7..c7f8746b4f5 100644
> --- a/configs/targets/x86_64-softmmu.mak
> +++ b/configs/targets/x86_64-softmmu.mak
> @@ -2,6 +2,6 @@ TARGET_ARCH=3Dx86_64
>  TARGET_BASE_ARCH=3Di386
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_KVM_HAVE_RESET_PARKED_VCPU=3Dy
> -TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-apx.xml
> +TARGET_XML_FILES=3D i386-64bit.xml i386-64bit-apx.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/meson.build b/meson.build
> index 60415df69a1..42f9cfb5512 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4302,9 +4302,13 @@ foreach target : target_dirs
>    endif
>
>    if 'TARGET_XML_FILES' in config_target
> +    gdbstub_xml_files =3D []
> +    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
> +      gdbstub_xml_files +=3D 'gdb-xml/' + gdbstub_xml
> +    endforeach
>      gdbstub_xml =3D custom_target(target + '-gdbstub-xml.c',
>                                  output: target + '-gdbstub-xml.c',
> -                                input: files(config_target['TARGET_XML_F=
ILES'].split()),
> +                                input: files(gdbstub_xml_files),
>                                  command: [feature_to_c, '@INPUT@'],
>                                  capture: true)
>      arch_srcs +=3D gdbstub_xml
> --
> 2.52.0
>
>

