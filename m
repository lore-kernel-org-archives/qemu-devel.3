Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A32BC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgm-0008IP-Cl; Wed, 23 Sep 2026 16:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TgD-0008Br-4g
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:35:04 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TgA-00051p-Bv
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:59 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-8692a856865so648775b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195697; x=1790800497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z0hFSulIzG2frxbzSf/EGXrp3EDo/qS7TjkfOkfAqlY=;
 b=bO5+NjGoBqgEhlEqk+kdRg61c5Jmn5Fy6m1D42RyN6vG7AKwkfQ+zXXO6Loa9zPB+k
 K99B7JC74B5A6KlXCfO5N3crKHRBCUb50xKHiBBhKBLHPpIpp4Bx9/HfZSsZ1hBqoOPv
 DgK+lZvrXOwYjvZvObBjpViu8sEESi24803hUC9iWqZJV2kYW/3Ualj0qb4Ibm6qX6dg
 Xy1ht5anEm9/mjAww2ZvE+evfybK+mWbnLjQaMDSeJcZQa5WNVxzTDH6WJ6f3KBcol2l
 0CevYvWMobuZWg03AJ1wVqI/yc2eBNVDLQ+hKB7IJJBdKe5RYNx7LPmwGYPhYlmjoEhy
 LCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195697; x=1790800497;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z0hFSulIzG2frxbzSf/EGXrp3EDo/qS7TjkfOkfAqlY=;
 b=NkGCfl6YiniJtx27/S59kxx18OtImaELjIwcd7D5+Gj8xCwygy7I1rPXFkfkqX6RMl
 sst/8LVDKFM8to4JUOwt6YKgf3jr/GgGXPqyB6gpdzLIuMAde+zC6J7IKe+6Q52e4/YV
 fg86N4h88LzPthNIyvAlnCK+YN4l5qUdLJhEJvvqjnGk7O9Udu6DFYkrOXX/mmXISATk
 Z/gG0joFwXhIdcYbNovQhD5dwPmnoLPIWLCVmxeRFMEPahq0Y4iz4Oler96Gqj6/i+m/
 KbRZeGr3KJLQLJzSWcvGIt9u4b3Hpd8CCSU421sIUDAcfWDqlNzYo7NzrOUxdNm0vZVy
 ZhFQ==
X-Gm-Message-State: AFuF++kMJAdmTjwGcUlYp+QDx08uDPNHF0aWtjJ6G3kSLqFDqEeg8whO
 lI0LCWAQCncSVdinAEkJed+k4oW6mwJhfo64KCb1ERflNzAGNn8778lXHqIV+AWGEsd9y219gAN
 u6V7H
X-Gm-Gg: AYBFou0DObofWo9ob7EyGZqi4vtvGb38hmWU+TxrFveJwX3gra6Y7ZxazykCrDwtoB6
 T1Yk/cunlZM3jrdEKF1sGSMvbADovH8PT+70brHV81bET3RrCLDWfZotX8jUQV/WwHPyTtj4UUb
 0l1dJLk+hdeffADlQ3Ayf6AGnxEYs31AEFn9y5lAZgRPPdY5UhakjwP7wcZGIKlje+j70E7cYXc
 7MyBFPwA47Nb8uWQvFMW+tlu1t1AZU9C1SLD1YUDHuf/cxNwjwYI6f5fdVkQevUsugaC4B3ba9N
 ULhffme0usKNkP2phbaynApWqaJfYrzMLfh67ePUsfi/Dc3DjPnLZpYghJIhqZLlW99vmNwRt5m
 Wf6KkWJEi5TE7PHDPHtc36LnFSv/sO1+hor2KcRPdnQiZtMS9x5pxyLCA0VWjAD6GJ8rBXlWDz4
 omkyChsUyWotgF8fix61KP26BqclYeuo10OoYITM8hrBxxUyJMA13N88sCWP253iUDXkXxU6u3k
 AtqnJDvF7Ar/iThONeVacxZnmsuvA==
X-Received: by 2002:a05:6a00:a228:b0:87d:dc3c:1b5e with SMTP id
 d2e1a72fcca58-87e9956d39amr244060b3a.26.1790195696573; 
 Wed, 23 Sep 2026 13:34:56 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 15/16] accel: Change AccelOpsClass.update_guest_debug to void
Date: Wed, 23 Sep 2026 13:34:40 -0700
Message-ID: <20260923203441.31276-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The return value is never used, so drop it.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/accel-cpu-ops.h | 2 +-
 include/system/hvf_int.h      | 2 +-
 accel/hvf/hvf-accel-ops.c     | 3 +--
 accel/kvm/kvm-accel-ops.c     | 4 ++--
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index f0c7ee7542c..af71fd9ab34 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -85,7 +85,7 @@ struct AccelOpsClass {
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
-    int (*update_guest_debug)(CPUState *cpu);
+    void (*update_guest_debug)(CPUState *cpu);
     int (*insert_gdbstub_breakpoint)(CPUState *cpu, GdbBreakpointType type,
                                      vaddr addr, vaddr len);
     int (*remove_gdbstub_breakpoint)(CPUState *cpu, GdbBreakpointType type,
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index a01691ce172..1b419b5428a 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -105,7 +105,7 @@ void hvf_arch_remove_all_gdbstub_hw_breakpoints(void);
  * Update guest to enable or disable debugging. Per-arch specifics will be
  * handled by calling down to hvf_arch_update_guest_debug.
  */
-int hvf_update_guest_debug(CPUState *cpu);
+void hvf_update_guest_debug(CPUState *cpu);
 
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d2276d8513e..6491a109ba4 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -227,10 +227,9 @@ static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
     hvf_arch_update_guest_debug(cpu);
 }
 
-int hvf_update_guest_debug(CPUState *cpu)
+void hvf_update_guest_debug(CPUState *cpu)
 {
     run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
-    return 0;
 }
 
 static int hvf_insert_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index c8e7aa38709..47244d33f7d 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -86,9 +86,9 @@ static bool kvm_cpus_are_resettable(void)
 }
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
-static int kvm_update_guest_debug_ops(CPUState *cpu)
+static void kvm_update_guest_debug_ops(CPUState *cpu)
 {
-    return kvm_update_guest_debug(cpu, 0);
+    kvm_update_guest_debug(cpu, 0);
 }
 #endif
 
-- 
2.53.0


