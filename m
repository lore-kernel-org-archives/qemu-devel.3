Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006C0D2F7DD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 01:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Fci-0004Tc-PH; Wed, 16 Oct 2024 21:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1FcX-0004PJ-FP; Wed, 16 Oct 2024 21:48:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t1FcS-00030j-7P; Wed, 16 Oct 2024 21:48:09 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GNtAjx026809;
 Thu, 17 Oct 2024 01:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tX2wGx0xeOmZ7E/fy
 5NtqQJRluafjriSO7wns8yXhiM=; b=ZOycQ8f2dxEKskERgug6DWW8DNQNuW/Xf
 rZtXNKNiwr2uBdPVC+7IXCXYD2vhJtX5RVp/7wEGLl1JAd9GAmieGO7PTVFUOUb+
 yHY5Zb7nbeXuBnrgDpYALkumE9eAfLZMPRLfnhH6Qhz566apVgPZkMeV8/MJC2yq
 2Xn9x2WQV/WwyhasHFnBz/P6JH/avhsO5y+hdfhFaR1Mger/jPlg5C/TPL3FOMVe
 vxJa8JclzswtMt8QWEQegRgvUPAZek95soVC47KOhzNWq5rZq+yAkeBLfWyft1OD
 xGZMpX0P75igyRpAkYvLdPNNCZBeN0H/9jcd+k1Y7l0LHAbhkjxTg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqk2gbh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49H1m1J6006033;
 Thu, 17 Oct 2024 01:48:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqk2gbgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GNwH5I027452;
 Thu, 17 Oct 2024 01:48:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txvfag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 01:48:00 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49H1lxT851183948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 01:47:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4370C5805E;
 Thu, 17 Oct 2024 01:47:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A800958052;
 Thu, 17 Oct 2024 01:47:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.153.16])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2024 01:47:58 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v4 05/19] pc-bios/s390-ccw: Merge netboot.mak into the main
 Makefile
Date: Wed, 16 Oct 2024 21:47:34 -0400
Message-ID: <20241017014748.829029-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017014748.829029-1-jrossi@linux.ibm.com>
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nvxsSDn3wJNwrk8AAk1lvvAdWZRjr1Ww
X-Proofpoint-ORIG-GUID: v-YDBi-SfcO-bSSGXcXdABV1gJMJtqjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170008
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, LOTS_OF_MONEY=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that the netboot code has been merged into the main s390-ccw.img,
it also does not make sense to keep the build rules in a separate
file. Thus let's merge netboot.mak into the main Makefile.

Co-authored by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/netboot.mak |  45 ---------------------------------
 pc-bios/s390-ccw/Makefile    |  47 ++++++++++++++++++++++++++++++++++-
 pc-bios/s390-netboot.img     | Bin 67232 -> 0 bytes
 3 files changed, 46 insertions(+), 46 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/netboot.mak
 delete mode 100644 pc-bios/s390-netboot.img

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
 
diff --git a/pc-bios/s390-netboot.img b/pc-bios/s390-netboot.img
deleted file mode 100644
index 6908e49f06801808b826d3a01f88132cf1b2f57c..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 67232
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

-- 
2.45.1


