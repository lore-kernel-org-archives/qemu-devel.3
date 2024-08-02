Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994E7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZq00-0002Hv-L7; Fri, 02 Aug 2024 06:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZpzy-0002Gb-JD; Fri, 02 Aug 2024 06:59:02 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZpzv-0007Jf-Nh; Fri, 02 Aug 2024 06:59:02 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:25c3:0:640:236:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E388660AB4;
 Fri,  2 Aug 2024 13:58:52 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b725::1:34] (unknown
 [2a02:6b8:b081:b725::1:34])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qwVHAR1VmGk0-omwRdX15; Fri, 02 Aug 2024 13:58:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722596332;
 bh=FsOwMPO25IFC9uKSCzyfkPBT4YVy2Vgr/v4rr9b03TQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VztyMyV/15CXic8y7uH1BdFeOP9i6s9elNoyWonpr3ekXG1ZsFZKB+GJltaYhl0VD
 XUcEaxxdzqzdFYChCC1pDk42V2nuqIQpeVG9SM30DS0cR4+SDXtFNuD+Sj2kEE7r0f
 XS6HXYOt7KaGMVzyqDsklvmCtFoYkUNp22j6ZbIM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9a4ad6af-d222-4d7a-9446-2ea090954731@yandex-team.ru>
Date: Fri, 2 Aug 2024 13:58:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] block: allow commit to unmap zero blocks
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240713215644.742244-1-libvirt-e6954efa@volkihar.be>
 <20240713215644.742244-4-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240713215644.742244-4-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 14.07.24 00:56, Vincent Vanlaer wrote:
> Non-active block commits do not discard blocks only containing zeros,
> causing images to lose sparseness after the commit. This commit fixes
> that by writing zero blocks using blk_co_pwrite_zeroes rather than
> writing them out as any other arbitrary data.
> 
> Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
> ---
>   block/commit.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/block/commit.c b/block/commit.c
> index fb54fc9560..6ce30927ac 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -130,6 +130,7 @@ static void commit_clean(Job *job)
>   
>   typedef enum CommitMethod {
>       COMMIT_METHOD_COPY,
> +    COMMIT_METHOD_ZERO,
>       COMMIT_METHOD_IGNORE,
>   } CommitMethod;
>   
> @@ -185,6 +186,18 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>           if (ret >= 0) {
>               if (!(ret & BDRV_BLOCK_ALLOCATED)) {
>                   commit_method = COMMIT_METHOD_IGNORE;
> +            } else if (ret & BDRV_BLOCK_ZERO) {
> +                int64_t target_offset;
> +                int64_t target_bytes;
> +                WITH_GRAPH_RDLOCK_GUARD() {
> +                    bdrv_round_to_subclusters(s->base_bs, offset, n,
> +                                           &target_offset, &target_bytes);

indentation broken

> +                }
> +
> +                if (target_offset == offset &&
> +                    target_bytes == n) {
> +                    commit_method = COMMIT_METHOD_ZERO;

Why this is needed? Could we blindly do write-zeroes at original (offset, n)? Underlying logic would use any possiblity to write zeroes effectively, and unaligned tails (if any) would be written as data.

> +                }
>               }
>   
>               switch (commit_method) {
> @@ -198,6 +211,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>                       }
>                   }
>                   break;
> +            case COMMIT_METHOD_ZERO:
> +                ret = blk_co_pwrite_zeroes(s->base, offset, n,
> +                    BDRV_REQ_MAY_UNMAP);
> +                error_in_source = false;
> +                break;
>               case COMMIT_METHOD_IGNORE:
>                   break;
>               default:
> @@ -216,6 +234,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>                   continue;
>               }
>           }
> +

extra unrelated hunk for style, I'd drop it

>           /* Publish progress */
>           job_progress_update(&s->common.job, n);
>   

-- 
Best regards,
Vladimir


