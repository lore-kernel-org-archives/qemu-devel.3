Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B38606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dupond.be header.i=@dupond.be header.a=rsa-sha256 header.s=dkim header.b=g0SGcF9o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRat-0007SZ-3o; Thu, 29 Oct 2026 10:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1xMRaX-0007MP-Ny; Thu, 29 Oct 2026 10:58:50 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1xMRaV-00016P-WA; Thu, 29 Oct 2026 10:58:45 -0400
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id F3FD61520D01;
 Thu, 29 Oct 2026 15:58:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1793285922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDcf2A0g2G+s7KORsLrDiWDwV/0tHie2d+2gxpMUPto=;
 b=g0SGcF9orqD1jlYJfoNTCOD9ChkxzqpSvNeY3p3aTGaPAPjvPlUZjJVZK7JPVTX3Dgc7gq
 /98t1BKTxXM62JuAgmFWgb/+6y13CtqSzAk0oOm1H28bgrK5jfvVJ9twzZ3YzCivoAtIWe
 JExfwwxEIwdNpmzYd37IPCMw1Iv/sLZbsJ4YHN1xoOSImwqLXbbq6c/98WdaDw0b076ikw
 /nW9epM5rl+Mey6IbXbTznPOznyR4BlyVAaBLwRdLaLO+7GicSgKAAziaNKHFWSCph2e8i
 IrHL2c1EUyiMUkN0PjFXUgEQZRekyob2AB7pAkcfEJUYjJWkM9/6JhNgYn6bAg==
Message-ID: <713e8c49-5a9c-4d42-9038-8b6f9cc70260@dupond.be>
Date: Thu, 29 Oct 2026 15:58:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] qcow2: fix snapshot data corruption with
 discard-no-unref=on
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, den@openvz.org
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
 <20261027104441.830212-3-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20261027104441.830212-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 27/10/2026 11:44, Andrey Drobyshev wrote:
> Whenever option discard-no-unref=on is enabled, we bypass refcount
> machinery and unconditionally punch hole in the data on 'discard' and
> 'write -z -u' paths.  However, when this same cluster is also referenced
> by an internal snapshot, such operations lead to problems.  The active L2
> table is copied before it is changed, so the snapshot metadata stays
> correct, but the host range under it is punched out and the snapshot reads
> zeroes there afterwards. qemu-img check finds nothing wrong.
>
> Fix this by guarding the 'keep_reference' flag by the presence of the
> QCOW_OFLAG_COPIED bit.  I.e. only proceed with unconditional data
> punching if we own this cluster exclusively.
>
> Fixes: 42a2890a76f4 ("qcow2: add discard-no-unref option")
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index e02fae6a0c6..cc473c7c796 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1953,6 +1953,7 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>           QCow2ClusterType cluster_type =
>               qcow2_get_cluster_type(bs, old_l2_entry);
>           bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
> +                              (old_l2_entry & QCOW_OFLAG_COPIED) &&
>                                 !full_discard &&
>                                 (s->discard_no_unref &&
>                                  type == QCOW2_DISCARD_REQUEST);
Wouldn't it be better to gate only qcow2_discard_cluster when the 
cluster is QCOW_OFLAG_COPIED?
Cause with the above change, we fully clear/remove the offset of the 
cluster, causing fragmentation again in the image afterwards.
And that was just the goal for discard-no-unref :)
> @@ -2097,8 +2098,9 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>           QCow2ClusterType type = qcow2_get_cluster_type(bs, old_l2_entry);
>           bool unmap = (type == QCOW2_CLUSTER_COMPRESSED) ||
>               ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
> -        bool keep_reference =
> -            (s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED);
> +        bool keep_reference = s->discard_no_unref &&
> +                              type != QCOW2_CLUSTER_COMPRESSED &&
> +                              (old_l2_entry & QCOW_OFLAG_COPIED);
>           uint64_t new_l2_entry = old_l2_entry;
>           uint64_t new_l2_bitmap = old_l2_bitmap;
>   

And same here then.

Thanks
Jean-Louis

