Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E44CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 18:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9p0U-0004R2-Jv; Fri, 17 Oct 2025 14:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9p0N-0004FR-QZ; Fri, 17 Oct 2025 14:16:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9p0E-0007Mk-R8; Fri, 17 Oct 2025 14:16:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HARLkL001980;
 Fri, 17 Oct 2025 18:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wICqCNOYkl/SO0Iud
 QTMSf41t6cz8HYOHXuy0A6JdNg=; b=NQ3ekffTNTapIQ58BPO4Kpe8hnS0rHylF
 hmsWmESOWk3jH3P213kiGctCNK6tsFY37M4jZVoHdw3NiifF+WAnQF1iMjnSSroH
 Sswp0Gmf1/tyi6r4bwYqaWE+swD7GK5IUTdmOyK38+bFyrgqil1UvfEqt5kHJIas
 l/SCzKbtbfwPher3ARpqIeUyGlozgSZ0n4CqtbSuCD3s71a+myYy9/1e7PlzsBSp
 cy/HrxK5WBBAjofxkc6Ou9XTIYVnKbRNx4mfRj/4+wDzwypJOT9HccwCi4BtDCRN
 hMYzXqAHRVFk6NfDv7ON3o49r9E2eHPAFmNIDBSbBiuUncFq3OszQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8fbdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:16:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HI5rPd024302;
 Fri, 17 Oct 2025 18:16:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8fbdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:16:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HFdlvH016745;
 Fri, 17 Oct 2025 18:16:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32keqw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:16:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HIGO5x48824582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 18:16:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BDF820040;
 Fri, 17 Oct 2025 18:16:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB86F20043;
 Fri, 17 Oct 2025 18:16:21 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.22.45])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 18:16:21 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v4 4/5] hw/ppc/spapr: Rename resize_hpt_err to errp
Date: Fri, 17 Oct 2025 23:42:52 +0530
Message-ID: <20251017181250.1421446-9-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017181250.1421446-2-vishalc@linux.ibm.com>
References: <20251017181250.1421446-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wh5ygjvHOa9cPeC-0R0AeWvm2mOnER1i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX1FsQowAglX+N
 gUU7YTLrM23HXnPpRhvKU1/gtJj20aUXnDXdR20m8+XpPEL+Fr3Mh65Xy0DsYjz5IcBsHvNSu7f
 9vzCnyxdLS73xxkXePtb51zlolG1DvELLd5lqNGtWYbWLMBudhJbuYqYewj733NddeS9gn+A/uL
 lOqcOMyvyMBa7nyXFa6HWK7Aw1TlywlTJ/kL2ICZRDAUwyrsk+w5NAXJdRjKMlf3bbDXzLjypwA
 PIF2P60YnqPInZeNHUobGrI/U9hNQvEI+Ejiqmh5m6KWvd2hYTQ9Y3nkOT5pvDUGmBD7v+8TPhk
 pbACTs+o62PRr7l05wBl/l6XqM9d/DQijeZ971zckMqNYvobdiX3u6v48K/KLJU0N470maiXLRR
 Skv2lJsFu4QS56E7lCAXI+DfaMJROg==
X-Proofpoint-GUID: 6p9gv3uMYWi2y9yfxgRr_cDhNv9m8Q5t
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f287fd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=YPwFAxgEYmRXNWQnHQUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Rename resize_hpt_err to standard errp naming convention.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/ppc/spapr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d69117d3b4..e51540a5ad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2817,7 +2817,7 @@ static void spapr_machine_init(MachineState *machine)
     int i;
     MemoryRegion *sysmem = get_system_memory();
     long load_limit, fw_size;
-    Error *resize_hpt_err = NULL;
+    Error *errp = NULL;
     NICInfo *nd;
 
     if (!filename) {
@@ -2845,7 +2845,7 @@ static void spapr_machine_init(MachineState *machine)
     /* Determine capabilities to run with */
     spapr_caps_init(spapr);
 
-    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
+    kvmppc_check_papr_resize_hpt(&errp);
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DEFAULT) {
         /*
          * If the user explicitly requested a mode we should either
@@ -2853,10 +2853,10 @@ static void spapr_machine_init(MachineState *machine)
          * it's not set explicitly, we reset our mode to something
          * that works
          */
-        if (resize_hpt_err) {
+        if (errp) {
             spapr->resize_hpt = SPAPR_RESIZE_HPT_DISABLED;
-            error_free(resize_hpt_err);
-            resize_hpt_err = NULL;
+            error_free(errp);
+            errp = NULL;
         } else {
             spapr->resize_hpt = smc->resize_hpt_default;
         }
@@ -2864,14 +2864,14 @@ static void spapr_machine_init(MachineState *machine)
 
     assert(spapr->resize_hpt != SPAPR_RESIZE_HPT_DEFAULT);
 
-    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && resize_hpt_err) {
+    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && errp) {
         /*
          * User requested HPT resize, but this host can't supply it.  Bail out
          */
-        error_report_err(resize_hpt_err);
+        error_report_err(errp);
         exit(1);
     }
-    error_free(resize_hpt_err);
+    error_free(errp);
 
     spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
 
-- 
2.51.0


