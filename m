Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C1BEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhbh-00033u-QX; Wed, 04 Feb 2026 13:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbg-000335-EL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbe-00016o-II
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:04 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so578215e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229681; x=1770834481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VASuul27qhIBrpK7E+LNnKj3UN3CBXvmYhJX8kxlH0=;
 b=Scfgtnbokrx6oc8rwP/ox35utJk7/1nftTGoRc5KR+2V84i6QAnC77DlQHV6/9zGJw
 otSQd8JVe4KhNAf6kc0OSXSbXRIpPoKE1xvsb3rH1ZQ0hk0E6JsUKphjs5nSEvB4RlFC
 IltxbrBvKT4E4qxNB999pORPSAVqoWWEUI5hkktAvVp8SXSzr22iTsxct3UxG7SVM+/v
 ZIAaPObxnLbbRGnIwojnqfGCMwiEEdgM3uc3c1O7p41wHuGIXQb3sxllbfOINlR5YvYm
 zQSoPJRFU58Mb0En1h691E/QAUyOO0tWL2VrzH7wSQm2VgSEjf8joTQ5PYIHI4TH/AzO
 5Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229681; x=1770834481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0VASuul27qhIBrpK7E+LNnKj3UN3CBXvmYhJX8kxlH0=;
 b=iWbUCj3lnpxqFAL3rnzDvqQZqhN+wC6n1uouEakSVL7qD0LyiVy+ZSlUJX8yHfYpE8
 MO/kDsZqHPueV5lXbchBgPpw7pkcU5YaJf+Ew+j2xWeDieH3InzJB3URvDR6KO0hpAm4
 Z8SCsZudcw55DAj0roiOr39DNI96A8y7tOrR6OKVGYC0KdgPwYlSaJl6Ta6WoRSo9aQK
 Pc2W1z87O4wsUAKkNhmULBIQPCDrqyOlQCHQc9BF4VO7KMGD3dTF8tWCPYXZJtrHdmfD
 dzUSy+RUIKfBmm+LBJQ4eFf+PBcsajgmphM43FPGsYhNEpjbmsFMBdmdDTi7J2kg8YoB
 0ZGA==
X-Gm-Message-State: AOJu0Yzp7JM9YNWQ/2v8zOiXCf5nP8l+fQ5MHOkmNPlioJJADMbjZdNJ
 BiOG+Zf68x3jBPw/mWmQg94e774H9n6N4Ighc6KFZRx5ZyU1L3nYiEBysk57HtTINHea0z2Ouf5
 chPGpN4I=
X-Gm-Gg: AZuq6aLyCQ+VMkV/2rh6QbzloIgkx7zDTLqTTU2R0KRFgZ9esFPhvfY2Pi/HUzTMJdD
 l569zm+cATvlqfxM1+BtUdtUOb0VrtoYc3kixUNq0HqofLMXh3dOriSmvx1T1Tb4UvcvQb1Aop0
 oI28EqoBM2rZIPbwUnswCVMfcigrWTxZPlblzll4KZEdg6kM9YHX5b1Crv8zfG9jbMBMEPFKvIk
 YFoFYZmL5SWm8+ZSoVwDUP7o0WYTNEau6g3MWIeu9JlGnzHqRNXSX85AVnuo/zLIZSGZAVp8LU6
 gDfhYB+S7VhpDJw2o8ecJS6CrZX2HKjPSqE2JcMA/IBhldPPJ8+Oz3LhgobxV0IdQDB0+xsVcaD
 jzVAJKQ5aVoAU92KkZoqi4i4hh2gN9SBUgB8X0psYxZBiYSHWgfdPbQayxhpKsIF6GphKtXe0Ze
 1suhLDMJWC/YnWfpXJSG/vn0aB9SmRddF9GWjLdF6WiMjRB+k0JU3UwgcVDEgb
X-Received: by 2002:a05:600c:19cf:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-4830e93e9f6mr57053675e9.1.1770229680605; 
 Wed, 04 Feb 2026 10:28:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d2c856sm2320585e9.4.2026.02.04.10.27.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:28:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/9] target/s390x: Un-inline KVM Protected Virtualization
 stubs
Date: Wed,  4 Feb 2026 19:27:18 +0100
Message-ID: <20260204182722.44062-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204182722.44062-1-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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


