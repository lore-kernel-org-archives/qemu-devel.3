Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C91CEACCE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdzU-0006NK-Ob; Tue, 01 Oct 2024 10:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1svdw4-0003jr-KQ; Tue, 01 Oct 2024 10:33:14 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1svdvx-00013U-7x; Tue, 01 Oct 2024 10:33:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 76DD7A428C2;
 Tue,  1 Oct 2024 05:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D3EC4CEC6;
 Tue,  1 Oct 2024 05:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727761100;
 bh=KWHKsBqafASDIcbljdst2Hf9v1Awn2C+S3J8HKqz9zQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MLft1ETqhuR+CYOGxey7FAl9KzwHTi606ejrkAgQUwX7PmST7+XdLxQsxu81hzqFp
 lbqfLgzQcXbzq62hbSkx7gRbHG+deOfHSZcRy+GXp5V2xxQm1VFR76SnvZxZavastI
 V7hhwfbkTAVcQPcu4p5QLIF++ZP+XV5ynbXuw21zKcNuj+X7WU9CTSMMUJLcagtHjT
 gN3yePvGSk2KFs/WxdRlNYvgf3RErGl5vM3Aj5f2D3IgSYvE30G0bFMWgb6lm8uzJJ
 +HwwF6pel/0q7SPIf7EgtZ5gdkmBtKwcLYMQoO6D9mz79ZiGKawjrqF9YETS2KsEr2
 g9q0ZSNfe5Acw==
Date: Tue, 1 Oct 2024 07:38:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 10/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241001073815.4720a986@foz.lan>
In-Reply-To: <20240926130348.00005e45@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
 <5e8c2f0267a21d05ed09c8af616a92d94638c474.1727236561.git.mchehab+huawei@kernel.org>
 <20240926130348.00005e45@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Thu, 26 Sep 2024 13:03:48 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:15 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Currently, CPER address location is calculated as an offset of
> > the hardware_errors table. It is also badly named, as the
> > offset actually used is the address where the CPER data starts,
> > and not the beginning of the error source.
> > 
> > Move the logic which calculates such offset to a separate
> > function, in preparation for a patch that will be changing the
> > logic to calculate it from the HEST table.
> > 
> > While here, properly name the variable which stores the cper
> > address.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Trivial comment inline.
> 
> Given this is a placeholder for more radical refactor I'll not comment on
> the maths etc being less flexible than it will hopefully end up!

Actually there will be two versions of the math calculus after the
next patch series:

1. one compatible with versions up to 9.1 that work with a single
   source ID, using offsets calculated from the hardware_errors
   table, which doesn't contain the number of sources. Such code
   will be used only for migration. This is the one on this series;

2. one that will get the number of source IDs from the HEST table.
   Such math will be added at the next patch series.
   This requires a migration-incompatible change to store a
   pointer to HEST table. The math there is flexible and should
   work with all future changes, as it uses all offsets from the
   HEST table, using the links there to the harware_errors firmware
   file.

So, basically, the migration logic will check if a HEST pointer
is stored. If so, it will use (2). If not, it is because the VM
that was running on QEMU 9.1 had its state stored, and then
was recovered on QEMU 9.2. Such machine will then use the math
from (1), which supports a single source ID.

Thanks,
Mauro

