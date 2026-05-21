Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23E2CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzqc-0003oj-MS; Thu, 21 May 2026 05:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wPzqa-0003nz-6h; Thu, 21 May 2026 05:37:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wPzqY-0005og-L0; Thu, 21 May 2026 05:37:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L90AO1605415; Thu, 21 May 2026 09:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=z8YR7s
 t9eREWCPa7QBw+VU0/c/ImZKv3E5xw63zjW1w=; b=gM41+T4/uRPLzq77I5QW24
 zmoQBo8g19kpmVpKz5pY5w/0qbyVcN3YBB07VSixECkLuHtW2+BYBD0hgGnYJ9QO
 PwYO/qwmwHXn5cd7PKZs+P7iIisRA+pvImsmuQrxczeKjEsaFcIIU70NO//zUlbE
 T7GgUsW8E2rjCHS3/1P1DndM/oxK+R3fj1NSnNEaPWCbr4WLiRo/bC3nOVewqFHH
 c9DbpcgTSGtCKNV57u6scpkNhk0nQqmAB8fPCweRh0j6jv0aPmNnppeBurlQy/ZA
 4n6T8mBvfZncBi7xkXSVzWGDnoWYgwGTBtfZUPB/U5JEWLb3qDoBJvDfkdEMhlLg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h7565fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:37:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L9OBaF030963;
 Thu, 21 May 2026 09:37:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyb5ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:37:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64L9bamH31130342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 09:37:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A96358067;
 Thu, 21 May 2026 09:37:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 222DE5804B;
 Thu, 21 May 2026 09:37:34 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 May 2026 09:37:33 +0000 (GMT)
Message-ID: <91bb6981-5115-4ef8-9102-a05f7ec72023@linux.ibm.com>
Date: Thu, 21 May 2026 15:07:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/39] MAINTAINERS: Drop stale F: from "sPAPR (pseries)"
Content-Language: en-GB
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-17-armbru@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260521080511.999266-17-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0ed262 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=W1OEiVIup1d-Y_K4MFEA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: W-Wv-a8lqCHp2adE0nF5A8wrHiEZr0lq
X-Proofpoint-GUID: diaF4zHbGfeciC_PTiQe61GPmCG4HaUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5NSBTYWx0ZWRfX6UCWswZHuKwl
 MKZKnQMw6f8d7QXcdT5P+iyvHahwR4TWmlBFUBhAs05k/39PlosGR1c25jyqSZOyTukH+jAoCD8
 UyCAWpZ/k7VYUkZ146ksJ4JZF6drWJCPaiKwFeaUo3hzgLoGiN67Tmk3h/Evh3sjfHV/i/5qEZg
 oNqyudECvnP7eqoNE2g4pEppieAijO1vCtXX+UYEMOqSHUOtijltKdXB0Kb1vN/l4wayUJKor+L
 SbIKFqNft/Ep1DerIysC2AFCoR5oX8xKs+jau8kpv4kwrddjmKPwXZIsrFN8Nn55HNb16ztI1eq
 F11YNhPxD6SHZu/JL0acCng0QE9NpPsM75S9qq44vPhAiZz0wsPdMhuJmDWsRH5Y/CdPkKLv3ws
 ogihOzQYpK9UJx9MBUbvwDjdbnCbXxVixzPQmJIG1jaM5NQ6MCXxhxiBS7amDdAx3GLKVg8YZSs
 702oRtUg3ZzcLBJTshQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 21/05/26 1:34 pm, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we deleted
> include/hw/ppc/pef.h.  Update it now.
> 
> Fixes: 00a238b1a8 (ppc/pef: switch to use confidential_guest_kvm_init/reset(), 2024-02-29)
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cefd2cbb..87450a84de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1634,7 +1634,6 @@ F: hw/*/xics*
>   F: include/hw/*/xics*
>   F: include/hw/ppc/fdt.h
>   F: hw/ppc/fdt.c
> -F: include/hw/ppc/pef.h

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   F: hw/ppc/pef.c
>   F: pc-bios/slof.bin
>   F: docs/system/ppc/pseries.rst


