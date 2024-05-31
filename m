Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18375C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 10:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCzd5-0004WA-Mg; Fri, 31 May 2024 06:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namcao@linutronix.de>)
 id 1sCzd4-0004Vs-Ij
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:36:58 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namcao@linutronix.de>)
 id 1sCzd2-0003f5-OF
 for qemu-devel@nongnu.org; Fri, 31 May 2024 06:36:58 -0400
Date: Fri, 31 May 2024 12:36:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1717151800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kR1M31gvA91CXyY9EUjMjaYAxftlHSB/tFZZKTqGWmU=;
 b=j5xac1QnvUMWLfvKXFQPCY+0i0EO+1xFn6UpW5kfjVq6mMEt777o2dI2BAuBPQ8sADlsAK
 3/w9I8eqlRHsncuuVtyausug/1f5+jm41Ul4HG+Ab3ePJYsp0y8qbcnyapzt5ouFywZP/O
 gDFSw2B9hqXtoQE9I1MMszAZUXv4POQjFqkl3s3dULeuTJW2+ILnGGJoHDCwI2eD0qx2Es
 pY3oSm+kfmESuh5Kum1ZCEhhSdFxoOeDTp8CVCcCk7K3gmqhN2anyGlzEXmkmSqcZnaYIu
 mGrNX978NSpFYlzViWjvkF9ySnTnFG7tc7fvZEEyqLvVCzCwk1wtZMtgTft9HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1717151800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kR1M31gvA91CXyY9EUjMjaYAxftlHSB/tFZZKTqGWmU=;
 b=J8HFj9a1oB6FaoA3Q7Z3ELFCKFIbCLjnuDAklUISds1FbnztXke05hrswXazLH5titdxGg
 MkEFx+txlzK7UECQ==
From: Nam Cao <namcao@linutronix.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] pci-bridge/xio3130_downstream: fix invalid link speed
 and link width
Message-ID: <20240531103635.x9vzCtCv@linutronix.de>
References: <20240529201744.15420-1-namcao@linutronix.de>
 <20240531111400.000064f7@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531111400.000064f7@Huawei.com>
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=namcao@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 31, 2024 at 11:14:00AM +0100, Jonathan Cameron wrote:
> On Wed, 29 May 2024 22:17:44 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > Set link width to x1 and link speed to 2.5 Gb/s as specified by the
> > datasheet. Without this, these fields in the link status register read
> > zero, which is incorrect.
> > 
> > This problem appeared since 3d67447fe7c2 ("pcie: Fill PCIESlot link fields
> > to support higher speeds and widths"), which allows PCIe slot to set link
> > width and link speed. However, if PCIe slot does not explicitly set these
> > properties, they will be zero. Before this commit, the width and speed
> > default to x1 and 2.5 Gb/s.
> > 
> > Fixes: 3d67447fe7c2 ("pcie: Fill PCIESlot link fields to support higher speeds and widths")
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> Hi Nam,
> 
> I'm feeling a bit guilty about this one a known it was there for a while.
> 
> I was lazy when fixing the equivalent CXL case a while back on
> basis no one had noticed and unlike CXL (where migration is broken for a lot
> of reasons) fixing this may need to take into account migration from broken to
> fixed versions.  Have you tested that?

I tested this patch with Linux kernel.

I noticed this bug when Linux complained that the PCI link was broken.
Linux determines weather a link is up by checking if these speed/width
fields have valid value.

Repro:
	qemu-system-x86_64 \
	-machine pc-q35-2.10 \
	-kernel bzImage \
	-drive "file=img,format=raw" \
	-m 2048 -smp 1 -enable-kvm \
	-append "console=ttyS0 root=/dev/sda debug" \
	-nographic \
	-device pcie-root-port,bus=pcie.0,slot=1,id=rp1,bus-reserve=253 \
	-device x3130-upstream,id=up1,bus=rp1 \
	-device xio3130-downstream,id=dp1,bus=up1,chassis=1,slot=1

Then after Linux has booted:
	device_add device_add e1000,bus=dp1,id=eth0

Then Linux complains that something is wrong with the link:
pcieport 0000:02:00.0: pciehp: Slot(1-1): Cannot train link: status 0x2000
 
This patch gets rid of Linux's complain, and the hot-plug now works fine.

> I did the CXL fix slightly differently.  Can't remember why though - looking
> at the fact it uses an instance_post_init, is there an issue with accidentally
> overwriting the parameters?  Or did I just over engineer the fix?

I would say over engineer. I think CXL does not take link speed and link
width as parameters.

Best regards,
Nam

