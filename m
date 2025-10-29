Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB41CCF9F7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SG-0004JJ-5H; Wed, 29 Oct 2025 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S9-0004AD-71
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:14 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rx-0002t3-GN
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:12 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b5e19810703so1701866b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753054; x=1762357854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JVPjp+p0LqcgwbbqEf2EcoXP0IUYtqEVdw3WZ1a5g4=;
 b=qvFHe13q7JR4Ph3JMwLnL/OW602cn97SEplPkVfn26e+FeifcWtKMXVTHmZXyO/pPz
 vEn2Set9Oh4zOpYLFtUxHjZV/E1/7aR/eeP1t5w9voa1ISjQhjZdYvxQSAMiGal2WTTK
 0qEc7GEWayX0XPO3C9Q4vgcbUeU+psJn+Ide/6IjimFXqo2oHqF9mdmD/vookZVhsZiB
 mYb5MRFqq5ZQD5pC06yWsuWv4i7CDydWE+JLmT3DjhDlQdu27rLCZoIseeMvxOsNLkud
 BNsRy0IcHscRDs+91MWS99wc3Rw5m6k/WeOsZx4jdl4nVf6MBze2z3XTvB7cbv0OYZ7M
 vVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753054; x=1762357854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JVPjp+p0LqcgwbbqEf2EcoXP0IUYtqEVdw3WZ1a5g4=;
 b=AIk83b7x/IbhvsWTaPs2iw0yH0WBLx16VQB++WTB1si2r07KU7O+Q8mWuPR+Rzyao9
 yqYubQjHkIpB9YM+n2eSd/+hrFm0N4s1X6gS6pEHStdHnLDtGszfW9THLHuS9YFr5h63
 jQPHThxkpwNT3Tm7cc/YOOGVuTrQGVm9vqMNJXFIXx7DaYo1bJqRMIpj/JEnyWlH9eKG
 VY6CSY8RJDrvjzdb4cewbb7Vfe1j+EwznJG12N9rhXTyVDiOQGzn0QyCpTMb5j317gJw
 He9fetVMuRUDAPpxmxURrV8S9H6sgNVoyZH48ygLYmcPy4wp+tQKu9Adb8xznBjKF+f/
 XZFg==
X-Gm-Message-State: AOJu0YyH3DtEJRUsC+vy8fvFrjh1/A/5la1CZKtXXuQup3fpcRAGqr3q
 Qb9MDmAtZwcvaT7rdscN+jcB2bjLaCr/1AciPFtupB5iAcjxb8ggUSoD9TuhCxEa3LE=
X-Gm-Gg: ASbGncs+5Fqui1HcWfN+WbRvifOMqAvip92Ejkv0aBrchIoMfRwAixWk60t80JsilHF
 Q5NzQLNCtYa2e0UhYnbihjJbl3Q9kAJ0AFqpJStSuqjElmrsKB7WtQiQqI38LhzloV6KdCj854F
 IRAkn8uSksjYq1A/eK96xzX4lTp2+GFUVNar/uBSACNWZR9q5FAemNyUiNmsZRUimCRlRE1WcNg
 oOR9OzJhFmf2PHDBuFWFPTrtYAbB3fkQAD0/vmTQVRniGG4kIwuzYMdHiH59YQ2pT2W9Wr1C9qG
 daDm24j79J9GWgKc3mk1PqqySWGIsAGBq1zxScUEWPU6dKUxrAgu5njyArv2TDDFkPyS4JZhS/q
 HxaM8H7P8rluTRxYgeL3VnBCkka6YRsYx4BdfCnd51bP5l8C/TljyHx91903tesyt1kuAPY2iiQ
 It
X-Google-Smtp-Source: AGHT+IFcnRvMF0vgyxEnKxZBJgYIM0n7No+vR6lyXVN+4DFGQcYhky+PmicVtViKqcoaazhc+dNJYA==
X-Received: by 2002:a17:907:7b89:b0:b4f:e12e:aa24 with SMTP id
 a640c23a62f3a-b703d326f7amr331527366b.22.1761753054269; 
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853386d8sm1448469766b.18.2025.10.29.08.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B87C65FAF1;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 09/35] plugins: add hooks for new discontinuity related
 callbacks
Date: Wed, 29 Oct 2025 15:50:18 +0000
Message-ID: <20251029155045.257802-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Julian Ganz <neither@nut.email>

The plugin API allows registration of callbacks for a variety of VCPU
related events, such as VCPU reset, idle and resume. In addition, we
recently introduced API for registering callbacks for discontinuity
events, specifically for interrupts, exceptions and host calls.

This change introduces the corresponding hooks called from target
specific code inside qemu.

Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 8cf20cd96f7..cea0a68858b 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -161,6 +161,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from);
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from);
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from);
 void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
@@ -258,6 +261,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 { }
 
+static inline void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
+{ }
+
+static inline void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
+{ }
+
+static inline void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
+{ }
+
 static inline void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
diff --git a/plugins/core.c b/plugins/core.c
index 40d001d39ad..35a252d2729 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -105,6 +105,30 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+static void plugin_vcpu_cb__discon(CPUState *cpu,
+                                   enum qemu_plugin_event ev,
+                                   enum qemu_plugin_discon_type type,
+                                   uint64_t from)
+{
+    struct qemu_plugin_cb *cb, *next;
+    uint64_t to = cpu->cc->get_pc(cpu);
+
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        /* iterate safely; plugins might uninstall themselves at any time */
+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+            qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
+
+            func(cb->ctx->id, cpu->cpu_index, type, from, to);
+        }
+    }
+}
+
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -557,6 +581,24 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     }
 }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_INTERRUPT,
+                           QEMU_PLUGIN_DISCON_INTERRUPT, from);
+}
+
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_EXCEPTION,
+                           QEMU_PLUGIN_DISCON_EXCEPTION, from);
+}
+
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_HOSTCALL,
+                           QEMU_PLUGIN_DISCON_HOSTCALL, from);
+}
+
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
-- 
2.47.3


