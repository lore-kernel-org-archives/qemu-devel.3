Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5427DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFEB-0000yY-9P; Mon, 18 Mar 2024 11:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFE8-0000ks-Vw
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:41 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDz-000809-Vs
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:40 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c37af44dcbso1713885b6e.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776908; x=1711381708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiDAmOnmWT4ekrWuB2ITbU/+cCjo/0GhwwVWCJ90GMA=;
 b=iiVrYLbq7NxMwFBuajV3OePao5hJ9moGchCBpvLCkGQopNut9c+YZgSEfx6AGhgobD
 h5tCZ7Inh4GLOEpAQZEMzP1fgJpsreTQf/GMdN9cTsSzSYqWPzTqYefpGcqBvi+dUGrV
 6c6bVIKXGjrJ8EhqIE898T1iYYlDsOqGZz8XtsMegGFtnuns17QhNErtJAn027MJRMtJ
 Ey+TKScs04EN1c43YoR/19kCEViAfJI8IPhzHRCsCRp93lIhpRu5Ejg8xMaZ5kypLtG7
 xxWcmAmmnZwGOBh32FXUeisDgQmnatw2nmd+16FcuSFOVcovopH6DgMc09wFmy7hMXzJ
 01cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776908; x=1711381708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiDAmOnmWT4ekrWuB2ITbU/+cCjo/0GhwwVWCJ90GMA=;
 b=r4gT0pblNs+SRTtcqxl7/FVmwMzr+OokfkyXONjKfqkjz8DEvLyHzibo2220ySC6Er
 aoxfob/K8EgcSjxbkAkqNGAeH5QOlyQ3lJ3RM0G5VukCSR89z8q46BoSKy5X83QvW7xa
 2SIiqX4dbI4uKzWpqLtHNuS2osqDrKs1df5FGndeO8UqfN/KqXDZyRF6jvEKyAY24Ypu
 k2yI/XZ+wrNJr8GDUQq2eeTYF+JlhOgDMap0eUBsXklRYgDvcfhUO6vofDeA+u8iXe4s
 Pwtnq2Ox1HZFnBBgR+qv2xsxFSJJ9D38CNVOPKUDGn4Oud+yTUlkKd2tsk/5cVdsMX1B
 QBww==
X-Gm-Message-State: AOJu0YzXzZEqUmLfQ4mkcIA5VbcQMZRcdsrZuuTOuFBagJ5naI69S+w5
 ME9YGOYCpbLpIkOtSiLj7LIhuJHt1cjMkj75/cjqSooZMuu8ektKIWFI50cTDqY=
X-Google-Smtp-Source: AGHT+IGeaApjV32xwbtP1EsJ30sONIG0xua+WZd5or9j2JP5SH9MQ9HdVJAxEy4J9htvqYnfLbICpA==
X-Received: by 2002:a05:6871:7981:b0:220:e608:89c with SMTP id
 pb1-20020a056871798100b00220e608089cmr14584816oac.28.1710776908370; 
 Mon, 18 Mar 2024 08:48:28 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 20/24] replay: simple auto-snapshot mode for record
Date: Tue, 19 Mar 2024 01:46:17 +1000
Message-ID: <20240318154621.2361161-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

record makes an initial snapshot when the machine is created, to enable
reverse-debugging. Often the issue being debugged appears near the end of
the trace, so it is important for performance to keep snapshots close to
the end.

This implements a periodic snapshot mode that keeps a rolling set of
recent snapshots. This could be done by the debugger or other program
that talks QMP, but for setting up simple scenarios and tests, this is
more convenient.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/system/replay.rst   |  5 ++++
 include/sysemu/replay.h  | 11 ++++++++
 replay/replay-snapshot.c | 57 ++++++++++++++++++++++++++++++++++++++++
 replay/replay.c          | 27 +++++++++++++++++--
 system/vl.c              |  9 +++++++
 qemu-options.hx          |  9 +++++--
 6 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/docs/system/replay.rst b/docs/system/replay.rst
index ca7c17c63d..1ae8614475 100644
--- a/docs/system/replay.rst
+++ b/docs/system/replay.rst
@@ -156,6 +156,11 @@ for storing VM snapshots. Here is the example of the command line for this:
 ``empty.qcow2`` drive does not connected to any virtual block device and used
 for VM snapshots only.
 
+``rrsnapmode`` can be used to select just an initial snapshot or periodic
+snapshots, with ``rrsnapcount`` specifying the number of periodic snapshots
+to maintain, and ``rrsnaptime`` the amount of run time in seconds between
+periodic snapshots.
+
 .. _network-label:
 
 Network devices
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 8102fa54f0..92fa82842b 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -48,6 +48,17 @@ typedef enum ReplayCheckpoint ReplayCheckpoint;
 
 typedef struct ReplayNetState ReplayNetState;
 
+enum ReplaySnapshotMode {
+    REPLAY_SNAPSHOT_MODE_INITIAL,
+    REPLAY_SNAPSHOT_MODE_PERIODIC,
+};
+typedef enum ReplaySnapshotMode ReplaySnapshotMode;
+
+extern ReplaySnapshotMode replay_snapshot_mode;
+
+extern uint64_t replay_snapshot_periodic_delay;
+extern int replay_snapshot_periodic_nr_keep;
+
 /* Name of the initial VM snapshot */
 extern char *replay_snapshot;
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index ccb4d89dda..762555feaa 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -70,6 +70,53 @@ void replay_vmstate_register(void)
     vmstate_register(NULL, 0, &vmstate_replay, &replay_state);
 }
 
+static QEMUTimer *replay_snapshot_timer;
+static int replay_snapshot_count;
+
+static void replay_snapshot_timer_cb(void *opaque)
+{
+    Error *err = NULL;
+    char *name;
+
+    if (!replay_can_snapshot()) {
+        /* Try again soon */
+        timer_mod(replay_snapshot_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                  replay_snapshot_periodic_delay / 10);
+        return;
+    }
+
+    name = g_strdup_printf("%s-%d", replay_snapshot, replay_snapshot_count);
+    if (!save_snapshot(name,
+                       true, NULL, false, NULL, &err)) {
+        error_report_err(err);
+        error_report("Could not create periodic snapshot "
+                     "for icount record, disabling");
+        g_free(name);
+        return;
+    }
+    g_free(name);
+    replay_snapshot_count++;
+
+    if (replay_snapshot_periodic_nr_keep >= 1 &&
+        replay_snapshot_count > replay_snapshot_periodic_nr_keep) {
+        int del_nr;
+
+        del_nr = replay_snapshot_count - replay_snapshot_periodic_nr_keep - 1;
+        name = g_strdup_printf("%s-%d", replay_snapshot, del_nr);
+        if (!delete_snapshot(name, false, NULL, &err)) {
+            error_report_err(err);
+            error_report("Could not delete periodic snapshot "
+                         "for icount record");
+        }
+        g_free(name);
+    }
+
+    timer_mod(replay_snapshot_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+              replay_snapshot_periodic_delay);
+}
+
 void replay_vmstate_init(void)
 {
     Error *err = NULL;
@@ -82,6 +129,16 @@ void replay_vmstate_init(void)
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
+
+            if (replay_snapshot_mode == REPLAY_SNAPSHOT_MODE_PERIODIC) {
+                replay_snapshot_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                                     replay_snapshot_timer_cb,
+                                                     NULL);
+                timer_mod(replay_snapshot_timer,
+                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                          replay_snapshot_periodic_delay);
+            }
+
         } else if (replay_mode == REPLAY_MODE_PLAY) {
             if (!load_snapshot(replay_snapshot, NULL, false, NULL, &err)) {
                 error_report_err(err);
diff --git a/replay/replay.c b/replay/replay.c
index 895fa6b67a..c916e71d30 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -29,6 +29,10 @@
 ReplayMode replay_mode = REPLAY_MODE_NONE;
 char *replay_snapshot;
 
+ReplaySnapshotMode replay_snapshot_mode;
+uint64_t replay_snapshot_periodic_delay;
+int replay_snapshot_periodic_nr_keep;
+
 /* Name of replay file  */
 static char *replay_filename;
 ReplayState replay_state;
@@ -424,6 +428,27 @@ void replay_configure(QemuOpts *opts)
     }
 
     replay_snapshot = g_strdup(qemu_opt_get(opts, "rrsnapshot"));
+    if (replay_snapshot && mode == REPLAY_MODE_RECORD) {
+        const char *snapmode;
+
+        snapmode = qemu_opt_get(opts, "rrsnapmode");
+        if (!snapmode || !strcmp(snapmode, "initial")) {
+            replay_snapshot_mode = REPLAY_SNAPSHOT_MODE_INITIAL;
+        } else if (!strcmp(snapmode, "periodic")) {
+            replay_snapshot_mode = REPLAY_SNAPSHOT_MODE_PERIODIC;
+        } else {
+            error_report("Invalid rrsnapmode option: %s", snapmode);
+            exit(1);
+        }
+
+        /* Default 10 host seconds of machine runtime per snapshot. */
+        replay_snapshot_periodic_delay =
+                           qemu_opt_get_number(opts, "rrsnaptime", 10) * 1000;
+
+        /* Default 2, to cover at least the last 10 host seconds of runtime. */
+        replay_snapshot_periodic_nr_keep =
+                           qemu_opt_get_number(opts, "rrsnapcount", 2);
+    }
     replay_vmstate_register();
     replay_enable(fname, mode);
 
@@ -446,8 +471,6 @@ void replay_start(void)
         exit(1);
     }
 
-    /* Timer for snapshotting will be set up here. */
-
     replay_enable_events();
 }
 
diff --git a/system/vl.c b/system/vl.c
index 70f4cece7f..8070cee6da 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -447,6 +447,15 @@ static QemuOptsList qemu_icount_opts = {
         }, {
             .name = "rrsnapshot",
             .type = QEMU_OPT_STRING,
+        }, {
+            .name = "rrsnapmode",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "rrsnaptime",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "rrsnapcount",
+            .type = QEMU_OPT_NUMBER,
         },
         { /* end of list */ }
     },
diff --git a/qemu-options.hx b/qemu-options.hx
index 7fd1713fa8..51f2498f12 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4665,13 +4665,13 @@ SRST
 ERST
 
 DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
-    "-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=<filename>[,rrsnapshot=<snapshot>]]\n" \
+    "-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=<filename>[,rrsnapshot=<snapshot>][,rrsnapmode=initial|periodic][,rrsnaptime=secs][,rrsnapcount=N]\n" \
     "                enable virtual instruction counter with 2^N clock ticks per\n" \
     "                instruction, enable aligning the host and virtual clocks\n" \
     "                or disable real time cpu sleeping, and optionally enable\n" \
     "                record-and-replay mode\n", QEMU_ARCH_ALL)
 SRST
-``-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=filename[,rrsnapshot=snapshot]]``
+``-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=filename[,rrsnapshot=snapshot][,rrsnapmode=initial|periodic][,rrsnaptime=secs][,rrsnapcount=N]]``
     Enable virtual instruction counter. The virtual cpu will execute one
     instruction every 2^N ns of virtual time. If ``auto`` is specified
     then the virtual cpu speed will be automatically adjusted to keep
@@ -4713,6 +4713,11 @@ SRST
     name. In record mode, a new VM snapshot with the given name is created
     at the start of execution recording. In replay mode this option
     specifies the snapshot name used to load the initial VM state.
+    ``rrsnapmode=periodic`` will additionally cause a periodic snapshot to
+    be created after ``rrsnaptime=secs`` seconds of real runtime. The last
+    ``rrsnapcount=N`` periodic snapshots (not including the initial) will
+    be kept (0 for infinite). Periodic snapshots are useful to speed
+    reverse debugging operations near the end of the recorded trace.
 ERST
 
 DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \
-- 
2.42.0


