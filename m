Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56BAC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23TU-0007wA-QC; Tue, 08 Apr 2025 03:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u23TN-0007vL-0o; Tue, 08 Apr 2025 03:34:17 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u23TK-0003FE-Oo; Tue, 08 Apr 2025 03:34:16 -0400
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 07E501520E64;
 Tue,  8 Apr 2025 09:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1744097648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4Kvw86qEHQ6uK9Ne9g5zyrmi9iSGD84QvKZmyUvXYo=;
 b=Wj/D5/Uwxcag10qmbbd5e71A4LIDS2UCzGWqOnXRhAHwx+9Cl1TSg9uozIxB3RIQyj+kUe
 1DDNj5KBs1lo/4uCEFtswCEalGIZvXIw7XT5TpT19UUNQvzWrv8p2QQPEDylT8wV7JkH+e
 n6OtdhRycfaPzJyf+QqZ5S3E6hQQaIAHIO3xfVSUf3EKB4BbbnfSrKM7V+bVywRrcOzTYr
 9BwwUK/gxt0gRRZBqE7tbyviTJLLsXvhpN26QehbjKLmsxfZ5wo2rZGIeO5ibhZgCrT5UC
 583stMgAqDAM5jcezrEgMEediGWdF+AtarOanfTTcmPKTXRSIyrkrOdl6Sz1bQ==
Message-ID: <263b1048-37bf-4149-a2ff-8f7fe59795b5@dupond.be>
Date: Tue, 8 Apr 2025 09:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] qcow2: put discard requests in the common queue
 when discard-no-unref enabled
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com, den@virtuozzo.com
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
 <20240913163942.423050-4-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20240913163942.423050-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

I hope this patchset can get merged soon, as it contains some good 
improvements.

Next to that, the change below only improves the performance on 
discards? It's not that something is broken/can cause issues in the 
current code?
Otherwise it might be a good idea to have this one merged as soon as 
possible.

Thanks for the work on this!

Jean-Louis

On 9/13/24 18:39, Andrey Drobyshev wrote:
> Normally discard requests are stored in the queue attached to BDRVQcow2State
> to be processed later at once.  Currently discard-no-unref option handling
> causes these requests to be processed straight away.  Let's fix that.
>
> Note that when doing regular discards qcow2_free_any_cluster() would check
> for the presence of external data files for us and redirect request to
> underlying data_file.  Here we want to do the same but avoid refcount updates,
> thus we perform the same checks.
>
> Suggested-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 5f057ba2fd..7dff0bd5a1 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1893,6 +1893,28 @@ again:
>       return 0;
>   }
>   
> +/*
> + * Helper for adding a discard request to the queue without any refcount
> + * modifications.  If external data file is used redirects the request to
> + * the corresponding BdrvChild.
> + */
> +static inline void
> +discard_no_unref_any_file(BlockDriverState *bs, uint64_t offset,
> +                          uint64_t length, QCow2ClusterType ctype,
> +                          enum qcow2_discard_type dtype)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +
> +    if (s->discard_passthrough[dtype] &&
> +        (ctype == QCOW2_CLUSTER_NORMAL || ctype == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +        if (has_data_file(bs)) {
> +            bdrv_pdiscard(s->data_file, offset, length);
> +        } else {
> +            qcow2_queue_discard(bs, offset, length);
> +        }
> +    }
> +}
> +
>   /*
>    * This discards as many clusters of nb_clusters as possible at once (i.e.
>    * all clusters in the same L2 slice) and returns the number of discarded
> @@ -1974,12 +1996,10 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>           if (!keep_reference) {
>               /* Then decrease the refcount */
>               qcow2_free_any_cluster(bs, old_l2_entry, type);
> -        } else if (s->discard_passthrough[type] &&
> -                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
> -                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +        } else {
>               /* If we keep the reference, pass on the discard still */
> -            bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
> -                          s->cluster_size);
> +            discard_no_unref_any_file(bs, old_l2_entry & L2E_OFFSET_MASK,
> +                                      s->cluster_size, cluster_type, type);
>           }
>       }
>   
> @@ -2088,12 +2108,11 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>               if (!keep_reference) {
>                   /* Then decrease the refcount */
>                   qcow2_free_any_cluster(bs, old_l2_entry, QCOW2_DISCARD_REQUEST);
> -            } else if (s->discard_passthrough[QCOW2_DISCARD_REQUEST] &&
> -                       (type == QCOW2_CLUSTER_NORMAL ||
> -                        type == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +            } else {
>                   /* If we keep the reference, pass on the discard still */
> -                bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
> -                            s->cluster_size);
> +                discard_no_unref_any_file(bs, old_l2_entry & L2E_OFFSET_MASK,
> +                                          s->cluster_size, type,
> +                                          QCOW2_DISCARD_REQUEST);
>               }
>           }
>       }

