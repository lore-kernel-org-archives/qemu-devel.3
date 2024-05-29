Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA78FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGcj-0006Ni-3P; Wed, 29 May 2024 06:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sCGch-0006N8-FY; Wed, 29 May 2024 06:33:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sCGcf-0007pv-F0; Wed, 29 May 2024 06:33:35 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 033DE443A7;
 Wed, 29 May 2024 12:33:30 +0200 (CEST)
Message-ID: <5e6a19d0-bb58-440e-9524-25555a276a21@proxmox.com>
Date: Wed, 29 May 2024 12:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "monitor: use aio_co_reschedule_self()"
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org
References: <20240506190622.56095-1-stefanha@redhat.com>
 <20240506190622.56095-2-stefanha@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240506190622.56095-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

CC-ing stable since 1f25c172f83704e350c0829438d832384084a74d is in 9.0.0

Am 06.05.24 um 21:06 schrieb Stefan Hajnoczi:
> Commit 1f25c172f837 ("monitor: use aio_co_reschedule_self()") was a code
> cleanup that uses aio_co_reschedule_self() instead of open coding
> coroutine rescheduling.
> 
> Bug RHEL-34618 was reported and Kevin Wolf <kwolf@redhat.com> identified
> the root cause. I missed that aio_co_reschedule_self() ->
> qemu_get_current_aio_context() only knows about
> qemu_aio_context/IOThread AioContexts and not about iohandler_ctx. It
> does not function correctly when going back from the iohandler_ctx to
> qemu_aio_context.
> 
> Go back to open coding the AioContext transitions to avoid this bug.
> 
> This reverts commit 1f25c172f83704e350c0829438d832384084a74d.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-34618
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/qmp-dispatch.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index f3488afeef..176b549473 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -212,7 +212,8 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
>               * executing the command handler so that it can make progress if it
>               * involves an AIO_WAIT_WHILE().
>               */
> -            aio_co_reschedule_self(qemu_get_aio_context());
> +            aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
> +            qemu_coroutine_yield();
>          }
>  
>          monitor_set_cur(qemu_coroutine_self(), cur_mon);
> @@ -226,7 +227,9 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
>               * Move back to iohandler_ctx so that nested event loops for
>               * qemu_aio_context don't start new monitor commands.
>               */
> -            aio_co_reschedule_self(iohandler_get_aio_context());
> +            aio_co_schedule(iohandler_get_aio_context(),
> +                            qemu_coroutine_self());
> +            qemu_coroutine_yield();
>          }
>      } else {
>         /*


