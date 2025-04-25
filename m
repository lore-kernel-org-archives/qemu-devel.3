Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62736C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LYY-0004JI-25; Fri, 25 Apr 2025 12:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8LY8-0003j5-WB
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8LY7-0000Zk-84
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745597109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BDgJuEhoLasWgrs5kzO98YRFZNh8CcndMBORynV+bo0=;
 b=AajrUiI1vb+UocFrH8YZkQiuWs2RhvJjHaSVg7y7DgqebdhDft/JeBJwdLrQh2O11FiXQt
 sc1v7qyiX9bVJjBjwnrzrczF182+KBJTY9sR9mzwIA3175QI2Pp1dcmh/jaZfAAbF3pYsK
 dksV1C4XX6H+DYhlqdRT9n52dpt1kgA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-gSp2tzVUPre4kUzb3wuGUg-1; Fri,
 25 Apr 2025 12:05:05 -0400
X-MC-Unique: gSp2tzVUPre4kUzb3wuGUg-1
X-Mimecast-MFC-AGG-ID: gSp2tzVUPre4kUzb3wuGUg_1745597105
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EEA51800875; Fri, 25 Apr 2025 16:05:04 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20EBB19560A3; Fri, 25 Apr 2025 16:05:01 +0000 (UTC)
Date: Fri, 25 Apr 2025 18:04:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH 2/4] qemu-img: fix offset calculation in bench
Message-ID: <aAuyq89aWJEl9Heg@redhat.com>
References: <20250327162423.25154-1-gerben@altlinux.org>
 <20250327162423.25154-3-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327162423.25154-3-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 27.03.2025 um 17:24 hat gerben@altlinux.org geschrieben:
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
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 2044c22a4c..71c9fe496f 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4491,7 +4491,7 @@ static void bench_cb(void *opaque, int ret)
>          if (b->image_size == 0) {
>              b->offset = 0;
>          } else {
> -            b->offset %= b->image_size;
> +            b->offset %= b->image_size - b->bufsize;

The approach makes sense in principle, but you just introduced a new
division by zero here if image_size == bufsize (in this case we want to
use 0 as the new offset).

We probably also don't want to allow this to become negative.

Kevin


