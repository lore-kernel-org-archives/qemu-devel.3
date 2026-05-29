Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30817CD6E50
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyPz-0000zG-2n; Fri, 29 May 2026 10:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1wSyPu-0000u1-1i; Fri, 29 May 2026 10:42:30 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1wSyPs-0000aO-KT; Fri, 29 May 2026 10:42:29 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BC9C605DD;
 Fri, 29 May 2026 14:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9DA1F0089A;
 Fri, 29 May 2026 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780065744;
 bh=45W8h+UDdrCe3td2wtxxePsZkx0zI5TnSODhieitH8k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=liaWyGeCUT8UKnaS4VKsxJzHA3qKp4k/S7AmUAqeQ7UFUg4Sl6yncl6NMUvZlZV5C
 YL89LocXrlhogtZn20LsVw8geWFyRDtc5BuqAqSOpePoLsyjqoP/XW57dc0kShXcEf
 GqdlbzD/5czhFqdonbcNqZwnA8prQU9zCONvZGrgsF9qnmbJh3pQu7A7fKG2plM9GX
 2JbGUwN3I338I9F8AvOAFv/nBmy+p8OVbtU2NIlNpBJ478NfTWKH53L5RGLTAXlWkH
 C4iah3TmUwX7T5ABoAL2s3/haNbSaBkPdbiinMPo0i23sMSI3vSkBbdsyY6APR2HQK
 2W5jcPmk6CJvQ==
Date: Fri, 29 May 2026 08:42:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 1/3] dma-helpers: chunk dma_blk_cb at IOV_MAX
Message-ID: <ahmlzjtnRoCtBP8a@kbusch-mbp>
References: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
 <20260529-align-nvme-mdts-with-linux-v1-1-221d4d21ab43@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-align-nvme-mdts-with-linux-v1-1-221d4d21ab43@samsung.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=kbusch@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, May 29, 2026 at 02:36:13PM +0200, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> dma_blk_cb() submits dbs->iov to io_func() in one shot, so callers
> must keep dbs->iov.niov below IOV_MAX or the host preadv()/pwritev()
> rejects the call.
> 
> Break the accumulation loop when niov reaches IOV_MAX. The existing
> re-entry path resumes mapping and submits a follow-up chunk under
> the same AIOCB, so callers no longer carry that constraint.

Thanks, I like the idea. One question below.

> -        if (!mem)
> +        if (!mem || dbs->iov.niov >= IOV_MAX) {
>              break;
> +        }

Won't this leak "mem" if it is not NULL, but we've hit the iov.niov
condition? If so, I think you can move this new check to after the
qemu_iovec_add call.

