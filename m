Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338E6CA100A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 23:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skB28-0002BU-Oc; Fri, 30 Aug 2024 19:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1skB23-00023w-Lk
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 19:27:55 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1skB1z-0001qa-8z
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 19:27:55 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e115c8aa51fso2502743276.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725060469; x=1725665269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6kzDBDnEq23R80njs6FyZJuIYVc6qdV8gw3M4/+OWM=;
 b=jS7KO+rUFDdyix7hQmsXJ2YHZvmsLKJpcaXSrVvPvtNoIjOwnlKcRPspO7tIc0+kMp
 XMO2OqhedHKok3d657I0QBYGe7Wp2XGZDWT4+RwX/iifnDN8c6nYEtvwCY3IFnwH/Jqs
 P93W+U4jI6BXw7xjiyNkdLJp7NsdZ+IBozTqBdtAQpwE3L6s81U3YBq5+6axwS3BP4Af
 gRnPGAUFWhoibOT42RWJZvj0KuAYUKzfSPj3S9Edq5UvlzYO8PZWaK5/BCnyzVHQ+wE9
 xFRdmox3eCQAhvtxPuL4clVOMsYboQXaZi/opfY+9rXxkFasbqb6e6F/H6J2ZcAHb0yd
 NBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725060469; x=1725665269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6kzDBDnEq23R80njs6FyZJuIYVc6qdV8gw3M4/+OWM=;
 b=f9BVySv8VGTzMTbr+Kwq2yDVnFBvPpclm+PLLQ2BH4PVtTbxBFX0JOeVMuoWRbJ+m5
 BUDZkbsDyAvwiSSs69uOah9liOreQoPqnNJ4niZdpRn8y33Xusj8qR1D3zRPxGq4FiTp
 N3APJDwykGz5jtTFhtAkGjMNqDqpSCYj3HIyw76nnLiNVioxNDS/6z4ziTKLI3s9ycNM
 6GhRho840JlYU/aTuXLP30vlN+NAZlKKeQ2F6NpQQoFN+YVGJUKIPvJY+ADRJbQS/O7x
 qdLD0yHfOLPWfNiXX39bVmm4LIGkZUZhK1XH+dbUIuPDP2v6cM7Bb8PpLCLM+DFT6eFf
 15EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlygkVIQQBI/xJSrx1Drp+zX+zzOQ1E07Clf2DSSjEZx6rM4UNxuflW6enz1Iyp2gzMVr61DVfmYGw@nongnu.org
X-Gm-Message-State: AOJu0YyBjkODMEl0gL8FGswwgJoDWdrO5/8Pe9/HwEC6mdn+HAor0qEJ
 vXkNSk7oLkMgLrppBty01C3gwhNL5Ehrab4TBPPRzEFWJfENQKJhl9OroK/tMFQ=
X-Google-Smtp-Source: AGHT+IGi0vzOrR56tutZMI2tVmiF5Z3cgRgYIakb0zpeJDIAki1XG/7UBTf2/IG78bKLC0LiGLDj6A==
X-Received: by 2002:a05:6902:228f:b0:e1a:8ae4:c4f2 with SMTP id
 3f1490d57ef6-e1a8ae4c5damr1546233276.50.1725060468987; 
 Fri, 30 Aug 2024 16:27:48 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340ca689asm19129176d6.109.2024.08.30.16.27.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Aug 2024 16:27:48 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 "Xiaoning Ding" <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v9 2/5] meson: Introduce 'qatzip' feature to the build system
Date: Fri, 30 Aug 2024 16:27:19 -0700
Message-Id: <20240830232722.58272-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240830232722.58272-1-yichen.wang@bytedance.com>
References: <20240830232722.58272-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/meson.build b/meson.build
index fbda17c987..b89b713e79 100644
--- a/meson.build
+++ b/meson.build
@@ -1262,6 +1262,14 @@ if not get_option('uadk').auto() or have_system
      uadk = declare_dependency(dependencies: [libwd, libwd_comp])
   endif
 endif
+
+qatzip = not_found
+if not get_option('qatzip').auto() or have_system
+  qatzip = dependency('qatzip', version: '>=1.1.2',
+                      required: get_option('qatzip'),
+                      method: 'pkg-config')
+endif
+
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2412,6 +2420,7 @@ config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())
+config_host_data.set('CONFIG_QATZIP', qatzip.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4535,6 +4544,7 @@ summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
 summary_info += {'Query Processing Library support': qpl}
 summary_info += {'UADK Library support': uadk}
+summary_info += {'qatzip support':    qatzip}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16..f7b652b30d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -261,6 +261,8 @@ option('qpl', type : 'feature', value : 'auto',
        description: 'Query Processing Library support')
 option('uadk', type : 'feature', value : 'auto',
        description: 'UADK Library support')
+option('qatzip', type: 'feature', value: 'auto',
+       description: 'QATzip compression support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c97079a38c..5f377a6d81 100644
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


