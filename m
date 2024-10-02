Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D87CF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzjQ-0004K6-6H; Wed, 02 Oct 2024 09:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svzj6-0004Ia-OQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svzj5-0002Kw-DB
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727876950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zDfauo2eCIRrvRJ1wW9uEyAuuDsgb7maWrb2eeHOB44=;
 b=fLyAHpXETMRj8tfHu8XzneL1KL/Pu+B3sp7jMNr7LAaG3TkOfiGgAdr3uYWeA3Ax+bEiOC
 W624/Q8/sfr4fsw3UGfilv5qLFnLYCS1QVdOM4YqWLZmbn0z70J59AR2dnJX4HtQzmzyt2
 3s2QgzVYaJJJ4TqPH9H3UUc957HMXbk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-ITBloYyMNxadAxg0-abY5g-1; Wed,
 02 Oct 2024 09:49:09 -0400
X-MC-Unique: ITBloYyMNxadAxg0-abY5g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2967E1955D64; Wed,  2 Oct 2024 13:49:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E7E419560A3; Wed,  2 Oct 2024 13:49:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23CFB21E6A28; Wed,  2 Oct 2024 15:49:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  kwolf@redhat.com,  hreitz@redhat.com,
 berrange@redhat.com,  qemu-block@nongnu.org,  den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com,  alexander.ivanov@virtuozzo.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit
 in QMP
In-Reply-To: <20240809161828.1342831-6-eblake@redhat.com> (Eric Blake's
 message of "Fri, 9 Aug 2024 11:14:26 -0500")
References: <20240809161828.1342831-4-eblake@redhat.com>
 <20240809161828.1342831-6-eblake@redhat.com>
Date: Wed, 02 Oct 2024 15:49:02 +0200
Message-ID: <87wmiqy5rl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> Although defaulting the handshake limit to 10 seconds was a nice QoI
> change to weed out intentionally slow clients, it can interfere with
> integration testing done with manual NBD_OPT commands over 'nbdsh
> --opt-mode'.  Expose a QMP knob 'handshake-max-secs' to allow the user
> to alter the timeout away from the default.
>
> The parameter name here intentionally matches the spelling of the
> constant added in commit fb1c2aaa98, and not the command-line spelling
> added in the previous patch for qemu-nbd; that's because in QMP,
> longer names serve as good self-documentation, and unlike the command
> line, machines don't have problems generating longer spellings.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-export.json         | 10 ++++++++++
>  include/block/nbd.h            |  6 +++---
>  block/monitor/block-hmp-cmds.c |  4 ++--
>  blockdev-nbd.c                 | 26 ++++++++++++++++++--------
>  4 files changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index ce33fe378df..c110dd375ad 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -17,6 +17,10 @@
>  #
>  # @addr: Address on which to listen.
>  #
> +# @handshake-max-secs: Time limit, in seconds, at which a client that
> +#     has not completed the negotiation handshake will be disconnected,
> +#     or 0 for no limit (since 9.2; default: 10).
> +#
>  # @tls-creds: ID of the TLS credentials object (since 2.6).
>  #
>  # @tls-authz: ID of the QAuthZ authorization object used to validate
> @@ -34,6 +38,7 @@
>  ##
>  { 'struct': 'NbdServerOptions',
>    'data': { 'addr': 'SocketAddress',
> +            '*handshake-max-secs': 'uint32',
>              '*tls-creds': 'str',
>              '*tls-authz': 'str',
>              '*max-connections': 'uint32' } }
> @@ -52,6 +57,10 @@
>  #
>  # @addr: Address on which to listen.
>  #
> +# @handshake-max-secs: Time limit, in seconds, at which a client that
> +#     has not completed the negotiation handshake will be disconnected,
> +#     or 0 for no limit (since 9.2; default: 10).
> +#
>  # @tls-creds: ID of the TLS credentials object (since 2.6).
>  #
>  # @tls-authz: ID of the QAuthZ authorization object used to validate
> @@ -72,6 +81,7 @@
>  ##
>  { 'command': 'nbd-server-start',
>    'data': { 'addr': 'SocketAddressLegacy',
> +            '*handshake-max-secs': 'uint32',
>              '*tls-creds': 'str',
>              '*tls-authz': 'str',
>              '*max-connections': 'uint32' },

Are we confident we'll never need less than a full second?

[...]


