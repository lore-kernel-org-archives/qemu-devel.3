Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A06C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzc5X-0007lj-WC; Tue, 01 Apr 2025 09:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzc5C-0007H4-R3
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzc5B-000881-7e
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743515712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PpdbFjnXGFVorHPIhRi0HdIOl3Gya0Cf916d/PyEfrM=;
 b=QgPDcGA0wH5Vgbc0LNykgAtwfpcCophY5rHckBZq05atehPmMk/ub5aK66XqkH9f/NZtPx
 jSggeC9AlvwLdNH3HnW4cmS33imc4ktDRjiCGL2NIeelKkAIl4131E6DPceUrYA1cdFdYI
 rFbgWhDcFGt9Ad7wyKTEP3qCs/+mXwA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-n33EaAFCPGOqJJjAh2kcNw-1; Tue,
 01 Apr 2025 09:55:08 -0400
X-MC-Unique: n33EaAFCPGOqJJjAh2kcNw-1
X-Mimecast-MFC-AGG-ID: n33EaAFCPGOqJJjAh2kcNw_1743515707
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AAC41955DAC; Tue,  1 Apr 2025 13:55:07 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.88])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDF69180B48B; Tue,  1 Apr 2025 13:55:05 +0000 (UTC)
Date: Tue, 1 Apr 2025 08:55:03 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 08/15] fuse: Introduce fuse_{at,de}tach_handlers()
Message-ID: <4r7vggv7jwq376focbc2mhad2b3cfs7eowsgge2ppwtd47c33u@cw3vd3tqxy3x>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-7-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-7-hreitz@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 25, 2025 at 05:06:48PM +0100, Hanna Czenczek wrote:
> Pull setting up and tearing down the AIO context handlers into two
> dedicated functions.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 2df6297d61..bd98809d71 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -78,27 +78,34 @@ static void read_from_fuse_export(void *opaque);
>  static bool is_regular_file(const char *path, Error **errp);
>  
>  
> -static void fuse_export_drained_begin(void *opaque)
> +static void fuse_attach_handlers(FuseExport *exp)
>  {
> -    FuseExport *exp = opaque;
> +    aio_set_fd_handler(exp->common.ctx,
> +                       fuse_session_fd(exp->fuse_session),
> +                       read_from_fuse_export, NULL, NULL, NULL, exp);
> +    exp->fd_handler_set_up = true;

I found this name mildly confusing (does "set_up=true" mean that I
still need to set up, or that I am already set up); would it be better
as s/fd_handler_set_up/fd_handler_armed/g ?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


