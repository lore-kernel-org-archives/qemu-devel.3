Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE466CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc7zA-0003QD-EM; Tue, 23 Jun 2026 16:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc7z6-0003MH-18; Tue, 23 Jun 2026 16:44:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc7z4-0005fs-B4; Tue, 23 Jun 2026 16:44:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NKIMeR3272657; Tue, 23 Jun 2026 20:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=q4FTUG
 sXJDUUjX7xf0Kiu0sCSg+tDdpk7ZuzxXIjsic=; b=nBVzQ4IqUnHtVno/QxgI3z
 MhrnuNdyMedYKQZSUtyEzEpZ1PbrsEoCf6AZxRFOjNFjA3OSmO3QEha3J81tzXL0
 xc66Ua6mxBxTm7hQ3bnazgGhQr/VD+38/Drg8vk4lYa6uCqCgud40+PndMHMz5jS
 e2WPPV4xKiI7BXpEBRGikkHZX+Nzl/gxWmMnFOLmAYgv4hdHOFoAPHEmfKL+8moE
 X5YhqEUGSNf4vEjzb1QybN/3DF+aHFUxjbPLsAg54IOmachlmUGTNc01GFcBXI2z
 hKtmcYUTnKhnX5i2PNn+iwC9gTpDeo9XF9SvcZFUwG0SXEKb2zyzSY66yQMvafrA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqrtaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 20:44:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NKYwLY023987;
 Tue, 23 Jun 2026 20:44:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg557k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 20:44:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NKiQrF7406154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 20:44:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F74658054;
 Tue, 23 Jun 2026 20:44:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BCAF5805A;
 Tue, 23 Jun 2026 20:44:24 +0000 (GMT)
Received: from [9.61.241.143] (unknown [9.61.241.143])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 20:44:24 +0000 (GMT)
Message-ID: <9be1c11d-fe6c-4ec6-8f0a-9caacd35b4d9@linux.ibm.com>
Date: Tue, 23 Jun 2026 15:44:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] pnv/phb5: Mask off LSI Source-ID based on number
 of interrupts
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-10-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260617095058.652789-10-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3af02d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=tSBAhjPZYQjbVnloOIgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE2NyBTYWx0ZWRfXwJqsXL32Xz86
 SyGAR+135/ko/XrzZdpSVxm4ibehQnXPR5ZBbLDkaUhsNDXt39F8QUemFIZyG+eX5xcb7JCmAst
 njEGCW7/dTORTyi2ZTaSRc+InxTvuvG3il9lSNXNZa9/KQ5Aan/mYK3EJhyZEg3P7NWlT8Z6vMe
 JQvdQ6ZiLLHq4pg9rgJBfB4uI3895liFoKgAJxVKKg3MJrJ0pReWU+9dMzL9IBsOqfFIVJx0cMt
 aEcRQtLNPGlueuKeltPzH74cHbCOzNgczgtT7xUYcZOtXE/X0YKb5FHG5VCWoP/vv0S/e5OcMwd
 cu96ELyWaCqk+YKSSnKjMuDgXS84wSYWYrEBDae5PMPCEZ+fvKTSKGga70sj9KsxLHUYEjuTVQM
 9ISzn3wE7eKhMPqlfi7FFaNQZwBc/jhizduiND75L0OLUEst2WhpwWLj+vGYxkBqq4r2o8SlCui
 w7s4z7XRqp1WIXwmZxQ==
X-Proofpoint-GUID: OtC50o0SgfZJ0xO1PqhcfqPjpHJ0j91w
X-Proofpoint-ORIG-GUID: ZpRH8y-tBz5jHkqePkhA5ayyrp9UACWJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE2NyBTYWx0ZWRfXwoF+fdj8qt7Z
 w/fvE8r9LuUsYKkQQ/6szjmT7fPDwCyiOY1URSzx7XwGSRutujnn/OuTdObc8sljqXrWTyvgG+R
 a+hzivSHW3c019mfuzRerE3imr0TY4c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230167
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

On 6/17/26 4:50 AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> Add a method to reset the value of LSI Source-ID.
> Mask off LSI source-id based on number of interrupts in the big/small PHB.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
> ---
> v3: Updates for coding guidelines.
> v2: Introduced method pnv_phb4_xsrc_reset().
> 
> 
>  hw/pci-host/pnv_phb4.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 91b2064113..08c96aef7d 100644
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
> @@ -1943,6 +1944,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
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
> @@ -1999,10 +2006,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
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
> @@ -2076,8 +2084,6 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    pnv_phb4_update_xsrc(phb);
> -
>      phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
>  
>      pnv_phb4_xscom_realize(phb);


