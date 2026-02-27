Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C198FD7F96
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 11:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvvhZ-0001lB-BD; Fri, 27 Feb 2026 06:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvvhR-0001j5-Pu
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:08:02 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvvhO-0007da-3h
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:08:01 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-436e8758b91so1252022f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 03:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772190467; cv=none;
 d=google.com; s=arc-20240605;
 b=USIPJPngdmjX6+E/6yVEZkAWOPvJyDW1V0Nmm+/aXq4OKoTh2129MQjyhVAS+hUX+Y
 ER2yeiXXGM2Umh7dZujDEfGz9fPFoCOkOOEgJDSkNxkZGhNvpwHU3esMSrtz2wYxRABH
 Pr+u7kwW5dkfvwuCKNaa84z9x0otQ6M3b3vLBZoTLv48do3AEnCBmjzJKYCH9RWYXBcr
 4/UuyLN8osFOdQX7ADk4Vg06RwzoaWFg5RIR4Pq6f2Re40oB415ttA0sQ9QR2ZBWCFSh
 JOuokY5pxni+w5LCUpqDMr82wYwdOe9XaxxRBdvHdLnt8Dx4ivDAkPOhvGCE4QolHXyy
 Torw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3tRbjJpbjdubI+HMRFv7XEcmCgBp3uJW9hI8g8bCw+w=;
 fh=YTxI/2B0tIA4OGE8g1nLoHfXTEPH/KCzPpRqw/hY+Dc=;
 b=k05A+qwkU2qbhoJlG94YNHdc/J+uVbkLo9x+Ek65SKyMEGLqnfG0ZdtTOu7cvp4SpN
 7FULO0dNzGpIXaza49cZFOT/ypK0WlN9JsWA2CO7VqafOdd1o3sTf+9UjD2DZabYBpmk
 qZJcHCRJDRq/Yg0z/mH6nBD/3rDG5UpEzRIlvVNQ2wIACGMTQFrpgnY1T2hHlVWlRuvX
 GUEyhHAyrmoNj/o9PXN/yksoNrN+Ov/8jNNWSKkqBqqjuCfvFa/0zTkJ+TCTJzAULJ5u
 2CY+0UTeHnvHj3obtRw2eJNgV+AR12F4flBWE53DUoeOLW16GJM4dYwYGuM04co20qZ2
 0rNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772190467; x=1772795267; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tRbjJpbjdubI+HMRFv7XEcmCgBp3uJW9hI8g8bCw+w=;
 b=eJ/LeB49K2xO9eTbC9TZwz7/KgET31FAKOzldgCPVi0YBkWYqz42pz+eZi+NTxr9M/
 dR8EbvGfBrw8rGlZzlftx2URHnPVtyVYdKpddHRcRsrStM6gGgJkSYVvg4MMcOx9XDFi
 H5Im6pjDO/byzmp6SGgLTtooQrQ3jOaBoJDSGD0fxevTQQpoaMW78Dgs39YyAsNNST7X
 n7OyIq8t8h0uV9Ekz+o6vggXpsYSZzSbAS5naOj7uRKw41bPmunk/3ALV7eQeApdMF5Y
 pgRIWzjY8LFB5+NUZkQpht/OeFKWxzk/g3N9FYRaIY9V9ihp+8bw99VNrmbe9gCa141s
 vPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772190467; x=1772795267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3tRbjJpbjdubI+HMRFv7XEcmCgBp3uJW9hI8g8bCw+w=;
 b=FZZgo5Qk6V5qMh66WvhAhAuq/j4hGItSk2AqjOZykSWQ3f/g2kLYeMUx7ZScqPNoFZ
 Nd+JEcCJngj/W2KLjIDWdP84cp1aVIV9kdgWG5hL8gDbINz3qbAlwehufiSz3lwaLDPA
 yjCGfcj70UBhSfuD7E4JS6ldJqCU3LEyy5RYyQq1KNOCer9CXdnR9yFnI2lMk18Y4wSw
 VXmQH6wwsDTHMaPllLl4y8dAhjH8fy7nzkUKTl+dRsZdhb9M/uHkgA3qmQ5jbdoFTdFu
 USIbh9GseS3QfOe+dzpB83d1n7YPktFsNSL6BuiH0dlUyEt2jclGElMjwZg/AIrwDVdp
 /7Sg==
X-Gm-Message-State: AOJu0Yz76LmKMArz+1A6Y359O3eaYW1sHE+gemTDcqfuwBYqkyYDF3aw
 HEW1OJvacjTbw5TqvrutAr9YgEyMG7J098PJYfkynp5K4KcSUEI95NR6jjJ5IYQVTYgPmfe10dE
 U8AYhT6088QSPxBn/pA93icJg9jZ9zrC9fAqwpC0Fhw==
X-Gm-Gg: ATEYQzwPiyS6/vhX5AdM60VaqEhacpmt6ivdmVd97lF4Ufkz9wyXAQsLhQp7oNgwdv0
 sME5/oTEO2bAb4G5O9TT/TaIXBHg9zxsHbpAu5G5muo6ASIFC1Za+LRrmY9h5DsKcruw4KY6JyB
 eTDPZ5yJ5OWVvcb6wId8wasCiEtSIZ9L17NPUr53q4E50NZArkxX+WUl1QXH5BS72/oDBnTWdGA
 8Do9NFW7ZBKtKe9azgkfreMVXdXJWogFkATfu9yOXOd0abI94uIJH18dUh5LlKqYCDDnPQfQgzF
 XH2iLJDwdS5J0flTBX5l9HGGjQtzyJ8s2iZm4OxPIYeFisLZMw==
X-Received: by 2002:a05:6000:18a8:b0:432:8537:85ca with SMTP id
 ffacd0b85a97d-4399de344b1mr4092652f8f.50.1772190467171; Fri, 27 Feb 2026
 03:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-5-philmd@linaro.org>
In-Reply-To: <20260227104314.81038-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 27 Feb 2026 13:07:21 +0200
X-Gm-Features: AaiRm53OCiiKtNuNcgDvz_U10o4iUETVAPgaOgVBkqxLMUouUMCscxR4-2TG-to
Message-ID: <CAAjaMXby0XUxnOHLzPXBk6bU8c81+frs7OfpJzJQaNNO90w9Gg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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
> gdb_static_features[] only contains strings, nothing target-specific.

Nit:
It does though, doesn't it?

./aarch64-softmmu-gdbstub-xml.c will contain aarch64-core.xml etc and
./x86_64-softmmu-gdbstub-xml.c will contain i386-64bit.xml. You
probably meant "does not depend on target-specific code".

Changes LGTM

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



> Instead of generating one file per target, generate a single file
> with a single gdb_static_features[] array.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  meson.build                               | 14 --------------
>  stubs/gdbstub.c =3D> gdbstub/gdb-xml-stub.c |  0
>  gdbstub/meson.build                       | 21 +++++++++++++++++++++
>  stubs/meson.build                         |  2 --
>  4 files changed, 21 insertions(+), 16 deletions(-)
>  rename stubs/gdbstub.c =3D> gdbstub/gdb-xml-stub.c (100%)
>
> diff --git a/meson.build b/meson.build
> index 56a746fed00..875a0bb1999 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4221,7 +4221,6 @@ if have_rust
>  endif
>
>
> -feature_to_c =3D find_program('scripts/feature_to_c.py')
>  rust_root_crate =3D find_program('scripts/rust/rust_root_crate.sh')
>
>  if host_os =3D=3D 'darwin'
> @@ -4301,19 +4300,6 @@ foreach target : target_dirs
>      endif
>    endif
>
> -  if 'TARGET_XML_FILES' in config_target
> -    gdbstub_xml_files =3D []
> -    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
> -      gdbstub_xml_files +=3D 'gdbstub/gdb-xml/' + gdbstub_xml
> -    endforeach
> -    gdbstub_xml =3D custom_target(target + '-gdbstub-xml.c',
> -                                output: target + '-gdbstub-xml.c',
> -                                input: files(gdbstub_xml_files),
> -                                command: [feature_to_c, '@INPUT@'],
> -                                capture: true)
> -    arch_srcs +=3D gdbstub_xml
> -  endif
> -
>    if target in config_target_info
>      arch_srcs +=3D config_target_info[target]
>    else
> diff --git a/stubs/gdbstub.c b/gdbstub/gdb-xml-stub.c
> similarity index 100%
> rename from stubs/gdbstub.c
> rename to gdbstub/gdb-xml-stub.c
> diff --git a/gdbstub/meson.build b/gdbstub/meson.build
> index 15c666f5752..a25a5ae9fbf 100644
> --- a/gdbstub/meson.build
> +++ b/gdbstub/meson.build
> @@ -4,6 +4,27 @@
>  # types such as hwaddr.
>  #
>
> +gdbstub_xml_files =3D []
> +foreach target : target_dirs
> +  config_target =3D config_target_mak[target]
> +  if 'TARGET_XML_FILES' in config_target
> +    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
> +      gdbstub_xml_files +=3D 'gdb-xml/' + gdbstub_xml
> +    endforeach
> +  endif
> +endforeach
> +if gdbstub_xml_files.length() > 0
> +  feature_to_c =3D find_program('../scripts/feature_to_c.py')
> +  gdbstub_xml =3D custom_target('gdbstub-xml.c',
> +                              output: 'gdbstub-xml.c',
> +                              input: files(gdbstub_xml_files),
> +                              command: [feature_to_c, '@INPUT@'],
> +                              capture: true)
> +else
> +  gdbstub_xml =3D files('gdb-xml-stub.c')
> +endif
> +common_ss.add(gdbstub_xml)
> +
>  # We build two versions of gdbstub, one for each mode
>  user_ss.add(files(
>    'gdbstub.c',
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 8a07059500d..1e0f6f47377 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -89,8 +89,6 @@ if have_system
>  endif
>
>  if have_system or have_user
> -  stub_ss.add(files('gdbstub.c'))
> -
>    # Also included in have_system for --disable-tcg builds
>    stub_ss.add(files('replay.c'))
>
> --
> 2.52.0
>
>

