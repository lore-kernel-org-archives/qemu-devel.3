Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC0CC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7D-0007WG-8H; Wed, 26 Aug 2026 08:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7B-0007Ut-In; Wed, 26 Aug 2026 08:52:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD78-0002PY-UP; Wed, 26 Aug 2026 08:52:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCWY1G2128669; Wed, 26 Aug 2026 12:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=q/ZGOiLJ2Ccr78S57
 fQ+pSEFowklo0XtSq1MOXog/bM=; b=b4ZmSvza3wvs3KsQvGKmwXGRTqswTfb/e
 MwXLbhZd4tai3uI1wkDweNOUXBy16+GOXdBHnnJ4iKdmTVQ9gD0lmsS6j1KieNS3
 nPxP8jGmLI35zp1GcWFPne7DId/+qd17RhNrT84dJadl7Hi5nXSQxFgp6y1kVnE2
 BRoICXmuIfiWZ08OG1C3RT0IFojBfz8/dmEugbBfdcakQWieN0UkjRcfbwdsqD2Y
 lXFhsBbTQhf4vL39+ceXP0YKdCdU7OYjqAzBaWPL/DftBCrLr94zf4/1F8RkcNt1
 60D/4EhJb6xJjllgBmRo3ZxvpgLTtQjFFCNGK2wNTikegI4dUFRvg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqxm72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfKLA032664;
 Wed, 26 Aug 2026 12:52:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh9vke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqIA035979928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 462DF58059;
 Wed, 26 Aug 2026 12:52:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F9015805B;
 Wed, 26 Aug 2026 12:52:17 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:17 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 02/37] s390x/css: Fix css stsch detection to go beyond 8192
 devices
Date: Wed, 26 Aug 2026 08:51:37 -0400
Message-ID: <20260826125213.1901252-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nBKeKWQeSmEvhovJ8iEe7dhtXz6XYVFw
X-Proofpoint-ORIG-GUID: nBKeKWQeSmEvhovJ8iEe7dhtXz6XYVFw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX5tkObZqpot6r
 rsc4BKwgNAfBA8YfbQFXhgDEvlYTLWjYi8vgYT9xBfxI1QbZy8qssy0mqxYAJRwlWVHn5zobSBZ
 6T51QvOIQ5lR5+suLevoO+6FYyPTqtN6tI/MLB+m8WDSYQJgWjOGFlxaDQ73oAzWdtspupJqvMV
 rKqcgb1vlzrpZg9iAjEDRsR1hBYMlL5ftiByqk9o7Zznj6II4gEzZyiMLHNerf8eEYwT2jo8ItD
 9Z4oLPNjCX2cGZRCZlnZ1/9XxPkskObzeNQzj4mnKMCPHApmdDhLooblq7GctvLPEPiofszXbbe
 rfzz0nFyk4zJeSqZta/sFf1kdK/sjYGcE38wSzsPi02Bi+jq7mhwGRW0fsw/6gynayim/vvtB5w
 HGBPo5Wgoh2lQy50H5Ah/02vQ8+3aEK+fO7v4G3FyYIGqB1ded0aJSF3ZmKnxTKFFu1i9KpaGzY
 vSj6Fg+5VE0jvtMwYpw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8ee185 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WHrucGKVQccoiEeWISEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX4NVFzpEAXUdf
 o0xrVFMn/D3Uv34MF/7U5YJhzJoyEYWN/EGr7fzw2rYFGItjTOcSULlBjjXXEAwxEGqEWnGhLyx
 RMgS5jgwE+qdBwYgQ57TsV4fcOv4icw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

find_last_bit expects a size in bits and not in words. the calculation
limits the number of guest devices to 8192.  This probably does not
matter in reality, its wrong anyway.

Fixes: df1fe5bb49241 ("s390: Virtual channel subsystem support")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260814152226.1834819-1-borntraeger@de.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/css.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 3a67b67053..76dbca3bb9 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2023,8 +2023,7 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid)
         return true;
     }
     set = channel_subsys.css[real_cssid]->sch_set[ssid];
-    return schid > find_last_bit(set->schids_used,
-                                 (MAX_SCHID + 1) / sizeof(unsigned long));
+    return schid > find_last_bit(set->schids_used, (MAX_SCHID + 1));
 }
 
 unsigned int css_find_free_chpid(uint8_t cssid)
-- 
2.55.0


