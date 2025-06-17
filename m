Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49973C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 20:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRd1E-0000nl-PK; Tue, 17 Jun 2025 16:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uRd19-0000jV-EN
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 16:34:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uRd16-0005rd-D7
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 16:34:51 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad89ee255easo1132748366b.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750192484; x=1750797284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ggtHM3GAaW5X/Kz0xY6kUpW+9KOtvI/XJSER1Yg1Ek8=;
 b=kzbmumzjB1aSnc5JwNAGjdoQXlKmMBALIc5cFFeipIkWqKpH6okme8jUYwrUH74gik
 hS/H94cyJRPvedFvA2WYhn8Gmu+aqYkht/W8tTHItIQYZ118yt/xoOHSQ+VDcZFWODW6
 IWy2syOtjBTrAI076t3GVY9ewI4bGl8UdbSNX4Q982GNl7Tdds/+NJPYItQnHc4jDMx+
 YlK87cz/UQGW2UUR88LPTNRjOuKIMARNRovt3ZhGsu1KfJDlot9Gl+0oowjvL0P2Rle/
 /WRfo4KCYU5oUkm1aTlpVc8E9E5O3fmaBTMs8rEkEnreOEgJg+QNPbnJ+R3Xj/c6p8Pr
 66cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750192484; x=1750797284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggtHM3GAaW5X/Kz0xY6kUpW+9KOtvI/XJSER1Yg1Ek8=;
 b=jGKmLJJ0fDe+BooDXYjn0jkYibsfXXQ2XHYUDEm7VHObNMX71EbJ0k7M8HyliX622S
 s+ck6GyYGd6Hd/F+zbTRXQHliAqoKTNWrcrXsEVpNmcAKjKEzjAc8h6dSbqn8jt8yZ5r
 LP2M+ndM/N5kfsWkh1htnEbRlTkrx9+f4LOyQzeu/YAwoyyrZq2+cNGagntppofiNOAp
 2OvcFStGHCrI837LbBqJq94bscJ7vGemLqVOyLAvAPxuA434oZ+xd+B7Snh2Sm4VwPB1
 Beox9HFSbEVNl4aOYQ7CAy8u5U/ni3QHYlLePo543ekso4xL8rGslVZFuA9EqHb7yNVM
 uOYQ==
X-Gm-Message-State: AOJu0YwNXlcxbybHM7O+qS2lMylZMHVoTvpl+6MGK4rpIuasSm4rNrHz
 IVyDxB1T7CtrzKvpYovRSYHmXwjK9N5G1zjVqi+NWRrU5REsWWVAFfgjM8LI9eV1
X-Gm-Gg: ASbGncux/uno9bJ11edfYWmFHac5Y8b8Hoajud/4j3KyvbukGiMM1Xu9rlYTr+jvlKJ
 9xnUE96o/468dYqOUkGunqhrVTgqPnf1XnhBKlva8TlBPx7PbZnyreBqf0GSXUGtOLo3BCDEjV0
 F9U0uB+wpfehee3aAgaLrn3mGHrbj/dYUndX62KjjwVNtt+B9PXjElwK2A8oqeBnwxK3e7LbB7W
 Z+HJoo4pYJlSvGNNAbB305CTIL6g59AmjJGoJDwSMJAjUE0yOlxcCaXnMFjheW8ZRMr19W69kdi
 RMk1+xhn5RNGqzZ9n7IZIfHLxgqG31ZWmMOyIa9iL/oOMDENr06M0DzT+u8Zv+u6UwUPRCieEfo
 mUc9HOYr8ROxM9qmcXtvR3rnRQjcQSA1zkbd9Jtf4PVgNBMUHMNmgTv22OrwTbmZMekQLJYDtC+
 WdvQ1M
X-Google-Smtp-Source: AGHT+IGpa1vkwT1qDmyAWrxnedBSnN1FjGbMGeNaTtQBNpf3JYcZqQXZo8RjRFfBx5E4FIV9tn0CJQ==
X-Received: by 2002:a17:907:868f:b0:adb:2ef9:db38 with SMTP id
 a640c23a62f3a-adfad5c7b4amr1482137466b.36.1750192484018; 
 Tue, 17 Jun 2025 13:34:44 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-23f9-0f00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:23f9:f00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec897ac3dsm919353466b.155.2025.06.17.13.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 13:34:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] meson: Add most 3rd-party includes as system includes
Date: Tue, 17 Jun 2025 22:34:35 +0200
Message-ID: <20250617203435.41490-1-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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

When compiling QEMU against fuse3-3.17.1 with --enable-werror the build fails
with:

  In file included from ../src/block/export/fuse.c:33:
  /usr/include/fuse3/fuse.h:959:5: error: redundant redeclaration of ‘fuse_main_real_versioned’ [-Werror=redundant-decls]
    959 | int fuse_main_real_versioned(int argc, char *argv[],
        |     ^~~~~~~~~~~~~~~~~~~~~~~~
  /usr/include/fuse3/fuse.h:885:5: note: previous declaration of ‘fuse_main_real_versioned’ with type ‘int(int,  char **, const struct fuse_operations *, size_t,  struct libfuse_version *, void *)’ {aka ‘int(int,  char **, const struct fuse_operations *, long unsigned int,  struct libfuse_version *, void *)’}
    885 | int fuse_main_real_versioned(int argc, char *argv[],
        |     ^~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

That is, a fuse header triggers a warning within itself. Since QEMU adds the
fuse3 include path via `-I`, the compiler thinks that the header is part of the
QEMU project, and thus raises a warning. The compiler can be told to ignore
warnings within 3rd party headers by adding these paths via `-isystem`. Fix the
above build failure by marking fuse as system dependency. While at it mark
every 3rd-party dependency as system dependency to prevent similar issues in the
future but skip glib since that results in glib include paths to be omitted from
bindgen in case of a Rust build.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 meson.build | 160 ++++++++++++++++++++++++++--------------------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/meson.build b/meson.build
index 34729c2a3d..694cf95f6f 100644
--- a/meson.build
+++ b/meson.build
@@ -826,7 +826,7 @@ endif
 #####################################
 
 libm = cc.find_library('m', required: false)
-threads = dependency('threads')
+threads = dependency('threads', include_type: 'system')
 util = cc.find_library('util', required: false)
 winmm = []
 socket = []
@@ -859,11 +859,11 @@ if host_os == 'windows'
                                       include_directories: include_directories('.'))
   host_dsosuf = '.dll'
 elif host_os == 'darwin'
-  coref = dependency('appleframeworks', modules: 'CoreFoundation')
-  iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
+  coref = dependency('appleframeworks', modules: 'CoreFoundation', include_type: 'system')
+  iokit = dependency('appleframeworks', modules: 'IOKit', required: false, include_type: 'system')
   host_dsosuf = '.dylib'
   pvg = dependency('appleframeworks', modules: ['ParavirtualizedGraphics', 'Metal'],
-                   required: get_option('pvg'))
+                   required: get_option('pvg'), include_type: 'system')
 elif host_os == 'sunos'
   socket = [cc.find_library('socket'),
             cc.find_library('nsl'),
@@ -899,7 +899,7 @@ endif
 hvf = not_found
 if get_option('hvf').allowed()
   hvf = dependency('appleframeworks', modules: 'Hypervisor',
-                   required: get_option('hvf'))
+                   required: get_option('hvf'), include_type: 'system')
   if hvf.found()
     accelerators += 'CONFIG_HVF'
   endif
@@ -960,30 +960,30 @@ endif
 xen = not_found
 if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
   xencontrol = dependency('xencontrol', required: false,
-                          method: 'pkg-config')
+                          method: 'pkg-config', include_type: 'system')
   if xencontrol.found()
     xen_pc = declare_dependency(version: xencontrol.version(),
       dependencies: [
         xencontrol,
         # disabler: true makes xen_pc.found() return false if any is not found
         dependency('xenstore', required: false,
-                   method: 'pkg-config',
+                   method: 'pkg-config', include_type: 'system',
                    disabler: true),
         dependency('xenforeignmemory', required: false,
-                   method: 'pkg-config',
+                   method: 'pkg-config', include_type: 'system',
                    disabler: true),
         dependency('xengnttab', required: false,
-                   method: 'pkg-config',
+                   method: 'pkg-config', include_type: 'system',
                    disabler: true),
         dependency('xenevtchn', required: false,
-                   method: 'pkg-config',
+                   method: 'pkg-config', include_type: 'system',
                    disabler: true),
         dependency('xendevicemodel', required: false,
-                   method: 'pkg-config',
+                   method: 'pkg-config', include_type: 'system',
                    disabler: true),
         # optional, no "disabler: true"
         dependency('xentoolcore', required: false,
-                   method: 'pkg-config')])
+                   method: 'pkg-config', include_type: 'system')])
     if xen_pc.found()
       xen = xen_pc
     endif
@@ -1050,10 +1050,10 @@ glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
 glib_cflags = []
 if enable_modules
   gmodule = dependency('gmodule-export-2.0', version: glib_req_ver, required: true,
-                       method: 'pkg-config')
+                       method: 'pkg-config', include_type: 'system')
 elif get_option('plugins')
   gmodule = dependency('gmodule-no-export-2.0', version: glib_req_ver, required: true,
-                       method: 'pkg-config')
+                       method: 'pkg-config', include_type: 'system')
 else
   gmodule = not_found
 endif
@@ -1109,7 +1109,7 @@ gdbus_codegen = not_found
 gdbus_codegen_error = '@0@ requires gdbus-codegen, please install libgio'
 if not get_option('gio').auto() or have_system
   gio = dependency('gio-2.0', required: get_option('gio'),
-                   method: 'pkg-config')
+                   method: 'pkg-config', include_type: 'system')
   if gio.found() and not cc.links('''
     #include <gio/gio.h>
     int main(void)
@@ -1126,7 +1126,7 @@ if not get_option('gio').auto() or have_system
     gdbus_codegen = find_program('gdbus-codegen',
                                  required: get_option('gio'))
     gio_unix = dependency('gio-unix-2.0', required: get_option('gio'),
-                          method: 'pkg-config')
+                          method: 'pkg-config', include_type: 'system')
     gio = declare_dependency(dependencies: [gio, gio_unix],
                              version: gio.version())
   endif
@@ -1141,15 +1141,15 @@ xml_pp = find_program('scripts/xml-preprocess.py')
 lttng = not_found
 if 'ust' in get_option('trace_backends')
   lttng = dependency('lttng-ust', required: true, version: '>= 2.1',
-                     method: 'pkg-config')
+                     method: 'pkg-config', include_type: 'system')
 endif
 pixman = not_found
 if not get_option('pixman').auto() or have_system or have_tools
   pixman = dependency('pixman-1', required: get_option('pixman'), version:'>=0.21.8',
-                      method: 'pkg-config')
+                      method: 'pkg-config', include_type: 'system')
 endif
 
-zlib = dependency('zlib', required: true)
+zlib = dependency('zlib', required: true, include_type: 'system')
 
 libaio = not_found
 if not get_option('linux_aio').auto() or have_block
@@ -1167,7 +1167,7 @@ linux_io_uring = not_found
 if not get_option('linux_io_uring').auto() or have_block
   linux_io_uring = dependency('liburing', version: '>=0.3',
                               required: get_option('linux_io_uring'),
-                              method: 'pkg-config')
+                              method: 'pkg-config', include_type: 'system')
   if not cc.links(linux_io_uring_test)
     linux_io_uring = not_found
   endif
@@ -1177,7 +1177,7 @@ libnfs = not_found
 if not get_option('libnfs').auto() or have_block
   libnfs = dependency('libnfs', version: ['>=1.9.3', '<6.0.0'],
                       required: get_option('libnfs'),
-                      method: 'pkg-config')
+                      method: 'pkg-config', include_type: 'system')
 endif
 
 libattr_test = '''
@@ -1214,9 +1214,9 @@ endif
 
 cocoa = dependency('appleframeworks',
                    modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
-                   required: get_option('cocoa'))
+                   required: get_option('cocoa'), include_type: 'system')
 
-vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
+vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'), include_type: 'system')
 if vmnet.found() and not cc.has_header_symbol('vmnet/vmnet.h',
                                               'VMNET_BRIDGED_MODE',
                                               dependencies: vmnet)
@@ -1233,7 +1233,7 @@ seccomp_has_sysrawrc = false
 if not get_option('seccomp').auto() or have_system or have_tools
   seccomp = dependency('libseccomp', version: '>=2.3.0',
                        required: get_option('seccomp'),
-                       method: 'pkg-config')
+                       method: 'pkg-config', include_type: 'system')
   if seccomp.found()
     seccomp_has_sysrawrc = cc.has_header_symbol('seccomp.h',
                                                 'SCMP_FLTATR_API_SYSRAWRC',
@@ -1265,13 +1265,13 @@ if get_option('xkbcommon').auto() and not have_system and not have_tools
   xkbcommon = not_found
 else
   xkbcommon = dependency('xkbcommon', required: get_option('xkbcommon'),
-                         method: 'pkg-config')
+                         method: 'pkg-config', include_type: 'system')
 endif
 
 slirp = not_found
 if not get_option('slirp').auto() or have_system
   slirp = dependency('slirp', required: get_option('slirp'),
-                     method: 'pkg-config')
+                     method: 'pkg-config', include_type: 'system')
   # slirp < 4.7 is incompatible with CFI support in QEMU.  This is because
   # it passes function pointers within libslirp as callbacks for timers.
   # When using a system-wide shared libslirp, the type information for the
@@ -1313,35 +1313,35 @@ endif
 pulse = not_found
 if not get_option('pa').auto() or (host_os == 'linux' and have_system)
   pulse = dependency('libpulse', required: get_option('pa'),
-                     method: 'pkg-config')
+                     method: 'pkg-config', include_type: 'system')
 endif
 alsa = not_found
 if not get_option('alsa').auto() or (host_os == 'linux' and have_system)
   alsa = dependency('alsa', required: get_option('alsa'),
-                    method: 'pkg-config')
+                    method: 'pkg-config', include_type: 'system')
 endif
 jack = not_found
 if not get_option('jack').auto() or have_system
   jack = dependency('jack', required: get_option('jack'),
-                    method: 'pkg-config')
+                    method: 'pkg-config', include_type: 'system')
 endif
 pipewire = not_found
 if not get_option('pipewire').auto() or (host_os == 'linux' and have_system)
   pipewire = dependency('libpipewire-0.3', version: '>=0.3.60',
                     required: get_option('pipewire'),
-                    method: 'pkg-config')
+                    method: 'pkg-config', include_type: 'system')
 endif
 sndio = not_found
 if not get_option('sndio').auto() or have_system
   sndio = dependency('sndio', required: get_option('sndio'),
-                    method: 'pkg-config')
+                    method: 'pkg-config', include_type: 'system')
 endif
 
 spice_protocol = not_found
 if not get_option('spice_protocol').auto() or have_system
   spice_protocol = dependency('spice-protocol', version: '>=0.14.0',
                               required: get_option('spice_protocol'),
-                              method: 'pkg-config')
+                              method: 'pkg-config', include_type: 'system')
 endif
 spice = not_found
 if get_option('spice') \
@@ -1351,7 +1351,7 @@ if get_option('spice') \
              .allowed()
   spice = dependency('spice-server', version: '>=0.14.0',
                      required: get_option('spice'),
-                     method: 'pkg-config')
+                     method: 'pkg-config', include_type: 'system')
 endif
 spice_headers = spice.partial_dependency(compile_args: true, includes: true)
 
@@ -1361,28 +1361,28 @@ libiscsi = not_found
 if not get_option('libiscsi').auto() or have_block
   libiscsi = dependency('libiscsi', version: '>=1.9.0',
                          required: get_option('libiscsi'),
-                         method: 'pkg-config')
+                         method: 'pkg-config', include_type: 'system')
 endif
 zstd = not_found
 if not get_option('zstd').auto() or have_block
   zstd = dependency('libzstd', version: '>=1.4.0',
                     required: get_option('zstd'),
-                    method: 'pkg-config')
+                    method: 'pkg-config', include_type: 'system')
 endif
 qpl = not_found
 if not get_option('qpl').auto() or have_system
   qpl = dependency('qpl', version: '>=1.5.0',
                     required: get_option('qpl'),
-                    method: 'pkg-config')
+                    method: 'pkg-config', include_type: 'system')
 endif
 uadk = not_found
 if not get_option('uadk').auto() or have_system
   libwd = dependency('libwd', version: '>=2.6',
                       required: get_option('uadk'),
-                      method: 'pkg-config')
+                      method: 'pkg-config', include_type: 'system')
   libwd_comp = dependency('libwd_comp', version: '>=2.6',
                            required: get_option('uadk'),
-                           method: 'pkg-config')
+                           method: 'pkg-config', include_type: 'system')
   if libwd.found() and libwd_comp.found()
      uadk = declare_dependency(dependencies: [libwd, libwd_comp])
   endif
@@ -1392,7 +1392,7 @@ qatzip = not_found
 if not get_option('qatzip').auto() or have_system
   qatzip = dependency('qatzip', version: '>=1.1.2',
                       required: get_option('qatzip'),
-                      method: 'pkg-config')
+                      method: 'pkg-config', include_type: 'system')
 endif
 
 virgl = not_found
@@ -1400,31 +1400,31 @@ virgl = not_found
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
 if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
   virgl = dependency('virglrenderer',
-                     method: 'pkg-config',
+                     method: 'pkg-config', include_type: 'system',
                      required: get_option('virglrenderer'))
 endif
 rutabaga = not_found
 if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
   rutabaga = dependency('rutabaga_gfx_ffi',
-                         method: 'pkg-config',
+                         method: 'pkg-config', include_type: 'system',
                          required: get_option('rutabaga_gfx'))
 endif
 blkio = not_found
 if not get_option('blkio').auto() or have_block
   blkio = dependency('blkio',
-                     method: 'pkg-config',
+                     method: 'pkg-config', include_type: 'system',
                      required: get_option('blkio'))
 endif
 curl = not_found
 if not get_option('curl').auto() or have_block
   curl = dependency('libcurl', version: '>=7.29.0',
-                    method: 'pkg-config',
+                    method: 'pkg-config', include_type: 'system',
                     required: get_option('curl'))
 endif
 libudev = not_found
 if host_os == 'linux' and (have_system or have_tools)
   libudev = dependency('libudev',
-                       method: 'pkg-config',
+                       method: 'pkg-config', include_type: 'system',
                        required: get_option('libudev'))
 endif
 
@@ -1504,7 +1504,7 @@ if have_system and get_option('curses').allowed()
   curses_dep_list = host_os == 'windows' ? ['ncurses', 'ncursesw'] : ['ncursesw']
   curses = dependency(curses_dep_list,
                       required: false,
-                      method: 'pkg-config')
+                      method: 'pkg-config', include_type: 'system')
   msg = get_option('curses').enabled() ? 'curses library not found' : ''
   curses_compile_args = ['-DNCURSES_WIDECHAR=1']
   if curses.found()
@@ -1593,7 +1593,7 @@ endif
 
 sdl = not_found
 if not get_option('sdl').auto() or have_system
-  sdl = dependency('sdl2', required: get_option('sdl'))
+  sdl = dependency('sdl2', required: get_option('sdl'), include_type: 'system')
   sdl_image = not_found
 endif
 if sdl.found()
@@ -1608,7 +1608,7 @@ if sdl.found()
                              version: sdl.version())
   endif
   sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
-                         method: 'pkg-config')
+                         method: 'pkg-config', include_type: 'system')
 else
   if get_option('sdl_image').enabled()
     error('sdl-image required, but SDL was @0@'.format(
@@ -1649,7 +1649,7 @@ glusterfs_iocb_has_stat = false
 if not get_option('glusterfs').auto() or have_block
   glusterfs = dependency('glusterfs-api', version: '>=3',
                          required: get_option('glusterfs'),
-                         method: 'pkg-config')
+                         method: 'pkg-config', include_type: 'system')
   if glusterfs.found()
     glusterfs_ftruncate_has_stat = cc.links('''
       #include <glusterfs/api/glfs.h>
@@ -1707,7 +1707,7 @@ endif
 libssh = not_found
 if not get_option('libssh').auto() or have_block
   libssh = dependency('libssh', version: '>=0.8.7',
-                    method: 'pkg-config',
+                    method: 'pkg-config', include_type: 'system',
                     required: get_option('libssh'))
 endif
 
@@ -1775,12 +1775,12 @@ endif
 coreaudio = not_found
 if not get_option('coreaudio').auto() or (host_os == 'darwin' and have_system)
   coreaudio = dependency('appleframeworks', modules: 'CoreAudio',
-                         required: get_option('coreaudio'))
+                         required: get_option('coreaudio'), include_type: 'system')
 endif
 
 opengl = not_found
 if not get_option('opengl').auto() or have_system or have_vhost_user_gpu
-  epoxy = dependency('epoxy', method: 'pkg-config',
+  epoxy = dependency('epoxy', method: 'pkg-config', include_type: 'system',
                       required: get_option('opengl'))
   if cc.has_header('epoxy/egl.h', dependencies: epoxy)
     opengl = epoxy
@@ -1790,14 +1790,14 @@ if not get_option('opengl').auto() or have_system or have_vhost_user_gpu
 endif
 gbm = not_found
 if (have_system or have_tools) and (virgl.found() or opengl.found())
-  gbm = dependency('gbm', method: 'pkg-config', required: false)
+  gbm = dependency('gbm', method: 'pkg-config', include_type: 'system', required: false)
 endif
 have_vhost_user_gpu = have_vhost_user_gpu and virgl.found() and opengl.found() and gbm.found()
 
 libcbor = not_found
 if not get_option('libcbor').auto() or have_system
   libcbor = dependency('libcbor', version: '>=0.7.0',
-                       required: get_option('libcbor'))
+                       required: get_option('libcbor'), include_type: 'system')
 endif
 
 gnutls = not_found
@@ -1817,14 +1817,14 @@ if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_syste
   # still use a different crypto backend to satisfy
   # the platform support requirements
   gnutls_crypto = dependency('gnutls', version: '>=3.6.14',
-                             method: 'pkg-config',
+                             method: 'pkg-config', include_type: 'system',
                              required: false)
   if gnutls_crypto.found()
     gnutls = gnutls_crypto
   else
     # Our min version if all we need is TLS
     gnutls = dependency('gnutls', version: '>=3.5.18',
-                        method: 'pkg-config',
+                        method: 'pkg-config', include_type: 'system',
                         required: get_option('gnutls'))
   endif
 endif
@@ -1853,7 +1853,7 @@ endif
 if not gnutls_crypto.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
     gcrypt = dependency('libgcrypt', version: '>=1.8',
-                        required: get_option('gcrypt'))
+                        required: get_option('gcrypt'), include_type: 'system')
     # Debian has removed -lgpg-error from libgcrypt-config
     # as it "spreads unnecessary dependencies" which in
     # turn breaks static builds...
@@ -1888,7 +1888,7 @@ if not gnutls_crypto.found()
   endif
   if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
     nettle = dependency('nettle', version: '>=3.4',
-                        method: 'pkg-config',
+                        method: 'pkg-config', include_type: 'system',
                         required: get_option('nettle'))
     if nettle.found() and not cc.has_header('nettle/xts.h', dependencies: nettle)
       xts = 'private'
@@ -1936,7 +1936,7 @@ endif
 capstone = not_found
 if not get_option('capstone').auto() or have_system or have_user
   capstone = dependency('capstone', version: '>=3.0.5',
-                        method: 'pkg-config',
+                        method: 'pkg-config', include_type: 'system',
                         required: get_option('capstone'))
 
   # Some versions of capstone have broken pkg-config file
@@ -1952,10 +1952,10 @@ if not get_option('capstone').auto() or have_system or have_user
   endif
 endif
 
-gmp = dependency('gmp', required: false, method: 'pkg-config')
+gmp = dependency('gmp', required: false, method: 'pkg-config', include_type: 'system')
 if nettle.found() and gmp.found()
   hogweed = dependency('hogweed', version: '>=3.4',
-                       method: 'pkg-config',
+                       method: 'pkg-config', include_type: 'system',
                        required: get_option('nettle'))
 endif
 
@@ -1971,18 +1971,18 @@ if get_option('gtk') \
                       error_message: 'cannot enable GTK if pixman is not available') \
              .allowed()
   gtk = dependency('gtk+-3.0', version: '>=3.22.0',
-                   method: 'pkg-config',
+                   method: 'pkg-config', include_type: 'system',
                    required: get_option('gtk'))
   if gtk.found()
     gtkx11 = dependency('gtk+-x11-3.0', version: '>=3.22.0',
-                        method: 'pkg-config',
+                        method: 'pkg-config', include_type: 'system',
                         required: false)
     gtk = declare_dependency(dependencies: [gtk, gtkx11],
                              version: gtk.version())
 
     if not get_option('vte').auto() or have_system
       vte = dependency('vte-2.91',
-                       method: 'pkg-config',
+                       method: 'pkg-config', include_type: 'system',
                        required: get_option('vte'))
     endif
   elif have_gtk_clipboard
@@ -1992,12 +1992,12 @@ endif
 
 x11 = not_found
 if gtkx11.found()
-  x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
+  x11 = dependency('x11', method: 'pkg-config', include_type: 'system', required: gtkx11.found())
 endif
 png = not_found
 if get_option('png').allowed() and have_system
    png = dependency('libpng', version: '>=1.6.34', required: get_option('png'),
-                    method: 'pkg-config')
+                    method: 'pkg-config', include_type: 'system')
 endif
 vnc = not_found
 jpeg = not_found
@@ -2009,7 +2009,7 @@ if get_option('vnc') \
              .allowed()
   vnc = declare_dependency() # dummy dependency
   jpeg = dependency('libjpeg', required: get_option('vnc_jpeg'),
-                    method: 'pkg-config')
+                    method: 'pkg-config', include_type: 'system')
   sasl = cc.find_library('sasl2', has_headers: ['sasl/sasl.h'],
                          required: get_option('vnc_sasl'))
   if sasl.found()
@@ -2135,49 +2135,49 @@ endif
 cacard = not_found
 if not get_option('smartcard').auto() or have_system
   cacard = dependency('libcacard', required: get_option('smartcard'),
-                      version: '>=2.5.1', method: 'pkg-config')
+                      version: '>=2.5.1', method: 'pkg-config', include_type: 'system')
 endif
 u2f = not_found
 if not get_option('u2f').auto() or have_system
   u2f = dependency('u2f-emu', required: get_option('u2f'),
-                   method: 'pkg-config')
+                   method: 'pkg-config', include_type: 'system')
 endif
 canokey = not_found
 if not get_option('canokey').auto() or have_system
   canokey = dependency('canokey-qemu', required: get_option('canokey'),
-                   method: 'pkg-config')
+                   method: 'pkg-config', include_type: 'system')
 endif
 usbredir = not_found
 if not get_option('usb_redir').auto() or have_system
   usbredir = dependency('libusbredirparser-0.5', required: get_option('usb_redir'),
-                        version: '>=0.6', method: 'pkg-config')
+                        version: '>=0.6', method: 'pkg-config', include_type: 'system')
 endif
 libusb = not_found
 if not get_option('libusb').auto() or have_system
   libusb = dependency('libusb-1.0', required: get_option('libusb'),
-                      version: '>=1.0.13', method: 'pkg-config')
+                      version: '>=1.0.13', method: 'pkg-config', include_type: 'system')
 endif
 
 libpmem = not_found
 if not get_option('libpmem').auto() or have_system
   libpmem = dependency('libpmem', required: get_option('libpmem'),
-                       method: 'pkg-config')
+                       method: 'pkg-config', include_type: 'system')
 endif
 libdaxctl = not_found
 if not get_option('libdaxctl').auto() or have_system
   libdaxctl = dependency('libdaxctl', required: get_option('libdaxctl'),
-                         version: '>=57', method: 'pkg-config')
+                         version: '>=57', method: 'pkg-config', include_type: 'system')
 endif
 tasn1 = not_found
 if gnutls.found()
   tasn1 = dependency('libtasn1',
                      required: false,
-                     method: 'pkg-config')
+                     method: 'pkg-config', include_type: 'system')
 endif
 keyutils = not_found
 if not get_option('libkeyutils').auto() or have_block
   keyutils = dependency('libkeyutils', required: get_option('libkeyutils'),
-                        method: 'pkg-config')
+                        method: 'pkg-config', include_type: 'system')
 endif
 
 has_gettid = cc.has_function('gettid')
@@ -2185,7 +2185,7 @@ has_gettid = cc.has_function('gettid')
 # libselinux
 selinux = dependency('libselinux',
                      required: get_option('selinux'),
-                     method: 'pkg-config')
+                     method: 'pkg-config', include_type: 'system')
 
 # Malloc tests
 
@@ -2237,7 +2237,7 @@ if get_option('fuse').disabled() and get_option('fuse_lseek').enabled()
 endif
 
 fuse = dependency('fuse3', required: get_option('fuse'),
-                  version: '>=3.1', method: 'pkg-config')
+                  version: '>=3.1', method: 'pkg-config', include_type: 'system')
 
 fuse_lseek = not_found
 if get_option('fuse_lseek').allowed()
@@ -2275,7 +2275,7 @@ endif
 
 # libbpf
 bpf_version = '1.1.0'
-libbpf = dependency('libbpf', version: '>=' + bpf_version, required: get_option('bpf'), method: 'pkg-config')
+libbpf = dependency('libbpf', version: '>=' + bpf_version, required: get_option('bpf'), method: 'pkg-config', include_type: 'system')
 if libbpf.found() and not cc.links('''
    #include <bpf/libbpf.h>
    #include <linux/bpf.h>
@@ -2299,7 +2299,7 @@ libxdp = not_found
 if not get_option('af_xdp').auto() or have_system
     if libbpf.found()
         libxdp = dependency('libxdp', required: get_option('af_xdp'),
-                            version: '>=1.4.0', method: 'pkg-config')
+                            version: '>=1.4.0', method: 'pkg-config', include_type: 'system')
     else
         if get_option('af_xdp').enabled()
             error('libxdp requested, but libbpf is not available')
@@ -2312,7 +2312,7 @@ libdw = not_found
 if not get_option('libdw').auto() or \
         (not get_option('prefer_static') and (have_system or have_user))
     libdw = dependency('libdw',
-                       method: 'pkg-config',
+                       method: 'pkg-config', include_type: 'system',
                        required: get_option('libdw'))
 endif
 
-- 
2.50.0


