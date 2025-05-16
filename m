Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96015C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxET-0002my-6w; Fri, 16 May 2025 11:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFxEP-0002k5-MM; Fri, 16 May 2025 11:44:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFxEN-0000pV-Ej; Fri, 16 May 2025 11:44:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GE40dQ009624;
 Fri, 16 May 2025 15:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=a+CKyfyir1r9EXN+wGH01d6OgduDNizIWOTUoJDEaYk=; b=jK9ibJ0jxZkK
 IokFypx3HEekB73fV/o1HyiPkXngAXK/oaMgpVtGzcE3l8wDrFUWYa3v7YDFTZ4s
 OM50giYS3QXAFoOc/ksSceUjjj5LSL3exN36ShAWsOhX7KavWddRmRJJtVmJrQhT
 nYqGqHaK1FWeAkfCeH10dJL5ImrAvM5/3m3luKwGG5/hnvkb04tkCPPxfR8ohj1T
 Wj3TaAVjlVn1aVD2Ow/mzFX7aBhLnc/ZNd680cTYx4Z0LtR2AxOvSkol2MJFrWw5
 fgJLrCKDS0lUP/IgAu8MIXlO99sFDL3l+IL60cfvE7q45ie7vJYf9EHSMtNgmRac
 pOAj/qeHEQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nny7cw6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 May 2025 15:44:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54GFaTwM020580;
 Fri, 16 May 2025 15:44:10 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nny7cw6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 May 2025 15:44:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54GEdQI5021861;
 Fri, 16 May 2025 15:44:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfq0896-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 May 2025 15:44:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54GFi4Kc25756190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 15:44:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23C015805B;
 Fri, 16 May 2025 15:44:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 836B458058;
 Fri, 16 May 2025 15:44:07 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 May 2025 15:44:07 +0000 (GMT)
Message-ID: <5b2ea8edf2f437b78e90fe3bcd9a78083fd652c0.camel@linux.ibm.com>
Subject: Re: [PATCH 17/50] pnv/xive2: Support ESB Escalation
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>, Glenn Miles
 <milesg@linux.vnet.ibm.com>
Date: Fri, 16 May 2025 10:44:07 -0500
In-Reply-To: <D9X5A3I88C2Q.29RV6YVBVYJ27@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-18-npiggin@gmail.com>
 <D9X5A3I88C2Q.29RV6YVBVYJ27@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -I0UXD-_vHbq8XJHayfA4xyCMzdiEgEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE1MiBTYWx0ZWRfXxQ8rdJn34du9
 S8eAixs2HxcE/NF/QPVCIv5XqJyv0lO053nRPY4XSxkgYmmyEUFtG+oKlwDGSMnAL6UpLiK6DD5
 U0GpDBrci+Z1wGdBcC+dSIxKF4ueei5RdKeVJJgU1bh/71SipGQphJu6PvLYzlkmlkQy0Hz4FDP
 O334UCJaJGCTFM3ZSGij68PMye2pYGDeCJ4iTlmsD3hOeHgHXlQvC9XgT7qIIu+9WDnVg4lo3if
 1cX2VdE+NURVMERXaI0GNtKzHe07IE990Cd2XVmnbZwaGCkTkBtSk9fpt6DdVqny9p5QFlJs18H
 3SlZln5fwMNAErtXUrJB2pBSaz76wdEWNUSaMHeNj62I0MvQB1gBDmX0u+wCT1A1mKRL/bYy5Xk
 XTbfVcbYe6xB+pznSapEvEZM1rtS7wbuXFh+RkjnvBNu6NnJTu+7644Eu4NLlHHRxHmOflmS
X-Proofpoint-GUID: kyevCz5mbEyNfgxyHDsJcEaBhZ92K62t
X-Authority-Analysis: v=2.4 cv=CfwI5Krl c=1 sm=1 tr=0 ts=68275d4a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=_1rhKVqMUZJ76mWlyvYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 2025-05-16 at 10:05 +1000, Nicholas Piggin wrote:
> On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> > From: Glenn Miles <milesg@linux.vnet.ibm.com>
> > 
> > Add support for XIVE ESB Interrupt Escalation.
> > 
> > Suggested-by: Michael Kowal <kowal@linux.ibm.com>
> > [This change was taken from a patch provided by Michael Kowal.]
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > ---
> >  hw/intc/xive2.c             | 62 ++++++++++++++++++++++++++++++-------
> >  include/hw/ppc/xive2.h      |  1 +
> >  include/hw/ppc/xive2_regs.h | 13 +++++---
> >  3 files changed, 59 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> > index de139dcfbf..0993e792cc 100644
> > --- a/hw/intc/xive2.c
> > +++ b/hw/intc/xive2.c
> > @@ -1552,18 +1552,39 @@ do_escalation:
> >          }
> >      }
> >  
> > -    /*
> > -     * The END trigger becomes an Escalation trigger
> > -     */
> > -    xive2_router_end_notify(xrtr,
> > -                           xive_get_field32(END2_W4_END_BLOCK,     end.w4),
> > -                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
> > -                           xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
> > +    if (xive2_end_is_escalate_end(&end)) {
> > +        /*
> > +         * Perform END Adaptive escalation processing
> > +         * The END trigger becomes an Escalation trigger
> > +         */
> > +        xive2_router_end_notify(xrtr,
> > +                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
> > +                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
> > +                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
> > +    } /* end END adaptive escalation */
> > +
> > +    else {
> > +        uint32_t lisn;              /* Logical Interrupt Source Number */
> > +
> > +        /*
> > +         *  Perform ESB escalation processing
> > +         *      E[N] == 1 --> N
> > +         *      Req[Block] <- E[ESB_Block]
> > +         *      Req[Index] <- E[ESB_Index]
> > +         *      Req[Offset] <- 0x000
> > +         *      Execute <ESB Store> Req command
> > +         */
> > +        lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
> > +                        xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
> > +
> > +        xive2_notify(xrtr, lisn, true /* pq_checked */);
> 
> Sorry I forgot to squash in a fix for the issues here. These should be
> _ESB_ constants not _END_, and we believe pq_checked should be false
> here so the ESB state machine is run.
> 
> https://lore.kernel.org/qemu-devel/D8CFK7Z5AJF8.ALT8MMH6EYYT@gmail.com/
> 
> I think we took discussion offline after that but that was the
> conclusion. I will sqash that fix in here. With that,
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> I also wonder if Mike should be author of this patch since
> that's what the note indicates? Or co-author? Better give your
> Signed-off-by too, if so.
> 
> Thanks,
> Nick

Yes, this commit was taken verbatim from a diff that Mike Kowal
provided me.  I think he certainly deserves the credit.  I wasn't sure
how to do that.

Glenn


