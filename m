Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378F0C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVlx-0002DW-L2; Fri, 03 Jul 2026 00:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlp-0002Ax-S8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlY-00038T-Uy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631IYFF1258027
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Jze7uN
 1t8Q87hZgvj9n28xJcK3D8NSVqzbbbjPXeCnY=; b=h9/5B2kY0WwqhphkBjJnFa
 MFwXNlJ2HbdM/J/j31G1Ysr7mKdRX7j/h+7vSlhBpmrgaXJ1ZfXrvIHgeu+UPQMU
 qG9N+ww0njGwUZJ+dRVVHc2sTsRa7bzbCuvyFdwwHpe2Ib37Orl/RH4EcQN0H6qy
 uIOcT+ptskpXucdJbbPYPf5bOVmcJ+0lONAZrMvrkaAnafNrsc04I5gBlAAUatf6
 9102Af0v5c72W1iv0LGbhpQTjSi7b6vjB2K+3s8V+wooXt+D6QkbkXY2lOA8x30O
 nQI8vi+N6whUKbSuEjr9T0XAbS1FX6f9GngOMdjnBbWXj+VtKOgYxTZ6gD4xCGpQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n65deb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6634YgVN003765
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wf960-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6634iMar51904942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2B8120043;
 Fri,  3 Jul 2026 04:44:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3920D20040;
 Fri,  3 Jul 2026 04:44:21 +0000 (GMT)
Received: from Mac-11.lan (unknown [9.39.22.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 04:44:20 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth@posteo.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/7] docs/system/ppc/pseries: Update the link to the SLOF
 repository
Date: Fri,  3 Jul 2026 10:14:00 +0530
Message-ID: <20260703044402.79723-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260703044402.79723-1-harshpb@linux.ibm.com>
References: <20260703044402.79723-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX54ErectVdZQ+
 KdNVF0jilbN63WFu/iS6MwU4ZqRbXzrlFm2wjholWfHyeuzGiyluEFzABpnL/pRG+NejgbnFL/4
 zfKpA0IVL36Q8B+vm5cs8/E2qGpJE92Rlc4eS9P50/6PWM7NFMaL0d2fUCViTmPYI+BVgns0ue9
 JoHJXDJ3sjZll6YSBvWga6I3QLfBXK0rpLUnQ03Nf6b1dAe4uCd8ZlxDgatrT+40m4yMp9+8MKp
 6+lEMW0QLi0ecKfQ/DQ/FHZ0P3HoM9HuhV2ixyJOPYFGvRuH/U6GNfm7pz75/XQ1P6qLD2cDdwx
 1zQbYXEcMATMkiVupP7HW5QKkD8YIm6RleWVvpovj2RZNEfP65kcuZcjunEk8r4KHjIImt6X99u
 56s6NegWRXYdnZow7Nortk6MWDPmHj+MgXJ3foHwxU/zGozYfMR9fcJcUnWOGbqJzzLCqFtvtC8
 YwqQQZCETqNE1YKFxjw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a473e2a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=bgKrIEmzAAAA:8 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=o83nqyVRAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Gu1-tfeXWjnmNH9sa4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Ifulqbl_J-1aL42CD9IR:22
X-Proofpoint-ORIG-GUID: uViHL47gEUnMQ7kDb3LrTHmp0GLRBUsN
X-Proofpoint-GUID: uViHL47gEUnMQ7kDb3LrTHmp0GLRBUsN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX6Ou/xJFVK8DN
 6MbfzfpM/RUjOVrFwoswKmbclIdKwKiRKDNAEGhMaAX+HlInO9K6Nttq6mkphZeCHb6v+N/Z1it
 lS4LvGtNqiFP+92iVEpINcxfDsHaO1w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030037
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Thomas Huth <th.huth@posteo.eu>

SLOF has been moved to gitlab.com already a while ago. We updated
the link in pc-bios/README in commit 7f98b4f25ed9 ("pseries: Update
SLOF firmware image"), but forgot to update it in the manual, too.

Signed-off-by: Thomas Huth <th.huth@posteo.eu>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260702074842.4806-1-th.huth@posteo.eu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 docs/system/ppc/pseries.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index bbc51aa7fc..107091a37f 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -43,7 +43,7 @@ Firmware
 
 The pSeries platform in QEMU comes with 2 firmwares:
 
-`SLOF <https://github.com/aik/SLOF>`_ (Slimline Open Firmware) is an
+`SLOF <https://gitlab.com/slof/slof>`_ (Slimline Open Firmware) is an
 implementation of the `IEEE 1275-1994, Standard for Boot (Initialization
 Configuration) Firmware: Core Requirements and Practices
 <https://standards.ieee.org/standard/1275-1994.html>`_.
-- 
2.52.0


