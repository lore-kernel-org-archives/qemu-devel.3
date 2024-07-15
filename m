Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8FBC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 22:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTTwa-00052c-Ab; Mon, 15 Jul 2024 18:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sTTwV-00050d-1d
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:13:11 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sTTwS-0006JD-MU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:13:10 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-79efd2151d9so325850385a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1721081584; x=1721686384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlMvMSAMvhZyUe5kybi6fOi/LKJ/sjw1cIOEtywcrWw=;
 b=kyMPzGWUL4mD04l1tbbpCs5DazF+ypyYpcNgB1a9dZ7N778/JuVPiPNdycag0ALudN
 FIhJpSXRtnGqCiviT8JFIwl3lUhlSmFKsjkQaw4ZmxEtL6mhhfREKOnzCJDdShe6h7yt
 MFR8xZLOtOnbO1RqyRuMzvb9xIBFHg2ALpuJY1UMqcXbLEtjQZC/efde/NRanQ0O+Aoo
 tYBdYmAB6AhfClBdtitAVnyLK9GB/qUXEZNSDviJFV6sdSwumX7A+GqMOixYzwWXehHn
 SCHPzFFB8pK08ObrdBvwbiFN/6lD0Y1ylcbwvPzPoe25dQn3altNwV7JvqgkAA5RKNrT
 qqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721081584; x=1721686384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlMvMSAMvhZyUe5kybi6fOi/LKJ/sjw1cIOEtywcrWw=;
 b=YWZhOlyuc//zzAFbO/QkWlVEW33pyG0Y7TrOBxHSuCA8gv0Too7bnWe51CtTqDzgLY
 ItsRhxWsQDyxustDo/X2ocfgLyEVDXd0LCwCtfBA+kLHfuCS8XNcI2HGEmpuoOvLVN2J
 RG62nq32uIZvUd2T9yEY62cVj5/Yt0Cq5bNO1YGwu/hxEFGhZsBUX3UVXq0sWit9mFlC
 efCA9VefPY3J9US4xepjxvAz8UxgLkTZClhC4dJCrq6N55ehGQYv9wi6FjTmrveLuCp6
 PWiSCDpGtP0BAHByapmgJwIkFug/n0hY3d4Rzs9xptpqWBSoYhISL400KUpVbEQWWapU
 HUHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2pTteAS/zfxVxyAy24cRgeLycd100B89DJ/SpGWw9D/8js7nsEEJS5gaD8Ko6sM3VhPO90Y/fsdbdT0gUjl8yldqi+yw=
X-Gm-Message-State: AOJu0YzRQ0VVBlvfIn9zQJNMa88HQmgiOYpSfootL/I1eEuU3mHfVKEp
 6OtXl0plBcT+omNnGjdE5GI0EpdhZ04JrZKLRHMbaf2aRFgAvvxoUGrde8734Oo=
X-Google-Smtp-Source: AGHT+IEr8Z9Jm4UsWSnJ5A6XOgSQFaX2fzgHcQL/W7DXPomngSGsP38tv/OhRWCxiXFLIepXX3lOpA==
X-Received: by 2002:a05:6214:5a04:b0:6b2:da3d:999f with SMTP id
 6a1803df08f44-6b77f5d0fb3mr8491556d6.41.1721081584445; 
 Mon, 15 Jul 2024 15:13:04 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-52-8-182-0.us-west-1.compute.amazonaws.com. [52.8.182.0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b76198aca3sm25398326d6.51.2024.07.15.15.13.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jul 2024 15:13:04 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v6 2/5] meson: Introduce 'qatzip' feature to the build system
Date: Mon, 15 Jul 2024 15:12:42 -0700
Message-Id: <20240715221245.12435-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715221245.12435-1-yichen.wang@bytedance.com>
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qk1-x72e.google.com
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
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/meson.build b/meson.build
index 6a93da48e1..ea977c6cbf 100644
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
@@ -4484,6 +4493,7 @@ summary_info += {'lzfse support':     liblzfse}
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


