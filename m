Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C17C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 20:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdbNv-0005Gn-Pg; Thu, 30 Jan 2025 15:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdbNs-0005G2-6m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdbNq-0007VB-Sg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738269810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tYQP/vN7wjgnN0Om2H0JI+3FDYfk9MokKiwaAx7FtG0=;
 b=VnPv+Iknpi/vi8U+FQn72OeO715jyF/EKcDEY8RA5WuzLCpfRQBSA3kcBn8rAVybZmseNP
 FN/YJ7uMWf9sPEiAyRrGr1vj2RNq/OxQmbq3voyw50BK1Sz0SlDdQJGQEkS1qv9TRx+Yyj
 GPUUvVqix7nOGwJx7zHm0cXFsqHkHoo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-MfkdSxHtMReAtFqrw6KbkQ-1; Thu,
 30 Jan 2025 15:43:26 -0500
X-MC-Unique: MfkdSxHtMReAtFqrw6KbkQ-1
X-Mimecast-MFC-AGG-ID: MfkdSxHtMReAtFqrw6KbkQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB2551800361; Thu, 30 Jan 2025 20:43:24 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21C7E18008F0; Thu, 30 Jan 2025 20:43:21 +0000 (UTC)
Date: Thu, 30 Jan 2025 14:43:19 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com, 
 peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 6/9] nbd/server: Support inactive nodes
Message-ID: <wo7bm767w64rv4xyak2l3kcv3amcklsq6do7d2zftcl6qep7pg@yspy4morhhrl>
References: <20250122115046.51216-1-kwolf@redhat.com>
 <20250122115046.51216-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122115046.51216-7-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 22, 2025 at 12:50:43PM +0100, Kevin Wolf wrote:
> In order to support running an NBD export on inactive nodes, we must
> make sure to return errors for any operations that aren't allowed on
> inactive nodes. Reads are the only operation we know we need for
> inactive images, so to err on the side of caution, return errors for
> everything else, even if some operations could possibly be okay.

Block status might be the only other command I could see being needed,
but I also agree with the approach of not supporting it until we have
a use case in mind (if ever).

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  nbd/server.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

> @@ -2920,6 +2921,22 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>      NBDExport *exp = client->exp;
>      char *msg;
>      size_t i;
> +    bool inactive;
> +
> +    WITH_GRAPH_RDLOCK_GUARD() {
> +        inactive = bdrv_is_inactive(blk_bs(exp->common.blk));

Can the declaration of bool inactive be moved inside the lock guard
block?  Not a problem if you want to leave it with all other
declarations, though.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


