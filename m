Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2B5CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQR-0008Dr-FZ; Thu, 09 Oct 2025 03:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQP-0008DR-S3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQF-0004Lx-0m
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyOnyEib+YgYPdGc4tRSKxU4ZzTsbMTZCc0XJuyrE4g=;
 b=bgd73962BkZh7Wn6sF/4iXWLoaBuR3VUCjvK5csFW6r4IHklojBOn+lAO+Gs6AL+UDjs7Z
 mtXWGj5ti0rCDvxwL/dxEufXld2V2ohM2a4nEyuQv2+S7N6QZxonvJD2Ft3PSY6aBcQcY8
 hl+IQU/CfwiuZQ23sKnasLfw1V4Ae5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-6qZ9DgQXOHS1YUApFfmWsA-1; Thu, 09 Oct 2025 03:50:44 -0400
X-MC-Unique: 6qZ9DgQXOHS1YUApFfmWsA-1
X-Mimecast-MFC-AGG-ID: 6qZ9DgQXOHS1YUApFfmWsA_1759996243
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e41c32209so3394615e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996242; x=1760601042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyOnyEib+YgYPdGc4tRSKxU4ZzTsbMTZCc0XJuyrE4g=;
 b=E3y8v3th6x+xOFP87vl2l/bbgqAU9d0Yx+vB7u3MT7jb4BxvPpwij5MvHLPYwfVgx9
 6dIXPNmrSdhvZgdHAZAv1T99prdh3gmtAIb9226sxiuglbidgCP4vxLlFgn33GvHc2mm
 7MRVIXbKV5eV+OeViAcUgX6svzVwHVVXihL255Z67/+SkAHRThlL/2QQBG1CvHWZHh2w
 YnlBJoEi60h4E97jaLK4O8fEUskV6Wb5jS4U7XTRODoFXBQyl9xS73rCfHpS3LI8KZk4
 asSTaOYEhuhiPSNKqxtNJsjZB+f8osqatwUNC1TH0q9R5RMCay3h+M/HC6gcochL8p+o
 75rw==
X-Gm-Message-State: AOJu0YyuJ8sza7P6KIP/iA9ihfejTCVDy5uEmbjR5xgjmWZjiHdkt7a9
 xDIrhtQA1CBfuNUy8ap/AYIqqSICQiGZ/lJ8WXNNt14a2okqTHl3xuQf/UBAokARMmWQGJMLnow
 kZsLhJ1kqIiwr4DTQKUkcwCBoHKzdopdTR+tZ6/NczK8UkkZKVm2cmsKnI8+7mYp15WNkSkz46s
 qNSU/qDI5uoW0JSOaYP1VYRl5VLVktnfoAvlO3aFenqS8=
X-Gm-Gg: ASbGnctVdZ2YUmInjZWnXvdXLsIuUsYBNL53yk7rtwrWu/PB3FUzTUKAUXh2P5wS6Ir
 1yGll0e62x3M8vluKEkLp5w6+MfJrWO7P14kvwtRj4qWxEF8m87VRjXO4MP1TAqwzUVvvXlK4Cy
 VCDAMgKWz27TQwzgtW9jqvL1/EfUQIdukLkoBGv7I1sebFN7U7JctsTiO9ZZ5AiNXf8a/MxEqvc
 sX3zu94XilnTE9Bro3Yj4CBwq1bnu6RWmNEfAU7LMNFJ2pz+8gv6ZTr7qFCcbqDpistflwvL2Me
 jDnwp9dU/hnA6Hj0Bwj7RY2PR0LYwEj9P2cc9jXrnzXvEGUBdLQmM7G6Ek1jP3RUUbE2N5gUt0j
 lEgRdTkKyG8NuIWXX37wPwnLGntrZWH+X6CEWcVqF+kVC2l9x
X-Received: by 2002:a05:600c:468c:b0:46e:3287:57d6 with SMTP id
 5b1f17b1804b1-46fa9b0e7f0mr42688905e9.27.1759996242464; 
 Thu, 09 Oct 2025 00:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaINTuXxeJWDodHMV5vHaG60InsNvuqmxKdkCA4dSOyf5hicp9f966vtQ7dgOW1n1WXNA0Rg==
X-Received: by 2002:a05:600c:468c:b0:46e:3287:57d6 with SMTP id
 5b1f17b1804b1-46fa9b0e7f0mr42688655e9.27.1759996241973; 
 Thu, 09 Oct 2025 00:50:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe9bsm33586711f8f.22.2025.10.09.00.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/35] accel: Add Meson and config support for MSHV accelerator
Date: Thu,  9 Oct 2025 09:49:57 +0200
Message-ID: <20251009075026.505715-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Introduce a Meson feature option and default-config entry to allow
building QEMU with MSHV (Microsoft Hypervisor) acceleration support.

This is the first step toward implementing an MSHV backend in QEMU.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250916164847.77883-2-magnuskulke@linux.microsoft.com
[Add error for unavailable accelerator. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 13 +++++++++++++
 accel/Kconfig                 |  3 +++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 21 insertions(+)

diff --git a/meson.build b/meson.build
index 62766c0f19c..167021ed621 100644
--- a/meson.build
+++ b/meson.build
@@ -334,6 +334,7 @@ elif cpu == 'x86_64'
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_MSHV': ['x86_64-softmmu'],
   }
 endif
 
@@ -883,6 +884,14 @@ accelerators = []
 if get_option('kvm').allowed() and host_os == 'linux'
   accelerators += 'CONFIG_KVM'
 endif
+
+if get_option('mshv').allowed() and host_os == 'linux'
+  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
+    error('mshv accelerator requires x64_64 host')
+  endif
+  accelerators += 'CONFIG_MSHV'
+endif
+
 if get_option('whpx').allowed() and host_os == 'windows'
   if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
     error('WHPX requires 64-bit host')
@@ -952,6 +961,9 @@ endif
 if 'CONFIG_WHPX' not in accelerators and get_option('whpx').enabled()
   error('WHPX not available on this platform')
 endif
+if 'CONFIG_MSHV' not in accelerators and get_option('mshv').enabled()
+  error('mshv not available on this platform')
+endif
 
 xen = not_found
 if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
@@ -4827,6 +4839,7 @@ if have_system
   summary_info += {'HVF support':       config_all_accel.has_key('CONFIG_HVF')}
   summary_info += {'WHPX support':      config_all_accel.has_key('CONFIG_WHPX')}
   summary_info += {'NVMM support':      config_all_accel.has_key('CONFIG_NVMM')}
+  summary_info += {'MSHV support':      config_all_accel.has_key('CONFIG_MSHV')}
   summary_info += {'Xen support':       xen.found()}
   if xen.found()
     summary_info += {'xen ctrl version':  xen.version()}
diff --git a/accel/Kconfig b/accel/Kconfig
index 4263cab7227..a60f1149238 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -13,6 +13,9 @@ config TCG
 config KVM
     bool
 
+config MSHV
+    bool
+
 config XEN
     bool
     select FSDEV_9P if VIRTFS
diff --git a/meson_options.txt b/meson_options.txt
index fff1521e580..1be7d61efdd 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -71,6 +71,8 @@ option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
 
 option('kvm', type: 'feature', value: 'auto',
        description: 'KVM acceleration support')
+option('mshv', type: 'feature', value: 'auto',
+       description: 'MSHV acceleration support')
 option('whpx', type: 'feature', value: 'auto',
        description: 'WHPX acceleration support')
 option('hvf', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0ebe6bc52a6..d3d8f48bbbe 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -154,6 +154,7 @@ meson_options_help() {
   printf "%s\n" '  membarrier      membarrier system call (for Linux 4.14+ or Windows'
   printf "%s\n" '  modules         modules support (non Windows)'
   printf "%s\n" '  mpath           Multipath persistent reservation passthrough'
+  printf "%s\n" '  mshv            MSHV acceleration support'
   printf "%s\n" '  multiprocess    Out of process device emulation support'
   printf "%s\n" '  netmap          netmap network backend support'
   printf "%s\n" '  nettle          nettle cryptography support'
@@ -408,6 +409,8 @@ _meson_option_parse() {
     --disable-modules) printf "%s" -Dmodules=disabled ;;
     --enable-mpath) printf "%s" -Dmpath=enabled ;;
     --disable-mpath) printf "%s" -Dmpath=disabled ;;
+    --enable-mshv) printf "%s" -Dmshv=enabled ;;
+    --disable-mshv) printf "%s" -Dmshv=disabled ;;
     --enable-multiprocess) printf "%s" -Dmultiprocess=enabled ;;
     --disable-multiprocess) printf "%s" -Dmultiprocess=disabled ;;
     --enable-netmap) printf "%s" -Dnetmap=enabled ;;
-- 
2.51.0


