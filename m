Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE8BC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRBp-0004Vb-EB; Mon, 29 Jul 2024 10:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYRBn-0004Ud-Mu
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYRBl-0003GS-Kf
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722262643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ELhKuW/y2mk0thotjZoAxSAITrXRoRMvAQ+o+jZv5yc=;
 b=jNzuq0dV7inlBfTT2BYMs4kzsqNOkAJ9jIGcA/a1pzgxXMSIflGL6+Tr9gTxB2GmGbY/dI
 Ub2pYCdys73H8NhktNYKByLlUKkxW2+I7b/6gpoiOAmyf6dFW7XdegMHsjIUtQ7nXkCTzN
 olxf9tj7eWqNZ7I9wi3FmQktgw7euBU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-O067gX1zMKuG7_BVn3IBqg-1; Mon,
 29 Jul 2024 10:16:13 -0400
X-MC-Unique: O067gX1zMKuG7_BVn3IBqg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBD231955D52; Mon, 29 Jul 2024 14:16:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9266E19560AE; Mon, 29 Jul 2024 14:16:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40D4921E6693; Mon, 29 Jul 2024 16:15:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org,  thuth@redhat.com,  wangyanan55@huawei.com,
 philmd@linaro.org,  marcel.apfelbaum@gmail.com,  eduardo@habkost.net
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
In-Reply-To: <00bc2317-dbba-43b3-b355-ddce45b5dfc6@redhat.com> (David
 Hildenbrand's message of "Mon, 29 Jul 2024 11:52:19 +0200")
References: <20240726203646.20279-1-walling@linux.ibm.com>
 <877cd7qsnj.fsf@pond.sub.org>
 <00bc2317-dbba-43b3-b355-ddce45b5dfc6@redhat.com>
Date: Mon, 29 Jul 2024 16:15:58 +0200
Message-ID: <87a5i0cmht.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

David Hildenbrand <david@redhat.com> writes:

> On 27.07.24 08:02, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>> 
>>> The @deprecated-props array did not make any sense to be a member of the
>>> CpuModelInfo struct, since this field would only be populated by a
>>> query-cpu-model-expansion response and ignored otherwise.
>> 
>> Doesn't query-cpu-model-baseline also return it in its response?  It
>> seems to assume the "static" expansion type.
>> 
>>>                                                            Move this
>>> field to the CpuModelExpansionInfo struct where is makes more sense.
>>>
>>> References:
>>>   - https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg05996.html
>>>   - commit eed0e8ffa38f0695c0519508f6e4f5a3297cbd67
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>
>>> @David, the previous commit header did not align with the changes made
>>> here, so I tagged this as a "v1" but added the previous conversation as
>>> a reference.  I hope this is appropriate?
>>>
>>> ---
>>>   qapi/machine-target.json         | 18 ++++++++++--------
>>>   target/s390x/cpu_models_sysemu.c | 31 ++++++++++++++++++++-----------
>>>   2 files changed, 30 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index a552e2b0ce..09dec2b9bb 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -20,17 +20,11 @@
>>>   #
>>>   # @props: a dictionary of QOM properties to be applied
>>>   #
>>> -# @deprecated-props: a list of properties that are flagged as deprecated
>>> -#     by the CPU vendor.  These properties are either a subset of the
>>> -#     properties enabled on the CPU model, or a set of properties
>>> -#     deprecated across all models for the architecture.
>>> -#
>>>   # Since: 2.8
>>>   ##
>>>   { 'struct': 'CpuModelInfo',
>>>     'data': { 'name': 'str',
>>> -            '*props': 'any',
>>> -            '*deprecated-props': ['str'] } }
>>> +            '*props': 'any' } }
>>>   
>>>   ##
>>>   # @CpuModelExpansionType:
>>> @@ -248,10 +242,18 @@
>>>   #
>>>   # @model: the expanded CpuModelInfo.
>>>   #
>>> +# @deprecated-props: a list of properties that are flagged as deprecated
>>> +#     by the CPU vendor.  The list depends on the CpuModelExpansionType:
>>> +#     "static" properties are a subset of the enabled-properties for
>>> +#     the expanded model; "full" properties are a set of properties
>>> +#     that are deprecated across all models for the architecture.
>>> +#     (since: 9.1).
>>> +#
>>>   # Since: 2.8
>>>   ##
>>>   { 'struct': 'CpuModelExpansionInfo',
>>> -  'data': { 'model': 'CpuModelInfo' },
>>> +  'data': { 'model': 'CpuModelInfo',
>>> +            '*deprecated-props': ['str'] },
>>>     'if': { 'any': [ 'TARGET_S390X',
>>>                      'TARGET_I386',
>>>                      'TARGET_ARM',
>> 
>> This solves several interface problems:
>> 
>> 1. Removes inappropriate @deprecated-props argument of
>>     query-cpu-model-comparison, query-cpu-model-expansion,
>>     query-cpu-model-baseline.
>> 
>> 2. Removes @deprecated-props return of query-cpu-model-baseline.
>> 
>> 3. Properly documents how @deprecated-props depends on the expansion
>>     type.
>> 
>> Remaining problem:
>> 
>> 4. Only S390 implements this.
>> 
>> Suggest to capture 1-3 more clearly in the commit message, perhaps like
>> this:
>> 
>>      CpuModelInfo is used both as command argument and in command
>>      returns.
>> 
>>      Its @deprecated-props array does not make any sense in arguments,
>>      and is silently ignored.  We actually want it only as return value
>>      of query-cpu-model-expansion.
>> 
>>      Move it from CpuModelInfo to CpuModelExpansionType, and document
>>      its dependence on expansion type propetly.
>
> s/propetly/property/

Can't type.

> Sounds good!
>
>> 
>> The simplest way to address 4 is to tack 'if': 'TARGET_S390X' to
>> @deprecated-props.
>> 
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 09dec2b9bb..0be95d559c 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -253,7 +253,7 @@
>   ##
>   { 'struct': 'CpuModelExpansionInfo',
>     'data': { 'model': 'CpuModelInfo',
> -            '*deprecated-props': ['str'] },
> +            '*deprecated-props' : { 'type': ['str'], 'if': 'TARGET_S390X' } },
>     'if': { 'any': [ 'TARGET_S390X',
>                      'TARGET_I386',
>                      'TARGET_ARM',
>
>
> Should do the trick, right?

Yes.  Break the line before 'if', please.

>> I recommend to make @deprecated-props mandatory rather than optional
>> then.
>
> Hm, does that make sense judging that previous implementations didn't expose it?

Adding members to the return value is fine.

docs/devel/qapi-code-gen.rst section "Compatibility considerations"

    Clients send commands with argument data, and receive command
    responses with return data and events with event data.

    Adding opt-in functionality to the send direction is backwards
    compatible: adding commands, optional arguments, enumeration values,
    union and alternate branches; turning an argument type into an
    alternate of that type; making mandatory arguments optional.  Clients
    oblivious of the new functionality continue to work.

    Incompatible changes include removing commands, command arguments,
    enumeration values, union and alternate branches, adding mandatory
    command arguments, and making optional arguments mandatory.

    The specified behavior of an absent optional argument should remain
    the same.  With proper documentation, this policy still allows some
    flexibility; for example, when an optional 'buffer-size' argument is
    specified to default to a sensible buffer size, the actual default
    value can still be changed.  The specified default behavior is not the
    exact size of the buffer, only that the default size is sensible.

--> Adding functionality to the receive direction is generally backwards
--> compatible: adding events, adding return and event data members.
--> Clients are expected to ignore the ones they don't know.

    Removing "unreachable" stuff like events that can't be triggered
    anymore, optional return or event data members that can't be sent
    anymore, and return or event data member (enumeration) values that
    can't be sent anymore makes no difference to clients, except for
    introspection.  The latter can conceivably confuse clients, so tread
    carefully.

    Incompatible changes include removing return and event data members.

Questions?


