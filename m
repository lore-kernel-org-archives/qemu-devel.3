Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E854C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PY0-0002Jl-Ne; Fri, 26 Apr 2024 13:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PXu-0002FA-8g; Fri, 26 Apr 2024 13:39:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PXs-000736-Hm; Fri, 26 Apr 2024 13:39:38 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHL2Fo001493; Fri, 26 Apr 2024 17:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=SZZs2Yb+kDhD4X8Gyh7YGltDevxkUfk2CI7ZefGg4pw=;
 b=PO8q4INb9MvCYJYdgJbytLvdR4BkZKpZxgOzzRbPGd9SU0nRiOEmA2NYDe6tzhX3W1PR
 8U5AXBmWMHwAaBPFqYQUNvzsggqCXexjZhU8MVENZ0gojv2DSVj0kq4H5wTFg4a1TZf1
 pxaTjQqMFdyIOviTzefOFWG5Nz9uBXmA5YFuRgf3YQiCr5rwIklrYHk12B5TjfwqEB2a
 rNx0aQceI1k9n6iFmKNebHxhFnCwSRfhBXZk8Pzsl3WSMu+2ou6x/BGwaL0Q8IwVGCnz
 yBBmV0YRoqfGm1YvnkQ9Vb3BDzAm+basuf708FYpARaGl8ai+0spaB9IOOt1tlT7rP2g Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgas01su-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:28 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHdRqI026446;
 Fri, 26 Apr 2024 17:39:27 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgas01st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:27 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHUgnA005352; Fri, 26 Apr 2024 17:39:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cyrut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHdL4552625666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:39:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B05A02004D;
 Fri, 26 Apr 2024 17:39:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 907D920040;
 Fri, 26 Apr 2024 17:39:19 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:39:19 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:09:17 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 07/10] ppc/pnv: Add a PSI bridge model for Power11
Message-ID: <gzmebdh772dl7fwasj3k77kjqmyorubkwomrfxgbjnqe7zrilj@zdsrxefy5lj6>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-8-adityag@linux.ibm.com>
 <11bd8c21-223d-44df-9f12-9be071633e5f@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11bd8c21-223d-44df-9f12-9be071633e5f@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n7AlEyPV5eTkQEz0mT-OviwMG_xbdvYT
X-Proofpoint-ORIG-GUID: rcbj6Wxb5d9vJ62EpP8-CB_DaGX1rCUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxlogscore=971
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404260120
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

On Fri, Apr 26, 2024 at 04:33:23PM +0200, Cédric Le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Power11 core is same as Power10, reuse PNV10_PSI initialisation, by
> > declaring 'PNV11_PSI' as child class of 'PNV10_PSI'
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

Thanks Cédric !

- Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> > ---
> >   hw/ppc/pnv_psi.c         | 24 ++++++++++++++++++++++++
> >   include/hw/ppc/pnv_psi.h |  2 ++
> >   2 files changed, 26 insertions(+)
> > 
> > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > index 26460d210deb..1f708b183a87 100644
> > --- a/hw/ppc/pnv_psi.c
> > +++ b/hw/ppc/pnv_psi.c
> > @@ -939,6 +939,29 @@ static const TypeInfo pnv_psi_power10_info = {
> >       .name          = TYPE_PNV10_PSI,
> >       .parent        = TYPE_PNV9_PSI,
> >       .class_init    = pnv_psi_power10_class_init,
> > +    .class_base_init = pnv_psi_power10_class_init,
> > +};
> > +
> > +static void pnv_psi_power11_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    PnvPsiClass *ppc = PNV_PSI_CLASS(klass);
> > +    static const char compat[] = "ibm,power11-psihb-x\0ibm,psihb-x";
> > +
> > +    dc->desc    = "PowerNV PSI Controller POWER11";
> > +
> > +    /*
> > +     * ppc->xscom_pbca and ppc->xscom_size will be set up by
> > +     * pnv_psi_power10_class_init
> > +     */
> > +    ppc->compat     = compat;
> > +    ppc->compat_size = sizeof(compat);
> > +}
> > +
> > +static const TypeInfo pnv_psi_power11_info = {
> > +    .name          = TYPE_PNV11_PSI,
> > +    .parent        = TYPE_PNV10_PSI,
> > +    .class_init    = pnv_psi_power11_class_init,
> >   };
> >   static void pnv_psi_class_init(ObjectClass *klass, void *data)
> > @@ -973,6 +996,7 @@ static void pnv_psi_register_types(void)
> >       type_register_static(&pnv_psi_power8_info);
> >       type_register_static(&pnv_psi_power9_info);
> >       type_register_static(&pnv_psi_power10_info);
> > +    type_register_static(&pnv_psi_power11_info);
> >   }
> >   type_init(pnv_psi_register_types);
> > diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
> > index 2a6f715350b6..9e1d31779204 100644
> > --- a/include/hw/ppc/pnv_psi.h
> > +++ b/include/hw/ppc/pnv_psi.h
> > @@ -70,6 +70,8 @@ struct Pnv9Psi {
> >   #define TYPE_PNV10_PSI TYPE_PNV_PSI "-POWER10"
> > +#define TYPE_PNV11_PSI TYPE_PNV_PSI "-POWER11"
> > +
> >   struct PnvPsiClass {
> >       SysBusDeviceClass parent_class;
> 

