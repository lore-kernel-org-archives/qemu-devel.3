Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5EFC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9W5c-0004eL-Mz; Mon, 28 Apr 2025 17:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9W5b-0004ck-32
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9W5Z-0003LH-06
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745875951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6qbtprtAjxQK70x2OlVApOqY2XbhYMCa+R+dNyulyg=;
 b=fVAHdNH8dxdfkDEFA2BVoOEtSMidx6i6Uip0Z7LkEs4i8/8Yixlgz3eDNruN5hXtDuJ+g2
 vvTezl3Z+IoO3DVOOO43AiKJn+Nt9sxG9ujaZd6qwKrxPKzTZ9qyKxwwDm++R5XtXVLG7j
 NZL184PoP80N4Iq4Pmo72rd8y9mCdGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-UlQ5GO1tMke7VumJwF5mIw-1; Mon,
 28 Apr 2025 17:32:28 -0400
X-MC-Unique: UlQ5GO1tMke7VumJwF5mIw-1
X-Mimecast-MFC-AGG-ID: UlQ5GO1tMke7VumJwF5mIw_1745875947
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8BCD1956088; Mon, 28 Apr 2025 21:32:26 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.31])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 797F11800872; Mon, 28 Apr 2025 21:32:24 +0000 (UTC)
Date: Mon, 28 Apr 2025 16:32:21 -0500
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 4/4] nbd: Enable multi-conn using round-robin
Message-ID: <bq4mky5xaw2n2evwboulkbzzn4ca5l24wo6luq5ilgut5524zc@qlod5ckru2se>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-10-eblake@redhat.com>
 <20250428192754.GF1450@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428192754.GF1450@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 28, 2025 at 08:27:54PM +0100, Richard W.M. Jones wrote:
> On Mon, Apr 28, 2025 at 01:46:47PM -0500, Eric Blake wrote:
> [...]
> 
> This all looks similar to when I posted it before.  However I noted a
> couple of problems ...
> 
> > (XXX) The strategy here is very naive.  Firstly if you were going to 
> > open them, you'd probably want to open them in parallel.  Secondly it
> > would make sense to delay opening until multiple parallel requests are
> > seen (perhaps above some threshold), so that simple or shortlived NBD
> > operations do not require multiple connections to be made.
> 
> > (XXX) This uses a naive round-robin approach which could be improved.
> > For example we could look at how many requests are in flight and
> > assign operations to the connections with fewest.  Or we could try to
> > estimate (based on size of requests outstanding) the load on each
> > connection.  But this implementation doesn't do any of that.
> 
> Plus there was a third rather more fundamental problem that apparently
> I didn't write about.  That is that connections were serialised on a
> single thread (called from many coroutines).  This bottleneck meant
> that there wasn't very much advantage to multi-conn, compared to what
> we get in libnbd / nbdcopy.
> 
> Are these fixed / planned to be fixed, especially the third?

That indeed is what I hope to address - to provide additional patches
on top of this rebase to make it possible to specify a pool of more
than one thread using the recent multiqueue work in the block layer.
It's taking me longer than I want to get something that I'm happy with
posting.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


