Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82231C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2bze-0005Sb-5x; Fri, 04 Sep 2026 18:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1x2bzT-0005OU-UJ; Fri, 04 Sep 2026 18:02:33 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1x2byv-0005bP-E2; Fri, 04 Sep 2026 18:02:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39D7A600D1;
 Fri,  4 Sep 2026 22:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB161F00A3D;
 Fri,  4 Sep 2026 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788559260;
 bh=wgx18wAY9w6K/fLeBpwCD6JSl3rcZlHfJZ296+BQohE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AK7oeEkHYPjAKWmbZGfy5d22+8FoO1My7FbLgWOJMaLz0C+CIleSnqs03tX0Aebb3
 AHw4Xyfvam5m71RzsuVrkljwnFbALTuSdl2mKn34vURXQv4OucKr6gpTiRzszEYl+U
 d/S98Jv0HBQP8rfCuxWWUlG4JLDhLYskrD3rjgqHMZuxZKDf58vYNAyijMO9aNp84A
 wjGrQDleh6GrBsS1QIZC6WGV9kp5APD1XOpCJ5bqaWMu9apmjlEyN6pOBoq9MTNMNj
 klUOnKL2r+r25Se5InWSkbo055wZKRWcs9hx8enohS5cFhf5bICGnR0F0hkyUibwtq
 OHgNWhm2c74XQ==
Date: Fri, 4 Sep 2026 16:00:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 0/7] hw/nvme: lift IOV_MAX limit in DMA path
Message-ID: <aps_mvzSc79lg8J-@kbusch-mbp>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=kbusch@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Aug 19, 2026 at 05:24:02PM +0200, Daniel Gomez wrote:
> Raise the QEMU NVMe controller's MDTS beyond the 2 MiB cap.
> 
> Commit 53493c1f83 ("hw/nvme: cap MDTS value for internal limitation")
> needed the 2 MiB cap because dma_blk_io() submitted the full sglist
> in one preadv()/pwritev() call, which the host kernel rejects when the
> iovec count exceeds IOV_MAX. This series moves the IOV_MAX bound down to
> dma_blk_cb(), where we batch in IOV_MAX chunks when necessary.

Series looks good to me:

Reviewed-by: Keith Busch <kbusch@kernel.org>

