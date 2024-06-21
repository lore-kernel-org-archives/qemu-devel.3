Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48FCC2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZZs-0008RZ-Ds; Fri, 21 Jun 2024 04:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZZq-0008RF-Jl
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZZo-0003Lk-Rf
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718958296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWrziMf2ceTCKn9MC4baWs15ewcjC8xpFlegXybltDA=;
 b=B0W3Ruz06iEzhF0IQXZSD1+6I74pi1/hmljF3MtvVTQwy3x0l6rATnVF1LEXQqUcugP3Gk
 fwJ4twBdfwy3h57i5jnJ+YEqA3wQHm2bzJD87pIKiH2XLvK9wvxPap9DPn6vBjR5pHviN3
 TmrNk5BIICKadx0PlbAEP4z/VoB42W8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-EdEBQ0CnNWKY1AZWFUQYhQ-1; Fri,
 21 Jun 2024 04:24:52 -0400
X-MC-Unique: EdEBQ0CnNWKY1AZWFUQYhQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E03EF195609E; Fri, 21 Jun 2024 08:24:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B92DC1955E80; Fri, 21 Jun 2024 08:24:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH 4/7] pc-bios/s390-ccw: Link the netboot code into the main
 s390-ccw.img binary
Date: Fri, 21 Jun 2024 10:24:19 +0200
Message-ID: <20240621082422.136217-5-thuth@redhat.com>
In-Reply-To: <20240621082422.136217-1-thuth@redhat.com>
References: <20240621082422.136217-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

We originally built a separate binary for the netboot code since it
was considered as experimental and we could not be sure that the
necessary SLOF module had been checked out. Time passed, the code
proved its usefulness, and the build system nowadays makes sure that
the SLOF module is checked out if you have a s390x compiler available
for building the s390-ccw bios. So there is no real compelling reason
anymore to keep the netboot code in a separate binary. Linking the
code together with the main s390-ccw.img will make future enhancements
much easier, like supporting more than one boot device.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
index b911ebe6d2..b960f85b90 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -54,6 +54,9 @@ void write_iplb_location(void);
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
index bf85a9c5fe..3c56d547ca 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -928,7 +928,7 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        jump_to_IPL_code(vdev->netboot_start_addr);
+        netmain();
     }
 
     ipl_scsi();
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index b8bf9f5fcc..558c26c21b 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -37,8 +37,13 @@ LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
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
 
@@ -230,7 +235,6 @@ static int virtio_setup(void)
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
         sclp_print("Network boot device detected\n");
-        vdev->netboot_start_addr = qipl.netboot_start_addr;
         return 0;
     case VIRTIO_ID_BLOCK:
         ret = virtio_blk_setup_device(blk_schid);
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 5cd619b2d6..99b07f72d9 100644
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
2.45.2


