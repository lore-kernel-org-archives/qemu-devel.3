Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39B4CCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 08:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIMt4-0006jG-Is; Mon, 10 Nov 2025 03:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vIMt3-0006iz-2R
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 03:04:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vIMt1-00062a-AD
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 03:04:28 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9Ehl8Y021035;
 Mon, 10 Nov 2025 08:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CLNcmr0hiBRqYGNo5
 HYYNASF61ziY4Yq2Z5Zbf3fFmk=; b=Hn0FfCMJOHuJe+RI8pxXBa3sN9mmyKnoV
 X1v2xsi+GohqIccDzDPXbxaPn+AJMScgycaNNq/wMbq6YAr1Jc/mLqwsuZC7A0GB
 fQq4r64ZoFNi9WhSTifjilGISLsv0Pyu9Jb26hOxE/vGpFiQ92oOmx98BSudeoow
 RaAK0DQDhj5RuN2Ss+EpQJn8QcKyhrhTUruBy72DOa0j4qdGSbWmv9yJdhKtpI/m
 SIxJk2u0SbligtkMzrs4Ck6qewO5QAo3Yjiikel1luAgNcORKEq5wkMhh5U1ai4Q
 vct9Ku+GiaSEQP4Bkue4eZpoMTFP1kHbOSZbYK2oBQSMiMZj7tlag==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5chwwa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Nov 2025 08:04:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4oFGB007313;
 Mon, 10 Nov 2025 08:04:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdj4b29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Nov 2025 08:04:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AA84Jrr44302604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Nov 2025 08:04:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDA9420040;
 Mon, 10 Nov 2025 08:04:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E067720043;
 Mon, 10 Nov 2025 08:04:18 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.217.7]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Nov 2025 08:04:18 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/2] hw/ppc/pegasos: Fix memory leak
Date: Mon, 10 Nov 2025 13:34:00 +0530
Message-ID: <20251110080401.3652497-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251110080401.3652497-1-harshpb@linux.ibm.com>
References: <20251110080401.3652497-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=69119c86 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=F0aBv-aiPrwMLLb2_7gA:9
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfXyNB84DSOjae4
 PP9fe8iQyk0SJxZfGWJq8aZLLsWn2CMKjc+aneVgkfE4OW5mzRqUu9rjOaoBX9uFGDN9lhFl6iS
 0UMYrYq27oF+75cVMb7pd01JQKgk/M+7eBQM97kNFNS8NeslkyFwZKNSvonMeTXAbKctSZqkSiS
 BUyOEq/yb2MC/eHwTxKKISmw67wlygVgBQo0rSvtfzZ05oPD3/3GPUXVMKq4wlGDoQiwB11zaPk
 AxGWIyujICOp5j+cGJ0r3n0ASF3JxkRHFFXvQJQl2gQx3SQhD/1pJJW/tzGeaRFjN/MPhCLsirh
 1UH1XW7A1nkaLCgwSubcXjfOt5GfKq4l9U3qWyUheABx6bXTGLMX+z725UMCcGdu2uJbLDhXi+5
 srAyo13bw3uASnMvRRMFu6XdvZDLFQ==
X-Proofpoint-GUID: N1xWdx4G9k_6zYCDYwvBj9bsJoUfhf2S
X-Proofpoint-ORIG-GUID: N1xWdx4G9k_6zYCDYwvBj9bsJoUfhf2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Commit 9099b430a4 introduced an early return that caused a leak of a
GString. Allocate it later to avoid the leak.

Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
Resolves: Coverity CID 1642027
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20251101165236.76E8B5972E3@zero.eik.bme.hu
Message-ID: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
---
 hw/ppc/pegasos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 3a498edd16..8ce185de3e 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -847,7 +847,7 @@ static struct {
 static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
 {
     FDTInfo *fi = opaque;
-    GString *node = g_string_new(NULL);
+    GString *node;
     uint32_t cells[(PCI_NUM_REGIONS + 1) * 5];
     int i, j;
     const char *name = NULL;
@@ -871,6 +871,7 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
             break;
         }
     }
+    node = g_string_new(NULL);
     g_string_printf(node, "%s/%s@%x", fi->path, (name ?: pn),
                     PCI_SLOT(d->devfn));
     if (PCI_FUNC(d->devfn)) {
-- 
2.43.5


