Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D54C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpNm-0008F7-Ef; Fri, 19 Jul 2024 11:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sUpNk-00087M-B7; Fri, 19 Jul 2024 11:18:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sUpNi-0000KE-CJ; Fri, 19 Jul 2024 11:18:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JEtueh007403;
 Fri, 19 Jul 2024 15:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 rtZOglzEb8AJpAGEGEJ65MBfjcscqVfIGrKMF2UepNs=; b=f4lz8CA9dIIxFcB9
 5E44LOfxubJzzkrNGjRvJ1A8TfGsqN+KQ/8K/HpNOf3bQx9N0LF281xdi3Cses3S
 MF21LZU+7OiZT33fLkTJBM4saOsosz2JGB003cUIop+9OSWAT2CCLeq05dFcPN1v
 1tEKuBhixBSN3uscoBze2rRsd7bJMH6/Dp+ImPJAKaWjuk3eg85+KWQn9HUQ6xA7
 qlWWhesWReciT4mDKjoYjM82ghBPNAxNAxnPJqApjnfSCrauud/LPt85pQq2Gg4F
 cjNLSWGaBdPIa26+g3WpSJQtxwhu7iGdx2Cu4GVaLT6O0gQY9hWgiTQCLggZTK6N
 inmaFQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40fsxdr3xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 15:18:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46JFF5gZ004108;
 Fri, 19 Jul 2024 15:18:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40fsxdr3xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 15:18:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46JCDIrM006020; Fri, 19 Jul 2024 15:18:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwknfr4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 15:18:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46JFIWTe14484012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 15:18:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2188358078;
 Fri, 19 Jul 2024 15:18:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82BC75806A;
 Fri, 19 Jul 2024 15:18:31 +0000 (GMT)
Received: from [9.67.171.109] (unknown [9.67.171.109])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 19 Jul 2024 15:18:31 +0000 (GMT)
Message-ID: <6cdaa2eb-03bd-40b6-b87b-8cfc075083f3@linux.ibm.com>
Date: Fri, 19 Jul 2024 11:18:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: filter deprecated properties based on
 model expansion type
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, Jiri Denemark <jdenemar@redhat.com>
References: <20240716173253.28533-1-walling@linux.ibm.com>
 <87le1yn7jy.fsf@pond.sub.org>
 <32379d4f-9b6f-4673-9b87-1db4a8ada649@linux.ibm.com>
 <16c9703c-79b9-4e52-bc40-2857c0c06672@redhat.com>
 <87wmlhtz4k.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87wmlhtz4k.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -DnXJYLRq5lSQSqKCr34qu-yxLA7yW85
X-Proofpoint-GUID: K44S7gF0RnZmR7ZRy4jXDXKR2S3jB1Js
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407190113
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

On 7/19/24 7:11 AM, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 18/07/2024 20.22, Collin Walling wrote:
>>> On 7/18/24 9:39 AM, Markus Armbruster wrote:
>>>> Collin Walling <walling@linux.ibm.com> writes:
>>>>
>>>>> As s390 CPU models progress and deprecated properties are dropped
>>>>> outright, it will be cumbersome for management apps to query the host
>>>>> for a comprehensive list of deprecated properties that will need to be
>>>>> disabled on older models. To remedy this, the query-cpu-model-expansion
>>>>> output now behaves by filtering deprecated properties based on the
>>>>> expansion type instead of filtering based off of the model's full set
>>>>> of features:
>>>>>
>>>>> When reporting a static CPU model, only show deprecated properties that
>>>>> are a subset of the model's enabled features.
>>>>>
>>>>> When reporting a full CPU model, show the entire list of deprecated
>>>>> properties regardless if they are supported on the model.
>>>>>
>>>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> 
> [...]
> 
>>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>>> index a8d9ec87f5..d151504f25 100644
>>>>> --- a/qapi/machine-target.json
>>>>> +++ b/qapi/machine-target.json
>>>>> @@ -21,8 +21,12 @@
>>>>>   # @props: a dictionary of QOM properties to be applied
>>>>>   #
>>>>>   # @deprecated-props: a list of properties that are flagged as deprecated
>>>>> -#     by the CPU vendor.  These props are a subset of the full model's
>>>>> -#     definition list of properties. (since 9.1)
>>>>> +#     by the CPU vendor.  (since 9.1).
>>>>> +#
>>>>> +# .. note:: Since 9.1, the list of deprecated props were always a subset
>>>>> +#    of the model's full-definition list of properites. Now, this list is
>>>>> +#    populated with the model's enabled property set when delta changes
>>>>> +#    are applied. All deprecated properties are reported otherwise.
>>>>
>>>> I'm confused.
>>>>
>>>> "Since 9.1, the list of deprecated props were ..." and "Now, this list
>>>> is" sounds like you're explaining behavior before and after a change.
>>>> What change?  Since only released behavior matters, and
>>>> @deprecated-props is new, there is no old behavior to document, isn't
>>>> it?
>>>
>>> I admittedly had some difficulty articulating the change introduced by
>>> this patch.  The @deprecated-props array, as well as a way for s390x to
>>> populate it, was introduced in release 9.1.  Prior to this patch, the
>>> deprecated-props list was filtered by the CPU model's full feature set.
>>> I attempted to explain this with:
>>> "Since 9.1, the list of deprecated props were always a subset of the
>>> model's full-definition list of properties."
>>
>> Version 9.1 has not been released yet (see https://wiki.qemu.org/Planning/9.1), so I agree with Markus, this sounds confusing/wrong to me, too.
> 
> User-visible changes between releases need to be documented in release
> notes and the manual.  Don't for changes within a release, instead
> update documentation to reflect the new state of things.
> 
> Regardless, do explain the change in the commit message.
> 
> Specifics are more helpful than such generalities, so let me try despite
> my relative ignorance of the subject matter.
> 
> 1. Update the description of @deprecated-props to match the new code.
> Ask yourself what people need to know to use this interface.
> 
> 2. Explain in the commit message how semantics of @deprecated-props
> change in this patch.
> 
> 

Understood, thank you.  As per Thomas' comment, I did not do my due
diligence to check the QEMU release schedule.  My comment does not make
sense anyway, since 9.1 is not even released.  I will remove it `note`
entirely.

Apologies for all of this confusion, and I appreciate your patience.

I will post v3 with the appropriate corrections.

-- 
Regards,
  Collin


