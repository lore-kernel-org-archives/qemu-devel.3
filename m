Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C632D3E78C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ck0-0003bo-Ly; Wed, 06 Nov 2024 04:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8cjz-0003bI-7R
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:54:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8cjw-0007kw-Cq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730886846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0EXNBo7zBth/JfJpiR61LmIIxKEPQf/aLGM/FZKPlI4=;
 b=ZcVpwqXizPTx5Cdie9PBoNpsikPRzjJJLHVOkuGDDuiCrh7rTxyTS3O6sawtsMY4QU4E/L
 UVvpRGsE0W7MhRzgXXwJ4cKbTC9lWe/jIg1vUtvVS4zPdT9fL+DwdSh87Bv6StYn/VGdHx
 3UM9aR8dGpz/PHcesM/AQp8u3P6zlbQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-9YxU5vWQNs2JmdfRg7bwQw-1; Wed,
 06 Nov 2024 04:54:02 -0500
X-MC-Unique: 9YxU5vWQNs2JmdfRg7bwQw-1
X-Mimecast-MFC-AGG-ID: 9YxU5vWQNs2JmdfRg7bwQw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 475871955F42; Wed,  6 Nov 2024 09:54:01 +0000 (UTC)
Received: from redhat.com (dhcp-192-228.str.redhat.com [10.33.192.228])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BDC019560AA; Wed,  6 Nov 2024 09:53:58 +0000 (UTC)
Date: Wed, 6 Nov 2024 10:53:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: stefanha@redhat.com, den@openvz.org, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH] block: fix possible int overflow
Message-ID: <Zys8tLcKjADMtkqn@redhat.com>
References: <20241106080521.219255-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106080521.219255-2-frolov@swemel.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[ Cc: qemu-block ]

Am 06.11.2024 um 09:04 hat Dmitry Frolov geschrieben:
> The sum "cluster_index + count" may overflow uint32_t.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

Thanks, applied to the block branch.

While trying to check if this can be triggered in practice, I found this
line in parallels_fill_used_bitmap():

    s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);

s->used_bmap_size is unsigned long, payload_bytes is the int64_t result
of bdrv_getlength() for the image file, which could certainly be made
more than 4 GB * cluster_size. I think we need an overflow check there,
too.

When allocate_clusters() calculates new_usedsize, it doesn't seem to
consider the overflow case either.

Denis, can you take a look?

Kevin


