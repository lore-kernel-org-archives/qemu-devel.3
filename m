Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE6DCED24F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxypg-00043m-7x; Mon, 07 Oct 2024 21:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypc-00042M-Th; Mon, 07 Oct 2024 21:16:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypa-0008F9-SI; Mon, 07 Oct 2024 21:16:08 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4980P4mU002291;
 Tue, 8 Oct 2024 01:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=Xa9SWvj2nTOBj
 7ZdljDWx6GyUtVU/3eH1k+1NqUZLt0=; b=MnOurqNOsllNcqgCEEFdkjUUxYFPT
 1bGM+9dAR8lwXUj5qtBn11o7uaw+eyqphNxqw03L94itqf7X2tYdym+tPxiGRrMy
 GdSHVk40A6cbw6uw7Hml8HcuuaU3fJ3EVVM0EyMyDuDtwN8aPxkqJhkLMQeXK5k0
 Z7adQqD8rhPSTmgwrsx0+wPuynwEvCWP0Ap+zPRJ9K5imhqZXse8pq/rOdaCAmqw
 zkEzRdccq8AzXDiJRDPN1tv/B3/Iv8eqAgQmRQqYTsfdT2a6neoK8Pau1eV7z6jg
 Y3ANWxAoiFZhkYPdGL4HpF79aY3cxZHZPlu3V++fhsd6jKTdLyJN3y7CQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424t5tg5d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981G4in000799;
 Tue, 8 Oct 2024 01:16:04 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424t5tg5d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497N5EnV022861;
 Tue, 8 Oct 2024 01:16:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0s7nt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981G1kY47645314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C51B958055;
 Tue,  8 Oct 2024 01:16:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47CA158043;
 Tue,  8 Oct 2024 01:16:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:01 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 03/19] pc-bios/s390-ccw: Link the netboot code into the
 main s390-ccw.img binary
Date: Mon,  7 Oct 2024 21:15:36 -0400
Message-ID: <20241008011552.2645520-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EY-2RPkI7Ksw5XYJuncxneDU9Lt74Rri
X-Proofpoint-GUID: Um5hFovDlJbjrdUX3xDVz5Hl5LxWNpb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=898 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We originally built a separate binary for the netboot code since it
was considered as experimental and we could not be sure that the
necessary SLOF module had been checked out. Time passed, the code
proved its usefulness, and the build system nowadays makes sure that
the SLOF module is checked out if you have a s390x compiler available
for building the s390-ccw bios. So there is no real compelling reason
anymore to keep the netboot code in a separate binary. Linking the
code together with the main s390-ccw.img will make future enhancements
much easier, like supporting more than one boot device.

Co-authored by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/netboot.mak | 14 --------------
 pc-bios/s390-ccw/cio.h       |  2 ++
 pc-bios/s390-ccw/iplb.h      |  4 ++--
 pc-bios/s390-ccw/s390-ccw.h  |  3 +++
 pc-bios/s390-ccw/virtio.h    |  1 -
 pc-bios/s390-ccw/bootmap.c   |  2 +-
 pc-bios/s390-ccw/main.c      | 10 +++++++---
 pc-bios/s390-ccw/netmain.c   | 15 ++-------------
 pc-bios/s390-ccw/Makefile    | 13 +++++++------
 9 files changed, 24 insertions(+), 40 deletions(-)

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index d2b3d8ee74..0a24257ff4 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,18 +1,4 @@
 
-NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o
-
-LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
-
-NETLDFLAGS := $(LDFLAGS) -Wl,-Ttext=0x7800000
-
-$(NETOBJS): EXTRA_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
-
-s390-netboot.elf: $(NETOBJS) libnet.a libc.a
-	$(call quiet-command,$(CC) $(NETLDFLAGS) -o $@ $^,Linking)
-
-s390-netboot.img: s390-netboot.elf
-	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,Stripping $< into)
-
 # libc files:
 
 LIBC_CFLAGS = $(EXTRA_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 8b18153deb..6a5e86ba01 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -361,6 +361,8 @@ typedef struct CcwSearchIdData {
     uint8_t record;
 } __attribute__((packed)) CcwSearchIdData;
 
+extern SubChannelId net_schid;
+
 int enable_mss_facility(void);
 void enable_subchannel(SubChannelId schid);
 uint16_t cu_type(SubChannelId schid);
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index cb6ac8a880..3758698468 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -87,9 +87,9 @@ extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 struct QemuIplParameters {
     uint8_t  qipl_flags;
     uint8_t  reserved1[3];
-    uint64_t netboot_start_addr;
+    uint64_t reserved2;
     uint32_t boot_menu_timeout;
-    uint8_t  reserved2[12];
+    uint8_t  reserved3[12];
 } __attribute__ ((packed));
 typedef struct QemuIplParameters QemuIplParameters;
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 9b622e616a..0ed7eb8ade 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -55,6 +55,9 @@ void write_iplb_location(void);
 unsigned int get_loadparm_index(void);
 void main(void);
 
+/* netmain.c */
+void netmain(void);
+
 /* sclp.c */
 void sclp_print(const char *string);
 void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 85bd9d1695..6f9a558ff5 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -253,7 +253,6 @@ struct VDev {
     uint8_t scsi_dev_heads;
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
-    uint64_t netboot_start_addr;
     uint32_t max_transfer;
     uint32_t guest_features[2];
 };
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 3cc79706be..414c3f1b47 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -929,7 +929,7 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        jump_to_IPL_code(vdev->netboot_start_addr);
+        netmain();
     }
 
     ipl_scsi();
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 73093d3f14..2345432abb 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -38,8 +38,13 @@ LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
  */
 void write_subsystem_identification(void)
 {
-    lowcore->subchannel_id = blk_schid.sch_id;
-    lowcore->subchannel_nr = blk_schid.sch_no;
+    if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() == VIRTIO_ID_NET) {
+        lowcore->subchannel_id = net_schid.sch_id;
+        lowcore->subchannel_nr = net_schid.sch_no;
+    } else {
+        lowcore->subchannel_id = blk_schid.sch_id;
+        lowcore->subchannel_nr = blk_schid.sch_no;
+    }
     lowcore->io_int_parm = 0;
 }
 
@@ -231,7 +236,6 @@ static int virtio_setup(void)
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
         puts("Network boot device detected");
-        vdev->netboot_start_addr = qipl.netboot_start_addr;
         return 0;
     case VIRTIO_ID_BLOCK:
         ret = virtio_blk_setup_device(blk_schid);
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 509119be15..bc6ad8695f 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -41,7 +41,6 @@
 #define DEFAULT_TFTP_RETRIES 20
 
 extern char _start[];
-void write_iplb_location(void) {}
 
 #define KERNEL_ADDR             ((void *)0L)
 #define KERNEL_MAX_SIZE         ((long)_start)
@@ -50,10 +49,9 @@ void write_iplb_location(void) {}
 /* STSI 3.2.2 offset of first vmdb + offset of uuid inside vmdb */
 #define STSI322_VMDB_UUID_OFFSET ((8 + 12) * 4)
 
-IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
 static char cfgbuf[2048];
 
-static SubChannelId net_schid = { .one = 1 };
+SubChannelId net_schid = { .one = 1 };
 static uint8_t mac[6];
 static uint64_t dest_timer;
 
@@ -438,15 +436,6 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
     return rc;
 }
 
-void write_subsystem_identification(void)
-{
-    SubChannelId *schid = (SubChannelId *) 184;
-    uint32_t *zeroes = (uint32_t *) 188;
-
-    *schid = net_schid;
-    *zeroes = 0;
-}
-
 static bool find_net_dev(Schib *schib, int dev_no)
 {
     int i, r;
@@ -509,7 +498,7 @@ static void virtio_setup(void)
     IPL_assert(found, "No virtio net device found");
 }
 
-void main(void)
+void netmain(void)
 {
     filename_ip_t fn_ip;
     int rc, fnlen;
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 3f4232636e..cf6859823a 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -32,19 +32,20 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 .PHONY : all clean build-all distclean
 
-OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-	  virtio.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
+OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
+	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
 LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
+LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
 
 EXTRA_CFLAGS += -Wall
 EXTRA_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -fno-common -fPIE
 EXTRA_CFLAGS += -fwrapv -fno-strict-aliasing -fno-asynchronous-unwind-tables
 EXTRA_CFLAGS += -msoft-float
 EXTRA_CFLAGS += -std=gnu99
-EXTRA_CFLAGS += $(LIBC_INC)
+EXTRA_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
 LDFLAGS += -Wl,-pie -nostdlib -z noexecstack
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
@@ -62,9 +63,9 @@ config-cc.mak: Makefile
 
 include $(SRC_PATH)/netboot.mak
 
-build-all: s390-ccw.img s390-netboot.img
+build-all: s390-ccw.img
 
-s390-ccw.elf: $(OBJECTS) libc.a
+s390-ccw.elf: $(OBJECTS) libnet.a libc.a
 	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $^,Linking)
 
 s390-ccw.img: s390-ccw.elf
@@ -72,7 +73,7 @@ s390-ccw.img: s390-ccw.elf
 
 $(OBJECTS): Makefile
 
-ALL_OBJS = $(sort $(OBJECTS) $(NETOBJS) $(LIBCOBJS) $(LIBNETOBJS))
+ALL_OBJS = $(sort $(OBJECTS) $(LIBCOBJS) $(LIBNETOBJS))
 -include $(ALL_OBJS:%.o=%.d)
 
 clean:
-- 
2.45.1


