Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25543CED25D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIJg-00045N-1V; Tue, 18 Nov 2025 04:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLIJf-00044h-0q
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:48:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLIJd-00023b-9M
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763459279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=roZ15f14m9G8k0TFcYERjC7X9OBXOAKNRBgASbBw9uk=;
 b=PQkZeVCq57dQ+tur8fPeCNzSLTex7cJkYR2b58+e14ly4Dod/JNbWBOAm0I8hKUfG8h5+i
 1HLmVmTZYpaR980Q/A05aQFHcgqTdtz3W/wF6j5L7SwThAHkIxtZDSi5V5SV0HCmfIMFDj
 wHuMp+wPk4Ej0pEMhhrD6iH3P1fyDio=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-590m-RKcPq6OqeKnuN0-7w-1; Tue,
 18 Nov 2025 04:47:56 -0500
X-MC-Unique: 590m-RKcPq6OqeKnuN0-7w-1
X-Mimecast-MFC-AGG-ID: 590m-RKcPq6OqeKnuN0-7w_1763459275
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B4B318D95C7; Tue, 18 Nov 2025 09:47:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E8D518004A3; Tue, 18 Nov 2025 09:47:51 +0000 (UTC)
Date: Tue, 18 Nov 2025 10:47:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 armbru@redhat.com, eblake@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v9 4/7] qapi: add blockdev-replace command
Message-ID: <aRxAxRGJOqLetXHM@redhat.com>
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-5-vsementsov@yandex-team.ru>
 <992e1551-6d75-441f-af6e-5df9e6c85c31@yandex-team.ru>
 <256e998c-c0bd-40b4-94bf-de25ac9c1b02@yandex-team.ru>
 <ZxJpx024fRqNsI2E@redhat.com>
 <ebbc334f-43d2-4a06-a3a0-5fa3c1266f52@yandex-team.ru>
 <aRr9uuaz4FmEextJ@redhat.com>
 <4b8cade1-ecd3-4fa7-9082-7f2f1ef0b8a9@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8cade1-ecd3-4fa7-9082-7f2f1ef0b8a9@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Am 18.11.2025 um 08:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 17.11.25 13:49, Kevin Wolf wrote:
> > Hi Vladimir,
> > 
> > I remembered this series and wanted to check what the current status is,
> > because I seemed to remember that the next step was that you would send
> > a new version. But reading it again, you're probably waiting for more
> > input? Let's try to get this finished.
> 
> I think yes, I was waiting, but then switched to other tasks.
> 
> > 
> > Am 02.04.2025 um 15:05 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > On 18.10.24 16:59, Kevin Wolf wrote:
> > > > If we want to get rid of the union, I think the best course of action
> > > > would unifying the namespaces (so that nodes, exports and devices can't
> > > > share the same ID) and then we could just accept a universal 'id' along
> > > > with 'child'.
> > > 
> > > Maybe we can go this way even without explicit restriction (which
> > > should some how go through deprecation period, etc), but simply look
> > > for the id among nodes, devices and exports and if found more than one
> > > parent - fail.
> > > 
> > > And we document, that id should not be ambiguous, should not match more
> > > than one parent object. So, those who want to use new command will care
> > > to make unique ids.
> > 
> > I don't think such a state is very pretty, but it would be okay for me
> > as an intermediate state while we go through a deprecation period to
> > restrict IDs accordingly.
> > 
> > So we could start with blockdev-replace returning an error on ambiguous
> > IDs and at the same time deprecate them, and only later we would make
> > creating nodes/devices/exports with the same ID an error.
> > 
> 
> Hmm, the only question remains, is what/how to deprecate exactly?
> 
> We want to deprecate user's possibility to set intersecting
> IDs for exports / devices / block-nodes? I think, we don't
> have a QAPI-native way to deprecate such thing..

We don't have to be able to express every deprecation in the schema. If
it can be expressed, that's nice, but docs/about/deprecated.rst is the
important part.

> May be, add new "uuid" parameter, and deprecate its absence (I doubt
> that we can do such deprecation too). And deprecate old IDs? But we
> can't deprecate QOM path for this..

I don't think renaming options is necessary.

> Hmm, or move to QOM paths for block-nodes and exports? And deprecate
> export names and node names?

That would only make sense if we converted the block layer to a QOM
class hierarchy, which would be a project of its own.

> Or we can just deprecate intersecting IDs in documentation and start
> to print warning, when user make intersecting IDs? But nobody reads
> warnings..
> 
> Is there a proper way to deprecate such things?

The latter is what I would suggest. docs/about/deprecated.rst and
printing warnings. I think libvirt already keeps all IDs distinct
anyway, so for a large part of users nothing will change.

Kevin


