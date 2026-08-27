Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5859AC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVUN-0005Hp-Ln; Thu, 27 Aug 2026 04:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wzVUD-0005HU-QW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wzVUC-0004Mq-2Q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787819363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=moe4i2TB3rWxKEUGFbSTbZj84HcKiuBYaXSxRH8MhBw=;
 b=TNAqpu+a0rAHPs0Ely/hiGnpg92vBsG0ui/jGWbYPcM1o6IQ16ZD5PvLNb0bmdMc64ry6K
 b6RcRmxjb3vLcmcO5fHy91AHQ+69y1Cclgqxoh0zA36QJ2BLJWuvycnl+GzxgmfaBTgPDI
 gx0fG19HaWqEwZQEDpxI4+nk7uDsSuA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-0ptwhhbUMQmgWU82wcwUSw-1; Thu,
 27 Aug 2026 04:29:19 -0400
X-MC-Unique: 0ptwhhbUMQmgWU82wcwUSw-1
X-Mimecast-MFC-AGG-ID: 0ptwhhbUMQmgWU82wcwUSw_1787819358
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C0E219774F8; Thu, 27 Aug 2026 08:29:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B595C18005AD; Thu, 27 Aug 2026 08:29:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F4B321E6920; Thu, 27 Aug 2026 10:29:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 19/25] parallels: report the stored dirty bitmaps in
 qemu-img info
In-Reply-To: <84b7646d-0567-4af5-be98-a62f49beb963@virtuozzo.com> (Denis
 V. Lunev's message of "Wed, 26 Aug 2026 18:45:54 +0200")
References: <20260817185942.1065143-1-den@openvz.org>
 <20260817185942.1065143-20-den@openvz.org>
 <878q5uo9a6.fsf@pond.sub.org>
 <84b7646d-0567-4af5-be98-a62f49beb963@virtuozzo.com>
Date: Thu, 27 Aug 2026 10:29:15 +0200
Message-ID: <87v78wezl0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"Denis V. Lunev" <den@virtuozzo.com> writes:

> On 8/25/26 11:10, Markus Armbruster wrote:
>> "Denis V. Lunev" <den@openvz.org> writes:
>>
>>> From: Denis V. Lunev <den@openvz.org>
>>>
>>> Nothing tells which persistent bitmaps an image carries. qemu-img info
>>> says nothing about them, and the only other way to see one is to export
>>> the image over NBD and ask for a bitmap by name, which needs the name
>>> beforehand.
>>>
>>> Add ImageInfoSpecificParallels with the bitmaps and their granularity,
>>> as qcow2 reports the contents of its bitmap directory:
>>>
>>>     Format specific information:
>>>         bitmaps:
>>>             [0]:
>>>                 name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
>>>                 granularity: 65536
>>>
>>> The list is built from the bitmaps loaded at open time rather than from
>>> a second pass over the Format Extension, as every bitmap the extension
>>> carries is loaded and marked persistent there. On a node which is open
>>> that also covers a bitmap which was created but not stored yet, which is
>>> what the field says: qemu-img info opens the image on its own, so there
>>> the two are the same thing.
>>
>> The last sentence confuses me.
>>
>>> An image with no bitmaps leaves the structure empty, and
>>> bdrv_image_info_specific_dump() prints nothing for an empty one, so the
>>> output for such an image does not change.
>>
>> Output of what?  I guess it's "info block" and "qemu-img info", because
>> these call bdrv_image_info_specific_dump().
> For the image (BDS) without dirty bitmaps the output
> of 'qemu-img info' would be the same as with and
> without a patch.

Suggest to clarify 'the output' to something like 'the output of
"qemu-img info" and "info block"'.

>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> [...]
>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 1f87b07850..4bc8b45efe 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -200,7 +200,7 @@
>>>  # Since: 1.7
>>>  ##
>>>  { 'enum': 'ImageInfoSpecificKind',
>>> -  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
>>> +  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'parallels' ] }
>>>  
>>>  ##
>>>  # @ImageInfoSpecificQCow2Wrapper:
>>> @@ -255,6 +255,41 @@
>>>  { 'struct': 'ImageInfoSpecificFileWrapper',
>>>    'data': { 'data': 'ImageInfoSpecificFile' } }
>>>  
>>> +##
>>> +# @ParallelsBitmapInfo:
>>> +#
>>> +# Parallels dirty bitmap information.
>>> +#
>>> +# @name: the name of the bitmap
>>> +#
>>> +# @granularity: granularity of the bitmap in bytes
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'struct': 'ParallelsBitmapInfo',
>>> +  'data': { 'name': 'str', 'granularity': 'uint32' } }
>>> +
>>> +##
>>> +# @ImageInfoSpecificParallels:
>>> +#
>>> +# @bitmaps: A list of the persistent dirty bitmaps of the image,
>>> +#     including the ones which are not written out yet
>>
>> Pardon my ignorance...  Is "not written out yet" relevant to a user /
>> management application?
> This means that the image on disk could contains
> bitmaps A and B while backup software has added
> bitmap C to BDS. The query will return A, B, C.
> This is same as for QCOW2.

Will bitmap C be written to the image, and when?

>> ImageInfoSpecificQCow2 also has a @bitmaps member.  Its documentation is
>>
>>    # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>>
>> Are these "persistent dirty bitmaps" as well, or something else?
> same, as above

If they're basically the same, then their documentation should be
basically the same.

>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'struct': 'ImageInfoSpecificParallels',
>>> +  'data': { '*bitmaps': ['ParallelsBitmapInfo'] } }

[...]


