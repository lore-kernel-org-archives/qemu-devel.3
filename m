Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080F8CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGj5O-00085I-V1; Wed, 05 Nov 2025 14:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGj5F-00082p-JF
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGj5B-0000fg-3t
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762370531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxYYgFjcakMAdK4SuDQqyF5bnL/821jd7KC4tRUWH6Q=;
 b=BSFwTFX9MKZQr/JHl3uXVLVpeEC0SYWcEFqguymCQshfMkYBF6LmkAJL2OQw46X1XvEYe9
 kuVfhViVm0cFaVDZpKMEvwevIxqDtr1PDXvuN2AlBCzLZwzMXN9+ltGWSUmy/Kq6Obpl9a
 zaltkQr0Lk2Lj2PDGt4fD2LAb85jMh0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-OFhgn5bYPPW8DUMGqs7ZVw-1; Wed,
 05 Nov 2025 14:22:09 -0500
X-MC-Unique: OFhgn5bYPPW8DUMGqs7ZVw-1
X-Mimecast-MFC-AGG-ID: OFhgn5bYPPW8DUMGqs7ZVw_1762370528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE8051956095; Wed,  5 Nov 2025 19:22:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1C831955F1A; Wed,  5 Nov 2025 19:22:06 +0000 (UTC)
Date: Wed, 5 Nov 2025 13:22:04 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 4/8] qio: Factor out helpers qio_net_listener_[un]watch
Message-ID: <udi2mpwibg43sbhgbcpvemzeznucgrwfezv7wfxr3pqod4anza@vuf6xmliutzv>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-14-eblake@redhat.com>
 <aQndkQ3knp-5d-YJ@redhat.com> <aQn8ZITZmk3IWpED@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQn8ZITZmk3IWpED@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 04, 2025 at 02:15:16PM +0100, Kevin Wolf wrote:
> Am 04.11.2025 um 12:03 hat Daniel P. Berrangé geschrieben:
> > On Mon, Nov 03, 2025 at 02:10:55PM -0600, Eric Blake wrote:
> > > The code had three similar repetitions of an iteration over one or all
> > > of nsiocs to set up a GSource, and likewise for teardown.  Since an
> > > upcoming patch wants to tweak whether GSource or AioContext is used,
> > > its better to consolidate that into one helper function for fewer
> > > places to edit later.
> > > 

> > > -    listener->nsioc++;
> > > +    qio_net_listener_watch(listener, listener->nsioc++, "add");
> > 
> > Nit-picking, I'd have a slight preference to keep the 'nsioc' increment
> > on the following line from the qio_net_listener_watch call, as I don't
> > like side effects in passing the function arguments.
> 
> It actually wouldn't work any more because qio_net_listener_watch()
> iterates up to listener->nsioc. It needs the increased value in
> listener->nsioc, and the previous one for i, so that we get exactly one
> loop iteration.

I'm happy to change it to this in v2, to avoid the side-effect in the
function call:

listener->nsioc++;
qio_net_listener_watch(listener, listener->nsioc - 1, "add");

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


