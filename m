Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA35AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PXL-0001bL-OZ; Fri, 26 Apr 2024 13:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PX2-0001Wl-S4; Fri, 26 Apr 2024 13:38:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PX0-0006sj-4w; Fri, 26 Apr 2024 13:38:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHUDpw000725; Fri, 26 Apr 2024 17:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=NsGFIH2TgJOmcAXrXQt4jbHVfX1s8qCjbZwsRdr+noI=;
 b=Fnh0BQv3aLMX60lW3s0x9ppXEwvRR9QeoLzdug+Ps6WBKHvudrXBGOEClIhrT0POEKIr
 ba9DIXG+KylIrXr5/vYQK/VIL5/t1S33MfnqDCtxRRPT57Gg6tx9UOP3vaoSf13wKgZV
 e6MjhO7ZoF+3pfdgW+cnmGxpjs08S3plIQzBuPM1aH6wJ+ZxlRl1BY5+AkalTMGWZ0sY
 5IZhJIF9LDKhzec66MNhfmz+9ppoh4nfzNblUb63AKiVJNOUEaJeKm68+bEgjnoh0c4z
 2MO8Lo+QrP84+1cv9mSPXQuyFn9hSXvbHbV2GMvJ8f6kfWxbLEChGmLfPuxnPMfrmlGS 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgay0239-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:38:38 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHccPJ012782;
 Fri, 26 Apr 2024 17:38:38 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgay0237-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:38:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHJMPA005373; Fri, 26 Apr 2024 17:38:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cyrsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:38:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHcV7O29819526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:38:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A452C20040;
 Fri, 26 Apr 2024 17:38:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4987620043;
 Fri, 26 Apr 2024 17:38:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:38:29 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:08:26 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 05/10] ppc/pnv: Add a LPC controller for POWER11
Message-ID: <tiuliqmnc2ic34cpty3we77wcjx3p2twlr2igkbxijgsue3wxt@o7h5ydfuyi3j>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-6-adityag@linux.ibm.com>
 <6ea2dbd5-46d3-44d9-bab3-175d38b85a74@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ea2dbd5-46d3-44d9-bab3-175d38b85a74@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tZkKuDy_T7LUxDp4Ic0gG_AiWI_WjCPm
X-Proofpoint-ORIG-GUID: aeeZYdYoJZp6v8hW5zl0TqL9t1tMs6mt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=956
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260120
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 26, 2024 at 04:32:52PM +0200, Cédric Le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Power11 core is same as Power10 core, declare PNV11_LPC as a child
> > class of PNV10_LPC, so it goes through same class init
> > 
> > Cc: Cédric Le Goater <clg@kaod.org>
> > Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> > Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thank you Cédric.

- Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> > ---
> >   hw/ppc/pnv_lpc.c         | 14 ++++++++++++++
> >   include/hw/ppc/pnv_lpc.h |  4 ++++
> >   2 files changed, 18 insertions(+)
> > 
> > diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> > index d692858bee78..54b366221bc7 100644
> > --- a/hw/ppc/pnv_lpc.c
> > +++ b/hw/ppc/pnv_lpc.c
> > @@ -698,6 +698,19 @@ static const TypeInfo pnv_lpc_power10_info = {
> >       .class_init    = pnv_lpc_power10_class_init,
> >   };
> > +static void pnv_lpc_power11_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->desc = "PowerNV LPC Controller POWER11";
> > +}
> > +
> > +static const TypeInfo pnv_lpc_power11_info = {
> > +    .name          = TYPE_PNV11_LPC,
> > +    .parent        = TYPE_PNV10_LPC,
> > +    .class_init    = pnv_lpc_power11_class_init,
> > +};
> > +
> >   static void pnv_lpc_realize(DeviceState *dev, Error **errp)
> >   {
> >       PnvLpcController *lpc = PNV_LPC(dev);
> > @@ -771,6 +784,7 @@ static void pnv_lpc_register_types(void)
> >       type_register_static(&pnv_lpc_power8_info);
> >       type_register_static(&pnv_lpc_power9_info);
> >       type_register_static(&pnv_lpc_power10_info);
> > +    type_register_static(&pnv_lpc_power11_info);
> >   }
> >   type_init(pnv_lpc_register_types)
> > diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> > index 5d22c4557041..1069bca38dfd 100644
> > --- a/include/hw/ppc/pnv_lpc.h
> > +++ b/include/hw/ppc/pnv_lpc.h
> > @@ -41,6 +41,10 @@ DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV9_LPC,
> >   DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV10_LPC,
> >                            TYPE_PNV10_LPC)
> > +#define TYPE_PNV11_LPC TYPE_PNV_LPC "-POWER11"
> > +DECLARE_INSTANCE_CHECKER(PnvLpcController, PNV11_LPC,
> > +                         TYPE_PNV11_LPC)
> > +
> >   struct PnvLpcController {
> >       DeviceState parent;
> 

