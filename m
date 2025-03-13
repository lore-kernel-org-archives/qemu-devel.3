Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F20EC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 13:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsj3B-0001QF-Kk; Thu, 13 Mar 2025 09:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsj39-0001Pn-6n
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 09:56:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsj37-0004Uj-62
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 09:56:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so13324255e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741874194; x=1742478994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+v3De3Kzd+7fXnoUItXws4/mMAs82QduI7pQ8dhHNo=;
 b=lnw06Az9om8AphkYPs2f6XTpVIbekJh4KXfRRMiVpvX2SRxuciwBQR73o/0KuFMKUr
 nXA+Nkv4pfipJSpUD3Iyz3ya7A2UQxGEDdIAkFpwjnBrm5rq+q3fyf7fYAfYdQ/srASP
 76TPgFHKA0LniUiXDxjwjZI0oIg+f1Kyx0N/lRzeOtmZkETZC/42NBIbPcR7dd/T2vQv
 EklIYYSFyBf0gXUL0LRio2oSMWUYFLfydZUH/cQVtNyYAU/N25OtQ0gODXsK5WAo2NZk
 Zl9aAcQv4dPgW/VPezMsPiMc66w3Y5r9S7mZLZEmI0yv3bR6HpQlfN9a9gCvWFxqLy6T
 iGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741874194; x=1742478994;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i+v3De3Kzd+7fXnoUItXws4/mMAs82QduI7pQ8dhHNo=;
 b=dqyqa4Rx8jFw43ROiBlxwkchjEJGf67iGL6TpGdYcR0aubiBWykE3ZBhk8LAPat5EA
 DSgudM4cLsBD3apwt1Kat2Rs3dM9DDDZFw+Xum2JLRqGGF834kZ5pdg+taUr9QgZfBhi
 T9HSduTN+2v4Q8zcgjp6i1TpdtDYfVEiCOUjS9DfXFABPe2jh+CilP/MrB806cq00/So
 5sPxk8nB8ku/nPN5Rfjk8Ky1i11J/kA0WPX3qJAJnDj3QI4GbU4X0mr3l7sE5daW80/O
 ckB8dTmCKYwKkpQ2+PSLep5t0/lIi5c7YyMVE7SUbmVwa33CilPIFkFELsuqiNReu2Fa
 fLAA==
X-Gm-Message-State: AOJu0YySZYKnNzfAYOqPqB8DuL87XVNUKVseYeYenwsFuG2XfoDh071t
 /w6YNGio4XbsoGTlub9OzBpyto0qjGkG+iAqHMqQ6Wrz2ApUPzuE9EVXV98qby8=
X-Gm-Gg: ASbGncs20VIOOUljD8wFoUzT7XkIBS7Lz6PvowdMx8ZjhCJ5QyAsBFVHaMmqsQHWv7I
 LNifz6OruqcfMGx75Zc76fihxlVc0cigpe5lsXE1fPRfb//FhnLBrSIdomPHvwCyOzeGKq2WkAQ
 Br6RlA9C6WSMrz0e+6ULjDUbjhxihIHNKXk663e4uoW7Cs1LxCTOew7SMi92ttltDHyx3t6VqSV
 gX5jikQTchA1YQUCy1v4j4ZYcZMNVLHQAWPUlPU72P+tTd1WkQKpq/eoC8IBqNXGKvYhkgQ1KE8
 vwcHUCzfyQKiEYcTrm1ETSsePWrYxB1q4qRmki8IsmuKqD3wb99ys71RWQ==
X-Google-Smtp-Source: AGHT+IGz/wiTMXNi5KsiQ0xR5ICfeIN2/NtMhWeOhilZwg7uR0k3EgJ82yFqUYNSn0wdwkkBo3O1Dg==
X-Received: by 2002:a05:600c:44d2:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-43d180d03dfmr19760055e9.15.1741874194101; 
 Thu, 13 Mar 2025 06:56:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8c5cbfsm53770155e9.30.2025.03.13.06.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 06:56:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02CD75F8C7;
 Thu, 13 Mar 2025 13:56:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 pbonzini@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH 00/37] accel/tcg, codebase: Build once patches
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 12 Mar 2025 20:44:40 -0700")
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 13 Mar 2025 13:56:31 +0000
Message-ID: <87v7sd3ugg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> All this is working toward building accel/tcg/translator.c once,
> but it got late and I decided to stop at a convenient milestone.
>
<snip>
>
> I know there is overlap with other in-flight patches, but it
> seemed easiest to just start from master.

I guess that was why the re-base fails with:

  [2210/6843] Compiling C object libcommon.a.p/hw_vfio_migration.c.o
  FAILED: libcommon.a.p/hw_vfio_migration.c.o=20
  cc -m64 -Ilibcommon.a.p -I../../common-user/host/x86_64 -I../../linux-use=
r/include/host/x86_64 -I../../linux-user/include -Isubprojects/libvduse -I.=
./../subprojects/libvduse -I/usr/include/capstone -I/usr/include/p11-kit-1 =
-I/usr/include/pixman-1 -I/usr/include/libpng16 -I/usr/include/spice-server=
 -I/usr/include/spice-1 -I/usr/include/libusb-1.0 -I/usr/include/SDL2 -I/us=
r/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/incl=
ude/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -I/usr/includ=
e/slirp -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/harf=
buzz -I/usr/include/freetype2 -I/usr/include/fribidi -I/usr/include/cairo -=
I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu -I/usr/include=
/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/in=
clude/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/=
vte-2.91 -I/usr/include/virgl -I/usr/include/cacard -I/usr/include/nss -I/u=
sr/include/nspr -I/usr/include/PCSC -I/usr/include/pipewire-0.3 -I/usr/incl=
ude/spa-0.2 -I/usr/include/fuse3 -I/usr/include/uuid -fdiagnostics-color=3D=
auto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -fstack-protector-strong =
-Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wform=
at-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissin=
g-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declar=
ation -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-pr=
ototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-d=
irs -Wno-psabi -Wno-shift-negative-value -isystem /home/alex/lsrc/qemu.git/=
linux-headers -isystem linux-headers -iquote . -iquote /home/alex/lsrc/qemu=
.git -iquote /home/alex/lsrc/qemu.git/include -iquote /home/alex/lsrc/qemu.=
git/host/include/x86_64 -iquote /home/alex/lsrc/qemu.git/host/include/gener=
ic -iquote /home/alex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -msse2 -D_GNU_=
SOURCE -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivi=
al-auto-var-init=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIE -D_FILE_OFFS=
ET_BITS=3D64 -D__USE_FILE_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=3D1=
 -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600 -DNCURSES_WIDECHAR=3D1 -D_REENTRAN=
T -DSTRUCT_IOVEC_DEFINED -MD -MQ libcommon.a.p/hw_vfio_migration.c.o -MF li=
bcommon.a.p/hw_vfio_migration.c.o.d -o libcommon.a.p/hw_vfio_migration.c.o =
-c ../../hw/vfio/migration.c
  In file included from ../../hw/vfio/migration.c:30:
  /home/alex/lsrc/qemu.git/include/system/ram_addr.h:22:10: fatal error: cp=
u.h: No such file or directory
     22 | #include "cpu.h"
        |          ^~~~~~~
  compilation terminated.
  [2211/6843] Compiling C object libcommon.a.p/hw_vfio_iommufd.c.o
  FAILED: libcommon.a.p/hw_vfio_iommufd.c.o=20
  cc -m64 -Ilibcommon.a.p -I../../common-user/host/x86_64 -I../../linux-use=
r/include/host/x86_64 -I../../linux-user/include -Isubprojects/libvduse -I.=
./../subprojects/libvduse -I/usr/include/capstone -I/usr/include/p11-kit-1 =
-I/usr/include/pixman-1 -I/usr/include/libpng16 -I/usr/include/spice-server=
 -I/usr/include/spice-1 -I/usr/include/libusb-1.0 -I/usr/include/SDL2 -I/us=
r/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/incl=
ude/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -I/usr/includ=
e/slirp -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/harf=
buzz -I/usr/include/freetype2 -I/usr/include/fribidi -I/usr/include/cairo -=
I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu -I/usr/include=
/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/in=
clude/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/=
vte-2.91 -I/usr/include/virgl -I/usr/include/cacard -I/usr/include/nss -I/u=
sr/include/nspr -I/usr/include/PCSC -I/usr/include/pipewire-0.3 -I/usr/incl=
ude/spa-0.2 -I/usr/include/fuse3 -I/usr/include/uuid -fdiagnostics-color=3D=
auto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -fstack-protector-strong =
-Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wform=
at-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissin=
g-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declar=
ation -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-pr=
ototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-d=
irs -Wno-psabi -Wno-shift-negative-value -isystem /home/alex/lsrc/qemu.git/=
linux-headers -isystem linux-headers -iquote . -iquote /home/alex/lsrc/qemu=
.git -iquote /home/alex/lsrc/qemu.git/include -iquote /home/alex/lsrc/qemu.=
git/host/include/x86_64 -iquote /home/alex/lsrc/qemu.git/host/include/gener=
ic -iquote /home/alex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -msse2 -D_GNU_=
SOURCE -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivi=
al-auto-var-init=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIE -D_FILE_OFFS=
ET_BITS=3D64 -D__USE_FILE_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=3D1=
 -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600 -DNCURSES_WIDECHAR=3D1 -D_REENTRAN=
T -DSTRUCT_IOVEC_DEFINED -MD -MQ libcommon.a.p/hw_vfio_iommufd.c.o -MF libc=
ommon.a.p/hw_vfio_iommufd.c.o.d -o libcommon.a.p/hw_vfio_iommufd.c.o -c ../=
../hw/vfio/iommufd.c
  In file included from ../../hw/vfio/iommufd.c:28:
  /home/alex/lsrc/qemu.git/include/system/ram_addr.h:22:10: fatal error: cp=
u.h: No such file or directory
     22 | #include "cpu.h"
        |          ^~~~~~~
  compilation terminated.

I'll see if I can bisect...

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

