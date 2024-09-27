Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA97CEBF60
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzCq-0002Sr-Nn; Thu, 26 Sep 2024 20:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCp-0002O5-Ii; Thu, 26 Sep 2024 20:51:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCn-0007FO-LS; Thu, 26 Sep 2024 20:51:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QLMDka024825;
 Fri, 27 Sep 2024 00:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=edVb/WNPzOg2P
 DIyfcKCNSCdMk87VuFLvBL6/nt/0Gc=; b=VacMtP1b6mSTNioi94uXvW+oMVwg1
 5jYA/pirBIGX8G7C1qm6R5v2GrmUipLxDn2mD0pXE98yhPuiI8qU9GfKoFkyBI6R
 G80YY/GSIfqJHmvhLWDyAin74X0XjzMI0obcTPRhepRY26wa2U22y4Q0u75CDC1W
 yCDi+2b9nWuDXECM8/bhipVh7hdbz7Hu8n1VxmcYQPWbfgCgdu/S2V6b5Y7/KJfz
 qktJ+YPz9KE045PatTc+sh5viPZFEQOJt9roMFkhiEWzN9W5adoPeRxZsDmEMtbg
 aCASnZIVaiFsCvFHHsF3541+oJhRASp8I/D8Z73cRXy6osZ5SBrhtqVXA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntwsem5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pUug027488;
 Fri, 27 Sep 2024 00:51:30 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntwsem3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R046Wv020844;
 Fri, 27 Sep 2024 00:51:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb63httu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0pSQL16777818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14DB65805D;
 Fri, 27 Sep 2024 00:51:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9086258052;
 Fri, 27 Sep 2024 00:51:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:27 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 04/18] hw/s390x: Remove the possibility to load the
 s390-netboot.img binary
Date: Thu, 26 Sep 2024 20:51:03 -0400
Message-ID: <20240927005117.1679506-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yusmrzl8rv9-wU9iKS0MT_0o5zdASmWi
X-Proofpoint-GUID: EsknepMhpWoJw2ifxgUFX1PSt-0eps97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270002
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Since the netboot code has now been merged into the main s390-ccw.img
binary, we don't need the separate s390-netboot.img anymore. Remove
it and the code that was responsible for loading it.

Co-authored by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

---
 hw/s390x/ipl.h             | 12 +++------
 hw/s390x/ipl.c             | 55 --------------------------------------
 hw/s390x/s390-virtio-ccw.c | 10 ++-----
 pc-bios/meson.build        |  1 -
 4 files changed, 6 insertions(+), 72 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 57cd125769..b2105b616a 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -134,11 +134,8 @@ void s390_ipl_clear_reset_request(void);
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
- * double-word aligned.
- * Placement of data fields in this area must account for
- * their alignment needs. E.g., netboot_start_address must
- * have an offset of 4 + n * 8 bytes within the struct in order
- * to keep it double-word aligned.
+ * double-word aligned. Placement of 64-bit data fields in this
+ * area must account for their alignment needs.
  * The total size of the struct must never exceed 28 bytes.
  * This definition must be kept in sync with the definition
  * in pc-bios/s390-ccw/iplb.h.
@@ -146,9 +143,9 @@ void s390_ipl_clear_reset_request(void);
 struct QemuIplParameters {
     uint8_t  qipl_flags;
     uint8_t  reserved1[3];
-    uint64_t netboot_start_addr;
+    uint64_t reserved2;
     uint32_t boot_menu_timeout;
-    uint8_t  reserved2[12];
+    uint8_t  reserved3[12];
 } QEMU_PACKED;
 typedef struct QemuIplParameters QemuIplParameters;
 
@@ -178,7 +175,6 @@ struct S390IPLState {
     char *initrd;
     char *cmdline;
     char *firmware;
-    char *netboot_fw;
     uint8_t cssid;
     uint8_t ssid;
     uint16_t devno;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index c33a044d1d..07c8ca69f5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -288,7 +288,6 @@ static Property s390_ipl_properties[] = {
     DEFINE_PROP_STRING("initrd", S390IPLState, initrd),
     DEFINE_PROP_STRING("cmdline", S390IPLState, cmdline),
     DEFINE_PROP_STRING("firmware", S390IPLState, firmware),
-    DEFINE_PROP_STRING("netboot_fw", S390IPLState, netboot_fw),
     DEFINE_PROP_BOOL("enforce_bios", S390IPLState, enforce_bios, false),
     DEFINE_PROP_BOOL("iplbext_migration", S390IPLState, iplbext_migration,
                      true),
@@ -480,56 +479,6 @@ int s390_ipl_set_loadparm(uint8_t *loadparm)
     return -1;
 }
 
-static int load_netboot_image(Error **errp)
-{
-    MachineState *ms = MACHINE(qdev_get_machine());
-    S390IPLState *ipl = get_ipl_device();
-    char *netboot_filename;
-    MemoryRegion *sysmem =  get_system_memory();
-    MemoryRegion *mr = NULL;
-    void *ram_ptr = NULL;
-    int img_size = -1;
-
-    mr = memory_region_find(sysmem, 0, 1).mr;
-    if (!mr) {
-        error_setg(errp, "Failed to find memory region at address 0");
-        return -1;
-    }
-
-    ram_ptr = memory_region_get_ram_ptr(mr);
-    if (!ram_ptr) {
-        error_setg(errp, "No RAM found");
-        goto unref_mr;
-    }
-
-    netboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->netboot_fw);
-    if (netboot_filename == NULL) {
-        error_setg(errp, "Could not find network bootloader '%s'",
-                   ipl->netboot_fw);
-        goto unref_mr;
-    }
-
-    img_size = load_elf_ram(netboot_filename, NULL, NULL, NULL,
-                            &ipl->start_addr,
-                            NULL, NULL, NULL, 1, EM_S390, 0, 0, NULL,
-                            false);
-
-    if (img_size < 0) {
-        img_size = load_image_size(netboot_filename, ram_ptr, ms->ram_size);
-        ipl->start_addr = KERN_IMAGE_START;
-    }
-
-    if (img_size < 0) {
-        error_setg(errp, "Failed to load network bootloader");
-    }
-
-    g_free(netboot_filename);
-
-unref_mr:
-    memory_region_unref(mr);
-    return img_size;
-}
-
 static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
                                          int virtio_id)
 {
@@ -754,10 +703,6 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
             ipl->iplb_valid = s390_gen_initial_iplb(ipl);
         }
     }
-    if (ipl->netboot) {
-        load_netboot_image(&error_fatal);
-        ipl->qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
-    }
     s390_ipl_set_boot_menu(ipl);
     s390_ipl_prepare_qipl(cpu);
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 18240a0fd8..c89a5475eb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -197,11 +197,10 @@ static void s390_memory_init(MemoryRegion *ram)
 static void s390_init_ipl_dev(const char *kernel_filename,
                               const char *kernel_cmdline,
                               const char *initrd_filename, const char *firmware,
-                              const char *netboot_fw, bool enforce_bios)
+                              bool enforce_bios)
 {
     Object *new = object_new(TYPE_S390_IPL);
     DeviceState *dev = DEVICE(new);
-    char *netboot_fw_prop;
 
     if (kernel_filename) {
         qdev_prop_set_string(dev, "kernel", kernel_filename);
@@ -212,11 +211,6 @@ static void s390_init_ipl_dev(const char *kernel_filename,
     qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
     qdev_prop_set_string(dev, "firmware", firmware);
     qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
-    netboot_fw_prop = object_property_get_str(new, "netboot_fw", &error_abort);
-    if (!strlen(netboot_fw_prop)) {
-        qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
-    }
-    g_free(netboot_fw_prop);
     object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
                               new);
     object_unref(new);
@@ -284,7 +278,7 @@ static void ccw_init(MachineState *machine)
     s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
                       machine->initrd_filename,
                       machine->firmware ?: "s390-ccw.img",
-                      "s390-netboot.img", true);
+                      true);
 
     dev = qdev_new(TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 090379763e..4823dff189 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -68,7 +68,6 @@ blobs = [
   'kvmvapic.bin',
   'pvh.bin',
   's390-ccw.img',
-  's390-netboot.img',
   'slof.bin',
   'skiboot.lid',
   'palcode-clipper',
-- 
2.45.1


