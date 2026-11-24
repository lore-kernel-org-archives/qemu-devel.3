Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A8606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IlXOFB+x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVwDg-00035k-Ho; Tue, 24 Nov 2026 14:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xVwDe-00035S-Uz
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xVwDd-0002rc-DC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795548618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nISrrAHkxikUoh5nI4EF4FHe+5ThDISub+XUdRnCxvw=;
 b=IlXOFB+xEFftJIFWiPLkWOpoYN7qVrCp7z0rM+tE0iKpQZT8NKnKMX4K3TNzK+TZ9BiLIY
 zN38PEO+mnYBfAPkLt6OI0olELt+JGnHT1iWvxFEAI1HMedvFsaZTaCVdsCokiHz6D0/i8
 x4syhcdiJtFpTbS7NR8gYswMEFA9FJc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-ouEgpD5mM2GRpD1lrUwuKg-1; Tue,
 24 Nov 2026 19:30:15 +0000
X-MC-Unique: ouEgpD5mM2GRpD1lrUwuKg-1
X-Mimecast-MFC-AGG-ID: ouEgpD5mM2GRpD1lrUwuKg_1795548614
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE0921955F00
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:30:13 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7667F1956045; Tue, 24 Nov 2026 19:30:09 +0000 (UTC)
Date: Tue, 24 Nov 2026 13:30:05 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com, 
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH] file-posix: Fix loss of QAPI feature
 'dynamic-auto-read-only'
Message-ID: <awXlbpIs9QdJZfIC@redhat.com>
References: <20261124152218.2562390-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124152218.2562390-1-armbru@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 04:22:18PM +0100, Markus Armbruster wrote:
> Recent commit 691094b7091b added a variant member to BlockdevOptions
> branch 'host-device' by changing the branch type to new struct type
> BlockdevOptionsHostDevice that has the old branch type
> BlockdevOptionsFile as base.  This is a perfectly reasonable thing to
> do.  However, since a type only inherits its base's members, and not
> its features or conditions, this lost BlockdevOptionsFile's feature
> 'dynamic-auto-read-only'.
> 
> Considering we are in deep freeze, fix the regression the stupidest
> and safest way possible: copy the feature from BlockdevOptionsFile to
> BlockdevOptionsHostDevice.
> 
> Reported-by: Peter Krempa <pkrempa@redhat.com>
> Fixes: 691094b7091b ("file-posix: Add 'accept-read-only-device' option")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

While we may do a more complete change in 12.0, I agree that this
patch is worth having in 11.2.

> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 23c5787d99b..7aa4fa2df93 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3403,11 +3403,23 @@
>  #     writable.  If it is true, this check is skipped.  (since: 11.2,
>  #     default: false)
>  #
> +# Features:
> +#
> +# @dynamic-auto-read-only: If present, enabled auto-read-only means
> +#     that the driver will open the image read-only at first,
> +#     dynamically reopen the image file read-write when the first
> +#     writer is attached to the node and reopen read-only when the
> +#     last writer is detached.  This allows giving QEMU write
> +#     permissions only on demand when an operation actually needs
> +#     write access.
> +#
>  # Since: 11.2
>  ##
>  { 'struct': 'BlockdevOptionsHostDevice',
>    'base': 'BlockdevOptionsFile',
> -  'data': { '*accept-read-only-device': 'bool' } }
> +  'data': { '*accept-read-only-device': 'bool' },
> +  'features': [ { 'name': 'dynamic-auto-read-only',
> +                  'if': 'CONFIG_POSIX' } ] }

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


