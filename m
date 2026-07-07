Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADC0C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFPZ-0002Rb-E7; Tue, 07 Jul 2026 19:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFPX-0002Qv-A3; Tue, 07 Jul 2026 19:41:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFPV-0006Bi-Nk; Tue, 07 Jul 2026 19:41:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmJJa819750; Tue, 7 Jul 2026 23:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6NU9nRwJLbw41Axun
 ZLuBph5dLXa9xthdNR9pMjf3/c=; b=k8jZFNqAT7/GZWx6kBjKtGCgQcHDSs70F
 ni/8Y7b67AyyyWCUDwjffpDSUwpPl5c4BeDeAv+bisWk/Ps37khAZaWjvdbgEGlG
 M48Hs0jry5LOe8V4ow3QoqhvCl3icdmwAMxW+eRSoti3RBRxOUz59G4Aa6FdZ+Lg
 Nz6x1lO1/I9Wt9fzh4/yLvJkITMzU3EcU7hDZ996SmRm0KADcCuXcFZrjM03qdyO
 9BrIkM547k84awRizM4hxpEMuwQkC/xwy3NdpVuTQXfIUs7mNLqm5DtiYxe/GM0J
 2lYUW2arqGY+jD9xg1sjg7HbziKwdmFKPlwkyfJoL+6RXGQEdNrbg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4stcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:41:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667NYvgf001371;
 Tue, 7 Jul 2026 23:41:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw5a5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:41:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NexTM15467174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:40:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4071458068;
 Tue,  7 Jul 2026 23:40:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BFDC5805D;
 Tue,  7 Jul 2026 23:40:57 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:40:57 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v16 24/33] pc-bios/s390-ccw: Add signed component address
 overlap checks
Date: Tue,  7 Jul 2026 19:40:37 -0400
Message-ID: <20260707234047.2499921-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707234047.2499921-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707234047.2499921-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R8-0e8ffRQ5PA9E3I5ltNpNJgLhTXe6M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIyOSBTYWx0ZWRfX+MlptNIyPliP
 iGRmbfkQ/NYLAhNY0ZGLzE+Bwxpy0a2/GQ4mCpsMnWjwI0bchk7x+31Lii1r8dBUictf7wCYMaV
 xL+k/MmWOk/tInXot7qiUJGXUdTUMgR2biXwOA50AJv9FMfp4bHzVt+A5lbIieJHgBJVu18gGqi
 MAg1geCzmqy28bGWeX+USkIHXm5JSoe2S5eoyAUu76s+cQdVN9zKQBF10zXGAN0+4XXaznlWNkK
 EpzESp14qY4Kue9wDMEVwCxLVMllJDbJLhXK1tgXBZ5/t5feGZccsm21LbBW2TMVtWq75USFLfE
 aFv45wgnHFMYBB6L1zw2MjGe3bY1TnrHSY+OdBhz4/253eKCr0hMpWftejpknT7fu+U1Dm/yIEL
 2l3zM8mtc12DUvrUP6eY0NVBgDkDXI3UHv5Q7mpteqnkd98uAlLAR4aAadkWxe3Maj/jVTjrIyR
 U07xffIlkjEUf524Eog==
X-Proofpoint-ORIG-GUID: R8-0e8ffRQ5PA9E3I5ltNpNJgLhTXe6M
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4d8e8e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=G58Pgg4fZqxeurqYNSYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIyOSBTYWx0ZWRfX9EMQb1dLB4aL
 aBNHh0KZGaQxD6o5N2zK5tAhB3BztS6ObV//Llj/wDPqg6OGQZ/scZBdSmloIsFkokQJRPgFlba
 wFu87rB2d2V88gwduiTngJd5qeBrUS8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070229
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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


