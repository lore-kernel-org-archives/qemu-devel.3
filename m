Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EA9C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwFGJ-0003HW-T2; Tue, 18 Aug 2026 04:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1wwFGI-0003HK-Q6; Tue, 18 Aug 2026 04:33:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1wwFGH-0001OI-77; Tue, 18 Aug 2026 04:33:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HM1eAY2668958; Tue, 18 Aug 2026 08:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uJiITp
 5OdacfvlAKm1GyU8b9XYQjit7Nw+0c8QR1wzw=; b=n6DGSMEyUPvGbfjqd9TAmP
 ShSHqXWjN3tVdEP2oabFn0kT0jzpblnNTz7jpAJE+if7W8XNM1fpoxoOhNUFOo3j
 z0E/BMVxD8d14TVeM6pW+XSZ4KPDk2Zf9hn9AMhUZzn4z9CANZaE3D7PT4fB6n9a
 dQqUZlKCUduyvtl+J4Tzq2d+qg9uudhO2jQpFEc5QItfjFIeTH5ee6KdzF++NO3B
 Ee4FRj9D1NbJFcsL/D4/Je7wqNtAOFuJ2+56X2K65cVHAbr81843nH2vaPmY557e
 4o7brjDgrsHfQgnt9yzUn0UY9AyTg7fKVzXIVmbdgEzdFvVJqfj42bcBVDlQpGpA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt6j20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 08:33:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I8QI9x010801;
 Tue, 18 Aug 2026 08:33:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ya00t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 08:33:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67I8XQiV15860112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 08:33:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC31020040;
 Tue, 18 Aug 2026 08:33:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28F632004B;
 Tue, 18 Aug 2026 08:33:24 +0000 (GMT)
Received: from [9.124.210.82] (unknown [9.124.210.82])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 08:33:23 +0000 (GMT)
Message-ID: <cc5ce9c1-eb37-47cc-9418-e66cf0ce1059@linux.ibm.com>
Date: Tue, 18 Aug 2026 14:03:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] MAINTAINERS: add dedicated PowerPC RAS section
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, npiggin@gmail.com, mahesh@linux.ibm.com
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
 <20260714164745.573141-3-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260714164745.573141-3-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a8418db cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=S56xvJB5AAAA:8 a=cP87xPRPmzi_D9xtnbwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2MiBTYWx0ZWRfXyvzO0W223Jho
 44Qtr1Cjmy2grjHwv/a6V/FlIUkJmyqK5i0btqAULj8lStJe7cu2pPFqLAws37evB4T9vf2+7qF
 yk5AZityxH/jePow2kmMYSeWvnvPJQE=
X-Proofpoint-GUID: bFG9UHTI_9PptPIcoUXajtLPWT1yAuMU
X-Proofpoint-ORIG-GUID: FsRW9McjUpw0jcOWFOWLNWiPcwCkQRBX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2MiBTYWx0ZWRfX4qhlqaNh8FtK
 YzfOm+7iFUO2LQP0TsMMt5Hj/MtyTut5G524Jukytq5rnyMvdujfpdco1ELFOi3fTorYqZaNluA
 +6Jokip2d9191KTJR5SiiRkSR/BwEXzUII8e5ROWTjOTZXpZm7sSp000HNh+aMuCWnGZ5EQY9Jk
 Vfy/8fjUhWCPWEPYxF1dmwQujYoc7vbmWCLMjFfKIFvOUB1mcIb0/9ShJ6asbVAD4OJWLMmhuVE
 q11xTBjYRyBIUc7FvJAavwTiAdjN09JKjuIR3AU6n9i1hBBjxMpibglsg6H7x7fAHXRoU8Kc3Oo
 FAUJRll+kzm3Gmhy+69pvKNzHF7kfbw+SLBSCneZ5y7ntZw9qkyLSidXiPmZgoIKi6eEoh8zCOB
 bvaIlYZTNQtdIkk0hoapRz5l+GQ0uyWRWih0K3GuIYwTMn4DTIHPMdtUegcDjR2BEsqcbjzikqw
 6/hp5ZfQ0ps/pK1mM1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180062
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 14/07/26 22:17, Shivang Upadhyay wrote:
> Introduce a new "PowerPC RAS (Reliability, Availability and
> Serviceability)" entry in the PowerPC Machines block, replacing the
> existing Fadump/MPIPL sections. Retaining the maintainer and
> reviewer entries from Fadump/MPIPL sections for this broader umbrella.
>
> Additionally adding spapr_events.c, as it implements RTAS error logging
> infrastructure and spapr_pci_vfio.c, since its all EEH related code.
>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   MAINTAINERS | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e25df9493c..4a010d4807 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1745,6 +1745,21 @@ F: include/hw/ppc/vof*
>   F: pc-bios/vof/*
>   F: pc-bios/vof*
>   
> +PowerPC RAS (Reliability, Availability and Serviceability)
> +M: Aditya Gupta <adityag@linux.ibm.com>
> +R: Sourabh Jain <sourabhjain@linux.ibm.com>
> +R: Hari Bathini <hbathini@linux.ibm.com>
> +L: qemu-ppc@nongnu.org
> +S: Maintained
> +F: hw/ppc/spapr_events.c
> +F: hw/ppc/spapr_fadump.c
> +F: hw/ppc/spapr_pci_vfio.c
> +F: hw/ppc/spapr_rtas_ras.c

As there is a suggestion to drop the 1/3, some of the above file names 
need to be
corrected accordingly. The rest of the changes look good to me.

Feel free to include in 2/3 and 3/3:

Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>


> +F: hw/ppc/pnv_mpipl.c
> +F: include/hw/ppc/spapr_fadump.h
> +F: include/hw/ppc/pnv_mpipl.h
> +F: tests/functional/ppc64/test_fadump.py
> +
>   RISC-V Machines
>   ---------------
>   OpenTitan
> @@ -3361,23 +3376,6 @@ F: scripts/coccinelle/remove_local_err.cocci
>   F: scripts/coccinelle/use-error_fatal.cocci
>   F: scripts/coccinelle/errp-guard.cocci
>   
> -Firmware Assisted Dump (fadump) for sPAPR (pseries)
> -M: Aditya Gupta <adityag@linux.ibm.com>
> -R: Sourabh Jain <sourabhjain@linux.ibm.com>
> -S: Maintained
> -F: include/hw/ppc/spapr_fadump.h
> -F: hw/ppc/spapr_fadump.c
> -F: tests/functional/ppc64/test_fadump.py
> -
> -Memory-Preserving Initial Program Load (MPIPL) for PowerNV
> -M: Aditya Gupta <adityag@linux.ibm.com>
> -R: Hari Bathini <hbathini@linux.ibm.com>
> -R: Sourabh <sourabhjain@linux.ibm.com>
> -S: Maintained
> -F: include/hw/ppc/pnv_mpipl.h
> -F: hw/ppc/pnv_mpipl.c
> -F: tests/functional/ppc64/test_fadump.py
> -
>   GDB stub
>   M: Alex Bennée <alex.bennee@linaro.org>
>   R: Philippe Mathieu-Daudé <philmd@mailo.com>


