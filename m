Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A90BC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUYRx-0008RF-Ra; Mon, 29 Jan 2024 15:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rUYRv-0008Qd-FS
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 15:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rUYRt-0003Z7-Mg
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 15:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706560904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/LQnr6Eh8WZucgGA8OEWqrM17c5Ai7vY2GwwmKF2jc=;
 b=Vf/bRHviA3uAIUPYoN1/+A2LKEboPFDkx2MeEk4ILqcr0sZDj4b9/weExHckHDx8EtJzPm
 dTZe/nBTpWb79vW974ocKSS3lB0rAFT/F4zCXPO8axmaL2qBOQvPDZIjJylRtrwtBlKiuD
 zBNmluAxiEKehaudN5BF/I8PQtJ5rjQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-jwqVXJF9Oy-Uq-gn751uxw-1; Mon,
 29 Jan 2024 15:41:41 -0500
X-MC-Unique: jwqVXJF9Oy-Uq-gn751uxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 250E129AA3A2;
 Mon, 29 Jan 2024 20:41:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 048F9492BC7;
 Mon, 29 Jan 2024 20:41:39 +0000 (UTC)
Date: Mon, 29 Jan 2024 14:41:38 -0600
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH [repost]] block/blkio: Don't assume size_t is 64 bit
Message-ID: <6mmso5wfxjoiloufhw7jqdtsckrfri36jvcf2qanvembq2d64p@s32i4maqxmdk>
References: <20240129185427.2952727-1-rjones@redhat.com>
 <20240129185427.2952727-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129185427.2952727-2-rjones@redhat.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 29, 2024 at 06:53:55PM +0000, Richard W.M. Jones wrote:
> With GCC 14 the code failed to compile on i686 (and was wrong for any
> version of GCC):
> 
> ../block/blkio.c: In function ‘blkio_file_open’:
> ../block/blkio.c:857:28: error: passing argument 3 of ‘blkio_get_uint64’ from incompatible pointer type [-Wincompatible-pointer-types]
>   857 |                            &s->mem_region_alignment);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~
>       |                            |
>       |                            size_t * {aka unsigned int *}
> In file included from ../block/blkio.c:12:
> /usr/include/blkio.h:49:67: note: expected ‘uint64_t *’ {aka ‘long long unsigned int *’} but argument is of type ‘size_t *’ {aka ‘unsigned int *’}
>    49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t *value);
>       |                                                         ~~~~~~~~~~^~~~~

I wish gcc could point this out even when compiling on a 64-bit
platform where size_t and uint64_t happen to share the same type, by
reasoning about the underlying typedefs being different.  But that's a
bigger task for gcc, and not one for this group.

> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  block/blkio.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


