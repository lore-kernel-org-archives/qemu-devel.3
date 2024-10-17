Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152CED2F7DE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 01:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Fcf-0004S6-SG; Wed, 16 Oct 2024 21:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1FcW-0004Oj-2H; Wed, 16 Oct 2024 21:48:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1FcQ-00030S-Mi; Wed, 16 Oct 2024 21:48:06 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GLQPHs032060;
 Thu, 17 Oct 2024 01:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Wgfcz87uZBAneHSMM
 i1Wkl9ZAA23tfYn02tGR2s1e8U=; b=gtGJc4WTy11bHAx02PukDHzbTrbeyUoZn
 qcuH/fGa3QqbXCxqVKf6uDy7ETm7ExaGjxCBmJEjRwQNOaSorrX/579rdarMaMRp
 9n1WJXkWmuo66KjUzN/471kGPELxEHr3nmYmqD1J4I6qb6hEESVQXtoOjeotvUtZ
 GKzL7Sz+Z8BeNrDGWoZoxVRH+QXolewE1hfk+7sSWEG9o8AZ9noFkOc9RBXPpfBA
 GGPTNiCyfDT5ai47a2vekxRMYPdKhKJWKlI8VH0cMbEAV/0N3SsmFlQKElXbP4eJ
 N/rirVozqGdevHnoUw5rFPSI/ODUx15yaL3KNWdnEU5uFjKw1ASjA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42and7grv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49H1m023011141;
 Thu, 17 Oct 2024 01:48:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42and7gruu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GM8Zkn005936;
 Thu, 17 Oct 2024 01:47:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42865140wq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:47:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49H1lvn139912090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 01:47:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D39EF5805A;
 Thu, 17 Oct 2024 01:47:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C68B58052;
 Thu, 17 Oct 2024 01:47:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.153.16])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2024 01:47:57 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v4 04/19] hw/s390x: Remove the possibility to load the
 s390-netboot.img binary
Date: Wed, 16 Oct 2024 21:47:33 -0400
Message-ID: <20241017014748.829029-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017014748.829029-1-jrossi@linux.ibm.com>
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4gguBsy5USMt0Y_qVBO0G9ZrTfMc_rBW
X-Proofpoint-ORIG-GUID: Y4vCd4sgYo0wk_mdwPDAy6QQgD3U3_UI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410170011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 5f60977ceb..8c490eeb52 100644
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
index 5aa8d207a3..529e53f308 100644
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


