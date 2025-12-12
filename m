Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C4FD59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6lC-0000He-VX; Fri, 12 Dec 2025 12:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6lB-0000Gs-Cm; Fri, 12 Dec 2025 12:16:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6lA-0001LC-0M; Fri, 12 Dec 2025 12:16:53 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC87a31023041;
 Fri, 12 Dec 2025 17:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=lnwMuLtluBeA8V3j3FJgbE5ite8Shq6fUXw2yWadKMQ=; b=iZVYjgzyFIs+
 KM2w2AMg+hUXVIBs84rUS0uuw/sRPf0pAC+RBM0bckBqvvK5fatyLvGSUu3vK6Qm
 u+0AcH6yiVHrcxBz8acXLSCppDh7GJPjVTLExuq1L3KlUMSbCQf3Cx332he0COGp
 99ozO7kTrxrjFhWnrPomgsGsy2KiLqzF8wcS/ylSQ5oSt1oTlQA6b8B8yDiVJvoX
 Cu6Ect4rnlPAVtBTJRnNbCU5TGSwxv/5MNfSQkol2IC4/gCfALlYmVUzMdMRREGc
 EuP9Pi1nz2SoIHQhr1LUrZofJUugMTaM3/Gnqgpih7GDcMSJVZxtUC/SDrB1OYVa
 vRlWkWzrLg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww5vmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:16:48 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCH2iue032050;
 Fri, 12 Dec 2025 17:16:48 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww5vku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:16:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCEqQoP002057;
 Fri, 12 Dec 2025 17:16:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jvx47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:16:33 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCHGGqZ7799302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 17:16:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F0945805E;
 Fri, 12 Dec 2025 17:16:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FAE258060;
 Fri, 12 Dec 2025 17:16:31 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 17:16:31 +0000 (GMT)
Message-ID: <8e7f5262529ea6f7c9f281223bbe33f1acbee035.camel@linux.ibm.com>
Subject: Re: [PATCH 3/6] hw/ppc: Add pnv_i2c vmstate support
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Date: Fri, 12 Dec 2025 11:16:31 -0600
In-Reply-To: <20251211220926.2865972-4-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
 <20251211220926.2865972-4-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UzB4Zgp9R0zphA5rUvNR7GvTsCRX2Yq4
X-Proofpoint-ORIG-GUID: avehfToO3qGlwlyopZlOu773jde-Enx2
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693c4e00 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=DifKZWw6yAwDI_I4Uo0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX31Jhg+o2CQoC
 rM762Paw24/f3IR9As+v9kiKDxTrLGyrXVAeUmkn7yF0FSFtPM6MVUTtF9q04DJFRaALxe7jOHB
 RJTBLyPLroLXj7mkMa5hDBhWxKaPRSmecJf76RygFZmYN1zL83cLUvltg/mMv/B7xzqboHy2iaB
 KmbyF7PkTxtJ8yv5nEUpqByRM61LWlZoHm5oEf5frEiLXmg16ctSWqNDzOG1bMXwbRkz2DbdWbZ
 Ug5OxA9H5cWOtp2/K0vn4lt5Tn+O/FCtBP3y6tm/1NYHKbGSmoeB3wFkivWAgtGM6Wsr0dIjrtE
 WRftWrKHPrE3LnJPKfH6oxXSJlDQpL5Z0WScWdi0xey9BdpV0GBfMral20B3GOh2CVfRGQC7qxt
 4m8KKoUrNHfgxSQxWQvDO5Pq4Ot0Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Thu, 2025-12-11 at 16:09 -0600, Caleb Schlossin wrote:
> - Add vmstate support for i2c registers
> 
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_i2c.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index 60de479491..1018078228 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -19,6 +19,7 @@
>  #include "hw/ppc/pnv_i2c.h"
>  #include "hw/ppc/pnv_xscom.h"
>  #include "hw/ppc/fdt.h"
> +#include "migration/vmstate.h"
>  
>  #include <libfdt.h>
>  
> @@ -549,6 +550,15 @@ static const Property pnv_i2c_properties[] = {
>      DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
>  };
>  
> +static const VMStateDescription pnv_i2c_vmstate = {
> +    .name = TYPE_PNV_I2C,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(regs, PnvI2C, PNV_I2C_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -561,6 +571,7 @@ static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
>  
>      dc->desc = "PowerNV I2C";
>      dc->realize = pnv_i2c_realize;
> +    dc->vmsd = &pnv_i2c_vmstate;
>      device_class_set_props(dc, pnv_i2c_properties);
>  }
>  


