Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D8C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTfr-0000Sh-08; Thu, 02 Jul 2026 22:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfo-0000Pw-Ki; Thu, 02 Jul 2026 22:30:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfm-0003eK-TW; Thu, 02 Jul 2026 22:30:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631Iwxf1202951; Fri, 3 Jul 2026 02:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gNSMRoHenwaVRrkVi
 Nw6SltkIz3xYFvi5J17N4ziV1A=; b=Ijj2e5lKsQtbctadLlue3a2GivCH5Gir2
 1tBavnYifBMvlT7VS7u4kAbAyxYC53rGa+5LLrNM36U6QI9iLH9D7WYtFCYMEHI9
 0NKDMfmTM+aVjehhm9Vds5AwHq21B9aJnLXU/nreV+fRzc8RGZlXr5mL8LbE/lTK
 CopDkGMIpUj38LyvHqhn5s6cDVJpAFXq+VGLNAsrN2N1mxO71/X5voKnT1vZmLVc
 uRm3Je2mybtR9W/unv+SoiVyM/fMg1CzmSGSV7U/xnjS1BsbYeAopZYN/oCj2NPY
 pZb1FwAQNVQWmdA1wW5spj+JLmQCiF3ReXqVMHmHulyNqHwXfNM+w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qacjuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632Jnwe026855;
 Fri, 3 Jul 2026 02:30:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7weuja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632UTdl30933730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:30:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A0E95805A;
 Fri,  3 Jul 2026 02:30:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 984FB58052;
 Fri,  3 Jul 2026 02:30:27 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:30:27 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 24/33] pc-bios/s390-ccw: Add signed component address
 overlap checks
Date: Thu,  2 Jul 2026 22:29:22 -0400
Message-ID: <20260703022933.1805010-25-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX6K+FWyYMkqGd
 dMmDF+L5f+7gf3zPTz/cTEij2aaYoaFqO8gRWM8x76EzQTqaP8iV9uihN8MDC2nyYtpq1bmh1Xd
 DTk9yJAvJyQjIdiyfv0rca9Vk8y0/7WFaJKwSxBoluwjYFQUYQoF8nQFRzFPh1fZk35DLN37OiU
 66KnmtvHRt0gzE9Apmpy/DSEx/Wsi9L2yaxFOZscgyRbCloZd9zXLLFdDCn5mJY84ah3c3+VzDu
 j70hwvDTjH+Ch4bka1Zo54QEGUUeFk3nfLWUSr20BJK5SSkZgaAbn2KZBFN0Oi8RCa0gD3HqKmO
 Ubr+zhRCjZfGW8XTDzPEQuHC9tqGbzqPfgkxR6YT32agLXm8M1r4JQ9Lm4u1dI8rnEyChM85oBB
 JyZDpl/mWxVVr5JJLa5AM0VRCL3nMvpoZP5I7idSuSeH8qcuFQkKhWEvFMu3Z/SHGFhqpNJmYY3
 5oUgMJLVKBNeXUM0cZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX3Dd9r16UGeTR
 unNC4yK8nUtpQ+xdu9FFrTlqlH4fRaYDwebebEIdRUobZ+JbebsULYF/TwURWOX4Ta0pfoaojVI
 ZStJQ+bKOQyroaQRfAy8qn1VctgvWsU=
X-Proofpoint-GUID: E2JbwFwlrZ9qXVyOFgXosilHa3YqbH1j
X-Proofpoint-ORIG-GUID: E2JbwFwlrZ9qXVyOFgXosilHa3YqbH1j
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a471ec7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=G58Pgg4fZqxeurqYNSYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030020
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
---
 pc-bios/s390-ccw/secure-ipl.c | 19 +++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 2cfa16fb68..e731926e4d 100644
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
@@ -288,6 +305,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
             comp_entry.addr = comp_addr;
             comp_entry.len = (uint64_t)comp_len;
 
+            check_comp_overlap(comp_list, comp_entry);
+
             /* no signature present (unsigned component) */
             if (!sig_entry.len) {
                 comp_list_add(comp_list, comp_entry);
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index d4a4553215..ae4bb8bc56 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -112,4 +112,10 @@ static inline bool verify_signature(IplDeviceComponentEntry comp_entry,
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


