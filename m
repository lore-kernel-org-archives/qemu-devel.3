Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E622CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3i-000368-BW; Sun, 28 Sep 2025 15:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3P-0002ui-I9
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3A-00046E-KD
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SJKfr0013771;
 Sun, 28 Sep 2025 19:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QGpY/7
 Qc54s9owPV8tPuFgZRMGIt3ccGcEpgBm9YRRI=; b=bhQXb9j+zpiyN4yS7k4Bxh
 UVwUxXXl1wR0eiYZu1ttRjHDO55augmjl9tpINcppbgRKXPAmQqEs3wlwQ7kbVBh
 xg4evkNI/pHK/seARGX7lR+Arug/K99Y8Q7Abunp4AfG6mzfg2OaDWG6QSirHmNG
 sImYH80bpc0265P20Pqfw+fNeiKbTTDBxQxN5c/ARtAt4RK38teRGmStxOBAxrpb
 BNUcqOkfawQDlSIhb4rLzCc7f04oliYf1DW0OJw54ZT92/W1kCYhmsXci+BkYgnK
 m+y6KKo07f81wBdtVVMBL0/WCKx7XSHk5kzjU9odKszNjewwMAqAsrRDHz9c2MDg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh6qbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SIEsda026795;
 Sun, 28 Sep 2025 19:27:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8mjug3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJR4Lr40042960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5477220049;
 Sun, 28 Sep 2025 19:27:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBA8020040;
 Sun, 28 Sep 2025 19:27:02 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:27:02 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Fabian Vogt <fvogt@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PULL 18/27] hw/intc/xics: Add missing call to register
 vmstate_icp_server
Date: Mon, 29 Sep 2025 00:56:20 +0530
Message-ID: <20250928192629.139822-19-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d98c0b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=TGpnWNUbWJQoO7jwSJQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX7AvU9U9+6E9a
 sz9ZnWAfmkYsWhNxMG8iyy8d2LUhAi7lsTSDiF5730yJa14uNW3piG1pn54vFS8iWZWkHluPiGY
 nFPI5+WLRIjLwgXMugvJRayqToLatsBIp2zkEsj/fgeN92JdHbPm9CQJ+0xAucq+/eN3+h8GL0J
 O8rTv8K71duw6vI+vOPEPfII2ZYYSDJTfU9wfKoQsQkxULyDUEgrS+6N7KBWE/354kM9BPT2riV
 t16pwsHm0QXubtWetbNkVsizpzBhHw8vdQLLqzFcOxjyymB88bIcL/D3xD4Jw3kbJFlBN9My5G4
 MX5svwoP8gI9mwHce//ionwMw1qvdU12i+0wyJ4zbiEGWNLklwxNjzWWolpxfk4IhYzIP4Mlu0g
 y9Viv56sTpp3tXVNytLyKgWuXITcTQ==
X-Proofpoint-GUID: MCXIhF7WO-MrcG7gtuhaWkzsBrPVEU9v
X-Proofpoint-ORIG-GUID: MCXIhF7WO-MrcG7gtuhaWkzsBrPVEU9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabian Vogt <fvogt@suse.de>

An obsolete wrapper function with a workaround was removed entirely,
without restoring the call it wrapped.

Without this, the guest is stuck after savevm/loadvm.

Fixes: 24ee9229fe31 ("ppc/spapr: remove deprecated machine pseries-2.9")
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/6187781.lOV4Wx5bFT@fvogt-thinkpad
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250819223905.2247-2-farosas@suse.de
Message-ID: <20250819223905.2247-2-farosas@suse.de>
---
 hw/intc/xics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d9a199e883..200710eb6c 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -335,6 +335,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
 }
 
 static void icp_unrealize(DeviceState *dev)
-- 
2.43.5


