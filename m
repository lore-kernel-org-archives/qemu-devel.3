Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F5DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZXg-0004kA-E2; Thu, 30 May 2024 02:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sCZXY-0004in-QZ; Thu, 30 May 2024 02:45:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sCZXW-0000Kw-QT; Thu, 30 May 2024 02:45:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U6UIAe005586; Thu, 30 May 2024 06:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=MP2W1rMOiMZcJ02OEKQ+Vt4/9TpLJFUV4Li0uH1cWpc=;
 b=eODdZFJA7xmWp0LbaRHOC4NFlQiwT8iowcqKrj+iV/1BpkEvJE0qfqdWegRTgcWGlpYL
 FitZRE9jT9Foxp+kdxjjJpFU/rIWnaUtlTu88Z6xU4mHu0MbxlBTNG+l8yq/hkCedCBd
 UThp9oZrGoFrakr9sp7t17I6kwyNjUpSXX1VgbAJ+Z3RK48cDLaXVpT5hg/l8GOp751S
 gUc5CtL0+bgPo7hGxXhma47DW9JDHrKRsP71+diLeebqW3k3b/XD2xAc5EaLX7shVb6K
 1ok1CM0Qmvz7upkQfU3nswCJZzrcy7hmTTfOUk/hF8V4oQP3VU1RSntD+O0G3fpw0Ewy Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yekhqr449-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 06:45:22 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44U6jM5a029173;
 Thu, 30 May 2024 06:45:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yekhqr43j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 06:45:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U4kWA2029563; Thu, 30 May 2024 06:42:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpayrf1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 06:42:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44U6fxf943450724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 06:42:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BBC320043;
 Thu, 30 May 2024 06:41:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0E3C20040;
 Thu, 30 May 2024 06:41:57 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.72])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 30 May 2024 06:41:57 +0000 (GMT)
Date: Thu, 30 May 2024 12:11:55 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4 11/11] ppc/pnv: Update skiboot.lid to support Power11
Message-ID: <237tfqyjrezyclwfhin4ywon26ltfz6uw4b3dafpofgta5jxda@h3swrqzjd2bf>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
 <20240528070515.117160-12-adityag@linux.ibm.com>
 <968da156-8621-4509-a0b2-726411e71b5e@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <968da156-8621-4509-a0b2-726411e71b5e@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B7GaS0ZkUcRGhbGshroPWLimR4O1cvO_
X-Proofpoint-GUID: HqQ2GrmtvU64ALSXaqJN7WWk5lLZee9J
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Cedric,

On Tue, May 28, 2024 at 09:15:29AM GMT, Cédric Le Goater wrote:
> On 5/28/24 09:05, Aditya Gupta wrote:
> > Skiboot/OPAL patches are in discussion upstream [1], with corresponding
> > commits in github repository [2].
> > 
> > Update skiboot.lid, with binary built from 'upstream_power11' branch
> > of skiboot repository with Power11 enablement patches [2].
> > 
> > ---
> > This patch can be skipped for now, if need to wait for patches to be
> > merged in open-power/skiboot. Have updated the skiboot.lid to aid in
> > testing this patch series.
> 
> When is the merge in skiboot planned ? QEMU 9.1 freeze is in ~2 months.

I have asked, will let you know when I get the expected time.

> > [1]:https://lists.ozlabs.org/pipermail/skiboot/2024-April/018963.html
> > [2]:https://github.com/maheshsal/skiboot.
> > 
> > Cc: Cédric Le Goater<clg@kaod.org>
> > Cc: Joel Stanley<joel@jms.id.au>
> > Cc: Mahesh J Salgaonkar<mahesh@linux.ibm.com>
> > Cc: Madhavan Srinivasan<maddy@linux.ibm.com>
> > Cc: Nicholas Piggin<npiggin@gmail.com>
> > Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> > ---
> >   pc-bios/skiboot.lid | Bin 2527328 -> 2527328 bytes
> 
> Please don't resend. This is big !

Oh okay. Sure.

Thanks,
Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> 
> 

