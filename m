Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBDFC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zrw-0001IZ-E5; Tue, 15 Sep 2026 16:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrv-0001IC-Cx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:07 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrt-0005at-B4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:07 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so1666375e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504504; x=1790109304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ya2xkpYj9xYatRBnkZU7QVEc+GAEhygQYkVwKQ4DXdc=;
 b=HObJrGy+b/d2LZUullOF0UbDmnHMi2OPJmOgiVBTxj2xlVc8bMsPKJ804UhCQTNpX5
 ak/VTAeGZY939b8GXSxR87umR1vKtOyVnLhp8Q8W0ZhaD8Akf85t+CyBV4RMjG1wkUXr
 iGHEHK4p8kEzPdyYt7XNTXJw5M/1BoKdiLdTcxKh90BkKhkmbBx3kcDWk+NSHc4vKLwj
 s7HR47fyIQDK94dJDg8h2Uevt5p7+/ohu+ed5QuR7Ey7jwEWesP3FgnHtb1ee4fz7LO5
 5OUDQyERJNTYomqI6TY8bMH2TmyeVY4gSis0JPPm5JS/03uQcuVfBZVsd6q3EBK8agyC
 v9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504504; x=1790109304;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ya2xkpYj9xYatRBnkZU7QVEc+GAEhygQYkVwKQ4DXdc=;
 b=CI1wzuEqN+tamB+rnYvNdlTDghHBEir2iffdJydQ3DOqelmXW/tGMi4ovA1KdRLEzL
 N7TNng2e04yGPs8tpKVUZfMCJDEajZPRCw+E7bm5VecOH5C+zT+bDYQ2uchtzT1pQygc
 q0Cfv2i9gAnzKb9cg9OXUWN+uEesSQ/XBmfZHev/qKRiRrBY8rag3f6swnqsBcyAcJ5Y
 7huHwzzrMacd3ffhvKGMV3DcabpDsZYkydhpfu+2DKwEJDLlXsx9jvc2ZdCe96NTigQZ
 98EEqjrsMRUsiY63pGElOCy7EeVK71ik35gY7dCjuXeeckHAhonGwAm/fx/9CmXAIycl
 mmVA==
X-Gm-Message-State: AFuF++l6MbOcwAe5z17WJy8+VDqsLyMBOyYY/dmth9sZ3DdSJSl2b2ac
 rdtrxMGXtzGEb79YqcEeqkbFfh3KOKahN0ZUubwN6EbjpMvDmrMrCvBdm30AVMR686NQHkZvARt
 V6r+g
X-Gm-Gg: AYBFou3GAO0l/bCePmjPe7BlQmKfcdnPnU52H2XBnFcRrOB5f8sH3Jdi2U5OHPzr5z0
 4RrOWG9LN97URTdXfrPLLAhODQFylzrN3mjfFMapFOx3MQa7MC8L8KIonpixeZKJp9Q63oE1v4I
 fmFfsyEwTz4KuprB/PuisB83To9wuj3jTm5ETtr9kKItiqxoD0AtXtEiQJPS3s1xZKe9HeQxov9
 HR9FKGNkEbyGX+UfsE2cIEq4vW0L4iavt5blkVgb60AbziDN5nehDMKqfKSavnhgZvjxDKzwo1I
 6fDV6veaGhw9PdzJeSMfObDFmyHair7MI4HUWfqMVKNsLs8pCV6B+TfpYLkbdW7kwUAn5ByOpg7
 3G0SfjubAeENiWNWpRjLwVJWr0wOIEeed6XqwHhvna3Sph12iWce7xfdhYHhZdFBcBc50OwmKnE
 FupuilPq1Y2g2OUbQxo4lsPYCcGhOHKvgiPACTPWos3kfZNs4SrmWBDxvOz0bMrPclRusA
X-Received: by 2002:a05:6000:25f4:b0:487:999:9ad9 with SMTP id
 ffacd0b85a97d-4870d26f060mr132045f8f.52.1789504503970; 
 Tue, 15 Sep 2026 13:35:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH 03/10] oslib: add qemu_thread_states()
Date: Tue, 15 Sep 2026 22:34:47 +0200
Message-ID: <20260915203455.580999-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
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

A watchdog that reports a hang wants to say what every thread was doing,
and that answer is host specific. Put it beside the other process
introspection helpers rather than in the code that happens to need it
first.

Describe each thread by id, name, scheduler state and the wait channel
it is parked on, all of which Linux exposes in /proc/self/task without
privilege. That is already enough to separate a thread blocked on a
userspace lock, which waits in a futex, from one blocked in the kernel,
which names the primitive it sits on. Skip the caller, which is
reporting rather than hanging.

Hosts with no way to answer return NULL, leaving the caller to print
its own message and nothing more.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 include/qemu/osdep.h | 10 +++++++
 util/oslib-posix.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++
 util/oslib-win32.c   |  5 ++++
 3 files changed, 86 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 96afe09632..8039bf91b8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -667,6 +667,16 @@ int qemu_get_thread_id(void);
  */
 bool qemu_debugger_attached(void);
 
+/**
+ * qemu_thread_states:
+ *
+ * Returns a newly allocated, newline terminated description of every thread
+ * in this process apart from the caller: its id, name, scheduler state and
+ * the wait channel it is parked on, or NULL on a host that cannot report any
+ * of that.
+ */
+char *qemu_thread_states(void);
+
 /**
  * qemu_kill_thread:
  * @tid: thread id.
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4eb6a40628..79887d370c 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -134,6 +134,77 @@ bool qemu_debugger_attached(void)
 #endif
 }
 
+#ifdef CONFIG_LINUX
+
+static char *read_task_file(const char *tid, const char *name)
+{
+    g_autofree char *path = g_strdup_printf("/proc/self/task/%s/%s", tid, name);
+    char *buf = NULL;
+
+    g_file_get_contents(path, &buf, NULL, NULL);
+    return buf;
+}
+
+static void append_thread_state(GString *out, const char *tid)
+{
+    g_autofree char *comm = read_task_file(tid, "comm");
+    g_autofree char *stat = NULL;
+    g_autofree char *wchan = NULL;
+    char state = '?';
+    char *rparen;
+
+    if (!comm) {
+        return;
+    }
+    g_strchomp(comm);
+
+    stat = read_task_file(tid, "stat");
+    if (stat) {
+        /* comm can hold anything, ')' included, so scan from the right */
+        rparen = strrchr(stat, ')');
+        if (rparen && rparen[1] == ' ') {
+            state = rparen[2];
+        }
+    }
+    g_string_append_printf(out, "  %-7s %-16s %c\n", tid, comm, state);
+
+    wchan = read_task_file(tid, "wchan");
+    if (wchan && wchan[0]) {
+        g_string_append_printf(out, "      wchan %s\n", wchan);
+    }
+}
+
+char *qemu_thread_states(void)
+{
+    g_autoptr(GDir) dir = g_dir_open("/proc/self/task", 0, NULL);
+    const char *tid;
+    GString *out;
+
+    if (!dir) {
+        return NULL;
+    }
+    out = g_string_new(NULL);
+    while ((tid = g_dir_read_name(dir))) {
+        if (atoi(tid) != qemu_get_thread_id()) {
+            append_thread_state(out, tid);
+        }
+    }
+    if (!out->len) {
+        g_string_free(out, TRUE);
+        return NULL;
+    }
+    return g_string_free(out, FALSE);
+}
+
+#else
+
+char *qemu_thread_states(void)
+{
+    return NULL;
+}
+
+#endif /* CONFIG_LINUX */
+
 int qemu_kill_thread(int tid, int sig)
 {
 #if defined(__linux__)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 6663d83151..d18886847c 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -233,6 +233,11 @@ bool qemu_debugger_attached(void)
     return IsDebuggerPresent();
 }
 
+char *qemu_thread_states(void)
+{
+    return NULL;
+}
+
 char *
 qemu_get_local_state_dir(void)
 {
-- 
2.53.0


