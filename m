Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA0C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWkM-0004Yo-1m; Fri, 03 Jul 2026 01:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWje-0004Sx-H2; Fri, 03 Jul 2026 01:46:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWjW-0003RU-9G; Fri, 03 Jul 2026 01:46:41 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jovb036784
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 3 Jul 2026 14:46:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=a5pX8GSQLfvXAGNcBH7Jek/cIEJQlGFUi9gglmnzbXs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1783057565; v=1;
 b=L11PWrTwQZGVmFeAItVm73mPTJFkRlawTeml8mm9ydsJ3N0AVX/ubpRfSykfpHwe
 9L3t8vN5HJavQ30joij+tT20Y08J2riJVfzwgU+iMQDA6H0496ZAibim/og9ft/Y
 9O59YSTmF3ULIRZCFSSXX+fEc5ahZWj46x1K8vWfl5JE/IjjCy7I4R5Nz8/HG9Ar
 B9E2I0TGYvO10L7pGVFxb/CAFvEXMz6bGOzLdxWDNrOrV6Emq2B5VTp6MRgU70Xx
 OHBjadgp4TP7UN1+Vb1kG0ZUeSsqb9FTfhELUw/+V5/eQUtLhy3ROa6BOGoGpL1D
 zGYSs2McY9XeSnXmGNznYw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:33 +0900
Subject: [PATCH v5 2/8] ivshmem-server: Use qemu_get_runtime_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-2-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260703-run-v5-0-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260703-run-v5-0-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yan Vugenfirer <yan@daynix.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3121;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=bk67rDms6n/fkiVYMEK4YCup/zBeBbWYRVMUGEZOa5U=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z+TA1f+sXxZPWqElkXJp8qo/DBP+l/PGzT/q4HJ89
 nE79djKjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgInwT2JkePDx18VbH56odXhz
 8B86eZPpj7S+8LHgac+ls5gfN3JaRzP8d0xS3vI1QlbBzM+xcKLp1dKKg/UbYu/q+reltT8NWX+
 ACwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qemu_get_runtime_dir() is used to construct the default PID file path.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
2.54.0


