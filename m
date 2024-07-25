Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257FDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 06:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWruJ-0007mE-99; Thu, 25 Jul 2024 02:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWruG-0007jT-1N
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWruD-0007Kw-8d
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721888687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZPMaVxL0QqXqcPl3QO8nmEoN+w2zBU0FOWWZV9muy/Q=;
 b=KnuR6vD6/sNuSnTRHOwZ+m+OOnq4XBvSYyTQ2fRF7C1YAJzWT094bX5e5l1bHXSR+FUUm4
 8nZITfKmhyjXKfS9B1nooEzs5FxpygEk8jEHwod5216v6S6q5h3R2COUcXEw/GlXzIGKVy
 tF40V/MVdbCn9bO3GiLWoc3NtJFlthA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-Sn0Z2CWINm-H1OpxsTF4og-1; Thu,
 25 Jul 2024 02:24:43 -0400
X-MC-Unique: Sn0Z2CWINm-H1OpxsTF4og-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A1ED1955D4B; Thu, 25 Jul 2024 06:24:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA52195605A; Thu, 25 Jul 2024 06:24:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9439D21E668F; Thu, 25 Jul 2024 08:24:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,  Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
In-Reply-To: <9f8023a4-3edd-476f-9243-677138be3921@linux.ibm.com> (Collin
 Walling's message of "Wed, 24 Jul 2024 15:42:00 -0400")
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
 <87bk2nrzou.fsf@pond.sub.org>
 <9f8023a4-3edd-476f-9243-677138be3921@linux.ibm.com>
Date: Thu, 25 Jul 2024 08:24:37 +0200
Message-ID: <87cyn2ugyi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 7/24/24 3:56 AM, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
> Let me try to explain the purpose of @deprecated-props and see if it
> helps bring us closer to some semblance of a mutual understanding so we
> can work together on a concise documentation for this field.
>
> s390 has been announcing features as deprecated for some time now, which
> was fine as a way to let users know that they should tune their guests
> to no longer user these features.  Now that we are approaching the
> release of generations that will drop these deprecated features
> outright, we encounter an issue: if users have not been mindful with
> disabling these announced-deprecated-features, then their guests running
> on older models will not be able to migrate to machines running on newer
> hardware.
>
> To alleviate this, I've added the @deprecated-props array to the
> CpuModelInfo struct, and this field is populated by a
> query-cpu-model-expansion* return.  It is up the the user/management app
> to make use of this data.
>
> On the libvirt side (currently in development), I am able to easily
> retrieve the host-model with a full expansion, parse the
> @deprecated-props, and then cache them for later use (e.g. when
> reporting the host-model with these features disabled, or enabling a
> user to define their domain with deprecated-features disabled via a
> convenient XML attribute).
>
> tl;dr @deprecated-props is only reported via a
> query-cpu-model-expansion, and it is up to the user/management app to
> figure out what to do with them.

Got it.

Permit me a digression.  In QAPI/QMP, we do something similar: we expose
deprecation in introspection (query-qmp-schema), and what to do with the
information is up to the management application.  We provide one more
tool to it: policy for handling deprecated interfaces, set with -compat.
It permits "testing the future".  See qapi/compat.json for details.
Whether such a thing would be usful in your case I can't say.

>> On closer examination, more questions on CpuModelInfo emerge.  Uses:
>> 
>
> I will attempt to expand on each input @model (CpuModelInfo) as if they
> were documented in the file.
>
>> * query-cpu-model-comparison both arguments
>> 
>>   Documentation doesn't say how exactly the command uses the members of
>>   CpuModelInfo, i.e. @name, @props, @deprecated-props.  Can you tell me?
>> 
>
> Note: Compares ModelA and ModelB.
>
> Both @models must include @name.  @props is optional.  @deprecated-props
> is ignored.
>
> @name: the name of the CPU model definition to look up.  The definition
> will be compared against the generation, GA level, and a static set of
> properties of the opposing model.
>
> @props: a set of additional properties to include in the model's set of
> properties to be compared.
>
> @deprecated-props: ignored.  The user should consider these properties
> beforehand and decide if these properties should be disabled/omitted on
> the respective model.
>
>> * query-cpu-model-expansion argument @model and return value member
>>   @model.
>> 
>>   The other argument is the expansion type, on which the value of return
>>   value model.deprecated-props depends, I believe.  Fine.
>> 
>>   Documentation doesn't say how exactly the command uses the members of
>>   CpuModelInfo arguments, i.e. @name, @props, @deprecated-props.  Can
>>   you tell me?
>> 
>
> The @model must include @name.  @props is optional.  @deprecated-props
> is ignored.
>
> @name: the name of the CPU model definition to look up.  The definition
> is associated with a set of properties that will populate the return data.
>
> @props: a set of additional properties to include in the model's set of
> expanded properties.
>
> @deprecated-props: ignored.  The user should consider these properties
> beforehand and decide if these properties should be disabled/omitted on
> the model.

Return value member @model will have @name, may have @props and
@deprecated-props.

Absent @props is the same as {}.  Only x86 uses {}.

Absent @deprecated-props is the same as {}.  No target uses {}.  Can be
present only on S390.

Aside: returning the same thing in two different ways, like absent and
{}, is slightly more complex than necessary.  But let's ignore that
here.

>> * query-cpu-model-baseline both arguments and return value member
>>   @model.
>> 
>>   Same, except we don't have an expansion type here.  So same question,
>>   plus another one: how does return value model.deprecated-props behave?
>> 
>
> Note: Creates a baseline model based on ModelA and ModelB.
>
> The @models must include @name.  @props is optional.  @deprecated-props
> is ignored.
>
> @name: the name of the CPU model definition to look up.  The definition,
> GA level, and a static set of properties will be used to determine the
> maximum model between ModelA and ModelB.
>
> @props: a set of additional properties to include in the model's set of
> properties to be baselined.
>
> @deprecated-props: ignored.  The user should consider these properties
> beforehand and decide if these properties should be disabled/omitted on
> the respective model.

Return value member @model is just like in query-cpu-model-expansion.

Unlike query-cpu-model-expansion, we don't have an expansion type.  The
value of @deprecated-props depends on the expansion type.  Do we assume
a type?  Which one?

>> If you can't answer my questions, we need to find someone who can.
>> 
>
> Hopefully this provides clarity on how CpuModelInfo and its respective
> fields are used in each command.  @David should be able to fill in any
> missing areas / expand / offer corrections.
>
>> [...]

This helps, thanks!

Arguments that are silently ignored is bad interface design.

Observe: when CpuModelInfo is an argument, @deprecated-props is always
ignored.  When it's a return value, absent means {}, and it can be
present only for certain targets (currently S390).

The reason we end up with an argument we ignore is laziness: we use the
same type for both roles.  We can fix that easily:

    { 'struct': 'CpuModel',
      'data': { 'name': 'str',
                '*props': 'any' } }

    { 'struct': 'CpuModelInfo',
      'base': 'CpuModel',
      'data': { '*deprecated-props': ['str'] } }

Use CpuModel for arguments, CpuModelInfo for return values.

Since @deprecated-props is used only by some targets, I'd make it
conditional, i.e. 'if': 'TARGET_S390X'.

Thoughts?


