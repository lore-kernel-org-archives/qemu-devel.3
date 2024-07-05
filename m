Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EDEC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 18:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPnga-0003sD-Tm; Fri, 05 Jul 2024 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngX-0003jF-NZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:29 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngI-0006wy-UG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:29 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b5ec93f113so9909226d6.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 11:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720204154; x=1720808954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlRBJL/2kgLHCTVQl2/1heWLqm15rZiaaAznhm/gz9E=;
 b=X1/GG/+IJrSX+Kv/wPuU9HIMlo4MqaCbD9IM2pj8+cy7xYPDEqU6LuZoRq1cYwEyvw
 R1cqpgEG3Vu1Wwk5FoymUAGs2KXxg3CMk4BolGyuqSF7Q5j4JrnO92ZNi6c4WeeiiLnr
 MfBb7aWem28R0pJsA+ValLc5A+ZOBNMieh/kFA3sWRZy1YMjbylFMhAR8Hw5bIhrEdiP
 UZiQtNYrtgIv+G76vAE+D6L2o2OA4KCG4dtBt11xtQtsfkWF17qikgogbZoV/qtXWVZT
 eREvX3hZDoRVdX1woSFn/xwW1NMP7DI9+TYnNPBsLD1Avo2lRjI+ZCPe+yWqgau56BVA
 yIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720204154; x=1720808954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZlRBJL/2kgLHCTVQl2/1heWLqm15rZiaaAznhm/gz9E=;
 b=TnIpzZzFwpQu4ySJXnn5Dz0YsIK+pn8/eUF8doZoBWEWOeizeULC+ShfTJqTQfPfjm
 uIM7HRzl3jSGXav/3UWOcD6mJne2euxFwnilxI+iMbQUB5OgVXAHI4PCPt0lhWIxh2Ps
 cjgtCPCxNH0S2N2oP9a8/3dJoWDzdHLB5M2oCnUqpNPGM6h/WerIIquaurhayCdaayhi
 SZxp91266DsKbSxZHvatwagwuwMFLoGBoC/HjYILaSxWUho52u+ff5kma2zzHBYuOxJx
 dzSiv0ZMz6o+xA7+zkJolfHjzSZ5SYf2e8c+Pe/hZE5UYpJ5NuPM0ledsv6474YSvEOd
 cdUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3D1hqPYOv6VHY2gBKIH6dLC4Z0oxXCf3HjY5JF1AuMC6uHq5FNgFJCSzFL9SQ2O0vM47rzq5mcObvrAO/iz6kNq4y4rc=
X-Gm-Message-State: AOJu0YwsyDKp1IS0v/XIKqRi8E5lVv+Nr1MgBjaRLXHDvQPyk5A93LFK
 zHEANUW2BryiU33H3ulqnyE6fPCAXxP8dzasX3MVBUzhNyWf+h29PF08Q8ipEKI=
X-Google-Smtp-Source: AGHT+IFzIwsYkbBwiYaQDJildw88IIK4dzNI7RnNDvd8/EMHWNsj/cWeOpzxYESI+PykcQeXzi907w==
X-Received: by 2002:a05:6214:19ca:b0:6b2:a091:284f with SMTP id
 6a1803df08f44-6b5ed1c41e5mr58089956d6.65.1720204153952; 
 Fri, 05 Jul 2024 11:29:13 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-54-152-246-50.compute-1.amazonaws.com. [54.152.246.50])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5fb7e316esm4972936d6.30.2024.07.05.11.29.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 11:29:13 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v4 1/4] meson: Introduce 'qatzip' feature to the build system
Date: Fri,  5 Jul 2024 11:28:58 -0700
Message-Id: <20240705182901.48948-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240705182901.48948-1-yichen.wang@bytedance.com>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Add a 'qatzip' feature, which is automatically disabled, and which
depends on the QATzip library if enabled.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/meson.build b/meson.build
index 54e6b09f4f..820baf4745 100644
--- a/meson.build
+++ b/meson.build
@@ -1244,6 +1244,14 @@ if not get_option('uadk').auto() or have_system
      uadk = declare_dependency(dependencies: [libwd, libwd_comp])
   endif
 endif
+
+qatzip = not_found
+if get_option('qatzip').enabled()
+  qatzip = dependency('qatzip', version: '>=1.1.2',
+                      required: get_option('qatzip'),
+                      method: 'pkg-config')
+endif
+
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2378,6 +2386,7 @@ config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())
+config_host_data.set('CONFIG_QATZIP', qatzip.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4480,6 +4489,7 @@ summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
 summary_info += {'Query Processing Library support': qpl}
 summary_info += {'UADK Library support': uadk}
+summary_info += {'qatzip support':    qatzip}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16..35a69f6697 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -261,6 +261,8 @@ option('qpl', type : 'feature', value : 'auto',
        description: 'Query Processing Library support')
 option('uadk', type : 'feature', value : 'auto',
        description: 'UADK Library support')
+option('qatzip', type: 'feature', value: 'disabled',
+       description: 'QATzip compression support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index cfadb5ea86..1ce467e9cc 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -163,6 +163,7 @@ meson_options_help() {
   printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
+  printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
   printf "%s\n" '  qga-vss         build QGA VSS support (broken with MinGW)'
@@ -427,6 +428,8 @@ _meson_option_parse() {
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
     --prefix=*) quote_sh "-Dprefix=$2" ;;
+    --enable-qatzip) printf "%s" -Dqatzip=enabled ;;
+    --disable-qatzip) printf "%s" -Dqatzip=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
     --disable-qcow1) printf "%s" -Dqcow1=disabled ;;
     --enable-qed) printf "%s" -Dqed=enabled ;;
-- 
Yichen Wang


