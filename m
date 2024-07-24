Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82040C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 19:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWhsU-0005tU-7E; Wed, 24 Jul 2024 15:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sWhsS-0005sW-2d; Wed, 24 Jul 2024 15:42:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sWhsP-0004Vr-62; Wed, 24 Jul 2024 15:42:19 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OJP0J4015086;
 Wed, 24 Jul 2024 19:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=V
 KpNJvi1ceeUf4Mup5glbUF7/HsMe4e66Uwyw1DrtSI=; b=kl1eYke1vLZYVc0jp
 yF12Lg7XGG0AONDlyDnncmmuRtLlHl+zJY0WIBUFsci1jAvdWJIE2Har2pYyHMph
 cb3NV+ykeP+KUFDnHtAe+cGskuntJAdN5fFOj6VQM3XNj/Hsx5pnsPatcUCtyzNf
 pMjcosKyRYw+4G2SA0xA9lh9TfyPfEW0pVVyYgIlUrvTsqoo4H5wb38kKojfMFmr
 /L6kb/pwZGdcfk8SmXtkYxJWpWmND52sbRl/s0jSqdd5urog0NwN5qAntsqpys/v
 RvfYTh+ENJEreCmfrmkMydriXbJode25Uejv4dxiQ6pmrBQ+PsX0/UR+UqX6w8xx
 6z0Qw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k6208bhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 19:42:06 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OJg5UJ012338;
 Wed, 24 Jul 2024 19:42:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k6208bhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 19:42:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46OJFDcJ007861; Wed, 24 Jul 2024 19:42:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxna1p0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 19:42:04 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46OJg1Wm49414450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 19:42:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC1EF5805F;
 Wed, 24 Jul 2024 19:42:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D95505805E;
 Wed, 24 Jul 2024 19:42:00 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Jul 2024 19:42:00 +0000 (GMT)
Message-ID: <9f8023a4-3edd-476f-9243-677138be3921@linux.ibm.com>
Date: Wed, 24 Jul 2024 15:42:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
 <87bk2nrzou.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87bk2nrzou.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VG5paRh5nK4slt0I1_2kmzFUDTd8BaEd
X-Proofpoint-GUID: uzD6kWLiGSuinlCiWm8yVYZRhn1sNnii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_21,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407240139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

On 7/24/24 3:56 AM, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> On 7/20/24 1:33 AM, Markus Armbruster wrote:
>>> Collin Walling <walling@linux.ibm.com> writes:
>>>
>>>> Currently, there is no way to execute the query-cpu-model-expansion
>>>> command to retrieve a comprehenisve list of deprecated properties, as
>>>> the result is dependent per-model. To enable this, the expansion output
>>>> is modified as such:
>>>>
>>>> When reporting a "full" CPU model, show the *entire* list of deprecated
>>>> properties regardless if they are supported on the model. A full
>>>> expansion outputs all known CPU model properties anyway, so it makes
>>>> sense to report all deprecated properties here too.
>>>>
>>>> This allows management apps to query a single model (e.g. host) to
>>>> acquire the full list of deprecated properties.
>>>>
>>>> Additionally, when reporting a "static" CPU model, the command will
>>>> only show deprecated properties that are a subset of the model's
>>>> *enabled* properties. This is more accurate than how the query was
>>>> handled before, which blindly reported deprecated properties that
>>>> were never otherwise introduced for certain models.
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>>     v3
>>>>     - Removed the 'note' and cleaned up documentation
>>>>     - Revised commit message
>>>>
>>>>     v2
>>>>     - Changed commit message
>>>>     - Added documentation reflecting this change
>>>>     - Made code changes that more accurately filter the deprecated
>>>>         properties based on expansion type.  This change makes it
>>>>         so that the deprecated-properties reported for a static model
>>>>         expansion are a subset of the model's properties instead of
>>>>         the model's full-definition properties.
>>>>
>>>> ---
>>>>  qapi/machine-target.json         |  5 +++--
>>>>  target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>>>>  2 files changed, 12 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>> index a8d9ec87f5..67086f006f 100644
>>>> --- a/qapi/machine-target.json
>>>> +++ b/qapi/machine-target.json
>>>> @@ -21,8 +21,9 @@
>>>>  # @props: a dictionary of QOM properties to be applied
>>>>  #
>>>>  # @deprecated-props: a list of properties that are flagged as deprecated
>>>> -#     by the CPU vendor.  These props are a subset of the full model's
>>>> -#     definition list of properties. (since 9.1)
>>>> +#     by the CPU vendor.  These properties are either a subset of the
>>>> +#     properties enabled on the CPU model, or a set of properties
>>>> +#     deprecated across all models for the architecture.
>>>
>>>
>>> When is it "a subset of the properties enabled on the CPU model", and
>>> when is it "a set of properties deprecated across all models for the
>>> architecture"?
>>>
>>> My guess based on the commit message: it's the former when
>>> query-cpu-model-expansion's type is "static", and the latter when it's
>>> "full".
>>>
>>
>> Correct.  I'm not confident where or how to document this dependency
>> since cross-referencing commands/data structures does not seem to be the
>> convention here.  My first thought is to mention how deprecated
>> properties are expanded under the @CpuModelExpansionType.  Something like:
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 67086f006f..3f38c5229f 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -44,11 +44,15 @@
>>  #     options, and accelerator options.  Therefore, the resulting
>>  #     model can be used by tooling without having to specify a
>>  #     compatibility machine - e.g. when displaying the "host" model.
>> -#     The @static CPU models are migration-safe.
>> +#     The @static CPU models are migration-safe.  Deprecated
>> +#     properties are a subset of the properties enabled for the
>> +#     expanded model.
>>  #
>>  # @full: Expand all properties.  The produced model is not guaranteed
>>  #     to be migration-safe, but allows tooling to get an insight and
>> -#     work with model details.
>> +#     work with model details.  Deprecated properties are a set of
>> +#     properties that are deprecated across all models for the
>> +#     architecture.
>>  #
>>  # .. note:: When a non-migration-safe CPU model is expanded in static
>>  #    mode, some features enabled by the CPU model may be omitted,
>>
>> Thoughts?
> 
> The distance between @deprecated-props and parts of its documentation
> bothers me a bit.

Let me try to explain the purpose of @deprecated-props and see if it
helps bring us closer to some semblance of a mutual understanding so we
can work together on a concise documentation for this field.

s390 has been announcing features as deprecated for some time now, which
was fine as a way to let users know that they should tune their guests
to no longer user these features.  Now that we are approaching the
release of generations that will drop these deprecated features
outright, we encounter an issue: if users have not been mindful with
disabling these announced-deprecated-features, then their guests running
on older models will not be able to migrate to machines running on newer
hardware.

To alleviate this, I've added the @deprecated-props array to the
CpuModelInfo struct, and this field is populated by a
query-cpu-model-expansion* return.  It is up the the user/management app
to make use of this data.

On the libvirt side (currently in development), I am able to easily
retrieve the host-model with a full expansion, parse the
@deprecated-props, and then cache them for later use (e.g. when
reporting the host-model with these features disabled, or enabling a
user to define their domain with deprecated-features disabled via a
convenient XML attribute).

tl;dr @deprecated-props is only reported via a
query-cpu-model-expansion, and it is up to the user/management app to
figure out what to do with them.

> 
> On closer examination, more questions on CpuModelInfo emerge.  Uses:
> 

I will attempt to expand on each input @model (CpuModelInfo) as if they
were documented in the file.

> * query-cpu-model-comparison both arguments
> 
>   Documentation doesn't say how exactly the command uses the members of
>   CpuModelInfo, i.e. @name, @props, @deprecated-props.  Can you tell me?
> 

Note: Compares ModelA and ModelB.

Both @models must include @name.  @props is optional.  @deprecated-props
is ignored.

@name: the name of the CPU model definition to look up.  The definition
will be compared against the generation, GA level, and a static set of
properties of the opposing model.

@props: a set of additional properties to include in the model's set of
properties to be compared.

@deprecated-props: ignored.  The user should consider these properties
beforehand and decide if these properties should be disabled/omitted on
the respective model.

> * query-cpu-model-expansion argument @model and return value member
>   @model.
> 
>   The other argument is the expansion type, on which the value of return
>   value model.deprecated-props depends, I believe.  Fine.
> 
>   Documentation doesn't say how exactly the command uses the members of
>   CpuModelInfo arguments, i.e. @name, @props, @deprecated-props.  Can
>   you tell me?
> 

The @model must include @name.  @props is optional.  @deprecated-props
is ignored.

@name: the name of the CPU model definition to look up.  The definition
is associated with a set of properties that will populate the return data.

@props: a set of additional properties to include in the model's set of
expanded properties.

@deprecated-props: ignored.  The user should consider these properties
beforehand and decide if these properties should be disabled/omitted on
the model.

> * query-cpu-model-baseline both arguments and return value member
>   @model.
> 
>   Same, except we don't have an expansion type here.  So same question,
>   plus another one: how does return value model.deprecated-props behave?
> 

Note: Creates a baseline model based on ModelA and ModelB.

The @models must include @name.  @props is optional.  @deprecated-props
is ignored.

@name: the name of the CPU model definition to look up.  The definition,
GA level, and a static set of properties will be used to determine the
maximum model between ModelA and ModelB.

@props: a set of additional properties to include in the model's set of
properties to be baselined.

@deprecated-props: ignored.  The user should consider these properties
beforehand and decide if these properties should be disabled/omitted on
the respective model.

> If you can't answer my questions, we need to find someone who can.
> 

Hopefully this provides clarity on how CpuModelInfo and its respective
fields are used in each command.  @David should be able to fill in any
missing areas / expand / offer corrections.

> [...]
> 
> 

-- 
Regards,
  Collin


