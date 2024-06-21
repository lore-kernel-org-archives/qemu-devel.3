Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02E9C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZZo-0008Qv-H5; Fri, 21 Jun 2024 04:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZZm-0008QZ-UH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZZk-0003LT-SR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718958292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5bGAyhiRsrXgPNb1doMR/Q+cf242OIFPtw4sRJHrvQ=;
 b=OnY5oxs4s7ePDBl8paI1EaF5gaO3H89d0MDGzy1ByiXKnC8CSQnRzDOQsUtC60MO/ZPcft
 NWigQpfV8sVtjHYM4LYZ8Idwr5c6gLjsekb/tV9VVUS9+oLbtmdMTzCvRb+I7aQDGikBkL
 9gYbEnWeaMuTMQjbBkf7OYPztOgQjSU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-1x_fgTVAM1qlA2DGml31GA-1; Fri,
 21 Jun 2024 04:24:46 -0400
X-MC-Unique: 1x_fgTVAM1qlA2DGml31GA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D9C719560A2; Fri, 21 Jun 2024 08:24:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE9ED1955E80; Fri, 21 Jun 2024 08:24:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH 3/7] pc-bios/s390-ccw: Use the libc from SLOF for the main
 s390-ccw.img binary, too
Date: Fri, 21 Jun 2024 10:24:18 +0200
Message-ID: <20240621082422.136217-4-thuth@redhat.com>
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

We are already using the libc from SLOF for the s390-netboot.img, and
this libc implementation is way more complete and accurate than the
simple implementation that we currently use for the s390-ccw.img binary.
Since we are now always assuming that the SLOF submodule is available
when building the s390-ccw bios (see commit bf6903f6944f), we can drop
the simple implementation and use the SLOF libc for the s390-ccw.img
binary, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netboot.mak     |  3 --
 pc-bios/s390-ccw/libc.h          | 89 --------------------------------
 pc-bios/s390-ccw/s390-ccw.h      |  7 +--
 pc-bios/s390-ccw/bootmap.c       |  2 +-
 pc-bios/s390-ccw/cio.c           |  2 +-
 pc-bios/s390-ccw/dasd-ipl.c      |  2 +-
 pc-bios/s390-ccw/jump2ipl.c      |  2 +-
 pc-bios/s390-ccw/libc.c          | 88 -------------------------------
 pc-bios/s390-ccw/main.c          |  5 +-
 pc-bios/s390-ccw/menu.c          | 25 ++++-----
 pc-bios/s390-ccw/sclp.c          |  2 +-
 pc-bios/s390-ccw/virtio-blkdev.c |  1 -
 pc-bios/s390-ccw/virtio-scsi.c   |  2 +-
 pc-bios/s390-ccw/virtio.c        |  2 +-
 pc-bios/s390-ccw/Makefile        | 15 ++++--
 15 files changed, 34 insertions(+), 213 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/libc.h
 delete mode 100644 pc-bios/s390-ccw/libc.c

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index 046aa35587..d2b3d8ee74 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,9 +1,6 @@
 
-SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
-
 NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o
 
-LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
 LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
 
 NETLDFLAGS := $(LDFLAGS) -Wl,-Ttext=0x7800000
diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
deleted file mode 100644
index bcdc45732d..0000000000
--- a/pc-bios/s390-ccw/libc.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- * libc-style definitions and functions
- *
- * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
- *
- * This code is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- */
-
-#ifndef S390_CCW_LIBC_H
-#define S390_CCW_LIBC_H
-
-typedef unsigned long      size_t;
-typedef int                bool;
-typedef unsigned char      uint8_t;
-typedef unsigned short     uint16_t;
-typedef unsigned int       uint32_t;
-typedef unsigned long long uint64_t;
-
-static inline void *memset(void *s, int c, size_t n)
-{
-    size_t i;
-    unsigned char *p = s;
-
-    for (i = 0; i < n; i++) {
-        p[i] = c;
-    }
-
-    return s;
-}
-
-static inline void *memcpy(void *s1, const void *s2, size_t n)
-{
-    uint8_t *dest = s1;
-    const uint8_t *src = s2;
-    size_t i;
-
-    for (i = 0; i < n; i++) {
-        dest[i] = src[i];
-    }
-
-    return s1;
-}
-
-static inline int memcmp(const void *s1, const void *s2, size_t n)
-{
-    size_t i;
-    const uint8_t *p1 = s1, *p2 = s2;
-
-    for (i = 0; i < n; i++) {
-        if (p1[i] != p2[i]) {
-            return p1[i] > p2[i] ? 1 : -1;
-        }
-    }
-
-    return 0;
-}
-
-static inline size_t strlen(const char *str)
-{
-    size_t i;
-    for (i = 0; *str; i++) {
-        str++;
-    }
-    return i;
-}
-
-static inline char *strcat(char *dest, const char *src)
-{
-    int i;
-    char *dest_end = dest + strlen(dest);
-
-    for (i = 0; i <= strlen(src); i++) {
-        dest_end[i] = src[i];
-    }
-    return dest;
-}
-
-static inline int isdigit(int c)
-{
-    return (c >= '0') && (c <= '9');
-}
-
-uint64_t atoui(const char *str);
-char *uitoa(uint64_t num, char *str, size_t len);
-
-#endif
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index c977a52b50..b911ebe6d2 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -13,6 +13,10 @@
 
 /* #define DEBUG */
 
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
 typedef unsigned char      u8;
 typedef unsigned short     u16;
 typedef unsigned int       u32;
@@ -26,9 +30,6 @@ typedef unsigned long long u64;
 #define EBUSY   2
 #define ENODEV  3
 
-#ifndef NULL
-#define NULL    0
-#endif
 #ifndef MIN
 #define MIN(a, b) (((a) < (b)) ? (a) : (b))
 #endif
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index a2137449dc..bf85a9c5fe 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -8,7 +8,7 @@
  * directory.
  */
 
-#include "libc.h"
+#include <string.h>
 #include "s390-ccw.h"
 #include "s390-arch.h"
 #include "bootmap.h"
diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 83ca27ab41..11f0387ff4 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -11,7 +11,7 @@
  * directory.
  */
 
-#include "libc.h"
+#include <string.h>
 #include "s390-ccw.h"
 #include "s390-arch.h"
 #include "helper.h"
diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
index 254bb1a15e..6e895abb44 100644
--- a/pc-bios/s390-ccw/dasd-ipl.c
+++ b/pc-bios/s390-ccw/dasd-ipl.c
@@ -8,7 +8,7 @@
  * directory.
  */
 
-#include "libc.h"
+#include <string.h>
 #include "s390-ccw.h"
 #include "s390-arch.h"
 #include "dasd-ipl.h"
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 78f5f46533..6166061045 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -6,7 +6,7 @@
  * directory.
  */
 
-#include "libc.h"
+#include <string.h>
 #include "s390-ccw.h"
 #include "s390-arch.h"
 
diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
deleted file mode 100644
index 3187923950..0000000000
--- a/pc-bios/s390-ccw/libc.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * libc-style definitions and functions
- *
- * Copyright 2018 IBM Corp.
- * Author(s): Collin L. Walling <walling@linux.vnet.ibm.com>
- *
- * This code is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- */
-
-#include "libc.h"
-#include "s390-ccw.h"
-
-/**
- * atoui:
- * @str: the string to be converted.
- *
- * Given a string @str, convert it to an integer. Leading spaces are
- * ignored. Any other non-numerical value will terminate the conversion
- * and return 0. This function only handles numbers between 0 and
- * UINT64_MAX inclusive.
- *
- * Returns: an integer converted from the string @str, or the number 0
- * if an error occurred.
- */
-uint64_t atoui(const char *str)
-{
-    int val = 0;
-
-    if (!str || !str[0]) {
-        return 0;
-    }
-
-    while (*str == ' ') {
-        str++;
-    }
-
-    while (*str) {
-        if (!isdigit(*(unsigned char *)str)) {
-            break;
-        }
-        val = val * 10 + *str - '0';
-        str++;
-    }
-
-    return val;
-}
-
-/**
- * uitoa:
- * @num: an integer (base 10) to be converted.
- * @str: a pointer to a string to store the conversion.
- * @len: the length of the passed string.
- *
- * Given an integer @num, convert it to a string. The string @str must be
- * allocated beforehand. The resulting string will be null terminated and
- * returned. This function only handles numbers between 0 and UINT64_MAX
- * inclusive.
- *
- * Returns: the string @str of the converted integer @num
- */
-char *uitoa(uint64_t num, char *str, size_t len)
-{
-    long num_idx = 1; /* account for NUL */
-    uint64_t tmp = num;
-
-    IPL_assert(str != NULL, "uitoa: no space allocated to store string");
-
-    /* Count indices of num */
-    while ((tmp /= 10) != 0) {
-        num_idx++;
-    }
-
-    /* Check if we have enough space for num and NUL */
-    IPL_assert(len > num_idx, "uitoa: array too small for conversion");
-
-    str[num_idx--] = '\0';
-
-    /* Convert int to string */
-    while (num_idx >= 0) {
-        str[num_idx--] = num % 10 + '0';
-        num /= 10;
-    }
-
-    return str;
-}
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 5506798098..b8bf9f5fcc 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -8,7 +8,8 @@
  * directory.
  */
 
-#include "libc.h"
+#include <stdlib.h>
+#include <string.h>
 #include "helper.h"
 #include "s390-arch.h"
 #include "s390-ccw.h"
@@ -50,7 +51,7 @@ void write_iplb_location(void)
 
 unsigned int get_loadparm_index(void)
 {
-    return atoui(loadparm_str);
+    return atoi(loadparm_str);
 }
 
 static int is_dev_possibly_bootable(int dev_no, int sch_no)
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index d601952d3e..eab64f6357 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -9,7 +9,10 @@
  * directory.
  */
 
-#include "libc.h"
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include "s390-ccw.h"
 #include "sclp.h"
 #include "s390-time.h"
@@ -140,20 +143,17 @@ static int get_index(void)
         }
     }
 
-    return atoui(buf);
+    return atoi(buf);
 }
 
 static void boot_menu_prompt(bool retry)
 {
-    char tmp[11];
-
     if (retry) {
         sclp_print("\nError: undefined configuration"
                    "\nPlease choose:\n");
     } else if (timeout > 0) {
-        sclp_print("Please choose (default will boot in ");
-        sclp_print(uitoa(timeout / 1000, tmp, sizeof(tmp)));
-        sclp_print(" seconds):\n");
+        printf("Please choose (default will boot in %d seconds):\n",
+               (int)(timeout / 1000));
     } else {
         sclp_print("Please choose:\n");
     }
@@ -163,7 +163,6 @@ static int get_boot_index(bool *valid_entries)
 {
     int boot_index;
     bool retry = false;
-    char tmp[5];
 
     do {
         boot_menu_prompt(retry);
@@ -172,8 +171,7 @@ static int get_boot_index(bool *valid_entries)
     } while (boot_index < 0 || boot_index >= MAX_BOOT_ENTRIES ||
              !valid_entries[boot_index]);
 
-    sclp_print("\nBooting entry #");
-    sclp_print(uitoa(boot_index, tmp, sizeof(tmp)));
+    printf("\nBooting entry #%d", boot_index);
 
     return boot_index;
 }
@@ -189,7 +187,7 @@ static int zipl_print_entry(const char *data, size_t len)
 
     sclp_print(buf);
 
-    return buf[0] == ' ' ? atoui(buf + 1) : atoui(buf);
+    return buf[0] == ' ' ? atoi(buf + 1) : atoi(buf);
 }
 
 int menu_get_zipl_boot_index(const char *menu_data)
@@ -231,7 +229,6 @@ int menu_get_zipl_boot_index(const char *menu_data)
 
 int menu_get_enum_boot_index(bool *valid_entries)
 {
-    char tmp[3];
     int i;
 
     sclp_print("s390-ccw Enumerated Boot Menu.\n\n");
@@ -241,9 +238,7 @@ int menu_get_enum_boot_index(bool *valid_entries)
             if (i < 10) {
                 sclp_print(" ");
             }
-            sclp_print("[");
-            sclp_print(uitoa(i, tmp, sizeof(tmp)));
-            sclp_print("]");
+            printf("[%d]", i);
             if (i == 0) {
                 sclp_print(" default\n");
             }
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index 7251f9af4d..48b1cc4d16 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -8,7 +8,7 @@
  * directory.
  */
 
-#include "libc.h"
+#include <string.h>
 #include "s390-ccw.h"
 #include "sclp.h"
 
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index a81207b52e..08bb5c1347 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -8,7 +8,6 @@
  * directory.
  */
 
-#include "libc.h"
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index d1a84b937c..1f24007ab1 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -9,7 +9,7 @@
  * directory.
  */
 
-#include "libc.h"
+#include <string.h>
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "scsi.h"
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 5edd058d88..8c6b0a8a92 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -8,7 +8,7 @@
  * directory.
  */
 
-#include "libc.h"
+#include <string.h>
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 6207911b53..3f4232636e 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -33,13 +33,18 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 .PHONY : all clean build-all distclean
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o dasd-ipl.o
+	  virtio.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
+
+SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
+
+LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
 
 EXTRA_CFLAGS += -Wall
 EXTRA_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -fno-common -fPIE
 EXTRA_CFLAGS += -fwrapv -fno-strict-aliasing -fno-asynchronous-unwind-tables
 EXTRA_CFLAGS += -msoft-float
 EXTRA_CFLAGS += -std=gnu99
+EXTRA_CFLAGS += $(LIBC_INC)
 LDFLAGS += -Wl,-pie -nostdlib -z noexecstack
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
@@ -55,18 +60,18 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=z900,-march=z10)) 3> config-cc.mak
 -include config-cc.mak
 
+include $(SRC_PATH)/netboot.mak
+
 build-all: s390-ccw.img s390-netboot.img
 
-s390-ccw.elf: $(OBJECTS)
-	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),Linking)
+s390-ccw.elf: $(OBJECTS) libc.a
+	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $^,Linking)
 
 s390-ccw.img: s390-ccw.elf
 	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,Stripping $< into)
 
 $(OBJECTS): Makefile
 
-include $(SRC_PATH)/netboot.mak
-
 ALL_OBJS = $(sort $(OBJECTS) $(NETOBJS) $(LIBCOBJS) $(LIBNETOBJS))
 -include $(ALL_OBJS:%.o=%.d)
 
-- 
2.45.2


