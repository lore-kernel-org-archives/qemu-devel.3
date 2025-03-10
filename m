Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FE6C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tratI-0006iO-Ht; Mon, 10 Mar 2025 07:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trasn-0006Px-1e
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trasl-0006vH-EX
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741604472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tXpEai54IsgN5h4NUDyKwAS46tnU3YIf2hGmXR6cIpI=;
 b=GVrMkLZclVQhK5rqs8w5GEoYR0dkWE8GaXV671jAzcXt2m4uKQ6mO/gJnecJYY3M0fRAAj
 xPjC/hgaWf/c419MIQmCMJUWjBy9iYV6wCG7nkg9sncyGHjSgJdr0gnm7BVLgng8IctcZ9
 iYHhVcSRUgLBlpbVSCtjHB0TwdPhNnI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-fP8TvOWtNyK4w-8vjZE6Kg-1; Mon,
 10 Mar 2025 07:01:11 -0400
X-MC-Unique: fP8TvOWtNyK4w-8vjZE6Kg-1
X-Mimecast-MFC-AGG-ID: fP8TvOWtNyK4w-8vjZE6Kg_1741604470
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF5F019560B7; Mon, 10 Mar 2025 11:01:09 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.222])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6F8C1956096; Mon, 10 Mar 2025 11:01:07 +0000 (UTC)
Date: Mon, 10 Mar 2025 12:01:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] block/snapshot: fix *errp handling in bdrv_snapshot_goto
Message-ID: <Z87GcceOGOM4wAkI@redhat.com>
References: <20250304080213.36099-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304080213.36099-1-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 04.03.2025 um 09:01 hat gerben@altlinux.org geschrieben:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> This error was discovered by fuzzing qemu-img.
> 
> If bdrv_snapshot_goto() returns an error, it is not handled immediately,
> allowing *errp to be reassigned when qcow_open() fails, which triggers
> assert(*errp == NULL) in util/error.c: void error_setv().
> 
> This patch ensures that errors from bdrv_snapshot_goto() are handled
> immediately after the call, preventing *errp from being modified twice
> and avoiding unnecessary assertion failures.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2851
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>  block/snapshot.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/snapshot.c b/block/snapshot.c
> index 9c44780e96..d1b5a8d33d 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -296,14 +296,20 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>          bdrv_graph_wrunlock();
>  
>          ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
> +        if (ret < 0) {
> +            bdrv_unref(fallback_bs);
> +            bs->drv = NULL;
> +            /* A bdrv_snapshot_goto() error takes precedence */
> +            error_propagate(errp, local_err);
> +            return ret;
> +        }

Now you return without having reopened the image!

>          open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
>          qobject_unref(options);
>          if (open_ret < 0) {
>              bdrv_unref(fallback_bs);
>              bs->drv = NULL;
> -            /* A bdrv_snapshot_goto() error takes precedence */
>              error_propagate(errp, local_err);
> -            return ret < 0 ? ret : open_ret;
> +            return open_ret;
>          }

I don't see a problem in the old code. local_err is still NULL at this
point, so it's safe to pass it to drv->bdrv_open(). A previous error
from bdrv_snapshot_goto() is stored in errp, which is separate.

The line in qcow.c (test.qed is misleading as a filename!) that causes
the assertion failure is this:

    error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
               "does not support live migration",
               bdrv_get_device_or_node_name(bs));

This is an internal field that is not related to either error in
bdrv_snapshot_goto(). This is another instance of the same bug that
bs->opaque needs to be zeroed before calling drv->bdrv_open(). I sent a
patch for that.

Kevin


