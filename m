Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB82BC531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBbu-0004fH-S0; Thu, 19 Feb 2026 16:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vtBbW-0004am-Jk
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vtBbT-0001Ib-7a
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771536628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Emae6bdUu0wA2jiQSV6LiH8hLNGtgI8fNO/W8v6Cehg=;
 b=CtWLtfBq0vy0kqZn3Sd5xim/3IT9oP7v+160MfyxMbo9WUAdguqQSv9qQPu+n6GaRGbMpY
 0NJ0/LrcO96j5GPi3lIfXuBhQWS/vED1MmyIBaVJ7zmtdrfFC6Ta+v8PqR80m6kTqOmO74
 jtPrIuaEK1lhF/d6nGkUruFWB7H1wjQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-nsPFSMGuNO6PY64vTfd4EQ-1; Thu,
 19 Feb 2026 16:30:24 -0500
X-MC-Unique: nsPFSMGuNO6PY64vTfd4EQ-1
X-Mimecast-MFC-AGG-ID: nsPFSMGuNO6PY64vTfd4EQ_1771536623
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 957EC1956058; Thu, 19 Feb 2026 21:30:22 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 378091955F01; Thu, 19 Feb 2026 21:30:18 +0000 (UTC)
Date: Thu, 19 Feb 2026 22:30:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com
Subject: Re: [PATCH v10 4/8] qapi: add blockdev-replace command
Message-ID: <aZeA6GZQaRtqmzgv@redhat.com>
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260119144941.87936-5-vsementsov@yandex-team.ru>
 <87wm0sy9s4.fsf@pond.sub.org>
 <739edd0f-8342-418e-96bb-01bc9bd3349e@yandex-team.ru>
 <87seb3zr7j.fsf@pond.sub.org>
 <f9aed7fd-2f56-4b54-bf4f-693e0c10fb38@yandex-team.ru>
 <87seazjz2q.fsf@pond.sub.org>
 <04575653-a2ba-4ef1-b1af-a514bec80a69@yandex-team.ru>
 <87a4x6h8kz.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4x6h8kz.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 18.02.2026 um 07:25 hat Markus Armbruster geschrieben:
> Block layer maintainers' advice sought:
> 
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
> > On 17.02.26 16:10, Markus Armbruster wrote:
> >> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> >> 
> >>> On 14.02.26 11:04, Markus Armbruster wrote:
> 
> [...]
> 
> >>>> This interface sort of overloads @parent and @child, and overloading the
> >>>> former creates ambiguity that can make the command unusable.
> >>>
> >>> Is it a real problem if we do deprecate the thing, that leads to this
> >>> ambiguity?
> >>>
> >>> If it is, we may mark the command "unstable" during the deprecation period.
> >> 
> >> By itself, the proposed command is a trap for the unwary.
> >> 
> >> Deprecating the usage that enables the trap makes the trap temporary.
> >> 
> >> Warning on (deprecated) usage that enables the trap helps users avoid
> >> it.  Human users, mostly.
> >> 
> >> Marking the command "unstable" should ensure management application
> >> avoid the command, and thus the trap.
> >> 
> >> All of the above together feels acceptable to me.  Can we do better?
> >> Maybe, and that's discussed below.
> >> 
> >>> Or even postpone its addition up to the end of this period.
> >> 
> >> No trap, no problem :)
> >> 
> >>>> @parent's set of valid values is the union of QOM path, block node name,
> >>>> block export ID with values occuring in more than one of them dropped.
> >>>>
> >>>> @child's set of valid values depends on @parent: child name when it's a
> >>>> QOM path, else "root".
> >>>>
> >>>> The obvious non-overloaded interface is a union of three branches: QOM,
> >>>> block node, block export.  The QOM branch has variant members @qom-path
> >>>> and @child.  The block node branch has variant member @node-name.  The
> >>>> block export branch has variant member @id.
> >>>>
> >>>> This is a bit more verbose: you have to specify the union tag[*].
> >>>>
> >>>> If we ever need to replace block nodes associated with additional
> >>>> things, we simply more branches.  These branches can have arbitrary
> >>>> members.  In your interface, we'd have to make do with @child, or maybe
> >>>> add optional arguments.
> >>>>
> >>>> Thoughts?  Mind, this isn't a demand!  I'm exploring the design space.
> >>>
> >>> Union-based solution was v9: https://lore.kernel.org/qemu-devel/20240626115350.405778-5-vsementsov@yandex-team.ru/
> >>>
> >>> And there was a discussion, that we may try a way without a union. And that's
> >>> this v10.
> >> 
> >> I see Kevin suggested to explore this approach.  I certainly respect his
> >> judgement.
> >> 
> >>> Hmm, but that had different field names for parents: qdev-id, export-id and node-name.
> >>>
> >>> What you suggest is to keep one filed for parent - "parent", but also add a "parent-type"
> >>> field. This way, we may deprecate and remove "parent-type" in future. Or, we may
> >>> add it as deprecated now (together with deprecating non-unique IDs)
> >> 
> >> We can't deprecate the union tag right away: it is *required*.
> >> 
> >>>> [*] We could add a "may omit union tag when the tag value can be derived
> >>>> from present variant members" convenience feature to QAPI, but I'm not
> >>>> sure it's worth the complexity.
> >>>>
> >>>
> >>> It also may be not a union, but a simple structure with optional fields:
> >>>
> >>> {
> >>>      parent: str, required, qom-path, or node-name, or export name
> >>>      child: str, optional, but required when parent is node-name, and must be 'root'
> >>>             if present for other parent types
> >>>      parent-type: str, optional, "qom-path" | "block-node" | "block-export", helps to
> >>>             overcome parent ambiguity, deprecated
> >>>      new-child: str, required node-name
> >>> }
> >> 
> >> PRO union: which members are valid together is syntactically obvious.
> >> With a bunch of optional members, that information is in the member
> >> descriptions.
> >> 
> >> CON union: need to specify the union tag.  The verbosity is a non-issue
> >> for management applications, and mildly bothersome for humans.
> >> 
> >> How important is keeping things terse for humans here?
> >> 
> >
> > It's not very important. Mostly, I just want to make "nice" interface, and possibility to
> > reference any supported object by one ID seemed very tempting to me.
> >
> > But to be honest, introducing such a precedent makes sense, if we have in mind more
> > cases where such approach may be reused. Personally, I don't have them. If blockdev-replace
> > command remains the only API for the ages, which allows to mix in one field different kinds
> > of IDs, it becomes just an extra exclusion from common practices.
> >
> > Finally, I don't care too much, which interface we chose. I'm not sure now that unifying
> > ids is better than union. So I'm OK to go back to union-based solution from v9, update and
> > resend it as v11.
> 
> Hanna, Kevin, got a preference?

My stance is unchanged from v9. When Vladimir asked if we could somehow
get rid of the union, I tried to help him find such a solution that
might be acceptable, but also recommended to keep the union for now,
simply because it raises a lot less questions and avoids the temporary
trap, and to move to a unified ID only later.

Still, as I said, "I don't think such a state is very pretty, but it
would be okay for me". So I wouldn't block the approach taken here in
v10 if Vladimir prefers it (at least as far as I can say from the
discussion; I didn't actually review it yet).

If you say that you really don't want to have the command fail on
ambiguous IDs, we probably shouldn't do it. But as far as I am
concerned, it seemed tolerable, so if you don't object, it remains
Vladimir's decision.

Kevin


