Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5C4C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFel-0001u8-HG; Tue, 07 Jul 2026 19:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFed-0001pm-Dg; Tue, 07 Jul 2026 19:56:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFeZ-0002k8-2h; Tue, 07 Jul 2026 19:56:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MohS1167985; Tue, 7 Jul 2026 23:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6NU9nRwJLbw41Axun
 ZLuBph5dLXa9xthdNR9pMjf3/c=; b=M9OEdEV2N/IqtFkaG7ipv7Fq7dpGevfg/
 VtcVEg3+3mwQJW5JzNFNU6qOwHBDHSVoZkLgKshDxBDqsH8whYsvIL7epvl/idLc
 LQ2rbZsjY19qHK43RhJ/UiuqEYwMaa5Xp3Ewt5TAr1e77B0GHh5DLL9bamyvbD+v
 jhYEfVebULJXXMhml9ILhJW/miVtmb/cyckMdzcpPLZTnwvP6/6vbKlMdE3Y6FJe
 F+l80csmsnSbEpW+tpMH4u1MiQFq7RZm+yt7M+M35DcSiCbE0VoT7Szx+O65TZDz
 7PcvwxtVL9K9qhwRvxnEYy0Lhcql3f2ZCxrJBSH/r/lBGsLE/n+SA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stst80n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667Nnb7w002501;
 Tue, 7 Jul 2026 23:56:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y4u57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NuIHJ3277582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:56:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4087358052;
 Tue,  7 Jul 2026 23:56:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DADE658056;
 Tue,  7 Jul 2026 23:56:17 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:56:17 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v16 24/33] pc-bios/s390-ccw: Add signed component address
 overlap checks
Date: Tue,  7 Jul 2026 19:55:58 -0400
Message-ID: <20260707235615.2513487-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xCeyTcsgfuhiq8IwaLUfrZQddLXBOpw8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX10J8bi13xA8B
 2bNuNQsdDVh9Yk8WaZFnffQ4Y7i055dSx8sKMYM1fKx50d7PwhoVpNsI03OsoO89i9APhKwcCrf
 Jb+lwZxnYHLi5lep6So+GMx50qx6aF0=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4d9224 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=G58Pgg4fZqxeurqYNSYA:9
X-Proofpoint-GUID: xCeyTcsgfuhiq8IwaLUfrZQddLXBOpw8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX+zih/2zJjn7Z
 rVwnztVdhsny3RIDnslg/6/vuSAekhqerIVT78osyn+pnG6Kq2n2cXhmQKVxpopseXazehhRbw0
 BBJS0Z5MOSNcdbTPGvLplCdkAxdBi9W4s2NHY9WQbHNW/fcnb6QnKUvlaxJFXQhKLmB+i65oVPu
 dAyVsdbhhqovIxSm4Rj2KFS0r3r/io13XIzkJd7s2NF84jgaleAHqWsi6/ojcfKkUI3TO3Qngx0
 qOiQJEusnjmUoZojX02eNbFBtSjvjuf557yO0scnMDR0z8npFK0E3YfcA0clHiBPDDTDghUBNQr
 jy9qo0P7N49aYkQLDUhhRIrLm5KAnp44Y3Gul93ngYXZlzc8UvuR9WEExCgfeZfyzDjsO79OPXQ
 Ehn+SgDN7Aw+LBSZw+mTO6fU5fxYlPyojkV5ic4EYP0ZKIlKk39tCbdXEuY6OhPj92L8xvMszJt
 JgFpy/bGVSqr1dXXRkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070233
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
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 pc-bios/s390-ccw/secure-ipl.c | 19 +++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 1ab41e5543..cd2d18bfa0 100644
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
@@ -288,6 +305,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, const uint8_t *tmp_sec,
             comp_entry.addr = comp_addr;
             comp_entry.len = (uint64_t)comp_len;
 
+            check_comp_overlap(comp_list, comp_entry);
+
             /* no signature present (unsigned component) */
             if (!sig_entry.len) {
                 comp_list_add(comp_list, comp_entry);
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index e192f8b61d..f014ae4b1a 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -112,4 +112,14 @@ static inline bool verify_signature(IplDeviceComponentEntry comp_entry,
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
2.54.0


