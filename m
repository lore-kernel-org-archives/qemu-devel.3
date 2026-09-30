Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2382CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBv3G-0001xc-FA; Wed, 30 Sep 2026 10:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1xBv39-0001qe-EX; Wed, 30 Sep 2026 10:12:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1xBv37-0002G6-CV; Wed, 30 Sep 2026 10:12:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5NmR3170693; Wed, 30 Sep 2026 14:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KPecSD
 ZzMrLTS9g+pP8CsUQBHSJEY39Stpuz4RyaKxM=; b=cRHk6MWi1k0O+64rYq5JFk
 e/rRycb7FmSwTlFmj+DFOd85XS330q8IBVQpnddGZWRh6+6rroP/Qvd9bSYf5aK8
 egRWdx5WNrnjrRfSd6jZwN+uLhrkN3YTjb+QLrxtfBegf5lYewU7ZknHWkQXXTRo
 lKTQhzhR1orY8sN4qDIMbWfn6Cp5HLOe85R+p9UzM4cHnsAvYwqPeVW42Lbr379W
 se1D6BVSbqfWyHVh/Ze0kYtT0G1A7TWPwmw5Gwt+Adg287LIdIQ6wPqD+SxzzDz1
 t++h+oKHKakyz24LOmQr0uJYXrb922MTI3AZT1pAEmNTspT3t3ps0Dn0WALZS5cg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5dde4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:12:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UBWcXs3341875; Wed, 30 Sep 2026 14:12:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcs9bhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:12:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UECG7a18678352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 14:12:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12C3F58066;
 Wed, 30 Sep 2026 14:12:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E7F858054;
 Wed, 30 Sep 2026 14:12:14 +0000 (GMT)
Received: from [9.40.186.87] (unknown [9.40.186.87])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 14:12:14 +0000 (GMT)
Message-ID: <f7bdd2f0-8c95-4e15-b45c-9cc5d9c446df@linux.ibm.com>
Date: Wed, 30 Sep 2026 09:12:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] pnv/phb5: Mask off LSI Source-ID based on number
 of interrupts
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-10-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-10-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NiBTYWx0ZWRfX3hc4tT/p6sv2
 WoM52tvE8Jwr9WIJvBgA/DkMmdL9vwRhiNFTitofOkI2aalWPAkKHWe7jyF0bFTUVfwPjyGQv6g
 VkMM08cVRofOp+0Q9C6LkRZ6xJ5GguA=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd18c2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=02HBNwNuGvCHycWd1hMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: 1yCxB5t-s6mAlGolgkplw6tB9e8M4Km4
X-Proofpoint-ORIG-GUID: rMT-GkgCctF3RaVa-AXshWLPHs1_MpZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NiBTYWx0ZWRfX8/Fdo4iYN2Oq
 FfmyE53hnMAtxiVff5LnPI7Y9CgZQurRQiRJ6C8nVr+XhSR/hBeBSbLVX/FlwSe7lTfp10i+syP
 BCfbSf1FaE/dOyPClvt2b1315w/KvqoGqVSVvCb68RevnWMaQrDv3bGBTDRfT94lCWcQLu3gsH0
 0gOlUMGVA+1ahdZjabDpwR/wotri51ppZ9cWAAmOHVMot054twguKx8UCodUqXoWqHLb/QOqmgM
 V0lfMGWMA02RxPi9c2UKJR9M8DoDPIgKIqUG2JMieMO4zYEVbSoKFl6F8ygzGGg0i+jqEuS1SvE
 ILh/GWl+7wdeLyUhYtIMG+Qj8CaWiqH9G+5cy7uSN3cAyoZwk0a9RqOir1OsrDzaiPeDVv7bw/3
 PWjEB+IDIYgY0gKXy5P+v19LwRWrOWdcQTx+qCK1l2aL5MD/8po+Oxvis6Mhdass8il4lxtqo+X
 xeaSL3ArwcvUheA7yYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
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

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 8/31/26 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> Add a method to reset the value of LSI Source-ID.
> Mask off LSI source-id based on number of interrupts in the big/small PHB.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  hw/pci-host/pnv_phb4.c         | 12 +++++++++---
>  hw/pci-host/pnv_phb5.c         | 17 -----------------
>  include/hw/pci-host/pnv_phb5.h | 10 ++++------
>  3 files changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 5f84550a7c..362c9a039b 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -491,6 +491,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>  
>      lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>      lsi_base <<= 3;
> +    lsi_base &= (xsrc->nr_irqs - 1);
>  
>      /* TODO: handle reset values of PHB_LSI_SRC_ID */
>      if (!lsi_base) {
> @@ -1908,6 +1909,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
>      /* TODO: Add more RO-masks as regs are implemented in the model */
>  }
>  
> +static void pnv_phb4_xsrc_reset(PnvPHB4 *phb)
> +{
> +    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
> +    pnv_phb4_update_xsrc(phb);
> +}
> +
>  static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>  {
>      STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
> @@ -1964,10 +1971,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
>      PnvPHB4 *phb = PNV_PHB4(obj);
>  
>      pnv_phb4_pbl_core_reset(phb);
> +
> +    pnv_phb4_xsrc_reset(phb);
>      pnv_phb4_err_reg_reset(phb);
>      pnv_phb4_pcie_stack_reg_reset(phb);
>      pnv_phb4_regb_err_reg_reset(phb);
> -    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
>  }
>  
>  static void pnv_phb4_instance_init(Object *obj)
> @@ -2041,8 +2049,6 @@ void pnv_phb4_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    pnv_phb4_update_xsrc(phb);
> -
>      phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
>  
>      pnv_phb4_xscom_realize(phb);
> diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
> index b09351f69f..ec6dfbe2b2 100644
> --- a/hw/pci-host/pnv_phb5.c
> +++ b/hw/pci-host/pnv_phb5.c
> @@ -6,24 +6,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> -#include "qemu/osdep.h"
> -#include "qemu/log.h"
> -#include "qemu/bswap.h"
> -#include "qapi/visitor.h"
> -#include "qapi/error.h"
> -#include "target/ppc/cpu.h"
> -#include "hw/pci-host/pnv_phb4_regs.h"
> -#include "hw/pci-host/pnv_phb4.h"
>  #include "hw/pci-host/pnv_phb5.h"
> -#include "hw/pci/pcie_host.h"
> -#include "hw/pci/pcie_port.h"
> -#include "hw/ppc/pnv.h"
> -#include "hw/ppc/pnv_xscom.h"
> -#include "hw/core/irq.h"
> -#include "hw/core/qdev-properties.h"
> -#include "qom/object.h"
> -#include "trace.h"
> -#include "system/reset.h"
>  
>  void pnv_phb5_cfg_core_reset(PCIDevice *d)
>  {
> diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
> index 4534083fd5..8f1df4892f 100644
> --- a/include/hw/pci-host/pnv_phb5.h
> +++ b/include/hw/pci-host/pnv_phb5.h
> @@ -9,12 +9,10 @@
>  #ifndef PCI_HOST_PNV_PHB5_H
>  #define PCI_HOST_PNV_PHB5_H
>  
> -#include "hw/pci-host/pnv_phb.h"
> -#include "hw/pci/pci_bus.h"
> -#include "hw/ppc/pnv.h"
> -#include "hw/ppc/pnv_nest_pervasive.h"
> -#include "hw/ppc/xive.h"
> -#include "qom/object.h"
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/pci-host/pnv_phb4_regs.h"
> +#include "hw/pci-host/pnv_phb4.h"
>  
>  void pnv_phb5_cfg_core_reset(PCIDevice *d);
>  


