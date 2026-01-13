Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D3FD2D0ED
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdxm-0004rf-6D; Tue, 13 Jan 2026 07:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vfdxk-0004py-Bb
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vfdxi-0000YX-TW
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768309050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDo6APYsqEcvy2DtL9viPiFuCFfAe9OQtgUONrwg/7A=;
 b=D3lRs8mYkx2GAKfxVPAAQZCSYzlC/IA7c3nVLtfSdNCOVUCWbczGqra9hjPybjniC4Tyq3
 Bddimas9PZdB693u4TbwLUwY6WOA+b8hwWouUCUgtkdJjZUgxUseX7Miol/9b23ZhMB28b
 QdVfZP0jNFPpos49JpIAOifsqJWo5wk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-m4sxiyrTO1GvkqUsVnKpFQ-1; Tue,
 13 Jan 2026 07:57:27 -0500
X-MC-Unique: m4sxiyrTO1GvkqUsVnKpFQ-1
X-Mimecast-MFC-AGG-ID: m4sxiyrTO1GvkqUsVnKpFQ_1768309046
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3995A1955DC3; Tue, 13 Jan 2026 12:57:26 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E10F1800665; Tue, 13 Jan 2026 12:57:23 +0000 (UTC)
Date: Tue, 13 Jan 2026 13:57:20 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] block: Wire up 'flat' mode also for 'query-block'
Message-ID: <aWZBMNaiolcB3k0f@angien.pipo.sk>
References: <38fa3ec064ed20282fb61f70ffed8e0abb3abbfa.1765445716.git.pkrempa@redhat.com>
 <874iorgm4b.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874iorgm4b.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 12, 2026 at 11:29:24 +0100, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:
> 
> > From: Peter Krempa <pkrempa@redhat.com>
> >
> > Some time ago (commit facda5443f5a8) I've added 'flat' mode (which
> > omits 'backing-image' key in reply) to 'query-named-block-nodes' to
> > minimize the size of the returned JSON for deeper backing chains.
> 
> Almost six years.  Time flies :)

Indeed! Actually last year (already) I've deleted the corresponding
capability since libvirt now only supports QEMUs which do support this
:D

> 
> > While 'query-block' behaved slightly better it turns out that in libvirt
> > we do call 'query-block' to figure out some information about the
> > block device (e.g. throttling info) but we don't look at the backing
> > chain itself.
> >
> > Wire up 'flat' for 'query-block' so that libvirt can ask for an
> > abbreviated output. The implementation is much simpler as the internals
> > are shared with 'query-named-block-nodes'.
> >
> > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> > ---
> >  block/monitor/block-hmp-cmds.c | 4 ++--
> >  block/qapi.c                   | 9 +++++----
> >  qapi/block-core.json           | 4 ++++
> >  ui/cocoa.m                     | 2 +-
> >  4 files changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> > index 3640d1f3dc..d301f56a39 100644
> > --- a/block/monitor/block-hmp-cmds.c
> > +++ b/block/monitor/block-hmp-cmds.c
> > @@ -422,7 +422,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
> >      /* Then try adding all block devices.  If one fails, close all and
> >       * exit.
> >       */
> > -    block_list = qmp_query_block(NULL);
> > +    block_list = qmp_query_block(false, false, NULL);
> 
> Is info->value->inserted->image->backing_image used here?
> 
> If not, we can pass true and save allocations.  Thought, not a demand.

It's not used in hmp_nbd_server_start. I'll do a separate patch for it
as it's simple enough, but IMO not related to this patch which should
keep behaviour of unrelated code.

> Same for the other calls.
> 
> >
> >      for (info = block_list; info; info = info->next) {
> >          if (!info->value->inserted) {
> > @@ -741,7 +741,7 @@ void hmp_info_block(Monitor *mon, const QDict *qdict)

... but this one does use it (although for questionably useful
information: first backing image name and the depth of the backing chain).


[...]


> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index b82af74256..e89d878544 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -855,6 +855,9 @@
> >  #
> >  # Get a list of `BlockInfo` for all virtual block devices.
> >  #
> > +# @flat: Omit the nested data about backing image ("backing-image"
> > +#     key) if true.  Default is false (Since 11.0)
> > +#
> 
> The "backing-image" key is actually BlockInfo member inserted member
> image member backing-image.  This is even more deeply nested than for
> query-named-block-nodes.  Doc text good enough?

Hmm, how about:

+# @flat: Omit the nested data about backing image (Omitted are contents of
+#        'backing-image' key of the 'ImageInfo' struct which is returned
+#        as 'image' key of 'BlockDeviceInfo' struct returned as 'inserted' key
+#        in  'BlockInfo' struct returned by this command).

or 

+# @flat: Omit the nested data about backing image (Omitted are contents
+#        of 'BlockInfo'->inserted->image->backing-image).

?


