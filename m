Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6914ED46954
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 16:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vib40-00070r-Mk; Wed, 21 Jan 2026 11:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vib2W-0005eW-Ha
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:26:43 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vib2U-0003Oj-ED
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:26:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BBF343802;
 Wed, 21 Jan 2026 16:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F76EC4CEF1;
 Wed, 21 Jan 2026 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769012796;
 bh=fLylYEARCcMukST3MyB+TlKcZ2XozjvW++Y1+T24Tco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cF6kYRaZ7ZKgaaHQMm01eE4H8K9absBKkRR2erz5koJGIGMHMo7mTx2om6z7mFEw1
 Rj0MdZ/zKO3kJa0Ku8EtgNFBLaRwb4SdVqFqclxb1l1s+Uf0n9wBEYGIk5RE9sWmmp
 jfO4kHfGTkXmhKoR0BfOjkgWl1lFuLGLJ6I2GIzA+29xG3gaObXbpgvEiVKHRj7dUY
 VEDzsdCzRkbOqKpMKZy2WMqAIv2AjH/mt0RaqLTbgYlPV2K9cV5dqZqS5DpkryJuvO
 OzYjb8nLgsU3xWMMbiztpoZc16r0hYU45JbilwAdsS98Yg+lTcMfr7BDjXni/mtuSM
 I+icWB0cwOASA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vib2Q-00000003u9Y-0mOR; Wed, 21 Jan 2026 17:26:34 +0100
Date: Wed, 21 Jan 2026 17:26:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 09/13] scripts/ghes_inject: add a handler for PCIe bus
 error
Message-ID: <aXD9zxGctPoBuyhU@foz.lan>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <c7db16aae93a98f3b0675e1010e59f6cefdaf1cd.1768993993.git.mchehab+huawei@kernel.org>
 <20260121133255.000018b1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121133255.000018b1@huawei.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 21, 2026 at 01:32:55PM +0000, Jonathan Cameron wrote:
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

Yeah, me too. If I got it right from specs, this one is related to
the PCIe bus controller, while the other one is for the PCIe device.

Perhaps in practice vendors are using hardware-first approach for
the PCI controller.

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

-- 
Thanks,
Mauro

