Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9F8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHW1-0007mY-13; Fri, 24 Oct 2025 09:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHVz-0007hB-1C; Fri, 24 Oct 2025 09:07:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHVv-0002y7-Up; Fri, 24 Oct 2025 09:07:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O630eI002474;
 Fri, 24 Oct 2025 13:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yuKGlP
 t/QGpIxBQ01VSVo+CDBgyAQ4fkTyIKa9zzdqs=; b=ZP5fexnQ3GSxYqozdD+Wvq
 o2WajP05Gj2K/6VckjdNhein30+fEc6cn50E0iJNU16+g/OlkgSJs5InaleKI1a2
 Fvto52SjoZIihSqrin4HaNoNUhZCthtg/NxkthZSlE50pqTGtH+/gwsI3vY9qDBG
 7gG6nF6tRAzJB28y4BfDGqwElHwaXfh84vjuqsREd/5s/3abp7xSOzXcPtPjsLbI
 eixo8GeRPvV86inscX3iZB/6TD17f8WUziBkHJW6iiKnenMoCVxR39cERkBn/KlR
 8sJHsFqTKsOzdewc2HJv2jZMgU/DfDK9iQlB7KrmINJo2I5H3lpfb/NNZsYyG5Nw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3277dpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:07:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OD2lrb013577;
 Fri, 24 Oct 2025 13:07:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3277dp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:07:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OA9kP3024940;
 Fri, 24 Oct 2025 13:07:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqkb3p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:07:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OD7HCC56230236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 13:07:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D94820043;
 Fri, 24 Oct 2025 13:07:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A55BA20040;
 Fri, 24 Oct 2025 13:07:14 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 13:07:14 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [Patch v10 5/6] core: Pass errp to load_image_targphys_as()
Date: Fri, 24 Oct 2025 18:36:01 +0530
Message-ID: <20251024130556.1942835-12-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024130556.1942835-2-vishalc@linux.ibm.com>
References: <20251024130556.1942835-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fb7a0b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=5QmAwwa3-A6azPfluFIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7dBOzbg2fLgj
 LoLX+AsyflbvBDN32s4B+r+CcnqzlvUX0q4B1Q/SqaeTNodUy9TulrDQHruWBjK/+QSXjSHQxia
 ppRhAW71LgILR57F0x7htxwjB2+4UgopOYciQOWGMvK+eeKWTZYgs8uc2KF+jUVGRikJbak/ooJ
 dYFYnysNbWnHjtWCES5Eqo9k3OwNfapOBLVn17wYkpmxXYNVphBpYDZdV/Udt8S9VYyfz9GEQxq
 1ZVAbRHJYa6AtsypRGntC+cmatuUXkR5RihL5uE75q1bapifhXZDPbhCQp6xBV6RHwPrAm7P6Xp
 IFaAzmLnGIbbiOjIaOI7wrLflQmElCh0v65dEgg7CWOeiVtxDJXicg750IbZrCdaN7HELgYH1eN
 PiSeaDbI4wMFEBV73Mh/HOx3kZL4YA==
X-Proofpoint-GUID: MGyWxHI9tz3Osi3zq2Epud869Fdru40l
X-Proofpoint-ORIG-GUID: iNnQE7SxJEOrNAZx3F2MNRJaDvIeFkU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Pass errp to load_image_targphys_as() in generic-loader and
guest-loader to capture detailed error information from the
loader functions.

Use error_prepend() instead of error_setg() to preserve the
underlying error details while adding context about which image
failed to load.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/generic-loader.c | 4 ++--
 hw/core/guest-loader.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 6689847c33..433efb7387 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -149,13 +149,13 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         if (size < 0 || s->force_raw) {
             /* Default to the maximum size being the machine's ram size */
             size = load_image_targphys_as(s->file, s->addr,
-                    current_machine->ram_size, as, NULL);
+                    current_machine->ram_size, as, errp);
         } else {
             s->addr = entry;
         }
 
         if (size < 0) {
-            error_setg(errp, "Cannot load specified image %s", s->file);
+            error_prepend(errp, "Cannot load specified image %s: ", s->file);
             return;
         }
     }
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 59f325ad9c..618455e556 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -101,9 +101,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
 
     /* Default to the maximum size being the machine's ram size */
     size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
-                                  NULL, NULL);
+                                  NULL, errp);
     if (size < 0) {
-        error_setg(errp, "Cannot load specified image %s", file);
+        error_prepend(errp, "Cannot load specified image %s: ", file);
         return;
     }
 
-- 
2.51.0


