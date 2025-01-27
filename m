Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4B0C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMkI-0000Sy-Sq; Mon, 27 Jan 2025 05:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tcMkG-0000SA-M5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:53:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tcMkE-0006PG-RD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737975209;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qx6AzvLdoLzXCApqop9S9vhTqdsFG5gi6cdOy/8/MM=;
 b=AKZVDuqRiA/kXZ6/3Oetr73k+ki/WBrVKcDHGBWv0Dah7Lc3qXLRmolOQrKQdRbY3FuAc3
 h+46kEPDPdLZbDnow6kyma3ctnl2qhUYmnTA4gxVVoTNHlGUD7Aj2FGxvF4v43mXnXycev
 lM+ImlIBSGbdJ6AUWS1j0W5XtRGZBGo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-OGbhIgh0PsSwRWstpCMliA-1; Mon,
 27 Jan 2025 05:53:25 -0500
X-MC-Unique: OGbhIgh0PsSwRWstpCMliA-1
X-Mimecast-MFC-AGG-ID: OGbhIgh0PsSwRWstpCMliA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7360819560AB; Mon, 27 Jan 2025 10:53:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.21])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14CFB195608A; Mon, 27 Jan 2025 10:53:20 +0000 (UTC)
Date: Mon, 27 Jan 2025 10:53:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] block-backend: Fix argument order when calling
 'qapi_event_send_block_io_error()'
Message-ID: <Z5dlnHdG_mWS5InU@redhat.com>
References: <09728d784888b38d7a8f09ee5e9e9c542c875e1e.1737973614.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09728d784888b38d7a8f09ee5e9e9c542c875e1e.1737973614.git.pkrempa@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 27, 2025 at 11:29:24AM +0100, Peter Krempa wrote:
> Commit 7452162adec25c10 introduced 'qom-path' argument to BLOCK_IO_ERROR
> event but when the event is instantiated in 'send_qmp_error_event()' the
> arguments for 'device' and 'qom_path' in
> qapi_event_send_block_io_error() were reversed :
> 
> Generated code for sending event:
> 
>   void qapi_event_send_block_io_error(const char *qom_path,
>                                       const char *device,
>                                       const char *node_name,
>                                       IoOperationType operation,
>                                       [...]
> 
> Call inside send_qmp_error_event():
> 
>      qapi_event_send_block_io_error(blk_name(blk),
>                                     blk_get_attached_dev_path(blk),
>                                     bs ? bdrv_get_node_name(bs) : NULL, optype,
>                                     [...]
> 
> This results into reporting the QOM path as the device alias and vice
> versa which in turn breaks libvirt, which expects the device alias being
> either a valid alias or empty (which would make libvirt do the lookup by
> node-name instead).
> 
> Fixes: 7452162adec25c1003d5bf0079aca52913a80e0c
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>

Hmm, luckily that was only introduced in 9.2.0, so we can probably just
fix it in stable, and not worry about libvirt needs to add back compat
to workaround the initially broken 9.2.0 release events.

> ---
>  block/block-backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index c93a7525ad..981be67e5d 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2136,8 +2136,8 @@ static void send_qmp_error_event(BlockBackend *blk,
>      BlockDriverState *bs = blk_bs(blk);
> 
>      optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
> -    qapi_event_send_block_io_error(blk_name(blk),
> -                                   blk_get_attached_dev_path(blk),
> +    qapi_event_send_block_io_error(blk_get_attached_dev_path(blk),
> +                                   blk_name(blk),
>                                     bs ? bdrv_get_node_name(bs) : NULL, optype,
>                                     action, blk_iostatus_is_enabled(blk),
>                                     error == ENOSPC, strerror(error));
> -- 
> 2.48.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


