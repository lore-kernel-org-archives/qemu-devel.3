Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C503CA601D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCZv-0001Yq-58; Fri, 09 Oct 2026 11:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ0-0001Rx-1W
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCYy-0007zQ-4G
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791559871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUM3C45s1SojI5HXslRhO+jefZG1IMb2lB5VwEKWEsE=;
 b=fLCJoxeVsnQZ9FACIl/o/l28uMt5xqzeJX5fUWRhQ22b6E1iliJ8XZwa9OvLZKO9u7jz5/
 D2hWedSmle8OBn/dt4xnEZFa/5J77oQpKf304Jr3jwGkezE+SbkubVCN1PT4zhBi+H0ILS
 hE46tXbsIzAp19bDZ3DsAEx69soBJqo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-o-qHirSCMWuPLMvP78vi-w-1; Fri,
 9 Oct 2026 15:31:07 +0000
X-MC-Unique: o-qHirSCMWuPLMvP78vi-w-1
X-Mimecast-MFC-AGG-ID: o-qHirSCMWuPLMvP78vi-w_1791559866
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C4091955E8D; Fri,  9 Oct 2026 15:31:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4176C1956086; Fri,  9 Oct 2026 15:31:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: akalenyu@redhat.com, <qemu-block@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 4/8] qemu-pr-helper: add PR_HELPER_CLEANUP for live migration
Date: Fri,  9 Oct 2026 11:30:54 -0400
Message-ID: <20261009153058.1089786-5-stefanha@redhat.com>
In-Reply-To: <20261009153058.1089786-1-stefanha@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce a new vendor-specific SCSI command that acts similar to
REGISTER AND IGNORE EXISTING KEY but also discards multipathd's state
(including /etc/multipath/prkeys). This command will be used on the
source after live migration completes successfully.

This cleanup step is necessary because multipathd will register the key
it has stored when the path comes up again. This is undesirable when the
guest has migrated to another host and can interfere with the migration
process or the application running inside the guest.

Add a qemu-pr-manager protocol feature bit indicating that the new
PR_HELPER_CLEANUP command is available. The command has no CDB fields
other than OPCODE and the response contains no data aside from the usual
result and sense data.

Note that the linker needs an explicit libmpathcmd dependency for
mpath_disconnect() even though qemu-pr-helper.c already #included the
mpath_cmd.h header before.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build              |   2 +
 include/scsi/constants.h |   1 +
 scsi/pr-helper.h         |   3 +
 scsi/qemu-pr-helper.c    | 146 ++++++++++++++++++++++++++++++++++++---
 4 files changed, 143 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 828100de816..34038eb8e52 100644
--- a/meson.build
+++ b/meson.build
@@ -1486,6 +1486,8 @@ if host_os == 'linux' and have_tools and get_option('mpath').allowed()
     endif
     mpathlibs += cc.find_library('multipath',
                                  required: get_option('mpath'))
+    mpathlibs += cc.find_library('mpathcmd',
+                                 required: get_option('mpath'))
     foreach lib: mpathlibs
       if not lib.found()
         mpathlibs = []
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 717e470a5d4..bb3981a779b 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -149,6 +149,7 @@
 #define MECHANISM_STATUS      0xbd
 #define READ_CD               0xbe
 #define SEND_DVD_STRUCTURE    0xbf
+#define PR_HELPER_CLEANUP     0xff /* vendor-specific QEMU command */
 
 /*
  * SERVICE ACTION IN subcodes
diff --git a/scsi/pr-helper.h b/scsi/pr-helper.h
index e26e104ec76..d088d0dc193 100644
--- a/scsi/pr-helper.h
+++ b/scsi/pr-helper.h
@@ -31,6 +31,9 @@
 #define PR_HELPER_SENSE_SIZE   96
 #define PR_HELPER_DATA_SIZE    8192
 
+/* Protocol features */
+#define PR_HELPER_FEATURE_CLEANUP (1u << 0)
+
 typedef struct PRHelperResponse {
     int32_t result;
     int32_t sz;
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9dcd3ec7111..fdbb4748dc0 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -537,6 +537,110 @@ static int coroutine_fn multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *se
                                      paramp, noisy, verbose);
     return mpath_reconstruct_sense(fd, r, sense);
 }
+
+/* Get the device-mapper device name given its block device fd */
+static char *get_dm_name(int fd, Error **errp)
+{
+    struct stat st;
+    int ret;
+
+    assert(is_mpath(fd));
+
+    ret = fstat(fd, &st);
+    if (ret != 0) {
+        error_setg_errno(errp, errno, "fstat failed on fd %d", fd);
+        return NULL;
+    }
+
+    return g_strdup_printf("dm-%u", minor(st.st_rdev));
+}
+
+/* Perform a multipathd command */
+static bool multipathd_cmd(int fd, const char *cmd, Error **errp)
+{
+    const unsigned int timeout_ms = 60000;
+    char *reply = NULL;
+    int last_errno;
+    int ret;
+
+    ret = mpath_process_cmd(fd, cmd, &reply, timeout_ms);
+    last_errno = errno;
+    if (reply && strcmp(reply, "ok\n") != 0) {
+        error_setg(errp, "mpath_process_cmd(%d, \"%s\") replied \"%s\"",
+                   fd, cmd, reply);
+        free(reply);
+        return false;
+    }
+    free(reply);
+    if (ret == -1) {
+        error_setg_errno(errp, last_errno,
+                         "mpath_process_cmd(%d, \"%s\") failed",
+                         fd, cmd);
+        return false;
+    }
+    return true;
+}
+
+/* Unregister so this I_T nexus has no key registered anymore */
+static int coroutine_fn multipath_pr_cleanup_unregister(int fd, uint8_t *sense,
+                                                        Error **errp)
+{
+    uint8_t cdb[PR_HELPER_CDB_SIZE] = {};
+    uint8_t param[PR_OUT_FIXED_PARAM_SIZE] = {};
+
+    /* Fill in CDB */
+    cdb[0] = PERSISTENT_RESERVE_OUT;               /* OPERATION CODE */
+    cdb[1] = PRO_REGISTER_AND_IGNORE_EXISTING_KEY; /* SERVICE ACTION */
+    stl_be_p(&cdb[5], sizeof(param));              /* PARAMETER LIST LENGTH */
+
+    /* The parameter list is all zeroes, so there is nothing to fill in */
+
+    return multipath_pr_out(fd, cdb, sense, param, sizeof(param));
+}
+
+/*
+ * A special version of REGISTER AND IGNORE EXISTING KEY with sark=0 to
+ * unregister the key without triggering multipathd's preemption. This succeeds
+ * when no key is registered too. This is essential so the migration source
+ * cleans up its registered key without multipathd preempting the destination
+ * host.
+ */
+static int coroutine_fn multipath_pr_cleanup(int bdev_fd, uint8_t *sense,
+                                             Error **errp)
+{
+    g_autofree char *bdev_dm_name = get_dm_name(bdev_fd, errp);
+    g_autofree char *cmd = NULL;
+    int multipathd_fd;
+
+    if (bdev_dm_name == NULL) {
+        return -1;
+    }
+
+    /* First make multipathd the key and reservation state */
+    multipathd_fd = mpath_connect();
+    if (multipathd_fd == -1) {
+        error_setg_errno(errp, errno, "mpath_connect() failed");
+        return -1;
+    }
+
+    cmd = g_strdup_printf("unsetprkey map %s", bdev_dm_name);
+    if (!multipathd_cmd(multipathd_fd, cmd, errp)) {
+        mpath_disconnect(multipathd_fd);
+        return -1;
+    }
+
+    g_free(cmd);
+    cmd = g_strdup_printf("unsetprstatus map %s", bdev_dm_name);
+    if (!multipathd_cmd(multipathd_fd, cmd, errp)) {
+        mpath_disconnect(multipathd_fd);
+        return -1;
+    }
+
+    mpath_disconnect(multipathd_fd);
+
+    /* Now unregister the key at the SCSI level */
+    return multipath_pr_cleanup_unregister(bdev_fd, sense, errp);
+}
 #endif
 
 static int coroutine_fn do_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
@@ -578,6 +682,21 @@ static int coroutine_fn do_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
                    SG_DXFER_TO_DEV);
 }
 
+static int coroutine_fn do_pr_cleanup(int fd, uint8_t *sense, Error **errp)
+{
+    if ((fcntl(fd, F_GETFL) & O_ACCMODE) == O_RDONLY) {
+        scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
+        return CHECK_CONDITION;
+    }
+
+#ifdef CONFIG_MPATH
+    if (is_mpath(fd)) {
+        return multipath_pr_cleanup(fd, sense, errp);
+    }
+#endif
+    return GOOD;
+}
+
 /* Client */
 
 typedef struct PRHelperClient {
@@ -667,7 +786,8 @@ static int coroutine_fn prh_read_request(PRHelperClient *client,
     }
 
     if (req->cdb[0] != PERSISTENT_RESERVE_OUT &&
-        req->cdb[0] != PERSISTENT_RESERVE_IN) {
+        req->cdb[0] != PERSISTENT_RESERVE_IN &&
+        req->cdb[0] != PR_HELPER_CLEANUP) {
         error_setg(errp, "Invalid CDB, closing socket.");
         goto out_close;
     }
@@ -703,7 +823,8 @@ static int coroutine_fn prh_write_response(PRHelperClient *client,
     ssize_t r;
     size_t sz;
 
-    if (req->cdb[0] == PERSISTENT_RESERVE_IN && resp->result == GOOD) {
+    if (req->cdb[0] == PERSISTENT_RESERVE_IN &&
+        resp->result == GOOD) {
         assert(resp->sz <= req->sz && resp->sz <= sizeof(client->data));
     } else {
         assert(resp->sz == 0);
@@ -739,10 +860,8 @@ static void coroutine_fn prh_co_entry(void *opaque)
 
     qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
 
-    /* A very simple negotiation for future extensibility.  No features
-     * are defined so write 0.
-     */
-    flags = cpu_to_be32(0);
+    /* A very simple negotiation for future extensibility */
+    flags = cpu_to_be32(PR_HELPER_FEATURE_CLEANUP);
     r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
                              (char *) &flags, sizeof(flags), NULL);
     if (r < 0) {
@@ -751,7 +870,7 @@ static void coroutine_fn prh_co_entry(void *opaque)
 
     r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
                              (char *) &flags, sizeof(flags), NULL);
-    if (be32_to_cpu(flags) != 0 || r < 0) {
+    if ((be32_to_cpu(flags) & ~PR_HELPER_FEATURE_CLEANUP) != 0 || r < 0) {
         goto out;
     }
 
@@ -766,15 +885,24 @@ static void coroutine_fn prh_co_entry(void *opaque)
         }
 
         num_active_sockets++;
-        if (req.cdb[0] == PERSISTENT_RESERVE_OUT) {
+        switch (req.cdb[0]) {
+        case PERSISTENT_RESERVE_OUT:
             r = do_pr_out(req.fd, req.cdb, resp.sense,
                           client->data, sz);
             resp.sz = 0;
-        } else {
+            break;
+        case PERSISTENT_RESERVE_IN:
             resp.sz = sizeof(client->data);
             r = do_pr_in(req.fd, req.cdb, resp.sense,
                          client->data, &resp.sz);
             resp.sz = MIN(resp.sz, sz);
+            break;
+        case PR_HELPER_CLEANUP:
+            r = do_pr_cleanup(req.fd, resp.sense, &local_err);
+            resp.sz = 0;
+            break;
+        default:
+            abort();
         }
         num_active_sockets--;
         close(req.fd);
-- 
2.56.0


