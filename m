Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338D2C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 11:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Iug-0001JI-6H; Thu, 03 Apr 2025 07:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0Iud-0001IN-00
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 07:39:11 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0IuZ-000268-NI
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 07:39:10 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so1302960a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743680333; x=1744285133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDl2NGkfDzFnsGrEICuCfCjw8YW6GzZVN9B/XBJfbv4=;
 b=Bg3HdQt2KQ2XBf8tApDNw3rAgKE2iD5btYqNoviaqwS7F7Gkd4Y4B3eAgxixcNfslF
 LgZOgEcFV4zvN4/ZMUZPYC5vjfF1JHo1DC48gZQww2Nh0xFK5FsiwFScQRCIbtgcwGm3
 72OPxbWEFY0co6P1x1uKv6LENyAATn27d5cv4IODEps2kVJJLYB4PsOdEezc+2Qpd56j
 gbdlWsu8LC0vQeY81NFCk8NoR4DuEB++zPX9e6eLeTrt4dYRyul1MAM+ePSE9svAjXaE
 UczPW8sMc3JzjSUALGRNpIVT4OIju5bYSmTLU6+VdVpyWFOUFaCaSltQqv/B3g+RhXMc
 gaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743680333; x=1744285133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDl2NGkfDzFnsGrEICuCfCjw8YW6GzZVN9B/XBJfbv4=;
 b=MwxbSgk0DGXA3KmSNZD9KIPNNlMs37kstcKr2S9bB3eTlUH/Gadmncxz2FwuAt38tO
 lJMBhV0GVXOqh1UzFGtD8mdb/Gbx6rHt6ngdWVPJz3qn2AirDhGf/KQWcddkdg4wLCDE
 BRUN9NC1Qga9jIOjSlx2Nb1uFc0dX9RjFt/Bv+2RnmYy7FrkZ2WSNdi+pt8iJWHvvfn6
 +Byftct+o/4LXGA7yDXXQSXpEhzYhJXwAvBui0ZwkXt/0QSV4hVuEcGXWbChgPCIk4zG
 DA1cKEqKQdv8cROc2jR1BE0kHlm8DLh68ednsUblH6JUduOIbAdMLySRzP24SG7gdfv2
 2Qcw==
X-Gm-Message-State: AOJu0Yz75640MW/LxgZlMZlBhluiYu6HeGKjRglUDgoi8VnEXILPMv1Y
 bI+ASRaF5Ysoit6E76eCq9Zq9bb5FjRw3RIMTrSNAgGRi8OfiasX57ylcGWROsk=
X-Gm-Gg: ASbGncuEuZydLYhrWzhfN+AIy+CuoprT5Cg+mUKXfiUDHEHh87ELkKajFdJ5Cy/Am0i
 TP1AkXkWbswIrI0JnAkcLdpiHDktLmd4FVxDJskWSP0SNFeJWILiSHezpn4O6adlN3bKNzFXj6h
 Egj8EqcWkdfj4zKKrKySd8cV2vPxDE+f8fHZ104x4i3lcqV2/fNkXkEcPnHmFOnFdt6Gj+WWRr/
 InVSo2/h6D076pQfIh/HHI/YLS0WnnefeS6VGt5f1WJrd1riwvd74OEY4+3aI4El45ORw7MoyIH
 94L6v4sFiJ2Qd2LwD8NUSym9rmS2vYwQQqDTu44JyTjf+cQ=
X-Google-Smtp-Source: AGHT+IHm0SxO69l7FXwnKUX3b6rBvjZdRKnAc8Ig7IKCiknSXJGf4YwMGVpf6cAD4mOrBa0usE9sxQ==
X-Received: by 2002:a17:907:72c4:b0:ac7:16ee:910b with SMTP id
 a640c23a62f3a-ac73895f900mr1734226266b.12.1743680333544; 
 Thu, 03 Apr 2025 04:38:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5c93asm80459666b.14.2025.04.03.04.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 04:38:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B6805F9E0;
 Thu,  3 Apr 2025 12:38:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 2/2] plugins: add qemu_plugin_register_time_cb support
Date: Thu,  3 Apr 2025 12:38:51 +0100
Message-Id: <20250403113851.4182190-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403113851.4182190-1-alex.bennee@linaro.org>
References: <20250403113851.4182190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

This allows the a plugin which has control of time to supply a callback
so it can control the reported virtual time instead of using the
default cpu_get_clock().

Time control plugins still need to call qemu_plugin_update_ns() to
ensure timers are moved forward.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin-event.h |  1 +
 include/qemu/plugin.h       |  9 +++++++++
 include/qemu/qemu-plugin.h  | 18 ++++++++++++++++++
 accel/tcg/tcg-accel-ops.c   |  5 +++++
 plugins/api-system.c        |  8 ++++++++
 plugins/core.c              | 22 ++++++++++++++++++++++
 6 files changed, 63 insertions(+)

diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b..ae9ec5ce85 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -20,6 +20,7 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_GET_TIME,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..a9371a9a42 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -63,6 +63,7 @@ union qemu_plugin_cb_sig {
     qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
     qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
     qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;
+    qemu_plugin_time_cb_t            time;
     void *generic;
 };
 
@@ -175,6 +176,14 @@ void qemu_plugin_flush_cb(void);
 
 void qemu_plugin_atexit_cb(void);
 
+/**
+ * qemu_plugin_maybe_fetch_time() - fetch virtual time from plugin
+ * @tptr: pointer to int64_t for result
+ *
+ * Returns true if the plugin has set time, otherwise false
+ */
+bool qemu_plugin_maybe_fetch_time(int64_t *tptr);
+
 void qemu_plugin_add_dyn_cb_arr(GArray *arr);
 
 static inline void qemu_plugin_disable_mem_helpers(CPUState *cpu)
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 3a850aa216..c5f1cad8fb 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -713,6 +713,22 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
 QEMU_PLUGIN_API
 const void *qemu_plugin_request_time_control(void);
 
+/**
+ * typedef qemu_plugin_vcpu_mem_cb_t - time callback function
+ * Returns time in ns (starting from 0)
+ */
+typedef int64_t (*qemu_plugin_time_cb_t) (void);
+
+/**
+ * qemu_plugin_register_time_cb() - register a time callback
+ *
+ * This can only be called once a plugin has successfully called
+ * qemu_plugin_request_time_control(). The callback will get called
+ * whenever qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) is called.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_time_cb(qemu_plugin_id_t id, const void *handle, qemu_plugin_time_cb_t cb);
+
 /**
  * qemu_plugin_update_ns() - update system emulation time
  * @handle: opaque handle returned by qemu_plugin_request_time_control()
@@ -723,6 +739,8 @@ const void *qemu_plugin_request_time_control(void);
  * user-mode emulation the time is not changed by this as all reported
  * time comes from the host kernel.
  *
+ * This allows QEMU to execute any pending timers.
+ *
  * Start time is 0.
  */
 QEMU_PLUGIN_API
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 1432d1c5b1..5ed748f5cc 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -33,6 +33,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
+#include "qemu/plugin.h"
 #include "exec/cputlb.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
@@ -199,6 +200,10 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
 
 static int64_t tcg_get_virtual_clock(void)
 {
+    int64_t from_plugin;
+    if (qemu_plugin_maybe_fetch_time(&from_plugin)) {
+        return from_plugin;
+    }
     return cpu_get_clock();
 }
 
diff --git a/plugins/api-system.c b/plugins/api-system.c
index cc190b167e..0f2a3eb5a6 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -17,6 +17,7 @@
 #include "hw/boards.h"
 #include "qemu/plugin-memory.h"
 #include "qemu/plugin.h"
+#include "plugin.h"
 
 /*
  * In system mode we cannot trace the binary being executed so the
@@ -129,3 +130,10 @@ void qemu_plugin_update_ns(const void *handle, int64_t new_time)
                          RUN_ON_CPU_HOST_ULONG(new_time));
     }
 }
+
+void qemu_plugin_register_time_cb(qemu_plugin_id_t id, const void *handle, qemu_plugin_time_cb_t cb)
+{
+    if (handle == &has_control) {
+        plugin_register_cb(id, QEMU_PLUGIN_EV_GET_TIME, cb);
+    }
+}
diff --git a/plugins/core.c b/plugins/core.c
index eb9281fe54..d56b4c9d48 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -571,6 +571,28 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+bool qemu_plugin_maybe_fetch_time(int64_t *tptr)
+{
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_GET_TIME;
+
+    /* there should only be one callback */
+    if (!QLIST_EMPTY(&plugin.cb_lists[ev])) {
+        struct qemu_plugin_cb *cb = QLIST_FIRST(&plugin.cb_lists[ev]);
+        qemu_plugin_time_cb_t func = cb->f.generic;
+        *tptr = func();
+        return true;
+    }
+
+    return false;
+}
+
+
 void exec_inline_op(enum plugin_dyn_cb_type type,
                     struct qemu_plugin_inline_cb *cb,
                     int cpu_index)
-- 
2.39.5


