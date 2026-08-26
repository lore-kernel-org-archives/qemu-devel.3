Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDBDC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD9C-0001vx-Tc; Wed, 26 Aug 2026 08:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD8J-0000Hv-Vv; Wed, 26 Aug 2026 08:53:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD88-0002th-NX; Wed, 26 Aug 2026 08:53:35 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW2u53893831; Wed, 26 Aug 2026 12:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IyLa/SA+RHp2L14np
 rNT1bv7osMr1IgTPthzs/jnPy8=; b=mKHosbo2FGQ3DcEVctjj7j6p4ZcVEjYpg
 JmQ5bGXzgQ4Qgupyc30lwa+Jl3zA10eyHR6YTa7I+aMGKr1aLocQYH+3hwb5H8qC
 tJ4alO1ymsHPWq/grJXL50CKZeaycuaydFHgmr8NnJqf+Pp6cz4dIkRJzdoRgORP
 ltGnAGlpp42j/KaPBUCEn+00E0NXvfYy9GKQYr9XJmMgs1noBH8lTd73kOyOtVLc
 A/tUxh6EglTwErYTOElsFwFzKbP8KBPQ9HfvIndWcaHgrcG6IXcPD/9sxrBwjvBj
 VMxPCH12wL6UoPL5p2JNG6N0866xQSVerf03iTkhAe7aKpYSINtTw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hxsbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:53:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfSSd003092;
 Wed, 26 Aug 2026 12:53:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qa5pp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:53:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCr0tV17760924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:53:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9992C5805B;
 Wed, 26 Aug 2026 12:53:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAFD558059;
 Wed, 26 Aug 2026 12:52:59 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:59 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 36/37] MAINTAINERS: Add secure IPL files to S390-ccw boot group
Date: Wed, 26 Aug 2026 08:52:11 -0400
Message-ID: <20260826125213.1901252-37-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX2PzzCtAN27Lk
 9/bMQjiPDbRLKF5UE5KAGuX7to9FpKpEDZdWICyXKYbh64UJgZnyP9wQTYC+RkN4OnAWEhxYaqw
 INToL+gbpsqxY4sCnZVKDO7C3DOFOMU=
X-Proofpoint-GUID: rY-abXEHFZ9ipl8VFzERMizOeAJSgTyC
X-Proofpoint-ORIG-GUID: rY-abXEHFZ9ipl8VFzERMizOeAJSgTyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXxJZd2CXd07Lq
 TuEOWfKFIBoRaV5EW4aVkq+7je/1h/+nj8ltRzi4Ix1j+nf/bblHQCKbJtEVX8EPA9Tm59tWs2s
 ubg/sHmTK7NxtSY16R5P4yhZscR7xNDt2Q6bM5Bx+Bou2Xjslc0XOkdNbHYTS81/VOCSaqLMENO
 8CPdgMV1lqORD1enHwxMmiODnWp7KkEjk1BDmhRxJcNyKiJD5uvZUesg9xdrELVgFJhJSAl6sd6
 CknqJWO6nn3rj5hcG5SdQUjo7phbq/xHuT/v906cVYOL15sVWcZ3oF4T8607cPpsvaNjTQqTqKO
 8IL6EjywQBYSH5ZTaygQW0Sd8kK8db0cRpZADGjuLT4i1HlhGwnuHC6tQ2vhnBQ5GUYh8He8J/Z
 JhF4/MXhZ1jbDZLDw+VTizySR2I3xLHU3W8BcH2X6NFnvaGgfPQwfmjSgtSdKoMjtvLx4AIKdq4
 VS7nzBbf3rh0L3RYycg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ee1af cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=3XkM9kc9ey0u6mwvYagA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Add entries for the files introduced by the secure IPL series (cert-store,
diag headers, documentation, and functional test) to the S390-ccw boot
maintainer group.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Jared Rossi <jrossi@linux.ibm.com>
Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-35-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0ee348c4..dc2f465628 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1970,10 +1970,15 @@ R: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
+F: hw/s390x/cert-store.[ch]
+F: include/hw/s390x/ipl/
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: docs/devel/s390-dasd-ipl.rst
+F: docs/specs/s390x-secure-ipl.rst
+F: docs/system/s390x/secure-ipl.rst
 F: tests/functional/s390x/test_pxelinux.py
+F: tests/functional/s390x/test_secure_ipl.py
 L: qemu-s390x@nongnu.org
 
 S390 PCI
-- 
2.55.0


