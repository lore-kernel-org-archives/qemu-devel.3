Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EA4C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPqy-0008EF-6p; Tue, 20 May 2025 12:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHPqv-0008B7-O7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHPqu-0002kL-21
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747758603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pnZ8FRp1+0E6UQT8TRYrzenTjD06EfK4pK0ZOJ79scY=;
 b=MH/JdGMl8z6iBI55hbSszyZyNjW55dQ1cGV5Xn4tSj4BwpQ8+aBfBfMDOVt4oOicZ+WjT1
 pvhtiO3IX3SkFzKZ1IbqP3VaMoN6hKsixKJ/0g4s32o+pNyvZYPbGSjYvzOsM6r2qBQoyh
 T0EZK2nRZvk1fEYPf+8eIyUzZuOFuDc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-OdU5MTYKPx-ms79reRwBwA-1; Tue,
 20 May 2025 12:29:59 -0400
X-MC-Unique: OdU5MTYKPx-ms79reRwBwA-1
X-Mimecast-MFC-AGG-ID: OdU5MTYKPx-ms79reRwBwA_1747758598
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26A2519560B1; Tue, 20 May 2025 16:29:58 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D16930001AA; Tue, 20 May 2025 16:29:55 +0000 (UTC)
Date: Tue, 20 May 2025 11:29:52 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org, 
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: Re: [PATCH 2/4] hbitmap: introduce hbitmap_reverse()
Message-ID: <x6elam26xqiepon2bvrhpejczvia6ksqn4xviov5vhh7e7vfrc@yucgtxyeabe7>
References: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
 <20250513013238.1213539-3-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513013238.1213539-3-andrey.zhadchenko@virtuozzo.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On Tue, May 13, 2025 at 03:32:36AM +0200, Andrey Zhadchenko wrote:
> and bdrv_dirty_bitmap_reverse() helper

Is 'inverse' a better name than 'reverse'?

> 
> Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
> ---
> +++ b/util/hbitmap.c
> @@ -940,3 +940,18 @@ char *hbitmap_sha256(const HBitmap *bitmap, Error **errp)
>  
>      return hash;
>  }
> +
> +void hbitmap_reverse(HBitmap *bitmap)
> +{
> +    int64_t pnum, pos = 0;
> +    int64_t size = bitmap->orig_size;
> +
> +    while (pos < size) {
> +        if (hbitmap_status(bitmap, pos, size - pos, &pnum)) {
> +            hbitmap_reset(bitmap, pos, pnum);
> +        } else {
> +            hbitmap_set(bitmap, pos, pnum);
> +        }

To me, reverse on 1110000 would be 0000111 (swapping the order); while
inverse would be 0001111 (swapping the bits but preserving the order).

The naming change will require respinning the series, but the concept
makes sense.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


