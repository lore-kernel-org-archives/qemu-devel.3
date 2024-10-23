Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D8ACF5389
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFP-0006Ph-O8; Wed, 23 Oct 2024 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bEz-000667-13
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bEx-00029O-AL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CdCfZDKjDgKmr1qWba1nZzvcJHpliMqM+wrWNaI0pqc=;
 b=XxEG+jwmEbr6iqIWnEXglb/jaJntvQ7VsEE4X0xMOYqw1noG3pjW0KZUFI5Tihxyhv69m0
 fFJO4Xyzb+GCIt4ofw9GVKlmUTR/V4GW0gmRvnFCFbUKoWZQ62wrvjHDesJ3C1ieA05rnl
 qmIZp7SoQbQGubWA4VBi4Qaucu4a5WM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-SQ2lQlMePtGUpt_KzqPMYQ-1; Wed,
 23 Oct 2024 09:17:28 -0400
X-MC-Unique: SQ2lQlMePtGUpt_KzqPMYQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EB191954AE5; Wed, 23 Oct 2024 13:17:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A35E1956054; Wed, 23 Oct 2024 13:17:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/23] pc-bios/s390-ccw: Merge netboot.mak into the main
 Makefile
Date: Wed, 23 Oct 2024 15:16:52 +0200
Message-ID: <20241023131710.906748-6-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that the netboot code has been merged into the main s390-ccw.img,
it also does not make sense to keep the build rules in a separate
file. Thus let's merge netboot.mak into the main Makefile.

Message-Id: <20240621082422.136217-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netboot.mak | 45 ----------------------------------
 pc-bios/s390-ccw/Makefile    | 47 +++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 46 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/netboot.mak

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
deleted file mode 100644
index 0a24257ff4..0000000000
--- a/pc-bios/s390-ccw/netboot.mak
+++ /dev/null
@@ -1,45 +0,0 @@
-
-# libc files:
-
-LIBC_CFLAGS = $(EXTRA_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
-	      -MMD -MP -MT $@ -MF $(@:%.o=%.d)
-
-CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
-%.o : $(SLOF_DIR)/lib/libc/ctype/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
-
-STRING_OBJS = strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
-	      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
-	      memset.o memcpy.o memmove.o memcmp.o
-%.o : $(SLOF_DIR)/lib/libc/string/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
-
-STDLIB_OBJS = atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
-%.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
-
-STDIO_OBJS = sprintf.o snprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
-	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
-%.o : $(SLOF_DIR)/lib/libc/stdio/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
-
-sbrk.o: $(SLOF_DIR)/slof/sbrk.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
-
-LIBCOBJS := $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) sbrk.o
-
-libc.a: $(LIBCOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,Creating static library)
-
-# libnet files:
-
-LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
-	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
-LIBNETCFLAGS = $(EXTRA_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
-	       -DDHCPARCH=0x1F -MMD -MP -MT $@ -MF $(@:%.o=%.d)
-
-%.o : $(SLOF_DIR)/lib/libnet/%.c
-	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,Compiling)
-
-libnet.a: $(LIBNETOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,Creating static library)
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index cf6859823a..27cbb354af 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -61,7 +61,52 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=z900,-march=z10)) 3> config-cc.mak
 -include config-cc.mak
 
-include $(SRC_PATH)/netboot.mak
+# libc files:
+
+LIBC_CFLAGS = $(EXTRA_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
+	      -MMD -MP -MT $@ -MF $(@:%.o=%.d)
+
+CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
+%.o : $(SLOF_DIR)/lib/libc/ctype/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+
+STRING_OBJS = strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
+	      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
+	      memset.o memcpy.o memmove.o memcmp.o
+%.o : $(SLOF_DIR)/lib/libc/string/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+
+STDLIB_OBJS = atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
+%.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+
+STDIO_OBJS = sprintf.o snprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
+	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
+%.o : $(SLOF_DIR)/lib/libc/stdio/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+
+sbrk.o: $(SLOF_DIR)/slof/sbrk.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,Compiling)
+
+LIBCOBJS := $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) sbrk.o
+
+libc.a: $(LIBCOBJS)
+	$(call quiet-command,$(AR) -rc $@ $^,Creating static library)
+
+# libnet files:
+
+LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
+	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
+LIBNETCFLAGS = $(EXTRA_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
+	       -DDHCPARCH=0x1F -MMD -MP -MT $@ -MF $(@:%.o=%.d)
+
+%.o : $(SLOF_DIR)/lib/libnet/%.c
+	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,Compiling)
+
+libnet.a: $(LIBNETOBJS)
+	$(call quiet-command,$(AR) -rc $@ $^,Creating static library)
+
+# Main targets:
 
 build-all: s390-ccw.img
 
-- 
2.47.0


