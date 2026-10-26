Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD44A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkTDGsDW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLR7e-0008Vh-QG; Mon, 26 Oct 2026 16:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1xLR7Q-0008T3-AJ; Mon, 26 Oct 2026 16:16:35 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1xLR7K-0007ke-Ja; Mon, 26 Oct 2026 16:16:28 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC6874393F;
 Mon, 26 Oct 2026 20:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5CD1F031E2;
 Mon, 26 Oct 2026 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793045783;
 bh=pYaaAlDYFRTqZ+wj+MoY8oeV2RM2hXXqdqz1u0tqFJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mkTDGsDWEivILxDWV6hR6+cMZa2rgf+7WwOtYHAIMkchj+eFPIwHBiCR8AKXhZ0zt
 0ORx4WBw4GI0C3T3mg+ekWd/94Sgt/v6u28/HDxh7z2v8F1SMSZayn8jCnc0fBBQ9C
 cxji/J6ib0dvxtWYXspflSwJjTXUJ2mSuiHf6hPcwxhbSm9ys6xdBlM4MYlQW01Vc+
 MeIHudJTnZYckF+xwUu5xkXkU/IB/JhjMP909B9uoXDlgQCsQFGQzZQXG+3192N2t9
 oVbdWmPkr0k38GPPh79sUJsybEv1k+EedKGb9sa6f3zlWAjtzjj3hD80lAB3A8hNsY
 r7C81yjgDFjpg==
Date: Mon, 26 Oct 2026 14:16:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH RESEND v3 4/7] dma-helpers: chunk dma_blk_cb at IOV_MAX
Message-ID: <at-1FYnLI6_MUWiX@kbusch-mbp>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
 <20261026-align-nvme-mdts-with-linux-v3-4-a33bd7c32df9@samsung.com>
 <20261026201126.GD629414@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026201126.GD629414@shajnocz.csb>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=kbusch@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 04:11:26PM -0400, Stefan Hajnoczi wrote:
> What happens when two large writes to the same sector run concurrently?
> Before, the result was either write A or write B. Now it's possible to
> get an interleaving of write A and B's data. 

That result is consistent with the storage hardware specs, too.

> I think this violates block device semantics and corrupts data. A
> serialization mechanism is needed if you want to do this.

Seems like overkill and you still don't get a deterministic outcome: you
get either A or B, but you the host doesn't know which. If you need
deterministic data, then the onus is usually on the host side to not
send overlapping writes.

