Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835F9C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 19:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZxGf-0007hu-Fy; Thu, 10 Jul 2025 15:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uZxGd-0007gJ-EY
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:49:15 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uZxGa-0007ZA-4Y
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:49:15 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae0de1c378fso214404966b.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752176950; x=1752781750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Xyy7kAwEJsr9KLigwZihtZTIE59A8SCdejfUhplkn8=;
 b=VJeP0KELAlUixmYxmWBnXfuadMuQrP68l4Hu+XK8ynum45VXZWkW3ebXf3jU9zukJU
 UPiAIbm3dDeGChfdFdjrVRkeYHR56+pQIRPWH/10PfgQt4DpOfRd0VfzbPnhEAXfXygI
 KpDznnENDlZGz/4n5gtJt+tYWo5yncqMZGj4JaYlFzWvXUYXtd33Yy3kOMUuZmOqsGe1
 cEZ0hDeOUad/ztApG/BnBIZ38Jmz9BvVvu6Y8rppheyFppjnz1O5qJm0MVV2R10C+4UR
 4Ex7rDJd/W2Ci8LD89XFT+n1VXkI3p7xht55xCTPThqXHFpSAY293qwiSJMyWbUKR+HH
 NuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752176950; x=1752781750;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Xyy7kAwEJsr9KLigwZihtZTIE59A8SCdejfUhplkn8=;
 b=Kdu06FNnt/1I0e5ptwmdpJDOen2HLDoXj8yh4ti8+kFVnUltFAEkLXKFyVFR9tK1nR
 rplORL5GyYZdFoahHdtBaDZpF0SZbhPNJkS7KEaB6y4TMrE2W10zsC24Eye0vLbX7QKW
 E5BXud9rvPpi9+zF0i2mPmmRR+oJsiuTkpXiSZFh0fz0+ixHRNlFEx7/FGJ/rf7wP1yo
 C5hexFpSmY8bbzyO2a607G9/WZ3UrH5SDKIfFzU59z/wx5kBdvMswsGMf1aq4+lOIn9v
 cEy7i5lYzoPBgfQXzpPNfDeMWLZIryRJysOT2zNDeVnUJjqVf0Vgcoa+fe8QXLuLzjsV
 RaJg==
X-Gm-Message-State: AOJu0YxeB1M8Z+F/YMVZiD0/DwQoX8E7sI3HtTwXduL4VWspjNFc6XIW
 mmix96TVblDxC4Il6piH1Y4O/YLc5KAAWRcfBShQL4VDEfOXVmzdgIFCb4UuJQ==
X-Gm-Gg: ASbGncv2ONE1ElPMG3LslhijksOC+EVZQOtcPd6/y3irJckRPtPCzogVlwLTHBNd8oP
 r5bZjGv39U6NNNJ+Z6RHVSq2PHzMIQToQ5eFGTPMJ2a+wGhzWSqqVRYlCRft/o2B72yR+Xn4m9z
 TBXhET9EWylQ9iYHKcwCKWhy9i4tM4yVCC5g3/S4y4Y6N/DqfiU+zDaCEjqF9tzw/Ev6jjMtmcQ
 kbmm4zTuNQmPDasBBtnz1K1QSk/dwsumsJjxu/+bKfWhR627+6byCcGS6SNgLyoBxuIDq1aGBAe
 M9D/h21I/7sMAO0DvIfu6/aIMV42nkbrcdnLpJbKLecBfQenKSVhG7YD5zk/cQU9+9jmwcX7tgC
 LLlgnut1KWP2VcsgNp7ja1RPjkA1Em/lpq3g/68ZpyjflFCkCxhRvglSD2CsjDlkwFM0rAQ==
X-Google-Smtp-Source: AGHT+IG3/CoJ5Z7zswfo0WaNz3dHmPjkw3oX0AW5L6SorURrT0YPIFUWedwSiiCuaocWximsSJR2/w==
X-Received: by 2002:a17:907:3e23:b0:ad5:a121:6ebc with SMTP id
 a640c23a62f3a-ae6fb7c8d52mr49738866b.0.1752176949083; 
 Thu, 10 Jul 2025 12:49:09 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-1ab0-6200-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:1ab0:6200:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7e9118dsm178323266b.21.2025.07.10.12.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 12:49:08 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:54:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: Add most 3rd-party includes as system includes
In-Reply-To: <C809116D-8A05-43BC-A7AA-828168457BA7@gmail.com>
References: <20250617203435.41490-1-shentey@gmail.com>
 <C809116D-8A05-43BC-A7AA-828168457BA7@gmail.com>
Message-ID: <EF1E4012-0693-499D-868E-356185E1ADDF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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



Am 3=2E Juli 2025 06:25:11 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>
>
>Am 17=2E Juni 2025 20:34:35 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>>When compiling QEMU against fuse3-3=2E17=2E1 with --enable-werror the bu=
ild fails
>>with:
>>
>>  In file included from =2E=2E/src/block/export/fuse=2Ec:33:
>>  /usr/include/fuse3/fuse=2Eh:959:5: error: redundant redeclaration of =
=E2=80=98fuse_main_real_versioned=E2=80=99 [-Werror=3Dredundant-decls]
>>    959 | int fuse_main_real_versioned(int argc, char *argv[],
>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~
>>  /usr/include/fuse3/fuse=2Eh:885:5: note: previous declaration of =E2=
=80=98fuse_main_real_versioned=E2=80=99 with type =E2=80=98int(int,  char *=
*, const struct fuse_operations *, size_t,  struct libfuse_version *, void =
*)=E2=80=99 {aka =E2=80=98int(int,  char **, const struct fuse_operations *=
, long unsigned int,  struct libfuse_version *, void *)=E2=80=99}
>>    885 | int fuse_main_real_versioned(int argc, char *argv[],
>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~
>>  cc1: all warnings being treated as errors
>>
>>That is, a fuse header triggers a warning within itself=2E Since QEMU ad=
ds the
>>fuse3 include path via `-I`, the compiler thinks that the header is part=
 of the
>>QEMU project, and thus raises a warning=2E The compiler can be told to i=
gnore
>>warnings within 3rd party headers by adding these paths via `-isystem`=
=2E Fix the
>>above build failure by marking fuse as system dependency=2E While at it =
mark
>>every 3rd-party dependency as system dependency to prevent similar issue=
s in the
>>future but skip glib since that results in glib include paths to be omit=
ted from
>>bindgen in case of a Rust build=2E
>>
>>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>Ping

Ping^2

>
>>---
>> meson=2Ebuild | 160 ++++++++++++++++++++++++++-------------------------=
-
>> 1 file changed, 80 insertions(+), 80 deletions(-)
>>
>>diff --git a/meson=2Ebuild b/meson=2Ebuild
>>index 34729c2a3d=2E=2E694cf95f6f 100644
>>--- a/meson=2Ebuild
>>+++ b/meson=2Ebuild
>>@@ -826,7 +826,7 @@ endif
>> #####################################
>>=20
>> libm =3D cc=2Efind_library('m', required: false)
>>-threads =3D dependency('threads')
>>+threads =3D dependency('threads', include_type: 'system')
>> util =3D cc=2Efind_library('util', required: false)
>> winmm =3D []
>> socket =3D []
>>@@ -859,11 +859,11 @@ if host_os =3D=3D 'windows'
>>                                       include_directories: include_dire=
ctories('=2E'))
>>   host_dsosuf =3D '=2Edll'
>> elif host_os =3D=3D 'darwin'
>>-  coref =3D dependency('appleframeworks', modules: 'CoreFoundation')
>>-  iokit =3D dependency('appleframeworks', modules: 'IOKit', required: f=
alse)
>>+  coref =3D dependency('appleframeworks', modules: 'CoreFoundation', in=
clude_type: 'system')
>>+  iokit =3D dependency('appleframeworks', modules: 'IOKit', required: f=
alse, include_type: 'system')
>>   host_dsosuf =3D '=2Edylib'
>>   pvg =3D dependency('appleframeworks', modules: ['ParavirtualizedGraph=
ics', 'Metal'],
>>-                   required: get_option('pvg'))
>>+                   required: get_option('pvg'), include_type: 'system')
>> elif host_os =3D=3D 'sunos'
>>   socket =3D [cc=2Efind_library('socket'),
>>             cc=2Efind_library('nsl'),
>>@@ -899,7 +899,7 @@ endif
>> hvf =3D not_found
>> if get_option('hvf')=2Eallowed()
>>   hvf =3D dependency('appleframeworks', modules: 'Hypervisor',
>>-                   required: get_option('hvf'))
>>+                   required: get_option('hvf'), include_type: 'system')
>>   if hvf=2Efound()
>>     accelerators +=3D 'CONFIG_HVF'
>>   endif
>>@@ -960,30 +960,30 @@ endif
>> xen =3D not_found
>> if get_option('xen')=2Eenabled() or (get_option('xen')=2Eauto() and hav=
e_system)
>>   xencontrol =3D dependency('xencontrol', required: false,
>>-                          method: 'pkg-config')
>>+                          method: 'pkg-config', include_type: 'system')
>>   if xencontrol=2Efound()
>>     xen_pc =3D declare_dependency(version: xencontrol=2Eversion(),
>>       dependencies: [
>>         xencontrol,
>>         # disabler: true makes xen_pc=2Efound() return false if any is =
not found
>>         dependency('xenstore', required: false,
>>-                   method: 'pkg-config',
>>+                   method: 'pkg-config', include_type: 'system',
>>                    disabler: true),
>>         dependency('xenforeignmemory', required: false,
>>-                   method: 'pkg-config',
>>+                   method: 'pkg-config', include_type: 'system',
>>                    disabler: true),
>>         dependency('xengnttab', required: false,
>>-                   method: 'pkg-config',
>>+                   method: 'pkg-config', include_type: 'system',
>>                    disabler: true),
>>         dependency('xenevtchn', required: false,
>>-                   method: 'pkg-config',
>>+                   method: 'pkg-config', include_type: 'system',
>>                    disabler: true),
>>         dependency('xendevicemodel', required: false,
>>-                   method: 'pkg-config',
>>+                   method: 'pkg-config', include_type: 'system',
>>                    disabler: true),
>>         # optional, no "disabler: true"
>>         dependency('xentoolcore', required: false,
>>-                   method: 'pkg-config')])
>>+                   method: 'pkg-config', include_type: 'system')])
>>     if xen_pc=2Efound()
>>       xen =3D xen_pc
>>     endif
>>@@ -1050,10 +1050,10 @@ glib_pc =3D dependency('glib-2=2E0', version: gl=
ib_req_ver, required: true,
>> glib_cflags =3D []
>> if enable_modules
>>   gmodule =3D dependency('gmodule-export-2=2E0', version: glib_req_ver,=
 required: true,
>>-                       method: 'pkg-config')
>>+                       method: 'pkg-config', include_type: 'system')
>> elif get_option('plugins')
>>   gmodule =3D dependency('gmodule-no-export-2=2E0', version: glib_req_v=
er, required: true,
>>-                       method: 'pkg-config')
>>+                       method: 'pkg-config', include_type: 'system')
>> else
>>   gmodule =3D not_found
>> endif
>>@@ -1109,7 +1109,7 @@ gdbus_codegen =3D not_found
>> gdbus_codegen_error =3D '@0@ requires gdbus-codegen, please install lib=
gio'
>> if not get_option('gio')=2Eauto() or have_system
>>   gio =3D dependency('gio-2=2E0', required: get_option('gio'),
>>-                   method: 'pkg-config')
>>+                   method: 'pkg-config', include_type: 'system')
>>   if gio=2Efound() and not cc=2Elinks('''
>>     #include <gio/gio=2Eh>
>>     int main(void)
>>@@ -1126,7 +1126,7 @@ if not get_option('gio')=2Eauto() or have_system
>>     gdbus_codegen =3D find_program('gdbus-codegen',
>>                                  required: get_option('gio'))
>>     gio_unix =3D dependency('gio-unix-2=2E0', required: get_option('gio=
'),
>>-                          method: 'pkg-config')
>>+                          method: 'pkg-config', include_type: 'system')
>>     gio =3D declare_dependency(dependencies: [gio, gio_unix],
>>                              version: gio=2Eversion())
>>   endif
>>@@ -1141,15 +1141,15 @@ xml_pp =3D find_program('scripts/xml-preprocess=
=2Epy')
>> lttng =3D not_found
>> if 'ust' in get_option('trace_backends')
>>   lttng =3D dependency('lttng-ust', required: true, version: '>=3D 2=2E=
1',
>>-                     method: 'pkg-config')
>>+                     method: 'pkg-config', include_type: 'system')
>> endif
>> pixman =3D not_found
>> if not get_option('pixman')=2Eauto() or have_system or have_tools
>>   pixman =3D dependency('pixman-1', required: get_option('pixman'), ver=
sion:'>=3D0=2E21=2E8',
>>-                      method: 'pkg-config')
>>+                      method: 'pkg-config', include_type: 'system')
>> endif
>>=20
>>-zlib =3D dependency('zlib', required: true)
>>+zlib =3D dependency('zlib', required: true, include_type: 'system')
>>=20
>> libaio =3D not_found
>> if not get_option('linux_aio')=2Eauto() or have_block
>>@@ -1167,7 +1167,7 @@ linux_io_uring =3D not_found
>> if not get_option('linux_io_uring')=2Eauto() or have_block
>>   linux_io_uring =3D dependency('liburing', version: '>=3D0=2E3',
>>                               required: get_option('linux_io_uring'),
>>-                              method: 'pkg-config')
>>+                              method: 'pkg-config', include_type: 'syst=
em')
>>   if not cc=2Elinks(linux_io_uring_test)
>>     linux_io_uring =3D not_found
>>   endif
>>@@ -1177,7 +1177,7 @@ libnfs =3D not_found
>> if not get_option('libnfs')=2Eauto() or have_block
>>   libnfs =3D dependency('libnfs', version: ['>=3D1=2E9=2E3', '<6=2E0=2E=
0'],
>>                       required: get_option('libnfs'),
>>-                      method: 'pkg-config')
>>+                      method: 'pkg-config', include_type: 'system')
>> endif
>>=20
>> libattr_test =3D '''
>>@@ -1214,9 +1214,9 @@ endif
>>=20
>> cocoa =3D dependency('appleframeworks',
>>                    modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
>>-                   required: get_option('cocoa'))
>>+                   required: get_option('cocoa'), include_type: 'system=
')
>>=20
>>-vmnet =3D dependency('appleframeworks', modules: 'vmnet', required: get=
_option('vmnet'))
>>+vmnet =3D dependency('appleframeworks', modules: 'vmnet', required: get=
_option('vmnet'), include_type: 'system')
>> if vmnet=2Efound() and not cc=2Ehas_header_symbol('vmnet/vmnet=2Eh',
>>                                               'VMNET_BRIDGED_MODE',
>>                                               dependencies: vmnet)
>>@@ -1233,7 +1233,7 @@ seccomp_has_sysrawrc =3D false
>> if not get_option('seccomp')=2Eauto() or have_system or have_tools
>>   seccomp =3D dependency('libseccomp', version: '>=3D2=2E3=2E0',
>>                        required: get_option('seccomp'),
>>-                       method: 'pkg-config')
>>+                       method: 'pkg-config', include_type: 'system')
>>   if seccomp=2Efound()
>>     seccomp_has_sysrawrc =3D cc=2Ehas_header_symbol('seccomp=2Eh',
>>                                                 'SCMP_FLTATR_API_SYSRAW=
RC',
>>@@ -1265,13 +1265,13 @@ if get_option('xkbcommon')=2Eauto() and not have=
_system and not have_tools
>>   xkbcommon =3D not_found
>> else
>>   xkbcommon =3D dependency('xkbcommon', required: get_option('xkbcommon=
'),
>>-                         method: 'pkg-config')
>>+                         method: 'pkg-config', include_type: 'system')
>> endif
>>=20
>> slirp =3D not_found
>> if not get_option('slirp')=2Eauto() or have_system
>>   slirp =3D dependency('slirp', required: get_option('slirp'),
>>-                     method: 'pkg-config')
>>+                     method: 'pkg-config', include_type: 'system')
>>   # slirp < 4=2E7 is incompatible with CFI support in QEMU=2E  This is =
because
>>   # it passes function pointers within libslirp as callbacks for timers=
=2E
>>   # When using a system-wide shared libslirp, the type information for =
the
>>@@ -1313,35 +1313,35 @@ endif
>> pulse =3D not_found
>> if not get_option('pa')=2Eauto() or (host_os =3D=3D 'linux' and have_sy=
stem)
>>   pulse =3D dependency('libpulse', required: get_option('pa'),
>>-                     method: 'pkg-config')
>>+                     method: 'pkg-config', include_type: 'system')
>> endif
>> alsa =3D not_found
>> if not get_option('alsa')=2Eauto() or (host_os =3D=3D 'linux' and have_=
system)
>>   alsa =3D dependency('alsa', required: get_option('alsa'),
>>-                    method: 'pkg-config')
>>+                    method: 'pkg-config', include_type: 'system')
>> endif
>> jack =3D not_found
>> if not get_option('jack')=2Eauto() or have_system
>>   jack =3D dependency('jack', required: get_option('jack'),
>>-                    method: 'pkg-config')
>>+                    method: 'pkg-config', include_type: 'system')
>> endif
>> pipewire =3D not_found
>> if not get_option('pipewire')=2Eauto() or (host_os =3D=3D 'linux' and h=
ave_system)
>>   pipewire =3D dependency('libpipewire-0=2E3', version: '>=3D0=2E3=2E60=
',
>>                     required: get_option('pipewire'),
>>-                    method: 'pkg-config')
>>+                    method: 'pkg-config', include_type: 'system')
>> endif
>> sndio =3D not_found
>> if not get_option('sndio')=2Eauto() or have_system
>>   sndio =3D dependency('sndio', required: get_option('sndio'),
>>-                    method: 'pkg-config')
>>+                    method: 'pkg-config', include_type: 'system')
>> endif
>>=20
>> spice_protocol =3D not_found
>> if not get_option('spice_protocol')=2Eauto() or have_system
>>   spice_protocol =3D dependency('spice-protocol', version: '>=3D0=2E14=
=2E0',
>>                               required: get_option('spice_protocol'),
>>-                              method: 'pkg-config')
>>+                              method: 'pkg-config', include_type: 'syst=
em')
>> endif
>> spice =3D not_found
>> if get_option('spice') \
>>@@ -1351,7 +1351,7 @@ if get_option('spice') \
>>              =2Eallowed()
>>   spice =3D dependency('spice-server', version: '>=3D0=2E14=2E0',
>>                      required: get_option('spice'),
>>-                     method: 'pkg-config')
>>+                     method: 'pkg-config', include_type: 'system')
>> endif
>> spice_headers =3D spice=2Epartial_dependency(compile_args: true, includ=
es: true)
>>=20
>>@@ -1361,28 +1361,28 @@ libiscsi =3D not_found
>> if not get_option('libiscsi')=2Eauto() or have_block
>>   libiscsi =3D dependency('libiscsi', version: '>=3D1=2E9=2E0',
>>                          required: get_option('libiscsi'),
>>-                         method: 'pkg-config')
>>+                         method: 'pkg-config', include_type: 'system')
>> endif
>> zstd =3D not_found
>> if not get_option('zstd')=2Eauto() or have_block
>>   zstd =3D dependency('libzstd', version: '>=3D1=2E4=2E0',
>>                     required: get_option('zstd'),
>>-                    method: 'pkg-config')
>>+                    method: 'pkg-config', include_type: 'system')
>> endif
>> qpl =3D not_found
>> if not get_option('qpl')=2Eauto() or have_system
>>   qpl =3D dependency('qpl', version: '>=3D1=2E5=2E0',
>>                     required: get_option('qpl'),
>>-                    method: 'pkg-config')
>>+                    method: 'pkg-config', include_type: 'system')
>> endif
>> uadk =3D not_found
>> if not get_option('uadk')=2Eauto() or have_system
>>   libwd =3D dependency('libwd', version: '>=3D2=2E6',
>>                       required: get_option('uadk'),
>>-                      method: 'pkg-config')
>>+                      method: 'pkg-config', include_type: 'system')
>>   libwd_comp =3D dependency('libwd_comp', version: '>=3D2=2E6',
>>                            required: get_option('uadk'),
>>-                           method: 'pkg-config')
>>+                           method: 'pkg-config', include_type: 'system'=
)
>>   if libwd=2Efound() and libwd_comp=2Efound()
>>      uadk =3D declare_dependency(dependencies: [libwd, libwd_comp])
>>   endif
>>@@ -1392,7 +1392,7 @@ qatzip =3D not_found
>> if not get_option('qatzip')=2Eauto() or have_system
>>   qatzip =3D dependency('qatzip', version: '>=3D1=2E1=2E2',
>>                       required: get_option('qatzip'),
>>-                      method: 'pkg-config')
>>+                      method: 'pkg-config', include_type: 'system')
>> endif
>>=20
>> virgl =3D not_found
>>@@ -1400,31 +1400,31 @@ virgl =3D not_found
>> have_vhost_user_gpu =3D have_tools and host_os =3D=3D 'linux' and pixma=
n=2Efound()
>> if not get_option('virglrenderer')=2Eauto() or have_system or have_vhos=
t_user_gpu
>>   virgl =3D dependency('virglrenderer',
>>-                     method: 'pkg-config',
>>+                     method: 'pkg-config', include_type: 'system',
>>                      required: get_option('virglrenderer'))
>> endif
>> rutabaga =3D not_found
>> if not get_option('rutabaga_gfx')=2Eauto() or have_system or have_vhost=
_user_gpu
>>   rutabaga =3D dependency('rutabaga_gfx_ffi',
>>-                         method: 'pkg-config',
>>+                         method: 'pkg-config', include_type: 'system',
>>                          required: get_option('rutabaga_gfx'))
>> endif
>> blkio =3D not_found
>> if not get_option('blkio')=2Eauto() or have_block
>>   blkio =3D dependency('blkio',
>>-                     method: 'pkg-config',
>>+                     method: 'pkg-config', include_type: 'system',
>>                      required: get_option('blkio'))
>> endif
>> curl =3D not_found
>> if not get_option('curl')=2Eauto() or have_block
>>   curl =3D dependency('libcurl', version: '>=3D7=2E29=2E0',
>>-                    method: 'pkg-config',
>>+                    method: 'pkg-config', include_type: 'system',
>>                     required: get_option('curl'))
>> endif
>> libudev =3D not_found
>> if host_os =3D=3D 'linux' and (have_system or have_tools)
>>   libudev =3D dependency('libudev',
>>-                       method: 'pkg-config',
>>+                       method: 'pkg-config', include_type: 'system',
>>                        required: get_option('libudev'))
>> endif
>>=20
>>@@ -1504,7 +1504,7 @@ if have_system and get_option('curses')=2Eallowed(=
)
>>   curses_dep_list =3D host_os =3D=3D 'windows' ? ['ncurses', 'ncursesw'=
] : ['ncursesw']
>>   curses =3D dependency(curses_dep_list,
>>                       required: false,
>>-                      method: 'pkg-config')
>>+                      method: 'pkg-config', include_type: 'system')
>>   msg =3D get_option('curses')=2Eenabled() ? 'curses library not found'=
 : ''
>>   curses_compile_args =3D ['-DNCURSES_WIDECHAR=3D1']
>>   if curses=2Efound()
>>@@ -1593,7 +1593,7 @@ endif
>>=20
>> sdl =3D not_found
>> if not get_option('sdl')=2Eauto() or have_system
>>-  sdl =3D dependency('sdl2', required: get_option('sdl'))
>>+  sdl =3D dependency('sdl2', required: get_option('sdl'), include_type:=
 'system')
>>   sdl_image =3D not_found
>> endif
>> if sdl=2Efound()
>>@@ -1608,7 +1608,7 @@ if sdl=2Efound()
>>                              version: sdl=2Eversion())
>>   endif
>>   sdl_image =3D dependency('SDL2_image', required: get_option('sdl_imag=
e'),
>>-                         method: 'pkg-config')
>>+                         method: 'pkg-config', include_type: 'system')
>> else
>>   if get_option('sdl_image')=2Eenabled()
>>     error('sdl-image required, but SDL was @0@'=2Eformat(
>>@@ -1649,7 +1649,7 @@ glusterfs_iocb_has_stat =3D false
>> if not get_option('glusterfs')=2Eauto() or have_block
>>   glusterfs =3D dependency('glusterfs-api', version: '>=3D3',
>>                          required: get_option('glusterfs'),
>>-                         method: 'pkg-config')
>>+                         method: 'pkg-config', include_type: 'system')
>>   if glusterfs=2Efound()
>>     glusterfs_ftruncate_has_stat =3D cc=2Elinks('''
>>       #include <glusterfs/api/glfs=2Eh>
>>@@ -1707,7 +1707,7 @@ endif
>> libssh =3D not_found
>> if not get_option('libssh')=2Eauto() or have_block
>>   libssh =3D dependency('libssh', version: '>=3D0=2E8=2E7',
>>-                    method: 'pkg-config',
>>+                    method: 'pkg-config', include_type: 'system',
>>                     required: get_option('libssh'))
>> endif
>>=20
>>@@ -1775,12 +1775,12 @@ endif
>> coreaudio =3D not_found
>> if not get_option('coreaudio')=2Eauto() or (host_os =3D=3D 'darwin' and=
 have_system)
>>   coreaudio =3D dependency('appleframeworks', modules: 'CoreAudio',
>>-                         required: get_option('coreaudio'))
>>+                         required: get_option('coreaudio'), include_typ=
e: 'system')
>> endif
>>=20
>> opengl =3D not_found
>> if not get_option('opengl')=2Eauto() or have_system or have_vhost_user_=
gpu
>>-  epoxy =3D dependency('epoxy', method: 'pkg-config',
>>+  epoxy =3D dependency('epoxy', method: 'pkg-config', include_type: 'sy=
stem',
>>                       required: get_option('opengl'))
>>   if cc=2Ehas_header('epoxy/egl=2Eh', dependencies: epoxy)
>>     opengl =3D epoxy
>>@@ -1790,14 +1790,14 @@ if not get_option('opengl')=2Eauto() or have_sys=
tem or have_vhost_user_gpu
>> endif
>> gbm =3D not_found
>> if (have_system or have_tools) and (virgl=2Efound() or opengl=2Efound()=
)
>>-  gbm =3D dependency('gbm', method: 'pkg-config', required: false)
>>+  gbm =3D dependency('gbm', method: 'pkg-config', include_type: 'system=
', required: false)
>> endif
>> have_vhost_user_gpu =3D have_vhost_user_gpu and virgl=2Efound() and ope=
ngl=2Efound() and gbm=2Efound()
>>=20
>> libcbor =3D not_found
>> if not get_option('libcbor')=2Eauto() or have_system
>>   libcbor =3D dependency('libcbor', version: '>=3D0=2E7=2E0',
>>-                       required: get_option('libcbor'))
>>+                       required: get_option('libcbor'), include_type: '=
system')
>> endif
>>=20
>> gnutls =3D not_found
>>@@ -1817,14 +1817,14 @@ if get_option('gnutls')=2Eenabled() or (get_opti=
on('gnutls')=2Eauto() and have_syste
>>   # still use a different crypto backend to satisfy
>>   # the platform support requirements
>>   gnutls_crypto =3D dependency('gnutls', version: '>=3D3=2E6=2E14',
>>-                             method: 'pkg-config',
>>+                             method: 'pkg-config', include_type: 'syste=
m',
>>                              required: false)
>>   if gnutls_crypto=2Efound()
>>     gnutls =3D gnutls_crypto
>>   else
>>     # Our min version if all we need is TLS
>>     gnutls =3D dependency('gnutls', version: '>=3D3=2E5=2E18',
>>-                        method: 'pkg-config',
>>+                        method: 'pkg-config', include_type: 'system',
>>                         required: get_option('gnutls'))
>>   endif
>> endif
>>@@ -1853,7 +1853,7 @@ endif
>> if not gnutls_crypto=2Efound()
>>   if (not get_option('gcrypt')=2Eauto() or have_system) and not get_opt=
ion('nettle')=2Eenabled()
>>     gcrypt =3D dependency('libgcrypt', version: '>=3D1=2E8',
>>-                        required: get_option('gcrypt'))
>>+                        required: get_option('gcrypt'), include_type: '=
system')
>>     # Debian has removed -lgpg-error from libgcrypt-config
>>     # as it "spreads unnecessary dependencies" which in
>>     # turn breaks static builds=2E=2E=2E
>>@@ -1888,7 +1888,7 @@ if not gnutls_crypto=2Efound()
>>   endif
>>   if (not get_option('nettle')=2Eauto() or have_system) and not gcrypt=
=2Efound()
>>     nettle =3D dependency('nettle', version: '>=3D3=2E4',
>>-                        method: 'pkg-config',
>>+                        method: 'pkg-config', include_type: 'system',
>>                         required: get_option('nettle'))
>>     if nettle=2Efound() and not cc=2Ehas_header('nettle/xts=2Eh', depen=
dencies: nettle)
>>       xts =3D 'private'
>>@@ -1936,7 +1936,7 @@ endif
>> capstone =3D not_found
>> if not get_option('capstone')=2Eauto() or have_system or have_user
>>   capstone =3D dependency('capstone', version: '>=3D3=2E0=2E5',
>>-                        method: 'pkg-config',
>>+                        method: 'pkg-config', include_type: 'system',
>>                         required: get_option('capstone'))
>>=20
>>   # Some versions of capstone have broken pkg-config file
>>@@ -1952,10 +1952,10 @@ if not get_option('capstone')=2Eauto() or have_s=
ystem or have_user
>>   endif
>> endif
>>=20
>>-gmp =3D dependency('gmp', required: false, method: 'pkg-config')
>>+gmp =3D dependency('gmp', required: false, method: 'pkg-config', includ=
e_type: 'system')
>> if nettle=2Efound() and gmp=2Efound()
>>   hogweed =3D dependency('hogweed', version: '>=3D3=2E4',
>>-                       method: 'pkg-config',
>>+                       method: 'pkg-config', include_type: 'system',
>>                        required: get_option('nettle'))
>> endif
>>=20
>>@@ -1971,18 +1971,18 @@ if get_option('gtk') \
>>                       error_message: 'cannot enable GTK if pixman is no=
t available') \
>>              =2Eallowed()
>>   gtk =3D dependency('gtk+-3=2E0', version: '>=3D3=2E22=2E0',
>>-                   method: 'pkg-config',
>>+                   method: 'pkg-config', include_type: 'system',
>>                    required: get_option('gtk'))
>>   if gtk=2Efound()
>>     gtkx11 =3D dependency('gtk+-x11-3=2E0', version: '>=3D3=2E22=2E0',
>>-                        method: 'pkg-config',
>>+                        method: 'pkg-config', include_type: 'system',
>>                         required: false)
>>     gtk =3D declare_dependency(dependencies: [gtk, gtkx11],
>>                              version: gtk=2Eversion())
>>=20
>>     if not get_option('vte')=2Eauto() or have_system
>>       vte =3D dependency('vte-2=2E91',
>>-                       method: 'pkg-config',
>>+                       method: 'pkg-config', include_type: 'system',
>>                        required: get_option('vte'))
>>     endif
>>   elif have_gtk_clipboard
>>@@ -1992,12 +1992,12 @@ endif
>>=20
>> x11 =3D not_found
>> if gtkx11=2Efound()
>>-  x11 =3D dependency('x11', method: 'pkg-config', required: gtkx11=2Efo=
und())
>>+  x11 =3D dependency('x11', method: 'pkg-config', include_type: 'system=
', required: gtkx11=2Efound())
>> endif
>> png =3D not_found
>> if get_option('png')=2Eallowed() and have_system
>>    png =3D dependency('libpng', version: '>=3D1=2E6=2E34', required: ge=
t_option('png'),
>>-                    method: 'pkg-config')
>>+                    method: 'pkg-config', include_type: 'system')
>> endif
>> vnc =3D not_found
>> jpeg =3D not_found
>>@@ -2009,7 +2009,7 @@ if get_option('vnc') \
>>              =2Eallowed()
>>   vnc =3D declare_dependency() # dummy dependency
>>   jpeg =3D dependency('libjpeg', required: get_option('vnc_jpeg'),
>>-                    method: 'pkg-config')
>>+                    method: 'pkg-config', include_type: 'system')
>>   sasl =3D cc=2Efind_library('sasl2', has_headers: ['sasl/sasl=2Eh'],
>>                          required: get_option('vnc_sasl'))
>>   if sasl=2Efound()
>>@@ -2135,49 +2135,49 @@ endif
>> cacard =3D not_found
>> if not get_option('smartcard')=2Eauto() or have_system
>>   cacard =3D dependency('libcacard', required: get_option('smartcard'),
>>-                      version: '>=3D2=2E5=2E1', method: 'pkg-config')
>>+                      version: '>=3D2=2E5=2E1', method: 'pkg-config', i=
nclude_type: 'system')
>> endif
>> u2f =3D not_found
>> if not get_option('u2f')=2Eauto() or have_system
>>   u2f =3D dependency('u2f-emu', required: get_option('u2f'),
>>-                   method: 'pkg-config')
>>+                   method: 'pkg-config', include_type: 'system')
>> endif
>> canokey =3D not_found
>> if not get_option('canokey')=2Eauto() or have_system
>>   canokey =3D dependency('canokey-qemu', required: get_option('canokey'=
),
>>-                   method: 'pkg-config')
>>+                   method: 'pkg-config', include_type: 'system')
>> endif
>> usbredir =3D not_found
>> if not get_option('usb_redir')=2Eauto() or have_system
>>   usbredir =3D dependency('libusbredirparser-0=2E5', required: get_opti=
on('usb_redir'),
>>-                        version: '>=3D0=2E6', method: 'pkg-config')
>>+                        version: '>=3D0=2E6', method: 'pkg-config', inc=
lude_type: 'system')
>> endif
>> libusb =3D not_found
>> if not get_option('libusb')=2Eauto() or have_system
>>   libusb =3D dependency('libusb-1=2E0', required: get_option('libusb'),
>>-                      version: '>=3D1=2E0=2E13', method: 'pkg-config')
>>+                      version: '>=3D1=2E0=2E13', method: 'pkg-config', =
include_type: 'system')
>> endif
>>=20
>> libpmem =3D not_found
>> if not get_option('libpmem')=2Eauto() or have_system
>>   libpmem =3D dependency('libpmem', required: get_option('libpmem'),
>>-                       method: 'pkg-config')
>>+                       method: 'pkg-config', include_type: 'system')
>> endif
>> libdaxctl =3D not_found
>> if not get_option('libdaxctl')=2Eauto() or have_system
>>   libdaxctl =3D dependency('libdaxctl', required: get_option('libdaxctl=
'),
>>-                         version: '>=3D57', method: 'pkg-config')
>>+                         version: '>=3D57', method: 'pkg-config', inclu=
de_type: 'system')
>> endif
>> tasn1 =3D not_found
>> if gnutls=2Efound()
>>   tasn1 =3D dependency('libtasn1',
>>                      required: false,
>>-                     method: 'pkg-config')
>>+                     method: 'pkg-config', include_type: 'system')
>> endif
>> keyutils =3D not_found
>> if not get_option('libkeyutils')=2Eauto() or have_block
>>   keyutils =3D dependency('libkeyutils', required: get_option('libkeyut=
ils'),
>>-                        method: 'pkg-config')
>>+                        method: 'pkg-config', include_type: 'system')
>> endif
>>=20
>> has_gettid =3D cc=2Ehas_function('gettid')
>>@@ -2185,7 +2185,7 @@ has_gettid =3D cc=2Ehas_function('gettid')
>> # libselinux
>> selinux =3D dependency('libselinux',
>>                      required: get_option('selinux'),
>>-                     method: 'pkg-config')
>>+                     method: 'pkg-config', include_type: 'system')
>>=20
>> # Malloc tests
>>=20
>>@@ -2237,7 +2237,7 @@ if get_option('fuse')=2Edisabled() and get_option(=
'fuse_lseek')=2Eenabled()
>> endif
>>=20
>> fuse =3D dependency('fuse3', required: get_option('fuse'),
>>-                  version: '>=3D3=2E1', method: 'pkg-config')
>>+                  version: '>=3D3=2E1', method: 'pkg-config', include_t=
ype: 'system')
>>=20
>> fuse_lseek =3D not_found
>> if get_option('fuse_lseek')=2Eallowed()
>>@@ -2275,7 +2275,7 @@ endif
>>=20
>> # libbpf
>> bpf_version =3D '1=2E1=2E0'
>>-libbpf =3D dependency('libbpf', version: '>=3D' + bpf_version, required=
: get_option('bpf'), method: 'pkg-config')
>>+libbpf =3D dependency('libbpf', version: '>=3D' + bpf_version, required=
: get_option('bpf'), method: 'pkg-config', include_type: 'system')
>> if libbpf=2Efound() and not cc=2Elinks('''
>>    #include <bpf/libbpf=2Eh>
>>    #include <linux/bpf=2Eh>
>>@@ -2299,7 +2299,7 @@ libxdp =3D not_found
>> if not get_option('af_xdp')=2Eauto() or have_system
>>     if libbpf=2Efound()
>>         libxdp =3D dependency('libxdp', required: get_option('af_xdp'),
>>-                            version: '>=3D1=2E4=2E0', method: 'pkg-conf=
ig')
>>+                            version: '>=3D1=2E4=2E0', method: 'pkg-conf=
ig', include_type: 'system')
>>     else
>>         if get_option('af_xdp')=2Eenabled()
>>             error('libxdp requested, but libbpf is not available')
>>@@ -2312,7 +2312,7 @@ libdw =3D not_found
>> if not get_option('libdw')=2Eauto() or \
>>         (not get_option('prefer_static') and (have_system or have_user)=
)
>>     libdw =3D dependency('libdw',
>>-                       method: 'pkg-config',
>>+                       method: 'pkg-config', include_type: 'system',
>>                        required: get_option('libdw'))
>> endif
>>=20

