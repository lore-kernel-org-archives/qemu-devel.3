Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F0C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekj-0007Fk-AU; Thu, 27 Feb 2025 09:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekb-0007Ei-KA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekX-0003lK-3b
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDS6Z8WrawwiiNNBQJGPMXXcS8yRfFQepxVzx5eREHg=;
 b=eaq6drC+JkXJffsUXMNYqSLw1o5J05htqPeu2KEdq2hnqriKVb+OCwfEt52wIiu8QzDtGV
 rUy6qG7rspHdESb5JkoRGcUBc0cHPYzYjPBjyVbdaSwugjLs8bJbMKINbQKLOgw7Rk53RA
 u0qPXcWap/0OtBnwu8NzPmXS9Afg+RM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-_OkUomRKOi2xiANX7B9tZQ-1; Thu, 27 Feb 2025 09:20:25 -0500
X-MC-Unique: _OkUomRKOi2xiANX7B9tZQ-1
X-Mimecast-MFC-AGG-ID: _OkUomRKOi2xiANX7B9tZQ_1740666023
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abec83a498cso114824066b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666022; x=1741270822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDS6Z8WrawwiiNNBQJGPMXXcS8yRfFQepxVzx5eREHg=;
 b=IZ236ryrjJtWnhMCKb6iJEcRHKCRYmhbC3ECP8XzLfQJJdLPIProI/wci2TafXe5Ls
 hq18WS7ai657c5jut7JPFySwEYSr8ZGZ7JVCKUthCPNR6x+Y7v4HKHtv+SxyP/F/YYZm
 Ui6LxIDV5qkY5ZFzrgP7h1uWZribfZxkuVB+Pu10kcY21/312qc28HyX21Z/In8Ud5eJ
 O1IoFL1Gt3BpRUOrAV5DdfmHwF+L/PjxMGEWj4+IgWC46njgaHCERHkM2aTYRgi83IUw
 JhlsnEKlXFDUgsskKFbZQ0/dkYOmz2DGa42Om3L0xioe3Y/GxQF9wv4lDKb+h0fBr1a/
 pZqQ==
X-Gm-Message-State: AOJu0YzBMJ8nywVOdeCqENwpsF+q34/FsaQndW5xzZaNAJqTMCmpobyW
 vsvcr8XWOEmz0WbZsD87Gb1BPDNn5JbkFPZsAhlh7Mql4v1Eneoohy2IQsqpQZx0BQ5bbuEhccB
 qg5hs7UvI/yZ5hjy+ZnRSqCUv2MEwmVkEPkfE6uXNJsRbqa/Dh+VYyT65YihWN/SyX6y2PQbadt
 WFJTtu5zmWO/g0WyOPiflO7IHMeFSYBuuV4++iLc0=
X-Gm-Gg: ASbGncvatZsXyRwd3dzO6TzFhUf48ZQ/yl9ejtgAksY3XAWrbbL8no8ZUuhebZmP5W0
 pkurE0C1ZLVicvD0sz/EQCan6zAw/8dq5AileDCTf7VXErJSHP8aCdoKsY5ZSik4/u9um85yEs9
 ihDPQqpE4U7gvtI2I/0aW6lsBqBSU1U+AbvC/57xCNbnYdMk9PWu1IdbkgrbDKJjd5YwCYNKZZ4
 GPf7TgdXEWXA6gYT662FUmecGo94dGdxTv+xJqasXZE1i2mjWqw79T4rvBEckt3lXrZYuoz0iEi
 lflSJFIF5zHigJT/Kty9
X-Received: by 2002:a17:907:a42:b0:abe:cecc:727 with SMTP id
 a640c23a62f3a-abeeefc9108mr1115438766b.53.1740666022538; 
 Thu, 27 Feb 2025 06:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGczmJdoKKAUlk0rHBNxZL5To0t5xZmTCbJAqQAD5Prh9RXIwM35vJs4lvLoUpGjyMkMyzqLQ==
X-Received: by 2002:a17:907:a42:b0:abe:cecc:727 with SMTP id
 a640c23a62f3a-abeeefc9108mr1115434066b.53.1740666021995; 
 Thu, 27 Feb 2025 06:20:21 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7ba168sm126906266b.163.2025.02.27.06.20.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/34] pvg: add option to configure it out
Date: Thu, 27 Feb 2025 15:19:31 +0100
Message-ID: <20250227141952.811410-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

... and also to require it (--enable-pvg).  While at it, unify the dependency()
call for pvg and metal, which simplifies the logic a bit.

Note that all other Apple frameworks are either required or always-present,
therefore do not add them to the summary in the same way as PVG.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 8 +++++---
 hw/display/meson.build        | 6 ++----
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index ad2c6b61930..0a2c61d2bfa 100644
--- a/meson.build
+++ b/meson.build
@@ -821,7 +821,6 @@ version_res = []
 coref = []
 iokit = []
 pvg = not_found
-metal = []
 emulator_link_args = []
 midl = not_found
 widl = not_found
@@ -843,8 +842,8 @@ elif host_os == 'darwin'
   coref = dependency('appleframeworks', modules: 'CoreFoundation')
   iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
   host_dsosuf = '.dylib'
-  pvg = dependency('appleframeworks', modules: 'ParavirtualizedGraphics')
-  metal = dependency('appleframeworks', modules: 'Metal')
+  pvg = dependency('appleframeworks', modules: ['ParavirtualizedGraphics', 'Metal'],
+                   required: get_option('pvg'))
 elif host_os == 'sunos'
   socket = [cc.find_library('socket'),
             cc.find_library('nsl'),
@@ -4846,6 +4845,9 @@ summary_info += {'libdw':             libdw}
 if host_os == 'freebsd'
   summary_info += {'libinotify-kqueue': inotify}
 endif
+if host_os == 'darwin'
+  summary_info += {'ParavirtualizedGraphics support': pvg}
+endif
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
 if host_arch == 'unknown'
diff --git a/hw/display/meson.build b/hw/display/meson.build
index b9bdf219103..90e6c041bdb 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -61,10 +61,8 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
 system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
 
-if pvg.found()
-  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m'), pvg, metal])
-  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m'), pvg, metal])
-endif
+system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_PCI'],     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m')])
+system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_MMIO'],    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m')])
 
 if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss = ss.source_set()
diff --git a/meson_options.txt b/meson_options.txt
index 5eeaf3eee5c..59d973bca00 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -198,6 +198,8 @@ option('lzfse', type : 'feature', value : 'auto',
        description: 'lzfse support for DMG images')
 option('lzo', type : 'feature', value : 'auto',
        description: 'lzo compression support')
+option('pvg', type: 'feature', value: 'auto',
+       description: 'macOS paravirtualized graphics support')
 option('rbd', type : 'feature', value : 'auto',
        description: 'Ceph block device driver')
 option('opengl', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index a8066aab037..3e8e00852b2 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -168,6 +168,7 @@ meson_options_help() {
   printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
+  printf "%s\n" '  pvg             macOS paravirtualized graphics support'
   printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
@@ -436,6 +437,8 @@ _meson_option_parse() {
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
     --prefix=*) quote_sh "-Dprefix=$2" ;;
+    --enable-pvg) printf "%s" -Dpvg=enabled ;;
+    --disable-pvg) printf "%s" -Dpvg=disabled ;;
     --enable-qatzip) printf "%s" -Dqatzip=enabled ;;
     --disable-qatzip) printf "%s" -Dqatzip=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
-- 
2.48.1


