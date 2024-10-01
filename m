Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A60CEACDE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svevW-0006ZM-1g; Tue, 01 Oct 2024 11:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1svevU-0006YX-MC; Tue, 01 Oct 2024 11:36:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1svevS-0006WB-Ek; Tue, 01 Oct 2024 11:36:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491FLKka025383;
 Tue, 1 Oct 2024 15:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=aNfGkfiYOUovw
 xB3qM7PqOAgxOsZmaHO4n59hTNi8jA=; b=VQkQcopsEzcW8cabp9DpwRs/PVMSi
 pIHSjYz8/ogTKfjPTVb1AMfxQ3UDEzasHWhSq6hTKtJlHIlhwtt8RfWq0Lb7Owfg
 wDisN40yt6DfEdnHxPLyRM7m40d/DwgDp+lVrFH/8tRfv4f/NuHtxTfLFesF8tDB
 WAMog6B2ZuvQYsz0IOX4ReTJViJuDJknedxh3TC2JtPlxp0+VJ81EoXidlH/eazf
 uZjKnXNlDqUjzoeOrpKEiLRsPxlveqZp9ckysBHHN3+p6BDC+GIgP3YKyJpCcDH1
 LeX6KzRv10b0kL0RBDa5Vz3p1YjPmoboW+zl5qRyaXnx0uVn82QHBtxxg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420kn4r2mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491FY4cA019836;
 Tue, 1 Oct 2024 15:36:31 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420kn4r2md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491DWR70002346;
 Tue, 1 Oct 2024 15:36:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu14wj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 491FaPXU42598768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 15:36:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECDEC20043;
 Tue,  1 Oct 2024 15:36:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A14D520040;
 Tue,  1 Oct 2024 15:36:24 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.fritz.box (unknown
 [9.171.30.227]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 15:36:24 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Jens Remus <jremus@linux.ibm.com>
Subject: [PATCH v1 3/3] pc-bios/s390-ccw: Introduce `EXTRA_LDFLAGS`
Date: Tue,  1 Oct 2024 17:36:18 +0200
Message-ID: <20241001153618.17791-4-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001153618.17791-1-mhartmay@linux.ibm.com>
References: <20241001153618.17791-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GZsDp5Tv87nw38iczhg-FY5tCtpF4hRg
X-Proofpoint-GUID: QgwUv-xkVO3JtDbWQ1MHRaKzp0AZBjPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=638
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010099
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Some packaging tools want to override `LDFLAGS` when building QEMU, this will
result in a build error as most likely no `-nostdlib` flag is passed. Introduce
`EXTRA_LDFLAGS` so that the packager can override `LDFLAGS` without breaking the
build.

Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
Note: Normally, I would rather use ALL_LDFLAGS, but adding EXTRA_LDFLAGS matches
      with the current Makefile style.
---
 pc-bios/s390-ccw/netboot.mak | 2 +-
 pc-bios/s390-ccw/Makefile    | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index 046aa35587ac..b1bc12603d99 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -6,7 +6,7 @@ NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o
 LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
 LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
 
-NETLDFLAGS := $(LDFLAGS) -Wl,-Ttext=0x7800000
+NETLDFLAGS := $(EXTRA_LDFLAGS) $(LDFLAGS) -Wl,-Ttext=0x7800000
 
 $(NETOBJS): EXTRA_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
 
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index ab6bd1edf41e..56c971462992 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -4,6 +4,7 @@ all: build-all
 
 include config-host.mak
 CFLAGS = -O2 -g
+LDFLAGS ?=
 MAKEFLAGS += -rR
 
 GIT_SUBMODULES = roms/SLOF
@@ -40,7 +41,7 @@ EXTRA_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -fno-common -fPIE
 EXTRA_CFLAGS += -fwrapv -fno-strict-aliasing -fno-asynchronous-unwind-tables
 EXTRA_CFLAGS += -msoft-float
 EXTRA_CFLAGS += -std=gnu99
-LDFLAGS += -Wl,-pie -nostdlib -z noexecstack -z text
+EXTRA_LDFLAGS += -Wl,-pie -nostdlib -z noexecstack -z text
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
 cc-option = if $(call cc-test, $1); then \
@@ -58,7 +59,7 @@ config-cc.mak: Makefile
 build-all: s390-ccw.img s390-netboot.img
 
 s390-ccw.elf: $(OBJECTS)
-	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),Linking)
+	$(call quiet-command,$(CC) $(EXTRA_LDFLAGS) $(LDFLAGS) -o $@ $(OBJECTS),Linking)
 
 s390-ccw.img: s390-ccw.elf
 	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,Stripping $< into)
-- 
2.43.0


