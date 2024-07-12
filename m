Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C022C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGHO-00031x-AQ; Fri, 12 Jul 2024 09:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHA-0002AH-U7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGH6-0003ku-JN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720790723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUn1UsHO5lwBdEAr8Dk++qFef7WJuUYdQh18Vqp4Zcg=;
 b=dCC+RrS24AgO6k9H8GJu70+2EhHF4mq2sLEPi2TUdSxE9nba7TryL/8jJcfen2qX3HgakM
 /pjg3GmVebTHEJ/5/iEG3vZo9fzb1btyjjMf9MuJKjRjCro27byL5A5nz8O2X8MdIx+shp
 ebzBIVCrrExyy+TKKyoXW7PlIiJ16MM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-yCq2yZO_MI-JQRHmIL4UXg-1; Fri,
 12 Jul 2024 09:25:21 -0400
X-MC-Unique: yCq2yZO_MI-JQRHmIL4UXg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32E281955F44; Fri, 12 Jul 2024 13:25:20 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6ADE51955F40; Fri, 12 Jul 2024 13:25:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v3 04/22] qga: move linux fs/disk command impls to
 commands-linux.c
Date: Fri, 12 Jul 2024 14:24:41 +0100
Message-ID: <20240712132459.3974109-5-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-1-berrange@redhat.com>
References: <20240712132459.3974109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The qmp_guest_{fstrim, get_fsinfo, get_disks} command impls in
commands-posix.c are surrounded by '#ifdef __linux__' so should
instead live in commands-linux.c

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-linux.c | 904 ++++++++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c | 909 -------------------------------------------
 2 files changed, 904 insertions(+), 909 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 3fabf54882..084e6c9e85 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -14,10 +14,21 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qga-qapi-commands.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "commands-common.h"
 #include "cutils.h"
 #include <mntent.h>
 #include <sys/ioctl.h>
+#include <mntent.h>
+#include <linux/nvme_ioctl.h>
+#include "block/nvme.h"
+
+#ifdef CONFIG_LIBUDEV
+#include <libudev.h>
+#endif
+
+#include <sys/statvfs.h>
 
 #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
 static int dev_major_minor(const char *devpath,
@@ -286,6 +297,899 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
 }
 #endif /* CONFIG_FSFREEZE */
 
+#if defined(CONFIG_FSFREEZE)
+
+static char *get_pci_driver(char const *syspath, int pathlen, Error **errp)
+{
+    char *path;
+    char *dpath;
+    char *driver = NULL;
+    char buf[PATH_MAX];
+    ssize_t len;
+
+    path = g_strndup(syspath, pathlen);
+    dpath = g_strdup_printf("%s/driver", path);
+    len = readlink(dpath, buf, sizeof(buf) - 1);
+    if (len != -1) {
+        buf[len] = 0;
+        driver = g_path_get_basename(buf);
+    }
+    g_free(dpath);
+    g_free(path);
+    return driver;
+}
+
+static int compare_uint(const void *_a, const void *_b)
+{
+    unsigned int a = *(unsigned int *)_a;
+    unsigned int b = *(unsigned int *)_b;
+
+    return a < b ? -1 : a > b ? 1 : 0;
+}
+
+/* Walk the specified sysfs and build a sorted list of host or ata numbers */
+static int build_hosts(char const *syspath, char const *host, bool ata,
+                       unsigned int *hosts, int hosts_max, Error **errp)
+{
+    char *path;
+    DIR *dir;
+    struct dirent *entry;
+    int i = 0;
+
+    path = g_strndup(syspath, host - syspath);
+    dir = opendir(path);
+    if (!dir) {
+        error_setg_errno(errp, errno, "opendir(\"%s\")", path);
+        g_free(path);
+        return -1;
+    }
+
+    while (i < hosts_max) {
+        entry = readdir(dir);
+        if (!entry) {
+            break;
+        }
+        if (ata && sscanf(entry->d_name, "ata%d", hosts + i) == 1) {
+            ++i;
+        } else if (!ata && sscanf(entry->d_name, "host%d", hosts + i) == 1) {
+            ++i;
+        }
+    }
+
+    qsort(hosts, i, sizeof(hosts[0]), compare_uint);
+
+    g_free(path);
+    closedir(dir);
+    return i;
+}
+
+/*
+ * Store disk device info for devices on the PCI bus.
+ * Returns true if information has been stored, or false for failure.
+ */
+static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
+                                           GuestDiskAddress *disk,
+                                           Error **errp)
+{
+    unsigned int pci[4], host, hosts[8], tgt[3];
+    int i, nhosts = 0, pcilen;
+    GuestPCIAddress *pciaddr = disk->pci_controller;
+    bool has_ata = false, has_host = false, has_tgt = false;
+    char *p, *q, *driver = NULL;
+    bool ret = false;
+
+    p = strstr(syspath, "/devices/pci");
+    if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
+                     pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
+        g_debug("only pci device is supported: sysfs path '%s'", syspath);
+        return false;
+    }
+
+    p += 12 + pcilen;
+    while (true) {
+        driver = get_pci_driver(syspath, p - syspath, errp);
+        if (driver && (g_str_equal(driver, "ata_piix") ||
+                       g_str_equal(driver, "sym53c8xx") ||
+                       g_str_equal(driver, "virtio-pci") ||
+                       g_str_equal(driver, "ahci") ||
+                       g_str_equal(driver, "nvme") ||
+                       g_str_equal(driver, "xhci_hcd") ||
+                       g_str_equal(driver, "ehci-pci"))) {
+            break;
+        }
+
+        g_free(driver);
+        if (sscanf(p, "/%x:%x:%x.%x%n",
+                          pci, pci + 1, pci + 2, pci + 3, &pcilen) == 4) {
+            p += pcilen;
+            continue;
+        }
+
+        g_debug("unsupported driver or sysfs path '%s'", syspath);
+        return false;
+    }
+
+    p = strstr(syspath, "/target");
+    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
+                    tgt, tgt + 1, tgt + 2) == 3) {
+        has_tgt = true;
+    }
+
+    p = strstr(syspath, "/ata");
+    if (p) {
+        q = p + 4;
+        has_ata = true;
+    } else {
+        p = strstr(syspath, "/host");
+        q = p + 5;
+    }
+    if (p && sscanf(q, "%u", &host) == 1) {
+        has_host = true;
+        nhosts = build_hosts(syspath, p, has_ata, hosts,
+                             ARRAY_SIZE(hosts), errp);
+        if (nhosts < 0) {
+            goto cleanup;
+        }
+    }
+
+    pciaddr->domain = pci[0];
+    pciaddr->bus = pci[1];
+    pciaddr->slot = pci[2];
+    pciaddr->function = pci[3];
+
+    if (strcmp(driver, "ata_piix") == 0) {
+        /* a host per ide bus, target*:0:<unit>:0 */
+        if (!has_host || !has_tgt) {
+            g_debug("invalid sysfs path '%s' (driver '%s')", syspath, driver);
+            goto cleanup;
+        }
+        for (i = 0; i < nhosts; i++) {
+            if (host == hosts[i]) {
+                disk->bus_type = GUEST_DISK_BUS_TYPE_IDE;
+                disk->bus = i;
+                disk->unit = tgt[1];
+                break;
+            }
+        }
+        if (i >= nhosts) {
+            g_debug("no host for '%s' (driver '%s')", syspath, driver);
+            goto cleanup;
+        }
+    } else if (strcmp(driver, "sym53c8xx") == 0) {
+        /* scsi(LSI Logic): target*:0:<unit>:0 */
+        if (!has_tgt) {
+            g_debug("invalid sysfs path '%s' (driver '%s')", syspath, driver);
+            goto cleanup;
+        }
+        disk->bus_type = GUEST_DISK_BUS_TYPE_SCSI;
+        disk->unit = tgt[1];
+    } else if (strcmp(driver, "virtio-pci") == 0) {
+        if (has_tgt) {
+            /* virtio-scsi: target*:0:0:<unit> */
+            disk->bus_type = GUEST_DISK_BUS_TYPE_SCSI;
+            disk->unit = tgt[2];
+        } else {
+            /* virtio-blk: 1 disk per 1 device */
+            disk->bus_type = GUEST_DISK_BUS_TYPE_VIRTIO;
+        }
+    } else if (strcmp(driver, "ahci") == 0) {
+        /* ahci: 1 host per 1 unit */
+        if (!has_host || !has_tgt) {
+            g_debug("invalid sysfs path '%s' (driver '%s')", syspath, driver);
+            goto cleanup;
+        }
+        for (i = 0; i < nhosts; i++) {
+            if (host == hosts[i]) {
+                disk->unit = i;
+                disk->bus_type = GUEST_DISK_BUS_TYPE_SATA;
+                break;
+            }
+        }
+        if (i >= nhosts) {
+            g_debug("no host for '%s' (driver '%s')", syspath, driver);
+            goto cleanup;
+        }
+    } else if (strcmp(driver, "nvme") == 0) {
+        disk->bus_type = GUEST_DISK_BUS_TYPE_NVME;
+    } else if (strcmp(driver, "ehci-pci") == 0 || strcmp(driver, "xhci_hcd") == 0) {
+        disk->bus_type = GUEST_DISK_BUS_TYPE_USB;
+    } else {
+        g_debug("unknown driver '%s' (sysfs path '%s')", driver, syspath);
+        goto cleanup;
+    }
+
+    ret = true;
+
+cleanup:
+    g_free(driver);
+    return ret;
+}
+
+/*
+ * Store disk device info for non-PCI virtio devices (for example s390x
+ * channel I/O devices). Returns true if information has been stored, or
+ * false for failure.
+ */
+static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,
+                                                 GuestDiskAddress *disk,
+                                                 Error **errp)
+{
+    unsigned int tgt[3];
+    char *p;
+
+    if (!strstr(syspath, "/virtio") || !strstr(syspath, "/block")) {
+        g_debug("Unsupported virtio device '%s'", syspath);
+        return false;
+    }
+
+    p = strstr(syspath, "/target");
+    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
+                    &tgt[0], &tgt[1], &tgt[2]) == 3) {
+        /* virtio-scsi: target*:0:<target>:<unit> */
+        disk->bus_type = GUEST_DISK_BUS_TYPE_SCSI;
+        disk->bus = tgt[0];
+        disk->target = tgt[1];
+        disk->unit = tgt[2];
+    } else {
+        /* virtio-blk: 1 disk per 1 device */
+        disk->bus_type = GUEST_DISK_BUS_TYPE_VIRTIO;
+    }
+
+    return true;
+}
+
+/*
+ * Store disk device info for CCW devices (s390x channel I/O devices).
+ * Returns true if information has been stored, or false for failure.
+ */
+static bool build_guest_fsinfo_for_ccw_dev(char const *syspath,
+                                           GuestDiskAddress *disk,
+                                           Error **errp)
+{
+    unsigned int cssid, ssid, subchno, devno;
+    char *p;
+
+    p = strstr(syspath, "/devices/css");
+    if (!p || sscanf(p + 12, "%*x/%x.%x.%x/%*x.%*x.%x/",
+                     &cssid, &ssid, &subchno, &devno) < 4) {
+        g_debug("could not parse ccw device sysfs path: %s", syspath);
+        return false;
+    }
+
+    disk->ccw_address = g_new0(GuestCCWAddress, 1);
+    disk->ccw_address->cssid = cssid;
+    disk->ccw_address->ssid = ssid;
+    disk->ccw_address->subchno = subchno;
+    disk->ccw_address->devno = devno;
+
+    if (strstr(p, "/virtio")) {
+        build_guest_fsinfo_for_nonpci_virtio(syspath, disk, errp);
+    }
+
+    return true;
+}
+
+/* Store disk device info specified by @sysfs into @fs */
+static void build_guest_fsinfo_for_real_device(char const *syspath,
+                                               GuestFilesystemInfo *fs,
+                                               Error **errp)
+{
+    GuestDiskAddress *disk;
+    GuestPCIAddress *pciaddr;
+    bool has_hwinf;
+#ifdef CONFIG_LIBUDEV
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+#endif
+
+    pciaddr = g_new0(GuestPCIAddress, 1);
+    pciaddr->domain = -1;                       /* -1 means field is invalid */
+    pciaddr->bus = -1;
+    pciaddr->slot = -1;
+    pciaddr->function = -1;
+
+    disk = g_new0(GuestDiskAddress, 1);
+    disk->pci_controller = pciaddr;
+    disk->bus_type = GUEST_DISK_BUS_TYPE_UNKNOWN;
+
+#ifdef CONFIG_LIBUDEV
+    udev = udev_new();
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udev == NULL || udevice == NULL) {
+        g_debug("failed to query udev");
+    } else {
+        const char *devnode, *serial;
+        devnode = udev_device_get_devnode(udevice);
+        if (devnode != NULL) {
+            disk->dev = g_strdup(devnode);
+        }
+        serial = udev_device_get_property_value(udevice, "ID_SERIAL");
+        if (serial != NULL && *serial != 0) {
+            disk->serial = g_strdup(serial);
+        }
+    }
+
+    udev_unref(udev);
+    udev_device_unref(udevice);
+#endif
+
+    if (strstr(syspath, "/devices/pci")) {
+        has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
+    } else if (strstr(syspath, "/devices/css")) {
+        has_hwinf = build_guest_fsinfo_for_ccw_dev(syspath, disk, errp);
+    } else if (strstr(syspath, "/virtio")) {
+        has_hwinf = build_guest_fsinfo_for_nonpci_virtio(syspath, disk, errp);
+    } else {
+        g_debug("Unsupported device type for '%s'", syspath);
+        has_hwinf = false;
+    }
+
+    if (has_hwinf || disk->dev || disk->serial) {
+        QAPI_LIST_PREPEND(fs->disk, disk);
+    } else {
+        qapi_free_GuestDiskAddress(disk);
+    }
+}
+
+static void build_guest_fsinfo_for_device(char const *devpath,
+                                          GuestFilesystemInfo *fs,
+                                          Error **errp);
+
+/* Store a list of slave devices of virtual volume specified by @syspath into
+ * @fs */
+static void build_guest_fsinfo_for_virtual_device(char const *syspath,
+                                                  GuestFilesystemInfo *fs,
+                                                  Error **errp)
+{
+    Error *err = NULL;
+    DIR *dir;
+    char *dirpath;
+    struct dirent *entry;
+
+    dirpath = g_strdup_printf("%s/slaves", syspath);
+    dir = opendir(dirpath);
+    if (!dir) {
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "opendir(\"%s\")", dirpath);
+        }
+        g_free(dirpath);
+        return;
+    }
+
+    for (;;) {
+        errno = 0;
+        entry = readdir(dir);
+        if (entry == NULL) {
+            if (errno) {
+                error_setg_errno(errp, errno, "readdir(\"%s\")", dirpath);
+            }
+            break;
+        }
+
+        if (entry->d_type == DT_LNK) {
+            char *path;
+
+            g_debug(" slave device '%s'", entry->d_name);
+            path = g_strdup_printf("%s/slaves/%s", syspath, entry->d_name);
+            build_guest_fsinfo_for_device(path, fs, &err);
+            g_free(path);
+
+            if (err) {
+                error_propagate(errp, err);
+                break;
+            }
+        }
+    }
+
+    g_free(dirpath);
+    closedir(dir);
+}
+
+static bool is_disk_virtual(const char *devpath, Error **errp)
+{
+    g_autofree char *syspath = realpath(devpath, NULL);
+
+    if (!syspath) {
+        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
+        return false;
+    }
+    return strstr(syspath, "/devices/virtual/block/") != NULL;
+}
+
+/* Dispatch to functions for virtual/real device */
+static void build_guest_fsinfo_for_device(char const *devpath,
+                                          GuestFilesystemInfo *fs,
+                                          Error **errp)
+{
+    ERRP_GUARD();
+    g_autofree char *syspath = NULL;
+    bool is_virtual = false;
+
+    syspath = realpath(devpath, NULL);
+    if (!syspath) {
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
+            return;
+        }
+
+        /* ENOENT: This devpath may not exist because of container config */
+        if (!fs->name) {
+            fs->name = g_path_get_basename(devpath);
+        }
+        return;
+    }
+
+    if (!fs->name) {
+        fs->name = g_path_get_basename(syspath);
+    }
+
+    g_debug("  parse sysfs path '%s'", syspath);
+    is_virtual = is_disk_virtual(syspath, errp);
+    if (*errp != NULL) {
+        return;
+    }
+    if (is_virtual) {
+        build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
+    } else {
+        build_guest_fsinfo_for_real_device(syspath, fs, errp);
+    }
+}
+
+#ifdef CONFIG_LIBUDEV
+
+/*
+ * Wrapper around build_guest_fsinfo_for_device() for getting just
+ * the disk address.
+ */
+static GuestDiskAddress *get_disk_address(const char *syspath, Error **errp)
+{
+    g_autoptr(GuestFilesystemInfo) fs = NULL;
+
+    fs = g_new0(GuestFilesystemInfo, 1);
+    build_guest_fsinfo_for_device(syspath, fs, errp);
+    if (fs->disk != NULL) {
+        return g_steal_pointer(&fs->disk->value);
+    }
+    return NULL;
+}
+
+static char *get_alias_for_syspath(const char *syspath)
+{
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+    char *ret = NULL;
+
+    udev = udev_new();
+    if (udev == NULL) {
+        g_debug("failed to query udev");
+        goto out;
+    }
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udevice == NULL) {
+        g_debug("failed to query udev for path: %s", syspath);
+        goto out;
+    } else {
+        const char *alias = udev_device_get_property_value(
+            udevice, "DM_NAME");
+        /*
+         * NULL means there was an error and empty string means there is no
+         * alias. In case of no alias we return NULL instead of empty string.
+         */
+        if (alias == NULL) {
+            g_debug("failed to query udev for device alias for: %s",
+                syspath);
+        } else if (*alias != 0) {
+            ret = g_strdup(alias);
+        }
+    }
+
+out:
+    udev_unref(udev);
+    udev_device_unref(udevice);
+    return ret;
+}
+
+static char *get_device_for_syspath(const char *syspath)
+{
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+    char *ret = NULL;
+
+    udev = udev_new();
+    if (udev == NULL) {
+        g_debug("failed to query udev");
+        goto out;
+    }
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udevice == NULL) {
+        g_debug("failed to query udev for path: %s", syspath);
+        goto out;
+    } else {
+        ret = g_strdup(udev_device_get_devnode(udevice));
+    }
+
+out:
+    udev_unref(udev);
+    udev_device_unref(udevice);
+    return ret;
+}
+
+static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)
+{
+    g_autofree char *deps_dir = NULL;
+    const gchar *dep;
+    GDir *dp_deps = NULL;
+
+    /* List dependent disks */
+    deps_dir = g_strdup_printf("%s/slaves", disk_dir);
+    g_debug("  listing entries in: %s", deps_dir);
+    dp_deps = g_dir_open(deps_dir, 0, NULL);
+    if (dp_deps == NULL) {
+        g_debug("failed to list entries in %s", deps_dir);
+        return;
+    }
+    disk->has_dependencies = true;
+    while ((dep = g_dir_read_name(dp_deps)) != NULL) {
+        g_autofree char *dep_dir = NULL;
+        char *dev_name;
+
+        /* Add dependent disks */
+        dep_dir = g_strdup_printf("%s/%s", deps_dir, dep);
+        dev_name = get_device_for_syspath(dep_dir);
+        if (dev_name != NULL) {
+            g_debug("  adding dependent device: %s", dev_name);
+            QAPI_LIST_PREPEND(disk->dependencies, dev_name);
+        }
+    }
+    g_dir_close(dp_deps);
+}
+
+/*
+ * Detect partitions subdirectory, name is "<disk_name><number>" or
+ * "<disk_name>p<number>"
+ *
+ * @disk_name -- last component of /sys path (e.g. sda)
+ * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)
+ * @disk_dev -- device node of the disk (e.g. /dev/sda)
+ */
+static GuestDiskInfoList *get_disk_partitions(
+    GuestDiskInfoList *list,
+    const char *disk_name, const char *disk_dir,
+    const char *disk_dev)
+{
+    GuestDiskInfoList *ret = list;
+    struct dirent *de_disk;
+    DIR *dp_disk = NULL;
+    size_t len = strlen(disk_name);
+
+    dp_disk = opendir(disk_dir);
+    while ((de_disk = readdir(dp_disk)) != NULL) {
+        g_autofree char *partition_dir = NULL;
+        char *dev_name;
+        GuestDiskInfo *partition;
+
+        if (!(de_disk->d_type & DT_DIR)) {
+            continue;
+        }
+
+        if (!(strncmp(disk_name, de_disk->d_name, len) == 0 &&
+            ((*(de_disk->d_name + len) == 'p' &&
+            isdigit(*(de_disk->d_name + len + 1))) ||
+                isdigit(*(de_disk->d_name + len))))) {
+            continue;
+        }
+
+        partition_dir = g_strdup_printf("%s/%s",
+            disk_dir, de_disk->d_name);
+        dev_name = get_device_for_syspath(partition_dir);
+        if (dev_name == NULL) {
+            g_debug("Failed to get device name for syspath: %s",
+                disk_dir);
+            continue;
+        }
+        partition = g_new0(GuestDiskInfo, 1);
+        partition->name = dev_name;
+        partition->partition = true;
+        partition->has_dependencies = true;
+        /* Add parent disk as dependent for easier tracking of hierarchy */
+        QAPI_LIST_PREPEND(partition->dependencies, g_strdup(disk_dev));
+
+        QAPI_LIST_PREPEND(ret, partition);
+    }
+    closedir(dp_disk);
+
+    return ret;
+}
+
+static void get_nvme_smart(GuestDiskInfo *disk)
+{
+    int fd;
+    GuestNVMeSmart *smart;
+    NvmeSmartLog log = {0};
+    struct nvme_admin_cmd cmd = {
+        .opcode = NVME_ADM_CMD_GET_LOG_PAGE,
+        .nsid = NVME_NSID_BROADCAST,
+        .addr = (uintptr_t)&log,
+        .data_len = sizeof(log),
+        .cdw10 = NVME_LOG_SMART_INFO | (1 << 15) /* RAE bit */
+                 | (((sizeof(log) >> 2) - 1) << 16)
+    };
+
+    fd = qga_open_cloexec(disk->name, O_RDONLY, 0);
+    if (fd == -1) {
+        g_debug("Failed to open device: %s: %s", disk->name, g_strerror(errno));
+        return;
+    }
+
+    if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd)) {
+        g_debug("Failed to get smart: %s: %s", disk->name, g_strerror(errno));
+        close(fd);
+        return;
+    }
+
+    disk->smart = g_new0(GuestDiskSmart, 1);
+    disk->smart->type = GUEST_DISK_BUS_TYPE_NVME;
+
+    smart = &disk->smart->u.nvme;
+    smart->critical_warning = log.critical_warning;
+    smart->temperature = lduw_le_p(&log.temperature); /* unaligned field */
+    smart->available_spare = log.available_spare;
+    smart->available_spare_threshold = log.available_spare_threshold;
+    smart->percentage_used = log.percentage_used;
+    smart->data_units_read_lo = le64_to_cpu(log.data_units_read[0]);
+    smart->data_units_read_hi = le64_to_cpu(log.data_units_read[1]);
+    smart->data_units_written_lo = le64_to_cpu(log.data_units_written[0]);
+    smart->data_units_written_hi = le64_to_cpu(log.data_units_written[1]);
+    smart->host_read_commands_lo = le64_to_cpu(log.host_read_commands[0]);
+    smart->host_read_commands_hi = le64_to_cpu(log.host_read_commands[1]);
+    smart->host_write_commands_lo = le64_to_cpu(log.host_write_commands[0]);
+    smart->host_write_commands_hi = le64_to_cpu(log.host_write_commands[1]);
+    smart->controller_busy_time_lo = le64_to_cpu(log.controller_busy_time[0]);
+    smart->controller_busy_time_hi = le64_to_cpu(log.controller_busy_time[1]);
+    smart->power_cycles_lo = le64_to_cpu(log.power_cycles[0]);
+    smart->power_cycles_hi = le64_to_cpu(log.power_cycles[1]);
+    smart->power_on_hours_lo = le64_to_cpu(log.power_on_hours[0]);
+    smart->power_on_hours_hi = le64_to_cpu(log.power_on_hours[1]);
+    smart->unsafe_shutdowns_lo = le64_to_cpu(log.unsafe_shutdowns[0]);
+    smart->unsafe_shutdowns_hi = le64_to_cpu(log.unsafe_shutdowns[1]);
+    smart->media_errors_lo = le64_to_cpu(log.media_errors[0]);
+    smart->media_errors_hi = le64_to_cpu(log.media_errors[1]);
+    smart->number_of_error_log_entries_lo =
+        le64_to_cpu(log.number_of_error_log_entries[0]);
+    smart->number_of_error_log_entries_hi =
+        le64_to_cpu(log.number_of_error_log_entries[1]);
+
+    close(fd);
+}
+
+static void get_disk_smart(GuestDiskInfo *disk)
+{
+    if (disk->address
+        && (disk->address->bus_type == GUEST_DISK_BUS_TYPE_NVME)) {
+        get_nvme_smart(disk);
+    }
+}
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskInfoList *ret = NULL;
+    GuestDiskInfo *disk;
+    DIR *dp = NULL;
+    struct dirent *de = NULL;
+
+    g_debug("listing /sys/block directory");
+    dp = opendir("/sys/block");
+    if (dp == NULL) {
+        error_setg_errno(errp, errno, "Can't open directory \"/sys/block\"");
+        return NULL;
+    }
+    while ((de = readdir(dp)) != NULL) {
+        g_autofree char *disk_dir = NULL, *line = NULL,
+            *size_path = NULL;
+        char *dev_name;
+        Error *local_err = NULL;
+        if (de->d_type != DT_LNK) {
+            g_debug("  skipping entry: %s", de->d_name);
+            continue;
+        }
+
+        /* Check size and skip zero-sized disks */
+        g_debug("  checking disk size");
+        size_path = g_strdup_printf("/sys/block/%s/size", de->d_name);
+        if (!g_file_get_contents(size_path, &line, NULL, NULL)) {
+            g_debug("  failed to read disk size");
+            continue;
+        }
+        if (g_strcmp0(line, "0\n") == 0) {
+            g_debug("  skipping zero-sized disk");
+            continue;
+        }
+
+        g_debug("  adding %s", de->d_name);
+        disk_dir = g_strdup_printf("/sys/block/%s", de->d_name);
+        dev_name = get_device_for_syspath(disk_dir);
+        if (dev_name == NULL) {
+            g_debug("Failed to get device name for syspath: %s",
+                disk_dir);
+            continue;
+        }
+        disk = g_new0(GuestDiskInfo, 1);
+        disk->name = dev_name;
+        disk->partition = false;
+        disk->alias = get_alias_for_syspath(disk_dir);
+        QAPI_LIST_PREPEND(ret, disk);
+
+        /* Get address for non-virtual devices */
+        bool is_virtual = is_disk_virtual(disk_dir, &local_err);
+        if (local_err != NULL) {
+            g_debug("  failed to check disk path, ignoring error: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+            /* Don't try to get the address */
+            is_virtual = true;
+        }
+        if (!is_virtual) {
+            disk->address = get_disk_address(disk_dir, &local_err);
+            if (local_err != NULL) {
+                g_debug("  failed to get device info, ignoring error: %s",
+                    error_get_pretty(local_err));
+                error_free(local_err);
+                local_err = NULL;
+            }
+        }
+
+        get_disk_deps(disk_dir, disk);
+        get_disk_smart(disk);
+        ret = get_disk_partitions(ret, de->d_name, disk_dir, dev_name);
+    }
+
+    closedir(dp);
+
+    return ret;
+}
+
+#else
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
+#endif
+
+/* Return a list of the disk device(s)' info which @mount lies on */
+static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
+                                               Error **errp)
+{
+    GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
+    struct statvfs buf;
+    unsigned long used, nonroot_total, fr_size;
+    char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
+                                    mount->devmajor, mount->devminor);
+
+    fs->mountpoint = g_strdup(mount->dirname);
+    fs->type = g_strdup(mount->devtype);
+    build_guest_fsinfo_for_device(devpath, fs, errp);
+
+    if (statvfs(fs->mountpoint, &buf) == 0) {
+        fr_size = buf.f_frsize;
+        used = buf.f_blocks - buf.f_bfree;
+        nonroot_total = used + buf.f_bavail;
+        fs->used_bytes = used * fr_size;
+        fs->total_bytes = nonroot_total * fr_size;
+        fs->total_bytes_privileged = buf.f_blocks * fr_size;
+
+        fs->has_total_bytes = true;
+        fs->has_total_bytes_privileged = true;
+        fs->has_used_bytes = true;
+    }
+
+    g_free(devpath);
+
+    return fs;
+}
+
+GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
+{
+    FsMountList mounts;
+    struct FsMount *mount;
+    GuestFilesystemInfoList *ret = NULL;
+    Error *local_err = NULL;
+
+    QTAILQ_INIT(&mounts);
+    if (!build_fs_mount_list(&mounts, &local_err)) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(mount, &mounts, next) {
+        g_debug("Building guest fsinfo for '%s'", mount->dirname);
+
+        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount, &local_err));
+        if (local_err) {
+            error_propagate(errp, local_err);
+            qapi_free_GuestFilesystemInfoList(ret);
+            ret = NULL;
+            break;
+        }
+    }
+
+    free_fs_mount_list(&mounts);
+    return ret;
+}
+#endif /* CONFIG_FSFREEZE */
+
+#if defined(CONFIG_FSTRIM)
+/*
+ * Walk list of mounted file systems in the guest, and trim them.
+ */
+GuestFilesystemTrimResponse *
+qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
+{
+    GuestFilesystemTrimResponse *response;
+    GuestFilesystemTrimResult *result;
+    int ret = 0;
+    FsMountList mounts;
+    struct FsMount *mount;
+    int fd;
+    struct fstrim_range r;
+
+    slog("guest-fstrim called");
+
+    QTAILQ_INIT(&mounts);
+    if (!build_fs_mount_list(&mounts, errp)) {
+        return NULL;
+    }
+
+    response = g_malloc0(sizeof(*response));
+
+    QTAILQ_FOREACH(mount, &mounts, next) {
+        result = g_malloc0(sizeof(*result));
+        result->path = g_strdup(mount->dirname);
+
+        QAPI_LIST_PREPEND(response->paths, result);
+
+        fd = qga_open_cloexec(mount->dirname, O_RDONLY, 0);
+        if (fd == -1) {
+            result->error = g_strdup_printf("failed to open: %s",
+                                            strerror(errno));
+            continue;
+        }
+
+        /* We try to cull filesystems we know won't work in advance, but other
+         * filesystems may not implement fstrim for less obvious reasons.
+         * These will report EOPNOTSUPP; while in some other cases ENOTTY
+         * will be reported (e.g. CD-ROMs).
+         * Any other error means an unexpected error.
+         */
+        r.start = 0;
+        r.len = -1;
+        r.minlen = has_minimum ? minimum : 0;
+        ret = ioctl(fd, FITRIM, &r);
+        if (ret == -1) {
+            if (errno == ENOTTY || errno == EOPNOTSUPP) {
+                result->error = g_strdup("trim not supported");
+            } else {
+                result->error = g_strdup_printf("failed to trim: %s",
+                                                strerror(errno));
+            }
+            close(fd);
+            continue;
+        }
+
+        result->has_minimum = true;
+        result->minimum = r.minlen;
+        result->has_trimmed = true;
+        result->trimmed = r.len;
+        close(fd);
+    }
+
+    free_fs_mount_list(&mounts);
+    return response;
+}
+#endif /* CONFIG_FSTRIM */
 
 #define LINUX_SYS_STATE_FILE "/sys/power/state"
 #define SUSPEND_SUPPORTED 0
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ef21da63be..98aafc45f3 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -24,23 +24,12 @@
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
 #include "commands-common.h"
-#include "block/nvme.h"
 #include "cutils.h"
 
 #ifdef HAVE_UTMPX
 #include <utmpx.h>
 #endif
 
-#if defined(__linux__)
-#include <mntent.h>
-#include <sys/statvfs.h>
-#include <linux/nvme_ioctl.h>
-
-#ifdef CONFIG_LIBUDEV
-#include <libudev.h>
-#endif
-#endif
-
 #ifdef HAVE_GETIFADDRS
 #include <arpa/inet.h>
 #include <sys/socket.h>
@@ -842,904 +831,6 @@ static void guest_fsfreeze_cleanup(void)
 }
 #endif
 
-/* linux-specific implementations. avoid this if at all possible. */
-#if defined(__linux__)
-#if defined(CONFIG_FSFREEZE)
-
-static char *get_pci_driver(char const *syspath, int pathlen, Error **errp)
-{
-    char *path;
-    char *dpath;
-    char *driver = NULL;
-    char buf[PATH_MAX];
-    ssize_t len;
-
-    path = g_strndup(syspath, pathlen);
-    dpath = g_strdup_printf("%s/driver", path);
-    len = readlink(dpath, buf, sizeof(buf) - 1);
-    if (len != -1) {
-        buf[len] = 0;
-        driver = g_path_get_basename(buf);
-    }
-    g_free(dpath);
-    g_free(path);
-    return driver;
-}
-
-static int compare_uint(const void *_a, const void *_b)
-{
-    unsigned int a = *(unsigned int *)_a;
-    unsigned int b = *(unsigned int *)_b;
-
-    return a < b ? -1 : a > b ? 1 : 0;
-}
-
-/* Walk the specified sysfs and build a sorted list of host or ata numbers */
-static int build_hosts(char const *syspath, char const *host, bool ata,
-                       unsigned int *hosts, int hosts_max, Error **errp)
-{
-    char *path;
-    DIR *dir;
-    struct dirent *entry;
-    int i = 0;
-
-    path = g_strndup(syspath, host - syspath);
-    dir = opendir(path);
-    if (!dir) {
-        error_setg_errno(errp, errno, "opendir(\"%s\")", path);
-        g_free(path);
-        return -1;
-    }
-
-    while (i < hosts_max) {
-        entry = readdir(dir);
-        if (!entry) {
-            break;
-        }
-        if (ata && sscanf(entry->d_name, "ata%d", hosts + i) == 1) {
-            ++i;
-        } else if (!ata && sscanf(entry->d_name, "host%d", hosts + i) == 1) {
-            ++i;
-        }
-    }
-
-    qsort(hosts, i, sizeof(hosts[0]), compare_uint);
-
-    g_free(path);
-    closedir(dir);
-    return i;
-}
-
-/*
- * Store disk device info for devices on the PCI bus.
- * Returns true if information has been stored, or false for failure.
- */
-static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
-                                           GuestDiskAddress *disk,
-                                           Error **errp)
-{
-    unsigned int pci[4], host, hosts[8], tgt[3];
-    int i, nhosts = 0, pcilen;
-    GuestPCIAddress *pciaddr = disk->pci_controller;
-    bool has_ata = false, has_host = false, has_tgt = false;
-    char *p, *q, *driver = NULL;
-    bool ret = false;
-
-    p = strstr(syspath, "/devices/pci");
-    if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
-                     pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
-        g_debug("only pci device is supported: sysfs path '%s'", syspath);
-        return false;
-    }
-
-    p += 12 + pcilen;
-    while (true) {
-        driver = get_pci_driver(syspath, p - syspath, errp);
-        if (driver && (g_str_equal(driver, "ata_piix") ||
-                       g_str_equal(driver, "sym53c8xx") ||
-                       g_str_equal(driver, "virtio-pci") ||
-                       g_str_equal(driver, "ahci") ||
-                       g_str_equal(driver, "nvme") ||
-                       g_str_equal(driver, "xhci_hcd") ||
-                       g_str_equal(driver, "ehci-pci"))) {
-            break;
-        }
-
-        g_free(driver);
-        if (sscanf(p, "/%x:%x:%x.%x%n",
-                          pci, pci + 1, pci + 2, pci + 3, &pcilen) == 4) {
-            p += pcilen;
-            continue;
-        }
-
-        g_debug("unsupported driver or sysfs path '%s'", syspath);
-        return false;
-    }
-
-    p = strstr(syspath, "/target");
-    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
-                    tgt, tgt + 1, tgt + 2) == 3) {
-        has_tgt = true;
-    }
-
-    p = strstr(syspath, "/ata");
-    if (p) {
-        q = p + 4;
-        has_ata = true;
-    } else {
-        p = strstr(syspath, "/host");
-        q = p + 5;
-    }
-    if (p && sscanf(q, "%u", &host) == 1) {
-        has_host = true;
-        nhosts = build_hosts(syspath, p, has_ata, hosts,
-                             ARRAY_SIZE(hosts), errp);
-        if (nhosts < 0) {
-            goto cleanup;
-        }
-    }
-
-    pciaddr->domain = pci[0];
-    pciaddr->bus = pci[1];
-    pciaddr->slot = pci[2];
-    pciaddr->function = pci[3];
-
-    if (strcmp(driver, "ata_piix") == 0) {
-        /* a host per ide bus, target*:0:<unit>:0 */
-        if (!has_host || !has_tgt) {
-            g_debug("invalid sysfs path '%s' (driver '%s')", syspath, driver);
-            goto cleanup;
-        }
-        for (i = 0; i < nhosts; i++) {
-            if (host == hosts[i]) {
-                disk->bus_type = GUEST_DISK_BUS_TYPE_IDE;
-                disk->bus = i;
-                disk->unit = tgt[1];
-                break;
-            }
-        }
-        if (i >= nhosts) {
-            g_debug("no host for '%s' (driver '%s')", syspath, driver);
-            goto cleanup;
-        }
-    } else if (strcmp(driver, "sym53c8xx") == 0) {
-        /* scsi(LSI Logic): target*:0:<unit>:0 */
-        if (!has_tgt) {
-            g_debug("invalid sysfs path '%s' (driver '%s')", syspath, driver);
-            goto cleanup;
-        }
-        disk->bus_type = GUEST_DISK_BUS_TYPE_SCSI;
-        disk->unit = tgt[1];
-    } else if (strcmp(driver, "virtio-pci") == 0) {
-        if (has_tgt) {
-            /* virtio-scsi: target*:0:0:<unit> */
-            disk->bus_type = GUEST_DISK_BUS_TYPE_SCSI;
-            disk->unit = tgt[2];
-        } else {
-            /* virtio-blk: 1 disk per 1 device */
-            disk->bus_type = GUEST_DISK_BUS_TYPE_VIRTIO;
-        }
-    } else if (strcmp(driver, "ahci") == 0) {
-        /* ahci: 1 host per 1 unit */
-        if (!has_host || !has_tgt) {
-            g_debug("invalid sysfs path '%s' (driver '%s')", syspath, driver);
-            goto cleanup;
-        }
-        for (i = 0; i < nhosts; i++) {
-            if (host == hosts[i]) {
-                disk->unit = i;
-                disk->bus_type = GUEST_DISK_BUS_TYPE_SATA;
-                break;
-            }
-        }
-        if (i >= nhosts) {
-            g_debug("no host for '%s' (driver '%s')", syspath, driver);
-            goto cleanup;
-        }
-    } else if (strcmp(driver, "nvme") == 0) {
-        disk->bus_type = GUEST_DISK_BUS_TYPE_NVME;
-    } else if (strcmp(driver, "ehci-pci") == 0 || strcmp(driver, "xhci_hcd") == 0) {
-        disk->bus_type = GUEST_DISK_BUS_TYPE_USB;
-    } else {
-        g_debug("unknown driver '%s' (sysfs path '%s')", driver, syspath);
-        goto cleanup;
-    }
-
-    ret = true;
-
-cleanup:
-    g_free(driver);
-    return ret;
-}
-
-/*
- * Store disk device info for non-PCI virtio devices (for example s390x
- * channel I/O devices). Returns true if information has been stored, or
- * false for failure.
- */
-static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,
-                                                 GuestDiskAddress *disk,
-                                                 Error **errp)
-{
-    unsigned int tgt[3];
-    char *p;
-
-    if (!strstr(syspath, "/virtio") || !strstr(syspath, "/block")) {
-        g_debug("Unsupported virtio device '%s'", syspath);
-        return false;
-    }
-
-    p = strstr(syspath, "/target");
-    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
-                    &tgt[0], &tgt[1], &tgt[2]) == 3) {
-        /* virtio-scsi: target*:0:<target>:<unit> */
-        disk->bus_type = GUEST_DISK_BUS_TYPE_SCSI;
-        disk->bus = tgt[0];
-        disk->target = tgt[1];
-        disk->unit = tgt[2];
-    } else {
-        /* virtio-blk: 1 disk per 1 device */
-        disk->bus_type = GUEST_DISK_BUS_TYPE_VIRTIO;
-    }
-
-    return true;
-}
-
-/*
- * Store disk device info for CCW devices (s390x channel I/O devices).
- * Returns true if information has been stored, or false for failure.
- */
-static bool build_guest_fsinfo_for_ccw_dev(char const *syspath,
-                                           GuestDiskAddress *disk,
-                                           Error **errp)
-{
-    unsigned int cssid, ssid, subchno, devno;
-    char *p;
-
-    p = strstr(syspath, "/devices/css");
-    if (!p || sscanf(p + 12, "%*x/%x.%x.%x/%*x.%*x.%x/",
-                     &cssid, &ssid, &subchno, &devno) < 4) {
-        g_debug("could not parse ccw device sysfs path: %s", syspath);
-        return false;
-    }
-
-    disk->ccw_address = g_new0(GuestCCWAddress, 1);
-    disk->ccw_address->cssid = cssid;
-    disk->ccw_address->ssid = ssid;
-    disk->ccw_address->subchno = subchno;
-    disk->ccw_address->devno = devno;
-
-    if (strstr(p, "/virtio")) {
-        build_guest_fsinfo_for_nonpci_virtio(syspath, disk, errp);
-    }
-
-    return true;
-}
-
-/* Store disk device info specified by @sysfs into @fs */
-static void build_guest_fsinfo_for_real_device(char const *syspath,
-                                               GuestFilesystemInfo *fs,
-                                               Error **errp)
-{
-    GuestDiskAddress *disk;
-    GuestPCIAddress *pciaddr;
-    bool has_hwinf;
-#ifdef CONFIG_LIBUDEV
-    struct udev *udev = NULL;
-    struct udev_device *udevice = NULL;
-#endif
-
-    pciaddr = g_new0(GuestPCIAddress, 1);
-    pciaddr->domain = -1;                       /* -1 means field is invalid */
-    pciaddr->bus = -1;
-    pciaddr->slot = -1;
-    pciaddr->function = -1;
-
-    disk = g_new0(GuestDiskAddress, 1);
-    disk->pci_controller = pciaddr;
-    disk->bus_type = GUEST_DISK_BUS_TYPE_UNKNOWN;
-
-#ifdef CONFIG_LIBUDEV
-    udev = udev_new();
-    udevice = udev_device_new_from_syspath(udev, syspath);
-    if (udev == NULL || udevice == NULL) {
-        g_debug("failed to query udev");
-    } else {
-        const char *devnode, *serial;
-        devnode = udev_device_get_devnode(udevice);
-        if (devnode != NULL) {
-            disk->dev = g_strdup(devnode);
-        }
-        serial = udev_device_get_property_value(udevice, "ID_SERIAL");
-        if (serial != NULL && *serial != 0) {
-            disk->serial = g_strdup(serial);
-        }
-    }
-
-    udev_unref(udev);
-    udev_device_unref(udevice);
-#endif
-
-    if (strstr(syspath, "/devices/pci")) {
-        has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
-    } else if (strstr(syspath, "/devices/css")) {
-        has_hwinf = build_guest_fsinfo_for_ccw_dev(syspath, disk, errp);
-    } else if (strstr(syspath, "/virtio")) {
-        has_hwinf = build_guest_fsinfo_for_nonpci_virtio(syspath, disk, errp);
-    } else {
-        g_debug("Unsupported device type for '%s'", syspath);
-        has_hwinf = false;
-    }
-
-    if (has_hwinf || disk->dev || disk->serial) {
-        QAPI_LIST_PREPEND(fs->disk, disk);
-    } else {
-        qapi_free_GuestDiskAddress(disk);
-    }
-}
-
-static void build_guest_fsinfo_for_device(char const *devpath,
-                                          GuestFilesystemInfo *fs,
-                                          Error **errp);
-
-/* Store a list of slave devices of virtual volume specified by @syspath into
- * @fs */
-static void build_guest_fsinfo_for_virtual_device(char const *syspath,
-                                                  GuestFilesystemInfo *fs,
-                                                  Error **errp)
-{
-    Error *err = NULL;
-    DIR *dir;
-    char *dirpath;
-    struct dirent *entry;
-
-    dirpath = g_strdup_printf("%s/slaves", syspath);
-    dir = opendir(dirpath);
-    if (!dir) {
-        if (errno != ENOENT) {
-            error_setg_errno(errp, errno, "opendir(\"%s\")", dirpath);
-        }
-        g_free(dirpath);
-        return;
-    }
-
-    for (;;) {
-        errno = 0;
-        entry = readdir(dir);
-        if (entry == NULL) {
-            if (errno) {
-                error_setg_errno(errp, errno, "readdir(\"%s\")", dirpath);
-            }
-            break;
-        }
-
-        if (entry->d_type == DT_LNK) {
-            char *path;
-
-            g_debug(" slave device '%s'", entry->d_name);
-            path = g_strdup_printf("%s/slaves/%s", syspath, entry->d_name);
-            build_guest_fsinfo_for_device(path, fs, &err);
-            g_free(path);
-
-            if (err) {
-                error_propagate(errp, err);
-                break;
-            }
-        }
-    }
-
-    g_free(dirpath);
-    closedir(dir);
-}
-
-static bool is_disk_virtual(const char *devpath, Error **errp)
-{
-    g_autofree char *syspath = realpath(devpath, NULL);
-
-    if (!syspath) {
-        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
-        return false;
-    }
-    return strstr(syspath, "/devices/virtual/block/") != NULL;
-}
-
-/* Dispatch to functions for virtual/real device */
-static void build_guest_fsinfo_for_device(char const *devpath,
-                                          GuestFilesystemInfo *fs,
-                                          Error **errp)
-{
-    ERRP_GUARD();
-    g_autofree char *syspath = NULL;
-    bool is_virtual = false;
-
-    syspath = realpath(devpath, NULL);
-    if (!syspath) {
-        if (errno != ENOENT) {
-            error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
-            return;
-        }
-
-        /* ENOENT: This devpath may not exist because of container config */
-        if (!fs->name) {
-            fs->name = g_path_get_basename(devpath);
-        }
-        return;
-    }
-
-    if (!fs->name) {
-        fs->name = g_path_get_basename(syspath);
-    }
-
-    g_debug("  parse sysfs path '%s'", syspath);
-    is_virtual = is_disk_virtual(syspath, errp);
-    if (*errp != NULL) {
-        return;
-    }
-    if (is_virtual) {
-        build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
-    } else {
-        build_guest_fsinfo_for_real_device(syspath, fs, errp);
-    }
-}
-
-#ifdef CONFIG_LIBUDEV
-
-/*
- * Wrapper around build_guest_fsinfo_for_device() for getting just
- * the disk address.
- */
-static GuestDiskAddress *get_disk_address(const char *syspath, Error **errp)
-{
-    g_autoptr(GuestFilesystemInfo) fs = NULL;
-
-    fs = g_new0(GuestFilesystemInfo, 1);
-    build_guest_fsinfo_for_device(syspath, fs, errp);
-    if (fs->disk != NULL) {
-        return g_steal_pointer(&fs->disk->value);
-    }
-    return NULL;
-}
-
-static char *get_alias_for_syspath(const char *syspath)
-{
-    struct udev *udev = NULL;
-    struct udev_device *udevice = NULL;
-    char *ret = NULL;
-
-    udev = udev_new();
-    if (udev == NULL) {
-        g_debug("failed to query udev");
-        goto out;
-    }
-    udevice = udev_device_new_from_syspath(udev, syspath);
-    if (udevice == NULL) {
-        g_debug("failed to query udev for path: %s", syspath);
-        goto out;
-    } else {
-        const char *alias = udev_device_get_property_value(
-            udevice, "DM_NAME");
-        /*
-         * NULL means there was an error and empty string means there is no
-         * alias. In case of no alias we return NULL instead of empty string.
-         */
-        if (alias == NULL) {
-            g_debug("failed to query udev for device alias for: %s",
-                syspath);
-        } else if (*alias != 0) {
-            ret = g_strdup(alias);
-        }
-    }
-
-out:
-    udev_unref(udev);
-    udev_device_unref(udevice);
-    return ret;
-}
-
-static char *get_device_for_syspath(const char *syspath)
-{
-    struct udev *udev = NULL;
-    struct udev_device *udevice = NULL;
-    char *ret = NULL;
-
-    udev = udev_new();
-    if (udev == NULL) {
-        g_debug("failed to query udev");
-        goto out;
-    }
-    udevice = udev_device_new_from_syspath(udev, syspath);
-    if (udevice == NULL) {
-        g_debug("failed to query udev for path: %s", syspath);
-        goto out;
-    } else {
-        ret = g_strdup(udev_device_get_devnode(udevice));
-    }
-
-out:
-    udev_unref(udev);
-    udev_device_unref(udevice);
-    return ret;
-}
-
-static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)
-{
-    g_autofree char *deps_dir = NULL;
-    const gchar *dep;
-    GDir *dp_deps = NULL;
-
-    /* List dependent disks */
-    deps_dir = g_strdup_printf("%s/slaves", disk_dir);
-    g_debug("  listing entries in: %s", deps_dir);
-    dp_deps = g_dir_open(deps_dir, 0, NULL);
-    if (dp_deps == NULL) {
-        g_debug("failed to list entries in %s", deps_dir);
-        return;
-    }
-    disk->has_dependencies = true;
-    while ((dep = g_dir_read_name(dp_deps)) != NULL) {
-        g_autofree char *dep_dir = NULL;
-        char *dev_name;
-
-        /* Add dependent disks */
-        dep_dir = g_strdup_printf("%s/%s", deps_dir, dep);
-        dev_name = get_device_for_syspath(dep_dir);
-        if (dev_name != NULL) {
-            g_debug("  adding dependent device: %s", dev_name);
-            QAPI_LIST_PREPEND(disk->dependencies, dev_name);
-        }
-    }
-    g_dir_close(dp_deps);
-}
-
-/*
- * Detect partitions subdirectory, name is "<disk_name><number>" or
- * "<disk_name>p<number>"
- *
- * @disk_name -- last component of /sys path (e.g. sda)
- * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)
- * @disk_dev -- device node of the disk (e.g. /dev/sda)
- */
-static GuestDiskInfoList *get_disk_partitions(
-    GuestDiskInfoList *list,
-    const char *disk_name, const char *disk_dir,
-    const char *disk_dev)
-{
-    GuestDiskInfoList *ret = list;
-    struct dirent *de_disk;
-    DIR *dp_disk = NULL;
-    size_t len = strlen(disk_name);
-
-    dp_disk = opendir(disk_dir);
-    while ((de_disk = readdir(dp_disk)) != NULL) {
-        g_autofree char *partition_dir = NULL;
-        char *dev_name;
-        GuestDiskInfo *partition;
-
-        if (!(de_disk->d_type & DT_DIR)) {
-            continue;
-        }
-
-        if (!(strncmp(disk_name, de_disk->d_name, len) == 0 &&
-            ((*(de_disk->d_name + len) == 'p' &&
-            isdigit(*(de_disk->d_name + len + 1))) ||
-                isdigit(*(de_disk->d_name + len))))) {
-            continue;
-        }
-
-        partition_dir = g_strdup_printf("%s/%s",
-            disk_dir, de_disk->d_name);
-        dev_name = get_device_for_syspath(partition_dir);
-        if (dev_name == NULL) {
-            g_debug("Failed to get device name for syspath: %s",
-                disk_dir);
-            continue;
-        }
-        partition = g_new0(GuestDiskInfo, 1);
-        partition->name = dev_name;
-        partition->partition = true;
-        partition->has_dependencies = true;
-        /* Add parent disk as dependent for easier tracking of hierarchy */
-        QAPI_LIST_PREPEND(partition->dependencies, g_strdup(disk_dev));
-
-        QAPI_LIST_PREPEND(ret, partition);
-    }
-    closedir(dp_disk);
-
-    return ret;
-}
-
-static void get_nvme_smart(GuestDiskInfo *disk)
-{
-    int fd;
-    GuestNVMeSmart *smart;
-    NvmeSmartLog log = {0};
-    struct nvme_admin_cmd cmd = {
-        .opcode = NVME_ADM_CMD_GET_LOG_PAGE,
-        .nsid = NVME_NSID_BROADCAST,
-        .addr = (uintptr_t)&log,
-        .data_len = sizeof(log),
-        .cdw10 = NVME_LOG_SMART_INFO | (1 << 15) /* RAE bit */
-                 | (((sizeof(log) >> 2) - 1) << 16)
-    };
-
-    fd = qga_open_cloexec(disk->name, O_RDONLY, 0);
-    if (fd == -1) {
-        g_debug("Failed to open device: %s: %s", disk->name, g_strerror(errno));
-        return;
-    }
-
-    if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd)) {
-        g_debug("Failed to get smart: %s: %s", disk->name, g_strerror(errno));
-        close(fd);
-        return;
-    }
-
-    disk->smart = g_new0(GuestDiskSmart, 1);
-    disk->smart->type = GUEST_DISK_BUS_TYPE_NVME;
-
-    smart = &disk->smart->u.nvme;
-    smart->critical_warning = log.critical_warning;
-    smart->temperature = lduw_le_p(&log.temperature); /* unaligned field */
-    smart->available_spare = log.available_spare;
-    smart->available_spare_threshold = log.available_spare_threshold;
-    smart->percentage_used = log.percentage_used;
-    smart->data_units_read_lo = le64_to_cpu(log.data_units_read[0]);
-    smart->data_units_read_hi = le64_to_cpu(log.data_units_read[1]);
-    smart->data_units_written_lo = le64_to_cpu(log.data_units_written[0]);
-    smart->data_units_written_hi = le64_to_cpu(log.data_units_written[1]);
-    smart->host_read_commands_lo = le64_to_cpu(log.host_read_commands[0]);
-    smart->host_read_commands_hi = le64_to_cpu(log.host_read_commands[1]);
-    smart->host_write_commands_lo = le64_to_cpu(log.host_write_commands[0]);
-    smart->host_write_commands_hi = le64_to_cpu(log.host_write_commands[1]);
-    smart->controller_busy_time_lo = le64_to_cpu(log.controller_busy_time[0]);
-    smart->controller_busy_time_hi = le64_to_cpu(log.controller_busy_time[1]);
-    smart->power_cycles_lo = le64_to_cpu(log.power_cycles[0]);
-    smart->power_cycles_hi = le64_to_cpu(log.power_cycles[1]);
-    smart->power_on_hours_lo = le64_to_cpu(log.power_on_hours[0]);
-    smart->power_on_hours_hi = le64_to_cpu(log.power_on_hours[1]);
-    smart->unsafe_shutdowns_lo = le64_to_cpu(log.unsafe_shutdowns[0]);
-    smart->unsafe_shutdowns_hi = le64_to_cpu(log.unsafe_shutdowns[1]);
-    smart->media_errors_lo = le64_to_cpu(log.media_errors[0]);
-    smart->media_errors_hi = le64_to_cpu(log.media_errors[1]);
-    smart->number_of_error_log_entries_lo =
-        le64_to_cpu(log.number_of_error_log_entries[0]);
-    smart->number_of_error_log_entries_hi =
-        le64_to_cpu(log.number_of_error_log_entries[1]);
-
-    close(fd);
-}
-
-static void get_disk_smart(GuestDiskInfo *disk)
-{
-    if (disk->address
-        && (disk->address->bus_type == GUEST_DISK_BUS_TYPE_NVME)) {
-        get_nvme_smart(disk);
-    }
-}
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    GuestDiskInfoList *ret = NULL;
-    GuestDiskInfo *disk;
-    DIR *dp = NULL;
-    struct dirent *de = NULL;
-
-    g_debug("listing /sys/block directory");
-    dp = opendir("/sys/block");
-    if (dp == NULL) {
-        error_setg_errno(errp, errno, "Can't open directory \"/sys/block\"");
-        return NULL;
-    }
-    while ((de = readdir(dp)) != NULL) {
-        g_autofree char *disk_dir = NULL, *line = NULL,
-            *size_path = NULL;
-        char *dev_name;
-        Error *local_err = NULL;
-        if (de->d_type != DT_LNK) {
-            g_debug("  skipping entry: %s", de->d_name);
-            continue;
-        }
-
-        /* Check size and skip zero-sized disks */
-        g_debug("  checking disk size");
-        size_path = g_strdup_printf("/sys/block/%s/size", de->d_name);
-        if (!g_file_get_contents(size_path, &line, NULL, NULL)) {
-            g_debug("  failed to read disk size");
-            continue;
-        }
-        if (g_strcmp0(line, "0\n") == 0) {
-            g_debug("  skipping zero-sized disk");
-            continue;
-        }
-
-        g_debug("  adding %s", de->d_name);
-        disk_dir = g_strdup_printf("/sys/block/%s", de->d_name);
-        dev_name = get_device_for_syspath(disk_dir);
-        if (dev_name == NULL) {
-            g_debug("Failed to get device name for syspath: %s",
-                disk_dir);
-            continue;
-        }
-        disk = g_new0(GuestDiskInfo, 1);
-        disk->name = dev_name;
-        disk->partition = false;
-        disk->alias = get_alias_for_syspath(disk_dir);
-        QAPI_LIST_PREPEND(ret, disk);
-
-        /* Get address for non-virtual devices */
-        bool is_virtual = is_disk_virtual(disk_dir, &local_err);
-        if (local_err != NULL) {
-            g_debug("  failed to check disk path, ignoring error: %s",
-                error_get_pretty(local_err));
-            error_free(local_err);
-            local_err = NULL;
-            /* Don't try to get the address */
-            is_virtual = true;
-        }
-        if (!is_virtual) {
-            disk->address = get_disk_address(disk_dir, &local_err);
-            if (local_err != NULL) {
-                g_debug("  failed to get device info, ignoring error: %s",
-                    error_get_pretty(local_err));
-                error_free(local_err);
-                local_err = NULL;
-            }
-        }
-
-        get_disk_deps(disk_dir, disk);
-        get_disk_smart(disk);
-        ret = get_disk_partitions(ret, de->d_name, disk_dir, dev_name);
-    }
-
-    closedir(dp);
-
-    return ret;
-}
-
-#else
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-#endif
-
-/* Return a list of the disk device(s)' info which @mount lies on */
-static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
-                                               Error **errp)
-{
-    GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
-    struct statvfs buf;
-    unsigned long used, nonroot_total, fr_size;
-    char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
-                                    mount->devmajor, mount->devminor);
-
-    fs->mountpoint = g_strdup(mount->dirname);
-    fs->type = g_strdup(mount->devtype);
-    build_guest_fsinfo_for_device(devpath, fs, errp);
-
-    if (statvfs(fs->mountpoint, &buf) == 0) {
-        fr_size = buf.f_frsize;
-        used = buf.f_blocks - buf.f_bfree;
-        nonroot_total = used + buf.f_bavail;
-        fs->used_bytes = used * fr_size;
-        fs->total_bytes = nonroot_total * fr_size;
-        fs->total_bytes_privileged = buf.f_blocks * fr_size;
-
-        fs->has_total_bytes = true;
-        fs->has_total_bytes_privileged = true;
-        fs->has_used_bytes = true;
-    }
-
-    g_free(devpath);
-
-    return fs;
-}
-
-GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
-{
-    FsMountList mounts;
-    struct FsMount *mount;
-    GuestFilesystemInfoList *ret = NULL;
-    Error *local_err = NULL;
-
-    QTAILQ_INIT(&mounts);
-    if (!build_fs_mount_list(&mounts, &local_err)) {
-        error_propagate(errp, local_err);
-        return NULL;
-    }
-
-    QTAILQ_FOREACH(mount, &mounts, next) {
-        g_debug("Building guest fsinfo for '%s'", mount->dirname);
-
-        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount, &local_err));
-        if (local_err) {
-            error_propagate(errp, local_err);
-            qapi_free_GuestFilesystemInfoList(ret);
-            ret = NULL;
-            break;
-        }
-    }
-
-    free_fs_mount_list(&mounts);
-    return ret;
-}
-#endif /* CONFIG_FSFREEZE */
-
-#if defined(CONFIG_FSTRIM)
-/*
- * Walk list of mounted file systems in the guest, and trim them.
- */
-GuestFilesystemTrimResponse *
-qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
-{
-    GuestFilesystemTrimResponse *response;
-    GuestFilesystemTrimResult *result;
-    int ret = 0;
-    FsMountList mounts;
-    struct FsMount *mount;
-    int fd;
-    struct fstrim_range r;
-
-    slog("guest-fstrim called");
-
-    QTAILQ_INIT(&mounts);
-    if (!build_fs_mount_list(&mounts, errp)) {
-        return NULL;
-    }
-
-    response = g_malloc0(sizeof(*response));
-
-    QTAILQ_FOREACH(mount, &mounts, next) {
-        result = g_malloc0(sizeof(*result));
-        result->path = g_strdup(mount->dirname);
-
-        QAPI_LIST_PREPEND(response->paths, result);
-
-        fd = qga_open_cloexec(mount->dirname, O_RDONLY, 0);
-        if (fd == -1) {
-            result->error = g_strdup_printf("failed to open: %s",
-                                            strerror(errno));
-            continue;
-        }
-
-        /* We try to cull filesystems we know won't work in advance, but other
-         * filesystems may not implement fstrim for less obvious reasons.
-         * These will report EOPNOTSUPP; while in some other cases ENOTTY
-         * will be reported (e.g. CD-ROMs).
-         * Any other error means an unexpected error.
-         */
-        r.start = 0;
-        r.len = -1;
-        r.minlen = has_minimum ? minimum : 0;
-        ret = ioctl(fd, FITRIM, &r);
-        if (ret == -1) {
-            if (errno == ENOTTY || errno == EOPNOTSUPP) {
-                result->error = g_strdup("trim not supported");
-            } else {
-                result->error = g_strdup_printf("failed to trim: %s",
-                                                strerror(errno));
-            }
-            close(fd);
-            continue;
-        }
-
-        result->has_minimum = true;
-        result->minimum = r.minlen;
-        result->has_trimmed = true;
-        result->trimmed = r.len;
-        close(fd);
-    }
-
-    free_fs_mount_list(&mounts);
-    return response;
-}
-#endif /* CONFIG_FSTRIM */
-
-#endif /* __linux__ */
-
 #if defined(__linux__) || defined(__FreeBSD__)
 void qmp_guest_set_user_password(const char *username,
                                  const char *password,
-- 
2.45.1


