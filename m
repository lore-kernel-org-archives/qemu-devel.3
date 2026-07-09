Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37A5C44507
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpkh-0004gV-MA; Thu, 09 Jul 2026 10:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1whpkf-0004eN-0A; Thu, 09 Jul 2026 10:29:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1whpkd-00009t-Bl; Thu, 09 Jul 2026 10:29:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669EIJxP2914112; Thu, 9 Jul 2026 14:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DYcDtNnpeNvDzkmsM
 3jRXgTazJtvdn25dCb/i75fLTw=; b=fkVVPxcPUFs4Z1B9v3vTd5UvPT4iBL7+Z
 W8UwweqLtfCU59uHpFO6FwOuBDhGowqcipZdZb1ZOdxr+01jNsdn242oUpTu1qpe
 2Vey7UfN0SzmrICUg9TFgnZjFkvu/DqYojqjtMshup1D0Ok6WfyxR8bOpOen+hqE
 Q/kr62WXhgk+oYMYD8hGBJ8IcPeOelj5/DumycUtQL2JAn1PY+zz/mxEMGWpZDmz
 RODriwtDyDgR7N9N44W2itKiTZ6d8sJw7E4AAT0QLdB5Mrrn8WwqOSulBipxzpnN
 QIkxK4akoJ50gcU9/vSJdv1A+QI+IlRAMkmhYRWTM47XxmdrQHxaA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur1vec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:29:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EJbhN009803;
 Thu, 9 Jul 2026 14:29:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hndbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:29:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669EScEd22741578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 14:28:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A203B5805F;
 Thu,  9 Jul 2026 14:29:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 732615805A;
 Thu,  9 Jul 2026 14:29:10 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jul 2026 14:29:10 +0000 (GMT)
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
Subject: [PATCH 1/2] s390x/sclp: prevent re-reading the sclp header
Date: Thu,  9 Jul 2026 16:29:05 +0200
Message-ID: <20260709142906.197474-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709142906.197474-1-borntraeger@linux.ibm.com>
References: <20260709142906.197474-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX2enrX6IJP0jD
 uKaV3b1mbG+t37bTYKoCqlMDopZ2yDwDy3ahaSEd6r1ZRQ6S9Tuqd0b65f5Rzx8zXXBle15xOsd
 1RgxfU3pyW21vgUGYgwobq7mPun2Zpg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX+1G+1zvR1W7o
 VFTE7tvBFHuHE/UG7IcELy3D4fCWtitpH5+KXZWAwNXQJ5O20LFAYqu2uogrNSZAe52hwKOxz45
 C/XIfmOwB1YDx2u3k/a6ugx+XkS2JfydCQy9Dz2JD7W3bDVgwOlkZHO1l2EFINeqPkWw+ysM2II
 ikO/FDT5eqBu+CcWU1umtpZmxXhJq5dHJrTWb+pLnnrC5VShx8grMrsf8CdsHSwGxOBbDvoksOa
 yish0N72ZdL5g+EUwsPyJmqpFQtMghRtQ60/mD4pmUsLHOOk3wNyxW7RINdZXqZEx1A137RnRkZ
 DxDJOtsT0DFbVjXiDdk7doUFKFyEURB6HfSveG9ASW2f3qaqKevfhgAoOQjotUrk19+A0Wlp9w5
 xRsjouykFrMZGYDamjF2Ck7wbAp/d99M6Ad/055Uw6CplGkrAWnbZV4XWWp9SVfp1b9uDQg4HBF
 v3bVMnitwPppRNKySKw==
X-Proofpoint-GUID: EFTXvyH3xcyZYMLhkqm8a123i1Lx1UXL
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4fb03b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=U3GCA_YXEp6Erz6r9jEA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: EFTXvyH3xcyZYMLhkqm8a123i1Lx1UXL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
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

We verify the sccb length and then allocate based on that length. The
following access re-reads the sccb again. This can race against other
vCPUs overwriting the length field.

sclp_service_call_protected does not need a change as the ultravisor
provides a consistent snapshot.

Fixes: c1db53a5910f ("s390/sclp: read sccb from mem based on provided length")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/sclp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 2d2cde7803..3c8cb16488 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -329,7 +329,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     /*
      * we want to work on a private copy of the sccb, to prevent guests
      * from playing dirty tricks by modifying the memory content after
-     * the host has checked the values
+     * the host has checked the values.
+     * Reuse the previously fetched header
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
     ret = address_space_read(as, sccb, attrs,
@@ -337,6 +338,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     if (ret != MEMTX_OK) {
         return -PGM_ADDRESSING;
     }
+    work_sccb->h = header;
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-- 
2.53.0


