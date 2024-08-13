Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D17C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 19:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdwjx-0001da-13; Tue, 13 Aug 2024 14:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sdwjr-0001bj-S9; Tue, 13 Aug 2024 14:59:25 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sdwjp-00029O-TF; Tue, 13 Aug 2024 14:59:23 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A4485617EA;
 Tue, 13 Aug 2024 18:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F37C32782;
 Tue, 13 Aug 2024 18:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723575556;
 bh=WO40j49FkGu+Q8lTsHl/pcFtXmA+HQMmF+nDSE40RQk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Mbf0Bgex0kjUzIdIRt26tVfsngq7XSfxksXF7oPIKuIoucAo3QrY1RZhxbrMkATsE
 HGxj4AtZyiv9bqJ/CG+caeC8WZ9BtPBT8PzS3P77EVlR3hgwtcOSm5lBvdmdVYM3dj
 BXMkHP3wXC5QYvkopT0JhXtKKEuRYbyEqqSmg95z7edaG7HNGJsJOR+DnKMDscbGI2
 92J6OP4ghGUoH58MoBCEU1oX6aGn4J0omchSqdZ47Bti23cOVjQSgou9G/rYkNV9OU
 kk/Fgt7TJSTmI7Dwkk1MCyKbeb2jM6Vcg2nW1hyqK1alv4Ae5kRaswmmHWB5lKbbH5
 5Q6t3XsMuBviQ==
Date: Tue, 13 Aug 2024 20:59:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240813205911.1719db56@foz.lan>
In-Reply-To: <20240812113900.25078ccc@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
 <20240807152547.000058fd@Huawei.com>
 <20240808101107.105a124f@imammedo.users.ipa.redhat.com>
 <20240808201903.077093ca@foz.lan>
 <20240812113900.25078ccc@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Em Mon, 12 Aug 2024 11:39:00 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > We may also store cper_offset there via bios_linker_loader_add_pointer()
> > and/or use bios_linker_loader_write_pointer(), but I can't see how the
> > data stored there can be retrieved, nor any advantage of using it instead
> > of the current code, as, in the end, we'll have 3 addresses that will be
> > used:
> > 
> > 	- an address where a pointer to CPER record will be stored;
> > 	- an address where the ack will be stored;
> > 	- an address where the actual CPER record will be stored.
> > 
> > And those are calculated on a single function and are all stored at the
> > ACPI table files.
> >
> > What am I missing?  
> 
> That's basically (2) approach and it works to some degree,
> unfortunately it's fragile when we start talking about migration
> and changing layout in the future.
> 
> Lets take as example increasing size of 1) 'Generic Error Status Block',
> we are considering. Old QEMU will, tell firmware to allocate 1K buffer
> for it and calculated offsets to [1] (that you've stored/calculated) will
> include this assumption.
> Then in newer we QEMU increase size of [1] and all hardcoded offsets will
> account for new size, but if we migrate guest from old QEMU to this newer
> one all HEST tables layout within guest will match old QEMU assumptions,
> and as result newer QEMU with larger block size will write CPERs at wrong
> address considering we are still running guest from old QEMU.
> That's just one example.
> 
> To make it work there a number of ways, but the ultimate goal is to pick
> one that's the least fragile and won't snowball in maintenance nightmare
> as number of GHES sources increases over time.
> 
> This series tries to solve problem of mapping GHES source to
> a corresponding 'Generic Error Status Block' and related registers.
> However we are missing access to this mapping since it only
> exists in guest patched HEST (i.e in guest RAM only).
> 
> The robust way to make it work would be for QEMU to get a pointer
> to whole HEST table and then enumerate GHES sources and related
> error/ack registers directly from guest RAM (sidestepping layout
> change issues this way).
> 
> what I'm proposing is to use bios_linker_loader_write_pointer()
> (only once) so that firmware could tell QEMU address of HEST table,
> in which one can find a GHES source and always correct error/ack
> pointers (regardless of table[s] layout changes).

Ok, got it. Such change was not easy, but I finally figured out how
to make it actually work.

I'll address tomorrow your comment on patch 5/10 about using raw data also 
for the other parts of CPER (generic error status and generic error data).

If you want to do a sneak peak, I'm keeping the latest development
version here:

	https://gitlab.com/mchehab_kernel/qemu/-/commits/qemu_submission?ref_type=heads

In particular, the patch changing from /etc/hardware_errors offset to
a HEST offset is at:

	https://gitlab.com/mchehab_kernel/qemu/-/commit/9197d22de09df97ce3d6725cb21bd2114c2eb43c

It contains several cleanups to make the logic clearer and more robust.

Thanks,
Mauro

