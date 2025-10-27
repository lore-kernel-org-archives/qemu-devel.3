Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC25CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKQM-0002dR-OD; Mon, 27 Oct 2025 06:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDKQJ-0002cr-Oo
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDKQG-0006jz-Sj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761560754;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60r4CtRHLc0zNgXQS9j9tZ8dFh+anHNmoO+UEQQrbD0=;
 b=WGo6RiF7K8bpD5xWTi+Blek/ee8AI8fW3QHTyK7/WF2+wiEMJ+JfsJbS4UmEoXWZMxKgXb
 rlR3zEOocL158MLce2gFko9umD4NXASCv8BBj0qBQTgXiNlzoZ+h3ud4MveSohVWqz57fh
 pweWYwpkajtHsHz8joimMucU9ZZY1B0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-KSdcQgCLOwyxNaSfSyzp1A-1; Mon,
 27 Oct 2025 06:25:52 -0400
X-MC-Unique: KSdcQgCLOwyxNaSfSyzp1A-1
X-Mimecast-MFC-AGG-ID: KSdcQgCLOwyxNaSfSyzp1A_1761560751
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8737E19540E1; Mon, 27 Oct 2025 10:25:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 178E11955F1B; Mon, 27 Oct 2025 10:25:48 +0000 (UTC)
Date: Mon, 27 Oct 2025 10:25:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
Message-ID: <aP9IqYzAea1DUjqp@redhat.com>
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org> <aPtim8ZACUWyje2o@redhat.com>
 <874irozabw.fsf@pond.sub.org> <87v7k4xuhk.fsf@pond.sub.org>
 <aPumkKBx4PoGSwNv@x1.local> <aPup9BzTf-uk8cUf@redhat.com>
 <87a51gdv4m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a51gdv4m.fsf@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 24, 2025 at 03:15:05PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Oct 24, 2025 at 12:17:20PM -0400, Peter Xu wrote:
> >> On Fri, Oct 24, 2025 at 04:08:39PM +0200, Markus Armbruster wrote:
> >> > Markus Armbruster <armbru@redhat.com> writes:
> >> > 
> >> > > Daniel P. Berrangé <berrange@redhat.com> writes:
> >> > 
> >> > [...]
> >> > 
> >> > >> But wow, the migrate_add_blocker API design is unpleasant with its
> >> > >> pair of "Error **" parameters - it is practically designed to
> >> > >> maximise confusion & surprise.
> >> > >
> >> > > It's quite a sight, isn't it?
> >> > >
> >> > > I'll give it a quick Friday afternoon try.
> >> > 
> >> > Alright, my confusion has been maximised.  Giving up on this.
> >> 
> >> Besides the use of two Error** that might be confusing, what is more
> >> confusing (if not wrong..): migrate_add_blocker() will take ownership of
> >> the 1st Error**, no matter whether the helper succeeded or not. However, it
> >> only resets the first Error** if failed.
> >> 
> >> I think it means if migrate_add_blocker() succeeded, the caller will have a
> >> non-NULL pointer, even if it has lost the ownership of that pointer.
> >> 
> >> I'm guessing it never caused issue only because we don't usually
> >> error_free() the migration blocker anywhere.. but I think maybe we should
> >> at least do an error_copy() in add_blockers()..
> >
> > IMHO we should not even be using an Error object for the the blocker.
> > AFAICT, internally all we care about is the formatted string. The main
> > reason for using an Error object appears to be to have a convenient
> > pointer to use as an identifier to later pass to del_blocker.
> >
> > I'd be inclined to just have passed in a fixed string, and return an
> > integer identifier for the blocker. eg
> >
> >     int64 migrate_add_blocker(const char *reason, Error **errp);
> >
> >     void migrate_del_blocker(int64 blockerid);
> >
> > The migrate_add_blocker method would strdup(reason) to keep its own
> > copy.
> >
> > The usage would thus be clear & simple:
> >
> >     int64 blockerid = migrate_add_blocker("cannot migrate vfio", errp);
> >     if (!blockerid) {
> >          return;
> >     }
> >
> >     ... some time later...
> >
> >     migrate_del_blocker(blockerid);
> >
> >
> > In some cases we needed dynamically formatted strings, which could have
> > been achieved thus:
> >
> >     g_autofree char *msg = g_strdup_printf("cannot migrate vfio %d", blah);
> >     int64 blockerid = migrate_add_blocker(msg, errp);
> >     ...the rest as above...
> >
> > yes, this costs an extra strdup(), but that is an acceptable & negligible
> > overhead in the context in which we're doing this.
> >
> 
> Hmm, I must disagree. This is more complex than what we have
> today. Calling error_setg(err, "msg") is pretty standard, already gives
> us formatting and keeps all (potentially) user-facing messages uniform.

IMHO this usage in migration is not really about error reporting
though, and the lifecycle ownership of the Error objects in this
migration usage is very diferent from the typical lifecycle
ownership of Error objects used in reporting errors, which I think
leads to a surprising / unusual API.

> Asking for people to deal with strings and storing an int64 in their
> code is not improving the situation. Besides, the Error is already used
> by the block layer when blocking operations, for instance. If anything
> we should be integrating the two usages instead of inventing yet another
> for the migration code. See:

Yes, having a common API for these two similar use cases would be
a useful thing. I'm just not convinced we should be (mis|re)using
the Error object for either of these two situations.

> 
> replication.c:
>   error_setg(&s->blocker,
>              "Block device is in use by internal backup job");
>   ...
>   bdrv_op_block_all(top_bs, s->blocker);
> 
> block.c:
>   void bdrv_op_block(BlockDriverState *bs, BlockOpType op, Error *reason)
>   {
>       BdrvOpBlocker *blocker;
>       assert((int) op >= 0 && op < BLOCK_OP_TYPE_MAX);
> 
>       blocker = g_new0(BdrvOpBlocker, 1);
>       blocker->reason = reason;
>       QLIST_INSERT_HEAD(&bs->op_blockers[op], blocker, list);
> }


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


