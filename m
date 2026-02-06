Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDD1EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTfJ-0006k7-I6; Fri, 06 Feb 2026 16:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdw-0005LR-Dk
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTds-0002bV-Cd
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso10389965e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414330; x=1771019130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2Cp+AFMEp/RWbnW3j9J4FV+90HWwKokWED94qwrJn4=;
 b=Mt+f6H+P7kq8FMxMx0xxq7+jzYatjGtAYPbTUBftqE/8bwwCi1QQoJHhFYf7M/X8MN
 TYB+unqpJroKJSMBrcWtOpgEUIxLsZiiow36PshJP5mba7a/FpBFtnt2BWwruiP0KTPd
 tJJPp+7TaVTfPLT43WwxMumTfUcZDpPYxjlTy1UN6TkB3Mf+nIT/eqOh8Ccxs9m8ttKd
 l5tQkZ6bTTPc5rGvJALKBMUQBnLrBqUd1eb63P/F8W9G8AdxGzEGtky9BSDs1E31SIRB
 RFTtXL0GL5AS3NUHrgDnQkCsaRapOPMAsRilmnUAKE0PWawfmzdw0hAJfrvvBknN/QhZ
 XqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414330; x=1771019130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2Cp+AFMEp/RWbnW3j9J4FV+90HWwKokWED94qwrJn4=;
 b=ePGEUP7vLExRfkZjbSSS6xftG0uf3kt5eV5tc+qjiUwGwDQ9YFBw2RwrbKhnvLLrih
 oYVlrICP6Q2JYNv04mEoy6gm8MyGTAVDubNqs0XVRW/ej7EFOcA7EuLLNhau+GyZhm0B
 vFM7pzgc59pdbCyDd4gWVNJn3YOip44fISZnzlnU+lmWW0+G8viZeTfn+X9Rv2Cx/bni
 Ul5xXL4TfIehJRIvdSNV2GlYAwWMm99D9mp466Ql15570yPsaAiSfr460OJwLdtyHgEx
 E+VlbUHAT1xFqVrMQarwijCoiQqxGLzYajswHFElrMaA+xoc+cBDAWVKIEbuyD4+WjPv
 K+qQ==
X-Gm-Message-State: AOJu0Yyu5Z2nfu9NaAxo492kWFSgxqOa+JnpYt9T9mTVCdc+ME8cI4YA
 h3mpz+HwJQYjsryE4Wjl/2wWRSDK/ob6Bw1zEcNmBT4UDJNFlvK2gRHgnFIOwTJJfDyDdDmUZWR
 3kfRNzDk=
X-Gm-Gg: AZuq6aLoJa+vNJJxYyc7FguLTLdXzGE4b6qO2yi7F8kjRjfEUDcHlaXB465MMVkFABD
 dR/V5MkBIbTsHhWkJ3a5JNKMdizqQdGMrSw4AvQB+WBnSW4ghBfTKytmmjs3E2geQ3j+fwOv409
 eTSrMwYfqGVAtc3OO4dsdrFjAFqYHe0ZcNM03MxLLZB57XFRyKhvN3l6ASjKHknzRJ6h7hChZeS
 RlhNjS+nKD0FFkiLfxHh/+dMaVeBxMv95d2O4MxPdcq1X62hW50P6PQiSTt6R6oF6BhdoyxjbgK
 HDcrpP/lmmyta9cfekM9Fd8Xq2uIOMIzXTeyHXhFxCMCmALoLu+iuzfg5nhOAAnHbUw1RKJLdRQ
 /uev7ZFiEEXSu1z2aw6JdDkKciQevwdE87zPQRk5YIex+tKVZsVfoI/74bfGqoY4CwcmElwlqxN
 z0GDOUzxEh5aF83+K74xp7VTXmjKyeg2YcBKaKSLtjcp0trWlbVSF3AZKhgzWU
X-Received: by 2002:a05:600d:640f:20b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-4832021cb9amr43567045e9.29.1770414329924; 
 Fri, 06 Feb 2026 13:45:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320719b8fsm81786805e9.9.2026.02.06.13.45.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 06/30] target/s390x: Un-inline KVM Protected Virtualization
 stubs
Date: Fri,  6 Feb 2026 22:44:24 +0100
Message-ID: <20260206214448.22008-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

By removing the target-specific 'CONFIG_KVM' definition this
header can be used by files in meson common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260206181953.18683-6-philmd@linaro.org>
---
 target/s390x/kvm/pv.h    | 27 ------------
 target/s390x/kvm/stubs.c | 94 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 27 deletions(-)

diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index e266fc3d545..ea4b4ec3403 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -20,7 +20,6 @@ struct S390PVResponse {
     uint16_t rc;
 };
 
-#ifdef CONFIG_KVM
 bool s390_is_pv(void);
 int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
@@ -43,31 +42,5 @@ int kvm_s390_dump_init(void);
 int kvm_s390_dump_cpu(S390CPU *cpu, void *buff);
 int kvm_s390_dump_mem_state(uint64_t addr, size_t len, void *dest);
 int kvm_s390_dump_completion_data(void *buff);
-#else /* CONFIG_KVM */
-static inline bool s390_is_pv(void) { return false; }
-static inline int s390_pv_query_info(void) { return 0; }
-static inline int s390_pv_vm_enable(void) { return 0; }
-static inline void s390_pv_vm_disable(void) {}
-static inline bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms) { return false; }
-static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
-                                        struct S390PVResponse *pv_resp,
-                                        Error **errp) { return 0; }
-static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak,
-                                 struct S390PVResponse *pv_resp) { return 0; }
-static inline void s390_pv_prep_reset(void) {}
-static inline int s390_pv_verify(struct S390PVResponse *pv_resp) { return 0; }
-static inline void s390_pv_unshare(void) {}
-static inline void s390_pv_inject_reset_error(CPUState *cs,
-                                              struct S390PVResponse pv_resp) {};
-static inline uint64_t kvm_s390_pv_dmp_get_size_cpu(void) { return 0; }
-static inline uint64_t kvm_s390_pv_dmp_get_size_mem_state(void) { return 0; }
-static inline uint64_t kvm_s390_pv_dmp_get_size_completion_data(void) { return 0; }
-static inline bool kvm_s390_pv_info_basic_valid(void) { return false; }
-static inline int kvm_s390_dump_init(void) { return 0; }
-static inline int kvm_s390_dump_cpu(S390CPU *cpu, void *buff) { return 0; }
-static inline int kvm_s390_dump_mem_state(uint64_t addr, size_t len,
-                                          void *dest) { return 0; }
-static inline int kvm_s390_dump_completion_data(void *buff) { return 0; }
-#endif /* CONFIG_KVM */
 
 #endif /* HW_S390_PV_H */
diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 5fd63b9a7e3..046e1f922b7 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -5,8 +5,102 @@
 #include "qemu/osdep.h"
 
 #include "kvm_s390x.h"
+#include "target/s390x/kvm/pv.h"
 
 int kvm_s390_get_protected_dump(void)
 {
     return false;
 }
+
+bool s390_is_pv(void)
+{
+    return false;
+}
+
+int s390_pv_query_info(void)
+{
+    return 0;
+}
+
+int s390_pv_vm_enable(void)
+{
+    return 0;
+}
+
+void s390_pv_vm_disable(void)
+{
+}
+
+bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
+{
+    return false;
+}
+
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
+                          struct S390PVResponse *pv_resp, Error **errp)
+{
+    return 0;
+}
+
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak,
+                   struct S390PVResponse *pv_resp)
+{
+    return 0;
+}
+
+void s390_pv_prep_reset(void)
+{
+}
+
+int s390_pv_verify(struct S390PVResponse *pv_resp)
+{
+    return 0;
+}
+
+void s390_pv_unshare(void)
+{
+}
+
+void s390_pv_inject_reset_error(CPUState *cs, struct S390PVResponse pv_resp)
+{
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_cpu(void)
+{
+    return 0;
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_mem_state(void)
+{
+    return 0;
+}
+
+uint64_t kvm_s390_pv_dmp_get_size_completion_data(void)
+{
+    return 0;
+}
+
+bool kvm_s390_pv_info_basic_valid(void)
+{
+    return false;
+}
+
+int kvm_s390_dump_init(void)
+{
+    return 0;
+}
+
+int kvm_s390_dump_cpu(S390CPU *cpu, void *buff)
+{
+    return 0;
+}
+
+int kvm_s390_dump_mem_state(uint64_t addr, size_t len, void *dest)
+{
+    return 0;
+}
+
+int kvm_s390_dump_completion_data(void *buff)
+{
+    return 0;
+}
-- 
2.52.0


