Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7EBCA6015
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvii-00011i-Ex; Thu, 08 Oct 2026 17:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveY-0000Mr-UV
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:28:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveR-0002pJ-7L
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5dVb2295334; Thu, 8 Oct 2026 21:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vj3jWJ
 XF8ia+zz8mbIM3d2tPOydAa0Q0eVrae8RNyGA=; b=ZKkFnFOKvYJtulMsrWdg12
 ZBsPDbunnrRBxjPvXFJdr/yv73XjjN6pOyQt5vsk1BsRtAy/E8EnIlGQT1l5QiLM
 JNKu+Rhls++kdWsUZKHOTQVLDzHTouKDi8hhePC2roAfhlMwHvYv6ZewahO6fb3z
 01i/fOs5DVH3dkEqCcnudFlPesnuzE0JVZc4S0oOLmyGNjVHtMIaazVK7qknvH4w
 O/x59dJs6AYCCZZFe2aY2jYyBJI/G+8r1k2BCQsLEvq+ywBhGbF0fSoMCMfJoNy8
 6yx00Lh7h7mvnqSlbtXVkHzYn4+dfqvgtgTMeVBW8AS1IG1kYumSs2Zp46Pr76KQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw6922-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2bVO4079130; Thu, 8 Oct 2026 21:27:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsng9ky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRUgt31523558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 511245805C;
 Thu,  8 Oct 2026 21:27:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C569A58054;
 Thu,  8 Oct 2026 21:27:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 07/10] hw/tpm: crb: Avoid potential integer underflow
Date: Thu,  8 Oct 2026 17:27:20 -0400
Message-ID: <20261008212723.3679685-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX7GzEmQzeoBQw
 3O2iMyRWR3uRSXwPS/1x5/95hG7E6PFuKObWnB3xmOI15m+zjlhnolmv4Pt+YR+XfhplYDDuOs/
 G/jFjvYkJwavsbVD/DqFSOdS3yhI1E8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX0Z+Jv9gyNE4x
 gOM/nGgANJEOq1ao4drZmczaZJjutp+8i1n2k+shFrFeb6iqpZlyt+j42k1vwV2yP+eF3dT4qVs
 LSpfJT81BUaq3rUS7hMo8Z58O8UH7IB+dp6ZCf5kMGwjYHfHs4sIL+TToD8NzfcdLGHInQ7o6aq
 5OhlsjVWjQh1uOrQ7KMWuq+amF/9fz1X1CX+lgREszh5bhLBOGudOVQ9fK9D0LguxrJKwpkHGR7
 9J+9hgBsg8QDErYB6j6jtl/42WI5OTwA+EEIiUCmPKl8xQ6DSaoVu7VltjRsXlhB5nQy6dKyz+q
 XYtjHdbrllVcAXglWRpleczG/Q8co+VoyywSkoIMkYp2Tdf4H1KqBbOqfEm8/VmUaCTBrWNJaTM
 WgACO28A4Yh9+CNHK1tCse3uZGZekP0MeMLhs/xfgUrmfjpi2vat/66OnscE6TSKn19s/wyUUQ5
 oafKbIhOaghIHSnA6GA==
X-Proofpoint-GUID: eRUl2LTSrPZWbipfnYT6mxj4qfbvV14f
X-Proofpoint-ORIG-GUID: eRUl2LTSrPZWbipfnYT6mxj4qfbvV14f
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac80ac3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=c1_1-GllvHXUlFLDVV0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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

Avoid a potential integer underflow in tpm_crb_fill_command_response
that could occur if s->response_offset > s->response_buffer->len and
the function's call sites were to change.

tpm_crb_fill_command_response currently has 3 callers that either test
that 's->response_offset < s->response_buffer->len' is true or ensure that
s->response_offset = 0 and s->response_buffer->len >= 0. Therefore, the
integer underflow cannot currently occur. In the worst case the subtraction
would lead to a '0'.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-8-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index daf451aa56..cd46b2e888 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -180,10 +180,17 @@ static void tpm_crb_fill_command_response(CRBState *s)
      * to the linux guest in chunks by writing it back to MMIO region.
      */
     void *mem = memory_region_get_ram_ptr(&s->cmdmem);
-    uint32_t remaining = s->response_buffer->len - s->response_offset;
-    uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, remaining);
+    uint32_t remaining = 0;
+    uint32_t to_copy;
 
-    memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
+    if (s->response_offset < s->response_buffer->len) {
+        remaining = s->response_buffer->len - s->response_offset;
+    }
+    to_copy = MIN(CRB_CTRL_CMD_SIZE, remaining);
+
+    if (to_copy) {
+        memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
+    }
 
     if (to_copy < CRB_CTRL_CMD_SIZE) {
         memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
-- 
2.55.0


