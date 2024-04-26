Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3121C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PZY-0004mH-5Z; Fri, 26 Apr 2024 13:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PZW-0004kw-SL; Fri, 26 Apr 2024 13:41:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PZS-0007Xh-6A; Fri, 26 Apr 2024 13:41:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHf8Z4011940; Fri, 26 Apr 2024 17:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=d0KJMt1ogV0ly+EZvfcgW0M8vroflHn4Ajw/r7jhubw=;
 b=B71/iPcfXmzCzRk5o0FmCLdInWttrsdJJCFayt96ZtyiUItwQkzA3LNnrvSS6DgP6b9E
 4/pNbaCqrTh+Uk7xmB5FYw098fq0QC2lIrU/JxcIZhP028YsNdND0IOXYyvvxlQh1EgG
 r58i5XgKmId25cY7NGgTXCJB7R5RKV//w4T/oa6RyGCyiup0PP9x2gZx/q3OnwpKb+G9
 EbXVoVxJFTcoOxIs0+JhRMA6g1dIuFEjj9VnNErE2URNWnTzpGo8tFKed24h9yIqdedW
 9NC4wArD7lttI7sfN/Dwtmzq+mqQP+btHkFk3Azxy2bt03GrRff0OnDph/nVNP3ZCvF7 IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgb1r2cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:41:07 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHf7rY011929;
 Fri, 26 Apr 2024 17:41:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgb1r2ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:41:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QH5QOx015430; Fri, 26 Apr 2024 17:41:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmrvd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:41:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHf1nM46334262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:41:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 133EA2004B;
 Fri, 26 Apr 2024 17:41:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBF1C20043;
 Fri, 26 Apr 2024 17:40:57 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:40:57 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:10:55 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 09/10] ppc: Make Power11 as default cpu type for
 'pseries' and 'powernv'
Message-ID: <2xn3w4tyravqwg2xqbwtlldgjofookiixt6bqmycinlijiwper@4o3ws7j2wbyh>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-10-adityag@linux.ibm.com>
 <3d64c7e6-6128-4723-b7c5-11967b0a7457@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d64c7e6-6128-4723-b7c5-11967b0a7457@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VZNtgTdGJuKoIhoqKwKCzLFfmEGWMPaD
X-Proofpoint-ORIG-GUID: -yS-GDChVapMuhnTocdkW2X09PboWiF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=849 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Fri, Apr 26, 2024 at 04:32:18PM +0200, Cédric Le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Make Power11 as default cpu type for 'pseries' and 'powernv' machine type,
> > with Power11 being the newest supported Power processor in QEMU.
> 
> This is too early. We should merge Power11 support first, possibly in 9.1,
> and then change default in a future release, 9.2, 10.0

Okay, makes sense.

I will drop this change from v3.

Thanks,
- Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> 
> > 
> > Cc: Cédric Le Goater <clg@kaod.org>
> > Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >   hw/ppc/pnv.c   | 4 ++--
> >   hw/ppc/spapr.c | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 06e272f3bdd3..0c5a6bc424af 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -2531,8 +2531,6 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
> >       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
> >       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
> > -    mc->alias = "powernv";
> > -
> >       pmc->compat = compat;
> >       pmc->compat_size = sizeof(compat);
> >       pmc->dt_power_mgt = pnv_dt_power_mgt;
> > @@ -2569,6 +2567,8 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
> >       /* do power10_class_init as p11 core is same as p10 */
> >       pnv_machine_p10_common_class_init(oc, data);
> > +    mc->alias = "powernv";
> > +
> >       mc->desc = "IBM PowerNV (Non-Virtualized) POWER11";
> >       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11");
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d2d1e310a3be..1c3e2da8e9e4 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4698,7 +4698,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
> >       smc->dr_lmb_enabled = true;
> >       smc->update_dt_enabled = true;
> > -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
> > +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11");
> >       mc->has_hotpluggable_cpus = true;
> >       mc->nvdimm_supported = true;
> >       smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
> 

