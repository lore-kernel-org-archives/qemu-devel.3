Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E814FCCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 04:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6LSl-0007IY-SB; Wed, 08 Oct 2025 00:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6LSj-0007Hf-SF
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:07:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6LSi-0005sW-2y
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:07:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so2607605e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759896454; x=1760501254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ocgs0Ja+xiwuPd8e/woUF/Yw02CcYFns8xQ4ykIqIlg=;
 b=Q3BJ/C6XHDeFoqei5fyOpgbUq4aAeTQvG7vId0T5GPmgGErdgvOsMPa+fXM6a+rjtj
 8mNYuxdFvhpwfuk90dwpQvoSXwVidQLqXtz4MPhRbzz+7apo8//rpHy7ckdexn+oq1sU
 +VL8NGQC8gAZNJbngxqUzlLpCBkBn089rSdljduW1vyfaZhIsmLa2z0aNlbSORtFmIP/
 MwKJc2p5ynnGzkV144Lwg9CXOYPzhSN7GkRpk1d9mxcj5fyssKdi9BvPk/eQYfu6BHO0
 PgMmNwu05ROkffLBKzjIE4TBMxlzjLzd4TkYNx0PhLUi3+IOerxU5fUI7DgK066MBmJ1
 QYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759896454; x=1760501254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ocgs0Ja+xiwuPd8e/woUF/Yw02CcYFns8xQ4ykIqIlg=;
 b=wXwDX74ZuTm6KTH8jL0Xt6xYF0nSCkOJBBT5bp3pfZnbfF7p46a9it9hz7ViX3nSzy
 TMbAeOux0stzHfbpH+bqcp+vwhMC1RC25UMntTdAW74gBziSzwJAAc0oP8xjoizFgSjh
 aimn45JtxjRyW+QAbPZCZhOGBoBbQ97iYjTKAbch4lRHpXHqy4giIxKsM3bUw1pfnZzv
 K0EbeXmjWH7AugsXs05vq2fvtF76F0104pD36Mc+0hAsUDaLTNylFe4yYdgYGxmL1JYK
 O9APAYczFC5xI2kplKTDZacc8IebieEEbDIslhRc2lg44PWhWW8JHjvIWA96YsEdUeUu
 E3tg==
X-Gm-Message-State: AOJu0YzDInbZd8ZD+QJDu9oHz0ukI2bxd6SOiop1fWKatVRAdlt2XIlH
 H9dMR+wrM/SR2oPLZS67SlfRf4IO3AO6T7AXGF4D4WbTy4uDA/9Oc/t9xW1qoarvT/93CwDYMXU
 dkaGSQ22mKA==
X-Gm-Gg: ASbGncvz1iEm/hiYodOqJgO5fOexodPXxbEaR4J+9pwrYS+uXlFLrfodd68kqFy7+OW
 IH4xO+fnsZ7MYzAlgENYcgP13rLppEx3HVzY61E68xRzVjrwXPfZxjyFTQrTc2JYL8+aYfnOOc0
 QsU5KwO255G2VPK5Vbnz3LT9nKKlgFD81bO7NYnse/ECnlBmRAVpMJg52xY0FQtLf2yG53wWj50
 L9+g4RpAHVr0OthtubHjIe5ZriNcpDdSoAShUar1dgWdxd57pxVajVT1T76kzVCMJdm/jiMv6HM
 aufbibcucnL8m9Qz9kOf7zcsjbEhNEvWbJ7v12q07xR38FzBoUQYmhWcbhOeKmSHFm1mb2nyJci
 vlvUGHzqYR94UXQjTqO+J8L9q6JBWWFPe3iqjp/6pJzSGPsQOok/FsSgGifQQ0iSPwBUPDSSF5E
 8Bb2DP4rgEk5Yb4FJ9kh7A5cxk
X-Google-Smtp-Source: AGHT+IHZFS8T1I/ZV9bUVDRHuknpw5/lllydyyhBKp58Zgvdd1J6n7PoUdc39F+bAmKfqLUaH6pXJQ==
X-Received: by 2002:a05:600c:8a8:b0:46d:38c4:1ac9 with SMTP id
 5b1f17b1804b1-46fa2952c99mr23685225e9.2.1759896454357; 
 Tue, 07 Oct 2025 21:07:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4bdcsm28015265f8f.54.2025.10.07.21.07.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 21:07:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Song Gao <gaosong@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 3/3] accel/kvm: Factor kvm_cpu_synchronize_put() out
Date: Wed,  8 Oct 2025 06:07:14 +0200
Message-ID: <20251008040715.81513-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008040715.81513-1-philmd@linaro.org>
References: <20251008040715.81513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The same code is duplicated 3 times: factor a common method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


