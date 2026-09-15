Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E05C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZsF-0001UY-Cd; Tue, 15 Sep 2026 16:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zs4-0001Qe-QF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:19 -0400
Received: from mail-wr2-x1a.google.com ([2a00:1450:4864:30::1a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zs2-0005d9-U8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:16 -0400
Received: by mail-wr2-x1a.google.com with SMTP id
 ffacd0b85a97d-482f6350f88so83572f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504513; x=1790109313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QW5K/W0TiJTIitpSY5ssNog89nsYvNRU+uFyJOyaiQ4=;
 b=JShp3A5b/+8+CsBTYiO5Umpbt/XsBLbH30okZtX0+tDcFU3OlvGQmWgMbMoXvy/Wn6
 nMzXl/sJwEurjq+hamv0GGhZbva7m7G90tKLcz0xUIgjXLXiQPGljWZ6ffhq4ZRu861H
 1ogagQz589ovQ0N3uE33oq8oQngOTkEcFFXbDVPFiySRTrzAtQCYVqOVSOh0mIFzyR1I
 lwriF4822i6h//ZaOqxULt8n2bp5fFmq8HSWyRdqqB8GcMeRp0AK46fIbJolYYb63Jqd
 e32pREVUyCwA5GdJTuaxpRa+CckZRccImtGHHeGV2v6YLPIH9PCaK31tWmE93hIHp22B
 u1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504513; x=1790109313;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QW5K/W0TiJTIitpSY5ssNog89nsYvNRU+uFyJOyaiQ4=;
 b=tlWC28Rosoplogl9wk0Grhy0DJpNa7QWmmec2WIHKek8mHRfWI6295L0Qc3qa7Twzv
 z9n74Yme4ENsppQPrSdyAE3QgWtH+TOFniHt8zw+xW4EVkEQcLXNLtY9B5VnxnW11CFM
 CEOOqdio2RgeaouR3efHlimjEcybh4niFm0FtrqdAJAsI5+V2Se9IMnaSv2zvJoSfFus
 f4GB3zua2AS4+xlUz/9K2b1vQhaCUOJspSd1UUwQgV+MUsaai1mBVC+sAYD23XScZNo4
 tSHRjCcHrWJszYDswW7kX5pJ0l1XrKN2JE5HEJUq0uCUvPsBmH/HNWEImd2XpZ0wdrW+
 SkXQ==
X-Gm-Message-State: AFuF++kj6ItoQ77XC4zm6YQAG8f0JUPbUjgUlGl1Dkzop9jT1Smd4XxI
 uqEtaOZKG/pXd/Wiu54KjC8bomBnmrbiZ3/fC8ybQs1143vpGbZEyql61dUOz1Jk8lBojNzJPqr
 kSEkw
X-Gm-Gg: AYBFou021sCwgs7JVepWrDS1SigD7bc0hqPsClLaQtPu73kS3Rvqfio3Sn99/WTTp7T
 UDIAkj6SORKkaTwp7eJ9oqO/T+4CM9kYlJsqhJddH6fs9E3Rtaag0FsPZJdi9P534qBwhaioaqu
 uCDW9bjNL3gjfY/N+4WNhVtQgkDsM4CAt8zeqYXOYPMZGOJlqJcZ3OPTBjn2o00Dxrq3Y6WFRk8
 9JyXPUNhbi32Xrql9Bq14rP/virhrOhzwuzQKAoMK2tjmpALNL9ISWQOYtwQCPFdbs/k3MjctQG
 aIp8RxbWDR4/3EfYpY02gAkinDI56KcVcDEQwrhHCOHAo0uPSMpFf9wd8e9ef1qHT85JYjRItYi
 WQsVC609WTOEl2K5Ogl22YJXXXaYKuecLJQqPdgTz5yKdJdRehuA6/l95XzPBzbAcpI/q+kuPWp
 wu6UhCwIzW79mwEIS1HaxpUJmSMnJQbSDsiy9i0Or0W6KOrX+6hejgt6TZIuX13xB/n66v
X-Received: by 2002:a05:6000:71c:b0:487:4ba:97f0 with SMTP id
 ffacd0b85a97d-4870cf31e89mr174072f8f.23.1789504513129; 
 Tue, 15 Sep 2026 13:35:13 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:12 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/10] system/cpus: add bql-watchdog-abort
Date: Tue, 15 Sep 2026 22:34:53 +0200
Message-ID: <20260915203455.580999-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::1a;
 envelope-from=den@openvz.org; helo=mail-wr2-x1a.google.com
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

From: Denis V. Lunev <den@openvz.org>

The report says where each thread was when the watchdog looked, not
how it got there. A core carries every thread's whole stack, at the
price of the guest. A qemu whose BQL has been held this long is not
running its vCPUs anyway, so on a host where the answer is worth more
than the guest, abort after the report.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/core/machine.c     | 17 +++++++++++++++++
 include/system/cpus.h |  4 ++++
 qemu-options.hx       |  5 +++++
 system/cpus.c         | 19 +++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b55af89516..2abb9e6295 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -403,6 +403,17 @@ static void machine_set_bql_watchdog_ms(Object *obj, Visitor *v,
     bql_watchdog_set_timeout_ms(value, errp);
 }
 
+static bool machine_get_bql_watchdog_abort(Object *obj, Error **errp)
+{
+    return bql_watchdog_get_abort();
+}
+
+static void machine_set_bql_watchdog_abort(Object *obj, bool value,
+                                           Error **errp)
+{
+    bql_watchdog_set_abort(value);
+}
+
 static bool machine_get_new_accel_vmfd_on_reset(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1174,6 +1185,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
         "Watchdog deadline for a Big QEMU Lock hold, in ms. "
         "Default: 0 (disabled)");
 
+    object_class_property_add_bool(oc, "bql-watchdog-abort",
+        machine_get_bql_watchdog_abort, machine_set_bql_watchdog_abort);
+    object_class_property_set_description(oc, "bql-watchdog-abort",
+        "Abort after the bql-watchdog-ms report, to leave a core dump. "
+        "Default: off");
+
     object_class_property_add_bool(oc, "x-change-vmfd-on-reset",
         machine_get_new_accel_vmfd_on_reset,
         machine_set_new_accel_vmfd_on_reset);
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 0e1e63bd85..14dbc8ff0d 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -44,4 +44,8 @@ void cpu_synchronize_all_pre_loadvm(void);
 bool bql_watchdog_set_timeout_ms(uint64_t ms, Error **errp);
 uint64_t bql_watchdog_get_timeout_ms(void);
 
+/* Abort after reporting, to leave a core behind. */
+void bql_watchdog_set_abort(bool enable);
+bool bql_watchdog_get_abort(void);
+
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 9600620d34..f43d8ca480 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -33,6 +33,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
     "                bql-watchdog-ms=ms report a Big QEMU Lock held longer than ms (default: 0, off)\n"
+    "                bql-watchdog-abort=on|off abort after the bql-watchdog-ms report (default: off)\n"
     "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
@@ -94,6 +95,10 @@ SRST
         milliseconds, up to a minute. The default is 0, which disables the
         watchdog.
 
+    ``bql-watchdog-abort=on|off``
+        Abort after the ``bql-watchdog-ms`` report, to leave a core dump.
+        The default is off.
+
     ``aes-key-wrap=on|off``
         Enables or disables AES key wrapping support on s390-ccw hosts.
         This feature controls whether AES wrapping keys will be created
diff --git a/system/cpus.c b/system/cpus.c
index 03a07e4824..a200a07707 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -398,6 +398,7 @@ static int bql_this_tid(void)
 static QemuThread bql_watchdog_thread;
 static QemuSemaphore bql_watchdog_sem;
 static uint64_t bql_watchdog_timeout_ms;
+static bool bql_watchdog_abort;
 
 static void bql_report_thread_states(void)
 {
@@ -411,6 +412,16 @@ static void bql_report_thread_states(void)
     qemu_funlockfile(stderr);
 }
 
+bool bql_watchdog_get_abort(void)
+{
+    return qatomic_read(&bql_watchdog_abort);
+}
+
+void bql_watchdog_set_abort(bool enable)
+{
+    qatomic_set(&bql_watchdog_abort, enable);
+}
+
 static void *bql_watchdog_fn(void *opaque)
 {
     unsigned int last = qatomic_read(&bql_seq);
@@ -456,6 +467,14 @@ static void *bql_watchdog_fn(void *opaque)
                      when ?: "", when ? " " : "", timeout_ms,
                      qatomic_read(&bql_owner_tid));
         bql_report_thread_states();
+        if (!qatomic_read(&bql_watchdog_abort)) {
+            continue;
+        }
+        /*
+         * A core carries the whole of every stack, and a qemu whose BQL has
+         * been held this long has stopped running its vCPUs anyway.
+         */
+        abort();
     }
 }
 
-- 
2.53.0


