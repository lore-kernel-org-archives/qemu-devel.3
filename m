Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4E9C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmi-0006pm-JK; Mon, 24 Jun 2024 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgme-0006me-82
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:48 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmY-0007gd-OC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:47 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52cd80e55efso4511194e87.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224321; x=1719829121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vyNzW8swQuYkPObetY8GGPVB+trDsJ78ejFduvHLra4=;
 b=bOuEoPltXk/BDmqTxr7flLBzYPuQ+NCNT2fCXnKO4YgnExDn8aoXDyyMlhxX+k9IQd
 Dvhwkxvy+Bd3ST6t1sZqlTRlXXeFxjrfLAma6vWOZzg4ydgbjBNBTmiLnXDIIPlyiXkv
 ZlvFjNmRQgIEnYSR3VU8c/dM3k2MQWtQbP8yZvy1nY+AvixtErJYNwVbGoAI8emem8GD
 vvORLek/85RPBNFh4qdbfWePxXo062WqZGYBKqNGQ0OdJwDenQ9chYwk5zpYpTpONI+B
 EDvREHPMXpEucJX5ljb4GaVfMltDRq6LZoXoxUnwygiQyRwHutHDIMMhZpfmOo6h0NlH
 +2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224321; x=1719829121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vyNzW8swQuYkPObetY8GGPVB+trDsJ78ejFduvHLra4=;
 b=SfiAjZNCv/qdxrWn+AXlirP5kizRDcJ942CZUI9HCA/sTDTQ4wY6UPvVrK8pqz7OF0
 2nualAGqMOoiqYPlZuSFErtE3Qg4HZluzxtRWiT9ihQw9uNxnHttD17mLb+m2p7s7FIo
 IlJ3/NHMtsr54nfMPLtQiK+jtCSiz+ybzKktvOMLgVPOMUfQfEgIv6HkmZvNecQ7Rm55
 EOotK5+pPH7xZj8vfwzzFMbnvLQW5SXJjojSYO8hYURVr4A2tpQ9AAXrfRxFt6safFiY
 Kwc0jyHEkTe4FrDATg+po/mALezlHWsVUMsgURkdr1vUzg/GwsJBy8K+sl7X3pHeGJ3G
 YM7w==
X-Gm-Message-State: AOJu0YzNJ7VDeMiwWHrFFd64axsiI2ewT15TVZZRu9/aZhwBxOLgVqaS
 3YTnI5w+AOiI3WakY3rdLcmqIguAnOiT4tsFKWXB6wO7pEpIgD7hSg6qsDGFruQ=
X-Google-Smtp-Source: AGHT+IHjz9zr9W74cajV4yjLpkcfdyQPIoXQ5l1gQ5D0Z7n/aKRu0zHLgtVWrwkhY8lkBgzn4zpf4g==
X-Received: by 2002:a05:6512:2813:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-52ce182bc85mr3431908e87.14.1719224320701; 
 Mon, 24 Jun 2024 03:18:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a725cc93794sm43811966b.170.2024.06.24.03.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B44215FA1A;
 Mon, 24 Jun 2024 11:18:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 04/12] sysemu: add set_virtual_time to accel ops
Date: Mon, 24 Jun 2024 11:18:28 +0100
Message-Id: <20240624101836.193761-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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

We are about to remove direct calls to individual accelerators for
this information and will need a central point for plugins to hook
into time changes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240530220610.1245424-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240620152220.2192768-5-alex.bennee@linaro.org>

diff --git a/include/sysemu/accel-ops.h b/include/sysemu/accel-ops.h
index ef91fc28bb..a088672230 100644
--- a/include/sysemu/accel-ops.h
+++ b/include/sysemu/accel-ops.h
@@ -20,7 +20,12 @@
 typedef struct AccelOpsClass AccelOpsClass;
 DECLARE_CLASS_CHECKERS(AccelOpsClass, ACCEL_OPS, TYPE_ACCEL_OPS)
 
-/* cpus.c operations interface */
+/**
+ * struct AccelOpsClass - accelerator interfaces
+ *
+ * This structure is used to abstract accelerator differences from the
+ * core CPU code. Not all have to be implemented.
+ */
 struct AccelOpsClass {
     /*< private >*/
     ObjectClass parent_class;
@@ -44,7 +49,18 @@ struct AccelOpsClass {
 
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
+    /**
+     * @get_virtual_clock: fetch virtual clock
+     * @set_virtual_clock: set virtual clock
+     *
+     * These allow the timer subsystem to defer to the accelerator to
+     * fetch time. The set function is needed if the accelerator wants
+     * to track the changes to time as the timer is warped through
+     * various timer events.
+     */
     int64_t (*get_virtual_clock)(void);
+    void (*set_virtual_clock)(int64_t time);
+
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index d86738a378..7bfa960fbd 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -96,8 +96,9 @@ int64_t cpu_get_clock(void);
 
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
 
-/* get the VIRTUAL clock and VM elapsed ticks via the cpus accel interface */
+/* get/set VIRTUAL clock and VM elapsed ticks via the cpus accel interface */
 int64_t cpus_get_virtual_clock(void);
+void cpus_set_virtual_clock(int64_t new_time);
 int64_t cpus_get_elapsed_ticks(void);
 
 #endif /* SYSEMU_CPU_TIMERS_H */
diff --git a/stubs/cpus-get-virtual-clock.c b/stubs/cpus-virtual-clock.c
similarity index 68%
rename from stubs/cpus-get-virtual-clock.c
rename to stubs/cpus-virtual-clock.c
index fd447d53f3..af7c1a1d40 100644
--- a/stubs/cpus-get-virtual-clock.c
+++ b/stubs/cpus-virtual-clock.c
@@ -6,3 +6,8 @@ int64_t cpus_get_virtual_clock(void)
 {
     return cpu_get_clock();
 }
+
+void cpus_set_virtual_clock(int64_t new_time)
+{
+    /* do nothing */
+}
diff --git a/system/cpus.c b/system/cpus.c
index f8fa78f33d..d3640c9503 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -229,6 +229,17 @@ int64_t cpus_get_virtual_clock(void)
     return cpu_get_clock();
 }
 
+/*
+ * Signal the new virtual time to the accelerator. This is only needed
+ * by accelerators that need to track the changes as we warp time.
+ */
+void cpus_set_virtual_clock(int64_t new_time)
+{
+    if (cpus_accel && cpus_accel->set_virtual_clock) {
+        cpus_accel->set_virtual_clock(new_time);
+    }
+}
+
 /*
  * return the time elapsed in VM between vm_start and vm_stop.  Unless
  * icount is active, cpus_get_elapsed_ticks() uses units of the host CPU cycle
diff --git a/stubs/meson.build b/stubs/meson.build
index f15b48d01f..772a3e817d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -29,7 +29,7 @@ endif
 if have_block or have_ga
   stub_ss.add(files('replay-tools.c'))
   # stubs for hooks in util/main-loop.c, util/async.c etc.
-  stub_ss.add(files('cpus-get-virtual-clock.c'))
+  stub_ss.add(files('cpus-virtual-clock.c'))
   stub_ss.add(files('icount.c'))
   stub_ss.add(files('graph-lock.c'))
   if linux_io_uring.found()
-- 
2.39.2


