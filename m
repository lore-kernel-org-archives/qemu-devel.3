Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97F7CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrY93-0003iC-BF; Tue, 02 Apr 2024 03:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrY91-0003hl-Aq
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:01:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrY8z-0006fw-2s
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:01:18 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4325hNlk024739; Tue, 2 Apr 2024 07:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=eEUs0t/Pp7Kh1Kh+m3CjD6QD0EumwVtWNMCNdOHaVyA=;
 b=HljyMPAZc68thv8TUwan8IjTKTbPC3pgjznZ6fR9hxih1T/aG09rLRcRzBPZxxDZS/Qx
 7CUhaAGhrV4YVwiu1oNB+D0JncyT3ProfEu/Y4Qof4Itbl2pmJkrzD46BArd8EcYR55e
 45WP/0XwK9Wp42VEhfI07uJmbDXD45VmvWwERrYtYHu6g1s6V4sNI9mv3HLQSQovBoob
 FSPhyymZGm/R2HOUkSntdB4+GuVH8JooFkjcUiJhcKrWSWv6S9J/qq4MLhtql4gpd0vl
 lK0l1qCPPvl4JAQx14ghNmeXjOc5DAvN0bpWLmWFGQIIJ+24jwZaqoNC7ATFQGDwIb6F 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8c4104y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Apr 2024 07:01:13 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43271D1m015405;
 Tue, 2 Apr 2024 07:01:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8c4104x5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Apr 2024 07:01:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4323Jcj0027148; Tue, 2 Apr 2024 07:00:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6wf0549e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Apr 2024 07:00:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43270jpm52822286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Apr 2024 07:00:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B87BA2005A;
 Tue,  2 Apr 2024 07:00:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DE3620043;
 Tue,  2 Apr 2024 07:00:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.72])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  2 Apr 2024 07:00:44 +0000 (GMT)
Date: Tue, 2 Apr 2024 12:30:41 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/2] P11 support for QEMU
Message-ID: <b4c2tbcn7qg5b4thxpyvwzddt43lfi5ylmwcrr3c6ikmwrhxq2@kmv54op37jnv>
References: <20240401055503.1880587-1-adityag@linux.ibm.com>
 <c671fb5a-18d7-4c3a-beec-ad3f28114986@kaod.org>
 <7dpmvbcarr2lbbjih3n6d6kaj23dzrmtowqme4lnyhbjeexffw@u3agsb3prq7b>
 <c8a82773-04ff-44d4-9a75-1e1f9b4efa10@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8a82773-04ff-44d4-9a75-1e1f9b4efa10@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n7ZARgnfwD4_EN8wBkbycyZQ6xZOOOL0
X-Proofpoint-GUID: f2atp_oAeooSDmP2CFYnL_mKM1DdTxrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_02,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020049
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

> > > <...snip...>
> > > 
> > > Please run ./scripts/get_maintainer.pl when sending a series. qemu-ppc should be
> > > in Cc:
> > 
> > Tried it now, For some reason, get_maintainer.pl shows no maintainers:
> > 
> >      $ ./scripts/get_maintainer.pl -f 0002-ppc-powernv11-add-base-support-for-P11-PowerNV.patch
> >      get_maintainer.pl: No maintainers found, printing recent contributors.
> >      get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
> >      qemu-devel@nongnu.org (open list:All patches CC here)
> 
> Weird. I downloaded your series with b4 and ran the get_maintainer.pl script :
> 
> $ ./scripts/get_maintainer.pl 20240401_adityag_p11_support_for_qemu.patches/0001_ppc_pseries_add_p11_cpu_type.patch 20240401_adityag_p11_support_for_qemu.patches/0002_ppc_powernv11_add_base_support_for_p11_powernv.patch
> 
> Nicholas Piggin <npiggin@gmail.com> (odd fixer:sPAPR (pseries))
> Daniel Henrique Barboza <danielhb413@gmail.com> (reviewer:sPAPR (pseries))
> David Gibson <david@gibson.dropbear.id.au> (reviewer:sPAPR (pseries))
> Harsh Prateek Bora <harshpb@linux.ibm.com> (reviewer:sPAPR (pseries))
> "Cédric Le Goater" <clg@kaod.org> (odd fixer:PowerNV Non-Virt...)
> "Frédéric Barrat" <fbarrat@linux.ibm.com> (reviewer:PowerNV Non-Virt...)
> qemu-ppc@nongnu.org (open list:sPAPR (pseries))
> qemu-devel@nongnu.org (open list:All patches CC here)

So, it should have worked, I will check if I can get it to work.

> 
> > I checked the MAINTAINERS file, will add maintainers in Cc, thanks.
> > 
> > > 
> > > Briefly looking at this, please separate the changes using one patch per model,
> > > that is : first CPU (target), LPC, OCC, PSI, SBE, PnvCore, SpaprCore. Last the
> > > PnvChip and the machines, powernv11 and pseries. A minimum commit log describing
> > > the HW is required.
> > 
> > Sure, I will split the changes and improve my commit descriptions.
> > 
> > > I don't see PHB6 or XIVE3. Why ?
> > 
> > Power11 core is same as Power10, so it supports till PHB5 and XIVE2,
> > same as P10. That's why I have not added any code for them.
> 
> ok. That's typically the info the commit log should have.

Okay, I will add these details also.

> 
> > > Also, you will need an OPAL update. The above changes are pointless without it.
> > > The minimum for now is a git commit from the opal repo, then you will need to
> > > update QEMU with a binary.
> > 
> > Agreed. I will consult when we push it to public. Will update this in
> > next series.
> > 
> > There might be some days delay in the next patch series.
> 
> We have entered the QEMU 9.1 cycle. There is time. I will comment more
> the next respin.

Thanks Cédric

- Aditya Gupta


> 
> Thanks,
> 
> C.
> 

