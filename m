Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B43C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1srv-00068D-Dk; Tue, 30 Apr 2024 15:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1s1srf-00060H-VR
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:10:10 -0400
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1s1src-0001Ju-14
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1714504202;
 bh=VoXco0VTUWsxUHXd9gn9oBIKxv+dNXTDC7mY7RZddWI=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
 b=McI0Iljk1KtCKzZapvCjn5GteWP2HMCS2o4lllMpRlMnX90gtS0y9j0ztlruHFvMe
 XXftNb68goxcl7mNB9ynGV4sDLu62c1gqNgzbm9ktrVFcW6uECVtpVsq875NSrQfjo
 yrZI/1vQ1O6tpEkfulKoGc9jRqKqsWjo5/j5tUJg=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id DC4A31281392;
 Tue, 30 Apr 2024 15:10:02 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 2SiK18G9NmeL; Tue, 30 Apr 2024 15:10:02 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 397EF1280087;
 Tue, 30 Apr 2024 15:10:02 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 1/2] tpm: convert tpmdev options processing to new visitor
 format
Date: Tue, 30 Apr 2024 15:08:54 -0400
Message-Id: <20240430190855.2811-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
References: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:fcd0:100:8a00::2;
 envelope-from=James.Bottomley@HansenPartnership.com;
 helo=bedivere.hansenpartnership.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Instead of processing the tpmdev options using the old qemu options,
convert to the new visitor format which also allows the passing of
json on the command line.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

---
v4: add TpmConfiOptions
v5: exit(0) for help
v7: adjust line lengths, free options
v8: minor updates; add tested/reviewed-by
v9: optarg->optstr
---
 backends/tpm/tpm_emulator.c    | 25 ++++------
 backends/tpm/tpm_passthrough.c | 23 +++------
 include/sysemu/tpm.h           |  5 +-
 include/sysemu/tpm_backend.h   |  2 +-
 qapi/tpm.json                  | 21 ++++++++
 system/tpm.c                   | 91 ++++++++++++++--------------------
 system/vl.c                    | 19 +------
 7 files changed, 81 insertions(+), 105 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 5a8fba9bde..99ab0019cc 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -580,33 +580,29 @@ err_exit:
     return -1;
 }
 
-static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
+static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu,
+                                           TpmCreateOptions *opts)
 {
-    const char *value;
     Error *err = NULL;
     Chardev *dev;
 
-    value = qemu_opt_get(opts, "chardev");
-    if (!value) {
-        error_report("tpm-emulator: parameter 'chardev' is missing");
-        goto err;
-    }
+    tpm_emu->options = QAPI_CLONE(TPMEmulatorOptions, &opts->u.emulator);
+    tpm_emu->data_ioc = NULL;
 
-    dev = qemu_chr_find(value);
+    dev = qemu_chr_find(opts->u.emulator.chardev);
     if (!dev) {
-        error_report("tpm-emulator: tpm chardev '%s' not found", value);
+        error_report("tpm-emulator: tpm chardev '%s' not found",
+                     opts->u.emulator.chardev);
         goto err;
     }
 
     if (!qemu_chr_fe_init(&tpm_emu->ctrl_chr, dev, &err)) {
         error_prepend(&err, "tpm-emulator: No valid chardev found at '%s':",
-                      value);
+                      opts->u.emulator.chardev);
         error_report_err(err);
         goto err;
     }
 
-    tpm_emu->options->chardev = g_strdup(value);
-
     if (tpm_emulator_prepare_data_fd(tpm_emu) < 0) {
         goto err;
     }
@@ -645,7 +641,7 @@ err:
     return -1;
 }
 
-static TPMBackend *tpm_emulator_create(QemuOpts *opts)
+static TPMBackend *tpm_emulator_create(TpmCreateOptions *opts)
 {
     TPMBackend *tb = TPM_BACKEND(object_new(TYPE_TPM_EMULATOR));
 
@@ -968,7 +964,6 @@ static void tpm_emulator_inst_init(Object *obj)
 
     trace_tpm_emulator_inst_init();
 
-    tpm_emu->options = g_new0(TPMEmulatorOptions, 1);
     tpm_emu->cur_locty_number = ~0;
     qemu_mutex_init(&tpm_emu->mutex);
     tpm_emu->vmstate =
@@ -985,7 +980,7 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
 {
     ptm_res res;
 
-    if (!tpm_emu->options->chardev) {
+    if (!tpm_emu->data_ioc) {
         /* was never properly initialized */
         return;
     }
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index 179697a3a9..54183b89a4 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -252,21 +252,13 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
 }
 
 static int
-tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt, QemuOpts *opts)
+tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt,
+                                   TpmCreateOptions *opts)
 {
-    const char *value;
+    tpm_pt->options = QAPI_CLONE(TPMPassthroughOptions, &opts->u.passthrough);
 
-    value = qemu_opt_get(opts, "cancel-path");
-    if (value) {
-        tpm_pt->options->cancel_path = g_strdup(value);
-    }
-
-    value = qemu_opt_get(opts, "path");
-    if (value) {
-        tpm_pt->options->path = g_strdup(value);
-    }
-
-    tpm_pt->tpm_dev = value ? value : TPM_PASSTHROUGH_DEFAULT_DEVICE;
+    tpm_pt->tpm_dev = opts->u.passthrough.path ? opts->u.passthrough.path :
+            TPM_PASSTHROUGH_DEFAULT_DEVICE;
     tpm_pt->tpm_fd = qemu_open_old(tpm_pt->tpm_dev, O_RDWR);
     if (tpm_pt->tpm_fd < 0) {
         error_report("Cannot access TPM device using '%s': %s",
@@ -288,11 +280,11 @@ tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt, QemuOpts *opts)
     return 0;
 }
 
-static TPMBackend *tpm_passthrough_create(QemuOpts *opts)
+static TPMBackend *tpm_passthrough_create(TpmCreateOptions *tco)
 {
     Object *obj = object_new(TYPE_TPM_PASSTHROUGH);
 
-    if (tpm_passthrough_handle_device_opts(TPM_PASSTHROUGH(obj), opts)) {
+    if (tpm_passthrough_handle_device_opts(TPM_PASSTHROUGH(obj), tco)) {
         object_unref(obj);
         return NULL;
     }
@@ -344,7 +336,6 @@ static void tpm_passthrough_inst_init(Object *obj)
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(obj);
 
-    tpm_pt->options = g_new0(TPMPassthroughOptions, 1);
     tpm_pt->tpm_fd = -1;
     tpm_pt->cancel_fd = -1;
 }
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 1ee568b3b6..e9ac0e0a3a 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -17,8 +17,9 @@
 
 #ifdef CONFIG_TPM
 
-int tpm_config_parse(QemuOptsList *opts_list, const char *optstr);
-int tpm_init(void);
+void tpm_config_parse(const char *optstr);
+void tpm_init(void);
+
 void tpm_cleanup(void);
 
 typedef enum TPMVersion {
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 7fabafefee..56b80cddbe 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -57,7 +57,7 @@ struct TPMBackendClass {
     /* get a descriptive text of the backend to display to the user */
     const char *desc;
 
-    TPMBackend *(*create)(QemuOpts *opts);
+    TPMBackend *(*create)(TpmCreateOptions *tco);
 
     /* start up the TPM on the backend - optional */
     int (*startup_tpm)(TPMBackend *t, size_t buffersize);
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 1577b5c259..5604553b7d 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -142,6 +142,27 @@
             'emulator': 'TPMEmulatorOptionsWrapper' },
   'if': 'CONFIG_TPM' }
 
+##
+# @TpmCreateOptions:
+#
+# A union referencing different TPM backend types' configuration options
+#   without the wrapper to be usable by visitors.
+#
+# @type: - 'passthrough' The configuration options for the TPM passthrough type
+#        - 'emulator' The configuration options for TPM emulator backend type
+#
+# @id: The Id of the TPM
+#
+# Since: 9.0
+##
+{ 'union': 'TpmCreateOptions',
+  'base': { 'type': 'TpmType',
+            'id' : 'str' },
+  'discriminator': 'type',
+  'data': { 'passthrough' : 'TPMPassthroughOptions',
+            'emulator': 'TPMEmulatorOptions' },
+  'if': 'CONFIG_TPM' }
+
 ##
 # @TPMInfo:
 #
diff --git a/system/tpm.c b/system/tpm.c
index 7164ea7ff1..8d00f79b65 100644
--- a/system/tpm.c
+++ b/system/tpm.c
@@ -17,14 +17,26 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-tpm.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-tpm.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/help_option.h"
 
 static QLIST_HEAD(, TPMBackend) tpm_backends =
     QLIST_HEAD_INITIALIZER(tpm_backends);
 
+typedef struct TpmCreateOptionsQueueEntry {
+        TpmCreateOptions *tco;
+        QSIMPLEQ_ENTRY(TpmCreateOptionsQueueEntry) entry;
+} TpmCreateOptionsQueueEntry;
+
+typedef QSIMPLEQ_HEAD(, TpmCreateOptionsQueueEntry) TpmCreateOptionsQueue;
+
+static TpmCreateOptionsQueue tco_queue = QSIMPLEQ_HEAD_INITIALIZER(tco_queue);
+
 static const TPMBackendClass *
 tpm_be_find_by_type(enum TpmType type)
 {
@@ -84,63 +96,31 @@ TPMBackend *qemu_find_tpm_be(const char *id)
     return NULL;
 }
 
-static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
+static void tpm_init_tpmdev(TpmCreateOptions *tco)
 {
-    /*
-     * Use of error_report() in a function with an Error ** parameter
-     * is suspicious.  It is okay here.  The parameter only exists to
-     * make the function usable with qemu_opts_foreach().  It is not
-     * actually used.
-     */
-    const char *value;
-    const char *id;
     const TPMBackendClass *be;
     TPMBackend *drv;
-    Error *local_err = NULL;
-    int i;
 
     if (!QLIST_EMPTY(&tpm_backends)) {
         error_report("Only one TPM is allowed.");
-        return 1;
+        exit(1);
     }
 
-    id = qemu_opts_id(opts);
-    if (id == NULL) {
-        error_report(QERR_MISSING_PARAMETER, "id");
-        return 1;
-    }
-
-    value = qemu_opt_get(opts, "type");
-    if (!value) {
-        error_report(QERR_MISSING_PARAMETER, "type");
-        tpm_display_backend_drivers();
-        return 1;
-    }
-
-    i = qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
-    be = i >= 0 ? tpm_be_find_by_type(i) : NULL;
+    be = tco->type >= 0 ? tpm_be_find_by_type(tco->type) : NULL;
     if (be == NULL) {
         error_report(QERR_INVALID_PARAMETER_VALUE,
                      "type", "a TPM backend type");
         tpm_display_backend_drivers();
-        return 1;
-    }
-
-    /* validate backend specific opts */
-    if (!qemu_opts_validate(opts, be->opts, &local_err)) {
-        error_report_err(local_err);
-        return 1;
+        exit(1);
     }
 
-    drv = be->create(opts);
+    drv = be->create(tco);
     if (!drv) {
-        return 1;
+        exit(1);
     }
 
-    drv->id = g_strdup(id);
+    drv->id = g_strdup(tco->id);
     QLIST_INSERT_HEAD(&tpm_backends, drv, list);
-
-    return 0;
 }
 
 /*
@@ -161,33 +141,36 @@ void tpm_cleanup(void)
  * Initialize the TPM. Process the tpmdev command line options describing the
  * TPM backend.
  */
-int tpm_init(void)
+void tpm_init(void)
 {
-    if (qemu_opts_foreach(qemu_find_opts("tpmdev"),
-                          tpm_init_tpmdev, NULL, NULL)) {
-        return -1;
-    }
+    while (!QSIMPLEQ_EMPTY(&tco_queue)) {
+        TpmCreateOptionsQueueEntry *tcoqe = QSIMPLEQ_FIRST(&tco_queue);
 
-    return 0;
+        QSIMPLEQ_REMOVE_HEAD(&tco_queue, entry);
+        tpm_init_tpmdev(tcoqe->tco);
+        qapi_free_TpmCreateOptions(tcoqe->tco);
+        g_free(tcoqe);
+    }
 }
 
 /*
  * Parse the TPM configuration options.
  * To display all available TPM backends the user may use '-tpmdev help'
  */
-int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
+void tpm_config_parse(const char *optstr)
 {
-    QemuOpts *opts;
+    Visitor *v;
+    TpmCreateOptionsQueueEntry *tcqe;
 
-    if (!strcmp(optstr, "help")) {
+    if (is_help_option(optstr)) {
         tpm_display_backend_drivers();
-        return -1;
-    }
-    opts = qemu_opts_parse_noisily(opts_list, optstr, true);
-    if (!opts) {
-        return -1;
+        exit(0);
     }
-    return 0;
+    v = qobject_input_visitor_new_str(optstr, "type", &error_fatal);
+    tcqe = g_new(TpmCreateOptionsQueueEntry, 1);
+    visit_type_TpmCreateOptions(v, NULL, &tcqe->tco, &error_fatal);
+    visit_free(v);
+    QSIMPLEQ_INSERT_TAIL(&tco_queue, tcqe, entry);
 }
 
 /*
diff --git a/system/vl.c b/system/vl.c
index 7756eac81e..f2b4630daa 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -330,16 +330,6 @@ static QemuOptsList qemu_object_opts = {
     },
 };
 
-static QemuOptsList qemu_tpmdev_opts = {
-    .name = "tpmdev",
-    .implied_opt_name = "type",
-    .head = QTAILQ_HEAD_INITIALIZER(qemu_tpmdev_opts.head),
-    .desc = {
-        /* options are defined in the TPM backends */
-        { /* end of list */ }
-    },
-};
-
 static QemuOptsList qemu_overcommit_opts = {
     .name = "overcommit",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_overcommit_opts.head),
@@ -2023,9 +2013,7 @@ static void qemu_create_late_backends(void)
         exit(1);
     }
 
-    if (tpm_init() < 0) {
-        exit(1);
-    }
+    tpm_init();
 
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
@@ -2767,7 +2755,6 @@ void qemu_init(int argc, char **argv)
     qemu_add_opts(&qemu_boot_opts);
     qemu_add_opts(&qemu_add_fd_opts);
     qemu_add_opts(&qemu_object_opts);
-    qemu_add_opts(&qemu_tpmdev_opts);
     qemu_add_opts(&qemu_overcommit_opts);
     qemu_add_opts(&qemu_msg_opts);
     qemu_add_opts(&qemu_name_opts);
@@ -3014,9 +3001,7 @@ void qemu_init(int argc, char **argv)
                 break;
 #ifdef CONFIG_TPM
             case QEMU_OPTION_tpmdev:
-                if (tpm_config_parse(qemu_find_opts("tpmdev"), optarg) < 0) {
-                    exit(1);
-                }
+                tpm_config_parse(optarg);
                 break;
 #endif
             case QEMU_OPTION_mempath:
-- 
2.35.3


