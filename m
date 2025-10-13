Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC527CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IxS-0006wE-Iv; Mon, 13 Oct 2025 09:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8IxP-0006pZ-4U
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8IxI-0008PZ-Qk
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760363464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=55KnTFk+tuYE0kny+3/SZffitL+JPm8SdzM9xFZAy9o=;
 b=PNfVOUt9lkmA3iIwZT0cPBo5oeQIKiHQjEIi2Cuc8k/Fk8R6yXNiqbKZCJvrsyQIWJ1r1v
 SB3u2rji2FrCdHc+mzoN9ARvP1Dz+j7GEINvLlerDby5nYyetfokLKOunzxe8/1qCGY95r
 xW+D/kI/6sG9OVHOP6PF87ymvrq/qeQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-x6UI7TLDPlivquAnkOsFZw-1; Mon,
 13 Oct 2025 09:51:01 -0400
X-MC-Unique: x6UI7TLDPlivquAnkOsFZw-1
X-Mimecast-MFC-AGG-ID: x6UI7TLDPlivquAnkOsFZw_1760363460
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7811B19560B7; Mon, 13 Oct 2025 13:51:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.195])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32AA21800446; Mon, 13 Oct 2025 13:50:57 +0000 (UTC)
Date: Mon, 13 Oct 2025 15:50:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 05/21] fuse: Change setup_... to mount_fuse_export()
Message-ID: <aO0Dv6kPk6M3TK2T@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-6-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-6-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
> There is no clear separation between what should go into
> setup_fuse_export() and what should stay in fuse_export_create().
> 
> Make it clear that setup_fuse_export() is for mounting only.  Rename it,
> and move everything that has nothing to do with mounting up into
> fuse_export_create().
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 49 ++++++++++++++++++++-------------------------
>  1 file changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 60d68d8fdd..01a5716bdd 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c

> +    g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
> +
> +    aio_set_fd_handler(exp->common.ctx,
> +                       fuse_session_fd(exp->fuse_session),
> +                       read_from_fuse_export, NULL, NULL, NULL, exp);
> +    exp->fd_handler_set_up = true;
> +

Preexisting, but 'exports' is really a bad name for a global variable in
QEMU. Maybe we should rename it to 'fuse_exports' on top of the series.

Kevin


