Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B89CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3HAm-0000Ya-LH; Mon, 29 Sep 2025 12:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3HAV-0000C6-1n
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3HAQ-0003at-CX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164958;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heYTRHS2SbH7q6OYEFsVEoaYnBvmxAG63VXARphQakI=;
 b=RSgiGhhUO9g0r9Ss61iKtXaHIBIgCFDGD3rwYJcYWe7r6brde3DfzTuoDIcupMeYG4bWRe
 FZ3RYHrF1tmp1nW6kOdL6lQfzJmJFpeJWcN0ApxazjB6WiLej3aOTzNAJQRnIcM2gL4ho7
 675liN+SP8+mIuZ9Xg4V1PNiSwOqxm4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-w1n8LBMMNrqzDGmWvXdEIw-1; Mon,
 29 Sep 2025 12:55:56 -0400
X-MC-Unique: w1n8LBMMNrqzDGmWvXdEIw-1
X-Mimecast-MFC-AGG-ID: w1n8LBMMNrqzDGmWvXdEIw_1759164955
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A100619560BD; Mon, 29 Sep 2025 16:55:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 139B7180047F; Mon, 29 Sep 2025 16:55:53 +0000 (UTC)
Date: Mon, 29 Sep 2025 17:55:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
Message-ID: <aNq6Fu0-nb1XMRxk@redhat.com>
References: <20250801170212.54409-1-berrange@redhat.com>
 <aNqsnaBkQe8i_MLK@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNqsnaBkQe8i_MLK@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 29, 2025 at 11:58:21AM -0400, Peter Xu wrote:
> On Fri, Aug 01, 2025 at 06:02:10PM +0100, Daniel P. Berrangé wrote:
> > This is a followup to previously merged patches that claimed to
> > workaround the gnutls bug impacting migration, but in fact were
> > essentially non-functional. Juraj Marcin pointed this out, and
> > this new patch tweaks the workaround to make it actually do
> > something useful.
> > 
> > Daniel P. Berrangé (2):
> >   migration: simplify error reporting after channel read
> >   migration: fix workaround for gnutls thread safety
> > 
> >  crypto/tlssession.c   | 16 ----------------
> >  migration/qemu-file.c | 22 +++++++++++++++++-----
> >  2 files changed, 17 insertions(+), 21 deletions(-)
> 
> Dan, is there a planned repost on this one?

It is on my todo list, but I don't have a firm ETA yet.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


