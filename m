Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032B9C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WMn-0005oK-HA; Mon, 28 Apr 2025 17:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9WMg-0005eG-GW
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9WMb-0005X8-7r
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745877007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2AT+ENOgOobGVn2MOPH3i3oCAHAxTUg9D4LxX0DC/aI=;
 b=ZK1nKL2xER4hxMihw7ia7YtEe2Nc3v4FhX83iFvlBzCatZ0L39H+3FO0G63tGSjWXuYekB
 ThW6+oyHVtHj3vWDiwnRK+taNJeUQeyrio4GvATvwpEJ5h5FPo3zMUPkFj5avsso76Pwmg
 ohde3cKESr3+cC22lq3GNXgXfhz5PqY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-XwmRfYDQMnumLqwjnuRbZA-1; Mon,
 28 Apr 2025 17:50:01 -0400
X-MC-Unique: XwmRfYDQMnumLqwjnuRbZA-1
X-Mimecast-MFC-AGG-ID: XwmRfYDQMnumLqwjnuRbZA_1745877000
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1236F18001CA; Mon, 28 Apr 2025 21:50:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.31])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC6371956094; Mon, 28 Apr 2025 21:49:57 +0000 (UTC)
Date: Mon, 28 Apr 2025 16:49:55 -0500
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/2] block/null: Report DATA if not reading zeroes
Message-ID: <vwlluemb5ekotdzldygunjiztexa77263acgmimmeadwlkruit@rj2u6ydjs7zk>
References: <20250427225900.24316-1-nirsof@gmail.com>
 <20250427225900.24316-2-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427225900.24316-2-nirsof@gmail.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Mon, Apr 28, 2025 at 01:58:59AM +0300, Nir Soffer wrote:
> If read-zeroes is not set, we did not report BDRV_BLOCK_DATA or
> BDRV_BLOCK_ZERO. This is not consistent with other drivers and can
> confuse users or other programs:
> 
>     % qemu-img map --output json "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}"
>     [{ "start": 0, "length": 1073741824, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]
> 
>     % qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}" &
> 
>     % nbdinfo --map nbd://127.0.0.1
>              0  1073741824    1  hole
> 
> With this change we report DATA in this case:
> 
>     % ./qemu-img map --output json "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}"
>     [{ "start": 0, "length": 1073741824, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0}]

Do we really want to represent the region as present?  I think we're
okay (we guarantee that reads from the region will return sensible
contents), and your next patch to allow control over what data is seen
makes it even better.


> 
>     % ./qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}" &
> 
>     % nbdinfo --map nbd://127.0.0.1
>              0  1073741824    0  data
> 
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>  block/null.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/null.c b/block/null.c
> index dc0b1fdbd9..7ba87bd9a9 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -239,9 +239,7 @@ static int coroutine_fn null_co_block_status(BlockDriverState *bs,
>      *map = offset;
>      *file = bs;
>  
> -    if (s->read_zeroes) {
> -        ret |= BDRV_BLOCK_ZERO;
> -    }
> +    ret |= s->read_zeroes ? BDRV_BLOCK_ZERO : BDRV_BLOCK_DATA;
>      return ret;

According to include/block/block-common.h,

 * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
 * BDRV_BLOCK_ZERO: offset reads as zero
 * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing raw data

Or read differently, BDRV_BLOCK_DATA says an area is not sparse.  This
patch is changing the null driver to report the entire image as either
sparse and zero, or not sparse and not zero.

For testing purposes, I think that is reasonable enough; it matches
that file-posix.c always returns one or the other, when using only
lseek() to probe things.  NBD has a bit finer-grained control (it has
two bits, one for sparseness which is effectively !BDRV_BLOCK_DATA,
and one for zero; where you can have something that is sparse but does
not read as zero, such as SCSI that lacks coherent uninitialized
read).  In fact, you could even have DATA|ZERO if we know something is
allocated AND that it reads as zero (which will be the case in your
next patch if the user explicitly asks for a read pattern of 0).

But for all of that thinking, in the end your patch makes sense to me.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


