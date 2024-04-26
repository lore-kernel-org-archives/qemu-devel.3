Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB089C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PYh-0003Q4-TH; Fri, 26 Apr 2024 13:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PYM-0003G9-D9; Fri, 26 Apr 2024 13:40:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PYK-00075A-DK; Fri, 26 Apr 2024 13:40:06 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QGtT75018356; Fri, 26 Apr 2024 17:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=JUTKKWiS/wS2aZosg7JGMw/yrO90rygScUQFt+/Hf+A=;
 b=loBcsiD7ngk31TJAZ3BR9kV+25sKC0N7Cb9JmZO6EroxvXoJfGzjoq1qGJlHJ92TKLSV
 Di8MLzTZBbI1SzKkLiHF3O63SKK30k1aYahXOXOuQkvXj4atPgIsbmlC6KGxX/b6MJnp
 vc8mkK9kYEGd6+eCR6G5wELL+QTuj08n2NstzLtPu/8N324dSCiyN4rk2+eHwisNpHRQ
 +ejybNr4z+6cKz9t30ct/nQkbnSIFKMBzfpYJojYVR29LeNeEjQcU37pXLX2ITqDE9f9
 w4P1xjYEOb+HmT6Xc3YMsS/gqI4vq93CD4aV08EyJ7vxSCMcRkwYQjHTSo5nKLctXeQH vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrg75g2hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHds4P017243;
 Fri, 26 Apr 2024 17:39:54 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrg75g2hj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHK1Sv028328; Fri, 26 Apr 2024 17:39:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr30hkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:39:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHdmB652756878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:39:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 407BE20043;
 Fri, 26 Apr 2024 17:39:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3382420040;
 Fri, 26 Apr 2024 17:39:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:39:45 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:09:43 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 08/10] ppc/pnv: Add SBE model for Power11
Message-ID: <ttwaifi2zgmg6n7ttyqitnbkz5hc6l5u6gnha7ca7s7y3bwcw3@xxsrt6jirp5k>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-9-adityag@linux.ibm.com>
 <2adea9d4-0baa-47f3-b489-1b891c0541dd@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2adea9d4-0baa-47f3-b489-1b891c0541dd@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3BhgF2Re0cCFpWmukI627L8HUq05gU4M
X-Proofpoint-ORIG-GUID: euYOuNmdju79zrYz6RKHu3czSodYbAA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Fri, Apr 26, 2024 at 04:33:33PM +0200, Cédric Le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Power11 core is same as Power10, reuse PNV10_SBER initialisation, by
> > declaring PNV11_PSI as child class of PNV10_PSI
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

Thank you Cédric !

- Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> > ---
> >   hw/ppc/pnv_sbe.c         | 15 +++++++++++++++
> >   include/hw/ppc/pnv_sbe.h |  2 ++
> >   2 files changed, 17 insertions(+)
> > 
> > diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
> > index 74cee4eea7ad..a655cc7f8c9e 100644
> > --- a/hw/ppc/pnv_sbe.c
> > +++ b/hw/ppc/pnv_sbe.c
> > @@ -366,6 +366,20 @@ static const TypeInfo pnv_sbe_power10_type_info = {
> >       .name          = TYPE_PNV10_SBE,
> >       .parent        = TYPE_PNV9_SBE,
> >       .class_init    = pnv_sbe_power10_class_init,
> > +    .class_base_init = pnv_sbe_power10_class_init,
> > +};
> > +
> > +static void pnv_sbe_power11_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->desc = "PowerNV SBE Controller (POWER11)";
> > +}
> > +
> > +static const TypeInfo pnv_sbe_power11_type_info = {
> > +    .name          = TYPE_PNV11_SBE,
> > +    .parent        = TYPE_PNV10_SBE,
> > +    .class_init    = pnv_sbe_power11_class_init,
> >   };
> >   static void pnv_sbe_realize(DeviceState *dev, Error **errp)
> > @@ -409,6 +423,7 @@ static void pnv_sbe_register_types(void)
> >       type_register_static(&pnv_sbe_type_info);
> >       type_register_static(&pnv_sbe_power9_type_info);
> >       type_register_static(&pnv_sbe_power10_type_info);
> > +    type_register_static(&pnv_sbe_power11_type_info);
> >   }
> >   type_init(pnv_sbe_register_types);
> > diff --git a/include/hw/ppc/pnv_sbe.h b/include/hw/ppc/pnv_sbe.h
> > index b6b378ad14c7..09073a1256d6 100644
> > --- a/include/hw/ppc/pnv_sbe.h
> > +++ b/include/hw/ppc/pnv_sbe.h
> > @@ -29,6 +29,8 @@ OBJECT_DECLARE_TYPE(PnvSBE, PnvSBEClass, PNV_SBE)
> >   DECLARE_INSTANCE_CHECKER(PnvSBE, PNV9_SBE, TYPE_PNV9_SBE)
> >   #define TYPE_PNV10_SBE TYPE_PNV_SBE "-POWER10"
> >   DECLARE_INSTANCE_CHECKER(PnvSBE, PNV10_SBE, TYPE_PNV10_SBE)
> > +#define TYPE_PNV11_SBE TYPE_PNV_SBE "-POWER11"
> > +DECLARE_INSTANCE_CHECKER(PnvSBE, PNV11_SBE, TYPE_PNV11_SBE)
> >   struct PnvSBE {
> >       DeviceState xd;
> 

