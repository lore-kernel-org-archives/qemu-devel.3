Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DFCE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVlR-0003gb-78; Wed, 11 Dec 2024 18:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLVlP-0003cK-DV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:05:03 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLVlN-0002PE-FV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:05:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:5829:0:640:f281:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 09BA461469;
 Thu, 12 Dec 2024 02:05:00 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:1227::1:8])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id b4xnrS4GamI0-SfRKyy5U; Thu, 12 Dec 2024 02:04:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733958299;
 bh=iXA0q1LrDfFbZ3l1Q1sy8O/HmyRUyKkBL+GNkwDF21I=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=bzjF60smxb20INGXB61lPQoGcXMyCYvh5WzEfhNS004S5zBIADPCgK+0NAp1ntc57
 3zAjRnHXNCzgUoBvp0IqvI5FJWiUYc+uMljqcRfdXYr5vm9rKZgNCDLj6aPQngraCi
 +oNUH1+Widjn6tlbtq7r74q/WfE6kIpDyskyvL8I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] overcommit: introduce mem-lock=on-fault
Date: Thu, 12 Dec 2024 02:04:33 +0300
Message-Id: <20241211230433.1371327-5-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Locking the memory without MCL_ONFAULT instantly prefaults any mmaped
anonymous memory with a write-fault, which introduces a lot of extra
overhead in terms of memory usage when all you want to do is to prevent
kcompactd from migrating and compacting QEMU pages. Add an option to
only lock pages lazily as they're faulted by the process by using
MCL_ONFAULT if asked.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 include/sysemu/sysemu.h  |  2 ++
 migration/postcopy-ram.c |  2 +-
 qemu-options.hx          | 14 +++++++++-----
 system/globals.c         |  7 ++++++-
 system/vl.c              | 34 +++++++++++++++++++++++++++-------
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index f1c9895057..9834038e8a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -49,9 +49,11 @@ extern QEMUClockType rtc_clock;
 typedef enum {
     MLOCK_OFF = 0,
     MLOCK_ON,
+    MLOCK_ON_FAULT,
 } MlockState;
 
 bool should_mlock(MlockState);
+bool is_mlock_on_fault(MlockState);
 
 extern MlockState mlock_state;
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a6a26a9cbb..fe396b8ff3 100644
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
index dacc9790a4..6c8360e62e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4566,21 +4566,25 @@ SRST
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
index c6452d4a0d..e04d6f57ec 100644
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
index a41306ac84..b1fdb71a9e 100644
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
@@ -1858,7 +1858,7 @@ static void object_option_parse(const char *str)
 static void overcommit_parse(const char *str)
 {
     QemuOpts *opts;
-    bool enable_mlock;
+    const char *mem_lock_opt;
 
     opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
                                    str, false);
@@ -1866,11 +1866,31 @@ static void overcommit_parse(const char *str)
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


