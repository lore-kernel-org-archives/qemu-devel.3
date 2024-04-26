Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E262EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0P8T-0008QH-47; Fri, 26 Apr 2024 13:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0P8Q-0008Oe-9g; Fri, 26 Apr 2024 13:13:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0P8O-000138-1k; Fri, 26 Apr 2024 13:13:17 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QGtHTN018211; Fri, 26 Apr 2024 17:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Yy6APWrbUDS6boX3eqPVNnBPdzSrHtCBIgSUs7Mh5wM=;
 b=EOjXmg34F5ZKc15+znVbnHUW3fmpLELvZlWhfLzefrNVbKidZOwGFHMJl2X9ry/TmcdE
 yx+Mfc6NKQHcKqlVlqF+Mnelyotzqj4sP7Hf1lVKXPOE+QrvP9XuHcJO/gSt5ujyS8ob
 GPcHYysUshdfFOx0qyi8G1OUqydBJlIMkY0boIuF0LunXDcEbWqkORNypYIdwdfgr0kF
 30npIcg3xBR9xpn3wkM7K/ZdelZIzxBg6dQcU2v1K8Kh/Y+P/auHdRtYYf+li9V5y35n
 AWO/Mf8WthtQNC2xo31CBoZPHVBKgz2ZYKEhjeMKqHVTuAvy8DuWiq0kvmFoM7Ncb78h jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrg75g17f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:13:03 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHD2kO012624;
 Fri, 26 Apr 2024 17:13:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrg75g17c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:13:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QG9PhW015343; Fri, 26 Apr 2024 17:13:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmrrrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:13:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHCtOW46596466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:12:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E26E720043;
 Fri, 26 Apr 2024 17:12:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58CFD20040;
 Fri, 26 Apr 2024 17:12:53 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:12:53 +0000 (GMT)
Date: Fri, 26 Apr 2024 22:42:50 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 01/10] ppc/pseries: Add Power11 cpu type
Message-ID: <renzconck4oavacnkebh4g73jia6ovxsv5fgf4lkik4edwdbt7@kajfn5jcjf5j>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-2-adityag@linux.ibm.com>
 <d35b2a2d-1307-46bf-81ae-747a0e62d6be@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d35b2a2d-1307-46bf-81ae-747a0e62d6be@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K2DNve_0LP5Kx93rctmftr1GuXVxPbfU
X-Proofpoint-ORIG-GUID: y7YAB3NyA6ikPLMhfjzJmJZZDaVIyW0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=494
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260116
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

> > diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
> > index a876d897b6e4..3277564b34c2 100644
> > --- a/docs/system/ppc/pseries.rst
> > +++ b/docs/system/ppc/pseries.rst
> > @@ -15,9 +15,9 @@ Supported devices
> >   =================
> >    * Multi processor support for many Power processors generations: POWER7,
> > -   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
> > -   but its state is unknown.
> > - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
> > +   POWER7+, POWER8, POWER8NVL, POWER9, Power10 and Power11. Support for POWER5+
> > +   exists, but its state is unknown.
> 
> The POWER5+ pseries machine seems functionnal with SLOF
> (Sep 18 2023 18:57:48) and Linux 6.6.3 under TCG. May be worth
> to mention (for AIX users) in another patch.

Sure, thanks for pointing this, will add these changes in a separate
patch.

There were some points in 'powernv' docs, that might need updating:

Quoting lines from docs/system/ppc/powernv.rst:

> Missing devices
> ---------------
> 
> A lot is missing, among which :
> 
>  * I2C controllers (yet to be merged).
>  * NPU/NPU2/NPU3 controllers.
>  * EEH support for PCIe Host bridge controllers.
>  * NX controller.
>  * VAS controller.
>  * chipTOD (Time Of Day).
>  * Self Boot Engine (SBE).
>  * FSI bus.

I can see that 'chipTOD' was added in commit 9a69950feb098. I2C mentions
yet to merge, is it merged yet ?

I will check whether this needs updating, but might do it in a separate
patch than this series.

Thanks,
- Aditya Gupta

> 
> > + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9, Power10, Power11)
> >    * vPHB PCIe Host bridge.
> >    * vscsi and vnet devices, compatible with the same devices available on a
> >      PowerVM hypervisor with VIOS managing LPARs.


