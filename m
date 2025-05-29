Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C91C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKhpj-0007Ye-KH; Thu, 29 May 2025 14:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uKhph-0007Xy-FU
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:18:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uKhpf-0001LX-HM
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:18:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so10109855e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748542701; x=1749147501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKynma6/LAijbkt1FX7Nj0XHKYMRE/pu+Ydcv9PmJXY=;
 b=OuU6Je7zHZO2+9IIgwjQuHiirWGcLbtsSBd706nMx2VvDf9S8FOkXtT95BE2V6hNqx
 bhs6hzPrE+P3T40a56Cd7NjfmzoRKyF3Cx4qqf2LsNX3mdb1bzAJwfVsEJXJUSlleYdy
 v71IUdm8NwfTZQPxomGgMLKkYujr2HvBWu7aQiMPbm6kGvzxrfvyLKivZkhO/w+l+X8b
 m/RXOsNyqxmU8TgbkrcovOVh1wv5JU/dlgX4ae+QdEfttJPs//K/6Jw1HgYq9J3Gz4m+
 Xj0wKsaUFui8Wf+gHCJwpk+3PGWel42uy/AH8nj/mmQ5M6+LdE8xi42AwjmQim5JRav6
 jmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748542701; x=1749147501;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKynma6/LAijbkt1FX7Nj0XHKYMRE/pu+Ydcv9PmJXY=;
 b=YiOcQuAiPlUhiTultzE9AGLtVrgEZbr9/J2TTvIqKy9zkjPIVDGnxx4NSjDcMY0zqD
 3W7FXwVM2orKmMvMzciIT/KrWhJHD++zsS1BLNZ8gfb2ekpJZhO5iUFkMFEE/3IlGkOP
 J/SAYeF2EF5MO86RjvFdh1YgcyRtRpCfT7zsG3HFjljX2doJCVmcQKUmgGob7whA52nd
 Lam3otdMLX3KPE3gx072kPvZcBjScIVKbrUQxIoO6jXUid29Wy1r1t0j/UtSeTQA1I7y
 eP7Zpg0NP56TrS30GsnOr9slgXxm51Jeqxw1IkRGCgXlXiKYOO+eWSky+x6r98+iOzuj
 PcVA==
X-Gm-Message-State: AOJu0YzPuFRjs8f09sA10JQdCfu8bYo33nlfbeyTw0R2Zl1lUpfkIaF7
 8KNkalXVEC4Hpm7xT/nncwwOtntiYeKDan5DB8Nb9unDEH0ywzOCpwwSGHygiA==
X-Gm-Gg: ASbGncv77HJei7TAk/HLzh2JXWzs73ZjDLVSW8wVoUHl5fKzBD6Y6gA5r6x24SqwtR5
 yYdSfCSgEyUTkXHQ0n/FOMzSvJJSq0p2w2m6AMgN8SZuBsTdG49yxvj5VZtLmSA8xek/i//xKlt
 EDoOLbJDkPuSO91KA4uH6aSi/C59sVILVr5WWcfIub7EzgqX29eKRTSp+GU8JCDWWq+UvfIte9r
 Wq5OwYE+9hshbKp2TEWoNI9GrCeR9GqoxgGgdXgruA8KyR54PH56Th3cv0ZwdTavkVqLIFU9Cu4
 Srtg4VsMHUp8ORxEGoQbglPtngI7UlFY/UUUpQe7iCiR67lXx0LbKxQGwH43JrB3qaYvZ2o9FF6
 GGR3p/Y9m3w==
X-Google-Smtp-Source: AGHT+IF27iN99im87EmK6T9KvrGsSUWiVGoLQn+ec0ZMbRpphC+M/tb7h54IICN5NswS7FLb+rRypQ==
X-Received: by 2002:a05:600c:3542:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-450d64366a0mr9632205e9.0.1748542700213; 
 Thu, 29 May 2025 11:18:20 -0700 (PDT)
Received: from [127.0.0.1] (ip-185-104-138-110.ptr.icomera.net.
 [185.104.138.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450cfc030fcsm26161095e9.15.2025.05.29.11.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:18:19 -0700 (PDT)
Date: Thu, 29 May 2025 18:18:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PULL 36/58] pc-bios: Move device tree files in their own subdir
In-Reply-To: <20250425152843.69638-37-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
 <20250425152843.69638-37-philmd@linaro.org>
Message-ID: <621F23F2-05FC-4C8C-8AA8-F61DED04B306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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



Am 25=2E April 2025 15:28:20 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>From: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>
>We have several device tree files already and may have more in the
>future so add a new dtb subdirectory and move device tree files there
>so they are not mixed with ROM binaries=2E
>
>Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>Message-ID: <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa=2E1745402140=2Egit=
=2Ebalaton@eik=2Ebme=2Ehu>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> MAINTAINERS                                |   2 +-
> system/datadir=2Ec                           |   4 +++-
> pc-bios/{ =3D> dtb}/bamboo=2Edtb               | Bin
> pc-bios/{ =3D> dtb}/bamboo=2Edts               |   0
> pc-bios/{ =3D> dtb}/canyonlands=2Edtb          | Bin
> pc-bios/{ =3D> dtb}/canyonlands=2Edts          |   0
> pc-bios/dtb/meson=2Ebuild                    |  23 +++++++++++++++++++++
> pc-bios/{ =3D> dtb}/petalogix-ml605=2Edtb      | Bin
> pc-bios/{ =3D> dtb}/petalogix-ml605=2Edts      |   0
> pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edtb | Bin
> pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edts |   0
> pc-bios/meson=2Ebuild                        |  23 +--------------------
> qemu=2Ensi                                   |   2 +-
> 13 files changed, 29 insertions(+), 25 deletions(-)
> rename pc-bios/{ =3D> dtb}/bamboo=2Edtb (100%)
> rename pc-bios/{ =3D> dtb}/bamboo=2Edts (100%)
> rename pc-bios/{ =3D> dtb}/canyonlands=2Edtb (100%)
> rename pc-bios/{ =3D> dtb}/canyonlands=2Edts (100%)
> create mode 100644 pc-bios/dtb/meson=2Ebuild
> rename pc-bios/{ =3D> dtb}/petalogix-ml605=2Edtb (100%)
> rename pc-bios/{ =3D> dtb}/petalogix-ml605=2Edts (100%)
> rename pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edtb (100%)
> rename pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edts (100%)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 661a47db5ac=2E=2Ed82d962f1a4 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix=2Ec
> F: hw/display/sm501*
> F: hw/ide/sii3112=2Ec
> F: hw/rtc/m41t80=2Ec
>-F: pc-bios/canyonlands=2Edt[sb]
>+F: pc-bios/dtb/canyonlands=2Edt[sb]
> F: pc-bios/u-boot-sam460ex-20100605=2Ebin
> F: roms/u-boot-sam460ex
> F: docs/system/ppc/amigang=2Erst
>diff --git a/system/datadir=2Ec b/system/datadir=2Ec
>index e450b84ce91=2E=2Ef96f8fc2646 100644
>--- a/system/datadir=2Ec
>+++ b/system/datadir=2Ec
>@@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const char *na=
me)
>=20
>     switch (type) {
>     case QEMU_FILE_TYPE_BIOS:
>-    case QEMU_FILE_TYPE_DTB:
>         subdir =3D "";
>         break;
>+    case QEMU_FILE_TYPE_DTB:
>+        subdir =3D "dtb/";
>+        break;
>     case QEMU_FILE_TYPE_KEYMAP:
>         subdir =3D "keymaps/";
>         break;
>diff --git a/pc-bios/bamboo=2Edtb b/pc-bios/dtb/bamboo=2Edtb
>similarity index 100%
>rename from pc-bios/bamboo=2Edtb
>rename to pc-bios/dtb/bamboo=2Edtb
>diff --git a/pc-bios/bamboo=2Edts b/pc-bios/dtb/bamboo=2Edts
>similarity index 100%
>rename from pc-bios/bamboo=2Edts
>rename to pc-bios/dtb/bamboo=2Edts
>diff --git a/pc-bios/canyonlands=2Edtb b/pc-bios/dtb/canyonlands=2Edtb
>similarity index 100%
>rename from pc-bios/canyonlands=2Edtb
>rename to pc-bios/dtb/canyonlands=2Edtb
>diff --git a/pc-bios/canyonlands=2Edts b/pc-bios/dtb/canyonlands=2Edts
>similarity index 100%
>rename from pc-bios/canyonlands=2Edts
>rename to pc-bios/dtb/canyonlands=2Edts
>diff --git a/pc-bios/dtb/meson=2Ebuild b/pc-bios/dtb/meson=2Ebuild
>new file mode 100644
>index 00000000000=2E=2E7a71835bca7
>--- /dev/null
>+++ b/pc-bios/dtb/meson=2Ebuild
>@@ -0,0 +1,23 @@
>+dtbs =3D [
>+  'bamboo=2Edtb',
>+  'canyonlands=2Edtb',
>+  'petalogix-ml605=2Edtb',
>+  'petalogix-s3adsp1800=2Edtb',

Was it intended that the suffix changed from =2Edts to =2Edtb? This change=
 isn't motivated in the commit message and usually source files rather than=
 generated artifacts are listed in build files=2E

Best regards,
Bernhard

>+]
>+
>+dtc =3D find_program('dtc', required: false)
>+if dtc=2Efound()
>+  foreach out : dtbs
>+    f =3D fs=2Ereplace_suffix(out, '=2Edts')
>+    custom_target(f,
>+        build_by_default: have_system,
>+        input: files(f),
>+        output: out,
>+        install: get_option('install_blobs'),
>+        install_dir: qemu_datadir / 'dtb',
>+        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
>+                        '-o', '@OUTPUT@', '@INPUT0@' ])
>+  endforeach
>+else
>+    install_data(dtbs, install_dir: qemu_datadir / 'dtb')
>+endif
>diff --git a/pc-bios/petalogix-ml605=2Edtb b/pc-bios/dtb/petalogix-ml605=
=2Edtb
>similarity index 100%
>rename from pc-bios/petalogix-ml605=2Edtb
>rename to pc-bios/dtb/petalogix-ml605=2Edtb
>diff --git a/pc-bios/petalogix-ml605=2Edts b/pc-bios/dtb/petalogix-ml605=
=2Edts
>similarity index 100%
>rename from pc-bios/petalogix-ml605=2Edts
>rename to pc-bios/dtb/petalogix-ml605=2Edts
>diff --git a/pc-bios/petalogix-s3adsp1800=2Edtb b/pc-bios/dtb/petalogix-s=
3adsp1800=2Edtb
>similarity index 100%
>rename from pc-bios/petalogix-s3adsp1800=2Edtb
>rename to pc-bios/dtb/petalogix-s3adsp1800=2Edtb
>diff --git a/pc-bios/petalogix-s3adsp1800=2Edts b/pc-bios/dtb/petalogix-s=
3adsp1800=2Edts
>similarity index 100%
>rename from pc-bios/petalogix-s3adsp1800=2Edts
>rename to pc-bios/dtb/petalogix-s3adsp1800=2Edts
>diff --git a/pc-bios/meson=2Ebuild b/pc-bios/meson=2Ebuild
>index 34d6616c32b=2E=2E34d8cc4f338 100644
>--- a/pc-bios/meson=2Ebuild
>+++ b/pc-bios/meson=2Ebuild
>@@ -86,31 +86,10 @@ blobs =3D [
>   'vof-nvram=2Ebin',
> ]
>=20
>-dtc =3D find_program('dtc', required: false)
>-foreach f : [
>-  'bamboo=2Edts',
>-  'canyonlands=2Edts',
>-  'petalogix-s3adsp1800=2Edts',
>-  'petalogix-ml605=2Edts',
>-]
>-  out =3D fs=2Ereplace_suffix(f, '=2Edtb')
>-  if dtc=2Efound()
>-    custom_target(f,
>-        build_by_default: have_system,
>-        input: files(f),
>-        output: out,
>-        install: get_option('install_blobs'),
>-        install_dir: qemu_datadir,
>-        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
>-                        '-o', '@OUTPUT@', '@INPUT0@' ])
>-  else
>-    blobs +=3D out
>-  endif
>-endforeach
>-
> if get_option('install_blobs')
>   install_data(blobs, install_dir: qemu_datadir)
> endif
>=20
> subdir('descriptors')
>+subdir('dtb')
> subdir('keymaps')
>diff --git a/qemu=2Ensi b/qemu=2Ensi
>index b186f223e14=2E=2Ed419986ca06 100644
>--- a/qemu=2Ensi
>+++ b/qemu=2Ensi
>@@ -204,7 +204,6 @@ Section "Uninstall"
>     Delete "$INSTDIR\*=2Ebmp"
>     Delete "$INSTDIR\*=2Ebin"
>     Delete "$INSTDIR\*=2Edll"
>-    Delete "$INSTDIR\*=2Edtb"
>     Delete "$INSTDIR\*=2Efd"
>     Delete "$INSTDIR\*=2Eimg"
>     Delete "$INSTDIR\*=2Elid"
>@@ -215,6 +214,7 @@ Section "Uninstall"
>     Delete "$INSTDIR\qemu-io=2Eexe"
>     Delete "$INSTDIR\qemu=2Eexe"
>     Delete "$INSTDIR\qemu-system-*=2Eexe"
>+    RMDir /r "$INSTDIR\dtb"
>     RMDir /r "$INSTDIR\doc"
>     RMDir /r "$INSTDIR\share"
>     ; Remove generated files

