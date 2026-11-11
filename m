Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C3D606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=APkwztwT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9Df-0005hz-Hr; Wed, 11 Nov 2026 09:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR9Dd-0005bz-Ft
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR9Db-0003Vl-Cb
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794406950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yv8CrgdL2LpHTxugwJoHqrLCbN6PJe1uf9sAo0QUrYo=;
 b=APkwztwT4cdW8HfDe5537+4kxMzBwIAjCA6OGu3f7onkQp+2JdTbm9KkyuAle0+KFXw6V/
 T9CYkMZIFCR79AfWjoL3FFSaYQXFfHj32Ey0sOP5rjN+c8uZZu7I4iGmy8gakUfkKB2f/p
 eGoGqbFzt60cjTjd6rRkwo3VMofdMVM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-wN3bYq3SO2Km90wapZv8vA-1; Wed,
 11 Nov 2026 09:22:28 -0500
X-MC-Unique: wN3bYq3SO2Km90wapZv8vA-1
X-Mimecast-MFC-AGG-ID: wN3bYq3SO2Km90wapZv8vA_1794406947
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B641819540DD; Wed, 11 Nov 2026 14:22:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD86A19634E9; Wed, 11 Nov 2026 14:22:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DBF421E6A04; Wed, 11 Nov 2026 15:22:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: guillaume vincke <guillaume.vincke@ovhcloud.com>
Cc: <qemu-devel@nongnu.org>,  <qemu-block@nongnu.org>,  <eblake@redhat.com>,
 <vsementsov@yandex-team.ru>,  <kwolf@redhat.com>,  <hreitz@redhat.com>
Subject: Re: [PATCH 1/2] nbd: Add an unstable query for the client state
In-Reply-To: <730c1463-8dfb-4040-9c61-330882320d7c@ovhcloud.com> (guillaume
 vincke's message of "Tue, 10 Nov 2026 16:07:35 +0100")
References: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
 <20261109160609.1434289-2-guillaume.vincke@ovhcloud.com>
 <87v764yhjg.fsf@pond.sub.org>
 <730c1463-8dfb-4040-9c61-330882320d7c@ovhcloud.com>
Date: Wed, 11 Nov 2026 15:22:23 +0100
Message-ID: <87h5hntpls.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

guillaume vincke <guillaume.vincke@ovhcloud.com> writes:

> On 11/10/26 13:53, Markus Armbruster wrote:
>
> Thanks for the review. Let me clarify before posting a v2.
>
>> Why block-core.json and not block-export.json?
>
> If I get this right, block-export.json covers the server part. I
> thought adding this next to BlockdevOptionsNbd was a better fit. I can
> change that in v2 if you think block-export.json is a better match.

My question was a question, not a change request :)

>>> +#
>>> +# @connecting-wait: No active connection.  A request waits for the
>>> +#     connection attempt to finish, while reconnect-delay has not
>>> +#     expired.
>>> +#
>>> +# @connecting-nowait: No active connection.  A request fails at once
>>> +#     if no channel is ready.
>>> +#
>>> +# @connected: Client has a valid connection.
>>
>> Double-checking: when we're in this state, there is a client connected.
>> Correct?
>
> Yes. This is a client state that describes the connection as valid: the
> channel got negotiated and is ready to process requests.
>
>> 
>>> +#
>>> +# @quit: Client will not reconnect.
>>
>> What does this one mean exactly?
>
> The client stopped for good. Requests fail and it never reconnects.
> This state is reached on fatal error or teardown.

Work some of that into the description?

>>> +#
>>> +# Since: 11.2
>>
>> Making 11.2 seems unlikely.
>
> Sure. Would updating this to 12.0 make more sense ?

Yes.

>>> +#
>>> +# @running: Connection attempt is in progress.
>>> +#
>>> +# @parked: Connection was successful and channel is kept for the next
>>> +#     request.
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'enum': 'XDbgNbdClientConnectorState',
>>> +  'data': [ 'running', 'parked' ] }
>>> +
>>> +##
>>> +# @XDbgNbdClientConnector:
>>> +#     The NBD connector information.
>>> +#
>>> +# @state: State of the connector.
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'struct': 'XDbgNbdClientConnector',
>>> +  'data': { 'state': 'XDbgNbdClientConnectorState' } }
>>> +
>>> +##
>>> +# @XDbgNbdClient:
>>> +#     The NBD connection state of the client and its connector.
>>> +#     The two members are read independently and may not reflect a
>>> +#     single point in time.
>>
>> That's unfortunate.  It'll do for debugging.  Could it create robustness
>> issues in tests?
>
> On the nbd-stale-connection test it is not a problem but I can try to
> take the locks together in v2.

Worth a try, I guess.

>>> +#
>>> +# @state: The client state.
>>> +#
>>> +# @connector: The connector details.  Only present while a connection
>>> +#     attempt is running or its channel is parked.

When exactly is this member present?

Is it always present when @state has certain values, and never present
when it doesn't?  Or is it more complicated?

>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'struct': 'XDbgNbdClient',
>>> +  'data': { 'state': 'XDbgNbdClientState',
>>> +            '*connector': 'XDbgNbdClientConnector' } }
>>
>> How the combined state machine works is not clear to me.  Is it
>> documented anywhere?
>
> I did not find a proper documentation. I found the comments on the code
> to be quite explicit though. The connector only runs in a connecting-*
> state. In that state, when processing a request, the client tries to
> get the channel from the connector. When the connector has a valid
> channel but the client did not request it, the connector is in parked
> state. Do you think this command should document that behavior?

Perhaps the doc comments are good enough for a debugging command to be
used by people who know how the state machine works.

I don't, I've read the doc comments several times, and the state machine
is still a mystery to me.  Can we do better with reasonable effort?

>>> +
>>> +##
>>> +# @x-debug-query-nbd-client:
>>> +#     Get the NBD client state.
>>> +#
>>> +# @node-name: node name of the NBD client to query.
>>
>> How would I find the valid node names?  query-block-exports?
>
> The node-name is listed by query-named-block-nodes or is the one passed
> to blockdev-add. I will add a reference to those commands in the
> docstring to clarify.

What exactly makes such a node name an "NBD client"?


