Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA7AC9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatA-0001i8-85; Sun, 18 Jan 2026 17:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhat7-0001PQ-J6
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:49 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhat5-0000Vm-Qk
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:49 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a110548cdeso24515255ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773886; x=1769378686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAjiwiRuOWizs0EGl+79VhmlGSH6tR7oUS2c/1ByVNA=;
 b=d+8B6wk0fKB5AfoXB7xKQW05B5qN8lwZbMxRWDsHyP4Vbzu0KVgjcfS8ljIQbx+6Jy
 UclqxclpgWxMs/hz3VztzHdJ8NYQaPggZAyFoCqP2tcFuuJ8S7zx385sUgdRFIso7Vik
 Tu80Y49W1MVtJ3/1vK7FIPIE26thY2/RSAs4zSPR8oq9ljCoC1o3l05WF8N9OTtUHAMT
 V5bcMzIFvTyyX4tmjebC7EICo9hjKr5A2L+yuxVMK/sKNe9wQ58BggoHr4ejkT5nOK71
 RQLjjSIhCN/WJ9QPHAwe7UqmmD18kI2/56StD+Yc2Sm2hfY7rn0YrsCj9R2qWgs6TXoJ
 vfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773886; x=1769378686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RAjiwiRuOWizs0EGl+79VhmlGSH6tR7oUS2c/1ByVNA=;
 b=cJVZLphq0xd4CU2oAnamUc+E4Xn+eRpoASw2CSpxC2zc06MAr25qdoKFzfr17u3Kao
 SA37DvM3596tOBprIW64AkSvxzgnZy+tbaRUPuGM4h+PWQTqq4KxHDITuaosHodk1a0P
 QP/JqB6J/a1xQ0nJH/K5tdENrk+PI4l+txlJOUc4B4P3Q0EdwyHFAy5sWxfxlWZyTkCf
 2avbcJr0tOORP/l7BkMt7d3DSBPLgtB+wPHs+VXIAcRVRxg0vdRWzkYegKOpwTfDgntt
 EVeQwNaJZqnwf1tRPH7tipji81ttebAGg4edD3anR4hifYsbmF7DxrDiV4SGMQ5h8wfK
 vC4A==
X-Gm-Message-State: AOJu0YzB0mXgXer1JjWRqU5SyKPu4+yvPkCsOPCcQepPVtzVrtiB/76K
 ebpBuJuQ/yj6Yv/FM+Fsd6dbQ/HObgAWP5ohx/uXJyLDsdALlSZjSvakj6E/4ed+EcJrsPL3cBD
 Xu+Yxggat/g==
X-Gm-Gg: AY/fxX7COLnfJJeG7I1j3Ve/p6n0ab9sUT7dP25UulRwj8Q3kD9L+jqL5g/VJUwyR/v
 QargEcl/GlMYW/sW5ZrUe2huNf6OXdggHMNrsCO3wH4HTnSbr5G52qBvkZ6w7l8aDzOvBivUI1l
 psJE9F0N7XQHUZ7Qy7x03g/o9GTUn+90jQHuwNJkIjJYONMkYM3x9uLrrCks7m4ojIg4t+6glF5
 IYIExyPhNwJVUCuAvl4ZF1FSw5pTZuwjYtClAQPvptH/1LSWDSd24ccjcPhy+ZZG52nn9tcwXf4
 /UuglWypNMr3bU61R6lFOo2QW8Y+t3v/t0qyI24N5Ju5ZfsybtQr6r7ZzZZhsIyA6+1GqX+UZhP
 RsT3MwhHzS3ZJXkPWEP5Dl7rT2c3DaSJT8yKAggTLO3dCB+pQqyd9Qxr4IhUCcJuXgP5rojzaX7
 S+sm8O5zSki0VtjThYyg==
X-Received: by 2002:a17:902:da8d:b0:295:9b3a:16b7 with SMTP id
 d9443c01a7336-2a7175189aemr98621865ad.4.1768773886173; 
 Sun, 18 Jan 2026 14:04:46 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/54] meson: Remove cpu == x86 tests
Date: Mon, 19 Jan 2026 09:03:31 +1100
Message-ID: <20260118220414.8177-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


