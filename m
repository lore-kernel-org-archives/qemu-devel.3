Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CABC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCPv-0000lE-Rx; Fri, 10 Jul 2026 10:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wiCPq-0000h1-L9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:41:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wiCPl-0005Vs-Tn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:41:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ADIWQT971630; Fri, 10 Jul 2026 14:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Injt72dZqXaLqp0VK
 vq6bhjajR5N2OsVmf2yOdoeZEg=; b=Nt5OVJOmZ8Y4gv564XAIl/LShfXnmaTCJ
 HV+A07FB8umPtPqdmOopsi380oMWr/99po0+aWyYCPQeAby8C1Tyg7PBmWkwSnc0
 2hIyIer4oVup2c8baTvBuIoN1Zp2zEGRVgL6aZIgbqeV+DBPPaDi738jK9zAfQXh
 5K/3mwz0pbaiEqlda4rJIUk+/98S7lU9PdMnObqyaY51Ru4Fwq5y6SG5+UTeQ82/
 57MK9GaNegFowLLvZYWoNinMOeKpY1o8hJfYb5uBwQ1GtuvrR9SjJE8Y+V3YmYFa
 /D01kAjuXFE/Awn2egDY9TCmvqHXWhwDpumCjXiSoOiAiFpRifhJA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw5797j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 14:41:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AEYb88030004;
 Fri, 10 Jul 2026 14:41:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgj81q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 14:41:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66AEfC2C22807248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 14:41:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB7775805C;
 Fri, 10 Jul 2026 14:41:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D28F5805A;
 Fri, 10 Jul 2026 14:41:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 14:41:12 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Mohammadfaiz Bawa <mbawa@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 3/3] hw/core/machine: disable tpm-tis-device PPI for machine
 type <= 11.0
Date: Fri, 10 Jul 2026 10:41:08 -0400
Message-ID: <20260710144108.621828-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710144108.621828-1-stefanb@linux.ibm.com>
References: <20260710144108.621828-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TBBNV1m_ZLZWa-Sjb-JoCfc7xQ_2b2YS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX9PYZUl17lbkO
 PXG7UfRkWDRAGA3G5yK8xemYbdU0jMi/3MclrCEH/n2Fs1qPWfaHvHaQaf6VWywn4jASHQUJ41A
 L+Zl1vBapwln7Dzwxg3mvfLOM+JrdsHcZIoGbglXjk6zlc01sBe2DWV6xJzYMSHMi7zxRQywh4/
 95XhsUYfR8s19tfmW7ft3Njmmh2o8NAcYwvnRbb6qxVvReHbm5zt1F+gz/VpJh0EwTKtu0dwU8z
 u/aeoBWrc8kpQiyZTAUf9h5UFBYh3pBrGsWTfgsng2F+RzklhejbZ9s29+samjpCdUyJVLFtX9Z
 LWs5kYr5PSFN9xfTNetCBbpDj5/ZnVJG2r145uctkL4LD5LmO01AEEodFOkF5AJhoUiX+m7NxnL
 Cntws1WrLfu7KoGCdcJfOxBvdZxZ07ZWHNtap3Y9eENHMMZmggi+qDZErZUVuRFPL+qEmyMiIKu
 ymwsgn+ENwz360bln4g==
X-Proofpoint-ORIG-GUID: TBBNV1m_ZLZWa-Sjb-JoCfc7xQ_2b2YS
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a51048a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=BVZ489IyuOhHAO5klUcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX8jFQon3T3sAD
 PXDdIDZstE3ToHlZL3vshORJwADPJ0JsYcjcgxcomIFsoRXypkFeHY30nvaEYg2CYkIrNeSS6za
 DK6xg06Q/qBT+Ems98wC8Pxc/WabCp8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

From: Mohammadfaiz Bawa <mbawa@redhat.com>

Set ppi=off in hw_compat_11_0[] so that older machine types do not
register the "tpm-ppi" RAMBlock, restoring backward migration.

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260619093140.832136-4-mbawa@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 15886a56b1..805148678d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -44,6 +44,7 @@ GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
+    { "tpm-tis-device", "ppi", "off" },
     { TYPE_ARM_SMMUV3, "ats", "off" },
     { TYPE_ARM_SMMUV3, "ril", "on" },
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
-- 
2.55.0


