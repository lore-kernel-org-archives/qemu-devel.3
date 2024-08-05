Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57C4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saurE-0000zL-4Z; Mon, 05 Aug 2024 06:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1saurC-0000vh-6Q
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1saur9-00051u-MH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722853342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cMCPeeqapOy4nHRjRV42pRvC3egT3AbMWgT3hGtF81c=;
 b=Tf/La4ZmTZRH3EFgP49IFsqd0IkNvmM0AoaGcv3NhVJrkx2NYf+jRd6xKqb9W5OB0c9Xs0
 vFkCruMp/3sT9iw4vX/3TWXDhPsd3PlCdtbmDyFA+buuPyXZXn3tl+I9KdZQBHgw3GSHgQ
 dXTm92vzMbqxEW9ZRDuPVAkJSiwLePw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-22T6F9g1PTOYYajpY1s_cg-1; Mon,
 05 Aug 2024 06:22:19 -0400
X-MC-Unique: 22T6F9g1PTOYYajpY1s_cg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A2071955D52; Mon,  5 Aug 2024 10:22:18 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.224])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D5881955D44; Mon,  5 Aug 2024 10:22:15 +0000 (UTC)
Date: Mon, 5 Aug 2024 12:22:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v6 4/5] vvfat: Fix reading files with non-continuous
 clusters
Message-ID: <ZrCn1Sn64slzK4-m@redhat.com>
References: <cover.1721470238.git.amjadsharafi10@gmail.com>
 <1f3ea115779abab62ba32c788073cdc99f9ad5dd.1721470238.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3ea115779abab62ba32c788073cdc99f9ad5dd.1721470238.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 20.07.2024 um 12:13 hat Amjad Alsharafi geschrieben:
> When reading with `read_cluster` we get the `mapping` with
> `find_mapping_for_cluster` and then we call `open_file` for this
> mapping.
> The issue appear when its the same file, but a second cluster that is
> not immediately after it, imagine clusters `500 -> 503`, this will give
> us 2 mappings one has the range `500..501` and another `503..504`, both
> point to the same file, but different offsets.
> 
> When we don't open the file since the path is the same, we won't assign
> `s->current_mapping` and thus accessing way out of bound of the file.
> 
> From our example above, after `open_file` (that didn't open anything) we
> will get the offset into the file with
> `s->cluster_size*(cluster_num-s->current_mapping->begin)`, which will
> give us `0x2000 * (504-500)`, which is out of bound for this mapping and
> will produce some issues.
> 
> Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
> ---
>  block/vvfat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index b63ac5d045..d2b879705e 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1360,15 +1360,17 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
>  {
>      if(!mapping)
>          return -1;
> -    if(!s->current_mapping ||
> -            strcmp(s->current_mapping->path,mapping->path)) {
> +    if (s->current_mapping != mapping) {
>          /* open file */
>          int fd = qemu_open_old(mapping->path,
> -                               O_RDONLY | O_BINARY | O_LARGEFILE);
> -        if(fd<0)
> +                            O_RDONLY | O_BINARY | O_LARGEFILE);
> +        if (fd < 0) {
>              return -1;
> +        }
>          vvfat_close_current_file(s);
> +
>          s->current_fd = fd;
> +        assert(s->current_fd);
>          s->current_mapping = mapping;
>      }
>      return 0;

Now we're reopening the file even if the mapping is actually referring
to the same file that was already open. So the result should be correct,
but wasteful in what is probably a common case.

However, this version of the patch simplified things enough that I think
I finally see what we really want:

diff --git a/block/vvfat.c b/block/vvfat.c
index e3a83fbc88..8ffe8b3b9b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1369,8 +1369,9 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
             return -1;
         vvfat_close_current_file(s);
         s->current_fd = fd;
-        s->current_mapping = mapping;
     }
+
+    s->current_mapping = mapping;
     return 0;
 }

That should be all that is needed, and it passes your test case.

I don't usually do this, but since time is running out for QEMU 9.1,
I'll just replace the code of this patch with the above and go ahead
with that. If you think it's wrong, let me know and we'll fix it on top
of this series.

Kevin


