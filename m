Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF757C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 11:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUlWj-0005Ds-MB; Fri, 19 Jul 2024 07:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUlWi-0005B9-Gv
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 07:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUlWg-0003PR-AD
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 07:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721387509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAuKk7VUG2HCRN8LVoybAg4IOU1GprDIQeiHU0aWM/4=;
 b=IXqEFMJ9bc3Q6wLUsDLTcZFwNpGn5+uFpDUxZQboJNnW8BcsP9mOZpX3LGKLtbeDJddBxY
 nzDU2wvBbAThzj+1egP8ZETB3JBzkZ9kiRhwCjA92Q0gBGKJr9Gr8XaDK/nMqcSyKBhonN
 olAtSN3Lhp3+7MsUeCDGGPJFTEvb+m8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-eSGI7aBROrSBlNiDdN2Ujw-1; Fri,
 19 Jul 2024 07:11:45 -0400
X-MC-Unique: eSGI7aBROrSBlNiDdN2Ujw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B4AC1955D4C; Fri, 19 Jul 2024 11:11:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88043195605A; Fri, 19 Jul 2024 11:11:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4623021E668F; Fri, 19 Jul 2024 13:11:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org,  david@redhat.com,  wangyanan55@huawei.com,
 philmd@linaro.org,  marcel.apfelbaum@gmail.com,  eduardo@habkost.net,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v2] target/s390x: filter deprecated properties based on
 model expansion type
In-Reply-To: <16c9703c-79b9-4e52-bc40-2857c0c06672@redhat.com> (Thomas Huth's
 message of "Fri, 19 Jul 2024 12:16:08 +0200")
References: <20240716173253.28533-1-walling@linux.ibm.com>
 <87le1yn7jy.fsf@pond.sub.org>
 <32379d4f-9b6f-4673-9b87-1db4a8ada649@linux.ibm.com>
 <16c9703c-79b9-4e52-bc40-2857c0c06672@redhat.com>
Date: Fri, 19 Jul 2024 13:11:39 +0200
Message-ID: <87wmlhtz4k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 18/07/2024 20.22, Collin Walling wrote:
>> On 7/18/24 9:39 AM, Markus Armbruster wrote:
>>> Collin Walling <walling@linux.ibm.com> writes:
>>>
>>>> As s390 CPU models progress and deprecated properties are dropped
>>>> outright, it will be cumbersome for management apps to query the host
>>>> for a comprehensive list of deprecated properties that will need to be
>>>> disabled on older models. To remedy this, the query-cpu-model-expansion
>>>> output now behaves by filtering deprecated properties based on the
>>>> expansion type instead of filtering based off of the model's full set
>>>> of features:
>>>>
>>>> When reporting a static CPU model, only show deprecated properties that
>>>> are a subset of the model's enabled features.
>>>>
>>>> When reporting a full CPU model, show the entire list of deprecated
>>>> properties regardless if they are supported on the model.
>>>>
>>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>

[...]

>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>> index a8d9ec87f5..d151504f25 100644
>>>> --- a/qapi/machine-target.json
>>>> +++ b/qapi/machine-target.json
>>>> @@ -21,8 +21,12 @@
>>>>   # @props: a dictionary of QOM properties to be applied
>>>>   #
>>>>   # @deprecated-props: a list of properties that are flagged as deprecated
>>>> -#     by the CPU vendor.  These props are a subset of the full model's
>>>> -#     definition list of properties. (since 9.1)
>>>> +#     by the CPU vendor.  (since 9.1).
>>>> +#
>>>> +# .. note:: Since 9.1, the list of deprecated props were always a subset
>>>> +#    of the model's full-definition list of properites. Now, this list is
>>>> +#    populated with the model's enabled property set when delta changes
>>>> +#    are applied. All deprecated properties are reported otherwise.
>>>
>>> I'm confused.
>>>
>>> "Since 9.1, the list of deprecated props were ..." and "Now, this list
>>> is" sounds like you're explaining behavior before and after a change.
>>> What change?  Since only released behavior matters, and
>>> @deprecated-props is new, there is no old behavior to document, isn't
>>> it?
>>
>> I admittedly had some difficulty articulating the change introduced by
>> this patch.  The @deprecated-props array, as well as a way for s390x to
>> populate it, was introduced in release 9.1.  Prior to this patch, the
>> deprecated-props list was filtered by the CPU model's full feature set.
>> I attempted to explain this with:
>> "Since 9.1, the list of deprecated props were always a subset of the
>> model's full-definition list of properties."
>
> Version 9.1 has not been released yet (see https://wiki.qemu.org/Planning/9.1), so I agree with Markus, this sounds confusing/wrong to me, too.

User-visible changes between releases need to be documented in release
notes and the manual.  Don't for changes within a release, instead
update documentation to reflect the new state of things.

Regardless, do explain the change in the commit message.

Specifics are more helpful than such generalities, so let me try despite
my relative ignorance of the subject matter.

1. Update the description of @deprecated-props to match the new code.
Ask yourself what people need to know to use this interface.

2. Explain in the commit message how semantics of @deprecated-props
change in this patch.


