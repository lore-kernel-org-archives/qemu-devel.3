Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF00C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 19:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYVzn-0003cE-3L; Mon, 29 Jul 2024 15:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sYVzj-0003Xp-CD; Mon, 29 Jul 2024 15:25:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sYVzg-0000qO-MZ; Mon, 29 Jul 2024 15:25:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TIQpA3011297;
 Mon, 29 Jul 2024 19:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 Jd37fC7bJ7ZE1R3q4RcGCxdZK6FNcUCYA7pskBVkzgo=; b=CddwT9pNLuZM48qi
 jWOYJzgcoAjEXVkRwWLwBadNCsrrJ6QfXoldnCZ4hB+9q2ZvkYfvmmvAzp+O+Qx+
 VzDgb8+qZKsCp4i5a/Q4WeBgFJMVG4kDjxB83Q8ZmRjwEAFjGZm9vFCxfwrzxZF/
 qcGh3BLJeC+r7xumUDpPDo5COkz4paelEafP/nFGX0b8560nGmncoqxRDf6PQ4t9
 sSJ90j8hY+QjvgjXYbvr0U8mN4Ea94KU5z1JCbK4qPY81z+bK1t8mJ3pSiQMLkMM
 BM1LVzXm0CxjRVZgC2w/mtHhPGaJKJSH71IaI8D0MWHkOV47MQgK/0Au4eM11RXR
 yL/7iw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pdrjrga3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 19:25:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46TJP9ZU010864;
 Mon, 29 Jul 2024 19:25:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pdrjrg9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 19:25:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46THdOtU018867; Mon, 29 Jul 2024 19:25:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pgahb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 19:25:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46TJP5xe27525632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jul 2024 19:25:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8538758067;
 Mon, 29 Jul 2024 19:25:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E65C758052;
 Mon, 29 Jul 2024 19:25:04 +0000 (GMT)
Received: from [9.67.113.167] (unknown [9.67.113.167])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jul 2024 19:25:04 +0000 (GMT)
Message-ID: <4f617078-e88d-4006-a56b-6bed684e577b@linux.ibm.com>
Date: Mon, 29 Jul 2024 15:25:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
To: David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net
References: <20240726203646.20279-1-walling@linux.ibm.com>
 <877cd7qsnj.fsf@pond.sub.org>
 <00bc2317-dbba-43b3-b355-ddce45b5dfc6@redhat.com>
 <87a5i0cmht.fsf@pond.sub.org>
 <f42a8801-f49d-48b6-84a4-467c89e78657@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <f42a8801-f49d-48b6-84a4-467c89e78657@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qufk-d4WD7ABu0yv2zC4HK0hB1VCb8RC
X-Proofpoint-ORIG-GUID: EAAvR76Vxy0-4zO64a7MFc1GuI2isGBa
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_16,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 7/29/24 10:22 AM, David Hildenbrand wrote:
>>>> The simplest way to address 4 is to tack 'if': 'TARGET_S390X' to
>>>> @deprecated-props.
>>>>
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index 09dec2b9bb..0be95d559c 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -253,7 +253,7 @@
>>>    ##
>>>    { 'struct': 'CpuModelExpansionInfo',
>>>      'data': { 'model': 'CpuModelInfo',
>>> -            '*deprecated-props': ['str'] },
>>> +            '*deprecated-props' : { 'type': ['str'], 'if': 'TARGET_S390X' } },
>>>      'if': { 'any': [ 'TARGET_S390X',
>>>                       'TARGET_I386',
>>>                       'TARGET_ARM',
>>>
>>>
>>> Should do the trick, right?
>>
>> Yes.  Break the line before 'if', please.
> 
> Ack
> 
> [...]
> 
>>
>> Questions?
> 
> As clear as it can get, thanks! :)
> 
> That would leave us with:
> 
> 
>  From 8be206168e31b9c3ff89e2b99c57a85d30150194 Mon Sep 17 00:00:00 2001
> From: Collin Walling <walling@linux.ibm.com>
> Date: Fri, 26 Jul 2024 16:36:46 -0400
> Subject: [PATCH] target/s390x: move @deprecated-props to CpuModelExpansion
>   Info
> 
> CpuModelInfo is used both as command argument and in command
> returns.
> 
> Its @deprecated-props array does not make any sense in arguments,
> and is silently ignored.  We actually want it only as return value
> of query-cpu-model-expansion.
> 
> Move it from CpuModelInfo to CpuModelExpansionType, and document
> its dependence on expansion type property.
> 
> This was identified late during review [1] and we have to fix it up
> while it's not part of an official QEMU release yet.
> 
> [1] https://lore.kernel.org/qemu-devel/20240719181741.35146-1-walling@linux.ibm.com/
> 
> Message-ID: <20240726203646.20279-1-walling@linux.ibm.com>
> Fixes: eed0e8ffa38f ("target/s390x: filter deprecated properties based on model expansion type")
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> [ david: - add "Fixes", adjust description, reference v3 instead
>           - make property s390x-only and non-optional ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   qapi/machine-target.json         | 19 +++++++++++--------
>   target/s390x/cpu_models_sysemu.c | 29 ++++++++++++++++++-----------
>   2 files changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index a552e2b0ce..00bbecc905 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -20,17 +20,11 @@
>   #
>   # @props: a dictionary of QOM properties to be applied
>   #
> -# @deprecated-props: a list of properties that are flagged as deprecated
> -#     by the CPU vendor.  These properties are either a subset of the
> -#     properties enabled on the CPU model, or a set of properties
> -#     deprecated across all models for the architecture.
> -#
>   # Since: 2.8
>   ##
>   { 'struct': 'CpuModelInfo',
>     'data': { 'name': 'str',
> -            '*props': 'any',
> -            '*deprecated-props': ['str'] } }
> +            '*props': 'any' } }
>   
>   ##
>   # @CpuModelExpansionType:
> @@ -248,10 +242,19 @@
>   #
>   # @model: the expanded CpuModelInfo.
>   #
> +# @deprecated-props: a list of properties that are flagged as deprecated
> +#     by the CPU vendor.  The list depends on the CpuModelExpansionType:
> +#     "static" properties are a subset of the enabled-properties for
> +#     the expanded model; "full" properties are a set of properties
> +#     that are deprecated across all models for the architecture.
> +#     (since: 9.1).
> +#
>   # Since: 2.8
>   ##
>   { 'struct': 'CpuModelExpansionInfo',
> -  'data': { 'model': 'CpuModelInfo' },
> +  'data': { 'model': 'CpuModelInfo',
> +            'deprecated-props' : { 'type': ['str'],
> +                                   'if': 'TARGET_S390X' } },
>     'if': { 'any': [ 'TARGET_S390X',
>                      'TARGET_I386',
>                      'TARGET_ARM',
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 94dd798b4c..6c8e5c7260 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -174,15 +174,11 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>                                   bool delta_changes)
>   {
>       QDict *qdict = qdict_new();
> -    S390FeatBitmap bitmap, deprecated;
> +    S390FeatBitmap bitmap;
>   
>       /* always fallback to the static base model */
>       info->name = g_strdup_printf("%s-base", model->def->name);
>   
> -    /* features flagged as deprecated */
> -    bitmap_zero(deprecated, S390_FEAT_MAX);
> -    s390_get_deprecated_features(deprecated);
> -
>       if (delta_changes) {
>           /* features deleted from the base feature set */
>           bitmap_andnot(bitmap, model->def->base_feat, model->features,
> @@ -197,9 +193,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>           if (!bitmap_empty(bitmap, S390_FEAT_MAX)) {
>               s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_enabled_feat);
>           }
> -
> -        /* deprecated features that are a subset of the model's enabled features */
> -        bitmap_and(deprecated, deprecated, model->features, S390_FEAT_MAX);
>       } else {
>           /* expand all features */
>           s390_feat_bitmap_to_ascii(model->features, qdict,
> @@ -213,9 +206,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>       } else {
>           info->props = QOBJECT(qdict);
>       }
> -
> -    s390_feat_bitmap_to_ascii(deprecated, &info->deprecated_props, list_add_feat);
> -    info->has_deprecated_props = !!info->deprecated_props;
>   }
>   
>   CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> @@ -226,6 +216,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>       CpuModelExpansionInfo *expansion_info = NULL;
>       S390CPUModel s390_model;
>       bool delta_changes = false;
> +    S390FeatBitmap deprecated_feats;
>   
>       /* convert it to our internal representation */
>       cpu_model_from_info(&s390_model, model, "model", &err);
> @@ -245,6 +236,22 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>       expansion_info = g_new0(CpuModelExpansionInfo, 1);
>       expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
>       cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
> +
> +    /* populated list of deprecated features */

s/populated/populate

> +    bitmap_zero(deprecated_feats, S390_FEAT_MAX);
> +    s390_get_deprecated_features(deprecated_feats);
> +
> +    if (delta_changes) {
> +        /*
> +         * Only populate deprecated features that are a
> +         * subset of the features enabled on the CPU model.
> +         */
> +        bitmap_and(deprecated_feats, deprecated_feats,
> +                   s390_model.features, S390_FEAT_MAX);
> +    }
> +
> +    s390_feat_bitmap_to_ascii(deprecated_feats,
> +                              &expansion_info->deprecated_props, list_add_feat);
>       return expansion_info;
>   }
>   

Eh, just a small nit above due to a typo I made.  Other than that, gave
it all another run-through just in case and everything is still good.

-- 
Regards,
  Collin


