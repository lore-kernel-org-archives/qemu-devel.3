Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411C9C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 13:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tax87-000817-4y; Thu, 23 Jan 2025 08:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tax7z-0007zq-TI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:20:13 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tax7x-0002HO-3g
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:20:11 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c00:2790:0:640:fde4:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CC63D6093B;
 Thu, 23 Jan 2025 16:20:05 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b702::1:22])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sJYg2w0IhCg0-ldIjOdzD; Thu, 23 Jan 2025 16:20:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1737638405;
 bh=YdDWouU7plxoJefphNtrnfuFE3KsAiVu+5cDa+HTFtQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=g5rhQo4+QFDaUHdeZJ5ZD/J9BbbCu48PUaots1RBg0yYdFbzoejg0m5AaKkeb/8sn
 rfmUQKpf1V37rjPOutd4ul+qksawhPnQ+c8eP9cjFK68/v7o5FF74hxsOGlMJFiesZ
 eaZYHrQdWtBWCp7VtzviA6SQ5s1bH90CjrbOW8bo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v4 4/4] overcommit: introduce mem-lock=on-fault
Date: Thu, 23 Jan 2025 16:19:44 +0300
Message-Id: <20250123131944.391886-5-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
References: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Locking the memory without MCL_ONFAULT instantly prefaults any mmaped
anonymous memory with a write-fault, which introduces a lot of extra
overhead in terms of memory usage when all you want to do is to prevent
kcompactd from migrating and compacting QEMU pages. Add an option to
only lock pages lazily as they're faulted by the process by using
MCL_ONFAULT if asked.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 include/system/system.h  |  2 ++
 migration/postcopy-ram.c |  2 +-
 qemu-options.hx          | 14 +++++++++-----
 system/globals.c         |  7 ++++++-
 system/vl.c              | 34 +++++++++++++++++++++++++++-------
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/system/system.h b/include/system/system.h
index dc7628357a..a7effe7dfd 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -50,9 +50,11 @@ extern QEMUClockType rtc_clock;
 typedef enum {
     MLOCK_OFF = 0,
     MLOCK_ON,
+    MLOCK_ON_FAULT,
 } MlockState;
 
 bool should_mlock(MlockState);
+bool is_mlock_on_fault(MlockState);
 
 extern MlockState mlock_state;
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 04068ee039..5d3edfcfec 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -652,7 +652,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     if (should_mlock(mlock_state)) {
-        if (os_mlock(false) < 0) {
+        if (os_mlock(is_mlock_on_fault(mlock_state)) < 0) {
             error_report("mlock: %s", strerror(errno));
             /*
              * It doesn't feel right to fail at this point, we have a valid
diff --git a/qemu-options.hx b/qemu-options.hx
index 7090d59f6f..fed5cfb130 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4573,21 +4573,25 @@ SRST
 ERST
 
 DEF("overcommit", HAS_ARG, QEMU_OPTION_overcommit,
-    "-overcommit [mem-lock=on|off][cpu-pm=on|off]\n"
+    "-overcommit [mem-lock=on|off|on-fault][cpu-pm=on|off]\n"
     "                run qemu with overcommit hints\n"
-    "                mem-lock=on|off controls memory lock support (default: off)\n"
+    "                mem-lock=on|off|on-fault controls memory lock support (default: off)\n"
     "                cpu-pm=on|off controls cpu power management (default: off)\n",
     QEMU_ARCH_ALL)
 SRST
-``-overcommit mem-lock=on|off``
+``-overcommit mem-lock=on|off|on-fault``
   \ 
 ``-overcommit cpu-pm=on|off``
     Run qemu with hints about host resource overcommit. The default is
     to assume that host overcommits all resources.
 
     Locking qemu and guest memory can be enabled via ``mem-lock=on``
-    (disabled by default). This works when host memory is not
-    overcommitted and reduces the worst-case latency for guest.
+    or ``mem-lock=on-fault`` (disabled by default). This works when
+    host memory is not overcommitted and reduces the worst-case latency for
+    guest. The on-fault option is better for reducing the memory footprint
+    since it makes allocations lazy, but the pages still get locked in place
+    once faulted by the guest or QEMU. Note that the two options are mutually
+    exclusive.
 
     Guest ability to manage power state of host cpus (increasing latency
     for other processes on the same host cpu, but decreasing latency for
diff --git a/system/globals.c b/system/globals.c
index adeff38348..316623bd20 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -33,7 +33,12 @@
 
 bool should_mlock(MlockState state)
 {
-    return state == MLOCK_ON;
+    return state == MLOCK_ON || state == MLOCK_ON_FAULT;
+}
+
+bool is_mlock_on_fault(MlockState state)
+{
+    return state == MLOCK_ON_FAULT;
 }
 
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
diff --git a/system/vl.c b/system/vl.c
index c26d728e22..19a5df7870 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -347,7 +347,7 @@ static QemuOptsList qemu_overcommit_opts = {
     .desc = {
         {
             .name = "mem-lock",
-            .type = QEMU_OPT_BOOL,
+            .type = QEMU_OPT_STRING,
         },
         {
             .name = "cpu-pm",
@@ -793,7 +793,7 @@ static QemuOptsList qemu_run_with_opts = {
 static void realtime_init(void)
 {
     if (should_mlock(mlock_state)) {
-        if (os_mlock(false) < 0) {
+        if (os_mlock(is_mlock_on_fault(mlock_state)) < 0) {
             error_report("locking memory failed");
             exit(1);
         }
@@ -1850,7 +1850,7 @@ static void object_option_parse(const char *str)
 static void overcommit_parse(const char *str)
 {
     QemuOpts *opts;
-    bool enable_mlock;
+    const char *mem_lock_opt;
 
     opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
                                    str, false);
@@ -1858,11 +1858,31 @@ static void overcommit_parse(const char *str)
         exit(1);
     }
 
-    enable_mlock = qemu_opt_get_bool(opts, "mem-lock",
-                                     should_mlock(mlock_state));
-    mlock_state = enable_mlock ? MLOCK_ON : MLOCK_OFF;
-
     enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
+
+    mem_lock_opt = qemu_opt_get(opts, "mem-lock");
+    if (!mem_lock_opt) {
+        return;
+    }
+
+    if (strcmp(mem_lock_opt, "on") == 0) {
+        mlock_state = MLOCK_ON;
+        return;
+    }
+
+    if (strcmp(mem_lock_opt, "off") == 0) {
+        mlock_state = MLOCK_OFF;
+        return;
+    }
+
+    if (strcmp(mem_lock_opt, "on-fault") == 0) {
+        mlock_state = MLOCK_ON_FAULT;
+        return;
+    }
+
+    error_report("parameter 'mem-lock' expects one of "
+                 "'on', 'off', 'on-fault'");
+    exit(1);
 }
 
 /*
-- 
2.34.1


