Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C38FC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJcM-00007Q-Pi; Fri, 08 Aug 2025 05:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJcK-00006Z-Pv
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:42:28 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJcI-0002vG-B9
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:42:28 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-af9611d8ff7so375107666b.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754646144; x=1755250944; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R+iPGrI1W10VwqMavPY3QRpRS+Aycaj8Qikp2+Sak/k=;
 b=AFn5Zw5K29iaVqtOxGkpEGZlQgHl82hwvmrG3MKybu8N2XHs83q/2JaPTRqgeyIPrR
 kXlTVgfX5fP4gu0oft2yM6Fl/iDda1IxZpBpC7tshgyr2alnGyzETguxLvCSNo3D2u/p
 VRSkrpt0bI58paFDeS4hcXKiOKoIhguIQAIR9Q7TxqmB7BQSRArz6M2dxvJOzLGB83bV
 jTvGH7dCLdkt35xdPcMfjYO8gggItMyOhzWyRCtqffe2DiZ94IR2s1DZjyEZHC7t3vxw
 p3QIHQnftLQcmoU4oHOyfGNMnz9PKq1h5mtMPPRCI0Rl616RT2JD9RRVD+HjrazetcxA
 OwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754646144; x=1755250944;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+iPGrI1W10VwqMavPY3QRpRS+Aycaj8Qikp2+Sak/k=;
 b=kzfVqmxmIxX0oRquZXA0OG23wjsertYqoUs1Id64xFPPJzOmuMQxXWJn0/LPCseaaD
 q27FBzmkNsT2QiGUWy2ity1k3pCqyA1twA6FWXx4AzItiKowsY7ssiluF3qTs2v71yAX
 aA23ZExXOnmLV48/WMCg9J1sLGrZyEdBIMqgq5nAtXx+BkzKRocmOftWmUE0p17DLQCQ
 Dl1Zhh4/pP3lC5xMeblqBvk0xBko2gGMg399/CiHS7QKpRMjbhtwn5VobECjIN6iDfpD
 7uDFa5eYh3me2Q7wqGIn+PRzXoqHSxY+8plNiPNuB/eYgEj2fsz54HIZqmX7TrPyjEN6
 eCpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBf3+B4qZ668ZwtTUVxek0OSap2MqxZkyJcnDHm5pITZfOMoDJJxKiqYyg2HmPFU69aE4lxo5Tioz3@nongnu.org
X-Gm-Message-State: AOJu0YzI4Gmq/hXPmUSHUZGaAU6Z2CLXbGMYF76OgjwHmFwQwoftdPDf
 m9DJMfHBjOQD73ibZtnL5SStenTLERdKk9vNRTtLieuWWzDnDjYh2/RUUoNjP27eP8c=
X-Gm-Gg: ASbGncuFwU14iyNa+xQAKpSZ3ohF4GNxGuLAuHUJ3eWWA01JwQ+HFBWU6pvm2YqSg5F
 8Emc3KlDGbikdSEmIDsd888wvdyAc0YqAAonVeADAXoCja6Y/iHy7GZj4RR4jvN33tDBpqdrdPJ
 pkh3ZO5+pARZ8E+oC77KgOo9HF18KkMQGAwZ01EqYdLlPlF2xnDjEGx0+vcI3NHyylJNz9C5vAG
 vTS4TieOXcDvJMIsak9uWTN9Sv6wqEEtQXpJrllvGReCBKZPxL+a6N3DboZUqdY8ee1u+Bm7sRW
 VIiWIpos5jMxzXMsyVRN9EbZizvEKBfLgngXdL7SfPA6NdNAeVrokl5KL74Bqzyzq9a8tS2yC8g
 Q1P4dH4Q+q1xGNVHrNCua2poqPYgzfi26AE3l8/ycX0WbOYdlgluckm7UIW+Ce1uIRk0e2CQR
X-Google-Smtp-Source: AGHT+IH9+uwwkyoHW+BzPPV/teGV1IOBVT8LU5cT/zTO9BL+S5MNjs8hHUXodQwdfo98S+2EnjZAOQ==
X-Received: by 2002:a17:907:7e9d:b0:af8:fded:6bad with SMTP id
 a640c23a62f3a-af9a3e3e611mr710242866b.18.1754646143882; 
 Fri, 08 Aug 2025 02:42:23 -0700 (PDT)
Received: from meli-email.org (athedsl-4440194.home.otenet.gr.
 [79.129.176.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a218aa3sm1474115466b.93.2025.08.08.02.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:42:23 -0700 (PDT)
Date: Fri, 08 Aug 2025 12:37:24 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 6/9] contrib/plugins/uftrace: generate additional files
 for uftrace
User-Agent: meli/0.8.12
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-7-pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-7-pierrick.bouvier@linaro.org>
Message-ID: <t0o5mm.2toq6tk2xu35q@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>Beyond traces per cpu, uftrace expect to find some specific files.
>- info: contains information about machine/program run
>  those values are not impacting uftrace behaviour, and we simply copied
>  a random example to keep things simple.
>- memory mapping: how every binary is mapped in memory. For system mode,
>  we generate an empty mapping (uftrace_symbols.py, coming in future
>  commit, will take care of that). For user mode, we copy current
>  /proc/self/maps. We don't need to do any special filtering, as
>  reported addresses will necessarily concern guest program, and not
>  QEMU and its libraries.
>- task: list of tasks. We present every vcpu/privilege level as a
>  separate process, as it's the best view we can have when generating a
>  (visual) chrome trace. Using threads is less convenient in terms of
>  UI.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> contrib/plugins/uftrace.c | 130 +++++++++++++++++++++++++++++++++++++-
> 1 file changed, 129 insertions(+), 1 deletion(-)
>
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index 7737626da2f..6628b4256fd 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -115,6 +115,126 @@ static uint64_t gettime_ns(void)
>     return now_ns;
> }
> 
>+static void uftrace_write_map(bool system_emulation)
>+{
>+    const char *path = "./uftrace.data/sid-0.map";
>+
>+    if (system_emulation && access(path, F_OK) == 0) {
>+        /* do not erase existing map in system emulation, as a custom one might
>+         * already have been generated by uftrace_symbols.py */
>+        return;
>+    }
>+
>+    FILE *sid_map = fopen(path, "w");
>+    g_assert(sid_map);
>+
>+    if (system_emulation) {
>+        fprintf(sid_map,
>+                "# map stack on highest address possible, to prevent uftrace\n"
>+                "# from considering any kernel address\n");
>+        fprintf(sid_map,
>+          "ffffffffffff-ffffffffffff rw-p 00000000 00:00 0 [stack]\n");
>+    } else {
>+        /* in user mode, copy /proc/self/maps instead */
>+        FILE *self_map = fopen("/proc/self/maps", "r");
>+        g_assert(self_map);
>+        for (;;) {
>+            int c = fgetc(self_map);
>+            if (c == EOF) {
>+                break;
>+            }
>+            fputc(c, sid_map);
>+        }
>+        fclose(self_map);
>+    }
>+    fclose(sid_map);
>+}
>+
>+static void uftrace_write_task(const GArray *traces)
>+{
>+    FILE *task = fopen("./uftrace.data/task.txt", "w");
>+    g_assert(task);
>+    for (int i = 0; i < traces->len; ++i) {
>+        Trace *t = g_array_index(traces, Trace*, i);
>+        fprintf(task, "SESS timestamp=0.0 pid=%"PRIu32" sid=0 exename=\"%s\"\n",
>+                t->id, t->name->str);
>+        fprintf(task, "TASK timestamp=0.0 tid=%"PRIu32" pid=%"PRIu32"\n",
>+                t->id, t->id);
>+    }
>+    fclose(task);
>+}
>+
>+static void uftrace_write_info(const GArray *traces)
>+{
>+    g_autoptr(GString) taskinfo_tids = g_string_new("taskinfo:tids=");
>+    for (int i = 0; i < traces->len; ++i) {
>+        Trace *t = g_array_index(traces, Trace*, i);
>+        const char *delim = i > 0 ? "," : "";
>+        g_string_append_printf(taskinfo_tids, "%s%"PRIu32, delim, t->id);
>+    }
>+
>+    g_autoptr(GString) taskinfo_nr_tid = g_string_new("taskinfo:nr_tid=");
>+    g_string_append_printf(taskinfo_nr_tid, "%d", traces->len);
>+
>+    FILE *info = fopen("./uftrace.data/info", "w");
>+    g_assert(info);
>+    /*
>+     * $ uftrace dump --debug
>+     * uftrace file header: magic         = 4674726163652100
>+     * uftrace file header: version       = 4
>+     * uftrace file header: header size   = 40
>+     * uftrace file header: endian        = 1 (little)
>+     * uftrace file header: class          = 2 (64 bit)
>+     * uftrace file header: features      = 0x1263 (PLTHOOK | ...
>+     * uftrace file header: info          = 0x7bff (EXE_NAME | ...
>+     *  <0000000000000000>: 46 74 72 61 63 65 21 00  04 00 00 00 28 00 01 02
>+     *  <0000000000000010>: 63 12 00 00 00 00 00 00  ff 7b 00 00 00 00 00 00
>+     *  <0000000000000020>: 00 04 00 00 00 00 00 00
>+     */
>+    const uint8_t header[] = {0x46, 0x74, 0x72, 0x61, 0x63, 0x65, 0x21, 0x00,
>+                              0x04, 0x00, 0x00, 0x00, 0x28, 0x00, 0x01, 0x02,
>+                              0x63, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>+                              0xff, 0x7b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>+                              0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
>+    fwrite(header, sizeof(header), 1, info);
>+    const char *info_data[] = {
>+        "exename:from_qemu",
>+        "build_id:0123456789abcdef0123456789abcdef01234567",
>+        "exit_status:0",
>+        "cmdline:uftrace record qemu",
>+        "cpuinfo:lines=2",
>+        "cpuinfo:nr_cpus=1 / 1 (online/possible)",
>+        "cpuinfo:desc=Intel 8086",

Haha what :D

>+        "meminfo:1.0 / 1.0 GB (free / total)",
>+        "osinfo:lines=3",
>+        "osinfo:kernel=Linux 6.12.33",
>+        "osinfo:hostname=pc",
>+        "osinfo:distro=\"Debian GNU/Linux 13 (trixie)\"",

So I assume these strings can be anything, why not make them blank?

>+        "taskinfo:lines=2",
>+        taskinfo_nr_tid->str,
>+        taskinfo_tids->str,
>+        "usageinfo:lines=6",
>+        "usageinfo:systime=0.000000",
>+        "usageinfo:usrtime=0.000000",
>+        "usageinfo:ctxsw=0 / 0 (voluntary / involuntary)",
>+        "usageinfo:maxrss=8016",
>+        "usageinfo:pagefault=0 / 0 (major / minor)",
>+        "usageinfo:iops=0 / 0 (read / write)",
>+        "loadinfo:0.0 / 0.0 / 0.0",
>+        "record_date:Mon Jan  1 00:00:00 2025",
>+        "elapsed_time:1000000000000.0 sec",
>+        "pattern_type:regex",
>+        "uftrace_version:v0.17 ( x86_64 dwarf python3 luajit tui perf sched dynamic kernel )",
>+        "utc_offset:1751552954",
>+        0};
>+    const char **info_data_it = info_data;
>+    while (*(info_data_it)) {
>+        fprintf(info, "%s\n", *info_data_it);
>+        ++info_data_it;
>+    }
>+    fclose(info);
>+}
>+
> static Callstack *callstack_new(void)
> {
>     Callstack *cs = g_new0(Callstack, 1);
>@@ -607,14 +727,22 @@ static void vcpu_end(unsigned int vcpu_index)
> 
> static void at_exit(qemu_plugin_id_t id, void *data)
> {
>+    bool system_emulation = (bool) data;
>+    g_autoptr(GArray) traces = g_array_new(0, 0, sizeof(Trace *));
>+
>     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>         Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
>         for (size_t j = 0; j < cpu->traces->len; ++j) {
>             Trace *t = g_array_index(cpu->traces, Trace*, j);
>             trace_flush(t, true);
>+            g_array_append_val(traces, t);
>         }
>     }
> 
>+    uftrace_write_map(system_emulation);
>+    uftrace_write_info(traces);
>+    uftrace_write_task(traces);
>+
>     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>         vcpu_end(i);
>     }
>@@ -651,7 +779,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>-    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
>+    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> 
>     return 0;
>-- 
>2.47.2
>

LGTM,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

