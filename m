Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C54606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=ecsPyxmy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSu7Q-00011R-Vq; Mon, 16 Nov 2026 05:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xSu7D-00010k-B7; Mon, 16 Nov 2026 05:39:13 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xSu7A-0002kf-RK; Mon, 16 Nov 2026 05:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1794825537; bh=E1R86gPCGNgy2YGRbdL5Vp6wl4LEYeHEWHqV6qyhlhE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ecsPyxmylxxD+vxWxWd+F3y5Z/2W7x/23hy7ezYT/ppA3a97mivj8gCBeIrJQJcec
 mr7tLLGJbqvLK8xXdQ2MI5KJfAEdIocgDoseXW4MABkTDqXHJY87NFATiN3DZpjwY4
 qBmxpbS+MsEePEx7l1BU+LBFTsEWk1xhDx0M+w7U=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 598092011D;
 Mon, 16 Nov 2026 11:38:56 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 731E821E6A04; Mon, 16 Nov 2026 11:39:01 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: <qemu-devel@nongnu.org>,  <qemu-block@nongnu.org>,  <eblake@redhat.com>,
 <vsementsov@yandex-team.ru>,  <kwolf@redhat.com>,  <hreitz@redhat.com>,
 <armbru@redhat.com>
Subject: Re: [PATCH v2 1/2] nbd: Add an unstable query for the client state
In-Reply-To: <20261113140852.702959-2-guillaume.vincke@ovhcloud.com>
 (Guillaume Vincke's message of "Fri, 13 Nov 2026 15:08:51 +0100")
References: <20261113140852.702959-1-guillaume.vincke@ovhcloud.com>
 <20261113140852.702959-2-guillaume.vincke@ovhcloud.com>
Date: Mon, 16 Nov 2026 11:39:01 +0100
Message-ID: <875wxxqcvu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
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
> index 23c5787d99..0aa3ced3fe 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2217,6 +2217,93 @@
>    'features': [ 'unstable' ],
>    'allow-preconfig': true }
>  
> +##
> +# @XDbgNbdClientState:
> +#     An enumeration of NBD client states.
> +#
> +# @connecting-wait: No active connection.  Reached when the client
> +#     hits an I/O error.  A request waits for the connection attempt
> +#     to finish, while reconnect-delay has not expired.
> +#
> +# @connecting-nowait: No active connection.  Reached when
> +#     reconnect-delay expires.  A request fails at once if no channel
> +#     is ready.
> +#
> +# @connected: Client has a valid connection.  Reached when a request
> +#     gets a channel from the connector.
> +#
> +# @quit: Client stopped and will never reconnect.  New requests
> +#     fail.  A running attempt or a parked channel stays until the
> +#     node is closed.  Reached on fatal error, teardown or yank.
> +#
> +# Since: 12.0
> +##
> +{ 'enum': 'XDbgNbdClientState',
> +  'data': [ 'connecting-wait', 'connecting-nowait', 'connected', 'quit' ] }
> +
> +##
> +# @XDbgNbdClientConnectorState:
> +#     An enumeration of NBD client connector states.
> +#
> +# @idle: No connection attempt running and no parked channel.  In
> +#     'connecting-wait' or 'connecting-nowait', the next request
> +#     starts an attempt.
> +#
> +# @running: Connection attempt is in progress.  A request waits or
> +#     fails, as described in 'connecting-wait' and
> +#     'connecting-nowait'.
> +#
> +# @parked: Connection was successful and channel is kept.  The next
> +#     request takes the channel and the client goes to 'connected'.
> +#
> +# Since: 12.0
> +##
> +{ 'enum': 'XDbgNbdClientConnectorState',
> +  'data': [ 'idle', 'running', 'parked' ] }
> +
> +##
> +# @XDbgNbdClientConnector:
> +#     The NBD connector information.
> +#
> +# @state: State of the connector.
> +#
> +# Since: 12.0
> +##
> +{ 'struct': 'XDbgNbdClientConnector',
> +  'data': { 'state': 'XDbgNbdClientConnectorState' } }
> +
> +##
> +# @XDbgNbdClient:
> +#     The NBD connection state of the client and its connector.
> +#
> +# @state: The client state.
> +#
> +# @connector: The connector details.
> +#
> +# Since: 12.0
> +##
> +{ 'struct': 'XDbgNbdClient',
> +  'data': { 'state': 'XDbgNbdClientState',
> +            'connector': 'XDbgNbdClientConnector' } }

You got rid of "The two members are read independently and may not
reflect a single point in time."  Good!

You also made @connector mandatory.  I think that simplified things.

I could grill you some more on the state machine.  Bah, the doc comemnts
are good enough for a testing / debugging command.

> +
> +##
> +# @x-debug-query-nbd-client:
> +#     Get the NBD client state.
> +#
> +# @node-name: node name of a block node using the nbd driver.
> +#     Use `query-named-block-nodes` to list block nodes.
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging and testing.
> +#
> +# Since: 12.0
> +##
> +{ 'command': 'x-debug-query-nbd-client',
> +  'data': { 'node-name': 'str' },
> +  'returns': 'XDbgNbdClient',
> +  'features': [ 'unstable' ] }
> +
>  ##
>  # @drive-mirror:
>  #     Start mirroring a block device's writes to a new destination.

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

