Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB5CC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 19:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSL9X-0004pP-B0; Thu, 19 Jun 2025 15:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uSL9O-0004or-TY
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 15:42:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uSL9L-0006TP-SN
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 15:42:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so9047375e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1750362133; x=1750966933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=945NnTgSwXk8exH8xblnViWPVG/bcKkjjf88tkCIGhw=;
 b=uj/cXdQHeN3p6apYPqLR8FTYJb3lISgesI0h/1Cuv7Q5+qkW6wS9Qc/xdWWlUwlagE
 u8CfK3lO/4UwlOT/GsYbI1zl3aGn/nmyL0hezp3NZpYJjY8JALxsmXvhPTlvpXnwJf4U
 IbIjBwyfOq/FWVkNR1myQpFV5htoGDv635ju4h4+NpTKZlvVMZ29Ymcy66qlmIBpFbWt
 YkmtJjIfOoSc8f76X/roKTxuD07XqYWzxHECfH4rPlzKI1EpgAOazGi6wxXSy2jhGF7K
 IVF6LPA2w4aKxnZ7LCbD0ylgYYAC+8MrzUxHQSFk5KM5i/k/OemGdYm0CVKeKzW7gwKL
 bQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750362133; x=1750966933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=945NnTgSwXk8exH8xblnViWPVG/bcKkjjf88tkCIGhw=;
 b=JiA4RL8ovmnatxPD3i2NVaNa6z7JB0PllBXJb347kfx0NoFXZ9cNBZPDd+dqpMNP1Z
 zatMpya9Y/QyZaJhZ2qTm3fBif31OfUoDnAIOJj0lFwDF5DVZD9sM7fUv0SvzS3MdWvR
 TSYPiCdpC8jPaQdp8RuOkRGsJTzyEYsyXTry2u/sZLeCXIX9urBsjzrALYD2my7eivWp
 Cwx9TU80ULTQBsfKHvlUsfIsFVNW+etKXRpOMEfrxe/Msbe0RjHW8EgNN7LGhmXHrHDY
 OUxCUta6/BSVb9byMUyiaxAWcWsjKDuQdrtBvJUHQMbwd5J/s3hiDTvLeD2XbcZNgdxy
 g2pQ==
X-Gm-Message-State: AOJu0YwWYjHvAfoMNyhr/92tqV08SJJasa9qYyC983+kTMfZQQcjd09t
 27/TDvfVM9gWlV4GVTOtSDAyCRCazpHKOQ3nq/DtbJg9XVlrXx76DSmQHGJNltJ+l28cWjFNGLk
 xS162
X-Gm-Gg: ASbGncs8QtdD0L73sJvPTvoy4URKxXSAi5lWCdqXxLnz/ECQMObe4Jsxgq6gWtIP7Bp
 9BKwyJE2utNZGgbc3vJxOVRtdaEksAUjBR+74KRUEaQfL2Mn7afC3NRnH5N4atzxZ7YquOp6HFh
 xX8CMzrWLPCxQJsrCWLP0PQADuygvFv0HXZ9xWVRnt1CmMMpzT6EOuUMlAnV7wItM0ORI8O3Gmt
 NTxElWuSsGJOrC9mVCIAip6FtwAQRChK6lg+3Go6Pzry32BbVMWHwc0KL/qT7A1NNS1beeaSoht
 66wFtpud3wIFwYyVOXn1Rx0KercjGSrAUVfsa6c+VmUmMQDfa/mhtj9we09rpSC4VLlbHUybRSy
 7nfsai+rmwckWXZq1PFc5VrAJ
X-Google-Smtp-Source: AGHT+IHTAR6ym8+0N/znfKC/8eb8jAIn387bUFaki0aVeXz/KhH5M+vSXjXJITq5Zjx874uSSn9Wag==
X-Received: by 2002:a05:600c:138e:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-453653b02c3mr835865e9.10.1750362132733; 
 Thu, 19 Jun 2025 12:42:12 -0700 (PDT)
Received: from bell.fritz.box (pd9ed7163.dip0.t-ipconnect.de. [217.237.113.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364708297sm3336525e9.35.2025.06.19.12.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 12:42:12 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Mathias Krause <minipli@grsecurity.net>,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH] i386/kvm: Disable hypercall patching quirk by default
Date: Thu, 19 Jun 2025 21:42:04 +0200
Message-Id: <20250619194204.1089048-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.069,
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
 include/system/kvm_int.h |  1 +
 qemu-options.hx          | 10 ++++++++++
 target/i386/kvm/kvm.c    | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 756a3c0a250e..fd7129824429 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -159,6 +159,7 @@ struct KVMState
     uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
     struct KVMDirtyRingReaper reaper;
     struct KVMMsrEnergy msr_energy;
+    bool hypercall_patching_enabled;
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
index 56a6b9b6381a..6f5f3b95e553 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3224,6 +3224,19 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+static int kvm_vm_disable_hypercall_patching(KVMState *s)
+{
+    int valid_quirks = kvm_vm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
+
+    if (valid_quirks & KVM_X86_QUIRK_FIX_HYPERCALL_INSN) {
+        return kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0,
+                                 KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
+    }
+
+    warn_report("kvm: disabling hypercall patching not supported");
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3363,6 +3376,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    if (s->hypercall_patching_enabled == false) {
+        if (kvm_vm_disable_hypercall_patching(s)) {
+            warn_report("kvm: failed to disable hypercall patching quirk");
+        }
+    }
+
     return 0;
 }
 
@@ -6456,6 +6475,19 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask)
     }
 }
 
+static bool kvm_arch_get_hypercall_patching(Object *obj, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    return s->hypercall_patching_enabled;
+}
+
+static void kvm_arch_set_hypercall_patching(Object *obj, bool value,
+                                            Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    s->hypercall_patching_enabled = value;
+}
+
 static int kvm_arch_get_notify_vmexit(Object *obj, Error **errp)
 {
     KVMState *s = KVM_STATE(obj);
@@ -6589,6 +6621,12 @@ static void kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
 
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


