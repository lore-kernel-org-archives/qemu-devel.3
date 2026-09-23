Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD89FC9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9UlQ-0001V3-Sg; Wed, 23 Sep 2026 17:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9UlP-0001Ul-QU; Wed, 23 Sep 2026 17:44:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9UlN-0003Wt-UK; Wed, 23 Sep 2026 17:44:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NK6iDA4194258; Wed, 23 Sep 2026 21:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BSCtN8
 F69B0TwssFu5iYw1FqdJEsIXIoTmiBWgWyTJM=; b=n2w4gkgA6GjIi/kNwtluAk
 CcLBMSb3U30hRjqMySBZ/IVLYviIty9YghfjPTIOmWPWi1Olez+q7mz9EFwx5Req
 C0CnjQwA6NMSFxGs2Fss3EC+jyqAnCiSotDoSEtkpvjirzNAIGsLCtuwPZ1IHWR/
 3Iqwm9VLX9kgOH+1/NyMVa7HY6aKEeYdiJXno5DTq+AsGASoFZ+jsKSlhSRpe1ko
 +Mq38A+sLCpkayiM1BJAlvTeWyX3GhwjxhjuPkxlkifc7uO4NLH/N6pZj7UaKYJa
 SduJCmBW8ch1HR8a927dxzUHteI6QNx/qbq0YF0IgVimara1zavgmU87NbniuFNw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1n84n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 21:44:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NJmMYG903618; Wed, 23 Sep 2026 21:44:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qjxsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 21:44:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NLiF9v38338898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 21:44:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CB4B58052;
 Wed, 23 Sep 2026 21:44:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B17658056;
 Wed, 23 Sep 2026 21:44:14 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 21:44:14 +0000 (GMT)
Message-ID: <4b4de309-7ba7-45a0-a485-e9474d2732b6@linux.ibm.com>
Date: Wed, 23 Sep 2026 17:44:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Expose pv attribute in QOM
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, brueckner@linux.ibm.com, borntraeger@de.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, david@kernel.org,
 iii@linux.ibm.com, richard.henderson@linaro.org
References: <20260923083406.64128-1-frankja@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260923083406.64128-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uLfY75kP-pSfi2Pigy8OGsqyeclnqoJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA4NiBTYWx0ZWRfX1ZQfke+gIY+W
 ygrZEztwFc5X7xcDJq0ZQmPBuw1FBTLVcpivK+qQjfYmR8ogC/bz7A1Om89ObWciygWOFr8AUO8
 qHymyqSWyAkttvDzskOSxKUTtTtOzIoyfcP/48B8RzGg+LYahVgbQZAfgFFqRjlthFrtL3uQlnE
 cap7v+q+cal7qQ08a7CU8+hcHK73JV2jgX12xilykh5OJV2vmjXJaI6NntXV5Jq4XhDIhc1sfC5
 eCWlLhtAeEOIJPgtcR8A9Ydk/fT7XG04aOnFQVo/Gxzk7rHF9Q8++NeVlkdHjSLHlRyK7/9QCxe
 pHcYIsxgM0BQ4fbDU+hlNWxdwiGs70LqCuDbC2pcttlHG+DY1AottmWMV5vVFacwAy6bnxzefD9
 X0jblrJg8QyVB4tmo9JlFGadDB1V32gWl9oiYlwKlm4bMYe+t68Uns0Pk9+78mmTYFIGSJdGhkq
 qZjScGvpCmf7Cj6xIxg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab44831 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=bfnBeW7mwfn-AX3SpRgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA4NiBTYWx0ZWRfX7BSR8XngAwaz
 D/JoPXrmBZjZUfvZJpXX4SIrzpMuICwpufbk0g7lTWv0wrlolFzcvW90Eh5QkSbPWSWphsl0nut
 cwYDBDDX2TMbStXjbq3WyNRDcsjdoqM=
X-Proofpoint-GUID: uLfY75kP-pSfi2Pigy8OGsqyeclnqoJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230086
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/23/26 4:33 AM, Janosch Frank wrote:
> People doing VM management requested a way to query if a VM is in PV
> or not. This of course does never replace attestation, it's merely
> QEMU's view of the situation.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> CC: Hendrik Brueckner <brueckner@linux.ibm.com>

I wondered for a bit about migration, but seeing as it's fenced for pv I
think the only weird scenario would be migrating to an older QEMU using
a pre-11.2 machine type and go from being able to see the attribute read
'false' to no longer being able to see the attribute with the same qemu
command line.

Do you think that would matter for tooling e.g. do we need tie the
visibility of the property to 11.2+ machine?


> ---
>  hw/s390x/s390-virtio-ccw.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7fb78d8fa1..42ecfa59f3 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -838,6 +838,13 @@ static inline void machine_set_secure_boot(Object *obj, bool value,
>      ms->secure_boot = value;
>  }
>  
> +static inline bool machine_get_pv(Object *obj, Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +
> +    return ms->pv;
> +}
> +
>   /*
>    * S390x-specific global compatibility properties.
>    *
> @@ -919,6 +926,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>                                     machine_set_secure_boot);
>      object_class_property_set_description(oc, "secure-boot",
>              "enable/disable secure boot");
> +
> +    object_class_property_add_bool(oc, "pv",
> +                                   machine_get_pv,
> +                                   NULL);
> +    object_class_property_set_description(oc, "pv",
> +            "protected virtualization state (read-only)");
>  }
>  
>  static inline void s390_machine_initfn(Object *obj)


