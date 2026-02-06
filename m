Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE53DEE6B6A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTfC-0006UZ-HW; Fri, 06 Feb 2026 16:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTe8-0005Pe-0a
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTe3-0002bw-0J
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:47 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-482f2599980so30654165e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414336; x=1771019136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psfjES6GIpNdKTgkvXNnu0Jv8MKKp9lWAQ/C32Dzxf4=;
 b=O3kUIChQrnBlMNRteKGzK9zxbxXDmfK9EElnYFnmMCDyTEfUe0CIGRuu8NQ0BzIj4z
 g09be6AcKafQ9ZYtwA6XU0Lptr5AfNg5+hBkOLHDF0pl+ElXzAuFdFu1LafeBmsVPQ42
 QLeFVMVy9nQFFD9f+WY90ecPhQgdPO8YbVbbXz0Xck6LILcObaNhPNt4R2Ecvemg6lDr
 f5h1u+sWKgP95mYsSvHae5hjCe5z/3D+VpBColbDeIhMRXE0oPsREl+YmG5y5QDR+/7J
 QvyRYuoztwYfd2h87MMUCtDbF4cY6yr3knqGfPL6O1peQOlb/7gz2sxudpm1+Eyul7nE
 Q4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414336; x=1771019136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=psfjES6GIpNdKTgkvXNnu0Jv8MKKp9lWAQ/C32Dzxf4=;
 b=PNr2IAGwa4EjsG1g07XFhzeSWPObWBpbeTvobrv8dgAc9/gUcOkJ6DJVCWUdCIDQgR
 3m/7/w7oYgkFhIEjvY3RTF4rqu86uTCaAajDEzIr6i/I7jFmBFM2B6Q7pa7gJiwpNgq8
 XLDa9qkFCJ6G3pPUzNyqx1Dz9xZCDuLz0Ogmst1dBHKVmZfIGaPPX8naxjENWmoorifr
 pBXA6j+r+eRkxFalcpplmAdGwiknjVwG8lfiR17Grne+YO9FoZ8GygpI7Xp4iiTEnBM9
 C8VJGVlAbg/6E50Aqwf0UGNkpQfOwjj9sq+6mctsAYIz+pM6Qa1BS6iXnJlFAusq3LdO
 dpXg==
X-Gm-Message-State: AOJu0YyeWlR4An2jVabRJu3y+9m308oqIuCw0NDuEPYl/8RuiVQvFM2H
 0TCA6rXQc+Y2v0WzaXcuI3sEQ7kHitZAMObHCFHAD94+aXFzdc6Ea4D9HkRbmvVVcVr22r7Rlye
 owlUQGBI=
X-Gm-Gg: AZuq6aJtBXE0Q5cBnbmKeNd6PI0yiVQwkCwVGsHvMXRQz/bXBpVwsBbRyUY0k1D7ryS
 riDYXsKk1yB7G8stBJE24OSR2Qd8npfP5wLLofi7vM5DNqcaWuiOe8RiUzAmbksyoCBIkuqJmru
 zNH1/KGJRVH8J3CtJ1WavKQlpLmKz5hOK1GVkTS0kkHZv5NkcUTXiZSmYmkLMIETajwuHmHFV+m
 LGiV/v6Ry6eW5PyFdMqqgyKWiX2I5tVx5omNydYYzrABxQ1GwFq4SjoUQvI3pg/E4t0ffngljMp
 j1VMJBZRoRvVKmol0nDdUKFTUVQc5COJTzNgjrLawxf27kSHXOhwY0xQGVb2KubrJubmvsyCqxw
 IJBTnOaWu5HMhTffeKG16WKFFJiN3wO3zX14Y47HhNO+fcqKyyZIGMbLiP0HQz17J22b7I218cA
 J00stGMvzataZFcRyjDUBevjHnnjvsW4JpY7FZwR9WWuHNhiQ2Y9h16pdHQFEH
X-Received: by 2002:a05:600c:5253:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-4832021b53dmr63696695e9.21.1770414336469; 
 Fri, 06 Feb 2026 13:45:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4832041f1a3sm38552615e9.7.2026.02.06.13.45.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 07/30] target/s390x: Add more unreachable KVM stubs
Date: Fri,  6 Feb 2026 22:44:25 +0100
Message-ID: <20260206214448.22008-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Next patch will move s390x system objects from the target
specific source set to the common one. Unfortunately the
kvm_enabled() macro won't be evaluable at built-time
anymore. Add stubs for KVM symbols unreachable at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260206181953.18683-7-philmd@linaro.org>
---
 target/s390x/kvm/stubs.c | 76 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 046e1f922b7..196127baa51 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -4,8 +4,9 @@
 
 #include "qemu/osdep.h"
 
-#include "kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
+#include "target/s390x/cpu_models.h"
 
 int kvm_s390_get_protected_dump(void)
 {
@@ -104,3 +105,76 @@ int kvm_s390_dump_completion_data(void *buff)
 {
     return 0;
 }
+
+bool kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
+                    int len, bool is_write)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
+                       bool is_write)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_get_hpage_1m(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_enable_css_support(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
+                                    int vq, bool assign)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_cmma_reset(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_crypto_reset(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_set_diag318(CPUState *cs, uint64_t diag318_info)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_topology_set_mtcr(uint64_t attr)
+{
+    g_assert_not_reached();
+}
-- 
2.52.0


