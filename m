Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47BEC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WRf-0001MQ-W2; Mon, 28 Apr 2025 17:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9WRd-0001Lq-B3
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9WRa-0006LL-W2
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745877317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6fMAfmEQpsMSLCZcZM07Xs/EBKCTWEySDnOcNXDsic=;
 b=X9gMgTXl28k9ypqVsuRIenFcc3IvP/1/W2kUX0p5ku6rFbzJqaWksT5WCFwAWcbH8jMylC
 2Xu34no5Twb6DgFKImoN/TkTiFovphf3QLfUYZ6e7MaKUBIV/2J+pqQDJrcIWgwlAhNtsH
 Eze8gHEXSrqhcxRsoB4+WpCA1qzDHCM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-rII1Yz8FPty0iMaQG-Apqw-1; Mon,
 28 Apr 2025 17:55:14 -0400
X-MC-Unique: rII1Yz8FPty0iMaQG-Apqw-1
X-Mimecast-MFC-AGG-ID: rII1Yz8FPty0iMaQG-Apqw_1745877313
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CD7A1955DCF; Mon, 28 Apr 2025 21:55:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.31])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2241C180045C; Mon, 28 Apr 2025 21:55:08 +0000 (UTC)
Date: Mon, 28 Apr 2025 16:55:06 -0500
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/2] block/null: Add read-pattern option
Message-ID: <pykbbqg7om2ahqs7h7gfstgvvlbfjc2gx3yobvbego6jrnqo6p@zohvnrrpfwce>
References: <20250427225900.24316-1-nirsof@gmail.com>
 <20250427225900.24316-3-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427225900.24316-3-nirsof@gmail.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 28, 2025 at 01:59:00AM +0300, Nir Soffer wrote:
> When the `read-zeroes` is set, reads produce zeroes, and block status
> return BDRV_BLOCK_ZERO, emulating a sparse image.
> 
> If we don't set `read-zeros` we report BDRV_BLOCK_DATA, but image data
> is undefined; posix_memalign, _aligned_malloc, valloc, or memalign do
> not promise to zero allocated memory.
> 
> When computing a blkhash of an image via qemu-nbd, we want to test 3
> cases:
> 
> 1. Sparse image: skip reading the entire image based on block status
>    result, and use a pre-computed zero block hash.
> 2. Image full of zeroes: read the entire image, detect block full of
>    zeroes and skip block hash computation.
> 3. Image full of data: read the entire image and compute a hash of all
>    blocks.
> 
> This change adds `read-pattern` option. If the option is set, reads
> produce the specified pattern. With this option we can emulate an image
> full of zeroes or full of non-zeroes.
> 
> Specifying both `read-zeroes` and `read-pattern != 0` is not useful
> since `read-zeroes` implies a sparse image.  In this case `read-zeroes`
> wins and we ignore the pattern. Maybe we need to make the options mutual
> exclusive.

I would lean towards an error.  It's easier to remove an error later
if we find it was too strict, than to be lax up front and then regret
it down the road when we wish we had been more strict.

> 
> The following examples shows how the new option can be used with blksum
> (or nbdcopy --blkhash) to compute a blkhash of an image using the
> null-co driver.
> 
> Sparse image - the very fast path:
> 
>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/sparse.sock \
>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-zeroes': true}}" &
> 
>     % time blksum 'nbd+unix:///?socket=/tmp/sparse.sock'
>     300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd+unix:///?socket=/tmp/sparse.sock
>     blksum 'nbd+unix:///?socket=/tmp/sparse.sock'  0.05s user 0.01s system 92% cpu 0.061 total
> 
> Image full of zeros - same hash, 268 times slower:
> 
>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/zero.sock \
>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-pattern': 0}}" &
> 
>     % time blksum 'nbd+unix:///?socket=/tmp/zero.sock'
>     300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd+unix:///?socket=/tmp/zero.sock
>     blksum 'nbd+unix:///?socket=/tmp/zero.sock'  7.45s user 22.57s system 183% cpu 16.347 total
> 
> Image full of data - difference hash, heavy cpu usage:
> 
>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/data.sock \
>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-pattern': -1}}" &
> 
>     % time blksum 'nbd+unix:///?socket=/tmp/data.sock'
>     2c122b3ed28c83ede3c08485659fa9b56ee54ba1751db74d8ba9aa13d9866432  nbd+unix:///?socket=/tmp/data.sock
>     blksum 'nbd+unix:///?socket=/tmp/data.sock'  46.05s user 14.15s system 448% cpu 13.414 total
> 
> Tested on top of
> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html.
> 
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>  block/null.c         | 17 +++++++++++++++++
>  qapi/block-core.json |  9 ++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)

Should block status return ZERO|DATA when read-pattern=0 is present?

> +# @read-pattern: if set, reads from the device produce the specified
> +#     pattern; if unset, the buffer is left unchanged.
> +#     (since: 10.1)
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsNull',
> -  'data': { '*size': 'int', '*latency-ns': 'uint64', '*read-zeroes': 'bool' } }
> +  'data': { '*size': 'int',
> +            '*latency-ns': 'uint64',
> +            '*read-zeroes': 'bool',
> +            '*read-pattern': 'int' } }

Should this be 'uint8' instead of 'int', so that we aren't silently
truncating spurious upper bits when passing it to memset()?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


