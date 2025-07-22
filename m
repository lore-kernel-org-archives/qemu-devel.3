Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58A6C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 20:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueJsi-0003Qj-3k; Tue, 22 Jul 2025 16:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1ueJpi-0008S5-1w
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:43:31 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1ueJpf-0001MN-7a
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:43:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-75ce780af03so2098439b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1753217004; x=1753821804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qadej4QY2us4blDeUWRkAww3V47laEeGj9PB4dLSeh0=;
 b=ik+0YfiV+q+mLNwalpJaxRjD7XOZrvjRuOCG5VGXGXciz9q6S1sdvm/FyrpfHr/Knr
 2Qm7LFnM0YxCRmELJf6a0yX435h25az7rvt5N+GT22GHPOxBMXG3S/Jk8hYwHR+YjVY5
 mW+sN8Xw2bVpd2d7qkPOJr766MxBREO/VDMI3qxTFeN7S371QZmpywb2/wZ8zsMRpDum
 iWjcX6Q5XQ44xWEHQJSOEtB/eIvQMDPu5Hq9idfR1JR2Fee18ig8D/2C+Q1qHa14Pcjm
 OS0HlIzKQJwUARJbtOmHDyG+XoxJA74DUpDR3PMt1rvgpTewUprCfkd2ohsBANdonVqa
 mj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753217004; x=1753821804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qadej4QY2us4blDeUWRkAww3V47laEeGj9PB4dLSeh0=;
 b=UACVkP/I5rDYCEZXUsHldDvVy0BvXM/TrQ0zuJrwsmutYaq4lgLhQyvIBe4Q0B9a7o
 dVkbAu1mnHxFd4yUX2updAhxP2myBWgrE4ug2O3kACIsuBNsKrGAQLBeIZ9YxlazE3zr
 nVFx7t00PfH7lYF/e0+i8NLEdeHNyCHQxROct2JnAp5tRsgw4n0fHtjiIaPqo3LGJ9yq
 r5zQpWJN2SLX36qCGW8mJz4MZxwdK1m8js4DN3PRdWyd/y6rRqgdxExj0CHOGv/wcvU5
 IDR2TZzF5dGclu7W8NONSPdJNwUG6nFuor9DTKpAgZPnUz6D4Z9gBVqaXcpgKZdKseXt
 m99w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsgdtyRNpI5s9O1/3jnN2/A7tOq9NeRE+XDulrNL2U4qaBM9Dh1cDz9iUgZBi6te2e2Nl/KgAZYKVA@nongnu.org
X-Gm-Message-State: AOJu0YyBK3oP6pA9ZdHpeOwxPJUsSELirKu63E+JMVZAUAxR1tbslYiz
 608Y+jF0YkGjpb5lMsGlYILoerUluGNOTYWV8B1lViFBp5adArHNS8g7CazPXHczh9s=
X-Gm-Gg: ASbGncsyfGrUB14146isXB77+GhqJFFnTuvkYTvePw8ptGFy8G92ugzwozU242QY3Kj
 YDgDxoMlERhf/ulNtDA0gxejPG3p6Jciyj9A8WUyLzkidT38Hhx5lYBYkiq65SRxbX14kPG+Hgz
 7rIItS56R3KBHmlFDV8vZMam0liH1GfBQf6PRdcUwKohFJymNsL5fDBtbrsD9aWQYvWc0N6amW7
 UPfXFM2s7EYSwe+K0tpUebLnhbnA4SKeVylGGEq194/4gD/sP9+qhIWyE9TJUyUQEt/BZtA8UMn
 K2OHFz4GSyrf9u/ftMcfRwt4k4Y3mC7s0QtBHnbGqBkYQ0ud6NKM3Y4TMhp8wusqwrIw8DunLeA
 d2WTqm5ojRnaRSgakO/aK9KcN4JTWQeS/4NtEshxP2XH2KV0NbqzjFHvs617UEmGpDy7TunO4Mm
 OiRzWP6TeZPI/F3UPu
X-Google-Smtp-Source: AGHT+IFkWBL534QSLuTIv4Nb9qWHjfDwAD6Y4PnF27h+JcuE493sdh+DTbAtxHhMxMbFXqdxcs0Nug==
X-Received: by 2002:a05:6a20:3d1d:b0:238:3f64:41a5 with SMTP id
 adf61e73a8af0-23d491f9161mr393893637.45.1753217003651; 
 Tue, 22 Jul 2025 13:43:23 -0700 (PDT)
Received: from bell.fritz.box
 (p200300faaf22cf002208a86d0dff5ae9.dip0.t-ipconnect.de.
 [2003:fa:af22:cf00:2208:a86d:dff:5ae9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbc680absm8313006b3a.144.2025.07.22.13.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 13:43:23 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 kvm@vger.kernel.org, Mathias Krause <minipli@grsecurity.net>,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2] i386/kvm: Disable hypercall patching quirk by default
Date: Tue, 22 Jul 2025 22:43:16 +0200
Message-Id: <20250722204316.1186096-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.158,
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

KVM has a weird behaviour when a guest executes VMCALL on an AMD system
or VMMCALL on an Intel CPU. Both naturally generate an invalid opcode
exception (#UD) as they are just the wrong instruction for the CPU
given. But instead of forwarding the exception to the guest, KVM tries
to patch the guest instruction to match the host's actual hypercall
instruction. That is doomed to fail as read-only code is rather the
standard these days. But, instead of letting go the patching attempt and
falling back to #UD injection, KVM injects the page fault instead.

That's wrong on multiple levels. Not only isn't that a valid exception
to be generated by these instructions, confusing attempts to handle
them. It also destroys guest state by doing so, namely the value of CR2.

Sean attempted to fix that in KVM[1] but the patch was never applied.

Later, Oliver added a quirk bit in [2] so the behaviour can, at least,
conceptually be disabled. Paolo even called out to add this very
functionality to disable the quirk in QEMU[3]. So lets just do it.

A new property 'hypercall-patching=on|off' is added, for the very
unlikely case that there are setups that really need the patching.
However, these would be vulnerable to memory corruption attacks freely
overwriting code as they please. So, my guess is, there are exactly 0
systems out there requiring this quirk.

[1] https://lore.kernel.org/kvm/20211210222903.3417968-1-seanjc@google.com/
[2] https://lore.kernel.org/kvm/20220316005538.2282772-2-oupton@google.com/
[3] https://lore.kernel.org/kvm/80e1f1d2-2d79-22b7-6665-c00e4fe9cb9c@redhat.com/

Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
v2:
- rename hypercall_patching_enabled to hypercall_patching (Xiaoyao Li)
- make use of error_setg*() (Xiaoyao Li)

 include/system/kvm_int.h |  1 +
 qemu-options.hx          | 10 +++++++++
 target/i386/kvm/kvm.c    | 45 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 756a3c0a250e..c909464c74a2 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -159,6 +159,7 @@ struct KVMState
     uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
     struct KVMDirtyRingReaper reaper;
     struct KVMMsrEnergy msr_energy;
+    bool hypercall_patching;
     NotifyVmexitOption notify_vmexit;
     uint32_t notify_window;
     uint32_t xen_version;
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a676..c2e232649c19 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -231,6 +231,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
     "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
     "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
+    "                hypercall-patching=on|off (enable KVM's VMCALL/VMMCALL hypercall patching quirk, x86 only)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n"
     "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
 SRST
@@ -313,6 +314,15 @@ SRST
         open up for a specified of time (i.e. notify-window).
         Default: notify-vmexit=run,notify-window=0.
 
+    ``hypercall-patching=on|off``
+        KVM tries to recover from the wrong hypercall instruction being used by
+        a guest by attempting to rewrite it to the one supported natively by
+        the host CPU (VMCALL on Intel, VMMCALL for AMD systems). However, this
+        patching may fail if the guest memory is write protected, leading to a
+        page fault getting propagated to the guest instead of an illegal
+        instruction exception. As this may confuse guests, it gets disabled by
+        default (x86 only).
+
     ``device=path``
         Sets the path to the KVM device node. Defaults to ``/dev/kvm``. This
         option can be used to pass the KVM device to use via a file descriptor
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 56a6b9b6381a..55f744956970 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3224,6 +3224,26 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+static int kvm_vm_disable_hypercall_patching(KVMState *s, Error **errp)
+{
+    int valid_quirks = kvm_vm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
+    int ret = -1;
+
+    if (valid_quirks & KVM_X86_QUIRK_FIX_HYPERCALL_INSN) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0,
+                                KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
+        if (ret) {
+            error_setg_errno(errp, -ret, "kvm: failed to disable "
+                             "hypercall patching quirk: %s",
+                             strerror(-ret));
+        }
+    } else {
+        error_setg(errp, "kvm: disabling hypercall patching not supported");
+    }
+
+    return ret;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3363,6 +3383,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    if (s->hypercall_patching == false) {
+        if (kvm_vm_disable_hypercall_patching(s, &local_err)) {
+            error_report_err(local_err);
+        }
+    }
+
     return 0;
 }
 
@@ -6456,6 +6482,19 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask)
     }
 }
 
+static bool kvm_arch_get_hypercall_patching(Object *obj, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    return s->hypercall_patching;
+}
+
+static void kvm_arch_set_hypercall_patching(Object *obj, bool value,
+                                            Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    s->hypercall_patching = value;
+}
+
 static int kvm_arch_get_notify_vmexit(Object *obj, Error **errp)
 {
     KVMState *s = KVM_STATE(obj);
@@ -6589,6 +6628,12 @@ static void kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
+    object_class_property_add_bool(oc, "hypercall-patching",
+                                   kvm_arch_get_hypercall_patching,
+                                   kvm_arch_set_hypercall_patching);
+    object_class_property_set_description(oc, "hypercall-patching",
+                                          "Enable hypercall patching quirk");
+
     object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
                                    &NotifyVmexitOption_lookup,
                                    kvm_arch_get_notify_vmexit,
-- 
2.30.2


