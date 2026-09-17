Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD83FC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76w9-0000Bc-Bn; Thu, 17 Sep 2026 03:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x76vz-0000Au-Df; Thu, 17 Sep 2026 03:53:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x76vx-0006JJ-UI; Thu, 17 Sep 2026 03:53:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H62Uvd543214; Thu, 17 Sep 2026 07:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OHIf+A
 07gaxnsgdI3YzFqP1HN+IbkV35ZK3wGfX8kMI=; b=BaQfbWiSKrshAW5xogadIE
 JzfTgQTU5wQXuebhoK5EdYZZnU05pID1ovNhrCgAYG4TP8nB9Nvm8/BjjFriwAR/
 pldA27bTT47N6gIYJ3ny46mSuZEVZPdesOxX/GnYZoK9K/LNKVz8a+dkCvy1y76D
 v6Zz0T3wH4RMdNX3U7bJDImDb26SghfLckHhddyxCaUXMn73LDVyFMbVEtuMd6o4
 A6QpaIqp/NacU/4yKkjCDDCwv7dDHFQpFM1Ms1xjuAkYZoTXK/z/qh6EF/PuqnGt
 pNaFtGmH15c0x6bAvZ/CijHGlsZxMvkkMtFZ++NWr/1KpB6W6pMUFZUmqeb5wmhw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e8r33-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:53:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H652ad2678179; Thu, 17 Sep 2026 07:53:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa1a4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:53:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68H7rNOH41615642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 07:53:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 075592004B;
 Thu, 17 Sep 2026 07:53:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5AA420043;
 Thu, 17 Sep 2026 07:53:22 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 07:53:22 +0000 (GMT)
Message-ID: <55e69bf5-6a53-41e7-a742-56e91b2fbb1c@linux.ibm.com>
Date: Thu, 17 Sep 2026 09:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] s390x/sclp: Reject short headers in PV case
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Janosch Frank <frankja@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-10-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfX0n2ggt3iKCg0
 K4LPW3X0oGoQdjtdsHHK+DBInZn4LI24H1TkGA+7WDrxVB8SAKNG7S77fQk0MjhqzoopGqIZdt1
 OAEiLHU0VE11n+dvlVUZ1ubBi5iU1Hbo5c/QdJZR+xLQjF31tsq5KfruPpUzX+zVmc0jEyZZZpg
 w2HEnGbGeeZQ+0+ok0NdT63Xk3NAVmFHVbBKVf/Irr4WvwXpNeFxxmQOi+ZvxDt9I+NyJrRkxWl
 ivAhwzS7FHcmLCT5gSi19LcRqDE/6/5eeY6yYUByJOH6tTg+UT0xFnkzqLT0lCyDJImK/71ybNF
 ShXp11RwNkf+0tVIXb+Zg+g3Fm1H71lqQ++WR2Zp1/E2WGQTjFjvSocWMQiqqh5KjovN87NzkMa
 UOnD1HMMZpWPzCOlUlBJg/jyr0mYPaZeOJtZt44M8kmQS5oJ9nK1xIGAYoPJtTufiVSFJrqojuv
 g3ZqvPe1LrPH9z/qS1w==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab9c77 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=APe_KEuA6KuHD-nQycYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3cHHR4-jzY7tHIWbLvNGhvvbsdbqTfnt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfX7WcEutzeXIP+
 q2LOQqnvoCmGr4MkNo+3NwiWrTRHAU8vQcYAG/shA1EsnWrqwa90AIlq45FEWh1m+OR7cUFUxb9
 3HD6ZPx5RFOD/evzHIbDAalTnSyD9Uc=
X-Proofpoint-GUID: 3cHHR4-jzY7tHIWbLvNGhvvbsdbqTfnt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170101
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 16.09.26 um 22:32 schrieb Eric Farman:
> An invalid length in an SCCB header correctly generates a specification
> exception for the regular (non-PV) codepath that processes an SCLP
> instruction intercept. The PV case doesn't, even though such a thing
> should already be sanitized. Since a short length will cause problems
> later down the line with the storage that will be allocated based on
> that size, put up a defensive check and return if it is too short.

I think the ultravisor will already sanitize this, but better save than
sorry

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> 
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Fixes: c1db53a591 ("s390/sclp: read sccb from mem based on provided length")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/s390x/sclp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index d8b655efcc..ad8129a5d8 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -277,6 +277,11 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
>   
>       s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
>   
> +    /* Do nothing if the header appears malformed */
> +    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
> +        goto out_no_write;
> +    }
> +
>       work_sccb = g_malloc0(be16_to_cpu(header.length));
>       s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
>                            be16_to_cpu(header.length));
> @@ -290,6 +295,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
>   out_write:
>       s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
>                             be16_to_cpu(header.length));
> +out_no_write:
>       sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>       return 0;
>   }


