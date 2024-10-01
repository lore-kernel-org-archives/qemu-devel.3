Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941A5CEACCC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdni-0005iO-PE; Tue, 01 Oct 2024 10:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1svdmb-000509-AP; Tue, 01 Oct 2024 10:23:24 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1svdmK-0005e3-To; Tue, 01 Oct 2024 10:23:14 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2A966A4268E;
 Tue,  1 Oct 2024 05:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABB8C4CEC6;
 Tue,  1 Oct 2024 05:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727760559;
 bh=tuLz94NqQ0hls7myXaXA23/ISr3v1CUTbd7LWGCd4io=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YBFFONSBtvJJFQ8iKLKuuaV4H9YYl59U0QKPr6g1Iyn4qPsTKZFnhnECkM7TMeCQ3
 1HV1ROY3v9Z3rAco2EsYCwlKVzqkC31f5XgWvhkKYUaHZXxSXtwSyGTtoGOcgpreNu
 OZjGDxAqB/DCCqwTyKzfiFqZbyj2iP0bQTgtF4rNWGF0u1Y216Mh88w1XlKQsWCJsS
 XmTxNKBMiwQGSruXWIysbyCY4QJGqKLQaEdzVRLZeYX4rMhJze1xs8B49A++xgz1XN
 oypw8BLl1vABYo3B93reJG4AOdBeJ3wT4lHqPANUyvqFHygTXPmIJrNssik4+/7RJb
 G4tVBOW6CbcSw==
Date: Tue, 1 Oct 2024 07:29:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 08/15] acpi/ghes: Prepare to support multiple sources on
 ghes
Message-ID: <20241001072913.09f82e9f@foz.lan>
In-Reply-To: <20240925152333.0000110d@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
 <05fb5c6a7d26eeb730bf5fe1f67bb6581ec6d730.1727236561.git.mchehab+huawei@kernel.org>
 <20240925152333.0000110d@Huawei.com>
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

Em Wed, 25 Sep 2024 15:23:33 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:13 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The current code is actually dependent on having just one
> > error structure with a single source.
> > 
> > As the number of sources should be arch-dependent, as it
> > will depend on what kind of synchronous/assynchronous
> > notifications will exist, change the logic to dynamically
> > build the table.  
> Not really arch dependent.  Depends on both arch and some
> firmware implementation choices, but I guess that detail
> doesn't matter here.
> 
> > 
> > Yet, for a proper support, we need to get the number of
> > sources by reading the number from the HEST table. However,
> > bios currently doesn't store a pointer to it.
> > 
> > For now just change the logic at table build time, while
> > enforcing that it will behave like before with a single
> > source ID.
> > 
> > A future patch will add a HEST table bios pointer and
> > change the logic at acpi_ghes_record_errors() to
> > dynamically use the new size.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Trivial comment inline
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > @@ -335,9 +346,10 @@ static void build_ghes_v2(GArray *table_data,
> >      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
> >                       4 /* QWord access */, 0);
> >      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> > -        address_offset + GAS_ADDR_OFFSET,
> > -        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> > -        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
> > +                                   address_offset + GAS_ADDR_OFFSET,  
> 
> I'd prefer if we avoided realigning unless absolutely necessary or
> that it is split into a separate patch.
> Makes things a tiny bit harder to review.

Heh, Igor nacked a patch doing the alignment change on a separate patch,
so let's do it at the patches that are actually changing the code.

At least for me, it is a low easier to review patches that are properly
aligned with parenthesis. So, yeah it may be a little more painful to
review a patch changing alignments, but IMO it pays off on future
revisions, specially if we place one argument per line, like in this
function.

> 
> > +                                   sizeof(uint64_t),
> > +                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
> > +                                   (num_sources + index) * sizeof(uint64_t));
> >    
> 



Thanks,
Mauro

