Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEE9C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1tn-0005Rb-1Y; Wed, 01 Jul 2026 16:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tT-0004ie-RU; Wed, 01 Jul 2026 16:50:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tQ-0004R4-RE; Wed, 01 Jul 2026 16:50:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GmfKx1339697; Wed, 1 Jul 2026 20:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=E4b5bfHOQyFhTmYYt
 ysCz81a9z7yS3ZdV6/IvgNVOmA=; b=qxQIKqU6IKXQ2ljtKQXy9gMrvyxLHaf0V
 QdYQS/bVT332frLhmRkb6YH8cial3HuSvXAOTD2WBe46KcWQmslPnTFakrLbKuXQ
 Ft+75R0B1AwuFBP2anb9jPzDJJhQkWR3mDrjnfPnI0vPe26iAX2NCmwU+0OuRLsP
 P78YpgNBX5cXP2/tsLkiEWcZEGV6KdMKza9HjuSndyR4nzjX0VEH8yY03pRRt4TI
 V/O4DMF9gk+c0pyTn1grKrMOJbl+1N6s8I2Hfp09j9+iQD1Qlw2gegfhFeuy6suP
 QijXpCdvFWtoLBJqHT8Ax68UyfaPECUuHvTQHyOaUCs1/TR/b4z1Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa69yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661Knbjv001596;
 Wed, 1 Jul 2026 20:50:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w9611-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661KodOs17957518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:50:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3285258060;
 Wed,  1 Jul 2026 20:50:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D7695803F;
 Wed,  1 Jul 2026 20:50:36 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:50:36 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 24/35] pc-bios/s390-ccw: Add signed component address
 overlap checks
Date: Wed,  1 Jul 2026 16:49:10 -0400
Message-ID: <20260701204922.1320349-25-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX322mlSKm7lwq
 ooUCUxV1z8Xm/5TVNl0q8yfd7XJygwrV8yNuPrspR8a6NDxuys7ipsxVdIWkRXJUrFPXD3EiLJo
 Ud9WxsTghZ6+Pe5blabyrvFWZbjgzphCVwgsPf1DO1VPCKgQA+OVQeD3AVKRw6TBBDYtMZxqsbh
 NZjpwq50QKe8uADUNWYc01N5bgeeImUcMt0M0IobnfVIo+K2ORmod0fzt4o/S+gixY/YSc7t5if
 1e+q2mJkg5ob+znMXwMNOA+jjho+ORmKvTH8lK3s0iB765uXG1CCeyVvCMujX2pxj81GVXotv0A
 lXYoZ+I3An6LIV5p52U3eOvu8VYYgv/xhHjtoxUslQgqNup69hHRf6q7mtRqrxCJrmFa/A/D82L
 OVCqXxavbXal3fUJ1f/Bw8FhtTRm1YceVATJyzhlCFzN4OWKd12pKjf3xpz/CK3G28HbxvTNhDn
 LTcu31qL4AxL4F1f0jQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfXyU7wRlNmADot
 FCHmBGhfuRIiQIql3DjM4TLaT+pK9ZvtF3uslwZKTt5D6bv0HUxKSZmx2M6OnnH9v+kQAsIZKlC
 CXedtdON0Lh9y1wdXlTZbgjkEo8lwiw=
X-Proofpoint-GUID: Skm8YSYOAMnHbvDj36wpObo25jMvkUsq
X-Proofpoint-ORIG-GUID: Skm8YSYOAMnHbvDj36wpObo25jMvkUsq
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a457da1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=G58Pgg4fZqxeurqYNSYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add address range tracking and overlap checks to ensure that no
component overlaps with a signed component during secure IPL.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/secure-ipl.c | 19 +++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 2d9a4cbc02..af98881aa5 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -193,6 +193,23 @@ static void init_lists(IplDeviceComponentList *comp_list,
     cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
 }
 
+static void check_comp_overlap(IplDeviceComponentList *comp_list,
+                               IplDeviceComponentEntry comp_entry)
+{
+    IplDeviceComponentEntry *comp;
+
+    /*
+     * Check component's address range does not overlap with any
+     * signed component's address range.
+     */
+    for_each_rb_entry(comp, comp_list) {
+        if (comp->flags & S390_IPL_DEV_COMP_FLAG_SC &&
+            intersects(comp->addr, comp->len, comp_entry.addr, comp_entry.len)) {
+            zipl_secure_error("Component addresses overlap");
+        }
+    }
+}
+
 static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
 {
     if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
@@ -287,6 +304,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
             comp_entry.addr = comp_addr;
             comp_entry.len = (uint64_t)comp_len;
 
+            check_comp_overlap(comp_list, comp_entry);
+
             /* no signature present (unsigned component) */
             if (!sig_entry.len) {
                 comp_list_add(comp_list, comp_entry);
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index d5d6d6f7ac..1b1287858b 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -113,4 +113,10 @@ static inline bool verify_signature(IplDeviceComponentEntry comp_entry,
     return false;
 }
 
+static inline bool intersects(uint64_t addr0, uint64_t size0,
+                              uint64_t addr1, uint64_t size1)
+{
+    return addr0 + size0 > addr1 && addr1 + size1 > addr0;
+}
+
 #endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */
-- 
2.54.0


