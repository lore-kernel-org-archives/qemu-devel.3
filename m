Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CDCCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDenF-0006Rk-K9; Mon, 05 Oct 2026 05:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xDemz-0006P3-Ay; Mon, 05 Oct 2026 05:15:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xDemx-0003ve-Hs; Mon, 05 Oct 2026 05:15:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69515XdN2065802; Mon, 5 Oct 2026 09:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x74uc5
 LmoWkfFpetsZFfpSbvUadmCJ7W262jw6WGyB4=; b=e5ea8MjBBv4MAp6VloCYEq
 7WtHfYc3piEEfUHiGgZ9vwu2fnUZy53S02gI1JWP4lC7qA/mNLAYOWGFhKBqxIxn
 zVK/d43XWm7xLJT67K96RLkLIYSFsmOHFDmrMF3MFJo9ICkcc/71PwwmbUwRVuv6
 iAW/4ZX8fCFcqYthdxz0e973ANsVborhBBAT2brhLOAFMexIApzq880vHVEK8SkL
 HKrsllYELKYCnNfDUt6MtrhJXgY+fOhxoND0A3UDuz3/pUyvNuFnctBahfQ1YqY1
 8eFmE74Bfrfk/KS3gLbH031Kx9LjIM9YjqHY91XjhKOaYS6E34XWnAdXwCRklsaA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4frth8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 09:15:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6956ERua2175570; Mon, 5 Oct 2026 09:15:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy4hap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 09:15:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6959F8ZV35455342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 09:15:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 034E720063;
 Mon,  5 Oct 2026 09:15:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9CB32004D;
 Mon,  5 Oct 2026 09:15:06 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  5 Oct 2026 09:15:06 +0000 (GMT)
Date: Mon, 5 Oct 2026 14:53:17 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: =?utf-8?B?6J+55r6k57+U5aSq?= <zakinko@snowrabbit.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH] hw/ppc/spapr: Add the "rtas-version" property to /rtas
Message-ID: <20261005144738.9c0e1f8c-ba-amachhiw@linux.ibm.com>
Mail-Followup-To: =?utf-8?B?6J+55r6k57+U5aSq?= <zakinko@snowrabbit.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260929094138.16A18C92A0@bambi.snowrabbit.org>
 <20260929161126.2679fec2-3f-amachhiw@linux.ibm.com>
 <5E17BD06-6338-41C7-BA4E-E43771862D8E@snowrabbit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E17BD06-6338-41C7-BA4E-E43771862D8E@snowrabbit.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac36aa0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=L9C5IM_eAAAA:8 a=KrfZMsDjxS26D4HVL1cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d8_PwHeUR2dB5DzxAQPm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX9Eodz5z0iro6
 e5qaQNtsOW788+0m8Kz/Knih/txH0rbAuT1hgDsTP7eEl7HkWaJaLLeRZ7zcvip1/4Si1ywRU3u
 VjJeNBzfSBrA8bJqXA2gwaYGz0hGHdW6cAVjCpwC1dJuwfohzUWloVI/FJQfyqN9QSpy2d/dyxG
 Key+qK0srYHt38s3DgDEX8TxhLrb7VX8MWE0SLyt2gWh5XeDXvAZKLJ/PNlr2ArOYRctsktIJLF
 GalYlEiJBPIV+MebyxyF+mAgEGNk8lLfR4OsaY9QoRPllnF5c1KNI2OT8/+txSFwZ8Pf7p2/HLR
 24goKOgnUKKwm0hpkHibmljDN9WJ/ZCUyshdY3DVf5NrsRxMqi2cEVp9twrs8c0ysg8nRdXRIXI
 DaczUV5+HnxWNPdeGZPMBL4tO20/s/O8dzH9IjCPnrsoOBK3e+PQIeTXjJFvjnFW+VtoIKA3+xW
 LHdRPUi1LXfe0jOQT/g==
X-Proofpoint-GUID: aSWBereA4dNszUOvD3igLJZWyNIwxQoX
X-Proofpoint-ORIG-GUID: xWRSQV2uvTVbTeAg2mLM6HDrEvYXvi8T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfXwQtTDMIONcWj
 QXwzCuWG3uJghyhePgCoDFtk7L6R3O9peI8XvsWxhZD1y67x2y0jWhVPTCSckybku0tZKo/TYuF
 URBIoa1+kt4NidTLJKhaapyu3Sm+cyA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050036
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi Showta,

Thanks for addressing the nits — both look good.  A few things before this is
ready:

1. Please send v2 as a proper standalone patch submission (not inline in a
   reply), so it gets picked up correctly by patchwork.

2. Since the nits have been addressed, please carry over the tags in v2:

Reviewed-by: Amit Machhiwal amachhiw@linux.ibm.com
Tested-by: Amit Machhiwal amachhiw@linux.ibm.com

3. One minor nit - see below:

On 2026/10/04 08:42 AM, 蟹澤翔太 wrote:
> Hi Amit,
> 
> I am sorry for the slow reply.  I have just started a new job, and it
> took me a while to get back to this work.
> 
> Thank you for the review, for checking it against PAPR v10.60, and for
> testing it on a nestedv2 KVM guest.  Both of your suggestions make
> sense; v2 below cites PAPR v10.60 first, keeps LoPAR and LoPAPR as
> secondary references, and the comment on RTAS_VERSION now names PAPR
> v10.60 Table 20.  There is no other change to the code.
> 
> Thanks,
> Showta
> 
> -- >8 --
> 
> Subject: [PATCH v2] hw/ppc/spapr: Add the "rtas-version" property to /rtas
> PAPR requires every property listed in its table of /rtas device tree
> properties to be present before the OS is booted (R-7.2.6-3 and Table
> 20 in PAPR v10.60; the same requirement is in LoPAR 2.9 and LoPAPR
> 1.1). One of them is "rtas-version", an integer encoding of the RTAS
> interface version, and PAPR says it describes version 1 of that
> interface.
> 
> spapr_dt_rtas() sets "rtas-size", "rtas-error-log-max" and
> "rtas-event-scan-rate" but never "rtas-version", so a client that reads
> it finds no RTAS: NetBSD's RTAS driver fails to attach when the
> property is absent.
> 
> Set it to 1, the version PAPR describes.
> 
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
> ---
> v2:
> - Cite PAPR v10.60 first, as the rest of the spapr code does, and keep
>   LoPAR and LoPAPR as secondary references.
> - The comment on RTAS_VERSION now names PAPR v10.60 Table 20.
> 
>  hw/ppc/spapr.c         | 1 +
>  include/hw/ppc/spapr.h | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6d99464486..8a1b5b37b6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1068,6 +1068,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>                            RTAS_ERROR_LOG_MAX));
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
>                            RTAS_EVENT_SCAN_RATE));
> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-version", RTAS_VERSION));
>  
>      g_assert(msi_nonbroken);
>      _FDT(fdt_setprop(fdt, rtas, "ibm,change-msix-capable", NULL, 0));
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9acda15d4f..b92d25c18e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -830,6 +830,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
>  
>  #define RTAS_EVENT_SCAN_RATE    1
>  
> +/* The RTAS interface version PAPR v10.60 Table 20 describes */

The wording reads a bit awkwardly. How about:

/* RTAS interface version, as defined by PAPR v10.60 Table 20 */

Thanks,
Amit

