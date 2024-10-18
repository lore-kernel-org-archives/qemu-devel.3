Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509B4D30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ptZ-0005Hf-90; Fri, 18 Oct 2024 12:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1ptX-0005FO-HP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1ptU-0006jN-Mm
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729269122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSge55wAhHNuoM35XbLzq8lU61J+TYnwAqZD8ofvPEc=;
 b=LUzVhSnjRuvIPJWsdIa6vRgjISnN3GwRR1blD/dsV/mCA5VgADtnzfeO6Q8W8seE+IH7OQ
 xoQxfaYL7P/SULuQVpQYdO8fvrhJK+tr+C+YFJX0uviCXwJEtWZZCL5tcvMKejFvHhhhtw
 Nsznjibcz+9y+oZAbqrCMWNDyaMopbo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-Lt5R7bCMPGiAN_9hkni7GQ-1; Fri,
 18 Oct 2024 12:32:00 -0400
X-MC-Unique: Lt5R7bCMPGiAN_9hkni7GQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD4DA1955F3D; Fri, 18 Oct 2024 16:31:58 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.196])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89C4230001A5; Fri, 18 Oct 2024 16:31:54 +0000 (UTC)
Date: Fri, 18 Oct 2024 18:31:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: luzhipeng <luzhipeng@cestc.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] vmdk:truncate more one sector in init extent
Message-ID: <ZxKNd_KqTJ9p_IIg@redhat.com>
References: <20240822105237.777-1-luzhipeng@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822105237.777-1-luzhipeng@cestc.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 22.08.2024 um 12:52 hat luzhipeng geschrieben:
> issue:https://gitlab.com/qemu-project/qemu/-/issues/1357
> empty vmdk only contains metadata, ovftool failed.
> So it allocates more one sector for empty disk. the ovftool
> command line: ovftool input.ovf output.ova
> 
> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>

I think this commit message needs more of the information from the bug
report, otherwise it seems unexplainable why adding an empty sector
should make a difference.

> diff --git a/block/vmdk.c b/block/vmdk.c
> index 78f6433607..283dee9b49 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2286,7 +2286,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
>          goto exit;
>      }
>  
> -    ret = blk_co_truncate(blk, le64_to_cpu(header.grain_offset) << 9, false,
> +    ret = blk_co_truncate(blk, (le64_to_cpu(header.grain_offset) << 9) + BDRV_SECTOR_SIZE,
> +                          false, PREALLOC_MODE_OFF, 0, errp);
>      if (ret < 0) {
>          goto exit;

This is not a good fix. It means that we will always leave an empty
sector after the header, even if more data follows.

Does the problem really only happen with empty images? I think we don't
necessarily add an end-of-stream marker for other images either, we just
align the image size to full sectors at the end of 'qemu-img convert'.

I wonder if vmdk_co_pwritev_compressed() should be changed to write both
a footer and an explicit end-of-stream marker for streamOptimized images
in the bytes == 0 case.

Kevin


