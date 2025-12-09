Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84FDD3B98A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 17:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT1kY-0004sg-3P; Tue, 09 Dec 2025 12:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vT1kW-0004sO-CZ
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 12:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vT1kU-0004ow-Hh
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 12:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765302220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ht8Hrb0K7b3OXqLoq/zycCaul1imXwo7ft/STeI7H3g=;
 b=FSyhQsVwEffwiwNdtILZNxrHhVfYoqis54i6onkR+VV1FA5XLJwevC/CVJyJlZDWSbkb9K
 25T3ZCiH4SGdnL8DfjuDzj+RWfdXNeN+0u39cP69mkDQabk4KZxqGyQ2JdoeEk8r5jON0E
 th72d/LJqpKB2tBKKg0GJoEEE2Urqw8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-1Vpan_moM4KxzEqIzcR9DA-1; Tue,
 09 Dec 2025 12:43:37 -0500
X-MC-Unique: 1Vpan_moM4KxzEqIzcR9DA-1
X-Mimecast-MFC-AGG-ID: 1Vpan_moM4KxzEqIzcR9DA_1765302216
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52B7D1956050; Tue,  9 Dec 2025 17:43:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 309D130001A8; Tue,  9 Dec 2025 17:43:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3] Fix const qualifier build errors with recent glibc
Date: Tue,  9 Dec 2025 18:43:28 +0100
Message-ID: <20251209174328.698774-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---

 Most changes are straight forward apart from vubr_parse_host_port.
 Please check.

 Thanks,

 C.

 backends/tpm/tpm_passthrough.c | 2 +-
 block/vmdk.c                   | 2 +-
 block/vvfat.c                  | 2 +-
 gdbstub/gdbstub.c              | 2 +-
 qga/commands-linux.c           | 7 ++++---
 tests/vhost-user-bridge.c      | 2 +-
 ui/ui-hmp-cmds.c               | 2 +-
 util/log.c                     | 2 +-
 8 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index b7c7074c2aa3b0d7c1ed70cbcdb83b78fbd7dce8..a9f35ab7d606c79e148620b1a3e6b1d2bde63b7f 100644
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
index 3b35b63cb5982364f40192eeb2c8585a0265ee40..89e89cd10e3594ad5be044b819ef4b875614e60a 100644
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
index 814796d9185f14183194e0421b8c3ef052c81543..e334b9febb16056b3549558666e20bfddc3a22d6 100644
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
index dd5fb5667ccd3bd4a303fb3f1b442f230cb44ffb..5b2fc06e58dffeabc9ef3b949d95b583c197e5fd 100644
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
index 4a09ddc760cc794be52e0d28fb6e3574d3827442..c639a60a9415c46abe5a2c8ca46dff5669cfdc43 100644
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
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index a5c711b1de8e9c164dd1614f4329b8e3c05d0402..019424c2be8df8c8b5c8b6670574bb74cc7ba927 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -744,7 +744,7 @@ vubr_run(VubrDev *dev)
 }
 
 static int
-vubr_parse_host_port(const char **host, const char **port, const char *buf)
+vubr_parse_host_port(const char **host, const char **port, char *buf)
 {
     char *p = strchr(buf, ':');
 
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 980a8bbc518c72d000873d63d06dff9ab7b41395..6c93d452c9c43fe72561f036ebc41ab080a83285 100644
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
index 41f78ce86b2522b8b7072c8b76d8e18603142db6..c44d66b5ce78338cf1b2cd26b7503cb94d4570cb 100644
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
2.52.0


