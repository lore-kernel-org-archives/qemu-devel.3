Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CC1E9B269
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vut43-00062M-1m; Tue, 24 Feb 2026 09:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vut40-00061E-Hk; Tue, 24 Feb 2026 09:07:00 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vut3x-0004Kp-Sj; Tue, 24 Feb 2026 09:07:00 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0F92B480FD;
 Tue, 24 Feb 2026 15:06:44 +0100 (CET)
Message-ID: <a5b6ecb1-f973-4bc3-9a1c-a7b8e2cbfe16@proxmox.com>
Date: Tue, 24 Feb 2026 15:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mirror: Fix missed dirty bitmap writes during startup
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, jean-louis@dupond.be, dionbosschieter@gmail.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260219202446.312493-1-kwolf@redhat.com>
 <46ff60a0-56c7-49f0-ae8f-6a26504409b9@proxmox.com>
 <aZ2ubi7GsYmGmcl2@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aZ2ubi7GsYmGmcl2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1771941987966
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 24.02.26 um 2:58 PM schrieb Kevin Wolf:
> Am 20.02.2026 um 15:00 hat Fiona Ebner geschrieben:
>> Am 19.02.26 um 9:25 PM schrieb Kevin Wolf:
>>> @@ -1672,9 +1673,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
>>>          abort();
>>>      }
>>>  
>>> -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
>>> +    if (!copy_to_target) {
>>>          qatomic_set(&s->job->actively_synced, false);
>>
>> Here, we must check that s->job is set for the qatomic_set().
>>
>> Other than that, the patch looks good to me, thanks!
> 
> Thanks, good catch. I'm squashing in this change:
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index abdffc6de86..fa1d975eb9f 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1677,7 +1677,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
>      }
> 
>      if (!copy_to_target) {
> -        qatomic_set(&s->job->actively_synced, false);
> +        if (s->job) {
> +            qatomic_set(&s->job->actively_synced, false);
> +        }
>          bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, bytes);
>      }
> 
> Can I add your R-b with this?

Yes!

> Jean-Louis, do you want to give this patch a test if it still fixes your
> problem? The approach is a bit different from what we tried initially.
> 
> Kevin
> 
> 



