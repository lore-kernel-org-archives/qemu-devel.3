Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD06C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9Vo-0007Pt-DC; Wed, 12 Aug 2026 10:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wu9VZ-0007NF-0T
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:00:41 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wu9VW-00021f-Ko
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:00:40 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso1618852a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786543235; cv=none;
 d=google.com; s=arc-20260327;
 b=c4J94qj7o9hHlWKa4m7xSSFlLYxiFPPTskoUSkEcQImgB+1OjScDfdE7YIv4UZSG6e
 +h+3gvFxGyGHBcRpkhP48wz5uoF3xSOwSkR97nMY5AnnZel99KEL14xYFu1LdmG3l4Gs
 S35G8i4dUOHcAtN3V75F1r4xjrjrXClBdnls5RWltQiA/zqKM7S5EuprfU7NimQsTwFM
 2Hn0fQvMgktp4G9oz5pZ3ZVOS5+ErvFyI6Cpg3wqjM54E1tXrGJHqC6QyydmsTvEJYKg
 8Ay+rm9CYEcf4ryyeUZfxk0zlzjuvsSSPrJxV6hNu/k1bENH9WM2FoeHZ+u40713C2S8
 PL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vyMnUYoND6Vua38fxeIw5u++h037YzQ+tQA0I9C+evk=;
 fh=LNX7mVNHExxcQ5NWzhO4PWUQhCGUJvbD7PZ19nL1UOU=;
 b=rkDA8BOTX7u5WhNei5kCttri3A2Qpv1gaJBLDRgrRkb+ErQqrVUDG4ZQAQF4wdh76x
 wtXb3v1Ao57+AoXZ7K/mpmpYIwYfdMim1wfe1ebxC6ISQoBrCsGtPgcEMDFaSdFGCQ3S
 1HiyzSLwR2pEuTbcKjdvPeBUUhJNkXDXx8WtoLN1Sz9nGkymx8+Ys8156hNf/E9+7FPp
 7FiN/fjkoVZ2ed+NM534D6pTcqCXQ8ZZLEgZiMeqQYAySHFpQFJQugijnoJ8DnzVuucX
 10Wt8/7PxA2+TigNinIVk9WsX+saw7Qug3tdyb5GE3m7jJiebgo6z/bMjMXQhXArIvLT
 v+qg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786543235; x=1787148035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vyMnUYoND6Vua38fxeIw5u++h037YzQ+tQA0I9C+evk=;
 b=d0AF0UKAtSywklMbriliXln6zazL5P0LgoXkpbuXeBO1hhXMlKgpTmNV30tSU2HfV1
 EsgA9/juQzGP80hDCZfxKPq+EVLbzE1b9zd1QKA9fxH0yE6j+1E4sr6gTd4EJ+3aowIF
 8ezuiJqm425HZUKQnbmkw9yxiJhRVoQSqzbzL0cWgtei1k3v2p7mg65pbh52hSXFUJnE
 VKmUf/RxrqBcGk9/mw0jjajYi4TXDqHTj88bg3M1wF8VfHKnlUduyqOPArWh/UC2rxCz
 LOD6pSU+7BmQ5bdvyCLbh8s7MDYC96XbShpFChqneSogdHAuOLK71+6auKGhD1ANpUtb
 lJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786543235; x=1787148035;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyMnUYoND6Vua38fxeIw5u++h037YzQ+tQA0I9C+evk=;
 b=sqXTC0+Rez7nEPVpLGD1wFs8fmXk12b3OWOaZal2CXvNq4kNhd0sAYkCZnoyb9Q91d
 smTBahAfrytW6fzfmkAhHJxZ4/snMPS5SYconRn8SK5uHKqpEgbFW/M/SX01Bg8fCUsO
 LZVpUjFOLKghSMpqFW290WHCsl57ZiGSkLzYjPyzY1gGZ2pBhmLYJmYxd6YShx5yi5r/
 /0Bv2/gvoFuDeqysrHV0leQKRYulztkD33PJKbtw1Go3hm4HpaK6DV9cSnqIyihFMPT/
 7KpQ9FL/d1kayV3HCYGkR4fxftPFmZvS84MojJhF1txZ5k4YaoTkoUTi1kBDE0ywi7c4
 3EJg==
X-Gm-Message-State: AOJu0YwiHS19HQ0iaujEqZKKVX6jHvSedJGIenNV7GRr9qGBmX0i2G/1
 EbsPQ5mrwRoouP/OBYqwiYiO75avqTRMR+QIbDlRTm0jCLvSVU+5r3kbWHhkrV1tzKAY9heFpUc
 NdkrYCCr8MqaFXEPpps/x1iF29p9IQck=
X-Gm-Gg: AR+sD10YbH/OrgDuRl1udeSGqimUjMXdIk+guCVSFc0z9IqqfcAPUXgUpQakACVm1yu
 NR4t5v3URkYu296dE4fRvljLpa4YtNbKp98vEmZM8i/DEyFfY0X5yHi9K886Ru/58WDiKzxmFvO
 HO0COTF0d1y+86YNCuXunobSFy1GRV0G/PRx97alNvG0WYn2JSNG7os/J2wrfOL3kRvwA5l1Sqc
 /WZtAI90fDnBELzbBbWg7dWeUF55aM1lqZ49I7W5ysZBH7SG8UCfjwlkhgZ50c2i4m9I//XM0Rn
 PYC7e5EvZRyhC+vVejJxNruUgheX3NtjCFX4IwQ0+UW6WDdyPOhvuXBrcyZGBp8L9kkrmw6RyDy
 u
X-Received: by 2002:a05:6a20:6a06:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3cc379c763dmr8722680637.14.1786543234876; Wed, 12 Aug 2026
 07:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-11-philmd@oss.qualcomm.com>
In-Reply-To: <20260812131147.83188-11-philmd@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Aug 2026 18:00:22 +0400
X-Gm-Features: AUfX_myQ9NavvlFmfGb9u2ty0QhlKBNyll68UvGXS83A2Oe-NenRF8VXdtiQ5P8
Message-ID: <CAJ+F1C+X4DNFWXn9AK8kxp6zyCUnau5SawaZbQLO+=Gjw07y3Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] monitor: Remove unnecessary 'block/block.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Wed, Aug 12, 2026 at 5:38=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Nothing here requires declarations from "block/block.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

breaks for me:
[38/286] Compiling C object libsystem.a.p/net_vhost-vdpa.c.o
FAILED: [code=3D1] libsystem.a.p/net_vhost-vdpa.c.o
cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/libvduse
-I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader
-I/usr/include/p11-kit-1 -I/usr/include/libpng16
-I/usr/include/pixman-1 -I/usr/include/spice-1 -I/usr/include/glib-2.0
-I/usr/lib64/glib-2.0/include -I/usr/include/libmount
-I/usr/include/blkid -I/usr/include/sysprof-6
-I/usr/include/gio-unix-2.0 -I/usr/include/spice-server
-I/usr/include/opus -I/usr/include/cacard -I/usr/include/nss3
-I/usr/include/nspr4 -I/usr/include/PCSC -I/usr/include/gstreamer-1.0
-I/usr/include/libdrm -I/usr/include/orc-0.4 -I/usr/include/slirp
-I/usr/local/include -I/usr/include/libusb-1.0 -I/usr/include/SDL2
-I/usr/include/gtk-3.0 -I/usr/include/pango-1.0
-I/usr/include/cloudproviders -I/usr/include/cairo
-I/usr/include/gdk-pixbuf-2.0 -I/usr/include/glycin-2
-I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0
-I/usr/include/atk-1.0 -I/usr/lib64/pkgconfig/../../include/dbus-1.0
-I/usr/lib64/pkgconfig/../../lib64/dbus-1.0/include
-I/usr/include/fribidi -I/usr/include/libxml2 -I/usr/include/harfbuzz
-I/usr/include/freetype2 -I/usr/include/vte-2.91 -I/usr/include/rav1e
-I/usr/include/svt-av1 -I/usr/include/libvmaf -I/usr/include/webp
-I/usr/include/virgl -I/usr/include/fuse3 -I/usr/include/pipewire-0.3
-I/usr/include/spa-0.2 -fdiagnostics-color=3Dauto -Wall -Winvalid-pch
-Werror -std=3Dgnu11 -O2 -g -mcx16 -msse2 -fno-link-libatomic
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
-fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
-fzero-init-padding-bits=3Dall -fzero-call-used-regs=3Dused-gpr
-fsanitize=3Daddress -fstack-protector-strong -fno-omit-frame-pointer
-Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=3D2
-Wformat-security -Wformat-y2k -Wignored-qualifiers
-Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-attribute
-Wmissing-prototypes -Wnested-externs -Wold-style-declaration
-Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal
-Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings
-Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value
-isystem /home/elmarco/src/qemu.nmi/linux-headers -isystem
linux-headers -iquote . -iquote /home/elmarco/src/qemu.nmi -iquote
/home/elmarco/src/qemu.nmi/include -iquote
/home/elmarco/src/qemu.nmi/host/include/x86_64 -iquote
/home/elmarco/src/qemu.nmi/host/include/generic -iquote
/home/elmarco/src/qemu.nmi/tcg/x86_64 -pthread -fPIE
-fno-strict-aliasing -fno-strict-overflow -DHWY_SHARED_DEFINE
-DAVIF_DLL -DEB_DLL -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600
-DNCURSES_WIDECHAR=3D1 -D_GNU_SOURCE=3D1 -D_REENTRANT
-DSTRUCT_IOVEC_DEFINED -DWITH_GZFILEOP -DCONFIG_SOFTMMU
-DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/net_vhost-vdpa.c.o
-MF libsystem.a.p/net_vhost-vdpa.c.o.d -o
libsystem.a.p/net_vhost-vdpa.c.o -c ../net/vhost-vdpa.c
../net/vhost-vdpa.c: In function =E2=80=98vhost_vdpa_net_load_cmd=E2=80=99:
../net/vhost-vdpa.c:714:24: error: implicit declaration of function
=E2=80=98iov_size=E2=80=99 [-Wimplicit-function-declaration]
  714 |     size_t data_size =3D iov_size(data_sg, data_num), cmd_size;
      |                        ^~~~~~~~
../net/vhost-vdpa.c:714:24: error: nested extern declaration of
=E2=80=98iov_size=E2=80=99 [-Werror=3Dnested-externs]
../net/vhost-vdpa.c:742:5: error: implicit declaration of function
=E2=80=98iov_from_buf=E2=80=99 [-Wimplicit-function-declaration]
  742 |     iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
      |     ^~~~~~~~~~~~
../net/vhost-vdpa.c:742:5: error: nested extern declaration of
=E2=80=98iov_from_buf=E2=80=99 [-Werror=3Dnested-externs]
../net/vhost-vdpa.c:744:5: error: implicit declaration of function
=E2=80=98iov_to_buf=E2=80=99 [-Wimplicit-function-declaration]
  744 |     iov_to_buf(data_sg, data_num, 0,
      |     ^~~~~~~~~~
../net/vhost-vdpa.c:744:5: error: nested extern declaration of
=E2=80=98iov_to_buf=E2=80=99 [-Werror=3Dnested-externs]
../net/vhost-vdpa.c:748:5: error: implicit declaration of function
=E2=80=98iov_copy=E2=80=99; did you mean =E2=80=98error_copy=E2=80=99?
[-Wimplicit-function-declaration]
  748 |     iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
      |     ^~~~~~~~
      |     error_copy
../net/vhost-vdpa.c:748:5: error: nested extern declaration of
=E2=80=98iov_copy=E2=80=99 [-Werror=3Dnested-externs]
../net/vhost-vdpa.c:760:5: error: implicit declaration of function
=E2=80=98iov_discard_front=E2=80=99 [-Wimplicit-function-declaration]
  760 |     iov_discard_front(&out_cursor, &dummy_cursor_iov_cnt, cmd_size)=
;
      |     ^~~~~~~~~~~~~~~~~
../net/vhost-vdpa.c:760:5: error: nested extern declaration of
=E2=80=98iov_discard_front=E2=80=99 [-Werror=3Dnested-externs]
cc1: all warnings being treated as errors
[55/286] Compiling C object libsystem.a.p/system_physmem.c.o
ninja: build stopped: subcommand failed.

> ---
>  include/monitor/monitor.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index fa9f4a8a75a..fd98ee2c71d 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -1,7 +1,6 @@
>  #ifndef MONITOR_H
>  #define MONITOR_H
>
> -#include "block/block.h"
>  #include "qapi/qapi-types-misc.h"
>  #include "qemu/coroutine-core.h"
>  #include "qemu/readline.h"
> --
> 2.53.0
>
>

