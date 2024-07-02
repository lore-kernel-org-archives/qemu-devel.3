Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786ABC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfNg-0000ft-Qk; Tue, 02 Jul 2024 11:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1sOfNd-0000Yp-4l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:25:17 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1sOfNY-0000ES-LQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:25:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BF40A61CD1;
 Tue,  2 Jul 2024 15:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD37C116B1;
 Tue,  2 Jul 2024 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719933901;
 bh=DKJBJ2rm9sYD8Fs/cVPyaYVoO+wc7ZxfKQMHmf3nj9w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vxy7kT1O3l6AThZEENwXSpeavgEjhSVSPS6odXsnIqd2h98QUXk8mMYY/7SN662ey
 9oskTgzL48Yqrb9M9Ekizk8YRQAwBerFxxKo44xW7Ow118v5b3iRaXqY6AIqRrb/4K
 93OAz369GCko2OcyLskPQTO1K90K/SI9+vVfHz23/yN/E7RDX9Nr/T5Er+v6Wcwv1N
 D8C+bOv/Co1ogWRSgEK+Vixp8Do6GFSP6h7PPT2Xs3iKjxDXb8AnKGNF9TuiU/Yo2f
 t2oshLHkboQMGa0Z6UPpPvO5qQo9iN0ZDKIg61zvbXS+S+E9uvQMWlKpVTmxOI/9br
 KeKsr4F2SQ4mQ==
Date: Tue, 2 Jul 2024 09:24:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ayush Mishra <ayush.m55@samsung.com>
Cc: qemu-devel@nongnu.org, its@irrelevant.dk, foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: actually implement abort
Message-ID: <ZoQby9WzEesIhuLz@kbusch-mbp>
References: <CGME20240702133144epcas5p22b982613bfbfce0e7ad0c74fd72a7956@epcas5p2.samsung.com>
 <20240702080232.848849-1-ayush.m55@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702080232.848849-1-ayush.m55@samsung.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=kbusch@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Tue, Jul 02, 2024 at 01:32:32PM +0530, Ayush Mishra wrote:
> Abort was not implemented previously, but we can implement it for AERs and asynchrnously for I/O.

Not implemented for a reason. The target has no idea if the CID the
host requested to be aborted is from the same context that the target
has. Target may have previoulsy completed it, and the host re-issued a
new command after the abort, and due to the queueing could have been
observed in a different order, and now you aborted the wrong command.

