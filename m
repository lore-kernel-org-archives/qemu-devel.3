Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914C3C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVcq-0001N8-PT; Tue, 04 Jun 2024 10:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEVcp-0001Ma-7z
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEVcn-00052L-G1
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717513135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZmEwnMSm8S3niIWGQ4Wbt4HKv4oA4g6fGRw+/0YiZc=;
 b=NWJQCuE0fHFBQEKpij0cDa+JZ9J3t3VeXkusqe5elGclZWtxa8GsXP3ktLa6UCPMQYmqWO
 tEqj/zyajS2BxLxe/M5mWAcBReHgY2u9SHkpZJzMzXKJqRmVyY711xErZPlrvSlF26U0ay
 WGJDL3Ih5z35rYU+XXu7dW61Q4xArcs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-KmaWKtJUP3WA0a8IEtrI-g-1; Tue,
 04 Jun 2024 10:58:54 -0400
X-MC-Unique: KmaWKtJUP3WA0a8IEtrI-g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA98A18E6E29; Tue,  4 Jun 2024 14:58:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4FA01955D87; Tue,  4 Jun 2024 14:58:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA99421E66E5; Tue,  4 Jun 2024 16:58:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Eric
 Blake <eblake@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi: clarify that the default is backend dependent
In-Reply-To: <a5rtqdvsqevk2pobqipmfiv5eazr5koffe3tn372i7bojpshhg@q7uxoverycvu>
 (Stefano Garzarella's message of "Tue, 4 Jun 2024 15:21:15 +0200")
References: <20240523133302.103858-1-sgarzare@redhat.com>
 <877cf61ib1.fsf@pond.sub.org>
 <a5rtqdvsqevk2pobqipmfiv5eazr5koffe3tn372i7bojpshhg@q7uxoverycvu>
Date: Tue, 04 Jun 2024 16:58:49 +0200
Message-ID: <875xuo69g6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Mon, Jun 03, 2024 at 11:34:10AM GMT, Markus Armbruster wrote:
>>Stefano Garzarella <sgarzare@redhat.com> writes:
>>
>>> The default value of the @share option of the @MemoryBackendProperties
>>> eally depends on the backend type, so let's document it explicitly and
>>> add the default value where it was missing.
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>> I followed how we document @share in memfd and epc, but I don't like it
>>> very much, I just can't think of a better way, so if you have a suggestion
>>> I can change them in all of them.
>>>
>>> Thanks,
>>> Stefano
>>> ---
>>>  qapi/qom.json | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 38dde6d785..8463bd32a2 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -600,7 +600,7 @@
>>   ##
>>   # @MemoryBackendProperties:
>>   #
>>   # Properties for objects of classes derived from memory-backend.
>>   #
>>
>>[...]
>>
>>>  #     preallocation threads (default: none) (since 7.2)
>>>  #
>>>  # @share: if false, the memory is private to QEMU; if true, it is
>>> -#     shared (default: false)
>>> +#     shared (default depends on the backend type)
>>
>>Note for later: the backends are the branches of ObjectOptions that use
>>MemoryBackendProperties as branch type or as base of their branch type.
>>These are
>>
>>    memory-backend-epc (uses MemoryBackendEpcProperties)
>>    memory-backend-file (uses MemoryBackendFileProperties)
>>    memory-backend-memfd (uses MemoryBackendMemfdProperties)
>>    memory-backend-ram (uses MemoryBackendProperties)
>>
>>>  #
>>>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>>>  #     (default: true) (since 6.1)
>>> @@ -639,6 +639,8 @@
>>>  #
>>>  # Properties for memory-backend-file objects.
>>>  #
>>> +# The @share boolean option is false by default with file.
>>> +#
>>>  # @align: the base address alignment when QEMU mmap(2)s @mem-path.
>>>  #     Some backend stores specified by @mem-path require an alignment
>>>  #     different than the default one used by QEMU, e.g. the device DAX
>>
>>As stated in the commit message, this matches existing documentation in
>>memory-backend-epc
>>
>>   # The @share boolean option is true by default with epc
>>
>>and memory-backend-memfd
>>
>>   # The @share boolean option is true by default with memfd.
>>
>>I think "with FOO" could be clearer.  Perhaps something like "with
>>backend 'memory-backend-FOO'.
>
> Ack, I'll do.
>
>>
>>However, even with your patch, we're still missing memory-backend-ram.
>>I can see two solutions:
>>
>>1. Create MemoryBackendRamProperties just to have a place for
>>documenting @share's default.
>>
>>2. Document @share's default right where it's defined, roughly like
>>this:
>>
>>   # @share: if false, the memory is private to QEMU; if true, it is
>>   #     shared (default false for backends memory-backend-file and
>>   #     memory-backend-ram, true for backends memory-backend-epc and
>>   #     memory-backend-memfd)
>>
>>CON: we need to remember to update this whenever we add another backend.
>>
>>PRO: generated documentation is better, in my opinion.
>>
>>Thoughts?
>>
>
> Maybe option 2 is slightly better and it's also clearer how to document the default for other backends.
>
> When I added a new backend, it was not clear to me how to define the default for an inherited parameter.
>
> I would go with 2 if you agree.

I actually like 2 better :)


