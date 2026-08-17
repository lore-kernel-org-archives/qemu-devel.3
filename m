Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BB8C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuaD-0000nu-PO; Mon, 17 Aug 2026 06:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuaC-0000nE-Db; Mon, 17 Aug 2026 06:28:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuaA-0008Eb-F4; Mon, 17 Aug 2026 06:28:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVYsf3727875; Mon, 17 Aug 2026 10:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=joAXqTTfzV8FHfI/G
 Ma9UYwVNf0mOTattx8ksSkFFoU=; b=Y267Iipepc2swW/2/kOD3xIurL0OEjkjy
 vEtarZomAe+dJB6Ii+E3dJDarP7wTKk+Zena6ZqdyDF6n9o6yCnPLTZ0ORKgt8xn
 RmjmbTtK7pKlHBx5bAxjj89cGpm6n8wJYpdGTLwUmQYid5FaDPNZ152GEfw8gYXl
 87lKSimQKb70s2/uMRu7RoVaY8NGMvpIkK35QJILY98LYr9emncN9wRWX6wuUsVR
 VdtlyECtjiFpqbkeFziuNBGRH25+2vsIIDT5fnBQAbgDhc1bWoDk2Me699Ig5Ayx
 jQ04gJc6M5AL/9QFoEt6H36xF+veWynbM81nEhdGlGSVyt0U2/6bQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4hras-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:28:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQURa019302;
 Mon, 17 Aug 2026 10:28:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejwmpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:28:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HASZXi28443284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:28:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED9BE58058;
 Mon, 17 Aug 2026 10:28:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBAC45805B;
 Mon, 17 Aug 2026 10:28:27 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:28:27 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH 2/8] hw/loader: add load_elf_ram_sym_buf() for in-memory
 ELF loading
Date: Mon, 17 Aug 2026 15:57:19 +0530
Message-ID: <20260817102733.605346-3-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
References: <20260817102733.605346-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ShgJaDe2Xm53URUTUQ0V0AGQqcf5AkAc
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82e256 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=dabpQpVp9OP7UmTFCWUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfXx+k9lwoCLniP
 VpXah1r3k1pnEoxNwnC3JNUcPS0NCFTvKcoNwHvGhOV2bTOelaTUwxOXV7AW9MQNqLOoxTGiVxD
 mg8MaTI4ezrMTl1iYMqJf/SPifuS/0w=
X-Proofpoint-ORIG-GUID: VqWDw3qB9o3bYCSAySo4Kw8TVmO1cnBd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX7NqKYRaflM4K
 SQ/UXEZP5agOb4sJ0GKdpzkPnRHKsWD7NgzuDuh+Vy3niyBHw3TyyQIeytoW6OTTXmmj9jXauMC
 pBE0+0Y5ULIB2pOFDTk+gqKJf8kKm8hNSNqt+hHnpj3eLL1XGGimw6fqBx6fQ1kKv4XU7r2kwf+
 f9/NFVcs3px0hqgDftf+xZHOw6yLl/GXRRx7reUyT2R/QBcNFve/vEPRIcQEeVEb+fb06O9DWtB
 GxIqxL/yX5ygDaJY/JttuFsiW0ClUbgPYkTuc/iun8F9dMYrrsuqdAe76t1w04J/VuMfr+jjZIs
 AQ/FUfe8vbYzP5HS1NwjFznzb0W2ngl4h6AbDOt7RmAwD9xHMeJOaT0lnj1BA2cxdSlnlHQ075j
 Yjq4xeRVhr5m+J7fxkbDpTdYZU+5K/xwoRRWuf3KALRJoxoSI8Tf8ib0qmDGSFZk7jYbADKLfKq
 RvHN4oQLolOwzdbqFVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Utkarsh Verma <uverma@linux.ibm.com>

Add a new public API load_elf_ram_sym_buf() that loads an ELF
image from a caller-supplied memory buffer rather than a file path.
The implementation writes the buffer to an anonymous memfd, then
reuses the existing load_elf32/load_elf64 paths.

To support per-segment inspection by callers (e.g. detecting VoF
firmware segments), extend the internal load_elf{32,64} template
(elf_ops.h.inc) with an optional segment_fn_t callback that is
invoked once for every PT_LOAD segment after its load address is
resolved. Returning false from the callback aborts the load with
ELF_LOAD_FAILED.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/core/loader.c         | 77 ++++++++++++++++++++++++++++++++++++++--
 include/hw/core/loader.h | 30 ++++++++++++++++
 include/hw/elf_ops.h.inc | 12 ++++++-
 3 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86..4e4e9764a3 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -43,6 +43,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/memfd.h"
 #include "qemu/datadir.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -510,12 +511,14 @@ ssize_t load_elf_ram_sym(const char *filename,
         ret = load_elf64(filename, fd, elf_note_fn,
                          translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, pflags, elf_machine,
-                         clear_lsb, data_swab, as, load_rom, sym_cb);
+                         clear_lsb, data_swab, as, load_rom, sym_cb,
+                         NULL, NULL);
     } else {
         ret = load_elf32(filename, fd, elf_note_fn,
                          translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, pflags, elf_machine,
-                         clear_lsb, data_swab, as, load_rom, sym_cb);
+                         clear_lsb, data_swab, as, load_rom, sym_cb,
+                         NULL, NULL);
     }
 
     if (ret > 0) {
@@ -527,6 +530,76 @@ ssize_t load_elf_ram_sym(const char *filename,
     return ret;
 }
 
+ssize_t load_elf_ram_sym_buf(const uint8_t *buf, size_t buflen,
+                              uint64_t (*elf_note_fn)(void *, void *, bool),
+                              uint64_t (*translate_fn)(void *, uint64_t),
+                              void *translate_opaque, uint64_t *pentry,
+                              uint64_t *lowaddr, uint64_t *highaddr,
+                              uint32_t *pflags, int elf_data_order,
+                              int elf_machine, int clear_lsb, int data_swab,
+                              AddressSpace *as, bool load_rom,
+                              symbol_fn_t sym_cb,
+                              segment_fn_t segment_fn, void *segment_opaque)
+{
+    const int host_data_order = HOST_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB;
+    int fd, must_swab;
+    ssize_t ret = ELF_LOAD_FAILED;
+    uint8_t e_ident[EI_NIDENT];
+
+    fd = memfd_create("qemu-elf-buf", MFD_CLOEXEC);
+    if (fd < 0) {
+        error_report("load_elf_ram_sym_buf: memfd_create: %s", strerror(errno));
+        return ELF_LOAD_FAILED;
+    }
+
+    if (write(fd, buf, buflen) != (ssize_t)buflen) {
+        error_report("load_elf_ram_sym_buf: write: %s", strerror(errno));
+        goto fail;
+    }
+
+    lseek(fd, 0, SEEK_SET);
+    if (read(fd, e_ident, sizeof(e_ident)) != sizeof(e_ident)) {
+        goto fail;
+    }
+    if (e_ident[0] != ELFMAG0 ||
+        e_ident[1] != ELFMAG1 ||
+        e_ident[2] != ELFMAG2 ||
+        e_ident[3] != ELFMAG3) {
+        ret = ELF_LOAD_NOT_ELF;
+        goto fail;
+    }
+
+    if (elf_data_order != ELFDATANONE && elf_data_order != e_ident[EI_DATA]) {
+        ret = ELF_LOAD_WRONG_ENDIAN;
+        goto fail;
+    }
+
+    must_swab = host_data_order != e_ident[EI_DATA];
+
+    lseek(fd, 0, SEEK_SET);
+    if (e_ident[EI_CLASS] == ELFCLASS64) {
+        ret = load_elf64("(buffer)", fd, elf_note_fn,
+                         translate_fn, translate_opaque, must_swab,
+                         pentry, lowaddr, highaddr, pflags, elf_machine,
+                         clear_lsb, data_swab, as, load_rom, sym_cb,
+                         segment_fn, segment_opaque);
+    } else {
+        ret = load_elf32("(buffer)", fd, elf_note_fn,
+                         translate_fn, translate_opaque, must_swab,
+                         pentry, lowaddr, highaddr, pflags, elf_machine,
+                         clear_lsb, data_swab, as, load_rom, sym_cb,
+                         segment_fn, segment_opaque);
+    }
+
+    if (ret > 0) {
+        debuginfo_report_elf("(buffer)", fd, 0);
+    }
+
+ fail:
+    close(fd);
+    return ret;
+}
+
 static void bswap_uboot_header(uboot_image_header_t *hdr)
 {
 #if !HOST_BIG_ENDIAN
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d..b67b2ca013 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -156,6 +156,36 @@ ssize_t load_elf_ram_sym(const char *filename,
                          int clear_lsb, int data_swab,
                          AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);
 
+/*
+ * segment_fn_t:
+ * Per-PT_LOAD segment callback for load_elf_ram_sym_buf().
+ */
+typedef bool (*segment_fn_t)(void *opaque,
+                             uint64_t paddr, uint64_t vaddr,
+                             uint64_t filesz, uint64_t memsz);
+
+/*
+ * load_elf_ram_sym_buf:
+ * @buf: pointer to an in-memory ELF image
+ * @buflen: size of @buf in bytes
+ * @segment_fn: optional per-PT_LOAD callback
+ * @segment_opaque: opaque data passed to @segment_fn
+ *
+ * Identical to load_elf_ram_sym() but loads from a caller-supplied
+ * memory buffer instead of a file.  All other parameters have the
+ * same meaning as load_elf_ram_sym().
+ */
+ssize_t load_elf_ram_sym_buf(const uint8_t *buf, size_t buflen,
+                             uint64_t (*elf_note_fn)(void *, void *, bool),
+                             uint64_t (*translate_fn)(void *, uint64_t),
+                             void *translate_opaque, uint64_t *pentry,
+                             uint64_t *lowaddr, uint64_t *highaddr,
+                             uint32_t *pflags, int elf_data_order,
+                             int elf_machine, int clear_lsb, int data_swab,
+                             AddressSpace *as, bool load_rom,
+                             symbol_fn_t sym_cb,
+                             segment_fn_t segment_fn, void *segment_opaque);
+
 /** load_elf_as:
  * Same as load_elf_ram_sym(), but always loads the elf as ROM
  */
diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 044e72de2a..a2c9b52bf9 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -321,7 +321,9 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
                                   uint32_t *pflags, int elf_machine,
                                   int clear_lsb, int data_swab,
                                   AddressSpace *as, bool load_rom,
-                                  symbol_fn_t sym_cb)
+                                  symbol_fn_t sym_cb,
+                                  segment_fn_t segment_fn,
+                                  void *segment_opaque)
 {
     struct elfhdr ehdr;
     struct elf_phdr *phdr = NULL, *ph;
@@ -504,6 +506,14 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
                 addr = ph->p_paddr;
             }
 
+            if (segment_fn) {
+                if (!segment_fn(segment_opaque, addr, ph->p_vaddr,
+                                file_size, mem_size)) {
+                    ret = ELF_LOAD_FAILED;
+                    goto fail;
+                }
+            }
+
             if (data_swab) {
                 elf_word j;
                 for (j = 0; j < file_size; j += (1 << data_swab)) {
-- 
2.54.0


