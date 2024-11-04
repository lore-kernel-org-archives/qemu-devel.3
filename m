Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A859FD11185
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 06:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7qoe-0000IU-3y; Mon, 04 Nov 2024 01:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t7qoa-0000I9-9r; Mon, 04 Nov 2024 01:43:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t7qoY-0000Ml-Qo; Mon, 04 Nov 2024 01:43:52 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A46diAs022715;
 Mon, 4 Nov 2024 06:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZfhX3YeMVLxQlwGzE
 sKUbv3aFY83tCbWhOxV2cEhV9Y=; b=cz0CjQYhKWwIMATWOJnEXT9CMCZzEIbW3
 oMT5ei3K+Fo4AdofSml66jvldXAI86b1WB97pgTabLeB6rUfUQzWoI8SvbxjfMHu
 Zz7XxzeCsGcMSxHK8hq839KvpeM8R/qmMTXFtSsIMqMiaeUtjYNIyeJ3PfWC9ND8
 E2geadeOa6pyOCM6SPAjEKkeopL8NNjzebab0HT0qPcZ4Gke+sYELv6eTnmMpk1/
 UacUJ8YfiMHuKH+9bTCWPmG0GGXJ3oIxX0auGyPxq1mDtNYgw5nTqqHdb4CZZuHe
 fUtKE1mdXpBPj4iMh1L+ttm4E7w6XIFRlxbAgrsF9ulVHF3XtndaQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ps6t807b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 06:43:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3K0O6m012253;
 Mon, 4 Nov 2024 06:43:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140shcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 06:43:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A46hgfh21496378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Nov 2024 06:43:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77F8758054;
 Mon,  4 Nov 2024 06:43:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E42C25803F;
 Mon,  4 Nov 2024 06:43:41 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Nov 2024 06:43:41 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org, dantan@linux.ibm.com
Subject: [PATCH v5 2/3] tpm/tpm_tis_spi: activation for the PowerNV machines
Date: Mon,  4 Nov 2024 00:43:33 -0600
Message-Id: <20241104064334.21468-3-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241104064334.21468-1-dantan@linux.vnet.ibm.com>
References: <20241104064334.21468-1-dantan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UpiGm4_f2YoAUQj4DcmPaCJRSskxycvN
X-Proofpoint-GUID: UpiGm4_f2YoAUQj4DcmPaCJRSskxycvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=823 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040057
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The addition to ppc/Kconfig is for building this into the
qemu-system-ppc64 binary. The enablement requires the
following command line argument:
  -device tpm-tis-spi,tpmdev=tpm0,bus=pnv-spi-bus.4

Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index b44d91bebb..56dcf5902e 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -39,6 +39,7 @@ config POWERNV
     select PCI_POWERNV
     select PCA9552
     select PCA9554
+    select TPM_TIS_SPI
     select SERIAL_ISA
     select SSI
     select SSI_M25P80
-- 
2.39.5


