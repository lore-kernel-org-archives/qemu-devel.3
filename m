Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFED5C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJpl-0008Ab-Mw; Tue, 20 May 2025 06:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHJpk-0008AE-7Y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHJph-0000En-Ec
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747735455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hEhSmeqcDlwZPpkP6jKz6Q4FGkALG/bs9LYCyyZqexo=;
 b=UbKAcXB4/hkxfEOfebwGErcC4qz4I0gag1dHvnxVtT/lR+AdJVPtDTyz/Yzjauu8SP/CLb
 vL9PL/YKn53Jhw1w1iKlD5jZJEb7+naIk8a/n4Yrk0Q09iX6ghN9gaBb/i4BKqDFimMN0I
 lX32eryCzrKORYL7njC8s5ZWM3j0f7k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-ffSFySFwMWuXeJ1_tFIEsg-1; Tue,
 20 May 2025 06:04:12 -0400
X-MC-Unique: ffSFySFwMWuXeJ1_tFIEsg-1
X-Mimecast-MFC-AGG-ID: ffSFySFwMWuXeJ1_tFIEsg_1747735451
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C91C81800447; Tue, 20 May 2025 10:04:10 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.86])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5851E30001AA; Tue, 20 May 2025 10:04:07 +0000 (UTC)
Date: Tue, 20 May 2025 12:04:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH v2] qemu-img: fix offset calculation in bench
Message-ID: <aCxTlds6UuiTR6w3@redhat.com>
References: <20250506141410.100119-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506141410.100119-1-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 06.05.2025 um 16:13 hat gerben@altlinux.org geschrieben:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> This error was discovered by fuzzing qemu-img.
> 
> The current offset calculation leads to an EIO error
> in block/block-backend.c: blk_check_byte_request():
> 
>  if (offset > len || len - offset < bytes) {
>      return -EIO;
>  }
> 
> This triggers the error message:
> "qemu-img: Failed request: Input/output error".
> 
> Example of the issue:
>  offset: 260076
>  len: 260096
>  bytes: 4096
> 
> This fix ensures that offset remains within a valid range.
> 
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>  qemu-img.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 76ac5d3028..e64acfafb3 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4488,10 +4488,10 @@ static void bench_cb(void *opaque, int ret)
>           */
>          b->in_flight++;
>          b->offset += b->step;
> -        if (b->image_size == 0) {
> +        if (b->image_size - b->bufsize <= 0) {

The result of b->image_size - b->bufsize is unsigned, so this doesn't do
what it looks like. I'm replacing it with b->image_size <= b->bufsize.

>              b->offset = 0;
>          } else {
> -            b->offset %= b->image_size;
> +            b->offset %= b->image_size - b->bufsize;
>          }
>          if (b->write) {
>              acb = blk_aio_pwritev(b->blk, offset, b->qiov, 0, bench_cb, b);

Thanks, applied to the block branch.

Kevin


