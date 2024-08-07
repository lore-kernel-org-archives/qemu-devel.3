Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A19EC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 13:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbgeI-0003jP-Fh; Wed, 07 Aug 2024 09:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbgeF-0003hT-68; Wed, 07 Aug 2024 09:24:15 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbgeB-0002aE-GL; Wed, 07 Aug 2024 09:24:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5E0A4CE112C;
 Wed,  7 Aug 2024 13:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAA8C32782;
 Wed,  7 Aug 2024 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723037042;
 bh=IJWsnY/NFxnESGFOLGzPavd3GqiqGQL1qkUbbESjJaQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SF+ZF/7T0ixwlBKAQctHdY+NLgJLFBBrgwBjoyzZuVq2OMWttiwJX2pCvZF+wGFiW
 PT730MaCfbYhUqasVtP4WvtEt13DvxcBgZkegjJo8tX/xa0WgcifvuRPIdKS2ycnIE
 J+zty3zM7tuZudJ9DFoG9PpkG5K9vHlCBKnWsX5RdXxJczvWXe8l494Yt8u7pj213E
 1wgfDf11xXhd11ccvMsgbYrzxQHSwztTOOseWMa1krTfFjot31EiqJMF+gXSQ0GHei
 s7h+6mXScDFikvSN7HPkTwZf22bfanSbL6m1FyYvtTvAGBAOByXbAKMmIxWnAu4rWD
 ra8rfKYHo86kw==
Date: Wed, 7 Aug 2024 15:23:57 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807152357.0d2dc466@foz.lan>
In-Reply-To: <20240807103436.000013fc@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
 <20240807094750.6414fb2f@foz.lan>
 <20240807103436.000013fc@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Em Wed, 7 Aug 2024 10:34:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 7 Aug 2024 09:47:50 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 6 Aug 2024 16:31:13 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > PS:
> > > looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> > > and it is the total size of a error block for a error source.
> > > 
> > > However acpi_hest_ghes.rst (3) says it should be 4K,
> > > am I mistaken?    
> > 
> > Maybe Jonathan knows better, but I guess the 1K was just some
> > arbitrary limit to prevent a too big CPER. The 4K limit described
> > at acpi_hest_ghes.rst could be just some limit to cope with
> > the current bios implementation, but I didn't check myself how
> > this is implemented there. 
> > 
> > I was unable to find any limit at the specs. Yet, if you look at:
> > 
> > https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section  
> 
> I think both limits are just made up.  You can in theory log huge
> error records.  Just not one does.

If both are made up, I would sync them, either patching the
documentation or the ghes driver.

> 
> > 
> > The processor Error Information Structure, starting at offset
> > 40, can go up to 255*32, meaning an offset of 8200, which is
> > bigger than 4K.
> > 
> > Going further, processor context can have up to 65535 (spec
> > actually says 65536, but that sounds a typo, as the size is
> > stored on an uint16_t), containing multiple register values
> > there (the spec calls its length as "P").
> > 
> > So, the CPER record could, in theory, have:
> > 	8200 + (65535 * P) + sizeof(vendor-specicific-info)
> > 
> > The CPER length is stored in Section Length record, which is
> > uint32_t.
> > 
> > So, I'd say that the GHES record can theoretically be a lot
> > bigger than 4K.	  
> Agreed - but I don't think we care for testing as long as it's
> big enough for plausible records.   Unless you really want
> to fuzz the limits?

Fuzz the limits could be interesting, but it is not on my
current plans.

Yet, 1K could be a little bit short for ARM CPER.

See: N.26 ARMv8 AArch64 GPRs (Type 4) has 256 bytes for
registers, plus 8 bytes for the header. So, a total size of
264 bytes, for a single context register dump. I would expect
that, in real life, type 4 to always be reported on aarch64,
on BIOS with context register support. Maybe other types could
also be dumped altogether (like context registers for EL1, 
EL2 and/or EL3).

If just one type 4 context is encoded, it means that, 1K has 
space for 23 errors (of a max limit of 255).

Just looking at the maximum number, my feeling is that 1K
might be too short to simulate some real life reports,
but that depends on how firmware is actually grouping
such events.

So, maybe this could be expanded to, let's say, 4K, thus
aligning with the ReST documentation.

Regards,
Mauro

