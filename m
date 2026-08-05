Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF185C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXZQ-00084v-FN; Wed, 05 Aug 2026 05:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wrXZO-00084A-CC; Wed, 05 Aug 2026 05:05:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wrXZM-0007u6-G3; Wed, 05 Aug 2026 05:05:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6758ldZb3387329; Wed, 5 Aug 2026 09:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=IHb83t0hiOgZvto0/2AyxyEB88ehl+IaMzPPojza3
 QM=; b=tjrqDK70dsZ5DYmYzbk9AqMR0rS9Xb/f9E1IHrzfcOLIyUumhIIH6kyq1
 FeqEpmuYoF6bqbn9s4M1KL690WHQinquEAxMOKA1x8oWFK0OWP1VKIN7j+FhGNH3
 4EqFKMNjfRy5wH9BbY2uAYmlwPvvt8+8CJwsT19vbLSNPpZIJTxTXyw3Uc42tNSv
 BUg8A1QeMqcG9kHKHuFFFEX4fCqmcogzOgvnQmH4w4NDszugdk9JrNes1Y3uai3F
 cfNjdvpAXTWjUG+jE1tKIyRW9s0D2DT5wauIIAmfxM5qo6PB9zqwsMpMNuIkL4TQ
 2eeYhlI9FTzRwr9g4H6KucGsVDI2w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h528e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 09:05:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758uIYF013100;
 Wed, 5 Aug 2026 09:05:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k5u0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 09:05:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67595cv349283364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 09:05:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E2662004B;
 Wed,  5 Aug 2026 09:05:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D388A20043;
 Wed,  5 Aug 2026 09:05:34 +0000 (GMT)
Received: from li-609d1fcc-36b3-11b2-a85c-cc82146838dd.bl1-in.ibm.com (unknown
 [9.123.10.251]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 09:05:34 +0000 (GMT)
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: qemu-stable@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH] hw/pci-host/pnv_phb4: fix guest-triggerable abort on 8-byte
 config access
Date: Wed,  5 Aug 2026 14:35:30 +0530
Message-ID: <20260805090530.1333997-1-nikhilks@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX537rSq9stxyI
 Ghf36l4A9wKxdRz9GIcD8+9TxWhsEb4Dgr5Khm9E+zPnI6SmZjJbxaE0QghesvLSzvH1NrNpl78
 GPNKwybZ4HrV1Wvv55ANmb9SVLaEKsg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX4B+jQiPHAlNw
 6/ohCCVxF6nSMVC/GoDtNSe//cuUOMacrfZIvzvkwTzIfaPKuUuWG1kSTIN0esSjLVYlKsn/XRd
 ftDsgM3rV/sMnlmwRuEtt15pQX8tnnS+l0iRaz/Zl3xtsIt5rfAANW3gLQ4jjI/tbzeqBCQ3PmV
 OKydcbSeLPQOXeAiJEke26Y/h7UOqgbBiBgeGirnog+euhclM95sxRM9jugNhWVFhbAsIxA3Nxd
 BSAtYjK+0VdFXWEgJ0kUlMlHv0noxpRLBhZdv6PfumLvdKD4xgxAAQBKk6rvpg97mqu22hUBCFJ
 PgUSpnEI7C1Sj37JRhAo7c+tbeNhWWHCfAOu6NV0JYGwoiXlfb/EhLf2UIiPBf0wXImCEHQBMIh
 Sm40qUZEozG9n/kyz5Th0fKro+rm/vaQEN+MLBJPidT5WJxKpkwHqTN5paQS04HGb90xpqjXh7e
 aQZSk3vVZrrNywe8RVw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a72fce7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=cZ2jSh9J2h8rrMqNVj0A:9
X-Proofpoint-ORIG-GUID: yq4mZ8KCXRgbi4nomDd92rs8L4n5BaXK
X-Proofpoint-GUID: R_YltPP5-irqzjUg65z_DdiKn3BNPBLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050069
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

A guest-triggerable assertion crash (DoS) exists in pnv_phb4_config_write()
and pnv_phb4_config_read(). When a guest performs an 8-byte access to
PHB_CONFIG_DATA (offset 0x130), QEMU aborts because the switch(size)
statement in the config accessors only handles 1, 2, and 4-byte accesses,
hitting g_assert_not_reached() in the default case.

Since guest input is untrusted, an invalid access size should not crash
the host. Fix this by adding a size > 4 guard in pnv_phb4_reg_write() and
pnv_phb4_reg_read() before the config accessor calls, and by replacing
the g_assert_not_reached() in pnv_phb4_config_write() and
pnv_phb4_config_read() with phb_error() to cover any other callers.
Invalid reads now return ~0ull, maintaining PCI conventions.

Fixes: 4f9924c4d4cf ("ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3591
Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 705a5bcf07..02ca2f978c 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -84,7 +84,9 @@ static void pnv_phb4_config_write(PnvPHB4 *phb, unsigned off,
         val = bswap32(val);
         break;
     default:
-        g_assert_not_reached();
+        phb_error(phb, "invalid config write size %u at offset 0x%x\n",
+                  size, off);
+        return;
     }
     pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
 }
@@ -119,7 +121,9 @@ static uint64_t pnv_phb4_config_read(PnvPHB4 *phb, unsigned off,
     case 4:
         return bswap32(val);
     default:
-        g_assert_not_reached();
+        phb_error(phb, "invalid config read size %u at offset 0x%x\n",
+                  size, off);
+        return ~0ull;
     }
 }
 
@@ -507,6 +511,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
 
     /* Special case outbound configuration data */
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb_error(phb, "invalid config write size %u at 0x%"PRIx64"\n",
+                      size, off);
+            return;
+        }
         pnv_phb4_config_write(phb, off & 0x3, size, val);
         return;
     }
@@ -644,6 +653,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb_error(phb, "invalid config read size %u at 0x%"PRIx64"\n",
+                      size, off);
+            return ~0ull;
+        }
         return pnv_phb4_config_read(phb, off & 0x3, size);
     }
 
-- 
2.54.0


