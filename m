Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1814AC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJyv-00018T-J6; Mon, 27 Jul 2026 07:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1woJyu-000186-2U; Mon, 27 Jul 2026 07:58:52 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1woJyr-0004Z2-W4; Mon, 27 Jul 2026 07:58:51 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3997946F6F;
 Mon, 27 Jul 2026 13:58:39 +0200 (CEST)
Message-ID: <210b97b8-b85e-4326-972b-d1ed1b267ba2@proxmox.com>
Date: Mon, 27 Jul 2026 13:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block/export/fuse: fix regression with O_TRUNC when
 export is not growable
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
References: <20260702132256.661429-1-f.ebner@proxmox.com>
Content-Language: en-US
In-Reply-To: <20260702132256.661429-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1785153483895
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

Ping

Am 02.07.26 um 8:35 PM schrieb Fiona Ebner:
> Before commit a94a1d7699 ("fuse: Manually process requests (without
> libfuse)"), the O_TRUNC flag when open()-ing an export would be
> ignored. This is because libfuse sets FUSE_CAP_ATOMIC_O_TRUNC, so the
> kernel lets user space handle the O_TRUNC flag, which is ignored by
> the fuse code for export. After the commit, FUSE_CAP_ATOMIC_O_TRUNC is
> not set anymore, so the O_TRUNC flag is handled by the kernel, which
> executes a truncate.
> 
> For blockdev-based exports, this causes a regression, because opening
> with O_TRUNC would previously work, but results in an ENOTSUP after
> commit a94a1d7699. For file-based exports, the fact that truncate is
> executed can be considered an improvement in general. However, in
> combination with growable=off, this still results in a practical
> regression in combination with virt-fw-vars, which opens its output
> file with O_TRUNC and previously worked with a file-based export with
> growable=off. After commit a94a1d7699, the file is truncated upon open
> and then cannot grow, meaning virt-fw-vars won't be able to write the
> output.
> 
> To fix these regressions, while keeping the improved behavior for
> file-based exports with growable=on, set the FUSE_CAP_ATOMIC_O_TRUNC
> flag again if growable=off.
> 
> Fiona Ebner (2):
>   block/export/fuse: fix regression with O_TRUNC when export is not
>     growable
>   iotests: test O_TRUNC behavior for fuse exports
> 
>  block/export/fuse.c                        |  12 ++
>  tests/qemu-iotests/tests/fuse-truncate     | 171 +++++++++++++++++++++
>  tests/qemu-iotests/tests/fuse-truncate.out |   5 +
>  3 files changed, 188 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/fuse-truncate
>  create mode 100644 tests/qemu-iotests/tests/fuse-truncate.out
> 



