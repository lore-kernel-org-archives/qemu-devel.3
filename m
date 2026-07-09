Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218FDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpki-0004gx-JI; Thu, 09 Jul 2026 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1whpkg-0004fW-7J; Thu, 09 Jul 2026 10:29:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1whpke-0000A4-K9; Thu, 09 Jul 2026 10:29:21 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669EIDDe2171228; Thu, 9 Jul 2026 14:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=x3AJ18j2Gu791GLdK
 33hU/MZSQ5eZMj/Nt1cSxjj1WU=; b=Va6GdkL1hmsO6tIH/CusDcjSBJNMJW7Eo
 Vq0fIT3nqh5mkeQ/H/SAHn7LliwukUNOX7w7qrFHlgg6iyZpwJCr4dca1qWK7ozg
 RpePEuE0HPkTnpCIWYL86jg7KB0WKYKLcoFlLEzJX2HC1HoCbfMc1AZ4mOn/FDIp
 Ylx0A1XIr8OxPset/SWjBmbeA6y28gYfJigtcd6pxdXbQ6/dGMg6S5z6DwgN9cXy
 ZI70ZQOqgINCqKW5oZJlL5S/jswD7iAmYoMbh3jB3dZ0Vkt7DWx3wG39z6jdMmZq
 WvaPkTRpeItx3CMbxeK1H/TQjXy+EE4zW7JA0qdz6VSwyabbI1o6w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw525ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:29:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EJaew026466;
 Thu, 9 Jul 2026 14:29:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgd9xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:29:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669ETFBr28508868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 14:29:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27EF35805C;
 Thu,  9 Jul 2026 14:29:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3C1858051;
 Thu,  9 Jul 2026 14:29:12 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jul 2026 14:29:12 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/2] s390x/sclpcpi: check event length field before reading
 from buffer
Date: Thu,  9 Jul 2026 16:29:06 +0200
Message-ID: <20260709142906.197474-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709142906.197474-1-borntraeger@linux.ibm.com>
References: <20260709142906.197474-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kH4vn3WgIYkGjuGVYGFFU-i_B9Hp0AM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX4iyTxQMvasSL
 bK6XOgxNPdhvkif4FcQ7mi+nAq21lNrsvLtL8hDEDbxh1/UVJtBEZxt5jDYrmt0lLWR+9jwroSB
 YWcAecPB9foBEvrMRi3B1haXs0SCutNSW3HVH9lgu3By2WIkOVCZzcf39nBYr1qajgfbFQFaIQu
 bzh6Is20BfHSFfITmYmeSxRx1pHhcOI5jrOCAMPVyDqf4zVt6dni2I3+Z+owXWQ7vJJ5fnbYOfP
 SezwBpsNtemNDwCtMck/VgrNSfG1bzC4rRb0fFMITH09qvfoqezy2jQoLMTulwdyaM9RmTp5c5q
 TXysh6zfugC9boR4NuOzkQY+FkaoZWXnbBG7eJVvPXNC+4AI+Du7Qz7qqco9BFxQnMY8EDk2sT6
 B63ySja4AjKS6bXsmBkjo2XPw+j0FOjNBPjsOYsLqmmPNRYEJvsUpY2lMGRPViercRnnt9s6xZ+
 p56QwUQBxQ8ru6v5K2A==
X-Proofpoint-ORIG-GUID: kH4vn3WgIYkGjuGVYGFFU-i_B9Hp0AM9
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4fb03d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=LL4VAQpvL9dv9tmx0-kA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfXwFI5YS/t1g/j
 5MtBE3tXFch2cYzLSHEOYj9UXWNusqTCvV02vN07hLEgyMYWXPN0reJuWAcNxOPEAFLg2/kejeW
 LczJqfclSouNClP1wFpcVx3yHBkoSx0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090141
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

A guest might send a too short SCCB with SCLP_EVENT_CTRL_PGM_ID. QEMU
would fill its data structures with garbage data. Check for the precise
length of the CBI data structure and reject otherwise.

Fixes: f345978f24be ("hw/s390x: add Control-Program Identification to QOM")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/sclpcpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 68fc1b809b..ec4bdf2350 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -97,6 +97,11 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
                                              ebh);
     SCLPEventCPI *e = SCLP_EVENT_CPI(event);
 
+    /* Caller checks sccb length, buffer header checking is our duty */
+    if (be16_to_cpu(evt_buf_hdr->length) != sizeof(ControlProgramIdMsg)) {
+        return SCLP_RC_INCONSISTENT_LENGTHS;
+    }
+
     ascii_put(e->system_type, (char *)cpim->data.system_type,
               sizeof(cpim->data.system_type));
     ascii_put(e->system_name, (char *)cpim->data.system_name,
-- 
2.53.0


