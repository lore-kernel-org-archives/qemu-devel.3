Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30C8CFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTWX-00005c-6i; Wed, 07 Jan 2026 08:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdTWT-0008QB-9S
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdTWQ-0005Vv-MF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767792261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=kHXcfqUpdUadtzjstg1lmm3/GgEIWG1dn0oWD2mhTp0=;
 b=HlUq41huGHuGGv+0RNWqw8CorkncMxDsSOqZMov//dG8g6MK1JakEcuhkxqXsEXBT3fkgH
 bO2m2OKuvL1UUfI0YpYGHJtKGk1OTL1Eb7kel+nCG1Fo+BaO0FsaYQaa1LmzFAIYQ6AuS5
 m+AA0kMazOKH3Ut7mvTWw46egEm+piQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-bKOuzTQ4MFyE5M2BSUfRZA-1; Wed,
 07 Jan 2026 08:24:17 -0500
X-MC-Unique: bKOuzTQ4MFyE5M2BSUfRZA-1
X-Mimecast-MFC-AGG-ID: bKOuzTQ4MFyE5M2BSUfRZA_1767792257
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B94251955E77; Wed,  7 Jan 2026 13:24:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 365F230002D1; Wed,  7 Jan 2026 13:24:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEEC921E6934; Wed, 07 Jan 2026 14:24:13 +0100 (CET)
Resent-To: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 dave@treblig.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 07 Jan 2026 14:24:13 +0100
Resent-Message-ID: <87344himiq.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Jan  7 13:43:41 2026
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F00321E61BB; Wed, 07 Jan 2026 13:43:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 12/17] error: Use error_setg_file_open() for simplicity and
 consistency
Date: Wed,  7 Jan 2026 13:43:36 +0100
Message-ID: <20260107124341.1093312-13-armbru@redhat.com>
In-Reply-To: <20260107124341.1093312-1-armbru@redhat.com>
References: <20260107124341.1093312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Replace

    error_setg_errno(errp, errno, MSG, FNAME);

by

    error_setg_file_open(errp, errno, FNAME);

where MSG is "Could not open '%s'" or similar.

Also replace equivalent uses of error_setg().

A few messages lose prefixes ("net dump: ", "SEV: ", __func__ ": ").
We could put them back with error_prepend().  Not worth the bother.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-ID: <20251121121438.1249498-11-armbru@redhat.com>
[Conflict with commit 26b4a6ffe7f (monitor/hmp: Merge
hmp-cmds-target.c within hmp-cmds.c) resolved]
---
 hw/9pfs/9p-local.c       | 2 +-
 hw/acpi/core.c           | 2 +-
 hw/core/loader.c         | 2 +-
 hw/pci-host/xen_igd_pt.c | 2 +-
 monitor/hmp-cmds.c       | 2 +-
 net/dump.c               | 2 +-
 net/tap-bsd.c            | 6 +++---
 net/tap-linux.c          | 2 +-
 target/i386/sev.c        | 6 ++----
 util/vfio-helpers.c      | 5 ++---
 10 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 31e216227c..376b377698 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1456,7 +1456,7 @@ static int local_init(FsContext *ctx, Error **errp)
 
     data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
     if (data->mountfd == -1) {
-        error_setg_errno(errp, errno, "failed to open '%s'", ctx->fs_root);
+        error_setg_file_open(errp, errno, ctx->fs_root);
         goto err;
     }
 
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 2b74bed882..4e030d8e3b 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -277,7 +277,7 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
         int fd = open(*cur, O_RDONLY | O_BINARY);
 
         if (fd < 0) {
-            error_setg(errp, "can't open file %s: %s", *cur, strerror(errno));
+            error_setg_file_open(errp, errno, *cur);
             goto out;
         }
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 89d67d2760..16c11a4643 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -380,7 +380,7 @@ bool load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
 
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "Failed to open file: %s", filename);
+        error_setg_file_open(errp, errno, filename);
         return false;
     }
     if (read(fd, hdr, EI_NIDENT) != EI_NIDENT) {
diff --git a/hw/pci-host/xen_igd_pt.c b/hw/pci-host/xen_igd_pt.c
index 5dd17ef236..f6016f2cd5 100644
--- a/hw/pci-host/xen_igd_pt.c
+++ b/hw/pci-host/xen_igd_pt.c
@@ -55,7 +55,7 @@ static void host_pci_config_read(int pos, int len, uint32_t *val, Error **errp)
 
     config_fd = open(path, O_RDWR);
     if (config_fd < 0) {
-        error_setg_errno(errp, errno, "Failed to open: %s", path);
+        error_setg_file_open(errp, errno, path);
         goto out;
     }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index f7ff6ec90e..5a673cddb2 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -740,7 +740,7 @@ static uint64_t vtop(void *ptr, Error **errp)
 
     fd = open("/proc/self/pagemap", O_RDONLY);
     if (fd == -1) {
-        error_setg_errno(errp, errno, "Cannot open /proc/self/pagemap");
+        error_setg_file_open(errp, errno, "/proc/self/pagemap");
         return -1;
     }
 
diff --git a/net/dump.c b/net/dump.c
index 581234b775..0c39f09892 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -111,7 +111,7 @@ static int net_dump_state_init(DumpState *s, const char *filename,
 
     fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY | O_BINARY, 0644);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "net dump: can't open %s", filename);
+        error_setg_file_open(errp, errno, filename);
         return -1;
     }
 
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index bbf84d1828..3fd300d46f 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -68,7 +68,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
         }
     }
     if (fd < 0) {
-        error_setg_errno(errp, errno, "could not open %s", dname);
+        error_setg_file_open(errp, errno, dname);
         return -1;
     }
 
@@ -118,7 +118,7 @@ static int tap_open_clone(char *ifname, int ifname_size, Error **errp)
 
     fd = RETRY_ON_EINTR(open(PATH_NET_TAP, O_RDWR));
     if (fd < 0) {
-        error_setg_errno(errp, errno, "could not open %s", PATH_NET_TAP);
+        error_setg_file_open(errp, errno, PATH_NET_TAP);
         return -1;
     }
 
@@ -166,7 +166,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
         snprintf(dname, sizeof dname, "/dev/%s", ifname);
         fd = RETRY_ON_EINTR(open(dname, O_RDWR));
         if (fd < 0 && errno != ENOENT) {
-            error_setg_errno(errp, errno, "could not open %s", dname);
+            error_setg_file_open(errp, errno, dname);
             return -1;
         }
     }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 2a90b58467..909c4f1fcf 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -57,7 +57,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     if (fd < 0) {
         fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
         if (fd < 0) {
-            error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN);
+            error_setg_file_open(errp, errno, PATH_NET_TUN);
             return -1;
         }
     }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fb5a3b5d77..1d70f96ec1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -892,8 +892,7 @@ static SevCapability *sev_get_capabilities(Error **errp)
 
     fd = open(sev_device, O_RDWR);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "SEV: Failed to open %s",
-                         sev_device);
+        error_setg_file_open(errp, errno, sev_device);
         g_free(sev_device);
         return NULL;
     }
@@ -1820,8 +1819,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     devname = object_property_get_str(OBJECT(sev_common), "sev-device", NULL);
     sev_common->sev_fd = open(devname, O_RDWR);
     if (sev_common->sev_fd < 0) {
-        error_setg(errp, "%s: Failed to open %s '%s'", __func__,
-                   devname, strerror(errno));
+        error_setg_file_open(errp, errno, devname);
         g_free(devname);
         return -1;
     }
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 44b457c442..c619516163 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -309,7 +309,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     s->container = open("/dev/vfio/vfio", O_RDWR);
 
     if (s->container == -1) {
-        error_setg_errno(errp, errno, "Failed to open /dev/vfio/vfio");
+        error_setg_file_open(errp, errno, "/dev/vfio/vfio");
         return -errno;
     }
     if (ioctl(s->container, VFIO_GET_API_VERSION) != VFIO_API_VERSION) {
@@ -333,8 +333,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
 
     s->group = open(group_file, O_RDWR);
     if (s->group == -1) {
-        error_setg_errno(errp, errno, "Failed to open VFIO group file: %s",
-                         group_file);
+        error_setg_file_open(errp, errno, group_file);
         g_free(group_file);
         ret = -errno;
         goto fail_container;
-- 
2.52.0



