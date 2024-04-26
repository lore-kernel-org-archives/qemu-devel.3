Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F385C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 08:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Gms-00071H-IZ; Fri, 26 Apr 2024 04:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0Gmn-0006w1-1C
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0Gmg-00057V-FN
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714119496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sN7thfPp/2yIrAMCzZsin8pIgKDJFLqi+FxnGvjZU34=;
 b=MAnjUbY+ogvxOVfCOuZMAeDv3iJmwbQlUVvi8qoCr3u9NkHbhyBTGMsJ7n7TYwKBurEZI9
 Jl9W8J32qGmg4VbsaL4fySEoa8Fi31pGyW6Hf1Gz9AI5u0Ex3D1yDWU8P5sMb2dyxQzSEQ
 zQWogaEe0uSjY+fMkhBQ+5WQ2oEPDUA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-kv4E22vZMyGnLaM7MIfzqw-1; Fri,
 26 Apr 2024 04:18:12 -0400
X-MC-Unique: kv4E22vZMyGnLaM7MIfzqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77E59380391A;
 Fri, 26 Apr 2024 08:18:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AD1A2166B36;
 Fri, 26 Apr 2024 08:18:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F2B4F21E66E5; Fri, 26 Apr 2024 10:18:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net
Subject: Re: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats"
 option to cpu model expansion
In-Reply-To: <f5d362f7-c9dd-4730-9b1c-07b14f8128a8@linux.ibm.com> (Collin
 Walling's message of "Thu, 25 Apr 2024 13:35:17 -0400")
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-2-walling@linux.ibm.com>
 <87bk5z5ll9.fsf@pond.sub.org>
 <809ee6ee-e66e-466f-bbf2-93ba7ec1afda@linux.ibm.com>
 <87jzkm9cn8.fsf@pond.sub.org>
 <f5d362f7-c9dd-4730-9b1c-07b14f8128a8@linux.ibm.com>
Date: Fri, 26 Apr 2024 10:18:09 +0200
Message-ID: <87a5lgzge6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

Collin Walling <walling@linux.ibm.com> writes:

> On 4/25/24 02:31, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>> 
>>> On 4/24/24 02:19, Markus Armbruster wrote:
>>>> Collin Walling <walling@linux.ibm.com> writes:
>>>>
>>>>> This optional parameter for query-cpu-model-expansion enables CPU
>>>>> model features flagged as deprecated to appear in the resulting
>>>>> list of properties.
>>>>>
>>>>> This commit does not add support beyond adding a new argument
>>>>> to the query. All queries with this option present will result
>>>>> in an error claiming this option is not supported.
>>>>>
>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>>> ---
>>>>>  qapi/machine-target.json         | 7 ++++++-
>>>>>  target/arm/arm-qmp-cmds.c        | 7 +++++++
>>>>>  target/i386/cpu-sysemu.c         | 7 +++++++
>>>>>  target/s390x/cpu_models_sysemu.c | 7 +++++++
>>>>>  4 files changed, 27 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>>> index 29e695aa06..b9da284d2d 100644
>>>>> --- a/qapi/machine-target.json
>>>>> +++ b/qapi/machine-target.json
>>>>> @@ -285,6 +285,10 @@
>>>>>  #
>>>>>  # @type: expansion type, specifying how to expand the CPU model
>>>>>  #
>>>>> +# @disable-deprecated-feats: include CPU model features that are
>>>>> +#     flagged as deprecated. If supported, these features will appear
>>>>> +#     in the properties list paired with false.
>>>>
>>>> What's the default?
>>>>
>>>> Which command result(s) does this affect?  Suggest to explain using
>>>> unabridged example QMP input and output before and after this series.
>>>
>>> Fair enough. Bool defaults to false but that's not apparent in the
>>> description. I will add more detail.
>> 
>> I didn't mean to ask for example QMP in the doc comment.  I need you to
>> explain the new member to me.  Once I understand what the thing does, I
>> may have suggestions on improving the doc comment.
>> 
>> [...]
>> 
>
> Ah, I misunderstood.  The idea behind this "disable-deprecated-feats"
> option is to add/override any CPU features that are flagged as
> deprecated to the props dictionary (found in the CpuModelInfo struct)
> paired with the value false.
>
> For example, the csske feature on s390x is flagged as deprecated.  If a
> query-cpu-model-expansion command is created with
> "disable-deprecated-feats": true, then the csske feature will show up in
> the props list as "csske": false.  This also overrides any user defined
> features and props that would show up in the response normally. E.g. if
> the same command was executed and "csske": true was provided in the
> model's properties by the user, the response will still show "csske":
> false since the "disable-deprecated-feats" option takes priority (there
> is a discussion with David H regarding which should take precedence --
> this is a flaw in this design).
>
> In the below QMP samples I provide a static expansion on a host model.
> Pay close attention to the bpb, te, cte, and csske properties.

[...]

> Hope this helps to provide more context.  Please let me know if you'd
> like more info.  I am leaning towards v3's design more, as it seems a
> lot cleaner overall.  I would appreciate your feedback there as well if
> you have the time.
>
> Thanks!

Okay, I'll look at v3 then.

Thank you!


