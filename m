Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4C2C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 08:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpOl6-0004rF-Gs; Wed, 27 Mar 2024 04:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpOl5-0004r4-3W
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:35:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpOl2-0000iv-QV
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:35:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e6b729669bso5373198b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 01:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711528538; x=1712133338;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=shyMHVOYeZYEDpNCG60RbJmXKyueZNGM40OWcSGe4BY=;
 b=tbGVwWT2uhohQLb9iKEw+2Caa+WDJ4LEOpWyVe7yD8Zp/Uv56bqu2INo9CZwZhiRJr
 goBbfo0BoOGuu/x521XwXJPoAi4WgK9novwPKw6kiEFSQBlZrlECCUjR0dL1l6Rmvs8g
 6CFM+9jFOvcwe5bkexO4ZPig5ZCWHo6uSvDk85Lus4prNAodcuo79Zm98rMSbbSWTa6P
 655+DgQaH3p03It1tfFLNPj2tA4/qX5W0wg5tumrrbMkE7Kgbz73V0NRtrY0MWC9Xfvx
 /0zW6Bt9Bfc/SaxFMOICHIPzieLaI2nq5fETSSjZkhGy23sd3Y4Jy6KU6fzzsDqbRDqw
 KP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711528538; x=1712133338;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=shyMHVOYeZYEDpNCG60RbJmXKyueZNGM40OWcSGe4BY=;
 b=Qd5vQ/VrESEZ/suqCD2gEuMuNxuu4TAM8N1BebzihasYnbFGWS/4WQDQQltJdRWMgN
 ttoBvU7zMfuY+BAJ9YhmnIcUSFUQ+89Vlzd3XS+yDHSh9CDSr4Ef2gseB5OyhQo6ibij
 gfajy3g++XrxzcQSR2UfMQGBExugs4nc/XhpEHJKUU1ZX5wW3tv90N6n9wc5sSHVvgBF
 WzAjWt7LPZB87P0teqX1rfRaRs5LPo+/hFheRCNrZbSQ9NwbbYXSaMNLMi/oDpjYt50l
 iLSkS7SOcB5i1aZisRBSIzEnL79Iwrzp0/pJH4+pNizWDYAvMa6pmOTZgTA1PbK8TR8a
 EnAg==
X-Gm-Message-State: AOJu0YyPxF2WrX+QfMzYH/Tm7z4oj+H3ZKMZwRwD2xMV6JJMvi31iE46
 4UNakwBqiSr9mGagWdthZwsO2GhngsXjstGZrpdGVcSsXsLSynr+LUD3Mt2lxu4qUtVxx76abdP
 Q
X-Google-Smtp-Source: AGHT+IGepkdhrEwd5tzrscb9nvN0qZzFWBTeuOSUXUO5AO3SZc6ts23R40wxJqMrhAxm3XptshT31A==
X-Received: by 2002:a05:6a21:3101:b0:1a3:6474:3953 with SMTP id
 yz1-20020a056a21310100b001a364743953mr778419pzb.35.1711528537823; 
 Wed, 27 Mar 2024 01:35:37 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 hg23-20020a17090b301700b0029c73ed3748sm1039265pjb.6.2024.03.27.01.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 01:35:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 27 Mar 2024 17:35:30 +0900
Subject: [PATCH] configure: Disable -Werror by default if sanitizers are
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-werror-v1-1-5d2ccce9a17e@daynix.com>
X-B4-Tracking: v=1; b=H4sIAFHaA2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyNz3fLUoqL8Il3TFKNUS3OTZOMU8xQloOKCotS0zAqwQdGxtbUAKyY
 Ou1gAAAA=
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

With GCC 13.2.1 I got the following warning when sanitizers are enabled:

../hw/net/rtl8139.c: In function 'rtl8139_io_writeb':
../hw/net/rtl8139.c:2273:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
 2273 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);

The bug is reported upstream and you can find details at:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494

The GCC documentation states it is not recommended to combine -Werror
and sanitizers so disable -Werror by default if sanitizers are enabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 configure | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configure b/configure
index 3cd736b139f3..3407f9971db1 100755
--- a/configure
+++ b/configure
@@ -262,6 +262,7 @@ unset target_list_exclude
 # The following Meson options are handled manually (still they
 # are included in the automatically generated help message)
 # because they automatically enable/disable other options
+sanitizers=no
 tcg="auto"
 cfi="false"
 
@@ -713,6 +714,10 @@ for opt do
       meson_option_add -Doptimization=0
       default_cflags='-O0 -g'
   ;;
+  --disable-sanitizers) sanitizers=no
+  ;;
+  --enable-sanitizers) sanitizers=yes
+  ;;
   --disable-tcg) tcg="disabled"
   ;;
   --enable-tcg) tcg="enabled"
@@ -1706,9 +1711,15 @@ if test "$skip_meson" = no; then
   echo "cpp_link_args = [$(meson_quote $CXXFLAGS $LDFLAGS $EXTRA_CXXFLAGS $EXTRA_LDFLAGS)]" >> $cross
 
   # Only enable by default for git builds and on select OSes
+  # Also don't enable if sanitizers are enabled. The GCC documentation says:
+  # > Note that sanitizers tend to increase the rate of false positive warnings,
+  # > most notably those around -Wmaybe-uninitialized. We recommend against
+  # > combining -Werror and [the use of] sanitizers.
+  # https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Instrumentation-Options.html
   echo "# environment defaults, can still be overridden on " >> $cross
   echo "# the command line" >> $cross
   if test -e "$source_path/.git" && \
+      test "$sanitizers" == no && \
       { test "$host_os" = linux || test "$host_os" = "windows"; }; then
       echo 'werror = true' >> $cross
   fi
@@ -1789,6 +1800,7 @@ if test "$skip_meson" = no; then
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
+  test "$sanitizers" = yes && meson_option_add -Dsanitizers=true
   run_meson() {
     NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
   }

---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240327-werror-5d2e974c3d7d

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


