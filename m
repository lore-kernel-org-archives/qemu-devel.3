Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A4BC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwbnA-0000ap-85; Wed, 19 Aug 2026 04:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wwbn8-0000aF-Tn; Wed, 19 Aug 2026 04:36:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wwbn7-0001mB-Ek; Wed, 19 Aug 2026 04:36:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J6WOpe2622749; Wed, 19 Aug 2026 08:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6Fw0sS
 ntxJe1+XkKINW8zj5uF0nr2xScdmA7iZ7aZAQ=; b=cBvB+ML/ijubw/iKBMWzoo
 z9R+CPkDbIJOInqFuPGKgqLaUnyfGiaJu8LbGnZ7cpaBeAPORe8mJzwE6gSmTqTB
 1pgsPRbf25H8jlQ1I4FQSPE5sREwrWIVewC2ohiI3bO126EkwXQdvBTa+RMES4mD
 GQd7v9FJ5D8qomEUjk4TAE5qp65QyugSZ4KjQ7Fx5uGwynN74bjf21gmob+uQAP/
 GHY2ETdYpA56gvF+bXm37ErBx2Bu7MkWx8+v7Kt0sFAqpZqk5XDSSAeQNU+4zTkO
 eXfTS3jbNS5VL6PCYUCqtxgw60w12/e+PVEkbYDbXVSnnsPM72w7M3hw2MpKKeMQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1ajhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 08:36:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8UDD3015232;
 Wed, 19 Aug 2026 08:36:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yfqb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 08:36:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67J8ae5t46006590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 08:36:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2E2C2004B;
 Wed, 19 Aug 2026 08:36:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FAE020040;
 Wed, 19 Aug 2026 08:36:39 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Aug 2026 08:36:39 +0000 (GMT)
Date: Wed, 19 Aug 2026 14:06:20 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for PPC KVM and
 sPAPR
Message-ID: <20260819140310.464f376c-a5-amachhiw@linux.ibm.com>
Mail-Followup-To: Nicholas Piggin <npiggin@gmail.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20260819050545.21232-1-amachhiw@linux.ibm.com>
 <4731356a-532f-4ecf-9f0b-ae7a6ac5f77e@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4731356a-532f-4ecf-9f0b-ae7a6ac5f77e@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a856b1d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=aow-egSQAAAA:8 a=omJ5bIHz1CpVJDpERRIA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: aaMZJ2KzNA4_KDVZyIoe52jDN6lsvvWa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX378MGvcwirA4
 ygZAd9OgLP63RLKDfWyEry2NTpYVF0SXjEFy74yZ/SSgaJQ6czP5VLzjklGH5aJD7+d0AGYhl1V
 1g0vpnt0gtEc+0VQrmfUWloypmknb70=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX4RF2Qv1M6ovA
 EdYn8wd7gl5FR3g0HX/XVQ4fqUgnqXzUCiEmG7Gn89zMpVk1CYFpNGn0N/AbtTe/YiTFWQsFv9X
 BnRq5hnoKXNjiKjbVxml43WD+emlh8P6ZweNhCDUwINKV/b5G+hwNu16+kbd+J02GpzVwYzxF/D
 b/NSeC4qONOo8mr80sq6h1moTnB/Lp7m8fGyifvgssg1Sq22LYl9TAG9P/g08JfEnBUUBb4S4LG
 hLYKcoTQ/gyG5GyPjJ+ouTh1DmSWNsoJ6f18pjkf2RRwn4AaXHQpdg75RaGpLQ7jOr73ZLeo0rp
 K6JgWQbcv4X9oGWZuP4mBznRBY8uUHB1HpRs1J9Rd9iKLjes3hD7c+CmSKqsjVTHb6wI8aLWQuX
 0wq8Aq1dXKNAEFHCyrlGj6QMSxpD1VGpjRPO3hc8UkctxhbAyGXBmSM8xVUa7hsuvxIc8Bgc/Zh
 T5aD99SG02AOze+x2Tg==
X-Proofpoint-ORIG-GUID: q2fQGNsl8tDZhdCnJvvcyIAUsEJqG-X4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190063
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 2026/08/19 09:12 AM, Cédric Le Goater wrote:
> On 8/19/26 07:05, Amit Machhiwal wrote:
> > I have been contributing to PPC KVM and sPAPR (pseries) for some time now and
> > would like to get notified of incoming changes to help with code reviews.
> > 
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   MAINTAINERS | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b51f5c3e6022..1a1c77285d3d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -497,6 +497,7 @@ F: tests/functional/aarch64/test_kvm.py
> >   PPC KVM CPUs
> >   M: Nicholas Piggin <npiggin@gmail.com>
> >   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > +R: Amit Machhiwal <amachhiw@linux.ibm.com>
> >   S: Odd Fixes
> >   F: target/ppc/kvm.c
> > @@ -1661,6 +1662,7 @@ F: tests/functional/ppc/test_40p.py
> >   sPAPR (pseries)
> >   M: Nicholas Piggin <npiggin@gmail.com>
> >   M: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > +R: Amit Machhiwal <amachhiw@linux.ibm.com>
> >   L: qemu-ppc@nongnu.org
> >   S: Odd Fixes
> >   F: hw/*/spapr*
> > 
> > base-commit: fa19879df1658f96ac07365fca8835b7decd6995
> 
> 
> I would consider removing Nick since he has moved to other activities.
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks for the ack, Cédric! 

Hi Nick,

Do you plan to be active on PPC in near future? Or do you think it would
be a right idea to remove you from the M list?

Thanks,
Amit

