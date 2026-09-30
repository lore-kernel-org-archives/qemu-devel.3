Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF75CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAY-0008C4-Rh; Wed, 30 Sep 2026 11:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAX-00089r-9i; Wed, 30 Sep 2026 11:24:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAV-0001zN-Ez; Wed, 30 Sep 2026 11:24:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5RFj1932738; Wed, 30 Sep 2026 15:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RQEkSInkulSL3Zhq7
 AS2LV2oMRSPuSXJr0NYt5J6WP0=; b=Q0gYjikXMNVR4zRu+cUSIrvwlQFkAF3eV
 wxkxcESnf+DBQHlZuWRpqvBTlFt5GBCAspvCD/4LL+lokLTJFBzVxpfbxPf3/r/O
 N30OmXpylBlLG9TsVSU5Wf+Cg2SAnV/iMmibjHF96SqfHExrhL6XlT7jPKX+oyOa
 bJ0XipEIabluuW6M2ggYjV292u32S+KEsneXseZlS2+AlQtkaoXg1AhVEHVcFClr
 4GLTEhUR4++0rY8sdBaU6aV6Zrzr3xa1ySHco5hjkYN4OxXTfTB8PB3WtJZUxN3X
 t8CX5Ac8rb2f7bVIMWPKGwXgEwHJfUC8Re1/RBVgumgS+vo1NEwag==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fecyek-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE3BXE3577012; Wed, 30 Sep 2026 15:24:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23m9kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOOcS12976762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BB1E58051;
 Wed, 30 Sep 2026 15:24:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 158B358062;
 Wed, 30 Sep 2026 15:24:24 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:23 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 05/23] vfio/ccw: Clear error object pointer after non-fatal
 errors
Date: Wed, 30 Sep 2026 11:24:02 -0400
Message-ID: <20260930152420.1956230-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd29aa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eyrJr5MS_a8KrCayzkIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX0aoQNe9UMBad
 h0L3SDigLjYeAqbTlO6A6UO5P70DoWkF9dCLPqPrksZUs6oKneLTDvI/HFsLGoKULF+QQjZeESb
 Z1kLk5q/7JOy8ulE6in2yefjgtZeRtU=
X-Proofpoint-ORIG-GUID: xnE7RJk4My_E5L5eOZ48KZRrz8eD8iDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX2d+miWFjFj+t
 Aalpc7XeESbpHrax2oZS2jd6ggtcYMI/d0O6+GUmex2PIVOTIo9PE0wFgBU2R8Q4TXhFcdwiC6x
 sS/CxN2xbsJcEF2izMIMFDP7fohSnKSkEtKaX4UjCS8/gYh5s6hhn66KUsXMjQHqOt1SnBR/d+c
 2tnBo4tcnEPQDbgQvoHQwdPAwx5LNCJawfRH7qhr+qwgaJhhGySQuR7b0e43vYwdhrYyYVzLNZw
 O/Ln7tjiJxXG2qi4X7seHMsKyr81/xkJJJt7b6q4cCzjfpiQO8Ff0Gor8Em44nBjr895fwmfShn
 aJ6wUk2Nh28fIOYRDeGjaESEeM+Ar8+iei/xM5NdsQxRtBOZlVf54sLbD3ZkQqPhcI6ORh0ezDZ
 WsZPQ9z22VlrBEHmecRBngADyVhjqrqYP/Mx6RJWL627tLZNF6Yt7REZnqeBz1lppkU+3TVvr7Z
 IHIN5LPZMoMw7y+psmQ==
X-Proofpoint-GUID: xnE7RJk4My_E5L5eOZ48KZRrz8eD8iDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

Just like in vfio/ap, there is a non-fatal message that could be
generated, with a stale pointer in the error object variable.

Unlike vfio/ap, there is no secondary message that could attempt
to use it. Clear it in the same way, in case that ever changes.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-6-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/vfio/ccw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c3dc7c1962..8e29a3ae61 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -604,8 +604,10 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err = NULL;
     }
 
     return;
-- 
2.55.0


