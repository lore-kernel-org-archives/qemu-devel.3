Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F32CC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0xS-0002Dm-Ie; Tue, 13 Aug 2024 19:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0xQ-00024Q-AE; Tue, 13 Aug 2024 19:29:40 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0xO-0007PO-EQ; Tue, 13 Aug 2024 19:29:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5E5F5CE17E3;
 Tue, 13 Aug 2024 23:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A2CC32782;
 Tue, 13 Aug 2024 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723591774;
 bh=MztplHyL+pZPuymFc0voh9Nuxrk0Y/b6mJ5Y2Bu27Yw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QK8pV5uG5mQGpTMH923Q+lMDVTUXeDOO2zAvfJKsTknDnQMY5cy/7c/JR+7FXbwrc
 a/FAYGX1FaCNFg++4zaQeCSC8HrsHF44Imteaij/+XrvwSjfy3QFLIBjEX0c4qB8Dj
 jFQAfEKxGbuNwp5u4VfjnWuXKWdCrsg5pDZuJBy0y1a+CRNBZ73dQshzLQ2XKVge8B
 sDouCSanm+BRGcSjDWjtmguHtMSzqu4+Uo8+PJ1Hn2sRhIfqyOMI9DijSRNTO5k52m
 AD8VyjSJMKTIFxMu6QhaEQf0JE6k7wQC0jeF9BJ40zi9LHKo059FvKgf8PO9tkB9cQ
 lXW/NL1TXG6ng==
Date: Wed, 14 Aug 2024 01:29:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/10] Add ACPI CPER firmware first error injection
 on ARM emulation
Message-ID: <20240814012929.59be7ef0@foz.lan>
In-Reply-To: <20240812141835.50749f0e@imammedo.users.ipa.redhat.com>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <20240808145735.70f81f76@foz.lan>
 <20240812141835.50749f0e@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Mon, 12 Aug 2024 14:18:35 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 8 Aug 2024 14:57:35 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Thu,  8 Aug 2024 14:26:26 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> >   
> > > v6:
> > > - PNP0C33 device creation moved to aml-build.c;
> > > - acpi_ghes record functions now use ACPI notify parameter,
> > >   instead of source ID;
> > > - the number of source IDs is now automatically calculated;
> > > - some code cleanups and function/var renames;
> > > - some fixes and cleanups at the error injection script;
> > > - ghes cper stub now produces an error if cper JSON is not compiled;
> > > - Offset calculation logic for GHES was refactored;
> > > - Updated documentation to reflect the GHES allocated size;
> > > - Added a x-mpidr object for QOM usage;
> > > - Added a patch making usage of x-mpidr field at ARM injection
> > >   script;  
> 
> stopping review at 5/10 and expecting a version with
> GHES source to error status block mapping fetched from
> HEST in guest RAM, instead of pre-calculated offsets
> in source code  (as in this series) to avoid migration
> issues and keeping compat plumbing manageable down the road.

Done. Sent a version 7 addressing it, and the other received
feedbacks. On this version, there are just two offsets used
during error injection:

1) the ack offset: represented relative to HEST table;
2) the CPER data offset: relative to /etc/hardware_errors table.

Thanks,
Mauro

