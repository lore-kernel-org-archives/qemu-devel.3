Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3FAC3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcbc-0004hq-SI; Tue, 16 Jul 2024 03:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbb-0004be-9O
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:11 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbZ-0006SI-In
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70af22a9c19so3833944b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721114888; x=1721719688;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qNvh0sTzcav+0om+9KQZskLO4kNiX/u7v2HI6UKmLHk=;
 b=LerFN5urRqZgKez4ESAfHVp+SvfTN7fa/1tyWLskur+bKSL1usHxmL/JA6p9sppSUj
 6oMcC49hsbOJ5mp7fgY97I1NpP4RXzVNDNhSxWPP6w/0juYWRSvEise4MOe8v31fM2Wt
 IFZzAvsEFpDnMVrsBOOQgsTHWqL4gMPjijkc4JCvE5yPnzvPszu6vWXV7ZTMKTY+OKxl
 YdLfK3FyNBN00hz9ph39+CSUvid3nQhSsUoeCabrT55pYNf0ImuHoZkBEzyMF/RI7cjF
 sk8YzpXBoAXH9hDdxzHo1LThZAtFryt6H1atoKDAJb3YcSF9eqTos3bNis7XGjgSfsfZ
 MEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114888; x=1721719688;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNvh0sTzcav+0om+9KQZskLO4kNiX/u7v2HI6UKmLHk=;
 b=e0vwidUowt+6leTCRMdY/hTKK6Tcc+/7pw2kFGRxcJReqTTjhpE/+KxQhupJICOR7N
 L2xKJ4TyAPtIjaD+o66mMcxhwwBfdzOxT3/oyegkRova9rEpLfCGpdup/m4lIUtvzTUQ
 LlTqjNqyFG509WIXP9I809mCorXVyHxPnrihCtgy8kX545MWfk5A+ivk3bfOzqN4rtvc
 t7p5gNXZVUAE0yHBieD1A1BzGxuz8gJf1HXcpj9BEiaQqc7tY21zAUltOzUmnsOA/4JL
 9VcN2EYVaByDx54CQ4taO10bOdsCEUwHLwewG3RGPmtCf1d35SJr1kNiFEY4jvOP4PoU
 meBA==
X-Gm-Message-State: AOJu0YwE4QyLjO2WvBe5GlUw2Y3rt0j42dBGorm4W8yuw9RcZdC/6+T4
 EhcVOmYg7g0NQba9nCwPtRdCLxetBg/x3tYUh5Rjuq9WohzV78lDeeRKP3jglnU=
X-Google-Smtp-Source: AGHT+IFqa3dZaRCSXfEBl+BtO2+GcZJyqDHq2hTmhGre9DnwRCjm9IDiG7gqnIbVtB4XKEdTTdSi3g==
X-Received: by 2002:a05:6a20:3d88:b0:1c0:ef24:413e with SMTP id
 adf61e73a8af0-1c3f1295d2cmr1383042637.36.1721114888199; 
 Tue, 16 Jul 2024 00:28:08 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc52568sm51780885ad.290.2024.07.16.00.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:28:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 16:27:32 +0900
Subject: [PATCH v4 2/7] ivshmem-server: Use qemu_get_runtime_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-run-v4-2-5f7a29631168@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

qemu_get_runtime_dir() is used to construct the default PID file path.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921075425.16738-3-akihiko.odaki@daynix.com>
---
 contrib/ivshmem-server/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
index 5901f17707e0..313124dd4520 100644
--- a/contrib/ivshmem-server/main.c
+++ b/contrib/ivshmem-server/main.c
@@ -14,7 +14,6 @@
 
 #define IVSHMEM_SERVER_DEFAULT_VERBOSE        0
 #define IVSHMEM_SERVER_DEFAULT_FOREGROUND     0
-#define IVSHMEM_SERVER_DEFAULT_PID_FILE       "/var/run/ivshmem-server.pid"
 #define IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH "/tmp/ivshmem_socket"
 #define IVSHMEM_SERVER_DEFAULT_SHM_PATH       "ivshmem"
 #define IVSHMEM_SERVER_DEFAULT_SHM_SIZE       (4 * 1024 * 1024)
@@ -35,15 +34,23 @@ typedef struct IvshmemServerArgs {
     unsigned n_vectors;
 } IvshmemServerArgs;
 
+static char *ivshmem_server_get_default_pid_file(void)
+{
+    g_autofree char *run = qemu_get_runtime_dir();
+    return g_build_filename(run, "ivshmem-server.pid", NULL);
+}
+
 static void
 ivshmem_server_usage(const char *progname)
 {
+    g_autofree char *pid_file = ivshmem_server_get_default_pid_file();
+
     printf("Usage: %s [OPTION]...\n"
            "  -h: show this help\n"
            "  -v: verbose mode\n"
            "  -F: foreground mode (default is to daemonize)\n"
            "  -p <pid-file>: path to the PID file (used in daemon mode only)\n"
-           "     default " IVSHMEM_SERVER_DEFAULT_PID_FILE "\n"
+           "     default %s\n"
            "  -S <unix-socket-path>: path to the unix socket to listen to\n"
            "     default " IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH "\n"
            "  -M <shm-name>: POSIX shared memory object to use\n"
@@ -54,7 +61,7 @@ ivshmem_server_usage(const char *progname)
            "     default %u\n"
            "  -n <nvectors>: number of vectors\n"
            "     default %u\n",
-           progname, IVSHMEM_SERVER_DEFAULT_SHM_SIZE,
+           progname, pid_file, IVSHMEM_SERVER_DEFAULT_SHM_SIZE,
            IVSHMEM_SERVER_DEFAULT_N_VECTORS);
 }
 
@@ -189,10 +196,10 @@ main(int argc, char *argv[])
 {
     IvshmemServer server;
     struct sigaction sa, sa_quit;
+    g_autofree char *default_pid_file = NULL;
     IvshmemServerArgs args = {
         .verbose = IVSHMEM_SERVER_DEFAULT_VERBOSE,
         .foreground = IVSHMEM_SERVER_DEFAULT_FOREGROUND,
-        .pid_file = IVSHMEM_SERVER_DEFAULT_PID_FILE,
         .unix_socket_path = IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH,
         .shm_path = IVSHMEM_SERVER_DEFAULT_SHM_PATH,
         .use_shm_open = true,
@@ -207,6 +214,11 @@ main(int argc, char *argv[])
      */
     printf("*** Example code, do not use in production ***\n");
 
+    qemu_init_exec_dir(argv[0]);
+
+    default_pid_file = ivshmem_server_get_default_pid_file();
+    args.pid_file = default_pid_file;
+
     /* parse arguments, will exit on error */
     ivshmem_server_parse_args(&args, argc, argv);
 

-- 
2.45.2


