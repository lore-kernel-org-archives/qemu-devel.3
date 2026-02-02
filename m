Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375A3E7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn11W-0005V2-0K; Mon, 02 Feb 2026 15:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn11T-0005J5-S7; Mon, 02 Feb 2026 15:59:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn11Q-0003rX-Uw; Mon, 02 Feb 2026 15:59:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C186B18519A;
 Mon, 02 Feb 2026 23:57:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8755735B311;
 Mon, 02 Feb 2026 23:58:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 14/74] Fix const qualifier build errors with recent
 glibc
Date: Mon,  2 Feb 2026 23:57:25 +0300
Message-ID: <20260202205833.941615-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

A recent change in glibc 2.42.9000 [1] changes the return type of
strstr() and other string functions to be 'const char *' when the
input is a 'const char *'.

This breaks the build in various files with errors such as :

  error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
    208 |         char *pidstr = strstr(filename, "%");
        |                        ^~~~~~

Fix this by changing the type of the variables that store the result
of these functions to 'const char *'.

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251209174328.698774-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 326e620fc0145686124f754194cdc6d0d9b3400d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index b7c7074c2a..a9f35ab7d6 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -211,7 +211,7 @@ static size_t tpm_passthrough_get_buffer_size(TPMBackend *tb)
 static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
 {
     int fd = -1;
-    char *dev;
+    const char *dev;
     char path[PATH_MAX];
 
     if (tpm_pt->options->cancel_path) {
diff --git a/block/vmdk.c b/block/vmdk.c
index 7b98debc2b..64051d55aa 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1089,7 +1089,7 @@ vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
 static int vmdk_parse_description(const char *desc, const char *opt_name,
         char *buf, int buf_size)
 {
-    char *opt_pos, *opt_end;
+    const char *opt_pos, *opt_end;
     const char *end = desc + strlen(desc);
 
     opt_pos = strstr(desc, opt_name);
diff --git a/block/vvfat.c b/block/vvfat.c
index 814796d918..e334b9febb 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1826,7 +1826,7 @@ cluster_was_modified(BDRVVVFATState *s, uint32_t cluster_num)
 
 static const char* get_basename(const char* path)
 {
-    char* basename = strrchr(path, '/');
+    const char *basename = strrchr(path, '/');
     if (basename == NULL)
         return path;
     else
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index dd5fb5667c..5b2fc06e58 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -362,7 +362,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
      * qXfer:features:read:ANNEX:OFFSET,LENGTH'
      *                     ^p    ^newp
      */
-    char *term = strchr(p, ':');
+    const char *term = strchr(p, ':');
     *newp = term + 1;
     len = term - p;
 
diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 4a09ddc760..c639a60a94 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -403,7 +403,8 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
     int i, offset, nhosts = 0, pcilen;
     GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
-    char *p, *driver = NULL;
+    const char *p;
+    char *driver = NULL;
     bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
@@ -543,7 +544,7 @@ static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,
                                                  Error **errp)
 {
     unsigned int tgt[3];
-    char *p;
+    const char *p;
 
     if (!strstr(syspath, "/virtio") || !strstr(syspath, "/block")) {
         g_debug("Unsupported virtio device '%s'", syspath);
@@ -575,7 +576,7 @@ static bool build_guest_fsinfo_for_ccw_dev(char const *syspath,
                                            Error **errp)
 {
     unsigned int cssid, ssid, subchno, devno;
-    char *p;
+    const char *p;
 
     p = strstr(syspath, "/devices/css");
     if (!p || sscanf(p + 12, "%*x/%x.%x.%x/%*x.%*x.%x/",
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 980a8bbc51..6c93d452c9 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -418,7 +418,7 @@ err_out:
 void sendkey_completion(ReadLineState *rs, int nb_args, const char *str)
 {
     int i;
-    char *sep;
+    const char *sep;
     size_t len;
 
     if (nb_args != 2) {
diff --git a/util/log.c b/util/log.c
index abdcb6b311..33917625d5 100644
--- a/util/log.c
+++ b/util/log.c
@@ -203,7 +203,7 @@ static ValidFilenameTemplateResult
 valid_filename_template(const char *filename, bool per_thread, Error **errp)
 {
     if (filename) {
-        char *pidstr = strstr(filename, "%");
+        const char *pidstr = strstr(filename, "%");
 
         if (pidstr) {
             /* We only accept one %d, no other format strings */
-- 
2.47.3


