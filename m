Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509FAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 22:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7NZ4-0006NA-8y; Wed, 15 May 2024 18:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7NZ2-0006Mm-N9
 for qemu-devel@nongnu.org; Wed, 15 May 2024 18:57:36 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7NZ1-00005d-4v
 for qemu-devel@nongnu.org; Wed, 15 May 2024 18:57:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 52AEB611A6;
 Wed, 15 May 2024 22:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C792FC116B1;
 Wed, 15 May 2024 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715813845;
 bh=q6H/1FcXoCDc0CF9c++iC7IKrb5/UCOhAQ+K55pVPr4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=bMnHNH3r+3s2cl2Jx/b+YpdnHy59iOdDFS6FdkFj2nRt6VIcgK+FqhLiVFv2GtL6D
 fqe1goIHSYBggv0J8+1J9M5pijAIfMmEyz0HLpAfDkzyu9KlQsH6V4q4j4kwk4wju3
 KiWhJ1TJtntJefz35u4ZSTlCsHzX5HXo4TECsAAZGWWCpOzF9qTLs5JMk5Wq3pph/s
 L9gOajbEIuHUco0x++/cxvVBEX5b/vL3ian2i1i0IAO9uLNSkAORwKTPTWSMRVMsoy
 uBrBoNkk3t8wLbIMbr+kbcvfme3LX4psg12rVaUzOKhkOOQQLRKYid2qFp7nOgQkFT
 yTp8BqiznEhkQ==
Date: Wed, 15 May 2024 15:57:22 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 4/8] softmmu: xen: Always pass offset + addr to
 xen_map_cache
In-Reply-To: <20240503014449.1046238-5-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405151557140.2544314@ubuntu-linux-20-04-desktop>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
 <20240503014449.1046238-5-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -79
X-Spam_score: -8.0
X-Spam_bar: --------
X-Spam_report: (-8.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 3 May 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Always pass address with offset to xen_map_cache().
> This is in preparation for support for grant mappings.
> 
> Since this is within a block that checks for offset == 0,
> this has no functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  system/physmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 342b7a8fd4..5e6257ef65 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2230,7 +2230,8 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>           * In that case just map the requested area.
>           */
>          if (block->offset == 0) {
> -            return xen_map_cache(block->mr, addr, len, lock, lock,
> +            return xen_map_cache(block->mr, block->offset + addr,
> +                                 len, lock, lock,
>                                   is_write);
>          }
>  
> -- 
> 2.40.1
> 

