Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055BBCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEM-0005ss-Aa; Tue, 14 Oct 2025 09:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEC-0005e4-Vs
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fE7-00015s-QK
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqD/1IAJB4FUzAxd+H8ERosOQw0rg1wSHVlzec/yl84=;
 b=f1vBUh6UH399utPxJHJF+tXLf4X4Hqo5V5krMrPAVoFwZ4WDq/F6z3CAWtojoSh2a0C+Rx
 qNKcSpeiM6RI+0klHbHkDGYpazxsLQM5mNMFsAoq57ln4LQlHJDRZZbbRPfggXn2XwNV12
 SUQIPoW/zbTpgx5O5aBkGdruoItJUHE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-JEAksl3HPeq7Z53Nlf5oxQ-1; Tue, 14 Oct 2025 09:38:03 -0400
X-MC-Unique: JEAksl3HPeq7Z53Nlf5oxQ-1
X-Mimecast-MFC-AGG-ID: JEAksl3HPeq7Z53Nlf5oxQ_1760449082
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e3d43bbc7so31581815e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449081; x=1761053881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqD/1IAJB4FUzAxd+H8ERosOQw0rg1wSHVlzec/yl84=;
 b=Pmw9j3916kaO1u63r1Gl1QbiQru1LCRNJ9KzH3+YVqBL+QjspJ1NUYdvrDuasrytj1
 WV7pS5c8n4vAeainK0Ao4oFeNeITwCD6GhiSft6IJCgAMfD11vrdZOqfc+lnMbX58hDw
 7blQ7ET9zXTX2fQeXB1kG/bsnmRD0zyNbJ9Zv+2yACaF2D6+bEoY8gsy3u2Sl2mOLdUZ
 GxcvmaG2RP4IfdiGc09X8ClxfAjyI0J7WZVKdNXjRlRkbDVUzID/ou8rh77ZxPB7ZkH+
 UtFuikO22f+WnvUQnmw7oXSmCsJrbYfhFgEpyKgEB0ITKDxNwLQ445fqQm6F3DkdxcXl
 VIGw==
X-Gm-Message-State: AOJu0YyOqh4RoRj97Yf6MzdgEEp498QDZSXMm8S7kjYbK2jEdT1kEjE1
 eENdHYfgKoxncmzDG5iKCZ98BqYeCOf73SypAoc2QtZtMRvPW0qoIJXxVcOVp6r99ntTeSNTGx+
 OK77yrS45rbnec54LmkJGfFLvNTT8muNyYDZxjJaTHdMlsAWLVsNaKYDMRxblRMVdwdoJXX9mhS
 ywKGD4gHGesqFHXUHTib/8Tv3AiiQ359pF9oNISxT8
X-Gm-Gg: ASbGncsrQV1KI4np1HBh4K+mmXfhAUsKtNLzuxp8cobCWmA/33226ax68WWF8NDZrYL
 XkzBLB2INj0y/Rpk2Q0FUGp7KgCPsnNAAdQWOROHGUBbiR0mIz9QeV+0Xz8NjDENdKo0R1MgmRB
 c6kvYQL3xid+nRm/EQ2f6nSWc6o1ZOHRSg7IemrXrphjQtsn+JIlmgZob0Liusz2o2UCh7tn1Gr
 NRgmZaVEOFcq+z34Z868DvDuOmbKkcfzdDTuUuKSpjbjJxAovpCBiJlcJffaotcwcqaFEGhLdDC
 kf06+undwPfgtRmqSkyu8cpwr3+w0jWyQyfwLHYjsXPCNvaSuuBE31ObufoauJio7qtXVHHOJSR
 FJOz/CMHgb4TrctRWezjGeji2At6qd8CtLQ03CKo8fU8=
X-Received: by 2002:a05:600c:19d2:b0:45d:84ca:8a7 with SMTP id
 5b1f17b1804b1-46fa9a96712mr158389015e9.14.1760449081054; 
 Tue, 14 Oct 2025 06:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUIyhryfSs+RE6qwpAkvKUb5CHomkwwPjEP8qM2wMByAzDu26dIUB1nqsXCUJArXjKWPa0PA==
X-Received: by 2002:a05:600c:19d2:b0:45d:84ca:8a7 with SMTP id
 5b1f17b1804b1-46fa9a96712mr158388765e9.14.1760449080632; 
 Tue, 14 Oct 2025 06:38:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49d03e2sm243126265e9.19.2025.10.14.06.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/28] accel/kvm: Factor kvm_cpu_synchronize_put() out
Date: Tue, 14 Oct 2025 15:37:03 +0200
Message-ID: <20251014133713.1103695-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The same code is duplicated 3 times: factor a common method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20251008040715.81513-4-philmd@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 47 ++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 58802f7c3cc..56031925c4e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2937,22 +2937,32 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
     }
 }
 
-static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+static bool kvm_cpu_synchronize_put(CPUState *cpu, KvmPutState state,
+                                    const char *desc)
 {
     Error *err = NULL;
-    int ret = kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE, &err);
+    int ret = kvm_arch_put_registers(cpu, state, &err);
     if (ret) {
         if (err) {
-            error_reportf_err(err, "Restoring resisters after reset: ");
+            error_reportf_err(err, "Restoring resisters %s: ", desc);
         } else {
-            error_report("Failed to put registers after reset: %s",
+            error_report("Failed to put registers %s: %s", desc,
                          strerror(-ret));
         }
-        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
-        vm_stop(RUN_STATE_INTERNAL_ERROR);
+        return false;
     }
 
     cpu->vcpu_dirty = false;
+
+    return true;
+}
+
+static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+{
+    if (!kvm_cpu_synchronize_put(cpu, KVM_PUT_RESET_STATE, "after reset")) {
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+        vm_stop(RUN_STATE_INTERNAL_ERROR);
+    }
 }
 
 void kvm_cpu_synchronize_post_reset(CPUState *cpu)
@@ -2966,19 +2976,9 @@ void kvm_cpu_synchronize_post_reset(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
-    Error *err = NULL;
-    int ret = kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE, &err);
-    if (ret) {
-        if (err) {
-            error_reportf_err(err, "Putting registers after init: ");
-        } else {
-            error_report("Failed to put registers after init: %s",
-                         strerror(-ret));
-        }
+    if (!kvm_cpu_synchronize_put(cpu, KVM_PUT_FULL_STATE, "after init")) {
         exit(1);
     }
-
-    cpu->vcpu_dirty = false;
 }
 
 void kvm_cpu_synchronize_post_init(CPUState *cpu)
@@ -3168,20 +3168,11 @@ int kvm_cpu_exec(CPUState *cpu)
         MemTxAttrs attrs;
 
         if (cpu->vcpu_dirty) {
-            Error *err = NULL;
-            ret = kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE, &err);
-            if (ret) {
-                if (err) {
-                    error_reportf_err(err, "Putting registers after init: ");
-                } else {
-                    error_report("Failed to put registers after init: %s",
-                                 strerror(-ret));
-                }
+            if (!kvm_cpu_synchronize_put(cpu, KVM_PUT_RUNTIME_STATE,
+                                         "at runtime")) {
                 ret = -1;
                 break;
             }
-
-            cpu->vcpu_dirty = false;
         }
 
         kvm_arch_pre_run(cpu, run);
-- 
2.51.0


