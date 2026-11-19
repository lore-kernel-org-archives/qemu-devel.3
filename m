Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A4606A33A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bz1Dm0Gg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU4s2-0001py-Uj; Thu, 19 Nov 2026 11:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU4s0-0001pM-Jd
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:20:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU4ry-0007tj-JA
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795105216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V9AmFpKii5Kis4THF2EJNXf/b+YdWpDyc6ERXpAsj7k=;
 b=bz1Dm0GgmpV9EjfEzvlRGySQ4WYpRtTckwLeClB9a9k9jcNi0XqH+o8iGwkb5Y6O9mcMi3
 J1DA+8UsxKzu3YeMwZiOhhRTuQxdZp2TIpRwPW4+7nK4cNThsjsMn3yeaMo8aom3CX5jrX
 DggCzPD2/m9Uon8BJy01rM8y86Kn/9M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-kRyujPasNOyW-WaCvysGrg-1; Thu,
 19 Nov 2026 11:20:14 -0500
X-MC-Unique: kRyujPasNOyW-WaCvysGrg-1
X-Mimecast-MFC-AGG-ID: kRyujPasNOyW-WaCvysGrg_1795105213
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DE731800589; Thu, 19 Nov 2026 16:20:12 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64D2C3000223; Thu, 19 Nov 2026 16:20:09 +0000 (UTC)
Date: Thu, 19 Nov 2026 10:20:06 -0600
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, nbd@other.debian.org
Subject: Re: [PATCH 0/5] block/nbd: Fix block resize on idle device
Message-ID: <av8d_ufYpxKMw4qk@redhat.com>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[cc NBD list for a protocol discussion]

On Thu, Nov 19, 2026 at 03:46:27PM +0100, Guillaume Vincke wrote:
> When using an NBD backed device, the size is exchanged during
> handshake. Therefore, when a volume gets resized on the target, it
> closes its clients' connections to force a new handshake. Then,
> management like OpenStack calls the block_resize QMP command to update
> the node size.
> This method works on active devices but, considering the NBD client
> reconnection is lazy, the handshake does not happen on idle ones which
> leads to a "Cannot grow NBD nodes" error when calling block_resize.
> 
> This patchset adds a function to manually trigger reconnection on an
> NBD device and calls it in the block_resize QMP command to make sure
> the new size gets exchanged before trying to update the device
> internals. It also implements the refresh callback in the raw and luks
> drivers, which forward it to their file child.

Before I even review this series, I wonder if it is time to consider
reviving discussion on the upstream NBD protocol mailing list about an
extension to allow NBD to optionally support resize messages.

If I recall the last time it was discussed several years ago, there
are competing needs: some scenarios want resize to be driven by the
server (for example, in response to a high-water write event done by
the client, the server detects that storage should grow; now the
server needs to advertise to the client that the exported volume is
larger); and some want it to be driven by the client (the client wants
to specifically ask the server for the export size to grow; the server
may or may not be able to comply).  NBD is normally client-driven, so
a client asking the server for a new size is easy to implement by
documenting a new NBD_CMD_RESIZE (in fact, opcode 8 is already
reserved for this in the NBD protocol document).

But the server being able to advertise a new size to the client is an
event-driven task, not client-driven.  Here, structured commands and
the fact that the protocol allows out-of-order responses appears to
provide a nice solution - the idea was that a new command initiated by
the client requests an open-ended registration of resize events, and
the server can reply with as many chunks as wanted over a long length
of time reusing the client's cookie, and not using the
NBD_REPLY_FLAG_DONE flag to end the stream of reply chunks until the
client deregisters from the request (either two new NBD_CMD to
register/deregister, or one command with a client flag to request
registration or deregistration).

Ultimately, having NBD able to support live resizes will be even nicer
than forcing client reconnections just to learn a new server size.
That said, your series probably still has merit, because even if we
extend the NBD protocol to allow live resize, it may take a while
before both client and server ends are upgraded to understand the new
protocol extension, while this reconnection should work with older
protocol.

> 
> Based-on: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
> Needed to detect if the channel was closed by the server.
> 
> Based-on: <20261113140852.702959-1-guillaume.vincke@ovhcloud.com>
> Needed to implement a deterministic test.

Based on the dependencies, this is definitely qemu 12.0 material, not
11.2; but that shouldn't stop me from starting review now.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


