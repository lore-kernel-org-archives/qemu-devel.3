Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4B60A2637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dxB9sClR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQlLt-0006Dd-MH; Tue, 10 Nov 2026 07:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQlLi-0006C4-Nu
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:53:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQlLf-0000F1-K4
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794315193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pVjUgvl9EK0gMiDAcTtimJk55MUizPfvyKD2CEsHiis=;
 b=dxB9sClRYnLMQh5TcS5OPm07qSbqiUpL48EDy+R1pjbntHVC9PKZlLiXCvqF56JTbTdGgq
 VdRs2fu1AWgfFzicxOEWc927rD6CfiB5Fugw9MFWXZ8dlP32XNDY9UepXGL16IegME72ur
 1wfaxFfjIyUwodezEZF76+obYV0G2qQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-kMX8yuwVNneuTy7ATC77YQ-1; Tue,
 10 Nov 2026 07:53:12 -0500
X-MC-Unique: kMX8yuwVNneuTy7ATC77YQ-1
X-Mimecast-MFC-AGG-ID: kMX8yuwVNneuTy7ATC77YQ_1794315191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B78E41800259; Tue, 10 Nov 2026 12:53:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC13B180034C; Tue, 10 Nov 2026 12:53:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BFC121E6A04; Tue, 10 Nov 2026 13:53:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: <qemu-devel@nongnu.org>,  <qemu-block@nongnu.org>,  <eblake@redhat.com>,
 <vsementsov@yandex-team.ru>,  <kwolf@redhat.com>,  <hreitz@redhat.com>
Subject: Re: [PATCH 1/2] nbd: Add an unstable query for the client state
In-Reply-To: <20261109160609.1434289-2-guillaume.vincke@ovhcloud.com>
 (Guillaume Vincke's message of "Mon, 9 Nov 2026 17:06:08 +0100")
References: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
 <20261109160609.1434289-2-guillaume.vincke@ovhcloud.com>
Date: Tue, 10 Nov 2026 13:53:07 +0100
Message-ID: <87v764yhjg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Guillaume Vincke <guillaume.vincke@ovhcloud.com> writes:

> At the moment, NBD client internals cannot be accessed. Therefore,
> tests have to infer the client state from I/O results and wait with
> sleeps, which is racy.
>
> Add the x-debug-query-nbd-client QMP command that reports the state of
> the client's connection and of its connector. Other fields will be
> added when needed.
>
> The next patch uses this command to make the nbd-stale-connection test
> deterministic.
>
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 23c5787d99..973be06dfd 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

Why block-core.json and not block-export.json?

> @@ -2217,6 +2217,85 @@
>    'features': [ 'unstable' ],
>    'allow-preconfig': true }
>  
> +##
> +# @XDbgNbdClientState:
> +#     Enum of NBD client state.

"An enumeration of NBD client states" for consistency with enum
descriptions elsewhere.  Or maybe simply "NBD client state".

> +#
> +# @connecting-wait: No active connection.  A request waits for the
> +#     connection attempt to finish, while reconnect-delay has not
> +#     expired.
> +#
> +# @connecting-nowait: No active connection.  A request fails at once
> +#     if no channel is ready.
> +#
> +# @connected: Client has a valid connection.

Double-checking: when we're in this state, there is a client connected.
Correct?

> +#
> +# @quit: Client will not reconnect.

What does this one mean exactly?

> +#
> +# Since: 11.2

Making 11.2 seems unlikely.

> +##
> +{ 'enum': 'XDbgNbdClientState',
> +  'data': [ 'connecting-wait', 'connecting-nowait', 'connected', 'quit' ] }
> +
> +##
> +# @XDbgNbdClientConnectorState:
> +#     Enum of NBD client connector state.

Again, "Enumeration of ... states".

> +#
> +# @running: Connection attempt is in progress.
> +#
> +# @parked: Connection was successful and channel is kept for the next
> +#     request.
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'XDbgNbdClientConnectorState',
> +  'data': [ 'running', 'parked' ] }
> +
> +##
> +# @XDbgNbdClientConnector:
> +#     The NBD connector information.
> +#
> +# @state: State of the connector.
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'XDbgNbdClientConnector',
> +  'data': { 'state': 'XDbgNbdClientConnectorState' } }
> +
> +##
> +# @XDbgNbdClient:
> +#     The NBD connection state of the client and its connector.
> +#     The two members are read independently and may not reflect a
> +#     single point in time.

That's unfortunate.  It'll do for debugging.  Could it create robustness
issues in tests?

> +#
> +# @state: The client state.
> +#
> +# @connector: The connector details.  Only present while a connection
> +#     attempt is running or its channel is parked.
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'XDbgNbdClient',
> +  'data': { 'state': 'XDbgNbdClientState',
> +            '*connector': 'XDbgNbdClientConnector' } }

How the combined state machine works is not clear to me.  Is it
documented anywhere?

> +
> +##
> +# @x-debug-query-nbd-client:
> +#     Get the NBD client state.
> +#
> +# @node-name: node name of the NBD client to query.

How would I find the valid node names?  query-block-exports?

> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging and testing.
> +#
> +# Since: 11.2
> +##
> +{ 'command': 'x-debug-query-nbd-client',
> +  'data': { 'node-name': 'str' },
> +  'returns': 'XDbgNbdClient',
> +  'features': [ 'unstable' ] }
> +
>  ##
>  # @drive-mirror:
>  #     Start mirroring a block device's writes to a new destination.


