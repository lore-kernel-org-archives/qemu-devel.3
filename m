Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96CFCCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGj1x-0006jo-N4; Wed, 05 Nov 2025 14:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGj1w-0006jb-Ov
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:18:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGj1u-0007iU-Sa
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762370329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XkxSx7Yw5Z5G9YKWsnRUIg0D/qH5sCPi6metWyjmFo4=;
 b=NZaEj5rNClp5oZPE6Nc34ywMNnk9luwlaqRd9ICrfuc6+uOaL33SH6ggwzuoymrHbEgXwm
 DTaC+Xnb1F77kjulK30F60VE/LqKRfz/dJI6NMA7Qf7DXnnxVfv/uSqAhM0lwraDEFMS+H
 Il9QoqM1Hb8J9UkHI31hhaliQWm/0ig=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-pCmn2Hg6PZ-bXffDZHOaRg-1; Wed,
 05 Nov 2025 14:18:45 -0500
X-MC-Unique: pCmn2Hg6PZ-bXffDZHOaRg-1
X-Mimecast-MFC-AGG-ID: pCmn2Hg6PZ-bXffDZHOaRg_1762370324
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 497541954B01; Wed,  5 Nov 2025 19:18:44 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2521530001B5; Wed,  5 Nov 2025 19:18:41 +0000 (UTC)
Date: Wed, 5 Nov 2025 13:18:39 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 3/8] qio: Remember context of
 qio_net_listener_set_client_func_full
Message-ID: <yjlmplmmvdcomea7wvek6vaafdsgyeevemk4r6jadqm5g35u34@aloz7iozx3gn>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-13-eblake@redhat.com>
 <aQnisoN92ihQ1LjG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQnisoN92ihQ1LjG@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 12:25:38PM +0100, Kevin Wolf wrote:
> Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:

> > 
> > That said, it is more robust to remember when a callback function is
> > tied to a non-default context, and have both the sync wait and any
> > late address additions honor that same context.  That way, the code
> > will be robust even if a later user performs a sync wait for a
> > specific client in the middle of servicing a longer-lived
> > QIONetListener that has an async callback for all other clients.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> > @@ -160,6 +160,7 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
> >      listener->io_func = func;
> >      listener->io_data = data;
> >      listener->io_notify = notify;
> > +    listener->context = context;
> 
> Now that you show me this, I think patch 2 actually also needs to check
> that context is unchanged. We don't remember the old value before this
> patch, so maybe the order of patch 2 and 3 should be swapped.

Makes sense.  v2 will swap the patch order, and ensure the context is
unchanged when optimizing a re-arm of the already-existing callback.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


