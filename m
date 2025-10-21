Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3CCCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBD60-0000pj-2R; Tue, 21 Oct 2025 10:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBD5m-0000ke-VE; Tue, 21 Oct 2025 10:12:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBD5k-0001ee-HM; Tue, 21 Oct 2025 10:12:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LCDhB2001179;
 Tue, 21 Oct 2025 13:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cwImrI
 ZkdEztsUTOZiZHWIUdy0Yh1BFQJW+Pg4Ay8sk=; b=pu/8MhRQ3wURxI81YLuigO
 A5h/fOIOw0sm7erlsyaSl82w52zlGxh1Pb1cGgN4zI1g8WLhCyRxLhovWUiuRgNk
 gy1Cvnf6HLtXcE6Iq3Qw4Ttq40iuMwXufzB2MqxRSFrjwFWFWu6dFeCGL9evehTk
 SJE7NrvrJTXVUa7//fTmkgR7qzgyU9Gsq54OEju17obQhuItNBR9tX+g0fv9cMFV
 Ye6QMaYiW8KR6CYRtRj6jc4YRO+i96p9F37S0AI9hGaM4jS0Gx3WkET4O8of3wTc
 P9Wq4mCs/ItazHHJADB11ClauCxWVhXAIR8gNG2WWyjdVcTuqaXILToL3sSMzokg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f778a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:26:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LDFEL4001474;
 Tue, 21 Oct 2025 13:26:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f7784-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:26:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LCj5wB002324;
 Tue, 21 Oct 2025 13:26:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejar0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:26:34 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LDQX5663832428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 13:26:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E5B75805F;
 Tue, 21 Oct 2025 13:26:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A19E758043;
 Tue, 21 Oct 2025 13:26:30 +0000 (GMT)
Received: from [9.39.25.124] (unknown [9.39.25.124])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Oct 2025 13:26:30 +0000 (GMT)
Message-ID: <602c19bc-bed9-43c2-b98c-491b75921604@linux.ibm.com>
Date: Tue, 21 Oct 2025 18:55:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] hw/ppc/spapr: Inline spapr_dtb_needed()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251021084346.73671-1-philmd@linaro.org>
 <20251021084346.73671-5-philmd@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251021084346.73671-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f78a0b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Rnii0OVWSoyPs2-5-ZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: OJPBdmFxcI1nz1-YSuMhFXb9JA2ldvK7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+kRD5Uf7tfgT
 rTBvnuRFfZd8npAFBRc2yNrzDtXpgb6Iwcr1HCRkIUgMg01u1GXmnPf20fsmwGgXpU4T6rAlqP8
 ccJ4nCx/TqKiwng1D8ohreXFQSkuAj2oUfELEeFIYAYxda/cqPSPm4Qzglh3j4CgF2RhEgyP9WG
 KFKwXruEDuYbHbGCchKm9dXLRAWVtsyy/m3VmeOmBThg2vGELmRjwtjlXrDLBboHqTvXAEr4nRY
 e+kkOVgEom1fdQMoO1N80X2M1Vi6AeiXcZAc1tJz3gDV+N+hMtrUCE9Qff9Xx9MGQKWy/v7GZOt
 dHNx5DT1rsdMf3sombt/84+xlYDiSt1M/Gha7pcL7oFLVWl3qMHhZk7VZ1IpZcJrf8PsakhmbLK
 DW7fMXc/TkWkxIbUrWBvHs2Uca+afg==
X-Proofpoint-ORIG-GUID: dTGD7Ser0z01z-nMZKlhEMcmtjKsd02O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hey Philippe,
The commit message says that this commit is inline-ing 
spapr_dtb_needed(), but it is actually removing it. I think it's better 
to convey that in the commit message.
Or did I miss something ?

On 10/21/25 14:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/spapr.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 458d1c29b4d..ad9fc61c299 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2053,11 +2053,6 @@ static const VMStateDescription vmstate_spapr_irq_map = {
>       },
>   };
>   
> -static bool spapr_dtb_needed(void *opaque)
> -{
> -    return true; /* backward migration compat */
> -}
> -
>   static int spapr_dtb_pre_load(void *opaque)
>   {
>       SpaprMachineState *spapr = (SpaprMachineState *)opaque;
> @@ -2073,7 +2068,6 @@ static const VMStateDescription vmstate_spapr_dtb = {
>       .name = "spapr_dtb",
>       .version_id = 1,

Does this version number need to be incremented ?

Regards,
Chinmay

>       .minimum_version_id = 1,
> -    .needed = spapr_dtb_needed,
>       .pre_load = spapr_dtb_pre_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(fdt_initial_size, SpaprMachineState),

