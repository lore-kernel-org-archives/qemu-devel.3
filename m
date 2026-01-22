Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BB4D3EE89
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vixlw-0006dc-1Z; Thu, 22 Jan 2026 11:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vixlC-0006Xz-80
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:42:20 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vixlA-0004OY-LB
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:42:17 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 67FFE4095E;
 Thu, 22 Jan 2026 16:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47066C116D0;
 Thu, 22 Jan 2026 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769100134;
 bh=F78Elc2RaITbygNewNcHtQrS7mD9P39HTYw3TZLGnjw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nI/tGl/iokvmiT1DWeX2DKOXCdVz8q2xfO94f67YOlzaqAbzSXMLmDbtsbZgF/ohd
 ev9ETRY6hn1VeQMdbp47/8QfGl1zH4owxvis+HBHvj4TVUhrh/fZ1qNeKWaslgJFZJ
 HnwRDPHKjsF0o4j1hMKBztLx/h5HOR3AFsmcVZlD3eOfYPFXWmjFTrhGHz2oTEXn8q
 4us4x4p+XBnO/9WVWOzd7iStrFvRdzv9Bkckxk4eTg8i67m7tdzhaVAx1n9dWurIDj
 x8HYsgmh6PV838B+T9bsVPev7uRpLi/q2X2Fc7UTjEwjW2WVXusbZ6C4zsT5ZU8/Qh
 GNxlezRyuuwyw==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vixl6-000000055Fi-1ZMj; Thu, 22 Jan 2026 17:42:12 +0100
Date: Thu, 22 Jan 2026 17:42:11 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Michael S Tsirkin
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, Igor Mammedov
 <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH 09/13] scripts/ghes_inject: add a handler for PCIe bus
 error
Message-ID: <20260122174211.76831b4a@localhost>
In-Reply-To: <20260121133255.000018b1@huawei.com>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <c7db16aae93a98f3b0675e1010e59f6cefdaf1cd.1768993993.git.mchehab+huawei@kernel.org>
 <20260121133255.000018b1@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
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

On Wed, 21 Jan 2026 13:32:55 +0000
Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:

> On Wed, 21 Jan 2026 12:25:17 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Add a logic to do PCIe BUS error injection.
> > 
> > On Linux Kernel, despite CPER_SEC_PCI_X_BUS macro is defined for such
> > event, ghes.c doesn't implement support for it yet:
> > 
> > [16950.077494] {26}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > [16950.077866] {26}[Hardware Error]: event severity: recoverable
> > [16950.078118] {26}[Hardware Error]:  Error 0, type: recoverable
> > [16950.078444] {26}[Hardware Error]:   section type: unknown, c5753963-3b84-4095-bf78-eddad3f9c9dd
> > [16950.078800] {26}[Hardware Error]:   section length: 0x48
> > [16950.079069] {26}[Hardware Error]:   00000000: 00000000 00000000 00000000 00000000  ................
> > [16950.079442] {26}[Hardware Error]:   00000010: 00000001 00000000 00000000 00000000  ................
> > [16950.079811] {26}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > [16950.080181] {26}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> > [16950.080538] {26}[Hardware Error]:   00000040: 00000000 00000000                    ........
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> LGTM. Bit surprised Linux doesn't decode it but fair enough.
> Seems a bit unlikely it ever will given this seems not to cover PCIe
> which has it's own records.

Yeah, I misread the spec when I wrote: this one is specific for
PCI/PCI-X, and not PCIe. That probably explain why this was not
implemented in practice yet.

I'll rename it.

Still, it is good to test it, even not being implemented, as it
helps to check how Linux reacts to a GUID it doesn't know about
it.

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 

