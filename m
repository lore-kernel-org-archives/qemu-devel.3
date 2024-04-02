Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A34BC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrXoc-0006FM-35; Tue, 02 Apr 2024 02:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrXoZ-0006Ev-7c
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:40:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrXoW-0002jQ-DA
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:40:10 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4326598I025333; Tue, 2 Apr 2024 06:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Fd3Oscgp/2CzBr7UOKe6HznnE9/U04aiAuaaL0ls5fc=;
 b=AmB1cHmD/L2Hh7GdCPPkR0c87rkhFXYCwDim1ZR4OQ2EwHfvAIx4UuzpgcaHQnJuSWUA
 whWflsYSUTJdtF2hxFg7OX0E5UQ4DPi0R+ypNQFJG8UYQ38Om+7qGgAoXLN55UDgIJme
 DXJwVSsWFSOobUFN8n8cULhXfPqaAxymaDelxuIczJBCrMWLrqjHWfXpNf3gI/3gpsS9
 8OGwY8oO/aqCgmdpkgl7MCAKaMCMHuAXloen3d9Hk7QorfHi/y/Tt4nmldOeTGoOCLKo
 XWdTkkKbZvX/pOMa+w51XKh5Auj+rCn8n5uRF1vyycgI4fzRXh48M2BxXNK21Ceez2LQ 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8c4103p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Apr 2024 06:39:56 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4326atX1010488;
 Tue, 2 Apr 2024 06:39:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8c4103p4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Apr 2024 06:39:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4324AdY1024736; Tue, 2 Apr 2024 06:39:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6x2p4tf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Apr 2024 06:39:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4326dnqb27460110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Apr 2024 06:39:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9441820043;
 Tue,  2 Apr 2024 06:39:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29A2C20040;
 Tue,  2 Apr 2024 06:39:48 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.72])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  2 Apr 2024 06:39:47 +0000 (GMT)
Date: Tue, 2 Apr 2024 12:09:45 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/2] P11 support for QEMU
Message-ID: <7dpmvbcarr2lbbjih3n6d6kaj23dzrmtowqme4lnyhbjeexffw@u3agsb3prq7b>
References: <20240401055503.1880587-1-adityag@linux.ibm.com>
 <c671fb5a-18d7-4c3a-beec-ad3f28114986@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c671fb5a-18d7-4c3a-beec-ad3f28114986@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QuJ71MKcpaDNJ4oQE_90bHDCGPVBc_7r
X-Proofpoint-GUID: KtIBE3R0RayVLkDuhbo9E62MiaVIMcQx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_02,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020046
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

Thanks for reviewing this.

On Mon, Apr 01, 2024 at 10:25:31AM +0200, Cédric Le Goater wrote:
> Hello Aditya,
> 
> Please run ./scripts/get_maintainer.pl when sending a series. qemu-ppc should be
> in Cc:

Tried it now, For some reason, get_maintainer.pl shows no maintainers:

    $ ./scripts/get_maintainer.pl -f 0002-ppc-powernv11-add-base-support-for-P11-PowerNV.patch
    get_maintainer.pl: No maintainers found, printing recent contributors.
    get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
    
    qemu-devel@nongnu.org (open list:All patches CC here)

I checked the MAINTAINERS file, will add maintainers in Cc, thanks.

> 
> Briefly looking at this, please separate the changes using one patch per model,
> that is : first CPU (target), LPC, OCC, PSI, SBE, PnvCore, SpaprCore. Last the
> PnvChip and the machines, powernv11 and pseries. A minimum commit log describing
> the HW is required.

Sure, I will split the changes and improve my commit descriptions.

> I don't see PHB6 or XIVE3. Why ?

Power11 core is same as Power10, so it supports till PHB5 and XIVE2,
same as P10. That's why I have not added any code for them.

> 
> Also, you will need an OPAL update. The above changes are pointless without it.
> The minimum for now is a git commit from the opal repo, then you will need to
> update QEMU with a binary.

Agreed. I will consult when we push it to public. Will update this in
next series.

There might be some days delay in the next patch series.

Thanks

> 
> Thanks,
> 
> C.
> 
> On 4/1/24 07:55, Aditya Gupta wrote:
> > This patch series adds support for Power11 pseries and powernv machine targets
> > to emulate VMs running on Power11.
> > 
> > Most of the P11 support code has been taken from P10 code in QEMU.
> > And has been tested in pseries, powernv, with and without compat mode.
> > 
> > Git Tree for Testing: https://github.com/adi-g15-ibm/qemu/tree/p11
> > 
> > Aditya Gupta (2):
> >    ppc: pseries: add P11 cpu type
> >    ppc: powernv11: add base support for P11 PowerNV
> > 
> >   docs/system/ppc/pseries.rst |   6 +-
> >   hw/ppc/pnv.c                | 409 ++++++++++++++++++++++++++++++++++++
> >   hw/ppc/pnv_core.c           |  94 +++++++++
> >   hw/ppc/pnv_homer.c          |  64 ++++++
> >   hw/ppc/pnv_lpc.c            |  14 ++
> >   hw/ppc/pnv_occ.c            |  14 ++
> >   hw/ppc/pnv_psi.c            |  21 ++
> >   hw/ppc/pnv_sbe.c            |  19 ++
> >   hw/ppc/spapr_cpu_core.c     |   1 +
> >   include/hw/ppc/pnv.h        |  51 +++++
> >   include/hw/ppc/pnv_chip.h   |  30 +++
> >   include/hw/ppc/pnv_homer.h  |   3 +
> >   include/hw/ppc/pnv_lpc.h    |   4 +
> >   include/hw/ppc/pnv_occ.h    |   2 +
> >   include/hw/ppc/pnv_psi.h    |   2 +
> >   include/hw/ppc/pnv_sbe.h    |   2 +
> >   include/hw/ppc/pnv_xscom.h  |  55 +++++
> >   target/ppc/compat.c         |   7 +
> >   target/ppc/cpu-models.c     |   2 +
> >   target/ppc/cpu-models.h     |   2 +
> >   target/ppc/cpu_init.c       | 162 ++++++++++++++
> >   21 files changed, 961 insertions(+), 3 deletions(-)
> > 
> 

