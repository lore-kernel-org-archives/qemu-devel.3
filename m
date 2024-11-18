Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24246D49234
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3fs-0004rC-3y; Mon, 18 Nov 2024 10:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD3fq-0004ql-H9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD3fo-0004qh-SD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731943700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=buqvqS9Khz6RF5jAdp4t3G8HHg9+w7BCQqxr1jXxBgI=;
 b=CIaBote3CsuC+VxQ9ujihIK0sUe+MMcWsjBI55HKL+/c/Elj4Y6wYRspp6FkKIAlbipY/8
 0gQtl+JQrmCnUdyCMu3igeahIGLdqTJI1ldw1oauOASlEYKWfIGSzqUEdMWQ5tNgYXsi3l
 QMhnjyAeHfyZLiq3xublpks7w6gdSlE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160--W-4Gi9eNm-TSFesh1-F1Q-1; Mon,
 18 Nov 2024 10:27:46 -0500
X-MC-Unique: -W-4Gi9eNm-TSFesh1-F1Q-1
X-Mimecast-MFC-AGG-ID: -W-4Gi9eNm-TSFesh1-F1Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E38AC195394D; Mon, 18 Nov 2024 15:27:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49F591955F43; Mon, 18 Nov 2024 15:27:42 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:27:39 -0600
From: Eric Blake <eblake@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2] vpc: Read images exported from Azure correctly
Message-ID: <itnfgqpjggu6jlkhaci32wz3d35o4wvwkbyys5j5qwsxumnjya@2zsfsx4rt2fe>
References: <20241118143646.33377-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118143646.33377-1-vkuznets@redhat.com>
User-Agent: NeoMutt/20241002
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 18, 2024 at 03:36:46PM +0100, Vitaly Kuznetsov wrote:
> It was found that 'qemu-nbd' is not able to work with some disk images
> exported from Azure. Looking at the 512b footer (which contains VPC
> metadata):
> 
> 00000000  63 6f 6e 65 63 74 69 78  00 00 00 02 00 01 00 00  |conectix........|
> 00000010  ff ff ff ff ff ff ff ff  2e c7 9b 96 77 61 00 00  |............wa..|
> 00000020  00 07 00 00 57 69 32 6b  00 00 00 01 40 00 00 00  |....Wi2k....@...|
> 00000030  00 00 00 01 40 00 00 00  28 a2 10 3f 00 00 00 02  |....@...(..?....|
> 00000040  ff ff e7 47 8c 54 df 94  bd 35 71 4c 94 5f e5 44  |...G.T...5qL._.D|
> 00000050  44 53 92 1a 00 00 00 00  00 00 00 00 00 00 00 00  |DS..............|
> 00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 
> we can see that Azure uses a different 'Creator application' --
> 'wa\0\0' (offset 0x1c, likely reads as 'Windows Azure') and QEMU uses this
> field to determine how it can get image size. Apparently, Azure uses 'new'
> method, just like Hyper-V.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Alternatively, we can probably make 'current_size' the default and only use
> CHS for 'vpc '/'qemu'.
> ---
>  block/vpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/vpc.c b/block/vpc.c
> index d95a204612b7..b67798697c15 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -321,6 +321,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>       *      'qemu'  :  CHS              QEMU (uses disk geometry)
>       *      'qem2'  :  current_size     QEMU (uses current_size)
>       *      'win '  :  current_size     Hyper-V
> +     *      'wa\0\0':  current_size     Azure
>       *      'd2v '  :  current_size     Disk2vhd
>       *      'tap\0' :  current_size     XenServer
>       *      'CTXS'  :  current_size     XenConverter
> @@ -330,6 +331,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>       *  that have CHS geometry of the maximum size.
>       */
>      use_chs = (!!strncmp(footer->creator_app, "win ", 4) &&
> +               !!memcmp(footer->creator_app, "wa\0", 4) &&

While this is literally correct (a string literal with 3 characters
spelled out includes the implicit NUL byte; sizeof("wa\0") == 4), it
is a bit odd to see a memcmp() of 4 bytes against a literal containing
only 3 characters, especially when the comments above spelled it out
with four characters.  For the sake of avoiding further confusion, it
might be nice to use memcmp() against explicit 4-byte patterns for all
of the strings (not just the Azure witness).

>                 !!strncmp(footer->creator_app, "qem2", 4) &&
>                 !!strncmp(footer->creator_app, "d2v ", 4) &&
>                 !!strncmp(footer->creator_app, "CTXS", 4) &&

I also don't know if it would be any easier to read by creating a
`static const char table[][4] = { "qemu", "qem2", "wa", ...}` (where
you don't have to write any explicit \0, because the compiler is
guaranteed to NUL-pad short strings into the char[4] table entry) and
then write a loop over each entry in the table, rather than having to
spell out a separate strncmp/memcmp line for each string in the table.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


