Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD0FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgi0-0007gq-Uc; Wed, 24 Apr 2024 13:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzghe-0007U2-5L; Wed, 24 Apr 2024 13:46:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzghc-0005pF-4n; Wed, 24 Apr 2024 13:46:41 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OHXclj011114; Wed, 24 Apr 2024 17:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PdqtxYxoJy2JY1FqCJT6mHxCnup1Ruh3xvdfG7phapw=;
 b=dX2rGXp27N9h3+Vy6Pj03lRq9jvlXMUlxTKS8ScDwIF+Qhm3IXvrlUF7K3BZ9Lf7f4nd
 GcUQv1XKdxT7E1WPfuTj3IswZx9VrmfeqMx0f3FvMZ4kROl0f8LlisrIgMCbB9OycaOT
 +bSJm9V+49xemnE3TH45s+gkLfqI8wKJf3iEq6iG9EkwXPO8X3Hh76IMDN6xNi917v7j
 9sbmj1ibh1UzT+cdYAizjiVmE09MkYR6bz6iM/CTQo416KzawHbjakmUL587ig0uDb8c
 uB6Xt8OvK7W/fE0gJWtTWCqb5Bc2gCWzzWzTynlS3PXSKc+IjkGL8fd6ZAqSdLYUZqH0 JA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq6gf01h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 17:46:30 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OHhFMe024616;
 Wed, 24 Apr 2024 17:46:29 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq6gf01gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 17:46:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OG6vxu005341; Wed, 24 Apr 2024 17:46:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3ckthj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 17:46:29 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43OHkQ7346072126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 17:46:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A19B05805A;
 Wed, 24 Apr 2024 17:46:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DDCF58068;
 Wed, 24 Apr 2024 17:46:26 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Apr 2024 17:46:26 +0000 (GMT)
Message-ID: <809ee6ee-e66e-466f-bbf2-93ba7ec1afda@linux.ibm.com>
Date: Wed, 24 Apr 2024 13:46:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats" option
 to cpu model expansion
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-2-walling@linux.ibm.com> <87bk5z5ll9.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87bk5z5ll9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vu384PxIENLHVGwjahlwwrFkIIpWVnWR
X-Proofpoint-GUID: o58Z4HHKHMBrdaVpF4-cBCv7I2Wv4m1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_14,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240077
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 4/24/24 02:19, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> This optional parameter for query-cpu-model-expansion enables CPU
>> model features flagged as deprecated to appear in the resulting
>> list of properties.
>>
>> This commit does not add support beyond adding a new argument
>> to the query. All queries with this option present will result
>> in an error claiming this option is not supported.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  qapi/machine-target.json         | 7 ++++++-
>>  target/arm/arm-qmp-cmds.c        | 7 +++++++
>>  target/i386/cpu-sysemu.c         | 7 +++++++
>>  target/s390x/cpu_models_sysemu.c | 7 +++++++
>>  4 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 29e695aa06..b9da284d2d 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -285,6 +285,10 @@
>>  #
>>  # @type: expansion type, specifying how to expand the CPU model
>>  #
>> +# @disable-deprecated-feats: include CPU model features that are
>> +#     flagged as deprecated. If supported, these features will appear
>> +#     in the properties list paired with false.
> 
> What's the default?
> 
> Which command result(s) does this affect?  Suggest to explain using
> unabridged example QMP input and output before and after this series.
> 

Fair enough. Bool defaults to false but that's not apparent in the
description. I will add more detail.

> We generally avoid abbreviations in QMP names.  Let's call this
> @disable-deprecated-features.
> 

Okay.

> Separate sentences with two spaces for consistency, please.
> 

Understood.

>> +#
>>  # Returns: a CpuModelExpansionInfo describing the expanded CPU model
>>  #
>>  # Errors:
>> @@ -298,7 +302,8 @@
>>  ##
>>  { 'command': 'query-cpu-model-expansion',
>>    'data': { 'type': 'CpuModelExpansionType',
>> -            'model': 'CpuModelInfo' },
>> +            'model': 'CpuModelInfo',
>> +            '*disable-deprecated-feats': 'bool' },
>>    'returns': 'CpuModelExpansionInfo',
>>    'if': { 'any': [ 'TARGET_S390X',
>>                     'TARGET_I386',
>                       'TARGET_ARM',
>                       'TARGET_LOONGARCH64',
>                       'TARGET_RISCV' ] } }
> 
> Put a pin into this conditional: [*].
> 
>> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
>> index 3cc8cc738b..1010d654e3 100644
>> --- a/target/arm/arm-qmp-cmds.c
>> +++ b/target/arm/arm-qmp-cmds.c
>> @@ -100,6 +100,8 @@ static const char *cpu_model_advertised_features[] = {
>>  
>>  CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>                                                       CpuModelInfo *model,
>> +                                                     bool has_disable_deprecated_feats,
>> +                                                     bool disable_deprecated_feats,
>>                                                       Error **errp)
>>  {
>>      CpuModelExpansionInfo *expansion_info;
>> @@ -110,6 +112,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>      const char *name;
>>      int i;
>>  
>> +    if (has_disable_deprecated_feats) {
>> +        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
>> +        return NULL;
>> +    }
> 
> Reject the new argument in the ARM version, ...
> 
>> +
>>      if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
>>          error_setg(errp, "The requested expansion type is not supported");
>>          return NULL;
>> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
>> index 3f9093d285..c15786fb66 100644
>> --- a/target/i386/cpu-sysemu.c
>> +++ b/target/i386/cpu-sysemu.c
>> @@ -196,6 +196,8 @@ out:
>>  CpuModelExpansionInfo *
>>  qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>                                                        CpuModelInfo *model,
>> +                                                      bool has_disable_deprecated_feats,
>> +                                                      bool disable_deprecated_feats,
>>                                                        Error **errp)
>>  {
>>      X86CPU *xc = NULL;
>> @@ -204,6 +206,11 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>      QDict *props = NULL;
>>      const char *base_name;
>>  
>> +    if (has_disable_deprecated_feats) {
>> +        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
>> +        goto out;
>> +    }
> 
> ... the i386 version, ...
> 
>> +
>>      xc = x86_cpu_from_model(model->name, model->props, "model.props", &err);
>>      if (err) {
>>          goto out;
>> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
>> index 2d99218069..ef9fa80efd 100644
>> --- a/target/s390x/cpu_models_sysemu.c
>> +++ b/target/s390x/cpu_models_sysemu.c
>> @@ -210,6 +210,8 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>>  
>>  CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>                                                        CpuModelInfo *model,
>> +                                                      bool has_disable_deprecated_feats,
>> +                                                      bool disable_deprecated_feats,
>>                                                        Error **errp)
>>  {
>>      Error *err = NULL;
>> @@ -217,6 +219,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>      S390CPUModel s390_model;
>>      bool delta_changes = false;
>>  
>> +    if (has_disable_deprecated_feats) {
>> +        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
>> +        return NULL;
>> +    }
> 
> ... and the S390 version, but ...
> 
>> +
>>      /* convert it to our internal representation */
>>      cpu_model_from_info(&s390_model, model, "model", &err);
>>      if (err) {
> 
> ... neither the loongarch not the RISC-V version, which according to
> condition [*] above also implement the command[*].  Bug?
> 
> Peeking ahead in the series, I see that you implement
> @disable-deprecated-feats only for S390.
> 
> Having to reject @disable-deprecated-feats in targets that implement
> query-cpu-model-expansion, but not the @disable-deprecated-feats, is
> problematic:
> 
> 1. If we implement query-cpu-model-expansion for another target, we need
> to remember rejecting @disable-deprecated-feats.  Trap for the unwary.
> 
> 2. query-qmp-schema can't tell whether the argument is supported.
> 
> You could make @query-cpu-model-expansion conditional on S390.
> 
> Since conditional arguments require 'boxed': true, you first have to
> do that, like so:
> 
>     { 'command': 'query-cpu-model-expansion', 'boxed': true,
>       'data': 'Foo',
>       'returns': 'CpuModelExpansionInfo',
>       'if': { 'any': [ 'TARGET_S390X',
>                        'TARGET_I386',
>                        'TARGET_ARM',
>                        'TARGET_LOONGARCH64',
>                        'TARGET_RISCV' ] } }
> 
> where Foo is
> 
>     { 'struct': 'Foo',
>       'data': { 'type': 'CpuModelExpansionType',
>                 'model': 'CpuModelInfo' } }
> 
> Then add the conditional argument:
> 
>     { 'struct': 'Foo',
>       'data': { 'type': 'CpuModelExpansionType',
>                 'model': 'CpuModelInfo' } }
>                 '*disable-deprecated-feats': { 'type': 'bool',
>                                                'if': 'TARGET_S390X' }
> 
> Use a reasonable name instead of Foo, of course.
> 
> Disadvantages:
> 
> * More churn
> 
> * Possibly something else I can't see without trying it
> 
> Advantages:
> 
> * You don't have to reject the argument for all targets that don't
>   implement it
> 
> * We can't forget to reject the argument when implementing
>   query-cpu-model-expansion for another target
> 
> * query-cpu-model-expansion shows whether the argument is supported
> 
> I think you should give this a try.
> 
> 

Very cool. Avoiding the requirement of others architectures to catch
this conditional and handle it would definitely be nice. Thank you for
this insight. I'll play around with it and find a cleaner approach to
what I have.

I will need to reflect on Daniel's feedback as well, which suggests
simply listing deprecated features as a separate array in the QMP response.

Thanks for your feedback!

-- 
Regards,
  Collin


