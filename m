Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB18C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFeTl-0006gS-GF; Thu, 15 May 2025 15:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFeTk-0006g9-GA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFeTf-0000cd-2i
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747338165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KfSHwIqfbaVabF4PEECBv1yEfTbEsIDvennn8j8rTMc=;
 b=a4tFG4fn0ROYsHe/6rUjzEFpVh+GcpTPjETITfbE6GocSUpJBHbqE4UUHeO902/44BA5Pr
 Cldpp2j8pdmXolSwxn9DcbegnSHvx/IS1Wau+JMdC8bObAra2yUMaj3SnQKNPHwLUWKwN+
 hmdY50w+t9O0ebxmTZppXvNrLNEMCxQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-2oO1-_UVOFOobgMV9YK1fg-1; Thu,
 15 May 2025 15:42:40 -0400
X-MC-Unique: 2oO1-_UVOFOobgMV9YK1fg-1
X-Mimecast-MFC-AGG-ID: 2oO1-_UVOFOobgMV9YK1fg_1747338158
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B073180035C; Thu, 15 May 2025 19:42:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.66])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A9D018008F4; Thu, 15 May 2025 19:42:35 +0000 (UTC)
Date: Thu, 15 May 2025 14:42:32 -0500
From: Eric Blake <eblake@redhat.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/2] qcow2: rename update_refcount_discard to
 queue_discard
Message-ID: <jldw5cuojss2n65srtnqqpyp6f4xmm245nwb66blrjwnk4ak7n@ud6ejyrliat2>
References: <20250513132628.1055549-1-jean-louis@dupond.be>
 <20250513132628.1055549-2-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513132628.1055549-2-jean-louis@dupond.be>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Tue, May 13, 2025 at 03:26:27PM +0200, Jean-Louis Dupond wrote:
> The function just queues discards, and doesn't do any refcount change.
> So let's change the function name to align with its function.
> 
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

>  block/qcow2-refcount.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 0266542cee..8fb210501c 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -754,8 +754,8 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
>      }
>  }
>  
> -static void update_refcount_discard(BlockDriverState *bs,
> -                                    uint64_t offset, uint64_t length)
> +static void queue_discard(BlockDriverState *bs,
> +                          uint64_t offset, uint64_t length)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      Qcow2DiscardRegion *d, *p, *next;
> @@ -902,7 +902,7 @@ update_refcount(BlockDriverState *bs, int64_t offset, int64_t length,
>              }
>  
>              if (s->discard_passthrough[type]) {
> -                update_refcount_discard(bs, cluster_offset, s->cluster_size);
> +                queue_discard(bs, cluster_offset, s->cluster_size);
>              }
>          }
>      }
> @@ -3619,7 +3619,7 @@ qcow2_discard_refcount_block(BlockDriverState *bs, uint64_t discard_block_offs)
>          /* discard refblock from the cache if refblock is cached */
>          qcow2_cache_discard(s->refcount_block_cache, refblock);
>      }
> -    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
> +    queue_discard(bs, discard_block_offs, s->cluster_size);
>  
>      return 0;
>  }
> -- 
> 2.49.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


