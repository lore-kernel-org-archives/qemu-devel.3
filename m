Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3FECA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBVf2-0002sy-2R; Tue, 29 Sep 2026 07:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xBVev-0002sN-TO; Tue, 29 Sep 2026 07:06:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xBVet-0000AQ-KF; Tue, 29 Sep 2026 07:06:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5gPl4017664; Tue, 29 Sep 2026 11:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qNydnn
 IRHXDwkbbsNXXq7nQCMhKBKDVCvmxoGGa1a6Q=; b=XTPQa1Q4dOcxITkXXDYbdD
 7D2D+zvENfQPclW1uAfzmtO7yf9i3iz7Er7KDGDSMHIayCHuGgH5eAzxerWsSx4m
 v3bUOiok6NdaEFxXv08ZFltAlr1elvDNx+W8sg4duW0pt2sP+HUx0/2I0s4dAhSR
 b4nz8ZUEegNp5IeI5r5jJ7+b/W6j+8CQhiASPdL/AbtbuK/o+5+y7YXO10elHpgE
 prdw3MkeVkvQbk9kJisQOOmnqboNQtV79dfiYzMrfBLZnDGnclaj6J6wGWv6vfqk
 lIAXqHAPC4w0KKSy9bxn4XLwtQYGTMGSoQx0xVu0fRRO16tI5KvAjHUshvZGg4VA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt5vcw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 11:06:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAm0Go1647480; Tue, 29 Sep 2026 11:05:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y95hr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 11:05:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TB5uoE50659716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 11:05:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2685C20049;
 Tue, 29 Sep 2026 11:05:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C979920040;
 Tue, 29 Sep 2026 11:05:54 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 29 Sep 2026 11:05:54 +0000 (GMT)
Date: Tue, 29 Sep 2026 16:36:05 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Showta Ishizaki <zakinko@snowrabbit.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PATCH] hw/ppc/spapr: Add the "rtas-version" property to /rtas
Message-ID: <20260929161126.2679fec2-3f-amachhiw@linux.ibm.com>
Mail-Followup-To: Showta Ishizaki <zakinko@snowrabbit.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260929094138.16A18C92A0@bambi.snowrabbit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929094138.16A18C92A0@bambi.snowrabbit.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2vt286gAcCm4pO0VO948N9y7VLDJvaTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX7/zzDdXMIeS2
 dP9AviP5hVusDWdqqKGI+pcTCAnXvIk8B7eEpDDfG0NSUHpCAj9o6XD/KWZKw4t4CvbNBkKkq2D
 EJdlva4jucdxI0Clxr2YIO/ZbvHf9Q79cH9+E1gK02yu8xZ/ufgXIYNQ60gNMk2m3fH/oiP+wOs
 HateK0Ftv1CI1JBnfdfrqLFHbxes/RDn+YnzLghKux3JoR0wehI5j0vzeJuFyMA/5F2BzLkOLEZ
 XAChyVnnmmRxQu9K013zER/aCR0wyOpmwfV3zpfaZDslGEr1cM6ONL6mZGQa6DFiz9GuN+UY5XL
 J/ta1LgyH9G0f9g6O6Fps6QlsDX7S1BvMbcWlTykSveEX2KpzlmRBwmM3k4fTWYcTfKT9yJCr2g
 IR+Ga8Fo9ms4wpXpjdj9lvMScTdTpLbPzEmKD34PJmq0VzbnGstRPyCUydaj3LAPEKMz1I2LKmf
 TuR0Q7Ap8AGqcBsCDWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX5/6+B1T/XHhO
 9nYGEwus0S0qwvkn0UjH/voNp99CtgwcU6kXl/4CxOfEIqd5XThu4/DioZQTDlU1B5gql4P8ToY
 n9Lj3mD6e9psklm4Z4H2vFSmoE87Igo=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abb9b98 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ixqt2FsUAAAA:8
 a=L9C5IM_eAAAA:8 a=VnNF1IyMAAAA:8 a=LEruXmYIRbEZDVLLkOEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=wbNHd7AAyUN6gYWAVcba:22 a=d8_PwHeUR2dB5DzxAQPm:22
X-Proofpoint-GUID: IUDqBCJzOktC7WKsA2evhiKG2ZccFis_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290044
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 2026/09/29 06:04 PM, Showta Ishizaki wrote:
> LoPAR requires every property listed in its table of /rtas device tree
> properties to be present before the OS is booted (R1-7.2.6-3 and Table
> 7.4 in LoPAR 2.9; the same requirement is in LoPAPR 1.1). One of them
> is "rtas-version", an integer encoding of the RTAS interface version,
> and LoPAR says it describes version 1 of that interface.
> 
> spapr_dt_rtas() sets "rtas-size", "rtas-error-log-max" and
> "rtas-event-scan-rate" but never "rtas-version", so a client that reads
> it finds no RTAS: NetBSD's RTAS driver fails to attach when the
> property is absent.
> 
> Set it to 1, the version LoPAR describes.

The fix looks correct and the motivation is well explained.  I do see that PAPR
v10.60 [1] does mention:

  "R–7.2.6–3.  The OF properties listed in Table 20, “OF Device Tree Properties”
  must be in the /rtas device tree node prior to booting the OS"

And in Table 20:

“rtas-version” : An integer encoding of the RTAS interface version.  This
		 document describes version 1

Nit: The existing QEMU spapr codebase consistently references the spec as "PAPR"
rather than "LoPAR"/"LoPAPR".  I would prefer the commit message reference PAPR
as the primary spec, with LoPAR as secondary if you want to retain both
citations.

[1] https://openpowerfoundation.org/specifications/papr/

> 
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
> ---
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
> index 9acda15d4f..676d3b4ea1 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -830,6 +830,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
>  
>  #define RTAS_EVENT_SCAN_RATE    1
>  
> +/* The interface version LoPAR 2.9 Table 7.4 describes */

As mentioned above, I think the comment should refer to PAPR instead.

> +#define RTAS_VERSION            1

Code change itself is good.  Tested it on a nestedv2 KVM guest and with this
patch the property is present as expected which was not there without the
patch.

  Without patch
  =============
  # lsprop /sys/firmware/devicetree/base/rtas/rtas-*
  /sys/firmware/devicetree/base/rtas/rtas-error-log-max
  		 00000800 (2048)
  /sys/firmware/devicetree/base/rtas/rtas-event-scan-rate
  		 00000001
  /sys/firmware/devicetree/base/rtas/rtas-size
  		 0000085c (2140)

  With patch
  ===========
  # lsprop /sys/firmware/devicetree/base/rtas/rtas-*
  /sys/firmware/devicetree/base/rtas/rtas-error-log-max
  		 00000800 (2048)
  /sys/firmware/devicetree/base/rtas/rtas-event-scan-rate
  		 00000001
  /sys/firmware/devicetree/base/rtas/rtas-size
  		 0000085c (2140)
  /sys/firmware/devicetree/base/rtas/rtas-version
  		 00000001

With the above suggested nits taken care of, please feel free to add:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit


