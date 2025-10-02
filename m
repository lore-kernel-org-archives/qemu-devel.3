Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA497CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Muz-0000o5-Ka; Thu, 02 Oct 2025 13:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuX-0000ZF-4r
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuI-0005cQ-MZ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yNaG/6ucbG5mg2eg8umLHmDKZAPnlboJTD4e0b/cYQ=;
 b=UU7TTgTc07XHzxXM6RfpI0McdlAHLKDyCenzQW1DhKaV5GsI2fW9vWIDxGzQ0Cw/afpGqP
 ByUcLF9aW18WRlzL3Z/UY0rifOkiRPUuOEThpnO8FAT/uWvLEZukjxS4AasIIDrpd50lQc
 wNkyO+lTrYHtkk7kqXceFtJrJjMtKK4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-b184Mqu-OOecR_dWcEjQHg-1; Thu, 02 Oct 2025 13:15:43 -0400
X-MC-Unique: b184Mqu-OOecR_dWcEjQHg-1
X-Mimecast-MFC-AGG-ID: b184Mqu-OOecR_dWcEjQHg_1759425342
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b4635c413a7so104773466b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425341; x=1760030141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yNaG/6ucbG5mg2eg8umLHmDKZAPnlboJTD4e0b/cYQ=;
 b=jaB32gBAnHYGgauJ5wJsT9EvxF6XgFa+vFtJFYgHGLTy7i1+lCZ91K5KFQxgdejBuB
 WY9UjcYEwsgXNHuPD8b6uVp9WAlbLWEMo23UuxcfYwa3r+UWzvsivVUucU/jWTnRstgQ
 qHpcnk4kUvpHsaF2kUs90++ch+ilMGHvwF0tK045UqfiqFqUNfV4zsM9joH5mOiGlttE
 Smp8+iWFAiKHXo/8X16mKVahFMN1HwsZTW0+GdzJ5I9uYHuEchtbJ/xMINvHKbZ3s85c
 WXwY0FgpprEbxU1f3ErVGraQyP2n1lurEmwODnQb6zMEwKZRDpgyRD5XXHiPeoq2/4Fv
 rsng==
X-Gm-Message-State: AOJu0Yx2aSiPBZT43Yu2iYOSkvYYassUz8TBcDyHiN8b1Op6Ngyr0FpB
 J6GRaHEcKSVMI1R0LzyybVUccN5lx7MiCcsFz18FjiGdUiLrtlKX4cw0wsJU2Z4hK6FCls5Qu21
 UJX7kIlZUPvjq1Sc4rLr0cKAPPcFyN6BIAlsEXLJAbYtPlmcnisGB2mQzHZlTC3rRBEMP/Cd3HI
 0L6JHNOe/Ad0Yxp2zlCqanjdpQP+AATyNDlsFXN3Uh
X-Gm-Gg: ASbGncteZMesuSxfgIz3yTh1WeuKXRhH3PWUbLfBIucOJDt455Llk4F1HT5JrYK+rsu
 zFseFz/GCmdbYnApXgTpi5lMGeYjNy7Zbw1wXwTV/xiA5sZa6FUTKahfJmIkOpNkO1o40Lzkhkd
 V0pAIPxgO/0CjI3aB2VGlMgK845zeEpz1GKizPrbbxELIE+CkIfUNt8KIDNu5E5GphK7hNSvnel
 FaNrONokgWrn39gTJQyfcU6WaFRcpREC/hYrV6AXYa5YP/y7U34NgoE9pPeZlwePQpC1PEoJcIO
 rn/3xcLe6Yt5HkTfwZUstGdkmSne1VehdwT0Ojk6NpP/ti8AfVTII3VQBbBeFZBKSYH2JOJ/omc
 L5QDlLX4OfoHCnC7HakWe1ybNScDBeqJG6HHXBjybyNZ2Wnbw
X-Received: by 2002:a17:907:1c1b:b0:b42:9840:eac1 with SMTP id
 a640c23a62f3a-b49c4393389mr21424766b.49.1759425341471; 
 Thu, 02 Oct 2025 10:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/AztTMPFVXpA0AKvaU8xmTUtNnDrErj17mfG3z6uWmsOoVO4Lgtaxr6V/Cn/bfEVORahb9Q==
X-Received: by 2002:a17:907:1c1b:b0:b42:9840:eac1 with SMTP id
 a640c23a62f3a-b49c4393389mr21420266b.49.1759425340874; 
 Thu, 02 Oct 2025 10:15:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486a173a5dsm232783866b.85.2025.10.02.10.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:15:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 01/27] accel: Add Meson and config support for MSHV accelerator
Date: Thu,  2 Oct 2025 19:15:10 +0200
Message-ID: <20251002171536.1460049-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 55c8202a4d8..31ddce93a38 100644
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
+if 'CONFIG_MSHV' not in accelerators and get_option('whpx').enabled()
+  error('mshv not available on this platform')
+endif
 
 xen = not_found
 if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
@@ -4826,6 +4838,7 @@ if have_system
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


