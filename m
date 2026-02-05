Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18815E91290
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnvDb-0007XP-Hd; Thu, 05 Feb 2026 04:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vnvDZ-0007W3-Ss
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:00:05 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vnvDX-00049n-MV
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:00:05 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8FF6947AE6;
 Thu, 05 Feb 2026 09:59:52 +0100 (CET)
Message-ID: <aef520c2-3296-4eb4-999c-faa757c9b2a3@proxmox.com>
Date: Thu, 5 Feb 2026 09:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (in guest) disk corruption during snapshots
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
Cc: dionbosschieter@gmail.com
References: <4853b0e5-8ec3-41e9-9a53-b1912b8e4449@dupond.be>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <4853b0e5-8ec3-41e9-9a53-b1912b8e4449@dupond.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1770281914365
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

Am 03.02.26 um 3:24 PM schrieb Jean-Louis Dupond:
> Hi,
> 
> Since some months we were observing disk corruption within the VM when
> enabling backups (which triggers snapshots).
> After a lot of troubleshooting, we were able to track down the commit
> that caused it:
> https://gitlab.com/qemu-project/qemu/-/
> commit/058cfca5645a9ed7cb2bdb77d15f2eacaf343694
> 
> More info in the issue:
> https://gitlab.com/qemu-project/qemu/-/issues/3273
> 
> Now this seems to be caused by a race between disabling the
> dirty_bitmaps and the tracking implemented in the mirror top layer.
> Kevin shared me a possible solution:
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index b344182c747..f76e43f22c1 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1122,6 +1122,9 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>       * accessing it.
>       */
>      mirror_top_opaque->job = s;
> +    if (s->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
> +        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> +    }
>  
>      assert(!s->dbi);
>      s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
> @@ -2018,7 +2021,9 @@ static BlockJob *mirror_start_job(
>       * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
>       * mode.
>       */
> -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> +    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
> +        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> +    }
>  
>      bdrv_graph_wrlock_drained();
>      ret = block_job_add_bdrv(&s->common, "source", bs, 0,
> 
> 
> Running this for some hours already, and it seems to fix the issue.
> 
> Let's open up the discussion if this is the proper way to fix it, or if
> there are better alternatives :)

Yes, I do think this is the proper solution. I ended up with essentially
the same yesterday (see the Gitlab issue). I moved the disabling
unconditionally, but there should be no need to delay the disabling if
using write-blocking mode. I would suggest moving the comment on top of
the changed hunk in mirror_start_job() along to the new hunk in
mirror_run(). With that, consider the change:

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>

Best Regards,
Fiona


