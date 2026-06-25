Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22781CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWD-0004Ke-7d; Thu, 25 Jun 2026 17:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrW4-0003mf-QO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVz-0003q4-9o
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWESVFA/bEGjV5UoFt7/z1oT86TfXk+2E5bFqTUhbG8=;
 b=G/htHuCiydgq/dtiequZWVorPAEpzNj11F7WLSt9sXacfQB7aM2iSsuuwiNQwVD2eX505G
 fHduTk63v9L6ee/nVgp+8slHiLKnm8tTOPgHlPb9DSXDHRJOll5DdjbZCQ64yyXYcSzjlw
 earF6yya4uHH0dAolBn5nCRxSY+B/cI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-LIaEQqogOwOumzdcUsmkTw-1; Thu,
 25 Jun 2026 17:21:34 -0400
X-MC-Unique: LIaEQqogOwOumzdcUsmkTw-1
X-Mimecast-MFC-AGG-ID: LIaEQqogOwOumzdcUsmkTw_1782422493
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77AAC1954221; Thu, 25 Jun 2026 21:21:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 792053000B56; Thu, 25 Jun 2026 21:21:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:23 +0400
Subject: [PATCH v2 22/39] qemu-io: propagate errors through Error API
 instead of printf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-22-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=150498;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pnCYlYRc060UbFLh3QGMLxh17/n+1JF4a69v6bHcPx8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdVvt5V3X1SieSS9QHxCl+yBSYhqL28rGdI
 rY06PEB+paJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5fV+D/4kKHmtBKsfPwvjc+0+0aMrBGTQd0izylfdnCwLlW6+NpnEfFUsW/0HmoiiGIMZu+sctdF
 d6kPDV6rHfmRLWxi2vHI6sxROv0jh9CTysUMIHKduzxMuZANOqDtj58yxiq+U7JVcEe+SRMhfOs
 hSMvK0zLVSyL+NNXUT767mWam3vRV3MdVi/DnKk1fNSCVvUzvweh9/T+BjnV5upaQNnRlm43sA6
 dIEvPu+XFolBohdfPLGYmN7a5WgA4Lac4dQNnUlsIXwMNen6i0/JdJjBsmG1KNLvIWWJulSCD2O
 RBRI8WiEJzBpkHta5vx5fKdsxwDWqQZISH9FBi59GwbRizm2uEvSBmeZiSj/FG/TVceTG4JUZqM
 YqBj3iuWTjqHz7dOAAq27I2OpFPHwu6RIdf/4Ppj3qziE50sGRXSe5rd5XIoWP2znd2YNFfTGC+
 eo/JJcXQbampj1uxmQtfsxxY7qWxAaQNrsa2LdWuRDjtloTBQlu2QwDD4gHAmkpN4bZ2tiIPHQ9
 cJaPLzIoF0Xs+jLVfah/PZPeAOuwavmEOZ996/6GFQ09DKqILfobOQLcVfwFf+EDFFCQx3RnFbO
 BXL3KIlf6gb1HUVtu0SD95vcJhXd4ecLGO2CV6qvaxqSkaL7w4ulS334D5VZeqGzE7FTYyDqgol
 Hy0wfLRiIyV+V/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Convert the qemu-io command infrastructure to use QEMU's Error API
(Error **errp) for error propagation instead of printing directly to
stdout/stderr via printf/fprintf.

The cfunc_t typedef, all ~35 command functions, the dispatcher chain
(command/init_check_command/qemuio_command), and helper functions
(parse_pattern, create_iovec, qemu_io_alloc_from_file) all gain an
Error **errp parameter. Async completion callbacks (aio_read_done,
aio_write_done, aio_discard_done) use error_report() since they have
no Error path back to the caller.

Update tests:
- error_report_err() prepends qemu-io: prefix
- copy-before-write: check the HMP return value, rather than stdio
- other tests: update to check JSON {"return": "Error: error text"}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu-io.h                              |   4 +-
 block/monitor/block-hmp-cmds.c                 |   2 +-
 qemu-io-cmds.c                                 | 414 +++++++++++++------------
 qemu-io.c                                      |  17 +-
 tests/qemu-iotests/004.out                     |  20 +-
 tests/qemu-iotests/021.out                     |  60 ++--
 tests/qemu-iotests/026.out                     | 228 +++++++-------
 tests/qemu-iotests/060.out                     |  44 ++-
 tests/qemu-iotests/071.out                     |  10 +-
 tests/qemu-iotests/072.out                     |   2 +-
 tests/qemu-iotests/080.out                     |   4 +-
 tests/qemu-iotests/081.out                     |   2 +-
 tests/qemu-iotests/083.out                     |  36 +--
 tests/qemu-iotests/089.out                     |   4 +-
 tests/qemu-iotests/114.out                     |   2 +-
 tests/qemu-iotests/134.out                     |   2 +-
 tests/qemu-iotests/137.out                     |   2 +-
 tests/qemu-iotests/153.out                     |  12 +-
 tests/qemu-iotests/171                         |   2 +-
 tests/qemu-iotests/171.out                     |  68 ++--
 tests/qemu-iotests/205                         |   2 +-
 tests/qemu-iotests/214.out                     |   2 +-
 tests/qemu-iotests/220.out                     |   2 +-
 tests/qemu-iotests/225.out                     |   4 +-
 tests/qemu-iotests/244.out                     |  12 +-
 tests/qemu-iotests/249.out                     |   6 +-
 tests/qemu-iotests/271.out                     |  14 +-
 tests/qemu-iotests/289.out                     |   2 +-
 tests/qemu-iotests/305.out                     |   2 +-
 tests/qemu-iotests/307.out                     |   2 +-
 tests/qemu-iotests/tests/backup-discard-source |   4 +-
 tests/qemu-iotests/tests/copy-before-write     |  66 ++--
 tests/qemu-iotests/tests/file-io-error.out     |   2 +-
 tests/qemu-iotests/tests/image-fleecing.out    |  12 +-
 tests/qemu-iotests/tests/inactive-node-nbd.out |   8 +-
 35 files changed, 552 insertions(+), 523 deletions(-)

diff --git a/include/qemu-io.h b/include/qemu-io.h
index 3af513004a6..240764bb35c 100644
--- a/include/qemu-io.h
+++ b/include/qemu-io.h
@@ -25,7 +25,7 @@
  * Operate on @blk using @argc/@argv as the command's arguments, and
  * return 0 on success or negative errno on failure.
  */
-typedef int (*cfunc_t)(BlockBackend *blk, int argc, char **argv);
+typedef int (*cfunc_t)(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 typedef void (*helpfunc_t)(void);
 
@@ -45,7 +45,7 @@ typedef struct cmdinfo {
 
 extern bool qemuio_misalign;
 
-int qemuio_command(BlockBackend *blk, const char *cmd);
+int qemuio_command(BlockBackend *blk, const char *cmd, Error **errp);
 
 void qemuio_add_command(const cmdinfo_t *ci);
 void qemuio_command_usage(const cmdinfo_t *ci);
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 69ade0534f1..c7113b8ea5e 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -608,7 +608,7 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
      * extended, possibly resulting in a read-only guest device keeping write
      * permissions. Ugly, but it appears to be the lesser evil.
      */
-    qemuio_command(blk, command);
+    qemuio_command(blk, command, &err);
 
 fail:
     blk_unref(local_blk);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index de4c1966fea..aa795fd87a1 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -55,40 +55,43 @@ void qemuio_command_usage(const cmdinfo_t *ci)
     printf("%s %s -- %s\n", ci->name, ci->args, ci->oneline);
 }
 
-static int init_check_command(BlockBackend *blk, const cmdinfo_t *ct)
+static int init_check_command(BlockBackend *blk, const cmdinfo_t *ct,
+                              Error **errp)
 {
     if (ct->flags & CMD_FLAG_GLOBAL) {
         return 1;
     }
     if (!(ct->flags & CMD_NOFILE_OK) && !blk) {
-        fprintf(stderr, "no file open, try 'help open'\n");
+        error_setg(errp, "no file open, try 'help open'");
         return 0;
     }
     return 1;
 }
 
 static int command(BlockBackend *blk, const cmdinfo_t *ct, int argc,
-                   char **argv)
+                   char **argv, Error **errp)
 {
     char *cmd = argv[0];
 
-    if (!init_check_command(blk, ct)) {
+    if (!init_check_command(blk, ct, errp)) {
         return -EINVAL;
     }
 
     if (argc - 1 < ct->argmin || (ct->argmax != -1 && argc - 1 > ct->argmax)) {
         if (ct->argmax == -1) {
-            fprintf(stderr,
-                    "bad argument count %d to %s, expected at least %d arguments\n",
-                    argc-1, cmd, ct->argmin);
+            error_setg(errp,
+                       "bad argument count %d to %s,"
+                       " expected at least %d arguments",
+                       argc - 1, cmd, ct->argmin);
         } else if (ct->argmin == ct->argmax) {
-            fprintf(stderr,
-                    "bad argument count %d to %s, expected %d arguments\n",
-                    argc-1, cmd, ct->argmin);
+            error_setg(errp,
+                       "bad argument count %d to %s, expected %d arguments",
+                       argc - 1, cmd, ct->argmin);
         } else {
-            fprintf(stderr,
-                    "bad argument count %d to %s, expected between %d and %d arguments\n",
-                    argc-1, cmd, ct->argmin, ct->argmax);
+            error_setg(errp,
+                       "bad argument count %d to %s,"
+                       " expected between %d and %d arguments",
+                       argc - 1, cmd, ct->argmin, ct->argmax);
         }
         return -EINVAL;
     }
@@ -112,21 +115,19 @@ static int command(BlockBackend *blk, const cmdinfo_t *ct, int argc,
 
         if (ct->perm & ~orig_perm) {
             uint64_t new_perm;
-            Error *local_err = NULL;
             int ret;
 
             new_perm = orig_perm | ct->perm;
 
-            ret = blk_set_perm(blk, new_perm, orig_shared_perm, &local_err);
+            ret = blk_set_perm(blk, new_perm, orig_shared_perm, errp);
             if (ret < 0) {
-                error_report_err(local_err);
                 return ret;
             }
         }
     }
 
     qemu_reset_optind();
-    return ct->cfunc(blk, argc, argv);
+    return ct->cfunc(blk, argc, argv, errp);
 }
 
 static const cmdinfo_t *find_command(const char *cmd)
@@ -192,18 +193,18 @@ static int64_t cvtnum(const char *s)
     return value;
 }
 
-static void print_cvtnum_err(int64_t rc, const char *arg)
+static void set_cvtnum_err(int64_t rc, const char *arg, Error **errp)
 {
     switch (rc) {
     case -EINVAL:
-        printf("Parsing error: non-numeric argument,"
-               " or extraneous/unrecognized suffix -- %s\n", arg);
+        error_setg(errp, "Parsing error: non-numeric argument,"
+                   " or extraneous/unrecognized suffix -- %s", arg);
         break;
     case -ERANGE:
-        printf("Parsing error: argument too large -- %s\n", arg);
+        error_setg(errp, "Parsing error: argument too large -- %s", arg);
         break;
     default:
-        printf("Parsing error: %s\n", arg);
+        error_setg(errp, "Parsing error: %s", arg);
     }
 }
 
@@ -316,14 +317,14 @@ static void timestr(struct timespec *tv, char *ts, size_t size, int format)
  * Because the pattern is used as an argument to memset it must evaluate
  * to an unsigned integer that fits into a single byte.
  */
-static int parse_pattern(const char *arg)
+static int parse_pattern(const char *arg, Error **errp)
 {
     char *endptr = NULL;
     long pattern;
 
     pattern = strtol(arg, &endptr, 0);
     if (pattern < 0 || pattern > UCHAR_MAX || *endptr != '\0') {
-        printf("%s is not a valid pattern byte\n", arg);
+        error_setg(errp, "%s is not a valid pattern byte", arg);
         return -1;
     }
 
@@ -386,7 +387,8 @@ static void qemu_io_free(BlockBackend *blk, void *p, size_t len,
  *          NULL on error
  */
 static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
-                                     const char *file_name, bool register_buf)
+                                     const char *file_name, bool register_buf,
+                                     Error **errp)
 {
     size_t alloc_len = len + (qemuio_misalign ? MISALIGN_OFFSET : 0);
     char *alloc_buf, *buf, *end;
@@ -394,7 +396,7 @@ static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
     int pattern_len;
 
     if (!f) {
-        perror(file_name);
+        error_setg_errno(errp, errno, "%s", file_name);
         return NULL;
     }
 
@@ -407,12 +409,12 @@ static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
     pattern_len = fread(buf, 1, len, f);
 
     if (ferror(f)) {
-        perror(file_name);
+        error_setg_errno(errp, errno, "%s", file_name);
         goto error;
     }
 
     if (pattern_len == 0) {
-        fprintf(stderr, "%s: file is empty\n", file_name);
+        error_setg(errp, "%s: file is empty", file_name);
         goto error;
     }
 
@@ -494,7 +496,7 @@ static void print_report(const char *op, struct timespec *t, int64_t offset,
  */
 static void *
 create_iovec(BlockBackend *blk, QEMUIOVector *qiov, char **argv, int nr_iov,
-             int pattern, bool register_buf)
+             int pattern, bool register_buf, Error **errp)
 {
     size_t *sizes = g_new0(size_t, nr_iov);
     size_t count = 0;
@@ -508,19 +510,20 @@ create_iovec(BlockBackend *blk, QEMUIOVector *qiov, char **argv, int nr_iov,
 
         len = cvtnum(arg);
         if (len < 0) {
-            print_cvtnum_err(len, arg);
+            set_cvtnum_err(len, arg, errp);
             goto fail;
         }
 
         if (len > BDRV_REQUEST_MAX_BYTES) {
-            printf("Argument '%s' exceeds maximum size %" PRIu64 "\n", arg,
-                   (uint64_t)BDRV_REQUEST_MAX_BYTES);
+            error_setg(errp, "Argument '%s' exceeds maximum size %" PRIu64,
+                       arg, (uint64_t)BDRV_REQUEST_MAX_BYTES);
             goto fail;
         }
 
         if (count > BDRV_REQUEST_MAX_BYTES - len) {
-            printf("The total number of bytes exceed the maximum size %" PRIu64
-                   "\n", (uint64_t)BDRV_REQUEST_MAX_BYTES);
+            error_setg(errp,
+                       "The total number of bytes exceed the maximum size %"
+                       PRIu64, (uint64_t)BDRV_REQUEST_MAX_BYTES);
             goto fail;
         }
 
@@ -692,7 +695,7 @@ static void read_help(void)
 "\n");
 }
 
-static int read_f(BlockBackend *blk, int argc, char **argv);
+static int read_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t read_cmd = {
     .name       = "read",
@@ -705,7 +708,7 @@ static const cmdinfo_t read_cmd = {
     .help       = read_help,
 };
 
-static int read_f(BlockBackend *blk, int argc, char **argv)
+static int read_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     struct timespec t1, t2;
     bool Cflag = false, qflag = false, vflag = false;
@@ -732,7 +735,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
             lflag = true;
             pattern_count = cvtnum(optarg);
             if (pattern_count < 0) {
-                print_cvtnum_err(pattern_count, optarg);
+                set_cvtnum_err(pattern_count, optarg, errp);
                 return pattern_count;
             }
             break;
@@ -741,7 +744,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
             break;
         case 'P':
             Pflag = true;
-            pattern = parse_pattern(optarg);
+            pattern = parse_pattern(optarg, errp);
             if (pattern < 0) {
                 return -EINVAL;
             }
@@ -756,7 +759,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
             sflag = true;
             pattern_offset = cvtnum(optarg);
             if (pattern_offset < 0) {
-                print_cvtnum_err(pattern_offset, optarg);
+                set_cvtnum_err(pattern_offset, optarg, errp);
                 return pattern_offset;
             }
             break;
@@ -776,18 +779,18 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
 
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
 
     optind++;
     count = cvtnum(argv[optind]);
     if (count < 0) {
-        print_cvtnum_err(count, argv[optind]);
+        set_cvtnum_err(count, argv[optind], errp);
         return count;
     } else if (count > BDRV_REQUEST_MAX_BYTES) {
-        printf("length cannot exceed %" PRIu64 ", given %s\n",
-               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
+        error_setg(errp, "length cannot exceed %" PRIu64 ", given %s",
+                   (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
         return -EINVAL;
     }
 
@@ -801,24 +804,26 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
     }
 
     if ((pattern_count < 0) || (pattern_count + pattern_offset > count))  {
-        printf("pattern verification range exceeds end of read data\n");
+        error_setg(errp, "pattern verification range exceeds end of read data");
         return -EINVAL;
     }
 
     if (bflag) {
         if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
-            printf("%" PRId64 " is not a sector-aligned value for 'offset'\n",
-                   offset);
+            error_setg(errp,
+                       "%" PRId64 " is not a sector-aligned value for 'offset'",
+                       offset);
             return -EINVAL;
         }
         if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
-            printf("%"PRId64" is not a sector-aligned value for 'count'\n",
-                   count);
+            error_setg(errp,
+                       "%" PRId64 " is not a sector-aligned value for 'count'",
+                       count);
             return -EINVAL;
         }
         if (flags & BDRV_REQ_REGISTERED_BUF) {
-            printf("I/O buffer registration is not supported when reading "
-                    "from vmstate\n");
+            error_setg(errp, "I/O buffer registration is not supported when"
+                       " reading from vmstate");
             return -EINVAL;
         }
     }
@@ -834,7 +839,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
     clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
-        printf("read failed: %s\n", strerror(-ret));
+        error_setg(errp, "read failed: %s", strerror(-ret));
         goto out;
     }
     cnt = ret;
@@ -845,9 +850,9 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
         void *cmp_buf = g_malloc(pattern_count);
         memset(cmp_buf, pattern, pattern_count);
         if (memcmp(buf + pattern_offset, cmp_buf, pattern_count)) {
-            printf("Pattern verification failed at offset %"
-                   PRId64 ", %"PRId64" bytes\n",
-                   offset + pattern_offset, pattern_count);
+            error_setg(errp, "Pattern verification failed at offset %"
+                       PRId64 ", %" PRId64 " bytes",
+                       offset + pattern_offset, pattern_count);
             ret = -EINVAL;
         }
         g_free(cmp_buf);
@@ -890,7 +895,7 @@ static void readv_help(void)
 "\n");
 }
 
-static int readv_f(BlockBackend *blk, int argc, char **argv);
+static int readv_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t readv_cmd = {
     .name       = "readv",
@@ -902,7 +907,7 @@ static const cmdinfo_t readv_cmd = {
     .help       = readv_help,
 };
 
-static int readv_f(BlockBackend *blk, int argc, char **argv)
+static int readv_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     struct timespec t1, t2;
     bool Cflag = false, qflag = false, vflag = false;
@@ -924,7 +929,7 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
             break;
         case 'P':
             Pflag = true;
-            pattern = parse_pattern(optarg);
+            pattern = parse_pattern(optarg, errp);
             if (pattern < 0) {
                 return -EINVAL;
             }
@@ -952,14 +957,14 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
 
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
     optind++;
 
     nr_iov = argc - optind;
     buf = create_iovec(blk, &qiov, &argv[optind], nr_iov, 0xab,
-                       flags & BDRV_REQ_REGISTERED_BUF);
+                       flags & BDRV_REQ_REGISTERED_BUF, errp);
     if (buf == NULL) {
         return -EINVAL;
     }
@@ -969,7 +974,7 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
     clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
-        printf("readv failed: %s\n", strerror(-ret));
+        error_setg(errp, "readv failed: %s", strerror(-ret));
         goto out;
     }
     cnt = ret;
@@ -980,8 +985,8 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
         void *cmp_buf = g_malloc(qiov.size);
         memset(cmp_buf, pattern, qiov.size);
         if (memcmp(buf, cmp_buf, qiov.size)) {
-            printf("Pattern verification failed at offset %"
-                   PRId64 ", %zu bytes\n", offset, qiov.size);
+            error_setg(errp, "Pattern verification failed at offset %"
+                       PRId64 ", %zu bytes", offset, qiov.size);
             ret = -EINVAL;
         }
         g_free(cmp_buf);
@@ -1031,7 +1036,7 @@ static void write_help(void)
 "\n");
 }
 
-static int write_f(BlockBackend *blk, int argc, char **argv);
+static int write_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t write_cmd = {
     .name       = "write",
@@ -1045,7 +1050,7 @@ static const cmdinfo_t write_cmd = {
     .help       = write_help,
 };
 
-static int write_f(BlockBackend *blk, int argc, char **argv)
+static int write_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     struct timespec t1, t2;
     bool Cflag = false, qflag = false, bflag = false;
@@ -1082,7 +1087,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
             break;
         case 'P':
             Pflag = true;
-            pattern = parse_pattern(optarg);
+            pattern = parse_pattern(optarg, errp);
             if (pattern < 0) {
                 return -EINVAL;
             }
@@ -1115,72 +1120,78 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     }
 
     if (bflag && zflag) {
-        printf("-b and -z cannot be specified at the same time\n");
+        error_setg(errp, "-b and -z cannot be specified at the same time");
         return -EINVAL;
     }
 
     if ((flags & BDRV_REQ_FUA) && (bflag || cflag)) {
-        printf("-f and -b or -c cannot be specified at the same time\n");
+        error_setg(errp,
+                   "-f and -b or -c cannot be specified at the same time");
         return -EINVAL;
     }
 
     if ((flags & BDRV_REQ_NO_FALLBACK) && !zflag) {
-        printf("-n requires -z to be specified\n");
+        error_setg(errp, "-n requires -z to be specified");
         return -EINVAL;
     }
 
     if ((flags & BDRV_REQ_MAY_UNMAP) && !zflag) {
-        printf("-u requires -z to be specified\n");
+        error_setg(errp, "-u requires -z to be specified");
         return -EINVAL;
     }
 
     if (zflag + Pflag + sflag > 1) {
-        printf("Only one of -z, -P, and -s "
-               "can be specified at the same time\n");
+        error_setg(errp, "Only one of -z, -P, and -s "
+                   "can be specified at the same time");
         return -EINVAL;
     }
 
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
 
     optind++;
     count = cvtnum(argv[optind]);
     if (count < 0) {
-        print_cvtnum_err(count, argv[optind]);
+        set_cvtnum_err(count, argv[optind], errp);
         return count;
     } else if (count > BDRV_REQUEST_MAX_BYTES &&
                !(flags & BDRV_REQ_NO_FALLBACK)) {
-        printf("length cannot exceed %" PRIu64 " without -n, given %s\n",
-               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
+        error_setg(errp,
+                   "length cannot exceed %" PRIu64 " without -n, given %s",
+                   (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
         return -EINVAL;
     }
 
     if (bflag || cflag) {
         if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
-            printf("%" PRId64 " is not a sector-aligned value for 'offset'\n",
-                   offset);
+            error_setg(errp,
+                       "%" PRId64 " is not a sector-aligned value for 'offset'",
+                       offset);
             return -EINVAL;
         }
 
         if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
-            printf("%"PRId64" is not a sector-aligned value for 'count'\n",
-                   count);
+            error_setg(errp,
+                       "%" PRId64 " is not a sector-aligned value for 'count'",
+                       count);
             return -EINVAL;
         }
     }
 
     if (zflag) {
         if (flags & BDRV_REQ_REGISTERED_BUF) {
-            printf("cannot combine zero write with registered I/O buffer\n");
+            error_setg(errp,
+                       "cannot combine zero write with registered I/O buffer");
             return -EINVAL;
         }
     } else {
         if (sflag) {
             buf = qemu_io_alloc_from_file(blk, count, file_name,
-                                          flags & BDRV_REQ_REGISTERED_BUF);
+                                          flags & BDRV_REQ_REGISTERED_BUF,
+                                          errp);
             if (!buf) {
                 return -EINVAL;
             }
@@ -1203,7 +1214,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
-        printf("write failed: %s\n", strerror(-ret));
+        error_setg(errp, "write failed: %s", strerror(-ret));
         goto out;
     }
     cnt = ret;
@@ -1245,7 +1256,7 @@ writev_help(void)
 "\n");
 }
 
-static int writev_f(BlockBackend *blk, int argc, char **argv);
+static int writev_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t writev_cmd = {
     .name       = "writev",
@@ -1258,7 +1269,7 @@ static const cmdinfo_t writev_cmd = {
     .help       = writev_help,
 };
 
-static int writev_f(BlockBackend *blk, int argc, char **argv)
+static int writev_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     struct timespec t1, t2;
     bool Cflag = false, qflag = false;
@@ -1287,7 +1298,7 @@ static int writev_f(BlockBackend *blk, int argc, char **argv)
             flags |= BDRV_REQ_REGISTERED_BUF;
             break;
         case 'P':
-            pattern = parse_pattern(optarg);
+            pattern = parse_pattern(optarg, errp);
             if (pattern < 0) {
                 return -EINVAL;
             }
@@ -1305,14 +1316,14 @@ static int writev_f(BlockBackend *blk, int argc, char **argv)
 
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
     optind++;
 
     nr_iov = argc - optind;
     buf = create_iovec(blk, &qiov, &argv[optind], nr_iov, pattern,
-                       flags & BDRV_REQ_REGISTERED_BUF);
+                       flags & BDRV_REQ_REGISTERED_BUF, errp);
     if (buf == NULL) {
         return -EINVAL;
     }
@@ -1322,7 +1333,7 @@ static int writev_f(BlockBackend *blk, int argc, char **argv)
     clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
-        printf("writev failed: %s\n", strerror(-ret));
+        error_setg(errp, "writev failed: %s", strerror(-ret));
         goto out;
     }
     cnt = ret;
@@ -1367,7 +1378,7 @@ static void aio_write_done(void *opaque, int ret)
 
 
     if (ret < 0) {
-        printf("aio_write failed: %s\n", strerror(-ret));
+        error_report("aio_write failed: %s", strerror(-ret));
         block_acct_failed(blk_get_stats(ctx->blk), &ctx->acct);
         goto out;
     }
@@ -1399,7 +1410,7 @@ static void aio_read_done(void *opaque, int ret)
     clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
-        printf("readv failed: %s\n", strerror(-ret));
+        error_report("readv failed: %s", strerror(-ret));
         block_acct_failed(blk_get_stats(ctx->blk), &ctx->acct);
         goto out;
     }
@@ -1409,8 +1420,8 @@ static void aio_read_done(void *opaque, int ret)
 
         memset(cmp_buf, ctx->pattern, ctx->qiov.size);
         if (memcmp(ctx->buf, cmp_buf, ctx->qiov.size)) {
-            printf("Pattern verification failed at offset %"
-                   PRId64 ", %zu bytes\n", ctx->offset, ctx->qiov.size);
+            error_report("Pattern verification failed at offset %"
+                         PRId64 ", %zu bytes", ctx->offset, ctx->qiov.size);
         }
         g_free(cmp_buf);
     }
@@ -1461,7 +1472,7 @@ static void aio_read_help(void)
 "\n");
 }
 
-static int aio_read_f(BlockBackend *blk, int argc, char **argv);
+static int aio_read_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t aio_read_cmd = {
     .name       = "aio_read",
@@ -1473,7 +1484,7 @@ static const cmdinfo_t aio_read_cmd = {
     .help       = aio_read_help,
 };
 
-static int aio_read_f(BlockBackend *blk, int argc, char **argv)
+static int aio_read_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int nr_iov, c;
     struct aio_ctx *ctx = g_new0(struct aio_ctx, 1);
@@ -1486,7 +1497,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv)
             break;
         case 'P':
             ctx->Pflag = true;
-            ctx->pattern = parse_pattern(optarg);
+            ctx->pattern = parse_pattern(optarg, errp);
             if (ctx->pattern < 0) {
                 g_free(ctx);
                 return -EINVAL;
@@ -1522,7 +1533,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv)
     ctx->offset = cvtnum(argv[optind]);
     if (ctx->offset < 0) {
         int ret = ctx->offset;
-        print_cvtnum_err(ret, argv[optind]);
+        set_cvtnum_err(ret, argv[optind], errp);
         g_free(ctx);
         return ret;
     }
@@ -1530,7 +1541,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv)
 
     nr_iov = argc - optind;
     ctx->buf = create_iovec(blk, &ctx->qiov, &argv[optind], nr_iov, 0xab,
-                            ctx->flags & BDRV_REQ_REGISTERED_BUF);
+                            ctx->flags & BDRV_REQ_REGISTERED_BUF, errp);
     if (ctx->buf == NULL) {
         block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_READ);
         g_free(ctx);
@@ -1573,7 +1584,7 @@ static void aio_write_help(void)
 "\n");
 }
 
-static int aio_write_f(BlockBackend *blk, int argc, char **argv);
+static int aio_write_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t aio_write_cmd = {
     .name       = "aio_write",
@@ -1586,7 +1597,7 @@ static const cmdinfo_t aio_write_cmd = {
     .help       = aio_write_help,
 };
 
-static int aio_write_f(BlockBackend *blk, int argc, char **argv)
+static int aio_write_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int nr_iov, c;
     int pattern = 0xcd;
@@ -1611,7 +1622,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
             ctx->flags |= BDRV_REQ_MAY_UNMAP;
             break;
         case 'P':
-            pattern = parse_pattern(optarg);
+            pattern = parse_pattern(optarg, errp);
             if (pattern < 0) {
                 g_free(ctx);
                 return -EINVAL;
@@ -1639,25 +1650,26 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
     }
 
     if (ctx->zflag && optind != argc - 2) {
-        printf("-z supports only a single length parameter\n");
+        error_setg(errp, "-z supports only a single length parameter");
         g_free(ctx);
         return -EINVAL;
     }
 
     if ((ctx->flags & BDRV_REQ_MAY_UNMAP) && !ctx->zflag) {
-        printf("-u requires -z to be specified\n");
+        error_setg(errp, "-u requires -z to be specified");
         g_free(ctx);
         return -EINVAL;
     }
 
     if (ctx->zflag && ctx->Pflag) {
-        printf("-z and -P cannot be specified at the same time\n");
+        error_setg(errp, "-z and -P cannot be specified at the same time");
         g_free(ctx);
         return -EINVAL;
     }
 
     if (ctx->zflag && (ctx->flags & BDRV_REQ_REGISTERED_BUF)) {
-        printf("cannot combine zero write with registered I/O buffer\n");
+        error_setg(errp,
+                   "cannot combine zero write with registered I/O buffer");
         g_free(ctx);
         return -EINVAL;
     }
@@ -1665,7 +1677,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
     ctx->offset = cvtnum(argv[optind]);
     if (ctx->offset < 0) {
         int ret = ctx->offset;
-        print_cvtnum_err(ret, argv[optind]);
+        set_cvtnum_err(ret, argv[optind], errp);
         g_free(ctx);
         return ret;
     }
@@ -1674,7 +1686,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
     if (ctx->zflag) {
         int64_t count = cvtnum(argv[optind]);
         if (count < 0) {
-            print_cvtnum_err(count, argv[optind]);
+            set_cvtnum_err(count, argv[optind], errp);
             g_free(ctx);
             return count;
         }
@@ -1685,7 +1697,8 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
     } else {
         nr_iov = argc - optind;
         ctx->buf = create_iovec(blk, &ctx->qiov, &argv[optind], nr_iov,
-                                pattern, ctx->flags & BDRV_REQ_REGISTERED_BUF);
+                                pattern,
+                                ctx->flags & BDRV_REQ_REGISTERED_BUF, errp);
         if (ctx->buf == NULL) {
             block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_WRITE);
             g_free(ctx);
@@ -1703,7 +1716,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
     return 0;
 }
 
-static int aio_flush_f(BlockBackend *blk, int argc, char **argv)
+static int aio_flush_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     BlockAcctCookie cookie;
     block_acct_start(blk_get_stats(blk), &cookie, 0, BLOCK_ACCT_FLUSH);
@@ -1718,7 +1731,7 @@ static const cmdinfo_t aio_flush_cmd = {
     .oneline    = "completes all outstanding aio requests"
 };
 
-static int flush_f(BlockBackend *blk, int argc, char **argv)
+static int flush_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     return blk_flush(blk);
 }
@@ -1735,7 +1748,7 @@ static inline int64_t tosector(int64_t bytes)
     return bytes >> BDRV_SECTOR_BITS;
 }
 
-static int zone_report_f(BlockBackend *blk, int argc, char **argv)
+static int zone_report_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int ret;
     int64_t offset;
@@ -1745,17 +1758,17 @@ static int zone_report_f(BlockBackend *blk, int argc, char **argv)
     ++optind;
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
     ++optind;
     val = cvtnum(argv[optind]);
     if (val < 0) {
-        print_cvtnum_err(val, argv[optind]);
+        set_cvtnum_err(val, argv[optind], errp);
         return val;
     }
     if (val > UINT_MAX) {
-        printf("Number of zones must be less than 2^32\n");
+        error_setg(errp, "Number of zones must be less than 2^32");
         return -ERANGE;
     }
     nr_zones = val;
@@ -1764,7 +1777,7 @@ static int zone_report_f(BlockBackend *blk, int argc, char **argv)
     zones = g_new(BlockZoneDescriptor, nr_zones);
     ret = blk_zone_report(blk, offset, &nr_zones, zones);
     if (ret < 0) {
-        printf("zone report failed: %s\n", strerror(-ret));
+        error_setg(errp, "zone report failed: %s", strerror(-ret));
     } else {
         for (int i = 0; i < nr_zones; ++i) {
             printf("start: 0x%" PRIx64 ", len 0x%" PRIx64 ", "
@@ -1788,25 +1801,25 @@ static const cmdinfo_t zone_report_cmd = {
     .oneline = "report zone information",
 };
 
-static int zone_open_f(BlockBackend *blk, int argc, char **argv)
+static int zone_open_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int ret;
     int64_t offset, len;
     ++optind;
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
     ++optind;
     len = cvtnum(argv[optind]);
     if (len < 0) {
-        print_cvtnum_err(len, argv[optind]);
+        set_cvtnum_err(len, argv[optind], errp);
         return len;
     }
     ret = blk_zone_mgmt(blk, BLK_ZO_OPEN, offset, len);
     if (ret < 0) {
-        printf("zone open failed: %s\n", strerror(-ret));
+        error_setg(errp, "zone open failed: %s", strerror(-ret));
     }
     return ret;
 }
@@ -1821,25 +1834,25 @@ static const cmdinfo_t zone_open_cmd = {
     .oneline = "explicit open a range of zones in zone block device",
 };
 
-static int zone_close_f(BlockBackend *blk, int argc, char **argv)
+static int zone_close_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int ret;
     int64_t offset, len;
     ++optind;
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
     ++optind;
     len = cvtnum(argv[optind]);
     if (len < 0) {
-        print_cvtnum_err(len, argv[optind]);
+        set_cvtnum_err(len, argv[optind], errp);
         return len;
     }
     ret = blk_zone_mgmt(blk, BLK_ZO_CLOSE, offset, len);
     if (ret < 0) {
-        printf("zone close failed: %s\n", strerror(-ret));
+        error_setg(errp, "zone close failed: %s", strerror(-ret));
     }
     return ret;
 }
@@ -1854,25 +1867,25 @@ static const cmdinfo_t zone_close_cmd = {
     .oneline = "close a range of zones in zone block device",
 };
 
-static int zone_finish_f(BlockBackend *blk, int argc, char **argv)
+static int zone_finish_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int ret;
     int64_t offset, len;
     ++optind;
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
     ++optind;
     len = cvtnum(argv[optind]);
     if (len < 0) {
-        print_cvtnum_err(len, argv[optind]);
+        set_cvtnum_err(len, argv[optind], errp);
         return len;
     }
     ret = blk_zone_mgmt(blk, BLK_ZO_FINISH, offset, len);
     if (ret < 0) {
-        printf("zone finish failed: %s\n", strerror(-ret));
+        error_setg(errp, "zone finish failed: %s", strerror(-ret));
     }
     return ret;
 }
@@ -1887,25 +1900,25 @@ static const cmdinfo_t zone_finish_cmd = {
     .oneline = "finish a range of zones in zone block device",
 };
 
-static int zone_reset_f(BlockBackend *blk, int argc, char **argv)
+static int zone_reset_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int ret;
     int64_t offset, len;
     ++optind;
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
     ++optind;
     len = cvtnum(argv[optind]);
     if (len < 0) {
-        print_cvtnum_err(len, argv[optind]);
+        set_cvtnum_err(len, argv[optind], errp);
         return len;
     }
     ret = blk_zone_mgmt(blk, BLK_ZO_RESET, offset, len);
     if (ret < 0) {
-        printf("zone reset failed: %s\n", strerror(-ret));
+        error_setg(errp, "zone reset failed: %s", strerror(-ret));
     }
     return ret;
 }
@@ -1934,7 +1947,7 @@ static int do_aio_zone_append(BlockBackend *blk, QEMUIOVector *qiov,
     return async_ret < 0 ? async_ret : 1;
 }
 
-static int zone_append_f(BlockBackend *blk, int argc, char **argv)
+static int zone_append_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int ret;
     bool pflag = false;
@@ -1956,19 +1969,19 @@ static int zone_append_f(BlockBackend *blk, int argc, char **argv)
 
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
     optind++;
     nr_iov = argc - optind;
     buf = create_iovec(blk, &qiov, &argv[optind], nr_iov, pattern,
-                       flags & BDRV_REQ_REGISTERED_BUF);
+                       flags & BDRV_REQ_REGISTERED_BUF, errp);
     if (buf == NULL) {
         return -EINVAL;
     }
     ret = do_aio_zone_append(blk, &qiov, &offset, flags, &total);
     if (ret < 0) {
-        printf("zone append failed: %s\n", strerror(-ret));
+        error_setg(errp, "zone append failed: %s", strerror(-ret));
         goto out;
     }
 
@@ -1994,7 +2007,7 @@ static const cmdinfo_t zone_append_cmd = {
     .oneline = "append write a number of bytes at a specified offset",
 };
 
-static int truncate_f(BlockBackend *blk, int argc, char **argv);
+static int truncate_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 static const cmdinfo_t truncate_cmd = {
     .name       = "truncate",
     .altname    = "t",
@@ -2006,9 +2019,8 @@ static const cmdinfo_t truncate_cmd = {
     .oneline    = "truncates the current file at the given offset",
 };
 
-static int truncate_f(BlockBackend *blk, int argc, char **argv)
+static int truncate_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
-    Error *local_err = NULL;
     int64_t offset;
     int c, ret;
     PreallocMode prealloc = PREALLOC_MODE_OFF;
@@ -2019,7 +2031,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
             prealloc = qapi_enum_parse(&PreallocMode_lookup, optarg,
                                        PREALLOC_MODE__MAX, NULL);
             if (prealloc == PREALLOC_MODE__MAX) {
-                error_report("Invalid preallocation mode '%s'", optarg);
+                error_setg(errp, "Invalid preallocation mode '%s'", optarg);
                 return -EINVAL;
             }
             break;
@@ -2031,7 +2043,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
 
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[1]);
+        set_cvtnum_err(offset, argv[1], errp);
         return offset;
     }
 
@@ -2040,23 +2052,22 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
      * exact=true.  It is better to err on the "emit more errors" side
      * than to be overly permissive.
      */
-    ret = blk_truncate(blk, offset, false, prealloc, 0, &local_err);
+    ret = blk_truncate(blk, offset, false, prealloc, 0, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
     return 0;
 }
 
-static int length_f(BlockBackend *blk, int argc, char **argv)
+static int length_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int64_t size;
     char s1[64];
 
     size = blk_getlength(blk);
     if (size < 0) {
-        printf("getlength: %s\n", strerror(-size));
+        error_setg(errp, "getlength: %s", strerror(-size));
         return size;
     }
 
@@ -2074,12 +2085,12 @@ static const cmdinfo_t length_cmd = {
 };
 
 
-static int info_f(BlockBackend *blk, int argc, char **argv)
+static int info_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
+    ERRP_GUARD();
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverInfo bdi;
     ImageInfoSpecific *spec_info;
-    Error *local_err = NULL;
     char s1[64], s2[64];
     int ret;
 
@@ -2104,9 +2115,8 @@ static int info_f(BlockBackend *blk, int argc, char **argv)
     printf("cluster size: %s\n", s1);
     printf("vm state offset: %s\n", s2);
 
-    spec_info = bdrv_get_specific_info(bs, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
+    spec_info = bdrv_get_specific_info(bs, errp);
+    if (*errp) {
         return -EIO;
     }
     if (spec_info) {
@@ -2143,7 +2153,7 @@ static void discard_help(void)
 "\n");
 }
 
-static int discard_f(BlockBackend *blk, int argc, char **argv);
+static int discard_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t discard_cmd = {
     .name       = "discard",
@@ -2157,7 +2167,7 @@ static const cmdinfo_t discard_cmd = {
     .help       = discard_help,
 };
 
-static int discard_f(BlockBackend *blk, int argc, char **argv)
+static int discard_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     struct timespec t1, t2;
     bool Cflag = false, qflag = false;
@@ -2185,18 +2195,18 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
 
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[optind]);
+        set_cvtnum_err(offset, argv[optind], errp);
         return offset;
     }
 
     optind++;
     bytes = cvtnum(argv[optind]);
     if (bytes < 0) {
-        print_cvtnum_err(bytes, argv[optind]);
+        set_cvtnum_err(bytes, argv[optind], errp);
         return bytes;
     } else if (bytes > BDRV_REQUEST_MAX_BYTES) {
-        printf("length cannot exceed %"PRIu64", given %s\n",
-               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
+        error_setg(errp, "length cannot exceed %" PRIu64 ", given %s",
+                   (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
         return -EINVAL;
     }
 
@@ -2205,7 +2215,7 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
     clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
-        printf("discard failed: %s\n", strerror(-ret));
+        error_setg(errp, "discard failed: %s", strerror(-ret));
         return ret;
     }
 
@@ -2238,7 +2248,8 @@ static void aio_discard_help(void)
 "\n");
 }
 
-static int aio_discard_f(BlockBackend *blk, int argc, char **argv);
+static int aio_discard_f(BlockBackend *blk, int argc, char **argv,
+                         Error **errp);
 
 static const cmdinfo_t aio_discard_cmd = {
     .name       = "aio_discard",
@@ -2259,7 +2270,7 @@ static void aio_discard_done(void *opaque, int ret)
     clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
-        printf("aio_discard failed: %s\n", strerror(-ret));
+        error_report("aio_discard failed: %s", strerror(-ret));
         block_acct_failed(blk_get_stats(ctx->blk), &ctx->acct);
         goto out;
     }
@@ -2278,7 +2289,7 @@ out:
     g_free(ctx);
 }
 
-static int aio_discard_f(BlockBackend *blk, int argc, char **argv)
+static int aio_discard_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int c, ret;
     int64_t count;
@@ -2310,7 +2321,7 @@ static int aio_discard_f(BlockBackend *blk, int argc, char **argv)
     ctx->offset = cvtnum(argv[optind]);
     if (ctx->offset < 0) {
         ret = ctx->offset;
-        print_cvtnum_err(ret, argv[optind]);
+        set_cvtnum_err(ret, argv[optind], errp);
         g_free(ctx);
         return ret;
     }
@@ -2318,7 +2329,7 @@ static int aio_discard_f(BlockBackend *blk, int argc, char **argv)
 
     count = cvtnum(argv[optind]);
     if (count < 0) {
-        print_cvtnum_err(count, argv[optind]);
+        set_cvtnum_err(count, argv[optind], errp);
         g_free(ctx);
         return count;
     }
@@ -2332,7 +2343,7 @@ static int aio_discard_f(BlockBackend *blk, int argc, char **argv)
     return 0;
 }
 
-static int alloc_f(BlockBackend *blk, int argc, char **argv)
+static int alloc_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     BlockDriverState *bs = blk_bs(blk);
     int64_t offset, start, remaining, count;
@@ -2342,14 +2353,14 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
 
     start = offset = cvtnum(argv[1]);
     if (offset < 0) {
-        print_cvtnum_err(offset, argv[1]);
+        set_cvtnum_err(offset, argv[1], errp);
         return offset;
     }
 
     if (argc == 3) {
         count = cvtnum(argv[2]);
         if (count < 0) {
-            print_cvtnum_err(count, argv[2]);
+            set_cvtnum_err(count, argv[2], errp);
             return count;
         }
     } else {
@@ -2361,7 +2372,7 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
     while (remaining) {
         ret = bdrv_is_allocated(bs, offset, remaining, &num);
         if (ret < 0) {
-            printf("is_allocated failed: %s\n", strerror(-ret));
+            error_setg(errp, "is_allocated failed: %s", strerror(-ret));
             return ret;
         }
         offset += num;
@@ -2422,7 +2433,7 @@ static int map_is_allocated(BlockDriverState *bs, int64_t offset,
     return firstret;
 }
 
-static int map_f(BlockBackend *blk, int argc, char **argv)
+static int map_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int64_t offset, bytes;
     char s1[64], s2[64];
@@ -2433,17 +2444,18 @@ static int map_f(BlockBackend *blk, int argc, char **argv)
     offset = 0;
     bytes = blk_getlength(blk);
     if (bytes < 0) {
-        error_report("Failed to query image length: %s", strerror(-bytes));
+        error_setg(errp, "Failed to query image length: %s", strerror(-bytes));
         return bytes;
     }
 
     while (bytes) {
         ret = map_is_allocated(blk_bs(blk), offset, bytes, &num);
         if (ret < 0) {
-            error_report("Failed to get allocation status: %s", strerror(-ret));
+            error_setg(errp, "Failed to get allocation status: %s",
+                       strerror(-ret));
             return ret;
         } else if (!num) {
-            error_report("Unexpected end of image");
+            error_setg(errp, "Unexpected end of image");
             return -EIO;
         }
 
@@ -2485,7 +2497,7 @@ static void reopen_help(void)
 "\n");
 }
 
-static int reopen_f(BlockBackend *blk, int argc, char **argv);
+static int reopen_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static QemuOptsList reopen_opts = {
     .name = "reopen",
@@ -2507,7 +2519,7 @@ static const cmdinfo_t reopen_cmd = {
        .help           = reopen_help,
 };
 
-static int reopen_f(BlockBackend *blk, int argc, char **argv)
+static int reopen_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     BlockDriverState *bs = blk_bs(blk);
     QemuOpts *qopts;
@@ -2517,13 +2529,12 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     bool writethrough = !blk_enable_write_cache(blk);
     bool has_rw_option = false;
     bool has_cache_option = false;
-    Error *local_err = NULL;
 
     while ((c = getopt(argc, argv, "c:o:rw")) != -1) {
         switch (c) {
         case 'c':
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
-                error_report("Invalid cache option: %s", optarg);
+                error_setg(errp, "Invalid cache option: %s", optarg);
                 return -EINVAL;
             }
             has_cache_option = true;
@@ -2536,7 +2547,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
             break;
         case 'r':
             if (has_rw_option) {
-                error_report("Only one -r/-w option may be given");
+                error_setg(errp, "Only one -r/-w option may be given");
                 return -EINVAL;
             }
             flags &= ~BDRV_O_RDWR;
@@ -2544,7 +2555,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
             break;
         case 'w':
             if (has_rw_option) {
-                error_report("Only one -r/-w option may be given");
+                error_setg(errp, "Only one -r/-w option may be given");
                 return -EINVAL;
             }
             flags |= BDRV_O_RDWR;
@@ -2566,7 +2577,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     if (!writethrough != blk_enable_write_cache(blk) &&
         blk_get_attached_dev(blk))
     {
-        error_report("Cannot change cache.writeback: Device attached");
+        error_setg(errp, "Cannot change cache.writeback: Device attached");
         qemu_opts_reset(&reopen_opts);
         return -EBUSY;
     }
@@ -2589,7 +2600,8 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
 
     if (qdict_haskey(opts, BDRV_OPT_READ_ONLY)) {
         if (has_rw_option) {
-            error_report("Cannot set both -r/-w and '" BDRV_OPT_READ_ONLY "'");
+            error_setg(errp,
+                       "Cannot set both -r/-w and '" BDRV_OPT_READ_ONLY "'");
             qobject_unref(opts);
             return -EINVAL;
         }
@@ -2600,7 +2612,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     if (qdict_haskey(opts, BDRV_OPT_CACHE_DIRECT) ||
         qdict_haskey(opts, BDRV_OPT_CACHE_NO_FLUSH)) {
         if (has_cache_option) {
-            error_report("Cannot set both -c and the cache options");
+            error_setg(errp, "Cannot set both -c and the cache options");
             qobject_unref(opts);
             return -EINVAL;
         }
@@ -2609,10 +2621,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
         qdict_put_bool(opts, BDRV_OPT_CACHE_NO_FLUSH, flags & BDRV_O_NO_FLUSH);
     }
 
-    bdrv_reopen(bs, opts, true, &local_err);
-
-    if (local_err) {
-        error_report_err(local_err);
+    if (bdrv_reopen(bs, opts, true, errp) < 0) {
         return -EINVAL;
     }
 
@@ -2620,26 +2629,28 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     return 0;
 }
 
-static int break_f(BlockBackend *blk, int argc, char **argv)
+static int break_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int ret;
 
     ret = bdrv_debug_breakpoint(blk_bs(blk), argv[1], argv[2]);
     if (ret < 0) {
-        printf("Could not set breakpoint: %s\n", strerror(-ret));
+        error_setg(errp, "Could not set breakpoint: %s", strerror(-ret));
         return ret;
     }
 
     return 0;
 }
 
-static int remove_break_f(BlockBackend *blk, int argc, char **argv)
+static int remove_break_f(BlockBackend *blk, int argc, char **argv,
+                           Error **errp)
 {
     int ret;
 
     ret = bdrv_debug_remove_breakpoint(blk_bs(blk), argv[1]);
     if (ret < 0) {
-        printf("Could not remove breakpoint %s: %s\n", argv[1], strerror(-ret));
+        error_setg(errp, "Could not remove breakpoint %s: %s",
+                   argv[1], strerror(-ret));
         return ret;
     }
 
@@ -2665,13 +2676,13 @@ static const cmdinfo_t remove_break_cmd = {
        .oneline        = "remove a breakpoint by tag",
 };
 
-static int resume_f(BlockBackend *blk, int argc, char **argv)
+static int resume_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int ret;
 
     ret = bdrv_debug_resume(blk_bs(blk), argv[1]);
     if (ret < 0) {
-        printf("Could not resume request: %s\n", strerror(-ret));
+        error_setg(errp, "Could not resume request: %s", strerror(-ret));
         return ret;
     }
 
@@ -2687,7 +2698,7 @@ static const cmdinfo_t resume_cmd = {
        .oneline        = "resumes the request tagged as tag",
 };
 
-static int wait_break_f(BlockBackend *blk, int argc, char **argv)
+static int wait_break_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     while (!bdrv_debug_is_suspended(blk_bs(blk), argv[1])) {
         aio_poll(blk_get_aio_context(blk), true);
@@ -2704,7 +2715,7 @@ static const cmdinfo_t wait_break_cmd = {
        .oneline        = "waits for the suspension of a request",
 };
 
-static int abort_f(BlockBackend *blk, int argc, char **argv)
+static int abort_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     abort();
 }
@@ -2730,7 +2741,7 @@ static void sigraise_help(void)
 "\n", SIGTERM);
 }
 
-static int sigraise_f(BlockBackend *blk, int argc, char **argv);
+static int sigraise_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t sigraise_cmd = {
     .name       = "sigraise",
@@ -2743,15 +2754,16 @@ static const cmdinfo_t sigraise_cmd = {
     .help       = sigraise_help,
 };
 
-static int sigraise_f(BlockBackend *blk, int argc, char **argv)
+static int sigraise_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int64_t sig = cvtnum(argv[1]);
     if (sig < 0) {
-        print_cvtnum_err(sig, argv[1]);
+        set_cvtnum_err(sig, argv[1], errp);
         return sig;
     } else if (sig > NSIG) {
-        printf("signal argument '%s' is too large to be a valid signal\n",
-               argv[1]);
+        error_setg(errp,
+                   "signal argument '%s' is too large to be a valid signal",
+                   argv[1]);
         return -EINVAL;
     }
 
@@ -2772,7 +2784,7 @@ static void sleep_cb(void *opaque)
     *expired = true;
 }
 
-static int sleep_f(BlockBackend *blk, int argc, char **argv)
+static int sleep_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     char *endptr;
     long ms;
@@ -2781,7 +2793,7 @@ static int sleep_f(BlockBackend *blk, int argc, char **argv)
 
     ms = strtol(argv[1], &endptr, 0);
     if (ms < 0 || *endptr != '\0') {
-        printf("%s is not a valid number\n", argv[1]);
+        error_setg(errp, "%s is not a valid number", argv[1]);
         return -EINVAL;
     }
 
@@ -2833,7 +2845,7 @@ static void help_all(void)
     printf("\nUse 'help commandname' for extended help.\n");
 }
 
-static int help_f(BlockBackend *blk, int argc, char **argv)
+static int help_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     const cmdinfo_t *ct;
 
@@ -2844,7 +2856,7 @@ static int help_f(BlockBackend *blk, int argc, char **argv)
 
     ct = find_command(argv[1]);
     if (ct == NULL) {
-        printf("command %s not found\n", argv[1]);
+        error_setg(errp, "command %s not found", argv[1]);
         return -EINVAL;
     }
 
@@ -2867,7 +2879,7 @@ static const cmdinfo_t help_cmd = {
  * Called with aio context of blk acquired. Or with qemu_get_aio_context()
  * context acquired if blk is NULL.
  */
-int qemuio_command(BlockBackend *blk, const char *cmd)
+int qemuio_command(BlockBackend *blk, const char *cmd, Error **errp)
 {
     char *input;
     const cmdinfo_t *ct;
@@ -2880,9 +2892,9 @@ int qemuio_command(BlockBackend *blk, const char *cmd)
     if (c) {
         ct = find_command(v[0]);
         if (ct) {
-            ret = command(blk, ct, c, v);
+            ret = command(blk, ct, c, v, errp);
         } else {
-            fprintf(stderr, "command \"%s\" not found\n", v[0]);
+            error_setg(errp, "command \"%s\" not found", v[0]);
             ret = -EINVAL;
         }
     }
diff --git a/qemu-io.c b/qemu-io.c
index 8f2de83f3c8..598d5b1c9ca 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -68,7 +68,7 @@ static int get_eof_char(void)
 #endif
 }
 
-static int close_f(BlockBackend *blk, int argc, char **argv)
+static int close_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     blk_unref(qemuio_blk);
     qemuio_blk = NULL;
@@ -140,7 +140,7 @@ static void open_help(void)
 "\n");
 }
 
-static int open_f(BlockBackend *blk, int argc, char **argv);
+static int open_f(BlockBackend *blk, int argc, char **argv, Error **errp);
 
 static const cmdinfo_t open_cmd = {
     .name       = "open",
@@ -164,7 +164,7 @@ static QemuOptsList empty_opts = {
     },
 };
 
-static int open_f(BlockBackend *blk, int argc, char **argv)
+static int open_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     int flags = BDRV_O_UNMAP;
     int readonly = 0;
@@ -268,7 +268,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     return 0;
 }
 
-static int quit_f(BlockBackend *blk, int argc, char **argv)
+static int quit_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
     quit_qemu_io = true;
     return 0;
@@ -414,7 +414,14 @@ static void prep_fetchline(void *opaque)
 
 static int do_qemuio_command(const char *cmd)
 {
-    return qemuio_command(qemuio_blk, cmd);
+    Error *local_err = NULL;
+    int ret;
+
+    ret = qemuio_command(qemuio_blk, cmd, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 static int command_loop(void)
diff --git a/tests/qemu-iotests/004.out b/tests/qemu-iotests/004.out
index fb8593289f5..37da6024809 100644
--- a/tests/qemu-iotests/004.out
+++ b/tests/qemu-iotests/004.out
@@ -6,36 +6,36 @@ wrote 1048576/1048576 bytes at offset 133169152
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write into image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write at image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write past image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 pwrite past image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 writev past image boundary
-writev failed: Input/output error
+qemu-io: writev failed: Input/output error
 
 read before image boundary
 read 1048576/1048576 bytes at offset 133169152
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 read into image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 read at image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 read past image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 pread past image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 readv past image boundary
-readv failed: Input/output error
+qemu-io: readv failed: Input/output error
 *** done
diff --git a/tests/qemu-iotests/021.out b/tests/qemu-iotests/021.out
index 8533f8e58ae..dfdfeb50378 100644
--- a/tests/qemu-iotests/021.out
+++ b/tests/qemu-iotests/021.out
@@ -2,92 +2,92 @@ QA output created by 021
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 
 == testing writev -P -1 ==
--1 is not a valid pattern byte
+qemu-io: -1 is not a valid pattern byte
 
 == testing read -P -1 ==
--1 is not a valid pattern byte
+qemu-io: -1 is not a valid pattern byte
 
 == testing write -P -1 ==
--1 is not a valid pattern byte
+qemu-io: -1 is not a valid pattern byte
 
 == testing readv -P -1 ==
--1 is not a valid pattern byte
+qemu-io: -1 is not a valid pattern byte
 
 == testing aio_read -P -1 ==
--1 is not a valid pattern byte
+qemu-io: -1 is not a valid pattern byte
 
 == testing aio_write -P -1 ==
--1 is not a valid pattern byte
+qemu-io: -1 is not a valid pattern byte
 
 == testing writev -P 300 ==
-300 is not a valid pattern byte
+qemu-io: 300 is not a valid pattern byte
 
 == testing read -P 300 ==
-300 is not a valid pattern byte
+qemu-io: 300 is not a valid pattern byte
 
 == testing write -P 300 ==
-300 is not a valid pattern byte
+qemu-io: 300 is not a valid pattern byte
 
 == testing readv -P 300 ==
-300 is not a valid pattern byte
+qemu-io: 300 is not a valid pattern byte
 
 == testing aio_read -P 300 ==
-300 is not a valid pattern byte
+qemu-io: 300 is not a valid pattern byte
 
 == testing aio_write -P 300 ==
-300 is not a valid pattern byte
+qemu-io: 300 is not a valid pattern byte
 
 == testing writev -P 12m ==
-12m is not a valid pattern byte
+qemu-io: 12m is not a valid pattern byte
 
 == testing read -P 12m ==
-12m is not a valid pattern byte
+qemu-io: 12m is not a valid pattern byte
 
 == testing write -P 12m ==
-12m is not a valid pattern byte
+qemu-io: 12m is not a valid pattern byte
 
 == testing readv -P 12m ==
-12m is not a valid pattern byte
+qemu-io: 12m is not a valid pattern byte
 
 == testing aio_read -P 12m ==
-12m is not a valid pattern byte
+qemu-io: 12m is not a valid pattern byte
 
 == testing aio_write -P 12m ==
-12m is not a valid pattern byte
+qemu-io: 12m is not a valid pattern byte
 
 == testing writev -P 4k ==
-4k is not a valid pattern byte
+qemu-io: 4k is not a valid pattern byte
 
 == testing read -P 4k ==
-4k is not a valid pattern byte
+qemu-io: 4k is not a valid pattern byte
 
 == testing write -P 4k ==
-4k is not a valid pattern byte
+qemu-io: 4k is not a valid pattern byte
 
 == testing readv -P 4k ==
-4k is not a valid pattern byte
+qemu-io: 4k is not a valid pattern byte
 
 == testing aio_read -P 4k ==
-4k is not a valid pattern byte
+qemu-io: 4k is not a valid pattern byte
 
 == testing aio_write -P 4k ==
-4k is not a valid pattern byte
+qemu-io: 4k is not a valid pattern byte
 
 == testing writev -P route66 ==
-route66 is not a valid pattern byte
+qemu-io: route66 is not a valid pattern byte
 
 == testing read -P route66 ==
-route66 is not a valid pattern byte
+qemu-io: route66 is not a valid pattern byte
 
 == testing write -P route66 ==
-route66 is not a valid pattern byte
+qemu-io: route66 is not a valid pattern byte
 
 == testing readv -P route66 ==
-route66 is not a valid pattern byte
+qemu-io: route66 is not a valid pattern byte
 
 == testing aio_read -P route66 ==
-route66 is not a valid pattern byte
+qemu-io: route66 is not a valid pattern byte
 
 == testing aio_write -P route66 ==
-route66 is not a valid pattern byte
+qemu-io: route66 is not a valid pattern byte
 *** done
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 83989996ff6..b998a9ac83d 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -4,442 +4,442 @@ Errors while writing 128 kB
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: on; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: on; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: on; write
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Input/output error
-read failed: Input/output error
+qemu-io: write failed: Input/output error
+qemu-io: read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: on; write -b
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Input/output error
-read failed: Input/output error
+qemu-io: write failed: Input/output error
+qemu-io: read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: off; write
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Input/output error
-read failed: Input/output error
+qemu-io: write failed: Input/output error
+qemu-io: read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: off; write -b
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Input/output error
-read failed: Input/output error
+qemu-io: write failed: Input/output error
+qemu-io: read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 28; imm: off; once: on; write
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: No space left on device
-read failed: No space left on device
+qemu-io: write failed: No space left on device
+qemu-io: read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 28; imm: off; once: on; write -b
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: No space left on device
-read failed: No space left on device
+qemu-io: write failed: No space left on device
+qemu-io: read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 28; imm: off; once: off; write
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: No space left on device
-read failed: No space left on device
+qemu-io: write failed: No space left on device
+qemu-io: read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 28; imm: off; once: off; write -b
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: No space left on device
-read failed: No space left on device
+qemu-io: write failed: No space left on device
+qemu-io: read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: on; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: on; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write -b
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: on; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: on; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: on; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: on; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: off; write
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: off; write -b
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: on; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: on; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: off; write
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: on; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: on; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: on; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: on; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 5; imm: off; once: on; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 5; imm: off; once: on; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 5; imm: off; once: off; write
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 5; imm: off; once: off; write -b
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 28; imm: off; once: off; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 28; imm: off; once: off; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 
 === Refcount table growth tests ===
@@ -447,122 +447,122 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write -b
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 
 === L1 growth tests ===
@@ -570,76 +570,76 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_alloc_table; errno: 5; imm: off; once: on
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_alloc_table; errno: 5; imm: off; once: off
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_alloc_table; errno: 28; imm: off; once: on
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_alloc_table; errno: 28; imm: off; once: off
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: on
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: on
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: on
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
+qemu-io: write failed: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
-write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: on
-write failed: No space left on device
+qemu-io: write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
+qemu-io: write failed: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
-write failed: No space left on device
 No errors were found on the image.
 
 === Avoid cluster leaks after temporary failure ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
@@ -651,6 +651,6 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index a37bf446e94..27275fd6b70 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -9,7 +9,7 @@ ERROR cluster 3 refcount=1 reference=3
 Data may be corrupted, or further writes to the image may corrupt it.
 incompatible_features     []
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with active L1 table); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 incompatible_features     [1]
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -23,7 +23,7 @@ Format specific information:
     corrupt: true
     extended l2: false
 qemu-io: can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot be opened read/write
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -37,7 +37,7 @@ ERROR cluster 2 refcount=1 reference=2
 Data may be corrupted, or further writes to the image may corrupt it.
 incompatible_features     []
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with refcount block); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 incompatible_features     [1]
 ERROR refcount block 0 refcount=2
 ERROR cluster 2 refcount=1 reference=2
@@ -73,7 +73,7 @@ Data may be corrupted, or further writes to the image may corrupt it.
 This means waste of disk space, but no harm to data.
 incompatible_features     []
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with inactive L2 table); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 incompatible_features     [1]
 ERROR cluster 4 refcount=1 reference=2
 Leaked cluster 9 refcount=1 reference=0
@@ -108,10 +108,10 @@ wrote 65536/65536 bytes at offset 0
 wrote 65536/65536 bytes at offset 536870912
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with active L2 table); further corruption events will be suppressed
+qemu-io: write failed: Input/output error
+qemu-io: aio_write failed: No medium found
 blkdebug: Suspended request '0'
-write failed: Input/output error
 blkdebug: Resuming request '0'
-aio_write failed: No medium found
 
 === Testing unallocated image header ===
 
@@ -119,7 +119,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with qcow2_header); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 === Testing unaligned L1 entry ===
 
@@ -127,7 +127,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: L2 table offset 0x42a00 unaligned (L1 index: 0); further corruption events will be suppressed
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -140,7 +140,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Testing unaligned pre-allocated zero cluster ===
 
@@ -154,7 +154,7 @@ qemu-img: Failed to turn zero into data clusters: Input/output error
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Refblock offset 0x22a00 unaligned (reftable index: 0); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 === Testing non-fatal corruption on freeing ===
 
@@ -171,8 +171,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Image is corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further non-fatal corruption events will be suppressed
-read failed: Input/output error
-read failed: Input/output error
+qemu-io: read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Testing non-fatal and then fatal corruption report ===
 
@@ -181,15 +181,15 @@ wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Image is corrupt: Cannot free unaligned cluster 0x52a00; further non-fatal corruption events will be suppressed
 qcow2: Marking image as corrupt: Cluster allocation offset 0x62a00 unaligned (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
+qemu-io: read failed: Input/output error
 discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Input/output error
 
 === Testing empty refcount table ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with refcount table); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
@@ -209,7 +209,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid allocation of refcount block at offset 0; further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
@@ -229,7 +229,7 @@ No errors were found on the image.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 2 refcount=0 reference=1
@@ -251,7 +251,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 65536
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid allocation of compressed cluster at offset 0; further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 2 refcount=0 reference=1
@@ -286,7 +286,7 @@ No errors were found on the image.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 === Testing dirty corrupt image ===
 
@@ -319,7 +319,7 @@ wrote 65536/65536 bytes at offset 0
 discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preallocated zero cluster offset 0x2a00 unaligned (guest offset: 0); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 --- Repairing ---
 Repairing offset=2a00: Preallocated cluster is not properly aligned; L2 entry corrupted.
 The following inconsistencies were found and repaired:
@@ -337,7 +337,7 @@ wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Refblock offset 0x2a00 unaligned (reftable index: 0); further corruption events will be suppressed
 qcow2_free_clusters failed: Input/output error
-discard failed: No medium found
+qemu-io: discard failed: No medium found
 --- Repairing ---
 ERROR refcount block 0 is not cluster aligned; refcount table entry corrupted
 qcow2: Marking image as corrupt: Refblock offset 0x2a00 unaligned (reftable index: 0); further corruption events will be suppressed
@@ -419,8 +419,7 @@ qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps
 QMP_VERSION
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "none0", "msg": "Preventing invalid write on metadata (overlaps with refcount table)", "offset": 65536, "node-name": "drive", "fatal": true, "size": 65536}}
-write failed: Input/output error
-{"return": ""}
+{"return": "Error: write failed: Input/output error\r\n"}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 
@@ -431,7 +430,6 @@ QMP_VERSION
 {"return": {}}
 qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); further non-fatal corruption events will be suppressed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
-{"return": ""}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index a2923b05c29..f2d015d8cca 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -30,11 +30,11 @@ blkverify: read offset=0 bytes=512 contents mismatch at offset 0
 
 === Testing blkdebug through filename ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Testing blkdebug through file blockref ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Testing blkdebug on existing block device ===
 
@@ -43,8 +43,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-read failed: Input/output error
-{"return": ""}
+{"return": "Error: read failed: Input/output error\r\n"}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 
@@ -82,8 +81,7 @@ read 512/512 bytes at offset 0
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
-read failed: Input/output error
-{"return": ""}
+{"return": "Error: read failed: Input/output error\r\n"}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error
diff --git a/tests/qemu-iotests/072.out b/tests/qemu-iotests/072.out
index fe949d47817..d7ce24da1f7 100644
--- a/tests/qemu-iotests/072.out
+++ b/tests/qemu-iotests/072.out
@@ -15,7 +15,7 @@ read 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 1024
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Pattern verification failed at offset 0, 512 bytes
+qemu-io: Pattern verification failed at offset 0, 512 bytes
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index d8acb3e7235..b20c21faf6a 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -66,8 +66,8 @@ wrote 512/512 bytes at offset 0
 qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
 qemu-img: Snapshot L1 table offset invalid
 qemu-img: Failed to turn zero into data clusters: Invalid argument
+qemu-io: write failed: Invalid argument
 qemu-io: Failed to flush the refcount block cache: Invalid argument
-write failed: Invalid argument
 qemu-img: Snapshot L1 table offset invalid
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: Invalid argument
 qemu-img: Could not delete snapshot 'test': Snapshot L1 table offset invalid
@@ -89,8 +89,8 @@ wrote 512/512 bytes at offset 0
 qemu-img: Failed to load snapshot: Snapshot L1 table too large
 qemu-img: Snapshot L1 table too large
 qemu-img: Failed to turn zero into data clusters: File too large
+qemu-io: write failed: File too large
 qemu-io: Failed to flush the refcount block cache: File too large
-write failed: File too large
 qemu-img: Snapshot L1 table too large
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: File too large
 qemu-img: Could not delete snapshot 'test': Snapshot L1 table too large
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index aba85ea5644..bc902bd8183 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -81,7 +81,7 @@ wrote 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == checking that quorum is broken ==
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 == checking the blkverify mode with broken content ==
 quorum: offset=0 bytes=10485760 contents mismatch at offset 0
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index 2090ee693c1..a1c446d5365 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -41,7 +41,7 @@ qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect after neg2 ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect 8 neg2 ===
 
@@ -53,31 +53,31 @@ qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect before request ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect after request ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect before reply ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect after reply ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect 4 reply ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect 8 reply ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect before data ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect after data ===
 
@@ -106,7 +106,7 @@ qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
 
 === Check disconnect after neg-classic ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect before neg1 ===
 
@@ -150,7 +150,7 @@ qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect after neg2 ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect 8 neg2 ===
 
@@ -162,31 +162,31 @@ qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect before request ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect after request ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect before reply ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect after reply ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect 4 reply ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect 8 reply ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect before data ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Check disconnect after data ===
 
@@ -215,6 +215,6 @@ qemu-io: can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect after neg-classic ===
 
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 *** done
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index c53fc4823a1..a29e19b12d7 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -16,7 +16,7 @@ read 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 1024
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Pattern verification failed at offset 0, 512 bytes
+qemu-io: Pattern verification failed at offset 0, 512 bytes
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -33,7 +33,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 512/512 bytes at offset 229376
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 === Testing qemu-img info output ===
 
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index f51dd9d20a1..80220e440ec 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -11,7 +11,7 @@ cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: foo
 qemu-io: can't open device TEST_DIR/t.qcow2: Could not open backing file: Unknown driver 'foo'
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Could not change the backing file to 'TEST_DIR/t.qcow2.base': backing format must be specified
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 4abc5b5f7da..ce2a0df166e 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -24,7 +24,7 @@ read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == verify pattern failure with wrong password ==
-Pattern verification failed at offset 0, 134217728 bytes
+qemu-io: Pattern verification failed at offset 0, 134217728 bytes
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index e19df5b6ba8..1947c1a1bd7 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -40,5 +40,5 @@ OK: Dirty bit not set
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 *** done
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 28e1a22952b..e235d9e59e3 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -33,12 +33,12 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
 qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
 qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 _qemu_img_wrapper info TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
@@ -107,7 +107,7 @@ _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
 qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
@@ -176,7 +176,7 @@ _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
 qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
 
@@ -231,7 +231,7 @@ _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
 qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
@@ -336,7 +336,7 @@ _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
 qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index d1d77f70130..87a8aa24d96 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -188,7 +188,7 @@ img_offset=512
 img_size=512
 _make_test_img $size
 (
-$QEMU_IO "$(img_json)"  <<EOT
+$QEMU_IO "$(img_json)" 2>&1 <<EOT
 write -P 0x0a 0 512
 write -P 0x0a 511 1
 write -P 0x0a 512 1
diff --git a/tests/qemu-iotests/171.out b/tests/qemu-iotests/171.out
index ec3363b4f44..67ef9b88415 100644
--- a/tests/qemu-iotests/171.out
+++ b/tests/qemu-iotests/171.out
@@ -21,32 +21,32 @@ wrote 1/1 bytes at offset 3583
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write across image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write at image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write after image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 writev before/after image boundary
-writev failed: Input/output error
+qemu-io: writev failed: Input/output error
 
 read before image boundary
 read 1/1 bytes at offset 3583
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 read across image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 read at image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 read after image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 readv before/after image boundary
-readv failed: Input/output error
+qemu-io: readv failed: Input/output error
 
 fill image with pattern
 wrote 4096/4096 bytes at offset 0
@@ -60,7 +60,7 @@ read 4/4 bytes at offset 510
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write zeroes across image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write zeroes at image boundary and check
 wrote 2/2 bytes at offset 3582
@@ -68,7 +68,7 @@ wrote 2/2 bytes at offset 3582
 00000ffe:  00 00  ..
 read 2/2 bytes at offset 4094
 2 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 fill image with pattern
 wrote 4096/4096 bytes at offset 0
@@ -82,7 +82,7 @@ read 4/4 bytes at offset 510
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 discard across image boundary
-discard failed: Input/output error
+qemu-io: discard failed: Input/output error
 
 discard at image boundary and check
 discard 2/2 bytes at offset 3582
@@ -90,7 +90,7 @@ discard 2/2 bytes at offset 3582
 00000ffe:  00 00  ..
 read 2/2 bytes at offset 4094
 2 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 == test 'offset' and 'size' options ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4096
@@ -113,32 +113,32 @@ wrote 1/1 bytes at offset 2047
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write across image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write at image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write after image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 writev before/after image boundary
-writev failed: Input/output error
+qemu-io: writev failed: Input/output error
 
 read before image boundary
 read 1/1 bytes at offset 2047
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 read across image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 read at image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 read after image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 readv before/after image boundary
-readv failed: Input/output error
+qemu-io: readv failed: Input/output error
 
 fill image with pattern
 wrote 4096/4096 bytes at offset 0
@@ -152,7 +152,7 @@ read 4/4 bytes at offset 510
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write zeroes across image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write zeroes at image boundary and check
 wrote 2/2 bytes at offset 2046
@@ -176,7 +176,7 @@ read 4/4 bytes at offset 510
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 discard across image boundary
-discard failed: Input/output error
+qemu-io: discard failed: Input/output error
 
 discard at image boundary and check
 discard 2/2 bytes at offset 2046
@@ -209,32 +209,32 @@ wrote 1/1 bytes at offset 2047
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write across image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write at image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write after image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 writev before/after image boundary
-writev failed: Input/output error
+qemu-io: writev failed: Input/output error
 
 read before image boundary
 read 1/1 bytes at offset 2047
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 read across image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 read at image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 read after image boundary
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 readv before/after image boundary
-readv failed: Input/output error
+qemu-io: readv failed: Input/output error
 
 fill image with pattern
 wrote 4096/4096 bytes at offset 0
@@ -248,7 +248,7 @@ read 4/4 bytes at offset 8
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write zeroes across image boundary
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 write zeroes at image boundary and check
 wrote 2/2 bytes at offset 2046
@@ -272,7 +272,7 @@ read 4/4 bytes at offset 8
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 discard across image boundary
-discard failed: Input/output error
+qemu-io: discard failed: Input/output error
 
 discard at image boundary and check
 discard 2/2 bytes at offset 2046
@@ -290,12 +290,12 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1/1 bytes at offset 511
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1/1 bytes at offset 1023
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 checking boundaries
 000001fe:  00 00 0a 0a  ....
 read 4/4 bytes at offset 510
diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 78459065418..3ed3ed233ac 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -75,7 +75,7 @@ class TestNbdServerRemove(iotests.QMPTestCase):
 
     def assertReadFailed(self, qemu_io_output):
         self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
-                         'read failed: Input/output error')
+                         'qemu-io: read failed: Input/output error')
 
     def assertConnectFailed(self, qemu_io_output):
         self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
index 9fc67287f8e..26056938ee9 100644
--- a/tests/qemu-iotests/214.out
+++ b/tests/qemu-iotests/214.out
@@ -7,7 +7,7 @@ wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 No errors were found on the image.
 read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/220.out b/tests/qemu-iotests/220.out
index 33b994b8a14..6f200ec8947 100644
--- a/tests/qemu-iotests/220.out
+++ b/tests/qemu-iotests/220.out
@@ -38,7 +38,7 @@ wrote 2097152/2097152 bytes at offset 37748736
 No errors were found on the image.
 image size 39845888
 == Trying to write compressed cluster ==
-write failed: File too large
+qemu-io: write failed: File too large
 image size 562949957615616
 == Writing normal cluster ==
 wrote 2097152/2097152 bytes at offset 0
diff --git a/tests/qemu-iotests/225.out b/tests/qemu-iotests/225.out
index 0998ae094c2..beb8c23bd33 100644
--- a/tests/qemu-iotests/225.out
+++ b/tests/qemu-iotests/225.out
@@ -14,11 +14,11 @@ read 512/512 bytes at offset 0
 
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) qemu-io overlay "read 0 512"
-read failed: Invalid argument
+Error: read failed: Invalid argument
 
 === Testing non-VMDK backing image ===
 
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) qemu-io overlay "read 0 512"
-read failed: Invalid argument
+Error: read failed: Invalid argument
 *** done
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index c62f5aec25b..c5e62146c93 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -10,22 +10,22 @@ read 65536/65536 bytes at offset 0
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 Data file required, but without data file name in the image:
 qemu-io: can't open device TEST_DIR/t.qcow2: 'data-file' is required for this image
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 Setting data-file for an image with internal data:
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-io: can't open device TEST_DIR/t.qcow2: 'data-file' can only be set for images with an external data file
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
-no file open, try 'help open'
+qemu-io: no file open, try 'help open'
 
 === Conflicting features ===
 
@@ -37,7 +37,7 @@ qemu-img: error while writing at byte 0: Operation not supported
 
 Convert uncompressed, then write compressed data manually:
 Images are identical.
-write failed: Operation not supported
+qemu-io: write failed: Operation not supported
 No errors were found on the image.
 
 Take an internal snapshot:
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index d2bf9be85ea..3d37709a9ef 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 { 'execute': 'human-monitor-command',
        'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Block node is read-onlyrn"}
+{"return": "Error: Block node is read-onlyrn"}
 
 === Run block-commit on base using an invalid filter node name
 
@@ -24,7 +24,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 { 'execute': 'human-monitor-command',
        'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Block node is read-onlyrn"}
+{"return": "Error: Block node is read-onlyrn"}
 
 === Run block-commit on base using the default filter node name
 
@@ -43,5 +43,5 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 { 'execute': 'human-monitor-command',
        'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Block node is read-onlyrn"}
+{"return": "Error: Block node is read-onlyrn"}
 *** done
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
index 0b24d501595..da92d4b5b1a 100644
--- a/tests/qemu-iotests/271.out
+++ b/tests/qemu-iotests/271.out
@@ -456,7 +456,7 @@ L2 entry #0: 0x8000000000050001 0000000000000001
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x8000000000060000 00000001ffffffff
 qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 ### Corrupted L2 entries - read test (unallocated) ###
 
@@ -471,14 +471,14 @@ L2 entry #0: 0x0000000000000001 0000000000000000
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #0: 0x0000000000000000 0000000000000001
 qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 # Both 'subcluster is zero' and 'subcluster is allocated' bits set
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x0000000000000000 0000000100000001
 qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 ### Compressed cluster with subcluster bitmap != 0 - read test ###
 
@@ -501,7 +501,7 @@ L2 entry #0: 0x8000000000050001 0000000000000001
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x8000000000060000 00000001ffffffff
 qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 ### Corrupted L2 entries - write test (unallocated) ###
 
@@ -516,14 +516,14 @@ L2 entry #0: 0x8000000000060000 0000000000000001
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #0: 0x0000000000000000 0000000000000001
 qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 # Both 'subcluster is zero' and 'subcluster is allocated' bits set
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x0000000000000000 0000000100000001
 qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 ### Compressed cluster with subcluster bitmap != 0 - write test ###
 
@@ -555,7 +555,7 @@ Double checking the fixed image now...
 1 errors were found on the image.
 Data may be corrupted, or further writes to the image may corrupt it.
 qcow2: Marking image as corrupt: Cluster allocation offset 0x50200 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 # Corrupted L2 entry, no allocated subclusters #
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
 Repairing offset=50200: Preallocated cluster is not properly aligned; L2 entry corrupted.
diff --git a/tests/qemu-iotests/289.out b/tests/qemu-iotests/289.out
index e54e2629d4d..58e4f4942f0 100644
--- a/tests/qemu-iotests/289.out
+++ b/tests/qemu-iotests/289.out
@@ -3,6 +3,6 @@ QA output created by 289
 === Avoid freeing external data clusters on failure ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536 data_file=TEST_DIR/t.IMGFMT.data_file
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/305.out b/tests/qemu-iotests/305.out
index 538019e7260..af09d6a3ff4 100644
--- a/tests/qemu-iotests/305.out
+++ b/tests/qemu-iotests/305.out
@@ -12,5 +12,5 @@ discard 1024/1024 bytes at offset 125952
 ### Corrupt the offset of the second refcount block
 ### Try to allocate the discarded clusters again
 qcow2: Marking image as corrupt: Refblock offset 0x20600 unaligned (reftable index: 0x1); further corruption events will be suppressed
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 *** done
diff --git a/tests/qemu-iotests/307.out b/tests/qemu-iotests/307.out
index a9b37d3ac11..608b407a6fc 100644
--- a/tests/qemu-iotests/307.out
+++ b/tests/qemu-iotests/307.out
@@ -127,7 +127,7 @@ exports available: 1
 {"error": {"class": "GenericError", "desc": "export 'export1' still in use"}}
 {"execute": "block-export-del", "arguments": {"id": "export1", "mode": "hard"}}
 {"return": {}}
-read failed: Input/output error
+qemu-io: read failed: Input/output error
 
 {"execute": "query-block-exports", "arguments": {}}
 {"return": []}
diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
index 17fef9c6d34..6c624bc8b0b 100755
--- a/tests/qemu-iotests/tests/backup-discard-source
+++ b/tests/qemu-iotests/tests/backup-discard-source
@@ -87,11 +87,11 @@ class TestBackup(iotests.QMPTestCase):
 
     def tearDown(self):
         # That should fail, because region is discarded
-        self.vm.hmp_qemu_io('access', 'read 0 1M')
+        result = self.vm.hmp_qemu_io('access', 'read 0 1M')
 
         self.vm.shutdown()
 
-        self.assertTrue('read failed: Permission denied' in self.vm.get_log())
+        self.assertIn('read failed: Permission denied', result['return'])
 
         # Final check that temp image is empty
         mapping = qemu_img_map(temp_img)
diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index 236cb8ac374..3e43e7127f2 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -87,17 +87,17 @@ class TestCbwError(iotests.QMPTestCase):
 
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io cbw "write 0 1M"')
-        self.assert_qmp(result, 'return', '')
+        write_res = result['return']
 
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io access "read 0 1M"')
-        self.assert_qmp(result, 'return', '')
+        read_res = result['return']
 
         self.vm.shutdown()
         log = self.vm.get_log()
         log = iotests.filter_qtest(log)
         log = iotests.filter_qemu_io(log)
-        return log
+        return log, write_res, read_res
 
     def do_cbw_error_via_blockdev_backup(self, on_cbw_error=None):
         self.vm.cmd('blockdev-add', {
@@ -150,28 +150,29 @@ class TestCbwError(iotests.QMPTestCase):
 
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io cbw "write 0 1M"')
-        self.assert_qmp(result, 'return', '')
+        write_res = result['return']
 
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io access "read 0 1M"')
-        self.assert_qmp(result, 'return', '')
+        read_res = result['return']
 
         self.vm.shutdown()
         log = self.vm.get_log()
         log = iotests.filter_qemu_io(log)
-        return log
+        return log, write_res, read_res
 
     def test_break_snapshot_on_cbw_error(self):
         """break-snapshot behavior:
         Guest write succeed, but further snapshot-read fails, as snapshot is
         broken.
         """
-        log = self.do_cbw_error('break-snapshot')
+        log, write_res, read_res = self.do_cbw_error('break-snapshot')
+        self.assertEqual(write_res, '')
+        self.assertIn('read failed: Permission denied', read_res)
 
         self.assertEqual(log, """\
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Permission denied
 """)
 
     def test_break_guest_write_on_cbw_error(self):
@@ -179,10 +180,11 @@ read failed: Permission denied
         Guest write fails, but snapshot-access continues working and further
         snapshot-read succeeds.
         """
-        log = self.do_cbw_error('break-guest-write')
+        log, write_res, read_res = self.do_cbw_error('break-guest-write')
+        self.assertIn('write failed: Input/output error', write_res)
+        self.assertEqual(read_res, '')
 
         self.assertEqual(log, """\
-write failed: Input/output error
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
@@ -191,20 +193,24 @@ read 1048576/1048576 bytes at offset 0
         """Ensure CBW filter accepts break-snapshot policy
         specified in blockdev-backup QMP command.
         """
-        log = self.do_cbw_error_via_blockdev_backup('break-snapshot')
+        log, write_res, read_res = \
+            self.do_cbw_error_via_blockdev_backup('break-snapshot')
+        self.assertEqual(write_res, '')
+        self.assertIn('read failed: Permission denied', read_res)
         self.assertEqual(log, """\
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Permission denied
 """)
 
     def test_break_guest_write_policy_forwarding(self):
         """Ensure CBW filter accepts break-guest-write policy
         specified in blockdev-backup QMP command.
         """
-        log = self.do_cbw_error_via_blockdev_backup('break-guest-write')
+        log, write_res, read_res = \
+            self.do_cbw_error_via_blockdev_backup('break-guest-write')
+        self.assertIn('write failed: Input/output error', write_res)
+        self.assertEqual(read_res, '')
         self.assertEqual(log, """\
-write failed: Input/output error
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
@@ -213,9 +219,11 @@ read 1048576/1048576 bytes at offset 0
         """Ensure break-guest-write policy is used by default when
         on-cbw-error is not explicitly specified.
         """
-        log = self.do_cbw_error_via_blockdev_backup()
+        log, write_res, read_res = \
+            self.do_cbw_error_via_blockdev_backup()
+        self.assertIn('write failed: Input/output error', write_res)
+        self.assertEqual(read_res, '')
         self.assertEqual(log, """\
-write failed: Input/output error
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
@@ -260,47 +268,53 @@ read 1048576/1048576 bytes at offset 0
 
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io cbw "write 0 512K"')
-        self.assert_qmp(result, 'return', '')
+        write1_res = result['return']
 
         # We need second write to trigger throttling
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io cbw "write 512K 512K"')
-        self.assert_qmp(result, 'return', '')
+        write2_res = result['return']
 
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io access "read 0 1M"')
-        self.assert_qmp(result, 'return', '')
+        read_res = result['return']
 
         self.vm.shutdown()
         log = self.vm.get_log()
         log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
         log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
         log = iotests.filter_qemu_io(log)
-        return log
+        return log, write1_res, write2_res, read_res
 
     def test_timeout_break_guest(self):
-        log = self.do_cbw_timeout('break-guest-write')
+        log, write1_res, write2_res, read_res = \
+            self.do_cbw_timeout('break-guest-write')
+        self.assertEqual(write1_res, '')
         # macOS and FreeBSD tend to represent ETIMEDOUT as
         # "Operation timed out", when Linux prefer
         # "Connection timed out"
-        log = log.replace('Operation timed out',
-                          'Connection timed out')
+        write2_res = write2_res.replace('Operation timed out',
+                                        'Connection timed out')
+        self.assertIn('write failed: Connection timed out', write2_res)
+        self.assertEqual(read_res, '')
         self.assertEqual(log, """\
 wrote 524288/524288 bytes at offset 0
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Connection timed out
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
 
     def test_timeout_break_snapshot(self):
-        log = self.do_cbw_timeout('break-snapshot')
+        log, write1_res, write2_res, read_res = \
+            self.do_cbw_timeout('break-snapshot')
+        self.assertEqual(write1_res, '')
+        self.assertEqual(write2_res, '')
+        self.assertIn('read failed: Permission denied', read_res)
         self.assertEqual(log, """\
 wrote 524288/524288 bytes at offset 0
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 524288/524288 bytes at offset 524288
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Permission denied
 """)
 
 
diff --git a/tests/qemu-iotests/tests/file-io-error.out b/tests/qemu-iotests/tests/file-io-error.out
index 0f46455a94a..bf8c0018ba5 100644
--- a/tests/qemu-iotests/tests/file-io-error.out
+++ b/tests/qemu-iotests/tests/file-io-error.out
@@ -21,7 +21,7 @@ QA output created by file-io-error
       }}
 {"return": {}}
 
-write failed: Input/output error
+qemu-io: write failed: Input/output error
 
 {'execute': 'block-export-del',
       'arguments': {'id': 'exp0'}}
diff --git a/tests/qemu-iotests/tests/image-fleecing.out b/tests/qemu-iotests/tests/image-fleecing.out
index acfc89ff0e9..dc788f1e20a 100644
--- a/tests/qemu-iotests/tests/image-fleecing.out
+++ b/tests/qemu-iotests/tests/image-fleecing.out
@@ -238,13 +238,13 @@ read -P0xd5 1M 64k
 read -P0xdc 32M 64k
 read -P0xcd 0x3ff0000 64k
 read -P0 0x00f8000 32k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 read -P0 0x2010000 32k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 read -P0 0x3fe0000 64k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 
 --- Testing COW ---
@@ -265,13 +265,13 @@ read -P0xd5 1M 64k
 read -P0xdc 32M 64k
 read -P0xcd 0x3ff0000 64k
 read -P0 0x00f8000 32k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 read -P0 0x2010000 32k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 read -P0 0x3fe0000 64k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 
 --- Cleanup ---
diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
index a458b4fc055..0fb8c18d874 100644
--- a/tests/qemu-iotests/tests/inactive-node-nbd.out
+++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
@@ -215,13 +215,13 @@ target-fmt active: True
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
-write failed: Operation not permitted
+qemu-io: write failed: Operation not permitted
 
-write failed: Operation not permitted
+qemu-io: write failed: Operation not permitted
 
-write failed: Operation not permitted
+qemu-io: write failed: Operation not permitted
 
-discard failed: Operation not permitted
+qemu-io: discard failed: Operation not permitted
 
 
 qemu-io: Failed to get allocation status: Operation not permitted

-- 
2.54.0


