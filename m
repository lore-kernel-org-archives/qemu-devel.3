Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBBCCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVI4-0007BO-1c; Thu, 30 Oct 2025 12:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEVHx-0007Az-TU
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:14:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEVHj-0006vf-HM
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:14:12 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-427015003eeso1075372f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761840826; x=1762445626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdBuLKwYZAt2s/2TJVVb1yvlWiDv31pOD4fRdTmYC9I=;
 b=sqbsElJEgQFNL+PP3riEcU6hPG4iE81PTE8jesk7dQ05AJffpYuAnJzpbvLdxFUyOh
 wYUO+Oc+m8kHvhEPY7m7l5Xsc/AH7/T1Nsclsmjdljmnh73SmwcNR2ZRKUsYpn/5Bmd4
 RJxrlxgdPhnWD3TomGjx9DZjPd9Z2nLf3HxjfnXwGQRs9SATDIm+S3XZV1/hrVRBVnwY
 4mIxsdGt54BSDqR7Gsuu/bB7Ui6QscFFqa/RVclVJ/aRs6tbYk10osmcpuyKuSwiv4D1
 jjH3gkmbZKUfIi3REL0qxMMe/rNk/vJG/SzGyzgKEPmfKWD/Ol3jMvu3EHuqAiAULlEM
 EBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761840826; x=1762445626;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PdBuLKwYZAt2s/2TJVVb1yvlWiDv31pOD4fRdTmYC9I=;
 b=iyBlPiLcEkaTtEcDkIoE2nw0r2tXZbumqZ00EQ/6SRuSx4hhyQbizbT0AhyrQFJAaF
 Bpsu+/8MNgcszVFiStASXGwAKmp/9OwrVNvBZqQf5kJUkFUhYWWzuFV1yQdhFB36nig6
 Ya7o9O176xU9ygpqlXB59HvNTmTof82hqrAC3syvqsLTDRQ/YnSqxuy5dZQ0FTyxbePr
 HoNnhcdqsUhcouGmCKKMSRDA8tj+7mkPp2QxfyIUucWasRbSFbe3x3F5ol+ePea+l6CO
 RBEywR0tNMsuAeDq+T1kLS0z0pzxc0Fl7tPohNJYe+57lNeCXSvRnrC6kwwAgKa7QCZP
 danA==
X-Gm-Message-State: AOJu0YyYIqzxlveluuaOC/kYkmBM4vdD5oRGkpWpEPsr2FrZIgQaT0cL
 rDWvm7LiCLn3BD15GY4Dk+8QmohfwMYhutDPbWAKSybRYIqz8PWjjBaDAN/pX+Zow5E=
X-Gm-Gg: ASbGncs7N6ELLVg6zu77v8XFGcZk0RpL7VWkABltclD5N/4HwZyNeIhJ2HQjOvagiIj
 oanfSzVQaK8NJI2rXc+eGL2xxq+hb0EYS1eH9mk5oDEbElXefUqXXSJab+NEdJvVmLkye4r4ofT
 7Quy3Mox5MdGg4VGWr20qU4qBTg2lUFe1Zm8yLtD43gzz2vCamq4Vu1rZDNGYBJyCpu4eBPpisx
 /PeVOTRBLGxhrJwLf5A7M5+bbc/p8F/lx0SjeDmidbvGS1B7Yq8jVvVQ854LoQxlgbfAUuwk6c6
 9ijvd/YFbgKpfiHzBEjuWyN8HMVbt4Cxz07sDsl8dQ2prZ7KJ1DSsGQvBffsZfFjJ8tXAl0K3vK
 R1fZnEYxG9VA9OgWauGsLpST36FNHcoNTwkQ8yq/iqYal0QGPdKdGq5bJ7Eg/pksytkPb9+0KG2
 Xr
X-Google-Smtp-Source: AGHT+IEGhYb13T69rpbhIayRic/kcHTJ3azPoPdMMeBQSwrmfUMi3CbBsWwcEazVDbsyaJ3V4zq5xQ==
X-Received: by 2002:a05:6000:1aca:b0:428:bb7:1753 with SMTP id
 ffacd0b85a97d-429bd6adda0mr119239f8f.49.1761840825668; 
 Thu, 30 Oct 2025 09:13:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbc16sm31955901f8f.15.2025.10.30.09.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:13:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 07EB35F7D8;
 Thu, 30 Oct 2025 16:13:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] futex: Add qemu_futex_timedwait()
In-Reply-To: <20251029-force_rcu-v1-1-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Wed, 29 Oct 2025 15:12:45 +0900")
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-1-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Thu, 30 Oct 2025 16:13:43 +0000
Message-ID: <87pla4tljc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> qemu_futex_timedwait() is equivalent to qemu_futex_wait(), except it has
> an absolute timeout.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Hmm this broke my compile, I guess a name clash:

  FAILED: tests/qtest/stm32l4x5_usart-test.p/stm32l4x5_usart-test.c.o=20
  cc -m64 -Itests/qtest/stm32l4x5_usart-test.p -Itests/qtest -I../../tests/=
qtest -I. -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 -I/usr/li=
b/x86_64-linux-gnu/glib-2.0/include -I/usr/include/sysprof-6 -fdiagnostics-=
color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protec=
tor-strong -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-secu=
rity -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-se=
lf -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-s=
tyle-declaration -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal =
-Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missin=
g-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem /home/alex/lsr=
c/qemu.git/linux-headers -isystem linux-headers -iquote . -iquote /home/ale=
x/lsrc/qemu.git -iquote /home/alex/lsrc/qemu.git/include -iquote /home/alex=
/lsrc/qemu.git/host/include/x86_64 -iquote /home/alex/lsrc/qemu.git/host/in=
clude/generic -iquote /home/alex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -ms=
se2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-=
aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero -fzero-call-use=
d-regs=3Dused-gpr -fPIE -MD -MQ tests/qtest/stm32l4x5_usart-test.p/stm32l4x=
5_usart-test.c.o -MF tests/qtest/stm32l4x5_usart-test.p/stm32l4x5_usart-tes=
t.c.o.d -o tests/qtest/stm32l4x5_usart-test.p/stm32l4x5_usart-test.c.o -c .=
./../tests/qtest/stm32l4x5_usart-test.c
  ../../tests/qtest/stm32l4x5_usart-test.c:114:13: error: conflicting types=
 for =E2=80=98init_clocks=E2=80=99; have =E2=80=98void(QTestState *)=E2=80=
=99
    114 | static void init_clocks(QTestState *qts)
        |             ^~~~~~~~~~~
  In file included from /home/alex/lsrc/qemu.git/include/qemu/futex.h:27,
                   from /home/alex/lsrc/qemu.git/include/qemu/thread.h:6,
                   from /home/alex/lsrc/qemu.git/include/qemu/rcu.h:27,
                   from /home/alex/lsrc/qemu.git/include/hw/qdev-core.h:7,
                   from /home/alex/lsrc/qemu.git/include/hw/sysbus.h:6,
                   from /home/alex/lsrc/qemu.git/include/hw/misc/stm32l4x5_=
rcc.h:21,
                   from /home/alex/lsrc/qemu.git/include/hw/misc/stm32l4x5_=
rcc_internals.h:22,
                   from ../../tests/qtest/stm32l4x5_usart-test.c:13:
  /home/alex/lsrc/qemu.git/include/qemu/timer.h:793:6: note: previous decla=
ration of =E2=80=98init_clocks=E2=80=99 with type =E2=80=98void(void (*)(vo=
id *, QEMUClockType))=E2=80=99
    793 | void init_clocks(QEMUTimerListNotifyCB *notify_cb);
        |      ^~~~~~~~~~~
  ninja: build stopped: cannot make progress due to previous errors.
  make: *** [Makefile:168: run-ninja] Error 1
  make: Target 'all' not remade because of errors.
  make: Leaving directory '/home/alex/lsrc/qemu.git/builds/all'


> ---
>  include/qemu/futex.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/include/qemu/futex.h b/include/qemu/futex.h
> index 607613eec835..e5e56603d117 100644
> --- a/include/qemu/futex.h
> +++ b/include/qemu/futex.h
> @@ -24,6 +24,7 @@
>  #ifndef QEMU_FUTEX_H
>  #define QEMU_FUTEX_H
>=20=20
> +#include "qemu/timer.h"
>  #define HAVE_FUTEX
>=20=20
>  #ifdef CONFIG_LINUX
> @@ -42,18 +43,28 @@ static inline void qemu_futex_wake_single(void *f)
>      qemu_futex(f, FUTEX_WAKE, 1, NULL, NULL, 0);
>  }
>=20=20
> -static inline void qemu_futex_wait(void *f, unsigned val)
> +static inline bool qemu_futex_timedwait(void *f, unsigned val, int64_t n=
s)
>  {
> -    while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
> +    struct timespec ts;
> +    uint32_t bitset =3D FUTEX_BITSET_MATCH_ANY;
> +
> +    ts.tv_sec =3D ns / NANOSECONDS_PER_SECOND;
> +    ts.tv_nsec =3D ns % NANOSECONDS_PER_SECOND;
> +
> +    while (qemu_futex(f, FUTEX_WAIT_BITSET, (int) val, &ts, NULL, bitset=
)) {
>          switch (errno) {
>          case EWOULDBLOCK:
> -            return;
> +            return true;
>          case EINTR:
>              break; /* get out of switch and retry */
> +        case ETIMEDOUT:
> +            return false;
>          default:
>              abort();
>          }
>      }
> +
> +    return true;
>  }
>  #elif defined(CONFIG_WIN32)
>  #include <synchapi.h>
> @@ -68,12 +79,20 @@ static inline void qemu_futex_wake_single(void *f)
>      WakeByAddressSingle(f);
>  }
>=20=20
> -static inline void qemu_futex_wait(void *f, unsigned val)
> +static inline bool qemu_futex_timedwait(void *f, unsigned val, int64_t n=
s)
>  {
> -    WaitOnAddress(f, &val, sizeof(val), INFINITE);
> +    uint32_t duration =3D MIN((ns - get_clock()) / SCALE_MS, UINT32_MAX);
> +    return WaitOnAddress(f, &val, sizeof(val), duration);
>  }
>  #else
>  #undef HAVE_FUTEX
>  #endif
>=20=20
> +#ifdef HAVE_FUTEX
> +static inline void qemu_futex_wait(void *f, unsigned val)
> +{
> +    qemu_futex_timedwait(f, val, INT64_MAX);
> +}
> +#endif
> +
>  #endif /* QEMU_FUTEX_H */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

