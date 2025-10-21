Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F4CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAWT-0000pK-VM; Tue, 21 Oct 2025 07:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBAWR-0000p4-8S; Tue, 21 Oct 2025 07:27:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBAWN-0007Jt-ID; Tue, 21 Oct 2025 07:27:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8GsF5017546;
 Tue, 21 Oct 2025 11:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Tcjchj
 A6/+BVFcTNQO+/OKE///DuvSoP75TVH+UCWyQ=; b=DsnwwVaDJpWC2ZZjtPjUxd
 uCmk20Bf7Yngq1r7jM5xGcffOwGpL9DXj6vfjD0WnsV4K+9MNeAloxUvuDp99L+F
 AwE/FvEPrnf4hfWZE8RHayHm3K9cWVWA87w1ik+7+yU5AsnjyJvQMUDzkNOiwl9/
 Pgka0OsIaFqkE21ic8BNG2MhTlSTwoqDkau6y33rFr3IELHtuHOmXMKubd632sFr
 Kk4SUZv+p5IZ7z3RurnROVX9uVjdNfj4HO22Yzd/6FDF2nnQ4GiuBXq+HH+zbMD6
 FYwf1xAKGbkJ85e0IfuNrjlp032a0R/WcsffUN1Oygi7ZQzd0BID9yCDowLl4JLw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f6p8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:27:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LBIOtk013218;
 Tue, 21 Oct 2025 11:27:13 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f6p8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:27:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LAuTTf014669;
 Tue, 21 Oct 2025 11:27:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s2mm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:27:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LBQxJR29491846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 11:26:59 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1D915805E;
 Tue, 21 Oct 2025 11:27:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 202D958051;
 Tue, 21 Oct 2025 11:27:09 +0000 (GMT)
Received: from [9.79.201.141] (unknown [9.79.201.141])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Oct 2025 11:27:08 +0000 (GMT)
Message-ID: <7f3143bc-505e-4120-938a-fa4bed982f7d@linux.ibm.com>
Date: Tue, 21 Oct 2025 16:57:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] hw/ppc/spapr: Inline few SPAPR_IRQ_* uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251021084346.73671-1-philmd@linaro.org>
 <20251021084346.73671-6-philmd@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251021084346.73671-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f76e12 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=vLoeH9cbTDQAPZaO96UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 2uTicLUVE8LEfvx4Yfdfrn4kf_sw6Wn7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8E/s87B9akSr
 AmdiBld3qK00zSBQtRZFL+sAxBY9zTiOBmZhH7/d8SdTqUpKHQLGIuie3gneg+Q2KzxfH2IQi3v
 T4eCo1/4qguB4dZyZFusZ5o7p0H53cKCYDNPekbvMMpIc+vDzu+YjA1VCT3BEvpd+7Wzrxs7iF3
 Vo3r9y+/iybBFj/0alG4UjuurZcR1wdSuQS4/mtHWljU4wwNQaYeCFV+OZXSxuryOwPVGQTbuf7
 9gNeeexPTVTj0vV2sKzNCHIzexwVsjNAv/8b12URc7iIUPcmpaJUQU2Ulk4fRyXuVetSFHKL6UK
 ykj+8lYEB9EJ2C6aZUL+sbjjTXCIFSvuP40djug+XTZFV8EjqCkbePwZyyZ09nKciT8Jef1tUfh
 Mv6kjIZbMtP7FW/Dtz2NDjejU9ZUZg==
X-Proofpoint-ORIG-GUID: 5CcphESwmciE-fSZgbOPW1R0dGg74zBB
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


On 10/21/25 14:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/spapr_events.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 548a190ce89..892ddc7f8f7 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -1041,16 +1041,14 @@ void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr)
>   
>   void spapr_events_init(SpaprMachineState *spapr)
>   {
> -    int epow_irq = SPAPR_IRQ_EPOW;
> -
> -    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
> +    spapr_irq_claim(spapr, SPAPR_IRQ_EPOW, false, &error_fatal);
>   
>       QTAILQ_INIT(&spapr->pending_events);
>   
>       spapr->event_sources = spapr_event_sources_new();
>   
>       spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
> -                                 epow_irq);
> +                                 SPAPR_IRQ_EPOW);
>   
>       /* NOTE: if machine supports modern/dedicated hotplug event source,
>        * we add it to the device-tree unconditionally. This means we may
> @@ -1061,12 +1059,10 @@ void spapr_events_init(SpaprMachineState *spapr)
>        * checking that it's enabled.
>        */
>       if (spapr->use_hotplug_event_source) {
> -        int hp_irq = SPAPR_IRQ_HOTPLUG;
> -
> -        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
> +        spapr_irq_claim(spapr, SPAPR_IRQ_HOTPLUG, false, &error_fatal);
>   
>           spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
> -                                     hp_irq);
> +                                     SPAPR_IRQ_HOTPLUG);
>       }
>   
>       spapr->epow_notifier.notify = spapr_powerdown_req;
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>

