Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095EBC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCVy-0008GA-Fz; Thu, 07 Aug 2025 22:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVt-00087n-8E
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:23 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVq-0003Uh-AP
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:20 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-32129c4e9a4so1486382a91.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618835; x=1755223635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XhHp4ICBhZSJpQEoZ4selXDuu2CQ0EBUbhnnEXKkzM=;
 b=EaXlO9dcbqHjqh0AIoxEKpX0iSPdLFaH+eQmcFcvEnUX3gHUfTuIrMArSuTPpDZKV2
 JI53iFKRfxjtciwlb11+UvQMRxgEar0wMepBtt5EefSAciWIcPHNVDL16b3RfGR9OLE8
 Ns7iBVpn17vIaphVYuTRVe88DHiZDTX6mpX6MRfQAucSEEYCUutIwZ3rIE2kRWTYqcVP
 s4lsN0vjfRPhid1+6CkFQgFfciPGAk4mqAkmC4qbu+j4rikOkEUbh4IhjXiMsTRtswYe
 IZzpAK4tbQ0YhqGPXMj5NUlj4gsJ9tELNfF2i6vVGOLgX6u//KqdAU5lxRyr2Xvbj9aG
 GIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618835; x=1755223635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XhHp4ICBhZSJpQEoZ4selXDuu2CQ0EBUbhnnEXKkzM=;
 b=OFM83ojMj6IUFbr0bt4g6CQ2dhsfjeZLBZ2v4M9Xhwc3tveWvWxItXHq8x36E7WLS+
 SLb/wV+DV8vbfuDyVzQvNxQR0e6ey8fT03TVZySM6CShY9SizmyQuFlYJpifIJfcoEfk
 UX8MzctI2qJ83BW7gV63Zo2VgGRFQc7sNEk5Yz6htYliEb2mokiymBCWphYLfo46cX+L
 I8w87dFI0+BMl1f9kOI+Ib4DbUCPMQYCK4cvioPGyWARw4qQUQgQVWYpXazFO0ZQgWFD
 Y7O7OhENPx+yZdIN0FKpi4EMiHglkK6hhHGoStNZNs9ZAQrFd4H8zesPN18PEACh44xq
 p7dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX/O5pPWEJowi42LYVrwzSvMwQWr8IaC/HcPqmn7z7kSyBs+IkpEQ2b0STtaFiJ6JQT5eTXHq88p0b@nongnu.org
X-Gm-Message-State: AOJu0Yy3ZWgUJXSGaofjalwCFbnfB3XhVldoWhyLlO8L4hsbjhgqa4Em
 GY+IPgfQzp1OkgA7SwTamgTjPxQQV3DtLVUaGAy3MR0kH9HcQF9vodigvKfasK6M9r8=
X-Gm-Gg: ASbGnctc5chmskMjg+c97dk9/dIlLgOURX8fjUeYCqjhRuydbdiKJo6cPghIgcwfeXt
 EdedMDobbpu7Rc67R8haYD9GXCB2DNFmEKfHh6ciwhkA1Tl6SZmSjjfmBIBG1CJj7dGaU1+SHcd
 jtxLPZX+ptojYRwWdBc2eGkysArHfu9capD+aT8CE5bCOiJP3MMP0T9M06pnSl4XCRm21r17f37
 WTPbiyxsdtVoFxyKKtkVQ65bSDOomyE0sPhK5j+2DwyLfAcPd5l2ass68VQr0/QFxcV57FcqhoH
 zkLqKtRsG5j9VD8x5kHrBDUrbtQOciztaPA73cw5XLqKgaaw0FXPTnldBV5skG4uXFHM6dyOHC0
 eI1DXTIHSNnZgBaFcmlSg6Q==
X-Google-Smtp-Source: AGHT+IEo4NbfBL4sQ1pkIKyfPFTDOzxAVZRDrLqP+SKbmFYHLVSJzcS3A4Ubx9XAAzfqCH1HdV7HOw==
X-Received: by 2002:a17:90b:3d8f:b0:31f:2bd7:a4d2 with SMTP id
 98e67ed59e1d1-32183e82581mr1845756a91.35.1754618835044; 
 Thu, 07 Aug 2025 19:07:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 6/9] contrib/plugins/uftrace: generate additional files for
 uftrace
Date: Thu,  7 Aug 2025 19:06:59 -0700
Message-ID: <20250808020702.410109-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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
  those values are not impacting uftrace behaviour, and we simply copied
  a random example to keep things simple.
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 130 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 7737626da2f..6628b4256fd 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -115,6 +115,126 @@ static uint64_t gettime_ns(void)
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
+    fwrite(header, sizeof(header), 1, info);
+    const char *info_data[] = {
+        "exename:from_qemu",
+        "build_id:0123456789abcdef0123456789abcdef01234567",
+        "exit_status:0",
+        "cmdline:uftrace record qemu",
+        "cpuinfo:lines=2",
+        "cpuinfo:nr_cpus=1 / 1 (online/possible)",
+        "cpuinfo:desc=Intel 8086",
+        "meminfo:1.0 / 1.0 GB (free / total)",
+        "osinfo:lines=3",
+        "osinfo:kernel=Linux 6.12.33",
+        "osinfo:hostname=pc",
+        "osinfo:distro=\"Debian GNU/Linux 13 (trixie)\"",
+        "taskinfo:lines=2",
+        taskinfo_nr_tid->str,
+        taskinfo_tids->str,
+        "usageinfo:lines=6",
+        "usageinfo:systime=0.000000",
+        "usageinfo:usrtime=0.000000",
+        "usageinfo:ctxsw=0 / 0 (voluntary / involuntary)",
+        "usageinfo:maxrss=8016",
+        "usageinfo:pagefault=0 / 0 (major / minor)",
+        "usageinfo:iops=0 / 0 (read / write)",
+        "loadinfo:0.0 / 0.0 / 0.0",
+        "record_date:Mon Jan  1 00:00:00 2025",
+        "elapsed_time:1000000000000.0 sec",
+        "pattern_type:regex",
+        "uftrace_version:v0.17 ( x86_64 dwarf python3 luajit tui perf sched dynamic kernel )",
+        "utc_offset:1751552954",
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
@@ -607,14 +727,22 @@ static void vcpu_end(unsigned int vcpu_index)
 
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
@@ -651,7 +779,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
-    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
+    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
 
     return 0;
-- 
2.47.2


