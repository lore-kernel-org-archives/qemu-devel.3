Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C277C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traUH-0007zu-J1; Mon, 10 Mar 2025 06:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1traUF-0007xz-BT
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1traUB-0002VZ-UI
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741602950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiBhGl194zUP3tnlpGCAxgoOvKg4tv3F89gPeIt/aOU=;
 b=isT2tcO3Q4pRnF+GCLPF/V4sR7C0ymAmah/NButQ/Ei2idaPHI0viEa6QbGy++dRblq3Ur
 ZsNy0HEmDvPBf21bknZGIisFBCZXhZ6SinEiw/R+8Tz1patXJTKVXDPsSW3LgbxNydcTjd
 BBaXSVGUnQNSjEeIoYEH57ssvLNiszE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-bN6QDz-fPPGmsqEs-8Um9A-1; Mon,
 10 Mar 2025 06:35:49 -0400
X-MC-Unique: bN6QDz-fPPGmsqEs-8Um9A-1
X-Mimecast-MFC-AGG-ID: bN6QDz-fPPGmsqEs-8Um9A_1741602948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4F9719560AB; Mon, 10 Mar 2025 10:35:47 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.222])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2B0E1800373; Mon, 10 Mar 2025 10:35:45 +0000 (UTC)
Date: Mon, 10 Mar 2025 11:35:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] block/vmdk: prevent double-free in extent memory
 management
Message-ID: <Z87Afzk_3r6ft_J4@redhat.com>
References: <20250304090415.39393-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304090415.39393-1-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 04.03.2025 um 10:04 hat gerben@altlinux.org geschrieben:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> This error was discovered by fuzzing qemu-img.
> 
> A double-free issue in the VMDK driver occurs when handling snapshots.
> The memory allocated for extent structures is freed twice: first in
> vmdk_close (block/vmdk.c) and then in vmdk_add_extent (block/vmdk.c).
> 
> The fix ensures the s->extents pointer is set to NULL after freeing,
> preventing double-free.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2853
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>  block/vmdk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 2adec49912..d6baa54602 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -285,6 +285,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
>      bdrv_graph_wrunlock();
>  
>      g_free(s->extents);
> +    s->extents = NULL;
>  }

This is not the right fix. It only papers over the real bug, which is
that bdrv_snapshot_goto() calls .bdrv_open() for a BlockDriverState
whose bs->opaque hasn't been zeroed. Open functions of block drivers
generally rely on having a zeroed state.

Kevin


