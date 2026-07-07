Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7148C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzuO-0005mp-9V; Tue, 07 Jul 2026 03:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuB-0005jA-KP; Tue, 07 Jul 2026 03:07:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuA-00034k-2q; Tue, 07 Jul 2026 03:07:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IV1f2286517; Tue, 7 Jul 2026 07:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=p+oSp2
 HbiAUlmJAhJiY0sfUSzkHpsawgB2KNKxdktzI=; b=LLlpRY8JtO4Qk89tvd2bO3
 4cTCvKpEHJDAyc27l0+jv9dMrunrv48OW1lnJXaS+BTZ6SHHhRTCYhN8QUuZqkT3
 R2hw/Gl+Guxstbil9JSMb+gGPKxn8GYshAM23q67FhNAv3/RanonQM0maPlq+4SZ
 re2sa9j3ok+4iP3G/LTbt6Mh9htoYl9FX3wFhRJc1kOxumfG6dDywcAbio9jVPTd
 FTP3u6ZnOKCZv2W8qhqiZnacj4PkeHIawZMX30nJelcqqxLUqs8mhUOEoi0IuhkG
 i883SVM8EkB+eye5wI3yhCvVYR0fowF9SX/oV+122PIBy6ziv8JXPVPFoDTFpXmg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4nmq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66774bao024237;
 Tue, 7 Jul 2026 07:07:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw1kne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66777ZO027918996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 07:07:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 067BF58061;
 Tue,  7 Jul 2026 07:07:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D39FE5805D;
 Tue,  7 Jul 2026 07:07:32 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 07:07:32 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/5] s390x/sclp: reject invalid write event data headers
Date: Tue,  7 Jul 2026 09:07:24 +0200
Message-ID: <20260707070728.147203-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707070728.147203-1-borntraeger@linux.ibm.com>
References: <20260707070728.147203-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 70NRucl6e665AmSEwHyYIATwulmQDTBb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfXwIkIkIXQx+fl
 hRUdAbREQLJViBlD9oKgEsYO0emDeeNgEVZQy8+DWZNWIKcKmDBOXTb8nyXBKTW9ZKC27xQOpQM
 zKg51wDP6MrQQXKVGjq/Exv4EBRq5mUuS6FsT7XDFRgmQ/Rr8AWwaHZ9kjMz1UdaqWus+jPc7kf
 n66GY0GIEmU/0JBMaTvWdhpWVKpeM4LZGAEh7FKP920rHqFF3iK2bDrIPzbBxtbjdeU3LWimRLc
 Hkg26k3TABfPWwMaJBXFFFcsu0rjhsMMru/mdibvaUOLF78K23uDV/8KuBwjJ+NA2XKh9945/7C
 Vme5M0+C5lGR17BdPAQiYX2jVe2X7chq7VA4dYGzYEu3GTFP9f2IAAFG5Ra3kswxtkZni1GG45k
 qC3G190OL0esi4h6Cm1PXTlStc8kGx00V4LKgdsNDhl445x6b6ss9KiXp3rczLdluShkShZfVkU
 /0NJApY8YyV8Tk6aNRQ==
X-Proofpoint-ORIG-GUID: 70NRucl6e665AmSEwHyYIATwulmQDTBb
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4ca5b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=MqXzq3hS93HRDXXrek4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX3ZWfa1pgdrJ2
 rMGIfl2LHgmOS56APOJokZrkajVS4FDB1f9oQdSAh6duDQeVnBPX3amDAMS2xA6sOAbWFoG0YrY
 nVYUyPOT2S9MJ1tzZwi1uBkZ3Tfxfk8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070064
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

If a guest submits an sccb with a tiny header length but a large number
of event mask entries, the write_event_mask handler will
1. return the wrong RC (ok instead of error)
2. write to memory after the allocated sccb in qemu host memory.

Add the necessary checks.

Cc: qemu-stable@nongnu.org
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


