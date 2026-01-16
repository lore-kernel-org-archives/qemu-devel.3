Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B5BD4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabM-0006AD-PA; Thu, 15 Jan 2026 22:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabL-0005zC-5g
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:19 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabJ-0005cF-Bg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:18 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81f416c0473so1415055b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534456; x=1769139256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAjiwiRuOWizs0EGl+79VhmlGSH6tR7oUS2c/1ByVNA=;
 b=gTUyhFyQ6gZwI5pmNfYtapXCYqFC3FtojShVyOhQ+SLn5seWuHKwPawQnamhN9/Vzu
 KDox3LOeasiA2mAUCfYIkEh2z4Vz8ltFr0KvAmDcAZrqfnn2hgihtxSgceyzfCuriy/q
 FAoeg2hNAV+BhQkRuIz+zVuwN8jSw2BbPUyn0TSxKmvyPpp7xtJpDbIWTL/PX2PTg7zh
 a0E/ky9q30+IVV9OQZk62YjWMGOZ6d0MtENFaSyeRErgtNkZ34GVa7O9Tr2epOjPy0Gr
 uMjMWyVi/lKTe9QyYjWi55B9FBU1mGAGG5Ce3oX3Hs+D9jU0+GYVvhQ22rl5pJ62HqVu
 cJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534456; x=1769139256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RAjiwiRuOWizs0EGl+79VhmlGSH6tR7oUS2c/1ByVNA=;
 b=E1hSbxYZ4OtrEZcouNu/eIYjy57WypAttE/uCuvJmyrfDpblZaWwhbUmm9miAXUo/N
 iQyqcOyddFd8ruOmpXJ1dUT7A3zpCqdqXdP0s3GC258RLsTdHgSEqxmw8FE+o1Iu5hhb
 bd3AFcAEtrEL+ChEYEo6p4rXVh4x78ybuOjUb6XTWb3WTF0HhdI0pzDFU48bUEB9Efib
 CMuWezGV9nKGcD1kJoxEYPUwSdytmFmFvRbGWmruVLFybG5FQUMQD1QwvXpZuMPYaxqz
 /yBW5gMrLM4/lFAfdFpm8lJ2N+/fyQrP3wZupvvy7VS5aPypKWfy9wqfeus7xnVfFWl4
 8wNA==
X-Gm-Message-State: AOJu0YyXK3ypUR3IwfSJq+NFJe1aeVAwpPA0O8NIPbRldXLgaV8RnIvm
 tTY2P6grm/9aPDZZeZp8evQuwddltG/c4i70H+QPCQ5w1Mb+eP7LVojrJoVkcYJ/9SmqCpWjt3d
 ZKSG9ARcw7w==
X-Gm-Gg: AY/fxX6iOIWkgMDGT7BUJa2j7hllGkf5hBntn1oUy0yGdoNuytzxftO9uIFIDUgk5b8
 ODVbC2tbXwRu1W3qqksM9xcBgh/qeKonXL96YaljNeqNI4dGh0UsIaibx8SDDSMUrHPLafruy/k
 21BS39eG5LSY4bOKEEGQBl8evDvfEuIeUNRfpl7HM4efoZ+Cx14npPOBcOLCtcOfGUvCPCrjF4y
 ex28mOLb9NWElSwcmbgGSF91N4qdXDTXSuk/PrvgIyyhTpWOaMnoYXMVMPiaqTIREICxgzVsv7W
 Bj22Srtb35CY3pl2lbP2BiC56X1H7QHcJOx1t+pf8fwk/DZ3lYi9b38exVzSCQ9n47wTl7nzNNg
 OnVtZ3Wez60oOELhv0IV61ZVHUQxZR26IvXrfC5N8izgClVD2x0CY60X1rBNj/RPv3YaK1HnmuF
 uXP7Fs7CgBQX4zf2Y4rw==
X-Received: by 2002:a05:6a00:3a25:b0:81f:43fe:988c with SMTP id
 d2e1a72fcca58-81f9f684e86mr1866693b3a.6.1768534455566; 
 Thu, 15 Jan 2026 19:34:15 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 15/58] meson: Remove cpu == x86 tests
Date: Fri, 16 Jan 2026 14:32:21 +1100
Message-ID: <20260116033305.51162-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The 32-bit x86 host is no longer supported.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure   | 16 +---------------
 meson.build | 49 ++++++++++---------------------------------------
 2 files changed, 11 insertions(+), 54 deletions(-)

diff --git a/configure b/configure
index de0f3a8ebe..e9d0b9e2c0 100755
--- a/configure
+++ b/configure
@@ -447,13 +447,6 @@ case "$cpu" in
     linux_arch=arm64
     ;;
 
-  i386|i486|i586|i686)
-    cpu="i386"
-    host_arch=i386
-    linux_arch=x86
-    CPU_CFLAGS="-m32"
-    ;;
-
   loongarch*)
     cpu=loongarch64
     host_arch=loongarch64
@@ -1944,14 +1937,7 @@ if test "$skip_meson" = no; then
   if test "$cross_compile" = "yes"; then
     echo "[host_machine]" >> $cross
     echo "system = '$host_os'" >> $cross
-    case "$cpu" in
-        i386)
-            echo "cpu_family = 'x86'" >> $cross
-            ;;
-        *)
-            echo "cpu_family = '$cpu'" >> $cross
-            ;;
-    esac
+    echo "cpu_family = '$cpu'" >> $cross
     echo "cpu = '$cpu'" >> $cross
     if test "$bigendian" = "yes" ; then
         echo "endian = 'big'" >> $cross
diff --git a/meson.build b/meson.build
index 137b2dcdc7..506904c7d7 100644
--- a/meson.build
+++ b/meson.build
@@ -50,7 +50,7 @@ qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
-supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
+supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86_64',
   'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm64']
 
 cpu = host_machine.cpu_family()
@@ -265,8 +265,6 @@ enable_modules = get_option('modules') \
 
 if cpu not in supported_cpus
   host_arch = 'unknown'
-elif cpu == 'x86'
-  host_arch = 'i386'
 elif cpu == 'mips64'
   host_arch = 'mips'
 elif cpu in ['riscv32', 'riscv64']
@@ -275,9 +273,7 @@ else
   host_arch = cpu
 endif
 
-if cpu == 'x86'
-  kvm_targets = ['i386-softmmu']
-elif cpu == 'x86_64'
+if cpu == 'x86_64'
   kvm_targets = ['i386-softmmu', 'x86_64-softmmu']
 elif cpu == 'aarch64'
   kvm_targets = ['aarch64-softmmu']
@@ -300,9 +296,7 @@ else
 endif
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
 
-if cpu == 'x86'
-  xen_targets = ['i386-softmmu']
-elif cpu == 'x86_64'
+if cpu == 'x86_64'
   xen_targets = ['i386-softmmu', 'x86_64-softmmu']
 elif cpu == 'aarch64'
   # i386 emulator provides xenpv machine type for multiple architectures
@@ -391,40 +385,17 @@ endif
 
 qemu_isa_flags = []
 
-# __sync_fetch_and_and requires at least -march=i486. Many toolchains
-# use i686 as default anyway, but for those that don't, an explicit
-# specification is necessary
-if host_arch == 'i386' and not cc.links('''
-  static int sfaa(int *ptr)
-  {
-    return __sync_fetch_and_and(ptr, 0);
-  }
-
-  int main(void)
-  {
-    int val = 42;
-    val = __sync_val_compare_and_swap(&val, 0, 1);
-    sfaa(&val);
-    return val;
-  }''')
-  qemu_isa_flags += ['-march=i486']
-endif
-
 # Pick x86-64 baseline version
-if host_arch in ['i386', 'x86_64']
-  if get_option('x86_version') == '0' and host_arch == 'x86_64'
+if host_arch == 'x86_64'
+  if get_option('x86_version') == '0'
     error('x86_64-v1 required for x86-64 hosts')
   endif
 
   # add flags for individual instruction set extensions
   if get_option('x86_version') >= '1'
-    if host_arch == 'i386'
-      qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
-    else
-      # present on basically all processors but technically not part of
-      # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
-      qemu_isa_flags += ['-mcx16']
-    endif
+    # present on basically all processors but technically not part of
+    # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
+    qemu_isa_flags += ['-mcx16']
   endif
   if get_option('x86_version') >= '2'
     qemu_isa_flags += ['-mpopcnt']
@@ -1040,7 +1011,7 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
            error_message: 'Xen PCI passthrough requested but Xen not enabled') \
   .require(host_os == 'linux',
            error_message: 'Xen PCI passthrough not available on this platform') \
-  .require(cpu == 'x86'  or cpu == 'x86_64',
+  .require(cpu == 'x86_64',
            error_message: 'Xen PCI passthrough not available on this platform') \
   .allowed()
 
@@ -4564,7 +4535,7 @@ if have_tools
                               libcap_ng, mpathpersist],
                install: true)
 
-    if cpu in ['x86', 'x86_64']
+    if cpu == 'x86_64'
       executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
                dependencies: [authz, crypto, io, qom, qemuutil,
                               libcap_ng, mpathpersist],
-- 
2.43.0


