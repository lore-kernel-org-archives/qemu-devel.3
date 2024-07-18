Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAB6C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUSwA-0004Rk-Qf; Thu, 18 Jul 2024 11:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUSw8-0004Qk-U7
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUSw5-00076l-BY
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721316046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dfk/ps4REpGUzBFcO/mjybkw26uJ7hbTETRjtXpB8LY=;
 b=HWqpVIg08YU+MxrJYQY7y2cknTFCJL8wfxeYc/mI+dj7yJQ3GrRcd2zVp5E76kJnzKrLbs
 E9gjMwGAZyvpUSVlN9/366nyxj4QqVb0HTb2RBEwCLui4fxNnH4+UGifADPmQIIH6mzXSr
 4PtgTloHDcswZqWB9//HTMaKAbCQCRs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-zu0Daln2Ohya02GFXWauhA-1; Thu,
 18 Jul 2024 11:20:44 -0400
X-MC-Unique: zu0Daln2Ohya02GFXWauhA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 097651955D4A; Thu, 18 Jul 2024 15:20:42 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.0])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 537B01955F3B; Thu, 18 Jul 2024 15:20:39 +0000 (UTC)
Date: Thu, 18 Jul 2024 17:20:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 4/5] vvfat: Fix reading files with non-continuous
 clusters
Message-ID: <ZpkyxA3s_gzQE7gW@redhat.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
 <9c0be954b608da7d47c6a0c120da332c16798d2a.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0be954b608da7d47c6a0c120da332c16798d2a.1718195956.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 12.06.2024 um 14:43 hat Amjad Alsharafi geschrieben:
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
>  block/vvfat.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index b63ac5d045..fc570d0610 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1360,15 +1360,24 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
>  {
>      if(!mapping)
>          return -1;
> +    int new_path = 1;
>      if(!s->current_mapping ||
> -            strcmp(s->current_mapping->path,mapping->path)) {
> -        /* open file */
> -        int fd = qemu_open_old(mapping->path,
> +            s->current_mapping->info.file.offset
> +                != mapping->info.file.offset ||

I'm wondering if this couldn't just be s->current_mapping != mapping?

> +            (new_path = strcmp(s->current_mapping->path, mapping->path))) {

If both the path and the offset change, we still want to set new_path, I
think. And if we didn't already have a mapping, we also need to open the
file.

Actually, setting a variable inside the condition makes it kind of hard
to read, so if s->current_mapping != mapping works, we can do the check
only in the conditon below:

> +        if (new_path) {

if (!s->current_mapping ||
    strcmp(s->current_mapping->path, mapping->path))

> +            /* open file */
> +            int fd = qemu_open_old(mapping->path,
>                                 O_RDONLY | O_BINARY | O_LARGEFILE);
> -        if(fd<0)
> -            return -1;
> -        vvfat_close_current_file(s);
> -        s->current_fd = fd;
> +            if (fd < 0) {
> +                return -1;
> +            }
> +            vvfat_close_current_file(s);
> +
> +            s->current_fd = fd;
> +        }
> +        assert(s->current_fd);
>          s->current_mapping = mapping;
>      }

Kevin


