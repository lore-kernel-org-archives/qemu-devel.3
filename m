Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A82C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4uu-0006VN-Bk; Fri, 31 May 2024 12:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD4us-0006Us-RT
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD4ur-0000H3-9S
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717172140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gw/3fc9bC7x1Kb0D+pOU1v94rkZdD6VM8IFr3aPmTx4=;
 b=PTUMOdzjY4a1V+IWt/uQ8bZVpVSYg7isvqy59LWxERpq6o7nv1d4YJmT4adTlYgWw9vgSL
 W+tnS8fl/9z2GFoRB2REtJli91UlBJc8jL20jaPUjFx2BJFb7WqjuRedYz0eA+ELnIEY1R
 X2kXLPBru9roVKyHfKXkliqP4611WJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-ET_y_noIOyGLLUiXJ_VnFQ-1; Fri, 31 May 2024 12:15:37 -0400
X-MC-Unique: ET_y_noIOyGLLUiXJ_VnFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A2F800169;
 Fri, 31 May 2024 16:15:36 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28B8A40C6EB7;
 Fri, 31 May 2024 16:15:36 +0000 (UTC)
Date: Fri, 31 May 2024 18:15:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 1/6] vvfat: Fix bug in writing to middle of file
Message-ID: <Zln3p6x_pjoyIHYq@redhat.com>
References: <cover.1716717181.git.amjadsharafi10@gmail.com>
 <2871281d8ea41fb4d7ef8f9beeaba017a1717019.1716717181.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2871281d8ea41fb4d7ef8f9beeaba017a1717019.1716717181.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 26.05.2024 um 11:56 hat Amjad Alsharafi geschrieben:
> Before this commit, the behavior when calling `commit_one_file` for
> example with `offset=0x2000` (second cluster), what will happen is that
> we won't fetch the next cluster from the fat, and instead use the first
> cluster for the read operation.
> 
> This is due to off-by-one error here, where `i=0x2000 !< offset=0x2000`,
> thus not fetching the next cluster.
> 
> Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>

> diff --git a/block/vvfat.c b/block/vvfat.c
> index 9d050ba3ae..ab342f0743 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -2525,7 +2525,7 @@ commit_one_file(BDRVVVFATState* s, int dir_index, uint32_t offset)
>          return -1;
>      }
>  
> -    for (i = s->cluster_size; i < offset; i += s->cluster_size)
> +    for (i = s->cluster_size; i <= offset; i += s->cluster_size)
>          c = modified_fat_get(s, c);

While your change results in the correct behaviour, I think I would
prefer the code to be changed like this so that at the start of each
loop iteration, 'i' always refers to the offset that matches 'c':

    for (i = 0; i < offset; i += s->cluster_size) {
        c = modified_fat_get(s, c);
    }

I'm also adding braces here to make the code conform with the QEMU
coding style. You can use scripts/checkpatch.pl to make sure that all
code you add has the correct style. Much of the vvfat code predates the
coding style, so you'll often have to change style when you touch a
line. (Which is good, because it slowly fixes the existing mess.)

You can keep my Reviewed/Tested-by if you change this.

Kevin


