Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7ADC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9s0L-0003PT-Ea; Tue, 29 Apr 2025 16:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9s0J-0003PH-Uf
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:56:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9s0I-00022r-CF
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:56:35 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TEubJG006215;
 Tue, 29 Apr 2025 20:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iXSVds
 dzgU0RagZBdn39btMvP/PDkBjyxtZ/KILlhQ8=; b=tlZQMkEMmkbrMmgirgUdDP
 CceraQH7Sg9hBuvMFI95Z+7QHSzToFLU9nIf16mM6mUryI1ELudL0QwrAhqagFmT
 b/uwNLItIjSc2UGinceevC+gHkKlP6w2vSea5i1OJUvMn+a5A01zxCy+JxOVvNNm
 fU+gWR7e/oigZ1H61w3O3wvRfZllN5s9KsTEYZYRX0a2d+0ZhbdPBoypD9bk39K+
 2NZ7IGyZEkoZ+CdJ2YBFKYllJe1ELjctDweUsm86wWRaSKpkGpCMHziI3VcgfN4U
 +c07bJKXzYRHr8Mb4NEJXqtdTS5J2WEyXuM0YjpG/5Awsh+cqhP2kTgQ80LFOrRQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahs9dech-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 20:56:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53THpFQ3001791;
 Tue, 29 Apr 2025 20:56:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bammybt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 20:56:29 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53TKuTxH18088574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 20:56:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53B7E5805D;
 Tue, 29 Apr 2025 20:56:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3B3D58054;
 Tue, 29 Apr 2025 20:56:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 20:56:28 +0000 (GMT)
Message-ID: <e7c926f4-7bc7-4de4-8cde-54449718a2c0@linux.ibm.com>
Date: Tue, 29 Apr 2025 16:56:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] qdev: make release_prop_array() free array and
 idempotent
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
 <20250429140306.190384-5-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250429140306.190384-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=68113cfe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=_znVokOWLvaMByaYaMkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pPf1nbhRGJT1T-Nqd_yyludIVJzd7cSi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1MiBTYWx0ZWRfX13mdBpKhI8uq
 GJoqqjOgma+uSlWE8NUDEGq+ezuq8PZ9Nwl8LFfMom8RhXfZgCGcANFmk4TOzy10kKXRKBLRSyb
 PZw3qktiRYBofOTHtN8vyEBUQIV0DQXEU+oUcw60+RExhJZyZLpQrNYclSVArO2lkiYAMnCtvH/
 HyJG1voBGlQbBDzXil6gpI9A8bxzPty0tsNt9lB19VsdM+YHUQuZnQpm7Ml12j9vUR+LNJwgRrc
 CazY99xKBnBiMmJcQX/EnkNipWfo0P49cV4FgQpJQvjeLuoqIGR8hErSwo/mGZ5qHm3/yublAvG
 aYFB6FAlCJaykhaD5kzXed9bGXswUPls2KAuZs1LU4xvVGsSjm/+tq4Dzm0YU4MJf1gpWrZkPkY
 s+tpFpljwcXxSQrZb1wC1XCvdS65Es0jkGCc2ukx9b+0SLnxcbCn1C7ft7SXpWwqiguZ1Eon
X-Proofpoint-GUID: pPf1nbhRGJT1T-Nqd_yyludIVJzd7cSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxlogscore=803 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 4/29/25 10:03 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Fix a memory leak, and allow it to be called multiple times safely.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/qdev-properties.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index bad111833c..7a53c85887 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -620,15 +620,16 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
>       char *elem = *arrayptr;
>       int i;
>   
> -    if (!prop->arrayinfo->release) {
> -        return;
> +    if (prop->arrayinfo->release) {
> +        for (i = 0; i < *alenptr; i++) {
> +            Property elem_prop = array_elem_prop(obj, prop, name, elem);
> +            prop->arrayinfo->release(obj, NULL, &elem_prop);
> +            elem += prop->arrayfieldsize;
> +        }
>       }
>   
> -    for (i = 0; i < *alenptr; i++) {
> -        Property elem_prop = array_elem_prop(obj, prop, name, elem);
> -        prop->arrayinfo->release(obj, NULL, &elem_prop);
> -        elem += prop->arrayfieldsize;
> -    }
> +    *alenptr = 0;
> +    g_clear_pointer(arrayptr, g_free);
>   }
>   
>   /*
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


