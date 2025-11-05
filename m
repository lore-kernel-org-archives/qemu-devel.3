Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C92FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGjEt-00042A-Ix; Wed, 05 Nov 2025 14:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGjEs-00041p-AM
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGjEq-0003U5-PK
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762371132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsyENzaBW6m8+bgDDJuru7OANute9VsHyDfjqpiqLOs=;
 b=NMgtaJ5lN/yk5heeW/BgeNvSLw8HUIWJ9/LCVaUb/lHpxFq6HXySyTdroWie+y+Jx8vRY0
 PtiFQhKWbKOpIUpe4BrRI2mz8fjHAT8pOKCEoDCm3ZHzNBlMHiRqdbe8PL9BX0PG2XISmL
 Ga3POreVrrK9R7LTcvlDgp3tx9RbdzI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-6h31BHbTO0WiPRT92oOntQ-1; Wed,
 05 Nov 2025 14:32:08 -0500
X-MC-Unique: 6h31BHbTO0WiPRT92oOntQ-1
X-Mimecast-MFC-AGG-ID: 6h31BHbTO0WiPRT92oOntQ_1762371127
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A382180047F; Wed,  5 Nov 2025 19:32:07 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF8C13000198; Wed,  5 Nov 2025 19:32:05 +0000 (UTC)
Date: Wed, 5 Nov 2025 13:32:03 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org
Subject: Re: [PATCH 4/8] qio: Factor out helpers qio_net_listener_[un]watch
Message-ID: <uulaqxt4nrva6nhodeunt2nr3i7pyh67o7w6ap22vwt75daapv@jojcxgoflnhf>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-14-eblake@redhat.com>
 <aQnzjtDgSakaTgPi@redhat.com> <aQn7NF8bVZ3TO3Zo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQn7NF8bVZ3TO3Zo@redhat.com>
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

On Tue, Nov 04, 2025 at 01:10:12PM +0000, Daniel P. Berrangé wrote:
> On Tue, Nov 04, 2025 at 01:37:34PM +0100, Kevin Wolf wrote:
> > Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:
> > > The code had three similar repetitions of an iteration over one or all
> > > of nsiocs to set up a GSource, and likewise for teardown.  Since an
> > > upcoming patch wants to tweak whether GSource or AioContext is used,
> > > its better to consolidate that into one helper function for fewer
> > > places to edit later.
> > > 
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >  io/net-listener.c | 109 +++++++++++++++++++---------------------------
> > >  1 file changed, 45 insertions(+), 64 deletions(-)
> > 
> > > @@ -145,15 +174,11 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
> > >                                             GDestroyNotify notify,
> > >                                             GMainContext *context)
> > >  {
> > > -    size_t i;
> > > -
> > >      if (listener->io_func == func && listener->io_data == data) {
> > >          return;
> > >      }
> > > 
> > > -    if (listener->io_func) {
> > > -        trace_qio_net_listener_watch_disabled(listener, "set_client_func");
> > > -    }
> > > +    qio_net_listener_unwatch(listener, "set_client_func");
> > >      if (listener->io_notify) {
> > >          listener->io_notify(listener->io_data);
> > >      }
> > 
> > This changes the order between the io_notify() call and the unwatch. Is
> > this intentional? If so, maybe mention it in the commit message and why
> > it's safe.
> 
> At least conceptually I think this ordering is better, and I don't think
> there should be any functional consequences from the change.
>

It may have been inadvertent at the time I wrote the patch, but I
agree it makes sense to call it out as intentional in v2.

Before this patch series, io_notify is typically object_unref on an
object that has other references besides the one associated with the
NetListener.  In which case, calling io_notify() reduces the refcount,
for example from 2 to 1, but has no other impact in relation to
whether the GSource is still armed.  More drastic would be if the
io_notify() reduced the refcount from 1 to 0 and thereby finalized the
data.  If the GSource is still armed and has any chance at all of a
narrow window of time where it can fire before being unwatched, but
the io_data has been freed because the io_notify() dropped the
refcount to 0 rather than merely reducing it, then the callback can
risk a use-after-free of the io_data.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


