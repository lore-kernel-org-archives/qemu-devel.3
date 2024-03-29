Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677DACD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 09:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq8RY-0007cW-JE; Fri, 29 Mar 2024 05:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq8RW-0007bo-TR; Fri, 29 Mar 2024 05:22:34 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq8RT-00079K-2U; Fri, 29 Mar 2024 05:22:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:400c:0:640:9907:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7E4D760B03;
 Fri, 29 Mar 2024 12:22:24 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6509::1:4] (unknown
 [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id NMKa9d26N8c0-f62bqmAL; Fri, 29 Mar 2024 12:22:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711704143;
 bh=yCjTJRVGotQFd3mw9vrR00WYowRNqM1p2TyYALQGWsY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mgI0Ng3DUwTcZUYW46UsRO47AnnxehvygRhGn+OrsZbDfx/mkA6Rqfof/IlbZMeC2
 h4USOyA3ZUABGWTB+To52+avDHbt0Eo5Tpcu8kY6jLTYvrG346ocr91cqc9lrNd6iP
 qIyRviEu5TAhM+BEnUeXXaTDTRbFJMvD9lhmHKSs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3db76890-62e0-48f1-afdc-9d9f13b74a68@yandex-team.ru>
Date: Fri, 29 Mar 2024 12:22:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] blockcommit: Reopen base image as RO after abort
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com
References: <20240328091615.335620-1-alexander.ivanov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240328091615.335620-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 28.03.24 12:16, Alexander Ivanov wrote:
> If a blockcommit is aborted the base image remains in RW mode, that leads
> to a fail of subsequent live migration.
> 
> How to reproduce:
>    $ virsh snapshot-create-as vm snp1 --disk-only
> 
>    *** write something to the disk inside the guest ***
> 
>    $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
>    $ lsof /vzt/vm.qcow2
>    COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
>    qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
>    $ cat /proc/433203/fdinfo/45
>    pos:    0
>    flags:  02140002 <==== The last 2 means RW mode
> 
> If the base image is in RW mode at the end of blockcommit and was in RO
> mode before blockcommit, reopen the base BDS in RO.
> 
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/mirror.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 1bdce3b657..d23be57255 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
>       int64_t active_write_bytes_in_flight;
>       bool prepared;
>       bool in_drain;
> +    bool base_ro;
>   } MirrorBlockJob;
>   
>   typedef struct MirrorBDSOpaque {
> @@ -797,6 +798,10 @@ static int mirror_exit_common(Job *job)
>       bdrv_drained_end(target_bs);
>       bdrv_unref(target_bs);
>   
> +    if (abort && s->base_ro && !bdrv_is_read_only(target_bs)) {
> +        bdrv_reopen_set_read_only(target_bs, true, NULL);
> +    }
> +

All looks good to me except this: seems it is safer to place this "if" block before "bdrv_drained_end(); bdrv_unref();" above. With it moved:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

>       bs_opaque->job = NULL;
>   
>       bdrv_drained_end(src);
> @@ -1717,6 +1722,7 @@ static BlockJob *mirror_start_job(
>                                bool is_none_mode, BlockDriverState *base,
>                                bool auto_complete, const char *filter_node_name,
>                                bool is_mirror, MirrorCopyMode copy_mode,
> +                             bool base_ro,
>                                Error **errp)
>   {
>       MirrorBlockJob *s;
> @@ -1800,6 +1806,7 @@ static BlockJob *mirror_start_job(
>       bdrv_unref(mirror_top_bs);
>   
>       s->mirror_top_bs = mirror_top_bs;
> +    s->base_ro = base_ro;
>   
>       /* No resize for the target either; while the mirror is still running, a
>        * consistent read isn't necessarily possible. We could possibly allow
> @@ -2029,7 +2036,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>                        speed, granularity, buf_size, backing_mode, zero_target,
>                        on_source_error, on_target_error, unmap, NULL, NULL,
>                        &mirror_job_driver, is_none_mode, base, false,
> -                     filter_node_name, true, copy_mode, errp);
> +                     filter_node_name, true, copy_mode, false, errp);
>   }
>   
>   BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
> @@ -2058,7 +2065,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>                        on_error, on_error, true, cb, opaque,
>                        &commit_active_job_driver, false, base, auto_complete,
>                        filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
> -                     errp);
> +                     base_read_only, errp);
>       if (!job) {
>           goto error_restore_flags;
>       }

-- 
Best regards,
Vladimir


