Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B40D3000D
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nWE-0006Fs-9h; Fri, 18 Oct 2024 09:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1nW6-0006Ev-BV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1nW4-0004jS-OD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729259983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPkSAfTX66SGCGU6X0N+sz2SUfiyc5EeSrqILSrT74g=;
 b=S78eMTO4FzLkGU+8DyS98euh/Briejgpx34rbTqKZXkCfAD+vyKzwMvYTrcHtaasazMTSM
 28lVXq3WT8bNlSB4AHNZzXe0uftPSAe7P/2zUoHv4au19Lzifo8RleL1Ij23zr2JJkyizx
 b6b2LBQe2SC3xp5jm5VwYMryMWKH0xY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-pHWlJIF8MPOlUTkPf4heJA-1; Fri,
 18 Oct 2024 09:59:42 -0400
X-MC-Unique: pHWlJIF8MPOlUTkPf4heJA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 234001955F3F; Fri, 18 Oct 2024 13:59:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.196])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C86161956086; Fri, 18 Oct 2024 13:59:38 +0000 (UTC)
Date: Fri, 18 Oct 2024 15:59:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 armbru@redhat.com, eblake@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v9 4/7] qapi: add blockdev-replace command
Message-ID: <ZxJpx024fRqNsI2E@redhat.com>
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-5-vsementsov@yandex-team.ru>
 <992e1551-6d75-441f-af6e-5df9e6c85c31@yandex-team.ru>
 <256e998c-c0bd-40b4-94bf-de25ac9c1b02@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <256e998c-c0bd-40b4-94bf-de25ac9c1b02@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 04.10.2024 um 19:01 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 02.10.24 17:41, Vladimir Sementsov-Ogievskiy wrote:
> > On 26.06.24 14:53, Vladimir Sementsov-Ogievskiy wrote:
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index df5e07debd..0a6f08a6e0 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -6148,3 +6148,91 @@
> > >   ##
> > >   { 'struct': 'DummyBlockCoreForceArrays',
> > >     'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
> > > +
> > > +##
> > > +# @BlockParentType:
> > > +#
> > > +# @qdev: block device, such as created by device_add, and denoted by
> > > +#     qdev-id
> > > +#
> > > +# @driver: block driver node, such as created by blockdev-add, and
> > > +#     denoted by node-name
> > > +#
> > > +# @export: block export, such created by block-export-add, and
> > > +#     denoted by export-id
> > > +#
> > > +# Since 9.1
> > > +##
> > > +{ 'enum': 'BlockParentType',
> > > +  'data': ['qdev', 'driver', 'export'] }
> > > +
> > > +##
> > > +# @BdrvChildRefQdev:
> > > +#
> > > +# @qdev-id: the device's ID or QOM path
> > > +#
> > > +# Since 9.1
> > > +##
> > > +{ 'struct': 'BdrvChildRefQdev',
> > > +  'data': { 'qdev-id': 'str' } }
> > > +
> > > +##
> > > +# @BdrvChildRefExport:
> > > +#
> > > +# @export-id: block export identifier
> > > +#
> > > +# Since 9.1
> > > +##
> > > +{ 'struct': 'BdrvChildRefExport',
> > > +  'data': { 'export-id': 'str' } }
> > > +
> > > +##
> > > +# @BdrvChildRefDriver:
> > > +#
> > > +# @node-name: the node name of the parent block node
> > > +#
> > > +# @child: name of the child to be replaced, like "file" or "backing"
> > > +#
> > > +# Since 9.1
> > > +##
> > > +{ 'struct': 'BdrvChildRefDriver',
> > > +  'data': { 'node-name': 'str', 'child': 'str' } }
> > > +
> > > +##
> > > +# @BlockdevReplace:
> > > +#
> > > +# @parent-type: type of the parent, which child is to be replaced
> > > +#
> > > +# @new-child: new child for replacement
> > > +#
> > > +# Since 9.1
> > > +##
> > > +{ 'union': 'BlockdevReplace',
> > > +  'base': {
> > > +      'parent-type': 'BlockParentType',
> > > +      'new-child': 'str'
> > > +  },
> > > +  'discriminator': 'parent-type',
> > > +  'data': {
> > > +      'qdev': 'BdrvChildRefQdev',
> > > +      'export': 'BdrvChildRefExport',
> > > +      'driver': 'BdrvChildRefDriver'
> > > +  } }
> > > +
> > > +##
> > > +# @blockdev-replace:
> > > +#
> > > +# Replace a block-node associated with device (selected by
> > > +# @qdev-id) or with block-export (selected by @export-id) or
> > > +# any child of block-node (selected by @node-name and @child)
> > > +# with @new-child block-node.
> > > +#
> > > +# Features:
> > > +#
> > > +# @unstable: This command is experimental.
> > > +#
> > > +# Since 9.1
> > > +##
> > > +{ 'command': 'blockdev-replace', 'boxed': true,
> > > +  'features': [ 'unstable' ],
> > > +  'data': 'BlockdevReplace' }
> > 
> > 
> > Looking back at this all, I now have another idea: instead of trying
> > to unite different types of parents, maybe just publish concept of
> > BdrvChild to QAPI? So that it will have unique id. Like for
> > block-nodes, it could be auto-generated or specified by user.
> > 
> > Then we'll add parameters for commands:
> > 
> > device-add
> >     root-child-slot-id: ID
> > 
> > block-export-add
> >     block-child-slot-id: ID
> > 
> > and for block-drivers we already have BlockdevRef structure, it only
> > lacks an id.
> > 
> > { 'alternate': 'BlockdevRef',
> >    'data': { 'definition': 'BlockdevOptions',
> >              'reference': 'str' } }
> > 
> > hmm.. Could it be as simple as
> > 
> > 
> > { 'alternate': 'BlockdevRef',
> >    'base': { '*child-slot-id': 'str' },
> >    'data': { 'definition': 'BlockdevOptions',
> >              'reference': 'str' } }
> > 
> > ?
> 
> Oops that was obviously impossible idea :) Then, I think the only way
> is to introduce virtual "reference" BlockdevDriver, with only one
> parameter { 'reference': 'str' }, this way user will be able to
> specify
> 
> file: {driver: reference, reference: NODE_NAME, child-slot-id: NEW_ID}

I don't think adding such a hack would make the interface any nicer
compared to what you have now with the union.

If we want to get rid of the union, I think the best course of action
would unifying the namespaces (so that nodes, exports and devices can't
share the same ID) and then we could just accept a universal 'id' along
with 'child'.

This would mean having 'child' even for devices, which feels
unnecessary at least in the common case, but it would at the same time
resolve Markus' concern if there could be any devices with multiple
BlockBackends.

I can only think of isa-fdc that used to be such a device, but that was
just incorrect modelling on the qdev level. Not sure if there are actual
legitimate use cases for having multiple BlockBackends.

Anyway, for the moment, I would suggest going ahead with the union.

Kevin


