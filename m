Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8558C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjff-00055S-Ks; Mon, 11 Mar 2024 13:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjfT-0003yR-JW
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:31 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjfP-0007T8-4g
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:29 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e676ea4e36so2375466b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178945; x=1710783745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReAKLnxDhZ0dLTbcBcY6ImZ2cOk598dKpfP+nB/tbBQ=;
 b=icLf8KbySJi5I0MU03q8Sa3lslgb9qf/nE6s0be+DdBRYCKrqNFfiqSiswYDObp7su
 fd+8Enb95j6Hp0o4/dMQWYKP8p7/5zIQ5REfDNZNTlrHcqzUgavtdS47cPYQcNNm/flM
 UjTLOD1Frzac8d5MZ/UyS4C+0nDI98gfSpITJpZnWLYhovr6F93AX8Mph61w1pGTrkyw
 5GT5IAhhtvRv0iONtrmP6zr8rTSjjFN/tXc1eyZYk3EEjoihBfawKwes6njBnJ/8cy8P
 SpqjsQnUg8ws8QmybR+qe53+pX3y7Rnlv1OUncUtaXNWQYT+wa0VEARQdYoG+ByaEnxz
 t9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178945; x=1710783745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReAKLnxDhZ0dLTbcBcY6ImZ2cOk598dKpfP+nB/tbBQ=;
 b=NR8C1VMJE+scIJ5IRqGGuq6IcPoBrvKn8FNGZHOgaUNMbmN1BpHuIKSH4HdrtN08MN
 tH9y9yzYh38rq8wKhwukBy0fs3V3HcbKMajYZPfRyDzkDr8hNxt/7ESqeHjSpBo6cVFJ
 Xddv7MpMdD5bxYZFT8DZWM2DlL7Fx+RIND1E08q/4QenO9RbGll8dIgd4BMouWgN7b1w
 kvzYUvfrhBi3KVDmkc7wBse+MJv5ckN+RCaZhna9O8xf6zSzLEX8kVw5TlcA0yn3jh1x
 6s3cuo+yfCTSLnkJVlU8dQnfDIFDnbs/Ou/zwm5JVRdluLbOMSPl55dnQb03pCYvR3np
 SOsA==
X-Gm-Message-State: AOJu0Yz16KY0ExgOqJIlZxLu3vcNfBLGwlqqy6h15OgmuvCG4vvdKiuX
 0ticpBQCpacIi3sdIzEidnnVakZZDQOmZDYdrLjPRkCnjhpgAe/2jO/VidHe4K8=
X-Google-Smtp-Source: AGHT+IHr6LuDGqUNSCjZhxYjFKq/y6EfdzE5nxC0Jag+yn9nyTGOO2EOD7CmUUDjbF2WcD3JKj0BIQ==
X-Received: by 2002:a05:6a00:1a8a:b0:6e6:2cde:a3d9 with SMTP id
 e10-20020a056a001a8a00b006e62cdea3d9mr1207142pfv.10.1710178943884; 
 Mon, 11 Mar 2024 10:42:23 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:23 -0700 (PDT)
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
Subject: [PATCH v4 20/24] replay: simple auto-snapshot mode for record
Date: Tue, 12 Mar 2024 03:40:22 +1000
Message-ID: <20240311174026.2177152-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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
index ac4a30fa83..9eb547bf52 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4651,13 +4651,13 @@ SRST
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
@@ -4699,6 +4699,11 @@ SRST
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


