Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B830FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6qJ-0001sm-6l; Wed, 29 Apr 2026 11:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wI6qH-0001sQ-Pf; Wed, 29 Apr 2026 11:28:49 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wI6qG-0006jz-6q; Wed, 29 Apr 2026 11:28:49 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EA6D68752F;
 Wed, 29 Apr 2026 17:28:44 +0200 (CEST)
Message-ID: <76eb4371-8cfe-4d9f-870f-56c9a6dda334@proxmox.com>
Date: Wed, 29 Apr 2026 17:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] qcow2: Fix corruption on discard during write with COW
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-4-kwolf@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260427170520.101242-4-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1777476426576
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 27.04.26 um 7:04 PM schrieb Kevin Wolf:
> @@ -2000,6 +2028,15 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>      int64_t cleared;
>      int ret;
>  
> +    /*
> +     * If we're touching a cluster for which allocating writes are in flight,
> +     * wait for them to complete to avoid conflicting metadata updates.
> +     *
> +     * We don't need to allocate a QCowL2Meta for the discard operation because
> +     * s->lock is held for the duration of the whole operation.

The caller in qcow2_make_empty() does not acquire s->lock AFAICS. Can
that be a problem?

> +     */
> +    wait_for_dependencies(bs, offset, bytes);
> +
>      /* Caller must pass aligned values, except at image end */
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||


