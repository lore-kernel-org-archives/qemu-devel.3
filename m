Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FB5C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEoMb-000641-VS; Wed, 05 Jun 2024 06:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1sEoMZ-00063Y-Le
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:59:27 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1sEoMW-0003Sr-JC
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:59:27 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:ba43:94d2:9111:d35b] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ba43:94d2:9111:d35b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 51C2E1520BCB;
 Wed,  5 Jun 2024 12:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1717585160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKeORz0EYIBY6KpLGS2xZcCEQ6vNjnvFwARUor5ysoA=;
 b=GEDs/ARFjx9Cgc4avEJD7B6G3f56+99x4Nhz3NNp3aNQjYN2X5X1U2E9A3sO1Aa0q3vYLO
 OKSEotFzDMDuzfr4o8HmcU7D4w1HF+EeVhoeVWvqACCe4vBfk2Gk2L7efXQ2EJskqIHP0u
 zs4VH+M86+dCQYywRimYLscKzuWgtBVBrYdlH61ZOOkrG9RdC23aEMC91s9Mg+ujIEwgMf
 lBjWUaML3CiIxdfL1/XvVuxmTvpRqUCrZeAQqaf+JwqrLZdsm79Gc+LQs3vw0Nw5R1gBdh
 UY1nqGDtFaS44Yc7cdlKjahl6p9jSnQsvdkYgkRySFCLQLqOamdyHgBhVQqNtA==
Message-ID: <5b49cbb9-9b28-4a0d-b897-77492392333d@dupond.be>
Date: Wed, 5 Jun 2024 12:59:19 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 1/2] qcow2: handle discard-no-unref in measure
Content-Language: en-US
To: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com
References: <20240605090639.3402698-2-jean-louis@dupond.be>
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20240605090639.3402698-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/06/2024 11:06, Jean-Louis Dupond wrote:
> When doing a measure on an image with a backing file and
> discard-no-unref is enabled, the code should take this into account.
>
> If for example you have a snapshot image with a base, and you do a
> discard within the snapshot, it will be ZERO and ALLOCATED, but without
> host offset.
> Now if we commit this snapshot, and the clusters in the base image were
> allocated, the clusters will only be set to ZERO, but the host offset
> will not be cleared.
> Therefor ZERO & ALLOCATED clusters in the top image need to check the
> base to see if space will be freed or not, to have a correct measure
> output.
>
> Bug-Url: https://gitlab.com/qemu-project/qemu/-/issues/2369
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2.c | 36 +++++++++++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 956128b409..1ce7ebbab4 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5163,9 +5163,16 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>           } else {
>               int64_t offset;
>               int64_t pnum = 0;
> +            BlockDriverState *parent = bdrv_filter_or_cow_bs(in_bs);
> +            BDRVQcow2State *s = NULL;
> +
> +            if (parent) {
> +                s = parent->opaque;
> +            }
>   
>               for (offset = 0; offset < ssize; offset += pnum) {
>                   int ret;
> +                int retp = 0;
>   
>                   ret = bdrv_block_status_above(in_bs, NULL, offset,
>                                                 ssize - offset, &pnum, NULL,
> @@ -5176,10 +5183,33 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>                       goto err;
>                   }
>   
> -                if (ret & BDRV_BLOCK_ZERO) {
> +                /* If we have a parent in the chain and the current block is zero but allocated,
> +                 * then we want to check the allocation state of the parent block.
> +                 * If it was allocated and now zero, we want
> +                 * to include it into the calculation, cause it will not free space when
> +                 * committing the top into base with discard-no-unref enabled.
> +                 */
> +                if (parent &&
> +                    ((ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED)) ==
> +                     (BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED)) &&
> +                     s->discard_no_unref) {
> +                        int64_t pnum_parent = 0;
> +                        retp = bdrv_block_status_above(parent, NULL, offset,
> +                                              ssize - offset, &pnum_parent, NULL,
> +                                              NULL);
> +                        // Check if parent block has an offset
> +                        if (retp & BDRV_BLOCK_OFFSET_VALID) {
> +                            pnum = retp;
This should be `pnum = pnum_parent` of course :)
> +                        }
> +                }
> +                if (ret & BDRV_BLOCK_ZERO && !retp) {
>                       /* Skip zero regions (safe with no backing file) */
> -                } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
> -                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
> +                } else if (((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
> +                            (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ||
> +                           (((ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED)) ==
> +                             (BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED)) &&
> +                            s && s->discard_no_unref &&
> +                            retp & BDRV_BLOCK_OFFSET_VALID)) {
>                       /* Extend pnum to end of cluster for next iteration */
>                       pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
>   


This seems to work fine in my tests with the following commands:
  ./build/qemu-img create -f qcow2 /tmp/test.qcow2 128M
  ./build/qemu-io -c 'open /tmp/test.qcow2' -c 'write 0 8M' -c 'write 
56M 20M' -c 'write 10M 8M' -c 'write 24M 32M'
  ./build/qemu-img create -f qcow2 -b /tmp/test.qcow2 -F qcow2 
/tmp/test_snap.qcow2
  ./build/qemu-io -c 'open -o discard=unmap,discard-no-unref=on 
/tmp/test_snap.qcow2' -c 'write 16M 8M' -c 'discard 60M 20M' -c 'write 
84M 10M'
  ./build/qemu-img measure --output json -O qcow2 'json:{"file": 
{"driver": "file", "filename": "/tmp/test_snap.qcow2"}, "driver": 
"qcow2", "backing": {"driver": "qcow2", "file": {"driver": "file", 
"filename": "/tmp/test.qcow2"}, "backing": null}}'
  ./build/qemu-img measure --output json -O qcow2 'json:{"file": 
{"driver": "file", "filename": "/tmp/test_snap.qcow2"}, "driver": 
"qcow2", "discard":"unmap", "discard-no-unref":true, "backing": 
{"driver": "qcow2", "discard-no-unref":true, "file": {"driver": "file", 
"filename": "/tmp/test.qcow2"}, "backing": null}}'


But it does not seem to work when the base image has ZERO ALLOCATED 
clusters that overlap with the ZERO ALLOCATED clusters in the snapshot.
As its then seen as a single zero cluster by the bdrv_block_status_above 
function.
This happens for example when the base vm was initially running without 
discard-no-unref and enabled it only later.

Any idea's on how to handle that ?

Thanks
Jean-Louis



