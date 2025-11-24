Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE48CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNU4i-0003Nt-Bj; Mon, 24 Nov 2025 05:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vNU3q-0003D4-BE; Mon, 24 Nov 2025 05:44:50 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vNU3o-0006wf-Mf; Mon, 24 Nov 2025 05:44:46 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A6B7B80212;
 Mon, 24 Nov 2025 11:44:31 +0100 (CET)
Message-ID: <3fbb3f9e-ded7-4fc5-9393-30fa3f4baad5@proxmox.com>
Date: Mon, 24 Nov 2025 11:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-backend: Fix race when resuming queued requests
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20251119172720.135424-1-kwolf@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20251119172720.135424-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1763981036164
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

Am 19.11.25 um 6:27 PM schrieb Kevin Wolf:
> When new requests arrive at a BlockBackend that is currently drained,
> these requests are queued until the drain section ends.
> 
> There is a race window between blk_root_drained_end() waking up a queued
> request in an iothread from the main thread and blk_wait_while_drained()
> actually being woken up in the iothread and calling blk_in_flight(). If

Small typo here: blk_inc_in_flight()

> the BlockBackend is drained again during this window, drain won't wait
> for this request and it will sneak in when the BlockBackend is already
> supposed to be quiesced. This causes assertion failures in
> bdrv_drain_all_begin() and can have other unintended consequences.
> 
> Fix this by increasing the in_flight counter immediately when scheduling
> the request to be resumed so that the next drain will wait for it to
> complete.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>


