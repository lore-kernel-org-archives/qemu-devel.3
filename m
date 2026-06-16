Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D34CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 23:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZdey-0001PA-NH; Tue, 16 Jun 2026 19:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wZdew-0001Oh-4j; Tue, 16 Jun 2026 19:57:34 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wZdek-0007bM-OG; Tue, 16 Jun 2026 19:57:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A6E642A43;
 Tue, 16 Jun 2026 23:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EA81F000E9;
 Tue, 16 Jun 2026 23:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781654239;
 bh=jWgKPaV0rvCJKCrhHIN9A65kMwl3h11A5BbIhCJmoFI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=G+P0bEqpOswukaP+jfjTz9jKaYDQNpylU1c2zExplrhlDn7ZYl2+3e4RKmeF54Elg
 EhjdMZpDXXZD+Y4OdSGsv8NGRVsNDJE5v8mwvWtvjClq9XwFL7peJGGRUi8+XrZDgR
 eERKPTo5LjL41zVmqA7Kn6yEkUPFPISMChb0Zn5CwCNP/C1b6RA9RbuDJiX7CqW9Jb
 d8FFp3ozQZoOSbuauQ9vbgmEOh3EHJq+fY8zynKHfn2bVys+XdtQoNUohh13jQGSwr
 cueuInZEHsXPEfUEyjLBbtI1lB03AGkjvGjZS9gHjUQFSF3D1wU+kQs9Ww+dpKBpIs
 QtjQyjiwG0PGQ==
Message-ID: <43970566-c820-47b2-a68a-c9c6e7c69a13@kernel.org>
Date: Wed, 17 Jun 2026 08:57:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] file-posix: fix cache.direct=on check for zoned block
 devices
To: Niklas Cassel <cassel@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20260616124535.1818951-1-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260616124535.1818951-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=dlemoal@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/16/26 9:45 PM, Niklas Cassel wrote:
> For zoned block devices with SWR zones, the order of the writes must be
> maintained to avoid write not at write pointer errors.
> Thus, cache.direct=on must be used to bypass the page cache, since the
> page cache uses write-back caching, where the physical order of the writes
> is not guaranteed.
> 
> There is already a check for cache.direct=on in raw_open_common(),
> however, this check is done before raw_refresh_zoned_limits() has been
> called (which initializes bs->bl.zoned), so it is currently dead code.
> 
> Fix this by moving the check to raw_refresh_zoned_limits(), such that the
> check is done after bs->bl.zoned has been initialized.
> 
> Fixes: 774c726ceb2a ("block: add zoned BlockDriver check to block layer")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 5019ddade9..2cdae2d40c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -800,18 +800,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>              goto fail;
>          }
>      }
> -#ifdef CONFIG_BLKZONED
> -    /*
> -     * The kernel page cache does not reliably work for writes to SWR zones
> -     * of zoned block device because it can not guarantee the order of writes.
> -     */
> -    if ((bs->bl.zoned != BLK_Z_NONE) &&
> -        (!(s->open_flags & O_DIRECT))) {
> -        error_setg(errp, "The driver supports zoned devices, and it requires "
> -                         "cache.direct=on, which was not specified.");
> -        return -EINVAL; /* No host kernel page cache */
> -    }
> -#endif
>  
>  #ifdef __FreeBSD__
>      if (S_ISCHR(st.st_mode)) {
> @@ -1462,6 +1450,16 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
>      }
>      bs->bl.zoned = zoned;
>  
> +    /*
> +     * The kernel page cache does not reliably work for writes to SWR zones
> +     * of zoned block device because it can not guarantee the order of writes.

s/device/devices

Apart from that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +     */
> +    if (!(s->open_flags & O_DIRECT)) {
> +        error_setg(errp, "The driver supports zoned devices, and it requires "
> +                         "cache.direct=on, which was not specified.");
> +        goto no_zoned;
> +    }
> +
>      ret = get_sysfs_long_val(st, "max_open_zones");
>      if (ret >= 0) {
>          bs->bl.max_open_zones = ret;


-- 
Damien Le Moal
Western Digital Research

