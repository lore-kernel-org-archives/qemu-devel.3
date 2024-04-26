Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F36C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PE7-0001tD-AH; Fri, 26 Apr 2024 13:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PE5-0001sy-Sb; Fri, 26 Apr 2024 13:19:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PE3-0002Af-Na; Fri, 26 Apr 2024 13:19:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QH3amt022006; Fri, 26 Apr 2024 17:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=kuMcYpqzp9mPokDMMOmLnWzGO3m3Dv6SZmMi/wQ8He8=;
 b=YhP6AUldEJBQpJNZ/vUjovVHdi9b/WJz8+bTovE1dOvR+RoSZysgzmfRrPqLBDAMAI25
 u88Dt0vpfpK6Bp6dBcIomBMaSCwmeCYyQr/ipAdEJ9l+JVT/pdtVNn3+sAJeAyrtdSUc
 77TOCyVaTKH1VWRWU9UmqceWsNzyBHRO0fgdxCLIP0DscwL41u7BT/Zz33HH7LFgb1jq
 qubhj3M17n1Hhb8Fm85a3Yk4Ggpbl4fquf98v5IenJmIqtyBR5lGUpujUTHhtSTldWbK
 J3CwboWt8Mj65JVBe1nizTamzl6p5/ovbu7U497ydZqAM36EWEEaYmQbuAjSws7irQ9C Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgb1r11v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:18:59 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHIw52012649;
 Fri, 26 Apr 2024 17:18:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgb1r11u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:18:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QE5a9F028319; Fri, 26 Apr 2024 17:18:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr30f48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:18:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHIqfo44695968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:18:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0B020040;
 Fri, 26 Apr 2024 17:18:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3996020043;
 Fri, 26 Apr 2024 17:18:50 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:18:49 +0000 (GMT)
Date: Fri, 26 Apr 2024 22:48:47 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 02/10] ppc/pnv: Introduce 'PnvChipClass::chip_type'
Message-ID: <rmrigncfgylrgqg3c6s6bknn2zllijrbne3byidmi4uhmgqsjp@vixxdr6ldvlw>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-3-adityag@linux.ibm.com>
 <3ea873c8-3548-4a1b-84bd-ffe28ca19fc0@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ea873c8-3548-4a1b-84bd-ffe28ca19fc0@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8WTimwWSWn5wvDphvjniJxNdS-Ais62N
X-Proofpoint-ORIG-GUID: loTzeajS1ZWkib1CX-TaFxGtHyTPjbi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260117
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

Hello Cédric,

> >
> > <...snip...>
> >
> > diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> > index 8589f3291ed3..ebfe82b89537 100644
> > --- a/include/hw/ppc/pnv_chip.h
> > +++ b/include/hw/ppc/pnv_chip.h
> > @@ -17,12 +17,21 @@
> >   OBJECT_DECLARE_TYPE(PnvChip, PnvChipClass,
> >                       PNV_CHIP)
> > +typedef enum PnvChipType {
> > +    PNV_TYPE_POWER8E,     /* AKA Murano (default) */
> > +    PNV_TYPE_POWER8,      /* AKA Venice */
> > +    PNV_TYPE_POWER8NVL,   /* AKA Naples */
> > +    PNV_TYPE_POWER9,      /* AKA Nimbus */
> > +    PNV_TYPE_POWER10,
> > +} PnvChipType;
> 
> Nope.
> 
> > +
> >   struct PnvChip {
> >       /*< private >*/
> >       SysBusDevice parent_obj;
> >       /*< public >*/
> >       uint32_t     chip_id;
> > +
> >       uint64_t     ram_start;
> >       uint64_t     ram_size;
> > @@ -137,6 +146,7 @@ struct PnvChipClass {
> >       SysBusDeviceClass parent_class;
> >       /*< public >*/
> > +    PnvChipType  chip_type;
> >       uint64_t     chip_cfam_id;
> >       uint64_t     cores_mask;
> >       uint32_t     num_pecs;
> 
> Adding an enum type under PnvChipClass which is a type already
> looks wrong. Please find another way. It is possible I am sure.

True. You suggested one possible way in patch #3, to replicate the
*_dt_populate and quad_realize functions for Power11 also.

Another way to do this was depending on the type string in qemu
object's class type name, or object_cast_cache, but I decided not to go
with string comparison or depending on internal strings.

Will use your suggestion in patch #3.

Thanks,
Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 

