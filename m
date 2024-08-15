Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D74C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seZa9-00019n-KH; Thu, 15 Aug 2024 08:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seZa6-00018t-Pv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 08:27:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seZa4-0002Iv-HH
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 08:27:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso5646945e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723724869; x=1724329669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=52Rx9K6nDE2L3UFTeCChG8IH/b2KMnJJw+OauduG444=;
 b=r5g2HdXvKGUB5PYoJVBRq/YEpisDxrXNKVOUSzaxVj9jqYRXiN5aXd2cvgXnZrahpX
 x8MrSpFnWMbeZNmsf5JAhtAMSmVa9dEiI+OGnJLTayZLL0jWoygq/VpYsk/bF0R9VT1Q
 scpxsv3+pb0Ykz/Yga7LD/GXxQjdi8vJLRzE0uFkFn+Beb1GiY7y9pkOOmn5VeU3x+LC
 dT+TDZ19J0uXInoqoorGPncV2i0Uwvc0ABaZfkyO7EZoRW1AXL7/6iFAXxF5K4ri8n+h
 Mat9gJkAUavbXMYN6cfh3r3haRI5V3bomV+iTyvTSWemVThdjVqn2ruV/QwVfFtCPWoy
 TJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723724869; x=1724329669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=52Rx9K6nDE2L3UFTeCChG8IH/b2KMnJJw+OauduG444=;
 b=vnRFBKcTTVb+qbU9MLq8EqyTzAojiZ6fLdq2K5kNICznyofeKeCETds2cXXaU3/bfl
 1dF3yoCqg5grjTmJKmL7s43QfpdjzrWZMAq18GV05zg9IjF3BxY9Vu7v+54xkF0no3/5
 mX5Sl5edrKo8XuzySzLFaQt302dET3JnkdCQ6x1L8UXTbX7Wus7zCVLFqpJYmOUOhPgM
 oEFu9TINvQq3FHxKg6myMMb6mB4TuPc0kBCtAjuCWGkqsa365N4lTiordPrImu697lIt
 qytt37nroV8r453cdJoFPS+eKXb5IZV7mRjw2xJbiWQmizz4/zMbjdJRZ3GqMAED55XL
 Gs5w==
X-Gm-Message-State: AOJu0Yw9RylRdAM/WoggITEXYHyINrcSLe8vbCP2KreNo7iGJIJTMM+2
 Zdon41c6zl8+K6QnrbeQKD97Bjd6+mS2DF3ulXjZwy5rQehg6n7g0HJDS/HoaDG7xG8IRKWibdu
 Z
X-Google-Smtp-Source: AGHT+IGRyQHAZ/XGfp9bRPn3H4nrtI0vq/22PXiTPszK7ShJo9M9irMOYKc48e1EU2b0AF2TFajcrA==
X-Received: by 2002:a05:600c:4707:b0:426:5fbe:bf75 with SMTP id
 5b1f17b1804b1-429dd2603a2mr44106405e9.23.1723724869429; 
 Thu, 15 Aug 2024 05:27:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded18630sm47345245e9.1.2024.08.15.05.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 05:27:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Johannes Stoelp <johannes.stoelp@googlemail.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH for-9.2] kvm: Use 'unsigned long' for request argument in
 functions wrapping ioctl()
Date: Thu, 15 Aug 2024 13:27:47 +0100
Message-Id: <20240815122747.3053871-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Johannes Stoelp <johannes.stoelp@googlemail.com>

Change the data type of the ioctl _request_ argument from 'int' to
'unsigned long' for the various accel/kvm functions which are
essentially wrappers around the ioctl() syscall.

The correct type for ioctl()'s 'request' argument is confused:
 * POSIX defines the request argument as 'int'
 * glibc uses 'unsigned long' in the prototype in sys/ioctl.h
 * the glibc info documentation uses 'int'
 * the Linux manpage uses 'unsigned long'
 * the Linux implementation of the syscall uses 'unsigned int'

If we wrap ioctl() with another function which uses 'int' as the
type for the request argument, then requests with the 0x8000_0000
bit set will be sign-extended when the 'int' is cast to
'unsigned long' for the call to ioctl().

On x86_64 one such example is the KVM_IRQ_LINE_STATUS request.
Bit requests with the _IOC_READ direction bit set, will have the high
bit set.

Fortunately the Linux Kernel truncates the upper 32bit of the request
on 64bit machines (because it uses 'unsigned int', and see also Linus
Torvalds' comments in
  https://sourceware.org/bugzilla/show_bug.cgi?id=14362 )
so this doesn't cause active problems for us.  However it is more
consistent to follow the glibc ioctl() prototype when we define
functions that are essentially wrappers around ioctl().

This resolves a Coverity issue where it points out that in
kvm_get_xsave() we assign a value (KVM_GET_XSAVE or KVM_GET_XSAVE2)
to an 'int' variable which can't hold it without overflow.

Resolves: Coverity CID 1547759
Signed-off-by: Johannes Stoelp <johannes.stoelp@gmail.com>
[PMM: Rebased patch, adjusted commit message, included note about
 Coverity fix, updated the type of the local var in kvm_get_xsave,
 updated the comment in the KVMState struct definition]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is a patch that was posted back in 2021, and I reviewed it
at the time
https://lore.kernel.org/qemu-devel/20210901213426.360748-1-johannes.stoelp@gmail.com/
but we never actually took it into the tree. I was reminded of it
by the Coverity issue, where a change to Coverity means it now
complains about the potential integer overflow when we put one
of these high-bit-set ioctls into an "int". So I thought it would
be worth dusting this off and getting it upstream.

For more discussion of the ioctl request datatype see also the
review thread on the previous version of the patch:
https://lore.kernel.org/qemu-devel/CAFEAcA8TRQdj33Ycm=XzmuUUNApaXVgeDexfS+3Ycg6kLnpmyg@mail.gmail.com/

Since this doesn't actually cause any incorrect behaviour this
is obviously for-9.2 material.
---
 include/sysemu/kvm.h     |  8 ++++----
 include/sysemu/kvm_int.h | 16 ++++++++++++----
 accel/kvm/kvm-all.c      |  8 ++++----
 target/i386/kvm/kvm.c    |  3 ++-
 accel/kvm/trace-events   |  8 ++++----
 5 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9cf14ca3d5b..613d3f7581f 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -235,11 +235,11 @@ static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_t
 
 /* internal API */
 
-int kvm_ioctl(KVMState *s, int type, ...);
+int kvm_ioctl(KVMState *s, unsigned long type, ...);
 
-int kvm_vm_ioctl(KVMState *s, int type, ...);
+int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
 
-int kvm_vcpu_ioctl(CPUState *cpu, int type, ...);
+int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...);
 
 /**
  * kvm_device_ioctl - call an ioctl on a kvm device
@@ -248,7 +248,7 @@ int kvm_vcpu_ioctl(CPUState *cpu, int type, ...);
  *
  * Returns: -errno on error, nonnegative on success
  */
-int kvm_device_ioctl(int fd, int type, ...);
+int kvm_device_ioctl(int fd, unsigned long type, ...);
 
 /**
  * kvm_vm_check_attr - check for existence of a specific vm attribute
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 1d8fb1473bd..b52e3483511 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -122,10 +122,18 @@ struct KVMState
     bool sync_mmu;
     bool guest_state_protected;
     uint64_t manual_dirty_log_protect;
-    /* The man page (and posix) say ioctl numbers are signed int, but
-     * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
-     * unsigned, and treating them as signed here can break things */
-    unsigned irq_set_ioctl;
+    /*
+     * POSIX says that ioctl numbers are signed int, but in practice
+     * they are not. Linux, glibc and *BSD all treat ioctl numbers as
+     * unsigned, and real-world ioctl values like KVM_GET_XSAVE have
+     * bit 31 set, which means that passing them via an 'int' will
+     * result in sign-extension when they get converted back to the
+     * 'unsigned long' which the ioctl() prototype uses. Luckily Linux
+     * always treats the argument as an unsigned 32-bit int, so any
+     * possible sign-extension is deliberately ignored, but for
+     * consistency we keep to the same type that glibc is using.
+     */
+    unsigned long irq_set_ioctl;
     unsigned int sigmask_len;
     GHashTable *gsimap;
 #ifdef KVM_CAP_IRQ_ROUTING
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2b..beb1988d12c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3170,7 +3170,7 @@ int kvm_cpu_exec(CPUState *cpu)
     return ret;
 }
 
-int kvm_ioctl(KVMState *s, int type, ...)
+int kvm_ioctl(KVMState *s, unsigned long type, ...)
 {
     int ret;
     void *arg;
@@ -3188,7 +3188,7 @@ int kvm_ioctl(KVMState *s, int type, ...)
     return ret;
 }
 
-int kvm_vm_ioctl(KVMState *s, int type, ...)
+int kvm_vm_ioctl(KVMState *s, unsigned long type, ...)
 {
     int ret;
     void *arg;
@@ -3208,7 +3208,7 @@ int kvm_vm_ioctl(KVMState *s, int type, ...)
     return ret;
 }
 
-int kvm_vcpu_ioctl(CPUState *cpu, int type, ...)
+int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...)
 {
     int ret;
     void *arg;
@@ -3228,7 +3228,7 @@ int kvm_vcpu_ioctl(CPUState *cpu, int type, ...)
     return ret;
 }
 
-int kvm_device_ioctl(int fd, int type, ...)
+int kvm_device_ioctl(int fd, unsigned long type, ...)
 {
     int ret;
     void *arg;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2fa88ef1e37..ada581c5d6e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4102,7 +4102,8 @@ static int kvm_get_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     void *xsave = env->xsave_buf;
-    int type, ret;
+    unsigned long type;
+    int ret;
 
     type = has_xsave2 ? KVM_GET_XSAVE2 : KVM_GET_XSAVE;
     ret = kvm_vcpu_ioctl(CPU(cpu), type, xsave);
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 37626c1ac5d..82c65fd2ab8 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -1,11 +1,11 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # kvm-all.c
-kvm_ioctl(int type, void *arg) "type 0x%x, arg %p"
-kvm_vm_ioctl(int type, void *arg) "type 0x%x, arg %p"
-kvm_vcpu_ioctl(int cpu_index, int type, void *arg) "cpu_index %d, type 0x%x, arg %p"
+kvm_ioctl(unsigned long type, void *arg) "type 0x%lx, arg %p"
+kvm_vm_ioctl(unsigned long type, void *arg) "type 0x%lx, arg %p"
+kvm_vcpu_ioctl(int cpu_index, unsigned long type, void *arg) "cpu_index %d, type 0x%lx, arg %p"
 kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
-kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
+kvm_device_ioctl(int fd, unsigned long type, void *arg) "dev fd %d, type 0x%lx, arg %p"
 kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
 kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
 kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
-- 
2.34.1


