Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7D3C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 20:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfm8K-0003iZ-Mo; Wed, 05 Feb 2025 15:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfm8H-0003iI-UW
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfm8E-0006f4-Ir
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738787777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTtu97mYPDT6lt01NgndwdaNszNX/rDl8Gxuw8TjIi4=;
 b=VJj3sMQSHc8TyYetibGUJqEfMGCXNhmHrPxG6h1Tq3FLHsgJ7h6V29LoTcuxXu/M8Fzfl/
 NZ3F0u6WtmcxN8dji+/PvyM0JfDwuLawZTWAC8g6nkCXQR7HfBbkrHYidour4S7KJN+1FO
 wtu/sVTPKSoc+TsJQTsrUDMR2BmLjuo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-TlBe0M0xNq6X3iRk1RUYpg-1; Wed,
 05 Feb 2025 15:36:13 -0500
X-MC-Unique: TlBe0M0xNq6X3iRk1RUYpg-1
X-Mimecast-MFC-AGG-ID: TlBe0M0xNq6X3iRk1RUYpg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AACA31955DB8; Wed,  5 Feb 2025 20:36:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C8C9195608D; Wed,  5 Feb 2025 20:36:08 +0000 (UTC)
Date: Wed, 5 Feb 2025 14:36:05 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit in
 QMP
Message-ID: <ia55sowaqjkpwbq7yum42m5vuw5octffzx6sqsvwsnsueqaf54@cetnceyik5op>
References: <20250203222722.650694-4-eblake@redhat.com>
 <20250203222722.650694-6-eblake@redhat.com>
 <87h6587udf.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6587udf.fsf@pond.sub.org>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 05, 2025 at 07:55:56AM +0100, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > Although defaulting the handshake limit to 10 seconds was a nice QoI
> > change to weed out intentionally slow clients, it can interfere with
> > integration testing done with manual NBD_OPT commands over 'nbdsh
> > --opt-mode'.  Expose a QMP knob 'handshake-max-secs' to allow the user
> > to alter the timeout away from the default.
> >
> > The parameter name here intentionally matches the spelling of the
> > constant added in commit fb1c2aaa98, and not the command-line spelling
> > added in the previous patch for qemu-nbd; that's because in QMP,
> > longer names serve as good self-documentation, and unlike the command
> > line, machines don't have problems generating longer spellings.
> >

> >  { 'struct': 'NbdServerOptions',
> >    'data': { 'addr': 'SocketAddress',
> > +            '*handshake-max-secs': 'uint32',
> >              '*tls-creds': 'str',
> >              '*tls-authz': 'str',
> >              '*max-connections': 'uint32' } }
> 
> Standard question on time: are we confident the granularity will
> suffice?

The default if this is unspecified is 10 seconds.  Anything subsecond
requires a fast negotiation between client and server; the more likely
use of this parameter is setting it extremely large (or to 0 to
disable) in order to allow lengthy gdb sessions without the timeout
cutting things short.  So I think seconds is okay.

> 
> On naming...  We use "seconds" (StatsUnit in qapi/stats.json), and "sec"
> (SnapshotInfo in qapi/block-core.json), but not "secs".  Do we care?

Avoiding abbreviations and using 'seconds' is fine by me, especially
since this won't be typed by many users but remains more of a tool for
use in a debugging arsenel.  I can respin with the longer name, but
will wait for any other review comments first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


