Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D40C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 05:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txJbz-0005AN-NT; Wed, 26 Mar 2025 01:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txJbw-000596-1y
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 01:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txJbu-0006lR-Js
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 01:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742968049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=si+0Dln2Tv2z43sX45U3zFyAG4cKW49/cqEhNFSLbdU=;
 b=bRKHCPWY9fvfAy6LHceG/LlLYy6HiRtuJWV7cx/QaY3Iw0RQGiNq5BvCScZyfe0q3ITjS3
 JWbmJE7jr33q71ZIYgmzWJcXw4YmYX+wOlFaLwxqQaL6SV27zG125L2DJTmcWX1q3SaLoh
 81OHR/MxdpizaguGMlqEvkQXiwXOy6Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-A3au-ERROPmkEIQzcaypPQ-1; Wed,
 26 Mar 2025 01:47:25 -0400
X-MC-Unique: A3au-ERROPmkEIQzcaypPQ-1
X-Mimecast-MFC-AGG-ID: A3au-ERROPmkEIQzcaypPQ_1742968044
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D67A81801A07; Wed, 26 Mar 2025 05:47:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FACC1801750; Wed, 26 Mar 2025 05:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B1B021E66C7; Wed, 26 Mar 2025 06:47:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 02/15] fuse: Ensure init clean-up even with error_fatal
In-Reply-To: <20250325160655.119407-1-hreitz@redhat.com> (Hanna Czenczek's
 message of "Tue, 25 Mar 2025 17:06:42 +0100")
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-1-hreitz@redhat.com>
Date: Wed, 26 Mar 2025 06:47:16 +0100
Message-ID: <87o6xofimz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hanna Czenczek <hreitz@redhat.com> writes:

> When exports are created on the command line (with the storage daemon),
> errp is going to point to error_fatal.  Without ERRP_GUARD, we would
> exit immediately when *errp is set, i.e. skip the clean-up code under
> the `fail` label.  Use ERRP_GUARD so we always run that code.
>
> As far as I know, this has no actual impact right now[1], but it is
> still better to make this right.
>
> [1] Not cleaning up the mount point is the only thing I can imagine
>     would be problematic, but that is the last thing we attempt, so if
>     it fails, it will clean itself up.

Hmm.

The pattern is "no cleanup with &error_fatal or &error_abort, but not
cleaning up then is harmless".  How many instances do we have?  My gut
feeling is in the hundreds.  Why is "fixing" just this one worth the
bother?

> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index a12f479492..7c035dd6ca 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -119,6 +119,7 @@ static int fuse_export_create(BlockExport *blk_exp,
>                                BlockExportOptions *blk_exp_args,
>                                Error **errp)
>  {
> +    ERRP_GUARD(); /* ensure clean-up even with error_fatal */
>      FuseExport *exp = container_of(blk_exp, FuseExport, common);
>      BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
>      int ret;


