Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A420EE6F08A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 20:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6yFN-00037X-Qq; Fri, 01 Nov 2024 16:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6yFJ-00036Y-Ln; Fri, 01 Nov 2024 16:27:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6yFI-0001Jw-16; Fri, 01 Nov 2024 16:27:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1KDPV7013205;
 Fri, 1 Nov 2024 20:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZfhX3YeMVLxQlwGzE
 sKUbv3aFY83tCbWhOxV2cEhV9Y=; b=s8NuGXGiFvOKtjijjKzfO/CL3ejXWc/Xi
 rWNdpVXXmpbMywVWAvlL3BULCq6cftQpQfmTseUEMbZA1Cz1SJ9I0KjbnoRLBqdZ
 9o/9O3L9FlrsC/yvDyJEU6i0dC3HChuzrp2M/HxBXCpspccLXx2SsBLJsW8++KtD
 Bt+vZVKIDefcfMoCWWCDzdWzLWPsjKKRWbpRK0FOxL81Cq6vUgC813ST5CWAZsQQ
 SAcKq4GTCPL29wkF6rLIAXP0vskEHgQg9tZyq7diRKWDmWt18OvPmrPwRoY1SE2h
 bAv2mwzEHDK/BIjHmbtCf22A9KV7C5Ka0kFETOFDpOc7WBuEwBMtw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42n0trsby0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 20:27:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1KAdx5018803;
 Fri, 1 Nov 2024 20:27:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8kk98p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 20:27:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A1KRYSE48824810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Nov 2024 20:27:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C13E58055;
 Fri,  1 Nov 2024 20:27:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F14425804B;
 Fri,  1 Nov 2024 20:27:33 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Nov 2024 20:27:33 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org,
 dantan@linux.vnet.ibm.com
Subject: [PATCH v4 2/3] tpm/tpm_tis_spi: activation for the PowerNV machines
Date: Fri,  1 Nov 2024 15:27:26 -0500
Message-Id: <20241101202727.9023-3-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101202727.9023-1-dantan@linux.vnet.ibm.com>
References: <20241101202727.9023-1-dantan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CdL_JWFzpl8-atueg08VRzXJf0OtgDNf
X-Proofpoint-GUID: CdL_JWFzpl8-atueg08VRzXJf0OtgDNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=823
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010144
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


