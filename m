Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EE4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PWk-0001Od-5k; Fri, 26 Apr 2024 13:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PWi-0001Nw-4O; Fri, 26 Apr 2024 13:38:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PWg-0006pv-Gz; Fri, 26 Apr 2024 13:38:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHSmhR025703; Fri, 26 Apr 2024 17:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=052njoWJBebggqh3gQQz7sS0mJqgXwOriMFQIwdX1L4=;
 b=fugAyodo87ANF0FyPIi4yOJm6SU63yF8F4Lh9vpEtJaN76Vok3QUwS6Lguf53GHpsKR8
 wj2lzTJ2FQfFZ0LuWnhOzoCmx0LtjsUNxVCh+OxHwbij1OKLp9HMNSXbnKbGi9OTriZB
 M9TRBB350r7IsqxF+WB0/I1MDZc06hAz8jdDJXFu3W0kFBbQK4YCvrEdu2o96paRsiXe
 jQrTL2IigU46dcc4dUOVw+ekiMFRwNplhkhNizvHu3GWy1XhV2wO9CTt0XCEQYNIXLht
 lVUYtCCqYBpwDKSdDEI0yrG5Z1J/iRvnZSVm4q9W3liSmT+NZlUvGdJR78pmvKR1XLY6 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgp880nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:38:12 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHcCN7008520;
 Fri, 26 Apr 2024 17:38:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgp880ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:38:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QGHDHA023068; Fri, 26 Apr 2024 17:38:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1ph04w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:38:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHc5Jg49283490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:38:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70B132004B;
 Fri, 26 Apr 2024 17:38:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3116820040;
 Fri, 26 Apr 2024 17:38:03 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:38:02 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:08:00 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 04/10] ppc/pnv: Add HOMER for POWER11
Message-ID: <ccl5jmzhsgpstg7o4i2ujtacdu2bwh6d45dr2mtade7zzgatzm@wep3jpqdyiqf>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-5-adityag@linux.ibm.com>
 <eb6954b8-e64d-4f0e-9533-52dcdf64e1a5@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb6954b8-e64d-4f0e-9533-52dcdf64e1a5@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cv3SQ_4x_agkgyqtYVhw7GbDEqFS6LKF
X-Proofpoint-GUID: v-BpAKstzKrLYbhYMZ6SD6lYEusYx9gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 mlxlogscore=834 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260120
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Fri, Apr 26, 2024 at 04:32:37PM +0200, Cédric Le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Power11 core is same as Power10, declare PNV11_HOMER as a child
> > class of PNV10_HOMER, so it goes through same class init
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
> >   hw/ppc/pnv_homer.c         | 8 ++++++++
> >   include/hw/ppc/pnv_homer.h | 3 +++
> >   2 files changed, 11 insertions(+)
> > 
> > diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
> > index f9a203d11d0d..1b0123a6f2ea 100644
> > --- a/hw/ppc/pnv_homer.c
> > +++ b/hw/ppc/pnv_homer.c
> > @@ -394,6 +394,13 @@ static const TypeInfo pnv_homer_power10_type_info = {
> >       .parent        = TYPE_PNV_HOMER,
> >       .instance_size = sizeof(PnvHomer),
> >       .class_init    = pnv_homer_power10_class_init,
> > +    .class_base_init = pnv_homer_power10_class_init,
> > +};
> > +
> > +static const TypeInfo pnv_homer_power11_type_info = {
> > +    .name          = TYPE_PNV11_HOMER,
> > +    .parent        = TYPE_PNV10_HOMER,
> > +    .instance_size = sizeof(PnvHomer),
> >   };
> >   static void pnv_homer_realize(DeviceState *dev, Error **errp)
> > @@ -442,6 +449,7 @@ static void pnv_homer_register_types(void)
> >       type_register_static(&pnv_homer_power8_type_info);
> >       type_register_static(&pnv_homer_power9_type_info);
> >       type_register_static(&pnv_homer_power10_type_info);
> > +    type_register_static(&pnv_homer_power11_type_info);
> >   }
> >   type_init(pnv_homer_register_types);
> > diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
> > index b1c5d498dc55..8f1cc8135937 100644
> > --- a/include/hw/ppc/pnv_homer.h
> > +++ b/include/hw/ppc/pnv_homer.h
> > @@ -35,6 +35,9 @@ DECLARE_INSTANCE_CHECKER(PnvHomer, PNV9_HOMER,
> >   #define TYPE_PNV10_HOMER TYPE_PNV_HOMER "-POWER10"
> >   DECLARE_INSTANCE_CHECKER(PnvHomer, PNV10_HOMER,
> >                            TYPE_PNV10_HOMER)
> > +#define TYPE_PNV11_HOMER TYPE_PNV_HOMER "-POWER11"
> > +DECLARE_INSTANCE_CHECKER(PnvHomer, PNV11_HOMER,
> > +                         TYPE_PNV11_HOMER)
> >   struct PnvHomer {
> >       DeviceState parent;
> 

