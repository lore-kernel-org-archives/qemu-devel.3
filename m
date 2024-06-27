Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC29CC30658
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 22:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMxhh-0004N6-L0; Thu, 27 Jun 2024 18:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sMxhf-0004MM-Iy
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 18:34:55 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sMxhc-0001hd-Dl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 18:34:55 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-25d8ab4f279so12628fac.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1719527689; x=1720132489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ca3+ASSRHT/T3lUzzZv0b/8X1bWoVAi2I/R4m07dOQY=;
 b=kFwdJs+LhRPGyqzzjApkCbAVZdZq8+2Z89CxziI43Iq7HS1ZPfroSuJW2i+ROYTq+c
 Cy7aEUarl9sLvgjTzjkCc/G7C7mk6wHeCFYQwOG5zHGieHUJ1UsoEcXMi8aw2SRj6/zx
 t+u53aGhO1EhPPAMF3QPYD+HvzlwdPWDSw9FadCfW77OlT7hena/G7mnKkLt9lsN9uAY
 7QydURd7CHVqmlSGli9PHtBO0G0u5UMS5U07IC4OFXdwfwfH30nq+1sc/vsVcUu7yFJS
 OYrQUZpQwHTmplodya0ZlOw+RtQE2z4Vv6UirDPEbitqom9Ns6Rk4xHmIAFV0f6jw7a3
 DUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719527689; x=1720132489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ca3+ASSRHT/T3lUzzZv0b/8X1bWoVAi2I/R4m07dOQY=;
 b=W83VSIVNp7xBA9XseMMR5UfFFdcUQtJNaA/plAAxwu8/UuErjRTHNWuzWpx7qf5rgZ
 GveaYATST9GgqYM14bcheDVUWuO4tx6Mr2fUjLTQPTMEhyC+c8NUiSR0maXBavlb1e+X
 oUlgkEitVgTtOf47a+55CjS6emymJv0uQMyEzMPs0FsiVl5jEAbdXipHIVuCZ2XdeigY
 LmW9XAmc4g0c8GaItOQFt7Y6aZAMX/8APD3ZFpaLrJJJAo+gDLA/SACBvWl3ymNDD8o9
 /h1hSmBV0hBHqzzLZm7RicF+vo3nklF4dkBmD5EXOTNHIcC8EnZd36tLbhgDFXKauhJR
 UhkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOcli9mJW5ho7zPWc0HPLEOUmTRHZ0hAMUUb4R1uQN/XbLMSSl0e3VPwOIs6PqxX0/8gAmUYjZyO1iZKz5bvyB9RQkdIk=
X-Gm-Message-State: AOJu0YwcySLx7GClaBdtiwmynO7KIdcdprNlrZ9iMnHenzU5s8RKwKVw
 vOxqsnxUO2+98MSkeKb90XVQ9ZIcliCUjfD/Fga0jSKMnWe9ALKAPwg1XK3Vefc=
X-Google-Smtp-Source: AGHT+IEKuMnSfNH7Zr0X0H2hbDy7Syit0Ras5kjXBEKu/qoJQawF8qrqpX104NPBnoybd0GaGfHgZA==
X-Received: by 2002:a05:6870:50f:b0:25d:dea:456f with SMTP id
 586e51a60fabf-25d0dea5d10mr14194708fac.42.1719527689556; 
 Thu, 27 Jun 2024 15:34:49 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080498a02csm226900b3a.199.2024.06.27.15.34.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 15:34:49 -0700 (PDT)
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
 Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v3 1/4] meson: Introduce 'qatzip' feature to the build system
Date: Thu, 27 Jun 2024 15:34:42 -0700
Message-Id: <20240627223445.95096-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240627223445.95096-1-yichen.wang@bytedance.com>
References: <20240627223445.95096-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oa1-x35.google.com
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Add a 'qatzip' feature, which is automatically disabled, and which
depends on the QATzip library if enabled.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/meson.build b/meson.build
index 97e00d6f59..009f07f506 100644
--- a/meson.build
+++ b/meson.build
@@ -1219,6 +1219,14 @@ if not get_option('uadk').auto() or have_system
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
@@ -2353,6 +2361,7 @@ config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())
+config_host_data.set('CONFIG_QATZIP', qatzip.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4468,6 +4477,7 @@ summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
 summary_info += {'Query Processing Library support': qpl}
 summary_info += {'UADK Library support': uadk}
+summary_info += {'qatzip support':    qatzip}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 7a79dd8970..3670e5058b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -263,6 +263,8 @@ option('qpl', type : 'feature', value : 'auto',
        description: 'Query Processing Library support')
 option('uadk', type : 'feature', value : 'auto',
        description: 'UADK Library support')
+option('qatzip', type: 'feature', value: 'disabled',
+       description: 'QATzip compression support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 58d49a447d..226605249e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -162,6 +162,8 @@ meson_options_help() {
   printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
+  printf "%s\n" '  pvrdma          Enable PVRDMA support'
+  printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
   printf "%s\n" '  qga-vss         build QGA VSS support (broken with MinGW)'
@@ -428,6 +430,10 @@ _meson_option_parse() {
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
     --prefix=*) quote_sh "-Dprefix=$2" ;;
+    --enable-pvrdma) printf "%s" -Dpvrdma=enabled ;;
+    --disable-pvrdma) printf "%s" -Dpvrdma=disabled ;;
+    --enable-qatzip) printf "%s" -Dqatzip=enabled ;;
+    --disable-qatzip) printf "%s" -Dqatzip=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
     --disable-qcow1) printf "%s" -Dqcow1=disabled ;;
     --enable-qed) printf "%s" -Dqed=enabled ;;
-- 
Yichen Wang


