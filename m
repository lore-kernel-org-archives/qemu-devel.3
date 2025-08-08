Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB92C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTus-000308-Uq; Fri, 08 Aug 2025 16:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTur-0002yV-4A
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:17 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTuo-0003DO-PB
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:16 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso29792755ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685733; x=1755290533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qof9Qj78VVSEid4N6FOGHfZkZXIU0Ub5qskH0ZkOHjU=;
 b=UrsuynZ2vwS+m1TJa43As9CYaX5v3PD00pkVGT31sXa/LgCpoGFgR07tHcSMuxatAk
 RJC7ghU/teH2SiKoXx2Arv78asYsawcXoRGcCeh3LjbhMFAZaX6CltTUikFz/Nms65Cl
 zbkPHOOWwQ1i5d1z6keRMIVV2m3eM2xPFcFZR7+yCUQLcdCoVVnZ+TePmTgTYcl/bfLC
 Ha1Ua8LKEjd3eupUdT74kjqh1mkPnnm2ij0NKE00rjbeW644wbUDEHrDRwHvHkzvsADu
 1mvsS8HN2nrmsghAXw5M79ZUuc+c+CPc7oLDFIO/Ok/EkeEhkZrVBR67rFv3Bpl5Smpe
 /LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685733; x=1755290533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qof9Qj78VVSEid4N6FOGHfZkZXIU0Ub5qskH0ZkOHjU=;
 b=CjQJEdLpaxbz0Hn5dVdSw8099wgL/ohbKAdLZkF9VKR3K83geuKDRG6TtVNLMNTkVl
 wYpYk+zTIfhknUCw5QiwDHSW8wl+cRtBIqDPJT3FXCbRB6uw9BESIFj3V4g9QqiN9QOV
 BpZ8Dp/qX76kUK5xLNwm6M++BwRhXd9NIOnaeuydHkNxWlRrB8UdIChzzKQX37wDZkSj
 E1yZiSOBZrLHPK3zs/90zcwdoMzEqhIEg4q2WHvGODHNPqFS4jI8gDUU3Gh0AOM2+G8V
 CocHe4HaieDn/C7sy9pihYhA092bCrklgC+ICAqYwOF/Pz0+GtinTcYQTe7zKUYATpqO
 /kiQ==
X-Gm-Message-State: AOJu0YzwsjVjiDU7Sid+VtZK8MuST8WNS+uA5oGGP6zjRsrJE0yLl98V
 LycSWkfsfj6dx5dptCna7v8hZZduSdJIgliS4md5WaeNSs98grHGCrjVmdXn45m0kQG20UlkuyD
 mrbPfteDkvg==
X-Gm-Gg: ASbGncuETAfy1BLvXlZnZ6R4H5EwZXR4beu7gRaFtf+65tsBst8T4Ml7hfxTtnhI70t
 C7CASGC76eODzyRxDAv5YVbRVOi2us5q3KojPZLhr1SeCLkPiV1D/FivhYKDL8JWpGVi8bpHHYQ
 1dxI7APPjqQRBHQlYBYnOtS2CJZEfdE3ieUkeJJsMapS+eQ/zv4NmYMe7x8AtqpUxO0NZzbadeJ
 ygk+6gfR3egr2xDYxtYuqSM46tTr6TBWUkS54obKqBu7UT1gbTPBfcux780q1U8+TrK6TcTn9JL
 B14u+v/iOx7VvhyY4Bkra2szn++mJofE5Tr0/AAClFcm96U4r0DBKtZEpF1/ZJfJo5Co92euBj5
 zN3+kxpNXYWNoNAwJBi3yNJECEujj7vLH
X-Google-Smtp-Source: AGHT+IGKygQORO9yAFr0wkyzD+psRcNYqUfG2u3yqCb36r3HaWeW8WYcW599TRN7Iy0SP/pXu/IPeA==
X-Received: by 2002:a17:903:2b06:b0:242:9be2:f67a with SMTP id
 d9443c01a7336-242c1fdce56mr64910355ad.11.1754685732695; 
 Fri, 08 Aug 2025 13:42:12 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a814sm217789945ad.117.2025.08.08.13.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 13:42:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org,
	pierrick.bouvier@linaro.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 6/9] contrib/plugins/uftrace: generate additional files for
 uftrace
Date: Fri,  8 Aug 2025 13:41:53 -0700
Message-ID: <20250808204156.659715-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
index fa95341b8b9..290e40ee390 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -116,6 +116,127 @@ static uint64_t gettime_ns(void)
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
@@ -610,14 +731,22 @@ static void vcpu_end(unsigned int vcpu_index)
 
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
@@ -654,7 +783,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
-    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
+    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
 
     return 0;
-- 
2.47.2


