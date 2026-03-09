Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67836EA852F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzOba-0006Iq-3E; Sun, 08 Mar 2026 20:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObY-0006Hz-PL; Sun, 08 Mar 2026 20:36:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObX-0001e4-AW; Sun, 08 Mar 2026 20:36:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628MpRP11545664; Mon, 9 Mar 2026 00:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hT+WaPK/l/KVraVn/
 hFNJ7cPBQ52onrJsY+ruj1S6IA=; b=NTSXksgE58aLd4abfj/3nnDNupXuxgatM
 I2nwDArSbPmD+8s1+kKs4QKFzSbB2nCvniRVKZ4Nt+hP5u+4lEH+h7SrwEcAyVvS
 JWQoNAhk28+5FSSS1UZUv0U0E+SilzgmFJ4M6OIORnIgpXR9aDdyJG8cz8QlOaB8
 TKURr2NGza/7cBpxWiVHAp6ZOg+e7SCcRm+Iivn4yacrMLBBm5EnBWnz9GMTxcrW
 xPAB+YVEF8+jZJaa4ErlEHYkaYQ1wBcUcAh8Pf/W3cBdHe3bpI7exJn6oT3+IFXC
 wwjCU9E0o8uvLao1eRNUTN26tfTC9tFLDSOQFx9k3hSyXTXwZXXFg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw4ker-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628LjP3f015638;
 Mon, 9 Mar 2026 00:36:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybn2yuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290aAnt32637522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF61358056;
 Mon,  9 Mar 2026 00:36:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A059258050;
 Mon,  9 Mar 2026 00:36:09 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:09 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 03/15] pc-bios/s390-ccw: Always reset virtio device on
 failed boot attempt
Date: Sun,  8 Mar 2026 20:35:49 -0400
Message-ID: <20260309003601.242634-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfX5mQPBjW2W3dM
 VSSHWp5BUd8E7UuL1bBneZxM0pkHVJhTSCVlI84GYGeuuE3dWxRvxyrLkqYY0ADM4NhFOk/CokW
 rioFpfPE6th19yqEw4zY5Qg+ucO4lZOat4mvIk9co87vP01T3h9GgtR/3bRyz+u+bZBNsjKdVvD
 3jnt0uRKGxoi95Wnd2tbX5zxGsGHb8054eMR1xgsCA4RzwFbkdwGqPiO/TZVnj7IHCQum3ZLTwd
 flp/11aWcnbDc0wPairt1DWvdJOvZ5lkTycaQctrUTJ3xiIW3SY9sEBlpXO8M/UTPdmk8TzNPVu
 P/kuLs0L8u7gcxFncm4uk02q0Gq5FIcVV/r5Ml4+LFVfLyd/ozBhIntZPLUuYfT10leqqDK0fCB
 MZIkJbIk4xsIiKy9REdrPDQFYMYX5+u+XK9UOW6/lSxHzMGp/PPWITZfZ+aQALrw3tiqu96vusi
 vLD0epUcvlYCND5IYDA==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69ae15fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=YW-40rnn-hUE6FG0_2oA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 4V1tYfZqINr0Z6dicb4LLhGgkf2a1c9T
X-Proofpoint-ORIG-GUID: 4V1tYfZqINr0Z6dicb4LLhGgkf2a1c9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

The virtio spec necessitates that live virtqueues must not be altered.  Reset
the failed device so that the queues are not live before we attempt to boot any
fallback devices.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 76bf743900..8e2c99bee1 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -277,7 +277,8 @@ static void ipl_boot_device(void)
         break;
     case CU_TYPE_VIRTIO:
         if (virtio_setup() == 0) {
-            zipl_load();
+            zipl_load(); /* only return on error */
+            virtio_reset(virtio_get_device());
         }
         break;
     default:
-- 
2.52.0


