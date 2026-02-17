Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2A0E6817A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 12:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsK9c-0003rk-9B; Tue, 17 Feb 2026 07:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsK9M-0003hw-NE
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 07:25:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsK9I-0000tm-OR
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 07:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771331151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zG9nbBMpSkASCJNW+/hK46qBLNsO37PRXzmzdP2v3ks=;
 b=KG9UwnBQZlOPiLqFmuV7V4n0sgyhoORzrXC+xc5gw6rtrkcxCKkdBhNO8VqAqeJ3DXdFom
 +WFTUizi+A/POMABXtEcuh4Nym5zcgaOSbG9F78OPDvOaajpOfg4DJNekvODB+Pt2JIES4
 UEaeOji+0vHbLaEeXtTCZOKIhOmAbbE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-W974cedtOXq6XXuw4DKTbw-1; Tue,
 17 Feb 2026 07:25:48 -0500
X-MC-Unique: W974cedtOXq6XXuw4DKTbw-1
X-Mimecast-MFC-AGG-ID: W974cedtOXq6XXuw4DKTbw_1771331147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D5991955F16; Tue, 17 Feb 2026 12:25:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0556F30001A5; Tue, 17 Feb 2026 12:25:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7598E21E692D; Tue, 17 Feb 2026 13:25:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eduardo@habkost.net,
 berrange@redhat.com,  pbonzini@redhat.com,  eblake@redhat.com,
 devel@lists.libvirt.org,  hreitz@redhat.com,  kwolf@redhat.com
Subject: Re: [PATCH v11 8/8] deprecate names duplication between qdev,
 block-node and block-export
In-Reply-To: <94f379d8-4e9d-48fb-9529-c05251fdebab@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 16 Feb 2026 10:25:43 +0300")
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260122160113.1147745-1-vsementsov@yandex-team.ru>
 <87qzr0y990.fsf@pond.sub.org>
 <74b1555d-1e4f-4be2-85e4-902f9670e435@yandex-team.ru>
 <877bsf23y4.fsf@pond.sub.org>
 <94f379d8-4e9d-48fb-9529-c05251fdebab@yandex-team.ru>
Date: Tue, 17 Feb 2026 13:25:42 +0100
Message-ID: <878qcrlfp5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 14.02.26 10:13, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> On 04.02.26 15:38, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>
>>>>> Now we have blockdev-replace QMP command, which depend on a possibility
>>>>> to select any block parent (block node, block export, or qdev) by one
>>>>> unique name. The command fails, if name is ambiguous (i.e., match
>>>>> several parents of different types). In future we want to rid of this
>>>>> ambiguity.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>
>>>> We have numerous kinds of IDs, i.e. names chosen by the user than need
>>>> to be unique, but only among the same kind.  For instance, you can't
>>>> name two block nodes "foo", but you can name a block node, a block
>>>> export, a qdev, and a network backend "foo".  Using the same ID for
>>>> multiple things is of course a bad idea.  Permitting it was also a bad
>>>> idea.
>>>>
>>>> Your patch rectifies this design mistake, but only partially.  Consider:
>>>>
>>>> * IDs need to be unique with their kind.  This is what we have now.  I
>>>>    don't like it.
>>>>
>>>> * IDs need to be unique among their kind and possibly some set of
>>>>     additional kinds.  This is where your patch takes us.  I like it even
>>>>    less, to be honest.
>>>>
>>>> * IDs need to be unique, period.  This is what I'd like to have.
>>>
>>> I like it. Is it enough to write it so simple in deprecation doc? Or should
>>> we still list all such ids we have in QEMU?
>>>
>>> It may be something like:
>>>
>>> Any kind of IDs you use to reference objects in QEMU must be unique, any
>>> used ID must reference exactly one object. This includes, but is not limited
>>> to qdev full and relative to "/peripheral/" paths, block-node and block-export
>>> names.
>> 
>> This would serve as a declaration of intent.  Better than nothing, I
>> guess.
>> 
>> To enforce uniqueness, we'll have to create a single table of IDs.
>> 
>> If we make it a set, we can reject duplicate IDs, but can't point to the
>> other ID.  Meh.
>> 
>> If we make it map to the kind of ID, we can report the kind.  Something
>> like "block node name 'foo' clashes with block export ID 'foo'".  Feels
>> adequate.
>> 
>> If we make it map the the object the ID identifies, we can get rid of
>> existing means to map from ID to object.  May or may not be worthwhile.
>> 
>> If we create the single table of IDs now rather than later, we can warn.
>> Something like "duplicate IDs are deprecated: block node name 'foo'
>> clashes with block export ID 'foo'".  Much more likely to get users'
>> attention than a note in docs/about/deprecated.rst.
>> 
>> We could even wire it to the "-compat deprecated-input=..." machinery
>> (I'd assist with that).  This would let people test their software is
>> ready for enforced unique IDs.
>> 
>> Thoughts?
>> 
>
>
> Sounds good. At least, I may try to make a common function, to be used both
> on object creation and from blockdev-replace to check for ambiguity.
>
>
> Now, another thought come in my mind:
>
> Shouldn't we instead of uniting different name-spaces, select qom-path as a
> primary source of object referencing?
> So, simple reserve "block/export/EXPORT_NAME" for exports and
> "block/node/NODE_NAME" for nodes?

Making everything a QOM object has some merit.  However, we'd have to
push QOMification pretty far.

Some ID kinds are already in QOM.  For instance, -device id=foo,...
creates "/machine/peripheral/foo", and -object id=bar,.. creates
"/objects/bar".

Some ID kinds could and quite possibly should be in QOM, such as device
backends: -chardev, -netdev, ...

What about monitors?  -mon & friends.  Having them in QOM wouldn't hurt,
I guess, but would it be worth the churn?

What about -rtc?  -global?  -action?

> I imaging, if we simply "deprecate duplicating IDs", this will force libvirt
> and others to include object type into the id, so they may start use block
> node names like "block-node-disk1", and block export names like "block-export-disk1".

Question for libvirt developers: would any living version of libvirt use
the same ID for different kinds of IDs?

> We can be proactive, providing a common path for "foldering" IDs.
>
> This way, node-name becomes "relative" QOM path, and may be used in context where
> only node-name could be used (all existing use cases in the API now), but in interfaces,
> where may be used objects of different kinds (like new blockdev-replace) the full
> path is preferred (or even required).

As is, we cannot define IDs as relative QOM paths even for the kinds of
IDs that are already in QOM.

Say we have both a device and an object with ID "foo".  The device's QOM
path is "/machine/peripheral/foo".  The object's is "/objects/foo".  The
relative QOM path "foo" is then ambiguous, and won't resolve.


