Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A30DD59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6lu-0000Ws-Oo; Fri, 12 Dec 2025 12:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6lt-0000WD-D4; Fri, 12 Dec 2025 12:17:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6lk-0001Si-8x; Fri, 12 Dec 2025 12:17:37 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC90ARY009413;
 Fri, 12 Dec 2025 17:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=JMWJsD2SnQQHNkv1TdX88NKA1+kQHrvfvtOWB0i2RpU=; b=d4sERGmZVaBX
 sQ/13/asEZXCsb4oD/5jmPa4wN2rnjUx3e8RG/IWcWmLIAav1V1SvGNvw/Bny1Cu
 /wZn+uLS+hjs+YWSdSyuxIsbuDANLpIOwgB7tNO9GO1936aowiI81trfUvduh6dI
 K/rTz2feFlnGK0NcrXW+Mu3NYtg5BJ4lF/JRVKj/Q1L/uTykPA03h0J9zvbU0oFg
 Liy5GKH3QAETc7DHLe5V08C5inZnDLgmrFtm80uUt/TO/OL3uEpPLdXpySsrqgEB
 ZewWATsSBgff3mgcHpYUFi2qvH+hicjMracdborSql4Bzu4qsgQzVwfKGKeL5Wwt
 8HCKQQW6dg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aytm97n2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:17:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCHAKXC014842;
 Fri, 12 Dec 2025 17:17:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aytm97n2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:17:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCE96Ih028102;
 Fri, 12 Dec 2025 17:17:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6yd777-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:17:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCHHNm121758602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 17:17:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DE9358059;
 Fri, 12 Dec 2025 17:17:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9467958043;
 Fri, 12 Dec 2025 17:17:22 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 17:17:22 +0000 (GMT)
Message-ID: <4c7c9feea38735db84e3b52e824f403a6e8ab7e4.camel@linux.ibm.com>
Subject: Re: [PATCH 4/6] hw/ppc: pnv_adu.c added vmstate support
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Date: Fri, 12 Dec 2025 11:17:22 -0600
In-Reply-To: <20251211220926.2865972-5-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
 <20251211220926.2865972-5-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 11D9hrgZahoqFCyvyeQUYV8KyC9-bmkL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA2MSBTYWx0ZWRfX69CN79z2yKFQ
 5YG3p0v3i+aAS+/cstv5FTtrX2aQ7uEEnVZco0aYLYj8dFmB4F4u6Ym+fvK6ML1MRPn88rLxpEd
 SiCdq152WCiTM7mBoZqqyE3OVqp6GFjv7VmeHySMeON2me7pIajdG0bghMF2RoC746xvzjewGIu
 xieO/cGelks0rZvQsF5KMd/a834TpjAuVu7XSdfrdB15QoEE8tFSXbHz/MzMtJ1vtg347ztAVpA
 dVK1v1oUtiq8FFgZ2uXq+7ZBORBCxxazHfrnWmnimOyGcnTFwEJg3sbIWIQYPpomtgd1Nrc2WH7
 r5KQyz8VOD8L3OH5Dx5PhrYm4h61JctRsERBNx6OjMeEMuUYIHxHSrhRRHwQM0bdXMvh+ZJvK/h
 8ISJXs5eHGub4eifdy/zaR2OPhiYeg==
X-Proofpoint-GUID: IbtidKV82Os43A5_VKKoXVR8U3P9uSWb
X-Authority-Analysis: v=2.4 cv=F5xat6hN c=1 sm=1 tr=0 ts=693c4e25 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=wBQykWjg2qbCGFWkGmgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512110061
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
> - Added vmstate support for ADU model
> 
> Signed-off-by: Angelo Jaramillo <angeloj@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_adu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
> index 005fbda475..bd2a9e233a 100644
> --- a/hw/ppc/pnv_adu.c
> +++ b/hw/ppc/pnv_adu.c
> @@ -23,6 +23,7 @@
>  #include "hw/ppc/pnv_chip.h"
>  #include "hw/ppc/pnv_lpc.h"
>  #include "hw/ppc/pnv_xscom.h"
> +#include "migration/vmstate.h"
>  #include "trace.h"
>  
>  #define ADU_LPC_BASE_REG     0x40
> @@ -189,6 +190,16 @@ static const Property pnv_adu_properties[] = {
>      DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
>  };
>  
> +static const VMStateDescription pnv_adu_vmstate = {
> +    .name = TYPE_PNV_ADU,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(lpc_cmd_reg, PnvADU),
> +        VMSTATE_UINT64(lpc_data_reg, PnvADU),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static void pnv_adu_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -197,6 +208,7 @@ static void pnv_adu_class_init(ObjectClass *klass, const void *data)
>      dc->desc = "PowerNV ADU";
>      device_class_set_props(dc, pnv_adu_properties);
>      dc->user_creatable = false;
> +    dc->vmsd = &pnv_adu_vmstate;
>  }
>  
>  static const TypeInfo pnv_adu_type_info = {


