Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17423C98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDf-00019M-FE; Wed, 23 Sep 2026 21:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDa-00017Q-EX
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDY-0007Mk-Uv
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNZOq6575604; Thu, 24 Sep 2026 01:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NyeWePykbWVIHHKi7
 Jsj23rbmZitj2HlmJnAJ95S3xQ=; b=pOd24ky1x33Rdg/ANi8mHVPWUZwQ7RkDa
 9P8tmWcRP9+WQxdPVK6bmgJil6/0O8ouILEvzDQNAVxCncBId6MVlmeD7wR4Eb+O
 Xi+vBXKH15r5WT1/HIcIWXT1rElSzR9Dhq+zrkXsGYDc2ROPs1eR7tvIk4We8Qq9
 byDfRAnYirV2FYk8nLKG8MiYMShlGGVYQ9sm5WKSPh77lKXXi/NteovthkLEytIb
 GmNa3q82MAN6m/T26023fFWQCMb+ou4wgIUmG2TrVatnd9bFY0vRIe9Emuv5ek27
 h42vKrlX+vITjCs8ZU8i7IGvWKSt1NfwmscNSo7V0vqGC0iSKxVVg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2pfj5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHeow1074669; Thu, 24 Sep 2026 01:25:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8uf2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1PfXT58196326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 400B658053;
 Thu, 24 Sep 2026 01:25:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B39395805F;
 Thu, 24 Sep 2026 01:25:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 08/10] hw/tpm: crb: Free ppi.buf in tpm_crb_unrealize
Date: Wed, 23 Sep 2026 21:25:25 -0400
Message-ID: <20260924012527.858527-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924012527.858527-1-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: yOQU6-PnXZWKqie4l2Bo9q9zoEW6bp2t
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab47c17 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HrTg4vUDa9T9seCBAk8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfXzRhadHpCWS1x
 vDG9PkrIOXY6Wc7Z0Se8H8VNDmmzT8EWoL4W0ZWJuMqiZ5wLfMQWsck8tiOAhNia6h5hX0S8UNy
 WwARhuKDFNPNIJcoOGA1RW9f1sAV/uCEdVcy7KttQ5wFIkRmrYXFbeVXIjUCQTWjCAB4tnC//rg
 YpSbDJnZ8S7bEv6fIkLNmD5zqYigE1TaTf1EHfPtoOazkT3E9n2M3gkZNkK4DXbbOr9OckmNRRa
 7WYRJ37tEcpwb87ZDxDAd/GZ8a5+vte+UJGT3E10qGjJKhnJYcBhban9r90OHTXHuhfXTMm70aa
 J09gO4AVz4MQlfpKqaGsyNkqoe+Tw/k4qnxaNFJNFWhyjXSzvjuOu81O4QN8MYA2wrdNZASRhxS
 1jI0alcDUifPNpFOISoZf4zmZF5lkZ+M/oh6v/nSqLXBhaJt4Yr5bN/D5HRNeSikS6JwOZIYV+c
 HeLd1nCVDZ4qkKn1+jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX8vCwp16yZI0r
 Xg0AU3U9xMyj/6ZxZTQe0/2uj3AcZf2AHvQw/osaWTl74aUNXSEnduH04Mo9Fx/TiD66dStKKMj
 TUTqZvfAXeBzBNev215KVPVYUP4OMrg=
X-Proofpoint-GUID: If1tnEkl7L9F-q0xphCRQpTlBzCGRFi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_08,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

Fix a memory leak by freeing ppi.buf in tpm_crb_unrealize.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 9a9677db6b..4bd1919952 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -16,6 +16,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qemu/memalign.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -529,6 +530,8 @@ static void tpm_crb_unrealize(DeviceState *dev)
     if (s->migration_blocker) {
         migrate_del_blocker(&s->migration_blocker);
     }
+
+    qemu_vfree(s->ppi.buf);
 }
 
 static void tpm_crb_class_init(ObjectClass *klass, const void *data)
-- 
2.55.0


