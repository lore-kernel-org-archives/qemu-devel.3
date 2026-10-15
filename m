Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62594CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ7K-0000Gt-6S; Thu, 15 Oct 2026 06:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6s-0008Hh-B0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6m-00082F-Qq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Nz/IIV44Jhty5e4VkO8qqTs4vYZFX8F8M8ro4QBM9o=;
 b=EfU01Z5Ca1WKWfgmotzw7BBSX5Mjkg0ceLILOVV1/Y0qi4w1d39Jrvfcwp3D0EG1CluNR3
 Scz6xd3yKzp+N6gfs8vDn7ij+/CWtZFukEyJBTngHczFvtxBsigkj46ABgl4QS6o3d5W7Z
 9Dro+68RU1OGsf6qFhgt46x8ZnvZ7H4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-PXMdhRRlNAOREHh8w_JtNg-1; Thu, 15 Oct 2026 10:54:46 +0000
X-MC-Unique: PXMdhRRlNAOREHh8w_JtNg-1
X-Mimecast-MFC-AGG-ID: PXMdhRRlNAOREHh8w_JtNg_1792061685
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b01a74792so3400240f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061685; x=1792666485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Nz/IIV44Jhty5e4VkO8qqTs4vYZFX8F8M8ro4QBM9o=;
 b=I9oSLvnsWJRMZDAYcXoaZul5ExjUWUMb4jrZfIYVEfLhYO9OTIFkvkIous12qr0cCZ
 nTsU3B/Kx+7PLDxIpHX9iXUnvOZQkw6J3m6PRfreuKrN+npt4AmCBl7xg4HWRXQLRhZQ
 +NQKaY2ale0AUfXlq2N4gWAwJ7Bz/opR9hmkALVuTNujt2rj/eu/eeBrYAnydagpMwXh
 mgs5X7rc9GOFe2J44g898JWu9mmJ/wvkSK0JoJqruLJ6z2ilBg0S9L2MzkKaxZE34f9D
 GYucR1uLoO2i5rV0e6bcSWGumb9eX1nSr2HZCYb0K9L2MwwalW8gKu3n9lShyw2sT87Z
 CRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061685; x=1792666485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Nz/IIV44Jhty5e4VkO8qqTs4vYZFX8F8M8ro4QBM9o=;
 b=SmgN20yEdm4T83Ds6ArjddBscSFeZecbwt4Um/+xJwOPUlRRLNRPPtr8jrXJNxaVgs
 J6gKplctdhdHyT5J7oMxxH3uX8btObJ+a/N7KymcaEvXBkAbbzDjJBvspWFxMRB/z3fC
 C0pflA7nejPsjR77eUq6dgXEfKmp6sX1Hqx4RuFG8mcD6TcUEgYqyOmbQU3rKkPDOMck
 C7uXg93Hdmic7QHhZRJKUCB50EG2HjTUBky2B8uN9fELUPeQuCDQ7azdnYfY3TG88dSs
 I3HGzs9fLPtlV8rXojrfMsIIElOzSbG2TAVSd3s5ZcB3VbCiiz/V0k8bFhYgsyVt/EXQ
 wYhA==
X-Gm-Message-State: AFq9FYL5aR0B1YCnyNB3/8X1zscdQUSSJwo8Wzv9WPNa3ZFUj9bWdlup
 IgsB4y1b1laAfgh+Yd4Dg9tO/6Ly3WOUdpJTceIKPsXwn0He06EN4vyDsOWUPiqyGnliArQmC0h
 NgIUaWyHqu0Bydgzo0nNqMTcdfM9NKuN3q2JtV3Rmm6KcfAMXLTON5ttwbBkfuGytFjABcfLgOS
 +o84o/zSGr5yqeZkbKk6a97CJVcqr3h2BI5ZFOzibr
X-Gm-Gg: AYBFou1qAQ+hfKn8XTsnh4xzphShhAoNDk7GXGhDjGuAGHVfB4Cwg3LBJfdodyD4gpR
 gr9eaJipMvFe8/lKOmQpBZUQs2kqYLl0R+fl25/ao56G7GbqEx7sNeph3kFxHOl8bIboSm8Gw8s
 RJP51ETT+iY5IGWAMmjWF4iFJO0awWQxO4Pmfk+FsGhrEgVwKPnTMdzWD/QY1+59mYYQ4qaW9Eg
 X68Hx4vD1HgBEyas3jjdNpnQ5QJK3g/5gYd63UrD4kcF60Y16889Kr3iBvFgtbIPhtaJkP+eq9k
 g34XHnBWeOJL28gfV+S6futoFD+pTLy1AeXKjje7fhxSOkRsTRGrk90x+wlJym/zxmq+cBv7Jda
 X+8kdTD7871MpqOwkpjX4nrMqHvYm/TJjdY9S3tQ9IZRwpmYrx6u9GRQvz+B1J1MlZkHL1jpqPv
 gDuUJu
X-Received: by 2002:adf:e189:0:b0:48d:f72a:339c with SMTP id
 ffacd0b85a97d-48df72a34bamr2642948f8f.57.1792061685274; 
 Thu, 15 Oct 2026 03:54:45 -0700 (PDT)
X-Received: by 2002:adf:e189:0:b0:48d:f72a:339c with SMTP id
 ffacd0b85a97d-48df72a34bamr2642888f8f.57.1792061684763; 
 Thu, 15 Oct 2026 03:54:44 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df2619703sm5257015f8f.24.2026.10.15.03.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:54:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 08/13] qemu-pr-helper: add PR_HELPER_CLEANUP for live migration
Date: Thu, 15 Oct 2026 12:53:42 +0200
Message-ID: <20261015105347.827029-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261013181752.1299456-5-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build              |   2 +
 include/scsi/constants.h |   1 +
 scsi/pr-helper.h         |   3 +
 hw/scsi/scsi-bus.c       |  10 +++
 scsi/qemu-pr-helper.c    | 146 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 153 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 48da6cf3e6b..6176935082b 100644
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
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index aa02ff631b7..b4c38c083e1 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -873,6 +873,16 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
           */
          !(buf[0] == REQUEST_SENSE && d->sense_is_ua))) {
         ops = &reqops_unit_attention;
+    } else if (buf[0] == PR_HELPER_CLEANUP) {
+        /*
+         * This is a QEMU-internal vendor-specific SCSI command that must only
+         * be submitted directly via blk_aio_ioctl() and not through SCSI
+         * emulation. Reject the command explicitly to guarantee a guest cannot
+         * execute it, although vendor-specific commands are not supported by
+         * SCSI emulation (including passthrough) anyway.
+         */
+        trace_scsi_req_parse_bad(d->id, lun, tag, buf[0]);
+        goto invalid_opcode;
     } else if (lun != d->lun ||
                buf[0] == REPORT_LUNS ||
                (buf[0] == REQUEST_SENSE && d->sense_len)) {
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9dcd3ec7111..54d196a503f 100644
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
+    /* First make multipathd forget the key and reservation state */
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


