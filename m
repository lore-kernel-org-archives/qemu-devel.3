Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D885C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 16:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujKVP-0007Zt-ME; Tue, 05 Aug 2025 12:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ujKVF-0007T3-1U; Tue, 05 Aug 2025 12:27:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ujKVD-0004db-Ae; Tue, 05 Aug 2025 12:27:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CZRVC029457;
 Tue, 5 Aug 2025 16:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=uJ/wDQRn2lPqPv3H+R7GujvJh3un+uEchlcukuaLbXo=; b=LiTO5+/+P7lA
 iQuIt97sc6OfcppeY+EHDXElucQ3m3AFRLdfkk7ROeCyw5wPZ9q9h/tb5jzOht5d
 KdLpKeBU8ln1GMF+fmBhSn1Okinw/+AEvup2TLBSWdRhJhdxsKd9NIYFn10wjjIj
 n9e+Q8wAXI0dcl/6Fu3lTx7VUMHEMzlLihA/dTawcpTDxFitE0I8YKE+n5CGwAw/
 SdQFkThIE/mz12aNxBEsW6N6s41orpsPm+ngOXqNBSOYGHe0TTTh3kkmh4I04gSb
 P0SiF3By81ZQkFVXVPYfGQZ+COXwdTMIQyNBR/L7FDXzQUDORW+YgnKUCKfNAv43
 OKG126L1cA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3qmkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 16:27:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575GLjo9025262;
 Tue, 5 Aug 2025 16:27:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3qmkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 16:27:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575E84Ef006905;
 Tue, 5 Aug 2025 16:27:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489xgmk52r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 16:27:00 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 575GQwGT31130328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Aug 2025 16:26:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7FD158050;
 Tue,  5 Aug 2025 16:26:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E143158045;
 Tue,  5 Aug 2025 16:26:57 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Aug 2025 16:26:57 +0000 (GMT)
Message-ID: <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
Subject: Re: [PULL 00/50] ppc queue
From: Miles Glenn <milesg@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 qemu-stable <qemu-stable@nongnu.org>
Date: Tue, 05 Aug 2025 11:26:57 -0500
In-Reply-To: <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z+jsHGRA c=1 sm=1 tr=0 ts=689230d5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=ySPgdnKajjii0QiPevkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cP2qBcW5DNDSlpzeWz86yR6hh35Bn67u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExMyBTYWx0ZWRfXzwYsnfSwdnwO
 cAZLleZ1QTUGHEcwVI5qtyIE2NKdvkQt+rt7gTSnPPP2z0pYj0GtIMmMPqGiaGweM2L8SwE2QOc
 AjQCZfJmH1AGuJSGUFpc1xGRTYjfSBAehS8LnlC8HFnHTS+1GL8rsDNZ0Cx9BlVGi+dwTS8hmFJ
 tYggxliiriT42Zm+lsyt82nOlAoIq7u/MZo7QootOivaPKpJDIzPKb0oP1S8t/AS/DxL2acXW9k
 vcCqerciVWL0YmOeA5+Q406CEq7A70Q+5VpI+aEcY47r5V+XD7DIQRi1R3lJXbas4iD3P48k8rk
 rqJ+LsT4vCaF0tOUIjiQRHPGkQMuHmDqQ6Tg2XfnFMI10hVK8nKzqgjNud3vbvLX8PBgneUsjlN
 AgEM/DF13f4+aPelJiicAF1FDUKw2boX4DxqhKyZqVemYch9G3As7GMNiz3YsTqTG39wvw2+
X-Proofpoint-GUID: Maq62WN5wkdqcrUFs3SvrHpPd2K5EN3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=634 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050113
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

On Tue, 2025-07-22 at 17:25 +0300, Michael Tokarev wrote:
> On 22.07.2025 16:37, Cédric Le Goater wrote:
> > + Glenn, Michael, Caleb, Gautam
> > 
> > On 7/22/25 13:44, Michael Tokarev wrote:
> > > 21.07.2025 19:21, Cédric Le Goater wrote:
> > > 
> > > > ----------------------------------------------------------------
> > > > ppc/xive queue:
> > > > 
> > > > * Various bug fixes around lost interrupts particularly.
> > > > * Major group interrupt work, in particular around redistributing
> > > >    interrupts. Upstream group support is not in a complete or usable
> > > >    state as it is.
> > > > * Significant context push/pull improvements, particularly pool and
> > > >    phys context handling was quite incomplete beyond trivial OPAL
> > > >    case that pushes at boot.
> > > > * Improved tracing and checking for unimp and guest error situations.
> > > > * Various other missing feature support.
> > > 
> > > Is there anything in there which should be picked up for
> > > stable qemu branches?
> > 
> > May be the IBM simulation team can say ?
> > I think this would also require some testing before applying.
> > 
> > Which stable branch are you targeting ? 7.2 to 10.0 ?
> 
> There are currently 2 active stable branches, 7.2 and 10.0.
> Both are supposed to be long-term maintenance.  I think 7.2
> can be left behind already.
> 
> Thanks,
> 
> /mjt

Michael T.,

All of the XIVE fixes/changes originating from myself were made in an
effort to get PowerVM firmware running on PowerNV with minimal testing
of OPAL firmware.  However, even with those fixes, running PowerVM on
PowerNV is still pretty unstable.  While backporting these fixes would
likely increase the stability of running PowerVM on PowerNV, I do think
it could pose significant risk to the stability of running OPAL on
PowerNV.  With that in mind, I think it's probably best if we did not
backport any of my own XIVE changes.

Nick, can you respond regarding the changes you made?

Thanks,

Glenn






