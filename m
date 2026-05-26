Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF7ECD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRr4Q-000755-TM; Tue, 26 May 2026 08:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRr4P-00074x-DL
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:39:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRr4M-0003tS-VD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:39:41 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so6439941f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779799177; cv=none;
 d=google.com; s=arc-20240605;
 b=ipXDbz6ccY3HRHyOdiwLYEIssnQMysJQ9d0sWBYPf4Q2xCit2MJbsdPWztw0/G7US7
 DKoeCN0B8Rg9mp6hhoqQTaSyuhcLoBpR7RXHxbOO/ov19aFKGXYTtt4W4oMhclNXAelo
 FU19+s88BygHF1z3AzL5MFM4cBjGn4D0DY+WQFXX5cnbmCLb8oSHsstfc8+Ve0GpAUow
 02gx7ftG+4Okb5UH76m+MaQQ4Htze8GGt/TmfYVzjoiud5tQWAey3jRZfFFVhyo5uNG7
 BNb9orWJT8RDdMQd9ceMasskCH+DjZu6ebII6QUUNGqUzqcmEqreDQzMMKqN1xX0HeoI
 jFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pARtVzn1OU32tRuPSzKkYHNeTOoyWYwIt9k4iR+SNsY=;
 fh=Z2Y+RJAyCvgSBYbNzYU3X4MXpw1pcmINz6UYe+pax2w=;
 b=RwhypabS3lw5W5OgmrPpVKdcKqHMqrWAb9wvPPA3AX4Fpa7mbaxY0TAkAe8o1kiauz
 W12tltcZXwQ0Dae2b5p2hdnjOYRPsS6amaf3clUkmOrD+y9E8uYqYwkZP+nRgEIUowq5
 4P2DqptjmqatIjCjkp3uv6+uM/yjwvDYCBn4D0DynaF/WufEu6ckyd2U8v5XCWK3DaZV
 u0j1wX1jopTr+oJKVsmYJowMOOEOpTYIgiEa3MI6DNOkWYMf3YzAG23nbBefStmKiCSF
 peXtAOQM5ECvHS2HxinQ2kuq2QH7jRqMgUOVk3THigf2dzXmabjAzV0PiFI8aNvAPgcI
 7yPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779799177; x=1780403977; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pARtVzn1OU32tRuPSzKkYHNeTOoyWYwIt9k4iR+SNsY=;
 b=BC1J8WXHLE/9iUylkBrVHs/1zny+BRcQlaQn3xAQ94ah2m3oxJ2mst9R39EK6K5v6p
 bhx7aB6cNZTqg8sq23crWY89DJpGd4PkiiImrWaJYdi9D2ybfIWJ6ZHVlJJb5GmEiM3e
 0Ra0jX8Ud224p7JZor+rcX0VcVRmkN5hua8u4wmQxg7G3ucMvN6irU06vyaOzurggw+o
 NLe3jADtFV+j9oiNRXGqUF/YiQ0OwyVwRAhFy7LpxSKscKhHN5oMi8jZ4dhT9Jyi8CiO
 JzfawqO3KFYh/chYkLnD9R/ZUg2o5LGOPy4CneMqUT0lLbo4geFhSS9YskAVfuUa0iJD
 c0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779799177; x=1780403977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pARtVzn1OU32tRuPSzKkYHNeTOoyWYwIt9k4iR+SNsY=;
 b=YYoDfuls9C8EKfYtY+i5Rxrfb/lheK/aZ4viuVpbhhmdRY3bfrp/WpMzypYUErh1kU
 jOefXtT1GGxki6yrpWy/A+ylmxPnSUhhMc5jGmY9dVGqsKEcBNf8OzLBn99zZjzOdYCq
 d4few2ZzsLH+pZaw9lS/vKyx9c0LZQBUg1bFRd+Hm1yNqn1QNbo/iFtI7XhP6wMPAY3u
 crP4857XjSZbzzgxzEOcXvVxReFgmvK+Rf+U8JL5DOJjikbdzXyEQEpR9DkGtqteN5g1
 ocqBfIaYivpPgWUsg5iQ4dz9u/UIoCf6N8dvjGgPIugQbGoBYjY9B8HC7Ezu01gLd4mK
 i6Sw==
X-Gm-Message-State: AOJu0YxEcAQH/E0OVdP3LLJncNpqvyHzammYlaUajLmC8p8TLNZmboFi
 KhUXKAMuqjzxMYqd4CdZ4VyTAhUp9bcfwZcAnmB3iGXoTUX9LCS3A7p1xOKdBt80TNh/zBavmOD
 CsMAszG5+94AuK0K6aWAo0B2DKDNylnWy0ytW3aeyvw==
X-Gm-Gg: Acq92OEywvPE6MrliQ0H2CS+WXD3xk6X6DGQ4+1o16FzzykdrYYBnIyk0kCY3vEjX6f
 jOYWqfJwTjUOucn+1UseJMTJ/B7WpJy2kGMOUKqkgEN/y4/uoaKwvYaKUOb2mbqo+wps8efK9sh
 AyTSF3LSoPEoGKdEmVuRXtgA8Nfu09AduT8iZUUaDfq1+zAFFmiVY9Ej1mjDRebzk6PyzScwW/k
 MllDkkLfdN8yF28vb3fTSS1QSat1X9rPmGznywC7LU9vdY5r4HzCyBxWujquk4y1WadBYcJD2yr
 wXAVE4mjTPfyGW1SRV4y5p2Y4NeVuo1k7IuUrYAuu8LRkEXHqg==
X-Received: by 2002:a05:6000:25e8:b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-45eb3af14fcmr31911304f8f.37.1779799177141; Tue, 26 May 2026
 05:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260526122137.64378-1-philmd@linaro.org>
In-Reply-To: <20260526122137.64378-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 26 May 2026 15:39:10 +0300
X-Gm-Features: AVHnY4JIisdh1MRJJZ7omTMja0PbcfIbF9EamwzZg0hO-CsSLq-4Ak9XqvGuGTI
Message-ID: <CAAjaMXZTCKmNFH_ELDRN9KLMnP_7Wf-yoEEux4cAZYbMMcJGZg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update PhilMD's email address
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi Philippe,

On Tue, May 26, 2026 at 3:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> philmd@linaro.org will stop working starting 2026-06-01,
> use my personal email instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Based-on: <20260519173014.98967-1-philmd@linaro.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 58 ++++++++++++++++++++++++++---------------------------
>  .mailmap    |  6 +++---
>  2 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 172f87ebda9..0808dd49d06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -68,7 +68,7 @@ Project policy and developer guides
>  R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  R: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  R: Markus Armbruster <armbru@redhat.com>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  W: https://www.qemu.org/docs/master/devel/index.html
>  S: Odd Fixes
>  F: docs/devel/build-environment.rst
> @@ -132,7 +132,7 @@ T: git https://gitlab.com/cohuck/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>
>  MIPS general architecture support
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  S: Odd Fixes
>  K: ^Subject:.*(?i)mips
> @@ -302,7 +302,7 @@ F: tests/docker/dockerfiles/debian-microblaze-cross.d=
/build-toolchain.sh
>  F: tests/functional/microblaze/
>
>  MIPS TCG CPUs
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <arikalo@gmail.com>
> @@ -533,7 +533,7 @@ Guest CPU Cores (other accelerators)
>  Overall
>  M: Richard Henderson <richard.henderson@linaro.org>
>  R: Paolo Bonzini <pbonzini@redhat.com>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Maintained
>  F: include/exec/cpu*.h
>  F: include/exec/target_long.h
> @@ -696,7 +696,7 @@ F: qemu.nsi
>  F: scripts/nsis.py
>
>  Darwin (macOS, iOS)
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Odd Fixes
>  F: .gitlab-ci.d/cirrus/macos-*
>  F: */*.m
> @@ -1012,7 +1012,7 @@ F: tests/functional/arm/test_quanta_gsj.py
>
>  Raspberry Pi
>  M: Peter Maydell <peter.maydell@linaro.org>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/raspi.c
> @@ -1314,7 +1314,7 @@ F: include/hw/misc/avr_power.h
>  F: hw/misc/avr_power.c
>
>  Arduino
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Maintained
>  F: hw/avr/arduino.c
>  F: tests/functional/avr/test_uno.py
> @@ -1448,7 +1448,7 @@ F: hw/microblaze/petalogix_ml605_mmu.c
>  MIPS Machines
>  -------------
>  Overall MIPS Machines
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Odd Fixes
>  F: configs/devices/mips*/*
>  F: hw/mips/
> @@ -1465,7 +1465,7 @@ F: hw/dma/rc4030.c
>  F: hw/nvram/ds1225y.c
>
>  Malta
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  S: Odd Fixes
>  F: hw/isa/piix.c
> @@ -1479,7 +1479,7 @@ F: tests/functional/mips*/test_tuxrun.py
>
>  Fuloong 2E
>  M: Huacai Chen <chenhuacai@kernel.org>
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  S: Odd Fixes
>  F: hw/mips/fuloong2e.c
> @@ -1503,7 +1503,7 @@ F: include/hw/intc/loongson_liointc.h
>  F: tests/functional/mips64el/test_loongson3v.py
>
>  Boston
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Aleksandar Rikalo <arikalo@gmail.com>
>  S: Odd Fixes
>  F: hw/core/loader-fit.c
> @@ -2032,7 +2032,7 @@ F: include/hw/i386/nitro_enclave.h
>  F: docs/system/i386/nitro-enclave.rst
>
>  Machine core
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Zhao Liu <zhao1.liu@intel.com>
>  S: Maintained
>  F: hw/core/cpu-common.c
> @@ -2055,7 +2055,7 @@ F: tests/unit/test-smp-parse.c
>
>  TargetInfo API
>  M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Supported
>  F: include/qemu/target-info*.h
>  F: target-info*.c
> @@ -2279,7 +2279,7 @@ F: docs/system/virtio-net-failover.rst
>  T: git https://github.com/jasowang/qemu.git net
>
>  Parallel NOR Flash devices
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Maintained
>  F: hw/block/pflash_cfi*.c
>  F: include/hw/block/flash.h
> @@ -2311,7 +2311,7 @@ S: Maintained
>  F: hw/ssi/xilinx_*
>
>  SD (Secure Card)
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  M: Bin Meng <bmeng.cn@gmail.com>
>  L: qemu-block@nongnu.org
>  S: Odd Fixes
> @@ -2765,14 +2765,14 @@ F: docs/specs/vmgenid.rst
>  F: tests/qtest/vmgenid-test.c
>
>  LED
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Maintained
>  F: include/hw/misc/led.h
>  F: hw/misc/led.c
>
>  Unimplemented device
>  M: Peter Maydell <peter.maydell@linaro.org>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Ani Sinha <ani@anisinha.ca>
>  S: Maintained
>  F: include/hw/misc/unimp.h
> @@ -2780,7 +2780,7 @@ F: hw/misc/unimp.c
>
>  Empty slot
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Ani Sinha <ani@anisinha.ca>
>  S: Maintained
>  F: include/hw/misc/empty_slot.h
> @@ -2859,14 +2859,14 @@ F: hw/display/apple-gfx*
>
>  PIIX4 South Bridge (i82371AB)
>  M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Maintained
>  F: hw/isa/piix.c
>  F: include/hw/southbridge/piix.h
>
>  VIA South Bridges (VT82C686B, VT8231)
>  M: BALATON Zoltan <balaton@eik.bme.hu>
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  S: Maintained
>  F: hw/isa/vt82c686.c
> @@ -2931,13 +2931,13 @@ F: hw/intc/openpic.c
>  F: include/hw/ppc/openpic.h
>
>  MIPS CPS
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Odd Fixes
>  F: hw/misc/mips_*
>  F: include/hw/misc/mips_*
>
>  MIPS GIC
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Odd Fixes
>  F: hw/intc/mips_gic.c
>  F: hw/timer/mips_gictimer.c
> @@ -3063,7 +3063,7 @@ F: audio/alsaaudio.c
>
>  Core Audio framework backend
>  M: Gerd Hoffmann <kraxel@redhat.com>
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Christian Schoenebeck <qemu_oss@crudebyte.com>
>  R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>  S: Odd Fixes
> @@ -3318,7 +3318,7 @@ F: tests/functional/ppc64/test_fadump.py
>
>  GDB stub
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Maintained
>  F: docs/system/gdb.rst
>  F: gdbstub/*
> @@ -3332,7 +3332,7 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
>  Memory API
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Peter Xu <peterx@redhat.com>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Supported
>  F: include/system/ioport.h
>  F: include/exec/memop.h
> @@ -3387,7 +3387,7 @@ F: tests/functional/generic/test_vnc.py
>
>  Cocoa graphics
>  M: Peter Maydell <peter.maydell@linaro.org>
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>  S: Odd Fixes
>  F: ui/cocoa.m
> @@ -3950,7 +3950,7 @@ S: Maintained
>  F: contrib/elf2dmp/
>
>  Overall sensors
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Odd Fixes
>  F: hw/sensor
>  F: include/hw/sensor
> @@ -4511,7 +4511,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
>
>  Functional testing framework
>  M: Thomas Huth <th.huth+qemu@posteo.eu>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Daniel P. Berrange <berrange@redhat.com>
>  S: Odd Fixes
>  F: docs/devel/testing/functional.rst
> @@ -4567,7 +4567,7 @@ Meson
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  R: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  R: Daniel P. Berrange <berrange@redhat.com>
> -R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  S: Maintained
>  F: meson.build
> diff --git a/.mailmap b/.mailmap
> index ce569d83f4a..ab6796090fe 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -104,9 +104,9 @@ Paul Burton <paulburton@kernel.org> <paul.burton@mips=
.com>
>  Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
>  Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
>  Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
> -Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <f4bug@amsat.org>
> -Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <philmd@redhat.com>
> -Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <philmd@fungible.com>
> +Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com> <f4bug@amsat.org>
> +Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com> <philmd@redhat.com>
> +Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com> <philmd@fungible.com>

You forgot

+Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com> <philmd@linaro.org>

With this change:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@l=
inaro.org>
>  Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
>  Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@es=
t.tech>
> --
> 2.53.0
>
>

