Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFAFCD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 13:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJXVu-0004zm-TJ; Thu, 13 Nov 2025 08:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJXUw-0004NG-4W
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:36:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJXUu-0003ZE-I5
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763040983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JeVZmaUnmGbNEzHrLmtUkyzI1970RQSOwSylWRM8dyg=;
 b=OU+wB2vujeA79jiYLWFRyYQh2HVg6vekGJpbriamSAAbxRdERw6U1QIIrxdmpq/DR01LoK
 9L1yGWUHupGH9SosiWTULQxMr2aOYupTb603Iy5hRf9/MyhuGLAn/ChhZDvIXwez637YkV
 TvPrBQCln9C+YemxsH0cliq398rIZIo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-rnCtgUuPMaeViLXn9uktfQ-1; Thu,
 13 Nov 2025 08:36:22 -0500
X-MC-Unique: rnCtgUuPMaeViLXn9uktfQ-1
X-Mimecast-MFC-AGG-ID: rnCtgUuPMaeViLXn9uktfQ_1763040981
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B30A19560B0; Thu, 13 Nov 2025 13:36:21 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCFBE1955F1B; Thu, 13 Nov 2025 13:36:19 +0000 (UTC)
Date: Thu, 13 Nov 2025 07:36:17 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH v3 for-10.2 00/13] Fix deadlock with bdrv_open of
 self-served NBD
Message-ID: <ogeyatgiy225rpeon2uq6qke6j27lk2yxziiokq77y46drtz3l@2dez6hvaafpu>
References: <20251113011625.878876-15-eblake@redhat.com>
 <aRWfwmWz2LfgMKrs@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRWfwmWz2LfgMKrs@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 13, 2025 at 09:07:14AM +0000, Daniel P. Berrangé wrote:
> Seems you sent a v3 twice today. I reviewed the earlier v3 and
> assume this v3 is an identical accident dupe. If this is actually
> a v3 let me know and i'll review further...

Rather, you got two copies, but the list only got one - my first
attempt botched the cc to Kevin's email to the point that the list
rejected it.  Sorry for my fat fingers on that one!

> 
> On Wed, Nov 12, 2025 at 07:11:25PM -0600, Eric Blake wrote:
> > v2 was here:
> > https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg01243.html
> > 
> > Since then:
> >  - drop patch 7/12; refcounting for GSource case is now unchanged
> >  - add a couple of patches: fix a chardev leaky abstraction, and add a
> >    mutex lock for cross-thread safety
> >  - improve commit messages to document why NBD is safe now, even without
> >    adding notify callbacks to AioContext
> > 
> > Now that the new behavior is opt-in rather than a change of defaults,
> > and only NBD opts in, it should still be safe to include in 10.2.
> > But the technical debt here means that we really should consider
> > improving the AioContext API for 11.0 to allow for a notify function
> > similar to what GSource provides.
> >

I'll go ahead and queue this through my tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


