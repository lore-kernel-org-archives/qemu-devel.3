Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227D1CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnQ-00077j-Vs; Tue, 02 Sep 2025 03:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnH-00074c-GK
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnD-0001vB-98
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7722f8cf9adso3484723b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799462; x=1757404262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3getHXPYzZdqMEOFGjHe0lrB5ynIJa8/W9r/FOOowbk=;
 b=hrvQSo3oZyRmaB2RHoutWICRA5qnaMK2TyLVQ81d6qYkk60QGj5CmV09BgRhzwrvLY
 Y6NavD3dqO2lfsmk16rH2M5JGDuODAPiczTfulYLfRzntQAntJwFz1ZOkSwz7yM69HjG
 Ux4RYBwkSbQ+5CQZEK9EyO4l5BiJyMH3DjAEXmYeD9ETMjAkd35scht2iUNFr8QEUmyL
 RPzWYEZtaCGx9Io4TbO4dqBY6ulThScl7dGAJUZ0/wM0EuxoF8v6cz52gOpFKK/xxjvv
 kQRirsmc77K7ZDkOfk3iOffY4kHTxDC+7ZENzB7jx1ZpXtJK5m9/FqAPPqjoxBT3jpQz
 cHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799462; x=1757404262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3getHXPYzZdqMEOFGjHe0lrB5ynIJa8/W9r/FOOowbk=;
 b=m40lMZyyOLCqEEsyM4xigP4C+jz9q4aDQbNTNlmbS3pSTUZ1hAaejtnqxnOSO0pWsw
 vK8/Uq9TJicZ+ETF8vXko2y+USZAkVk4YmMqf1Zcu2/qlqiiLk1qgBj2S6S/4wL6e8v4
 dek/G62RRniQDwlXx9E0+R3B2lbE+SamXFNmaQ9RLQAjt1HCLhPwpgYQ1QUOkuUg24j6
 W+mY2c8f8U4ZIXFFJ6vEXemN8fONuDVJ+2emfKP6GSrxQFyKpNbSSaIMrC0+gLKLsTt3
 i2YMrulq0LPECwgWXGoKrlWMM/ExcygSc3+bw+gBAkKxx7YYLs53QJAgp66VGucjWGrX
 Hm4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZbEyB/B8MebXDnDNebGSwOHPMLtkDkWX1+drH31/Vp/oVJ5SXc3KbNBdd5E+Xr+LXAnmOw8jioajy@nongnu.org
X-Gm-Message-State: AOJu0YxHxdg/zDC4KHnESOs5lL3AYR0vSgKCYY594H0fdTQYLDcblUc/
 0PDqpslVWeiSA/M3hqrQDjw7PcRTU+C/MTiZCV44KhFF47Q4Uo4lvHM8pWDvjeG3DJU=
X-Gm-Gg: ASbGncv462cVMC8m2WTyE/SOaD2MGMkx+eWg+ZnNOwL5Qya1NrZFcOvrv4qHk95caWD
 IdHBbi+9UNT3/Z8LZHfg9baFFDkGz12w1TVZHcpXVq5O/MrhdoQxKxgCxX59lsDC+UWQ84vpRRT
 HEF/FpZwVq31FhdRDJibyyDIJjeYnLmFpnxnprv6xug5YyN4UlPxraoT0fZq1T2tlmahRE/b8dp
 ieu3uJl75blBMLEKNHTmzM8aBCqpExasWIRYD1NowDLvK+/FJxnD3E+W/J3rqdB5HlDjyb+7Yl3
 TbJwuKE8CgewKeyOkTHB17QSGGgNj0XQXJoIDZBPmZJMXKyFE+6UfQbLsftWVslnKbuhBT3rILS
 f8gB3+vhT8kBDq532bVV6KH2qJ4GQh6CCr2nf0aXmLO7daQuOBj5sbg==
X-Google-Smtp-Source: AGHT+IGiTBgQxeNEmWqERms56y9rXFvnzRtkpdJYa0TS8dzbNI4n0oxkeYhR4EfNBacukrCIzqN6zg==
X-Received: by 2002:a05:6a00:4fc3:b0:772:6493:7e77 with SMTP id
 d2e1a72fcca58-77264938033mr4459128b3a.5.1756799461622; 
 Tue, 02 Sep 2025 00:51:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:51:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 6/9] contrib/plugins/uftrace: generate additional files for
 uftrace
Date: Tue,  2 Sep 2025 00:50:39 -0700
Message-ID: <20250902075042.223990-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Beyond traces per cpu, uftrace expect to find some specific files.
- info: contains information about machine/program run
  those values are not impacting uftrace behaviour (only reported by
  uftrace info), and we simply added empty strings.
- memory mapping: how every binary is mapped in memory. For system mode,
  we generate an empty mapping (uftrace_symbols.py, coming in future
  commit, will take care of that). For user mode, we copy current
  /proc/self/maps. We don't need to do any special filtering, as
  reported addresses will necessarily concern guest program, and not
  QEMU and its libraries.
- task: list of tasks. We present every vcpu/privilege level as a
  separate process, as it's the best view we can have when generating a
  (visual) chrome trace. Using threads is less convenient in terms of
  UI.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 131 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 10abad0673c..2386cc723bc 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -118,6 +118,127 @@ static uint64_t gettime_ns(void)
     return now_ns;
 }
 
+static void uftrace_write_map(bool system_emulation)
+{
+    const char *path = "./uftrace.data/sid-0.map";
+
+    if (system_emulation && access(path, F_OK) == 0) {
+        /* do not erase existing map in system emulation, as a custom one might
+         * already have been generated by uftrace_symbols.py */
+        return;
+    }
+
+    FILE *sid_map = fopen(path, "w");
+    g_assert(sid_map);
+
+    if (system_emulation) {
+        fprintf(sid_map,
+                "# map stack on highest address possible, to prevent uftrace\n"
+                "# from considering any kernel address\n");
+        fprintf(sid_map,
+          "ffffffffffff-ffffffffffff rw-p 00000000 00:00 0 [stack]\n");
+    } else {
+        /* in user mode, copy /proc/self/maps instead */
+        FILE *self_map = fopen("/proc/self/maps", "r");
+        g_assert(self_map);
+        for (;;) {
+            int c = fgetc(self_map);
+            if (c == EOF) {
+                break;
+            }
+            fputc(c, sid_map);
+        }
+        fclose(self_map);
+    }
+    fclose(sid_map);
+}
+
+static void uftrace_write_task(const GArray *traces)
+{
+    FILE *task = fopen("./uftrace.data/task.txt", "w");
+    g_assert(task);
+    for (int i = 0; i < traces->len; ++i) {
+        Trace *t = g_array_index(traces, Trace*, i);
+        fprintf(task, "SESS timestamp=0.0 pid=%"PRIu32" sid=0 exename=\"%s\"\n",
+                t->id, t->name->str);
+        fprintf(task, "TASK timestamp=0.0 tid=%"PRIu32" pid=%"PRIu32"\n",
+                t->id, t->id);
+    }
+    fclose(task);
+}
+
+static void uftrace_write_info(const GArray *traces)
+{
+    g_autoptr(GString) taskinfo_tids = g_string_new("taskinfo:tids=");
+    for (int i = 0; i < traces->len; ++i) {
+        Trace *t = g_array_index(traces, Trace*, i);
+        const char *delim = i > 0 ? "," : "";
+        g_string_append_printf(taskinfo_tids, "%s%"PRIu32, delim, t->id);
+    }
+
+    g_autoptr(GString) taskinfo_nr_tid = g_string_new("taskinfo:nr_tid=");
+    g_string_append_printf(taskinfo_nr_tid, "%d", traces->len);
+
+    FILE *info = fopen("./uftrace.data/info", "w");
+    g_assert(info);
+    /*
+     * $ uftrace dump --debug
+     * uftrace file header: magic         = 4674726163652100
+     * uftrace file header: version       = 4
+     * uftrace file header: header size   = 40
+     * uftrace file header: endian        = 1 (little)
+     * uftrace file header: class          = 2 (64 bit)
+     * uftrace file header: features      = 0x1263 (PLTHOOK | ...
+     * uftrace file header: info          = 0x7bff (EXE_NAME | ...
+     *  <0000000000000000>: 46 74 72 61 63 65 21 00  04 00 00 00 28 00 01 02
+     *  <0000000000000010>: 63 12 00 00 00 00 00 00  ff 7b 00 00 00 00 00 00
+     *  <0000000000000020>: 00 04 00 00 00 00 00 00
+     */
+    const uint8_t header[] = {0x46, 0x74, 0x72, 0x61, 0x63, 0x65, 0x21, 0x00,
+                              0x04, 0x00, 0x00, 0x00, 0x28, 0x00, 0x01, 0x02,
+                              0x63, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+                              0xff, 0x7b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+                              0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+    size_t wrote = fwrite(header, sizeof(header), 1, info);
+    g_assert(wrote == 1);
+    const char *info_data[] = {
+        "exename:",
+        "build_id:0000000000000000000000000000000000000000",
+        "exit_status:",
+        "cmdline:",
+        "cpuinfo:lines=2",
+        "cpuinfo:nr_cpus=",
+        "cpuinfo:desc=",
+        "meminfo:",
+        "osinfo:lines=3",
+        "osinfo:kernel=",
+        "osinfo:hostname=",
+        "osinfo:distro=",
+        "taskinfo:lines=2",
+        taskinfo_nr_tid->str,
+        taskinfo_tids->str,
+        "usageinfo:lines=6",
+        "usageinfo:systime=",
+        "usageinfo:usrtime=",
+        "usageinfo:ctxsw=",
+        "usageinfo:maxrss=",
+        "usageinfo:pagefault=",
+        "usageinfo:iops=",
+        "loadinfo:",
+        "record_date:",
+        "elapsed_time:",
+        "pattern_type:regex",
+        "uftrace_version:",
+        "utc_offset:",
+        0};
+    const char **info_data_it = info_data;
+    while (*(info_data_it)) {
+        fprintf(info, "%s\n", *info_data_it);
+        ++info_data_it;
+    }
+    fclose(info);
+}
+
 static Callstack *callstack_new(void)
 {
     Callstack *cs = g_new0(Callstack, 1);
@@ -612,14 +733,22 @@ static void vcpu_end(unsigned int vcpu_index)
 
 static void at_exit(qemu_plugin_id_t id, void *data)
 {
+    bool system_emulation = (bool) data;
+    g_autoptr(GArray) traces = g_array_new(0, 0, sizeof(Trace *));
+
     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
         Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
         for (size_t j = 0; j < cpu->traces->len; ++j) {
             Trace *t = g_array_index(cpu->traces, Trace*, j);
             trace_flush(t, true);
+            g_array_append_val(traces, t);
         }
     }
 
+    uftrace_write_map(system_emulation);
+    uftrace_write_info(traces);
+    uftrace_write_task(traces);
+
     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
         vcpu_end(i);
     }
@@ -656,7 +785,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
-    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
+    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
 
     return 0;
-- 
2.47.2


