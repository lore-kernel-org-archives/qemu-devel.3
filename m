Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170ECCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wboxc-0000Df-K1; Mon, 22 Jun 2026 20:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxb-0000C9-I3; Mon, 22 Jun 2026 20:25:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxZ-0003aJ-3K; Mon, 22 Jun 2026 20:25:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJmGOS3990942; Tue, 23 Jun 2026 00:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xfgv5ZGMvcU9x2RFr
 +qrcJYF1DnVLW/79moXRLhEO7U=; b=NFgS0yUpC39fJ1dFB8iCsUghRZTECxjnd
 8Kg4jGx5FgOq8NR/w4a64Y9Be6u3zsR0txhqneh8pMNyROHpGJ5PSFgUICWF42MC
 esJzegSRvpluY8+hD9N4FtfSKB/kaf0bwsmQ2OkxjMMLQN+8hAEP2BqtjCJXu15D
 CZPuJdAfi70sBwwNO3ikgFK8MxuWPhCFkZL39tcJAWoSqzYNeYXbwzGq6jZLZgEB
 mWxxdcb3Cw3eUQc9/DIlZn/hTNfapeg3ZiuYO3NgJQX8omxVCpGAlHagbAQPPtoR
 xfKJKQh2h3zBL7/S2Uu3k2d0prPy2w5sYJG3//YxYDkaqydFHoEAw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3bxy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N0JfG3024620;
 Tue, 23 Jun 2026 00:25:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg0h4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N0PiN324511188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:25:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3EC358053;
 Tue, 23 Jun 2026 00:25:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA9DF5805D;
 Tue, 23 Jun 2026 00:25:43 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.116.241])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 00:25:43 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH 1/5] pc-bios/s390-ccw: Refactor byte swapping
Date: Mon, 22 Jun 2026 20:25:35 -0400
Message-ID: <20260623002539.126124-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260623002539.126124-1-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a39d28a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Mh-7s8SilpXd35hLZrsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX9owW/76WuTeL
 b56eJKvxqPs+t59QrjaaEmyywh/vxfN7daM/fB+lNUbqDFfuPuRWeMTxqCSaLA36fNMpKY1za5b
 ZfTlLacq1/1H9WqGH4tioFchKBzW89Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX0p86FkAen+GS
 ZogQ5Q5xpV9CgrasJuJhhhrmdeCeWds10oGNjpgDIFrklZvTikUuIlTuwhB6Te3JCfJ1a7nBgjm
 DuwcrNbOktq4dTmqEODO/yqJGTIp6SxDe2baJmoF7ChVV/tdZko0Rs6weE+dIiBlDyZM3eOkCVk
 WbV7iAxBRid6lcKlPntlTxtjvKOuKR3EnMN9JUrjGJuJTJpSvhsqMpxhdJMZNCuOhwlx1txjviF
 lOwSL642uarxU9L65f5SKHWWtUVdr9kqUOMgFayWXsS18ku28zlzu4UtB79BSFHV2GDLNdOgI1b
 zPuZobkRH5glYBXscyRTfwzGLSdfV8aVCOfH6HElzRMhBhzlHtWjcHXhg48kUFl0IDwqVfLtKAS
 tKufZNlN9X8YwCaFvDUeBe2dVdkW+cIKqa6DyhTyyiYJAMOjRjaxK3BQh40B15FRKyarxI3FFvd
 wRy4pISjTcQfdBj7flA==
X-Proofpoint-ORIG-GUID: 6pU86svbHrQdXtvsllFrw8CP6UjKifcT
X-Proofpoint-GUID: 6pU86svbHrQdXtvsllFrw8CP6UjKifcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230000
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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

Introduce local variables to cache the byte-swapped values eliminating
some redundant byte swap operations.  Additionally, do byte swap when
polling to avoid a special case where endianness is preserved.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 390b55c7b9..a448dc96e2 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -153,14 +153,14 @@ static void vr_bswap_descriptor(VRingDesc *desc)
 
 void vring_send_buf(VRing *vr, void *p, int len, int flags)
 {
-    if (!be_ipl()) {
-        vr->avail->idx = bswap16(vr->avail->idx);
-    }
+    uint16_t avail_idx;
+
+    avail_idx = be_ipl() ? vr->avail->idx : bswap16(vr->avail->idx);
 
     /* For follow-up chains we need to keep the first entry point */
     if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
-        vr->avail->ring[vr->avail->idx % vr->num] = be_ipl() ? vr->next_idx :
-                                                               bswap16(vr->next_idx);
+        vr->avail->ring[avail_idx % vr->num] = be_ipl() ? vr->next_idx :
+                                                          bswap16(vr->next_idx);
     }
 
     vr->desc[vr->next_idx].addr = (unsigned long)p;
@@ -177,23 +177,23 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
 
     /* Chains only have a single ID */
     if (!(flags & VRING_DESC_F_NEXT)) {
-        vr->avail->idx++;
-    }
-
-    if (!be_ipl()) {
-        vr->avail->idx = bswap16(vr->avail->idx);
+        avail_idx++;
+        vr->avail->idx = be_ipl() ? avail_idx : bswap16(avail_idx);
     }
 }
 
 int vr_poll(VRing *vr)
 {
-    if (vr->used->idx == vr->used_idx) {
+    uint16_t used_idx;
+
+    used_idx = be_ipl() ? vr->used->idx : bswap16(vr->used->idx);
+    if (used_idx == vr->used_idx) {
         vring_notify(vr);
         yield();
         return 0;
     }
 
-    vr->used_idx = vr->used->idx; /* Endianness is preserved */
+    vr->used_idx = used_idx;
     vr->next_idx = 0;
     vr->desc[0].len = 0;
     vr->desc[0].flags = 0;
-- 
2.54.0


