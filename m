Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1BEC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD8K-0000HG-Hk; Wed, 26 Aug 2026 08:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD88-0008SX-Ge; Wed, 26 Aug 2026 08:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7x-0002nO-EJ; Wed, 26 Aug 2026 08:53:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCVx162127759; Wed, 26 Aug 2026 12:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TCzoDCBigZnHnzhP7
 O0NeyYg9pf+U7Zxai9zdUPXYgk=; b=Dkmtf3Qn9PaoC4tSUPAGXViX9zn2GBMMW
 Bpq88xoLvytSBCVcqbq3fCnBPhV64T24N7PDaoMqHV6auZVy6om8es7PM7T57xfY
 3fI6dQQ5g2gPeGgg+tfYuFZcmprzaMHp1dCt5dOHN/m98xEk726SoHJUoTB6fTup
 8DjYI5zJErz3mfpLTDqFQago5TEYCWYFCO6lVB1ECEL6uVbmK316SsM5+M+6LIJv
 0ArTFTCr9fukMmEmTMike9+XCdnpA+rOQ/MtFGB5P0zKEQsWACiuUwsPJe0eQzs3
 1J6EF2KmrN8+OvdiSadkV2MdpwH9L94ZqqT2wsWvjioKse2mcs+fQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqxma0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfLbF003033;
 Wed, 26 Aug 2026 12:52:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qa5nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqmwc65732900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B54125805B;
 Wed, 26 Aug 2026 12:52:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9D2B58059;
 Wed, 26 Aug 2026 12:52:47 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:47 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 26/37] pc-bios/s390-ccw: Add signed component address overlap
 checks
Date: Wed, 26 Aug 2026 08:52:01 -0400
Message-ID: <20260826125213.1901252-27-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MmMOKVJSQxFBGTU1LXjfIDUMSCA3c2w_
X-Proofpoint-ORIG-GUID: MmMOKVJSQxFBGTU1LXjfIDUMSCA3c2w_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXzT2iODYsxRZ2
 z//zrB0BRGsqUwfNwOp2IvCG+axSSDT3PzK7wDPNB1wlD38c0lNyy4Gfsvd7oIv27yrdUdctpuE
 5aRn9T32iXwwMPZQin96IugyMnS6tn9EU1OsikbhmDDk6HZE2GPCQ1xVErspPFWJbr0J7IjMuB8
 VRFDzx8FXWRLDfRPHXfriotrDcdbA5aVv7vvVPqrMRP1Xyp0m+3Vu15EPZmn1/EQpPkx7MewBXw
 j8tksYX3iwGrvkFhZTZvZZj4Pn4BitUU00Xy6UhaVFuw+Du0EWynY7dL8b9bd/RSxjL3wqrQQ8W
 Eb1UGfoJ7R7f0/lhNpwC7xwdpgm5yO0pld53xS2DtW2VUlq/e6OVq82aQ2uGQz7aamuYe3z8W0D
 Ta6bA4RmoF4t3T9YRlxK1vFPuucRShBsgBJJ7P17VNY+ZcHANDP6q6wHARWIAzgIOriHcMT5wgX
 aPnvL1CR4buoN/dQmBQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8ee1a2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NXXwFC7yLcffaugpo9UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX58eolyh/9btE
 Xvd3/UHjLasG+JH4V7QETU2L1PmUn44rGsrdoWhze2ggTK4gkXGv+cTeVlPcEkLL/XjyYVcMBkm
 vdfSKCmKPMw8JU5q3QIYzf1dwPIej5s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Add address range tracking and overlap checks to ensure that no
component overlaps with a signed component during secure IPL.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-25-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 pc-bios/s390-ccw/secure-ipl.c | 19 +++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index a03105cf5a..fd3455cf67 100644
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
@@ -294,6 +311,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, const uint8_t *tmp_sec,
             comp_entry.addr = comp_addr;
             comp_entry.len = (uint64_t)comp_len;
 
+            check_comp_overlap(comp_list, comp_entry);
+
             /* no signature present (unsigned component) */
             if (!sig_entry.len) {
                 comp_list_add(comp_list, comp_entry);
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index b5a871a799..d495dd5d04 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -116,4 +116,14 @@ static inline bool verify_signature(IplDeviceComponentEntry comp_entry,
     return false;
 }
 
+static inline bool intersects(uint64_t addr0, uint64_t size0,
+                              uint64_t addr1, uint64_t size1)
+{
+    if (addr1 > addr0) {
+        return addr1 - addr0 < size0;
+    }
+
+    return addr0 - addr1 < size1;
+}
+
 #endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */
-- 
2.55.0


