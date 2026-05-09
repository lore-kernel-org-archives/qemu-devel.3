Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED3CCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 15:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLjF0-0001mG-GU; Sat, 09 May 2026 11:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLjEy-0001lq-UU; Sat, 09 May 2026 11:05:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLjEx-00088r-Aw; Sat, 09 May 2026 11:05:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64930oxP2539290; Sat, 9 May 2026 15:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qBT4Th
 kNcpm16fvS94fmtwBfbxKGdW/5tNEv+hFPknw=; b=HhrNKn0TZqDP+FqHX9MFmE
 CLaexBT+bO2XB0x5BkzuthrBNV4iBSbnxerHwoj0ruD6EWJmjlzTt8aCl7/f2ydH
 EX2qz7RpmdPF8PexOt4hpIRrFf1W7qGELWRMSvpOGRnJNvwQ60SDXWWHuZPJdKXr
 JH0bHl4fLU3wl5e2neEQ9AizA3Xda9oFzmnF/NIhBWn7MnWM+kmuXrM6EKBsj+yw
 G/CvTX1dM2d1VPpqIpXCWw4XR3ORWkAoHnQ+B8uyRCX4Fe5EQbPUXfrBGb8A0ERo
 jLabVH0VMZhSjcHPIbdXPi+UcMBqiTs7dg9hiUBQTT4FCSJZ7U64/dHv+BoysZjw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4hxde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 15:05:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649EsSXg023618;
 Sat, 9 May 2026 15:05:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywn1q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 15:05:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649F506n57868690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 15:05:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C29F20049;
 Sat,  9 May 2026 15:05:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE75A20040;
 Sat,  9 May 2026 15:04:53 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.188]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat,  9 May 2026 15:04:53 +0000 (GMT)
Date: Sat, 9 May 2026 20:34:50 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
Subject: Re: [PATCH v4 9/9] pnv/phb4: Mask off LSI Source-ID based on number
 of interrupts
Message-ID: <af9M4YtLceZXP06j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-10-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305060923.3753402-10-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=69ff4d22 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=PGcDxPPNg-x8-EFvyMgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1OSBTYWx0ZWRfX1c0zRN9NtjzE
 zBhTZVfLRdQwKpLpZo8Aqfxi7wj38cCeoRLt1fK+7Ae/ppeGD+arpVXJzYZ2iWYyBSToV4Arp63
 0pL2up9GqC/YrKP4XD3W0fW2Dgq5bL0H6/4BFqnt7GhkbCCNDejVnwZx4epVvmWahqr0fpqg7t9
 hRlYvLBM/1AXSA0B2+pJOvb4msqHbQXYTKueubqmNQdI7gOQvIPF2/IvhZABgZuJTGv3awFtCBp
 wByMjmIhMVhn4Igq+XAI6SEPi1rGAhJnG1HFnxYyWGX5tilJg2n3ZvFfkVy7Excvh2ySqiHJWCT
 dHdHPU/PPEROJTMBagsxaEdi4g40dLjg+dTr9xHZkukouhsoWlYA8jVnev0gIVMdFcDRFwr7X+b
 QQWJ6neE0ju/dRAjGMLPvJzqEawY6WqkMDeTcdHOCK73ie5BiRhDQHmmOdhODDhAGVughy6K0eh
 nG3rQ0hf6wI9i5lj8Tg==
X-Proofpoint-GUID: XOkHvR_h1oJf5bMv7LqOnQwxrFW2STNp
X-Proofpoint-ORIG-GUID: WDXMQn7JQBYe23nO74qNQQvY52bbweJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 26/03/05 12:09AM, Saif Abrar wrote:
> Add a method to reset the value of LSI Source-ID.
> Mask off LSI source-id based on number of interrupts in the big/small PHB.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
> v3: Updates for coding guidelines.
> v2: Introduced method pnv_phb4_xsrc_reset().
> 
>  hw/pci-host/pnv_phb4.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 254bbe4089..5e885cb89d 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -490,6 +490,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>  
>      lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>      lsi_base <<= 3;
> +    lsi_base &= (xsrc->nr_irqs - 1);
>  
>      /* TODO: handle reset values of PHB_LSI_SRC_ID */
>      if (!lsi_base) {
> @@ -1944,6 +1945,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4 *phb)
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
> @@ -2000,10 +2007,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
>      PnvPHB4 *phb = PNV_PHB4(obj);
>  
>      pnv_phb4_pbl_core_reset(phb);
> +
> +    pnv_phb4_xsrc_reset(phb);
>      pnv_phb4_err_reg_reset(phb);
>      pnv_phb4_pcie_stack_reg_reset(phb);
>      pnv_phb4_regb_err_reg_reset(phb);
> -    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;

why is resetting PHB_PCIE_CRESET removed here, is it not expected to
change during reset ?

- Aditya G


