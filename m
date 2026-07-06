Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AFEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfWF-0005aL-CZ; Mon, 06 Jul 2026 05:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfW0-0005WN-88; Mon, 06 Jul 2026 05:21:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfVx-00061h-A3; Mon, 06 Jul 2026 05:21:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669IG8d3133832; Mon, 6 Jul 2026 09:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=B8VoXBgb9KAwjXV1G
 lontgqPsYaxn5b2Lq6Xc4Hd1xE=; b=scwu2JfyiueB54NvI6cV9MLV1I4TWysNp
 w4ATSUVF9bm11nF1oa1aOdk4nFuvFpmZsUCRKGggXWmPJuTf4qrBLoynPBLX8jQJ
 yAZw5Jkab2Gpo2nNXdDp3+TtEqZ3TZHNbtXtAsYUB+46paPTKiP9XMP0gOtZ6YBL
 8/XIWJwp0KPK3zayLR27Ca2u6REEYNvhNFKA2VQ+AjN9jEP6AG11fgUj1FmRUBy1
 I+AupmhTXATTMF+kDsB1aKWX4S+48ww0gxIAWqAlrG1i4Eyfpht8d38gvkKdM58H
 4RpHJelEYcN6Ib0mYdOOjOhEdiaz9L9OSUD7xiTcaGkeu80GR1Sng==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsh67b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669JdCb005484;
 Mon, 6 Jul 2026 09:21:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfvpnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6669LFUa9634498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:21:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C86535805B;
 Mon,  6 Jul 2026 09:21:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D0605805C;
 Mon,  6 Jul 2026 09:21:13 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:21:13 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH 1/5] s390x/sclp: reject invalid write event data headers
Date: Mon,  6 Jul 2026 11:19:05 +0200
Message-ID: <20260706091909.864405-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706091909.864405-1-borntraeger@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8NXXMbMDjJ0fr-5x1a5JYxHD3-6KwQsu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXzwxstqGyHWRM
 V/jYPS3+wb0VNc4dfwa3xIR2Nd9s1dflzfvd0CiZi+C8KVUrw9Afxc+JmqvfPbLyng2QPbsWNeb
 b5/WtorAT/k+oOVLD/oTbLlorf3RubU=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b738d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=kbmgJ76JzREG6MJ5-XUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 8NXXMbMDjJ0fr-5x1a5JYxHD3-6KwQsu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX/kjTffvrnnml
 ByZ2ikrVGCDrsoVxj7kpl1zH3Ur0RVGrlSGiIpPTIfIv+4AnOi6LOrvYrs3hLXY+AfrN66p4XJO
 4/KbT19EkbJp4bKqBon6BwbLBdDWvjB9EE5PP8ZpYSNQP8aUXn00RAb+WdsYu9KGxJfOFbBUgM1
 G7LEoHtajXbY3oad5xbs6b4qUCpI/3IAE8Yfczruor/WKckdw9xRp649zSbTlDCGg8TGy4KUdRa
 kQ1V7dHKTnr7nKFufZ39nXfkOYV4XFJqfiz904bCgA+/P0uKaaaIRORxlwn3/Lp+1cu1KJIpn1i
 vylELcSSpsbSixJQ/xvj7WAGXjCpFFCPZNddtE0WFRrBh2uGULPGL+pRFEhXVaX0NcYcreZ+a0O
 B0BWVrE4tFDn9zRWlVS1RxruTN6hk6wCuyjynCFbmEr7DVPlVjUQIc8FpivSpJLSQQTLWkDeKcZ
 yiBp5Hj49TaDbCII/tQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060094
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

If a guest submits an sccb with a tiny header length but a large number
of event mask entries, the write_event_mask handler will
1. return the wrong RC (ok instead of error)
2. write to memory after the allocated sccb in qemu host memory.

Add the necessary checks.

Cc: qemu-stable@nongnu.org
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 hw/s390x/event-facility.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index fee286ea63..184c469bd3 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -286,6 +286,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
 {
     WriteEventMask *we_mask = (WriteEventMask *) sccb;
+    uint16_t sccb_length = be16_to_cpu(sccb->h.length);
     uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
     sccb_mask_t tmp_mask;
 
@@ -294,6 +295,11 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
         return;
     }
 
+    if (sccb_length < sizeof(WriteEventMask) + 4 * mask_length) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return;
+    }
+
     /*
      * Note: We currently only support masks up to 8 byte length;
      *       the remainder is filled up with zeroes. Older Linux
-- 
2.53.0


