Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EFCC83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH7U-0008UK-GY; Mon, 14 Jul 2025 07:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzY-0000pO-RG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzT-0001dd-LZ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvaPDebJQqrXFfnLyyiynRkEMunN2jwXGo43DBM4hqM=;
 b=RGToYhc2dZ68NY69GPTP1EHogzzDDkOoIn4T39Zx0JTuggoL7t0LSCBTLXqshRs8NDScEx
 NqJLsu7s40E87Ll5zGykqEJld6zZla9QmHxfzukD3AIyaHLChUHfDrtDakYL98VgrQrAW0
 xjVc4RyAa2XTe5ATp7ORauKpt9k0ur0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-TI1Zl6mEMgS7hx2Au5kZ6w-1; Mon, 14 Jul 2025 07:04:57 -0400
X-MC-Unique: TI1Zl6mEMgS7hx2Au5kZ6w-1
X-Mimecast-MFC-AGG-ID: TI1Zl6mEMgS7hx2Au5kZ6w_1752491096
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-455f7b86aeeso12296545e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491095; x=1753095895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvaPDebJQqrXFfnLyyiynRkEMunN2jwXGo43DBM4hqM=;
 b=uddZGCCCbpA1vnGCBo24YafrvAcEJFvP0nARSAEv7deEYb40UiS5M5Zkf6IRVCEA9e
 xAKaw43+lq9ZDNT2vRKnsN97Ake2OzvXaVYCCJ11y5b3Tz761q1p6jb1NGFN2M5EK1kL
 SQihV7E6OOHKeVY+mdGhUa50A3/cpU6ng1nbZLhjVPP8FJuWdkHgpZ3YZuYNPg2KW7nv
 wJJVcEUfs/Dvw74+AGVNvZlrgu/JBTHWLhKEFynDgy4xUyd80rS0/dmari50aSP3vkZl
 kAub2HiZAD7SfbvrS8P/Wztzm4SGHsFlOkhgDGzpGJqgaDqAlqP/zLCV+mXJ/XU3v5Vv
 YoSg==
X-Gm-Message-State: AOJu0YzSOhysREXF9P6yIxfEY12+gKjIpQeK+k0xDDG/8MzYVtG6eNRx
 4xXASgI156XdTc0pTJ52kMUZFHDSlInPKRki+qs6loSPuJZxqHl9Lnmn8df+jjNdpebqBBNHq46
 pQvWjxWc6eZ56NAoebFJTOqBhpOwnmsKMvHGYu+J7Mi+tkTQwAoY3eXi+UIVPq/5lVLDi871xF3
 xPAwrCr6Lk09hum+et8y2W/SVMlT6gDhnlgZrSnxHK
X-Gm-Gg: ASbGnct+MZtgvCrbmdIR9nklDyDZK7MotxKgVQLglaAijVIvBtDZv6zVbel3jNpX+vV
 ZihvuiqfPhtlVRUvwE4QEKi+w9Oenm6hbsMHyD2LjD66mR1vCwk12+FMA2hVbkJq2TQ/H75NX3T
 mLGY/hXmXQga9OJGXK8qjpJNRTCfHCmzJRaCMCrPE/EkOGkAWZ6eeOhXFNctLDTJ7RWUzuTBrFF
 6TUF000V0Sso7S9v0o7HV8ZCwhd5JQQ9zKK5O+DcZKgGN705QkB5pF/TuK/CwUXsMcC0Ov+Qctd
 FwnucAmLqFyULb50iO3vX+p/PT7R+LFfQPPRXE4ZuIE=
X-Received: by 2002:a05:6000:2088:b0:3b3:a6e1:135c with SMTP id
 ffacd0b85a97d-3b5f2e32f4fmr8643404f8f.42.1752491094902; 
 Mon, 14 Jul 2025 04:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9XRIDEC+alv0gL1xVW/RCLAQXcrsdsbZhO0y1skcuB05+k8bqSJfKl5Abficiw+qZ/rYbpg==
X-Received: by 2002:a05:6000:2088:b0:3b3:a6e1:135c with SMTP id
 ffacd0b85a97d-3b5f2e32f4fmr8643376f8f.42.1752491094316; 
 Mon, 14 Jul 2025 04:04:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45614aeba29sm43525615e9.11.2025.07.14.04.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 17/77] meson: Add optional dependency on IGVM library
Date: Mon, 14 Jul 2025 13:03:06 +0200
Message-ID: <20250714110406.117772-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

The IGVM library allows Independent Guest Virtual Machine files to be
parsed and processed. IGVM files are used to configure guest memory
layout, initial processor state and other configuration pertaining to
secure virtual machines.

This adds the --enable-igvm configure option, enabled by default, which
attempts to locate and link against the IGVM library via pkgconfig and
sets CONFIG_IGVM if found.

The library is added to the system_ss target in backends/meson.build
where the IGVM parsing will be performed by the ConfidentialGuestSupport
object.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/45945a83a638c3f08e68c025f378e7b7f4f6d593.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 8 ++++++++
 backends/meson.build          | 3 +++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 4 files changed, 16 insertions(+)

diff --git a/meson.build b/meson.build
index b5f74aa37a7..200352c2448 100644
--- a/meson.build
+++ b/meson.build
@@ -1424,6 +1424,12 @@ if host_os == 'linux' and (have_system or have_tools)
                        method: 'pkg-config',
                        required: get_option('libudev'))
 endif
+igvm = not_found
+if not get_option('igvm').auto() or have_system
+  igvm = dependency('igvm', version: '>= 0.3.0',
+                    method: 'pkg-config',
+                    required: get_option('igvm'))
+endif
 
 mpathlibs = [libudev]
 mpathpersist = not_found
@@ -2601,6 +2607,7 @@ config_host_data.set('CONFIG_CFI', get_option('cfi'))
 config_host_data.set('CONFIG_SELINUX', selinux.found())
 config_host_data.set('CONFIG_XEN_BACKEND', xen.found())
 config_host_data.set('CONFIG_LIBDW', libdw.found())
+config_host_data.set('CONFIG_IGVM', igvm.found())
 if xen.found()
   # protect from xen.version() having less than three components
   xen_version = xen.version().split('.') + ['0', '0']
@@ -4965,6 +4972,7 @@ summary_info += {'seccomp support':   seccomp}
 summary_info += {'GlusterFS support': glusterfs}
 summary_info += {'hv-balloon support': hv_balloon}
 summary_info += {'TPM support':       have_tpm}
+summary_info += {'IGVM support':      igvm}
 summary_info += {'libssh support':    libssh}
 summary_info += {'lzo support':       lzo}
 summary_info += {'snappy support':    snappy}
diff --git a/backends/meson.build b/backends/meson.build
index 9b88d226851..ac0fac78458 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -34,6 +34,9 @@ if have_vhost_user_crypto
 endif
 system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
+if igvm.found()
+  system_ss.add(igvm)
+endif
 
 system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
 
diff --git a/meson_options.txt b/meson_options.txt
index a442be29958..1e429311a2d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -117,6 +117,8 @@ option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
 option('valgrind', type : 'feature', value: 'auto',
        description: 'valgrind debug support for coroutine stacks')
+option('igvm', type: 'feature', value: 'auto',
+       description: 'Independent Guest Virtual Machine (IGVM) file support')
 
 # Do not enable it by default even for Mingw32, because it doesn't
 # work on Wine.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 73e0770f42b..78515404450 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -130,6 +130,7 @@ meson_options_help() {
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
+  printf "%s\n" '  igvm            IGVM file support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
@@ -346,6 +347,8 @@ _meson_option_parse() {
     --iasl=*) quote_sh "-Diasl=$2" ;;
     --enable-iconv) printf "%s" -Diconv=enabled ;;
     --disable-iconv) printf "%s" -Diconv=disabled ;;
+    --enable-igvm) printf "%s" -Digvm=enabled ;;
+    --disable-igvm) printf "%s" -Digvm=disabled ;;
     --includedir=*) quote_sh "-Dincludedir=$2" ;;
     --enable-install-blobs) printf "%s" -Dinstall_blobs=true ;;
     --disable-install-blobs) printf "%s" -Dinstall_blobs=false ;;
-- 
2.50.0


