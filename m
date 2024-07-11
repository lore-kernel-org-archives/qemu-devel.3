Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2760C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvIT-0003AY-2A; Thu, 11 Jul 2024 11:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1sRvIQ-00038z-Pv
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:01:22 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1sRvIO-0007eP-LS
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:01:22 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 81317615F9;
 Thu, 11 Jul 2024 15:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA760C116B1;
 Thu, 11 Jul 2024 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720710076;
 bh=DrjgF8PBCxLbvDAYGk2K08traFJBKwCnRp90uDTZ514=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bFS9/pIZXA85Yf+wD6trXJ5SPWDaiiNfgFEVFplYiwKEWqij9/D0ggqPwnA16kojP
 IT6yXtI/+IFVEu+itXb1FS0uKOlfiuwfjWBnxNk6HxrJzBaozARQDo/VrP40hYSD8d
 VLF/djlTAtGz88fHQi5bxigb5x9ndOL2hVnMIV67kHljG3YMIdFym4gNVsREZyUYga
 ayq/cukDwVrIyWQ73cqPqTEOT+JUq5QtW6BoMax9THwc9XhuX6nyXQXM4ob6+rXOZf
 fOfUnGzvOZQv6jCmdhNPjPMnTLBdKBtgvpC9u0QMLXgtkBWB7kujRa8yBpV9DmFmaQ
 i4VIlhK1nu4Gw==
Date: Thu, 11 Jul 2024 09:01:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Ayush Mishra <ayush.m55@samsung.com>, qemu-devel@nongnu.org,
 foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: actually implement abort
Message-ID: <Zo_zuOB1_tXlKYj_@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240702133144epcas5p22b982613bfbfce0e7ad0c74fd72a7956@epcas5p2.samsung.com>
 <20240702080232.848849-1-ayush.m55@samsung.com>
 <ZoQby9WzEesIhuLz@kbusch-mbp> <ZoRNKb_u5SW3Ts0e@cormorant.local>
 <Zo5P18w2P0jbmgxL@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo5P18w2P0jbmgxL@cormorant.local>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=kbusch@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, Jul 10, 2024 at 11:09:43AM +0200, Klaus Jensen wrote:
> On Jul  2 20:55, Klaus Jensen wrote:
> > On Jul  2 09:24, Keith Busch wrote:
> > > On Tue, Jul 02, 2024 at 01:32:32PM +0530, Ayush Mishra wrote:
> > > > Abort was not implemented previously, but we can implement it for AERs and asynchrnously for I/O.
> > > 
> > > Not implemented for a reason. The target has no idea if the CID the
> > > host requested to be aborted is from the same context that the target
> > > has. Target may have previoulsy completed it, and the host re-issued a
> > > new command after the abort, and due to the queueing could have been
> > > observed in a different order, and now you aborted the wrong command.
> > 
> > I might be missing something here, but are you saying that the Abort
> > command is fundamentally flawed? Isn't this a host issue? The Abort is
> > for a specific CID on a specific SQID. The host *should* not screw this
> > up and reuse a CID it has an outstanding Abort on?
> > 
> > I don't think there are a lot of I/O commands that a host would be able
> > to cancel (in QEMU, not at all, because only the iscsi backend
> > actually implements blk_aio_cancel_async). But some commands that issue
> > multiple AIOs, like Copy, may be long running and with this it can
> > actually be cancelled.
> > 
> > And with regards to AERs, I don't see why it is not advantageous to be
> > able to Abort one?
> 
> Keith, any thoughts on this?

Oh, you can take this if you want, I'm just mentioning the pitfalls with
the abort command. While sequestoring command id's that are being
aborted may be good practice for the host, the spec doesn't say anything
about it. The Linux driver doesn't do that at least, though it recently
created a different mechanism to avoid immediate command id reuse.

