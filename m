Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB1DCA0EE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 06:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjvDe-0007pB-1A; Fri, 30 Aug 2024 02:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjvDc-0007js-K9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 02:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjvDa-0007rb-5m
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 02:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724999684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OMNk6goa0JlX+ovkMkqNhM9EyhydxBlU67QtvB812W4=;
 b=gy4rc8xdLB74VdvXhXNfKKtruyDbNnPdI8Lhx0MvmiG8FqITEte/K0+La8q2xhQ/GPVM/z
 l+/GKAWfVWLnauiLq2r6j2xQcCOoBcD7rT0FJrcCRXACOuNqD6UMGj0en0vYeVkAN3G0Mk
 pOiIUz5h/IGvTLm5XCCJrUxrE04L8z4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-uPdHBsnYOhqyoK2SKOwP1Q-1; Fri,
 30 Aug 2024 02:34:40 -0400
X-MC-Unique: uPdHBsnYOhqyoK2SKOwP1Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7B181955BF4; Fri, 30 Aug 2024 06:34:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A99C619560A3; Fri, 30 Aug 2024 06:34:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98F6821E6A28; Fri, 30 Aug 2024 08:34:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  devel@lists.libvirt.org,  Peter Krempa
 <pkrempa@redhat.com>,  Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH] chardev: allow specifying finer-grained reconnect timeouts
In-Reply-To: <icxdvsi5omarzi5f3737npbghj53emlnanafq2wpkcnmzoeiey@w6e2qq57bysx>
 (Eric Blake's message of "Thu, 29 Aug 2024 13:59:47 -0500")
References: <20240816100723.2815-1-d-tatianin@yandex-team.ru>
 <87v7zjleys.fsf@pond.sub.org>
 <icxdvsi5omarzi5f3737npbghj53emlnanafq2wpkcnmzoeiey@w6e2qq57bysx>
Date: Fri, 30 Aug 2024 08:34:35 +0200
Message-ID: <87o75aikn8.fsf@pond.sub.org>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Eric Blake <eblake@redhat.com> writes:

> On Thu, Aug 29, 2024 at 01:56:43PM GMT, Markus Armbruster wrote:
>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>> 
>> > The "reconnect" option only allows to specify the time in seconds,
>> > which is way too long for certain workflows.
>
> ...
>> > @@ -287,7 +292,8 @@
>> >              '*telnet': 'bool',
>> >              '*tn3270': 'bool',
>> >              '*websocket': 'bool',
>> > -            '*reconnect': 'int' },
>> > +            '*reconnect': 'int',
>> > +            '*reconnect-is-ms': 'bool' },
>> >    'base': 'ChardevCommon' }
>> >  
>> >  ##
>> 
>> I don't like this interface.
>> 
>>    PRO: compatible extension; no management application updates needed
>>    unless they want to support sub-second delays.
>> 
>>    CON: specifying a sub-second delay takes two parameters, which is
>>    awkward.
>> 
>>    CON: trap in combination with -set.  Before the patch, something like
>>    -set chardev.ID.reconnect=N means N seconds no matter what.
>>    Afterwards, it depends on the value of reconnect-is-ms, which may be
>>    set far away.  Mitigating factor: -set is obscure.
>
> I also dislike this interface.  Having only one number plus an
> optional boolean that controls its scale is not as easy to reason
> about.
>
>> 
>> Alternatives:
>> 
>> 1. Change @reconnect to 'number', specify sub-second delays as
>>    fractions.
>> 
>>    PRO: compatible extension; no management application updates needed
>>    unless they want to support sub-second delays.
>> 
>>    CON: first use of floating-point for time in seconds in QAPI, as far
>>    as I can see.
>> 
>>    CON: QemuOpts can't do floating-point.
>
> Eww.  I don't see this as the compelling reason to switch to floating point.
>
>> 
>> 2. Deprecate @reconnect in favour of a new member with a more suitable
>>    unit.  Error if both are present.
>> 
>>    PRO: after @reconnect is gone, the interface is what it arguably
>>    should've been from the start.
>> 
>>    CON: incompatible change.  Management application updates needed
>>    within the deprecation grace period.
>
> This seems reasonable to me.

To Daniil as well.  Since Peter is okay with it on behalf of libvirt, so
am I.

>                               We have enough places in QAPI where we
> want mutual exclusion (we mark both fields optional, but expect the
> user to provide exactly one or get an error), that I wonder if it is
> worth making it a first-class construct in QAPI (maybe I'm spoiled by
> the OneOf designation[1] in protobuf[2] used by gRPC[3] in
> kubernetes).

"One of a set of optional members" is a constraint the QAPI language
cannot express, so we have to leave enforcing it to handwritten code,
and documenting it to handwritten comments.

If it could express it, the constraint would be visible in
introspection, and we'd have less handwritten code.  The price is
additional QAPI language and generator complexity.  Sensible tradeoff?
Hard to tell without patches.  Risk: we pay for patches only to find out
the answer is no.  Another risk: we pay for patches, then take them just
because we already paid for them, then continue to pay upkeep.

I don't mean to say such QAPI language enhancements are a bad idea.  I'm
just pointing out the tradeoff to weigh, and the risks to take.

There are more constraints that could be supported by the language,
e.g. integer ranges.

>               Including the scale in the name is a bonus reason to
> switch the interface.

Yes, because the unit isn't obvious from the type.  It is for things
like byte counts, where we've succeeded at sticking to one plain
unit[*].  We failed for time, so there it isn't obvious.

> [1] https://protobuf.dev/programming-guides/proto3/#oneof
> [2] https://protobuf.dev/overview/
> [3] https://grpc.io/
>
>> 
>> Let's get additional input from management application developers.  I
>> cc'ed some.
>> 
>> Related: NetdevSocketOptions member @reconnect.

Could use the same treatment for consistency.  Not a demand.


[*] With few exceptions, such certain rate limits that use MBytes/s.


