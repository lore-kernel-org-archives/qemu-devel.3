Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB66C02196
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 20:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmEQ-000555-Mo; Wed, 05 Feb 2025 15:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfmEL-00054k-R2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:42:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tfmEJ-0007lj-EP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738788157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BtDFz2ZUBgfeOh1Wn+3O8jJj0l8qY1601XWAX02SDso=;
 b=VvWOB8ga3D59y0rlVZJruT7tklJr+P6z/6lyx2wrHGOs+iso7nAvWInPIj3JDQzwxh0POi
 39c7vYKJpeHUWdIkY9mWoq3lAYBndPWQqhDSmuDl3pM1S6RLns/7sGgkhu7YBW9EkvU3Sc
 zkW47myhmRuGoe2brHtkM28bMpia/T4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-OZ67qIBwNk-HG3XSVT-N_w-1; Wed,
 05 Feb 2025 15:42:36 -0500
X-MC-Unique: OZ67qIBwNk-HG3XSVT-N_w-1
X-Mimecast-MFC-AGG-ID: OZ67qIBwNk-HG3XSVT-N_w
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1D55180056F; Wed,  5 Feb 2025 20:42:34 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 033231800872; Wed,  5 Feb 2025 20:42:31 +0000 (UTC)
Date: Wed, 5 Feb 2025 14:42:29 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 11/16] block: Drain nodes before inactivating them
Message-ID: <ylu54rplep3pzmdj2ld5tkhupukn4p5ffd7rwdrecvhcftioif@4kjf2vjf35x6>
References: <20250204211407.381505-1-kwolf@redhat.com>
 <20250204211407.381505-12-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204211407.381505-12-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 04, 2025 at 10:14:02PM +0100, Kevin Wolf wrote:
> So far the assumption has always been that if we try to inactivate a
> node, it is already idle. This doesn't hold true any more if we allow
> inactivating exported nodes because we can't know when new external

'deactivating' sounds nicer than 'inactivating', but I can also see
why you went with 'inactivating' since the flag is centered around the
notion of INACTIVE.

> requests come in.
> 
> Drain the node around setting BDRV_O_INACTIVE so that requests can't
> start operating on an active node and then in the middle it suddenly
> becomes inactive. With this change, it's enough for exports to check
> for new requests that they operate on an active node (or, like reads,
> are allowed even on an inactive node).
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block.c b/block.c
> index 7eeb8d076e..1601b25f66 100644
> --- a/block.c
> +++ b/block.c
> @@ -7032,7 +7032,9 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
>          return -EPERM;
>      }
>  
> +    bdrv_drained_begin(bs);
>      bs->open_flags |= BDRV_O_INACTIVE;
> +    bdrv_drained_end(bs);
>  
>      /*
>       * Update permissions, they may differ for inactive nodes.
> -- 
> 2.48.1
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


