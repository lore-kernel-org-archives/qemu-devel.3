Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC60CC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGPg-0003Vb-4G; Tue, 08 Jul 2025 18:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZFqm-0008Vd-JE
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZFqh-00004r-MY
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752010053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bU59mTLhcSNJBH0/PpwDeUTVcqTOhqElXFXdFNvDB9E=;
 b=DrzXynIpvALGGelBslkPHycZwtOihCbsmCnW6FsW012mh1cfHvS9P3D8grSzwyGAL8y3HF
 OQFLTHszrXV0MsUgOceE1kfDFvxBK5rHUS0dsG2n7BL/1PFPNPeX8rUp58l5oxcRXdSEG7
 cuLYfC4ZLZd4eD0mbgshnYUUtvuLlhs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-6wuQ_rngPSWrF8DEYVeWXw-1; Tue,
 08 Jul 2025 01:06:30 -0400
X-MC-Unique: 6wuQ_rngPSWrF8DEYVeWXw-1
X-Mimecast-MFC-AGG-ID: 6wuQ_rngPSWrF8DEYVeWXw_1751951189
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02AD318DA5C0; Tue,  8 Jul 2025 05:06:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 183BB1956087; Tue,  8 Jul 2025 05:06:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B93021E6A27; Tue, 08 Jul 2025 07:06:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Peter Krempa <pkrempa@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH V2 1/5] qom: qom-tree-get
In-Reply-To: <76271add-d9b3-4b45-a272-3cbe336c2103@oracle.com> (Steven
 Sistare's message of "Mon, 7 Jul 2025 10:44:17 -0400")
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-2-git-send-email-steven.sistare@oracle.com>
 <877c0ono29.fsf@pond.sub.org>
 <76271add-d9b3-4b45-a272-3cbe336c2103@oracle.com>
Date: Tue, 08 Jul 2025 07:06:25 +0200
Message-ID: <87zfdfz2y6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/4/2025 8:22 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Define the qom-tree-get QAPI command, which fetches an entire tree of
>>> properties and values with a single QAPI call.  This is much faster
>>> than using qom-list plus qom-get for every node and property of the
>>> tree.  See qom.json for details.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   qapi/qom.json      | 56 ++++++++++++++++++++++++++++++++++++++++++
>>>   qom/qom-qmp-cmds.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 128 insertions(+)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 28ce24c..94662ad 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -46,6 +46,38 @@
>>>               '*default-value': 'any' } }
>>>   
>>>  ##
>>> +# @ObjectPropertyValue:
>>> +#
>>> +# @name: the name of the property
>>> +#
>>> +# @type: the type of the property, as described in @ObjectPropertyInfo
>> 
>> That description is crap.  In part because what it tries to describe is
>> crap.  Neither is this patch's problem.
>> 
>>> +#
>>> +# @value: the value of the property.  Omitted if cannot be read.
>> 
>> Suggest "Absent when the property cannot be read."
>
> OK.
>
>>> +#
>>> +# Since 10.1
>>> +##
>>> +{ 'struct': 'ObjectPropertyValue',
>>> +  'data': { 'name': 'str',
>>> +            'type': 'str',
>>> +            '*value': 'any' } }
>> 
>> ObjectPropertyValue suggests this describes a property's value.
>
> I would agree with you if the name included "info" or "desc", but it
> does not.  To me, "ObjectPropertyValue" says this is an object's
> property and value.  But it's subjective.

Naming is hard.

> Perhaps: ObjectPropertyWithValue

I'd be tempted by ObjectProperty if it wasn't already taken by
qom/object.h.

Let's converge on the code, and maybe revisit naming at the end.

>>  It does
>> not.  It includes the name, i.e. it describes the *property*.
>> 
>> So does ObjectPropertyInfo.
>> 
>> The two overlap: both habe name and type.  Only ObjectPropertyValue has
>> the current value.  Only ObjectPropertyInfo has the default value and
>> description (I suspect the latter is useless in practice).
>> 
>> ObjectPropertyInfo is used with qom-list and qom-list-properties.
>> 
>> qom-list takes a QOM path, like your qom-tree-get and qom-list-getv.
>> I'd expect your commands to supersede qom-list in practice.
>> 
>> qom-list-properties is unlike your qom-tree-get and qom-list-getv: it
>> takes a type name.  It's unreliable for non-abstract types: it can miss
>> dynamically created properties.
>> 
>> Let's ignore all this for now.
>> 
>>> +
>>> +##
>>> +# @ObjectNode:
>>> +#
>>> +# @name: the name of the node
>>> +#
>>> +# @children: child nodes
>>> +#
>>> +# @properties: properties of the node
>>> +#
>>> +# Since 10.1
>>> +##
>>> +{ 'struct': 'ObjectNode',
>>> +  'data': { 'name': 'str',
>>> +            'children': [ 'ObjectNode' ],
>>> +            'properties': [ 'ObjectPropertyValue' ] }}
>>> +
>>> +##
>>>  # @qom-list:
>>>  #
>>>  # This command will list any properties of a object given a path in
>>> @@ -126,6 +158,30 @@
>>>     'allow-preconfig': true }
>>>   
>>>  ##
>>> +# @qom-tree-get:
>>> +#
>>> +# This command returns a tree of objects and their properties,
>>> +# rooted at the specified path.
>>> +#
>>> +# @path: The absolute or partial path within the object model, as
>>> +#     described in @qom-get
>>> +#
>>> +# Errors:
>>> +#     - If path is not valid or is ambiguous, returns an error.
>> 
>> By convention, we use "If <condition>, <error>, where <error> is a
>> member of QapiErrorClass.
>
> OK.  I was following the minimal Errors examples from this same file.

Yup.  I'll clean them up.

>> What are the possible error classes?  As far as I can tell:
>> 
>>           - If path is ambiguous, GenericError
>>           - If path cannot be resolved, DeviceNotFound
>> 
>> However, use of error classes other than GenericError is strongly
>> discouraged (see error_set() in qapi/error.h).
>> 
>> Is the ability to distinguish between these two errors useful?
>> 
>> Existing related commands such as qom-get also use DeviceNotFound.
>> Entirely undocumented, exact error conditions unclear.  Awesome.
>> 
>> Libvirt seems to rely on this undocumented behavior: I can see code
>> checking for DeviceNotFound.  Hyrum's law strikes.
>> 
>> qom-get fails with DeviceNotFound in both of the above cases.  It fails
>> with GenericError when @property doesn't exist or cannot be read.  Your
>> qom-tree-get fails differently.  Awesome again.
>> 
>> Choices:
>> 
>> 1. Leave errors undocumented and inconsistent.
>> 
>> 2. Document errors for all related commands.  Make the new ones as
>> consistent as we can.
>
> Ignoring qom-tree-get since we are dropping it.
>
> Do you prefer that qom-list-getv be consistent with qom-list (GenericError
> and DeviceNotFound, as created by the common subroutine qom_resolve_path),
> or only return GenericError with a customized message per best practices?

I like to stick to GenericError, I like consistency, I can't have both.
Go with simpler code?

> (Regardless, it will still succeed when @property cannot be read).

Yes, that's a documented feature.

>>> +#     - If a property cannot be read, the value field is omitted in
>>> +#       the corresponding @ObjectPropertyValue.
>> 
>> This is not an error, and therefore doesn't belong here.
>> ObjectPropertyValue's documentation also mentions it.  Good enough?
>
> OK.
>
>>> +#
>>> +# Returns: A tree of @ObjectNode.  Each node contains its name, list
>>> +#     of properties, and list of child nodes.
>> 
>> Hmm.
>> 
>> A struct Object has no name.  Only properties have a name.
>> 
>> An ObjectNode has a name, and an ObjectPropertyValue has a name.
>> 
>> I may get back to this in a later message.

I propose you respin without qom-tree first.  The patches will get
simpler, and review hopefully more focused.

[...]


