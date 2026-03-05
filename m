Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92558F47CD4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFg0-0006XF-Lw; Thu, 05 Mar 2026 15:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFfy-0006X2-Ip
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:06 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFfw-00065L-02
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:06 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-89a0ecbc713so41088456d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743923; x=1773348723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lx5W1qivAVEWx1Q4u6g+Hr2hU85HQyKfVSro3hcuqg4=;
 b=rskuN0PJbzO/LO/oM9ZajOf2Wpx32t6NQY/GXh8yuVkaEle0inrNvbsIbrZi15z46Y
 tjqTsc1SA1MilNvU9XFs1PwjWca9LSazlyhB8ljA5RUmkruytpA5jd1QAjp5LabHH6MT
 sPoJwY5siEVsMAh2VrzWD5ZUbXF0z0oBESsolplQXsloDzWaILRlHEaP4c2KbQwFgix+
 UEratLFdt3zk44gm/HWmwpR4UyZGpGYC9VrGJxeJb3n7x8qzcZ4OuhYbjVCFQhSNJuJU
 iaiaz8MPv+aaozoi6KkUQWYAekp2V8t5qkiHiUHSTDze/f+EdkW8mJaF/8kmCRdTpIYr
 XZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743923; x=1773348723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lx5W1qivAVEWx1Q4u6g+Hr2hU85HQyKfVSro3hcuqg4=;
 b=IP//BEcD7VEYUuRUU6jAf92AJpyNKTahCl3vVBfz/O4+o1r+1QDV6vPdlFZM9lacFo
 HzYj5LqhuGFZAQbLqQvXd2G9oumAQCaco5ZbHEclmaHKgaL9MsfChEIKxOa3mMn5GtgO
 ABR/J3S7LoRChtn0JvYm6ch7YO6cSl80z9MXO+ZZc+QpOYF26cEgkumQBncKA9U14j5T
 NxCMs3iamJhElJjgMHEYU1plVksOoqVBxucGDkivwqzP4jYYecBPaw+AAjdJlTgmwv0d
 evnYgUk+DguxP94nSmJIlhQbJtkghBUMFVw1SfF7t/fy73MmO8AwBLhK4ima7zNkOPGF
 3C4Q==
X-Gm-Message-State: AOJu0YypMQQmW/+OiHv/hlO+4jo9aTdWBeKtofoxTBpaipH1r28c6eV9
 tMqfso/TCwSUJHsRaQ0pS6sYaNkvxlX86goonWx04iO5Bkpqq2BzaFxebBp49gyMi/62gtnvVc7
 076gy
X-Gm-Gg: ATEYQzyTCHRjn52pFDmtQztetsKCMAJbv7yfEYSvJ3WqL0yj8cXpKSgsoKQhtAxYhM/
 c/KpGcz6f+eC28gYeNBE3FGgUdsYxfCTLYRp9wwecbH+fdTKV/CZCqyb9pEDWq4DbXpqmafN/9I
 5ZkR1KaPzf+G6tbMqhZ1J+VIVdKroDBXIPu2IstXgNSlzBNucHmEzWCYR8jDhqAnkeRiW7OMi7A
 lo8kqCpaqZxlyiPOvcNs1e6dl+5KIkKYzti/EX6KCrNvjHqPYyBQrZSsGXzbhx2WRVTUomd+qvo
 3LMeutJ5IQkpqqxJMkzbt+GXAG3TGF8Oc7xYNmIvqdDkX6LwosB2IdAJ94uinITbVnde5f4HXZ/
 Lx7oI8yWhZMDb24ifXdJmF7BTWTuWmg8EB6voEfBYWXSLDglJEebyAlXi8PgVLKIynXkWpVQ1b0
 QW9eBdx8qwFArGGd2l67mUKen49dX5iHztgWakgQ0Fv/w0oDp+0/M/qoQxZvdKqAGaMuaaKy20O
 tSK
X-Received: by 2002:a05:6214:f2b:b0:89a:424:984b with SMTP id
 6a1803df08f44-89a24809caemr54658156d6.31.1772743922586; 
 Thu, 05 Mar 2026 12:52:02 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:02 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 01/12] plugins/core: clamp syscall arguments if target is 32-bit
Date: Thu,  5 Mar 2026 12:51:41 -0800
Message-ID: <20260305205152.2121854-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Syscall arguments are abi_long in user code, and plugin syscall
interface works with uint64_t only.

According to C integer promotion rules, the value is sign extended
before becoming unsigned, thus setting high bits when only 32-bit lower
ones should have a significant value.

As a result, we need to clamp values we receive from user-code
accordingly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index 42fd9865930..d6173422e98 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -513,6 +513,23 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
     }
 }
 
+static void clamp_syscall_arguments(uint64_t *a1, uint64_t *a2, uint64_t *a3,
+                                    uint64_t *a4, uint64_t *a5, uint64_t *a6,
+                                    uint64_t *a7, uint64_t *a8)
+{
+    if (target_long_bits() == 32) {
+        const uint64_t mask = UINT32_MAX;
+        *a1 &= mask;
+        *a2 &= mask;
+        *a3 &= mask;
+        *a4 &= mask;
+        *a5 &= mask;
+        *a6 &= mask;
+        *a7 &= mask;
+        *a8 &= mask;
+    }
+}
+
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -531,6 +548,8 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
         return;
     }
 
+    clamp_syscall_arguments(&a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8);
+
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
@@ -584,6 +603,8 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
         return false;
     }
 
+    clamp_syscall_arguments(&a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8);
+
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
 
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
-- 
2.47.3


