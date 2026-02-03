Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5903BE87839
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIAy-0006iC-D3; Tue, 03 Feb 2026 10:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vnIAe-0006ZR-GW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:18:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vnIAc-0007A1-92
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770131905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HA/h7ZMhcapQU3W1kqr0RuT09ndTqWPCITJJvwMUyhA=;
 b=W624+CFgIpJlT2YkhuJ129mJ5Q3GLqC/fS5ejlddtFRf/mnZ8NIZixNcE9au2e6OUAvMQ/
 Hp3wiujNNczahSaWdFMOkwVTlT8qw3JqcayyS/MVqMmXHDioEutRIIBygaPeyiN3bco90e
 X/85J9p4IXh7z7YWlBvjVL/EmD2NPZc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-vIDi4N1fNXmYPG2R8piODQ-1; Tue,
 03 Feb 2026 10:18:22 -0500
X-MC-Unique: vIDi4N1fNXmYPG2R8piODQ-1
X-Mimecast-MFC-AGG-ID: vIDi4N1fNXmYPG2R8piODQ_1770131901
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC28A1800BC2; Tue,  3 Feb 2026 15:17:27 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF25A180094B; Tue,  3 Feb 2026 15:17:25 +0000 (UTC)
Date: Tue, 3 Feb 2026 16:17:22 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/2] block: Wire up 'flat' mode also for 'query-block'
Message-ID: <aYIRgmXsqf09ZfX4@angien.pipo.sk>
References: <cover.1770108436.git.pkrempa@redhat.com>
 <a38d78156b74b134da0f1479a30fc0d6cdb7b97c.1770108436.git.pkrempa@redhat.com>
 <87pl6m2g02.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl6m2g02.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 03, 2026 at 13:01:01 +0100, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:
> 
> > From: Peter Krempa <pkrempa@redhat.com>
> >
> > Some time ago (commit facda5443f5a8) I've added 'flat' mode (which
> > omits 'backing-image' key in reply) to 'query-named-block-nodes' to
> > minimize the size of the returned JSON for deeper backing chains.
> >
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
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> [...]
> 
> > diff --git a/block/qapi.c b/block/qapi.c
> > index 27e0ac6a32..3688d0e713 100644
> > --- a/block/qapi.c
> > +++ b/block/qapi.c
> 
> [...]
> 
> > @@ -698,11 +698,12 @@ bdrv_query_bds_stats(BlockDriverState *bs, bool blk_level)
> >      return s;
> >  }
> >
> > -BlockInfoList *qmp_query_block(Error **errp)
> > +BlockInfoList *qmp_query_block(bool has_flat, bool flat, Error **errp)
> >  {
> >      BlockInfoList *head = NULL, **p_next = &head;
> >      BlockBackend *blk;
> >      Error *local_err = NULL;
> > +    bool return_flat = has_flat && flat;
> 
> This is fine.  Just flat would also be fine: flat implies has_flat.

I've borrowed this from my old patch that added it to
query-named-block-nodes.

Otherwise I'd have to mark 'has_flat' as unused. Nice side effect would
be that 'flat' can then be used directly in the call to bdrv_query_info.

Alternatively I can move the 'has_flat && flat' expression into the
arguments of the call to bdrv_query_info to avoid the extra local
variable.

Whichever you prefer.

> 
> >
> >      GRAPH_RDLOCK_GUARD_MAINLOOP();
> >
> > @@ -714,7 +715,7 @@ BlockInfoList *qmp_query_block(Error **errp)
> >          }
> >
> >          info = g_malloc0(sizeof(*info));
> > -        bdrv_query_info(blk, &info->value, &local_err);
> > +        bdrv_query_info(blk, return_flat, &info->value, &local_err);
> >          if (local_err) {
> >              error_propagate(errp, local_err);
> >              g_free(info);
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index b82af74256..a701f6bbee 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -855,6 +855,10 @@
> >  #
> >  # Get a list of `BlockInfo` for all virtual block devices.
> >  #
> > +# @flat: Omit nested data about the backing image (ie. the contents at
> > +#        'inserted.image.backing-image' are trimmed).
> > +#        Default is false (Since 11.0)
> > +#
> 
> s/ie./i.e./
> 
> Remind me: true suppresses member inserted.image.backing-image, i.e. it
> is absent then.  Correct?

Yes the 'backing-image' key is completely missing when @flat is true.


