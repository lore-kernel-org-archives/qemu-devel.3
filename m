Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E426C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 11:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tncLL-0001QO-80; Thu, 27 Feb 2025 06:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tncKq-00019g-7w; Thu, 27 Feb 2025 06:45:50 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tncKo-0007bS-8g; Thu, 27 Feb 2025 06:45:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B8CB65C493B;
 Thu, 27 Feb 2025 11:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2270C4CEDD;
 Thu, 27 Feb 2025 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740656743;
 bh=RbApozzYBuV1XvJ4VezhGxrAHX++zrZ0W8FPqStcTYw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=e11cxfxTuj0kBUHpM7kvJNlAipl9h2iRj2UT7uCU9ruFW2Rs6bCYfNlyZt6vheCcI
 DN4KpT3iXyxK/kjMHyQnkCF1+GJ3dzDZ6oj00cJdy3e0GcsxDXPwr0G6H9ICLFjE4G
 OP8KMKsftjEjSEPS4a2AxfyNM0ca30+9e+xan4fj76tFiPKVM+FfNvPCF2Wtx/kvt+
 MsK69+5xk8wYgoc4C7sdshO017fxp/GhXAYqMyTN3MORws3w9mEEyeO1A7yXJ6Lt7m
 fQzHsmJwwfJOExrghLZ6jdxjWnydspoWlpGT9BqD+vDjHZ4fYR+eFd1t0/dcl08hcm
 IOCG038XBbvHw==
Date: Thu, 27 Feb 2025 12:45:38 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250227124538.7a2191e0@foz.lan>
In-Reply-To: <20250226153714.20c57efe@imammedo.users.ipa.redhat.com>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <9eeaabf88e7ddc4884633702b7bc419075975bc8.1740148260.git.mchehab+huawei@kernel.org>
 <20250226153714.20c57efe@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Em Wed, 26 Feb 2025 15:37:14 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 21 Feb 2025 15:35:10 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 

> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 3ac8f8e17861..8ab8d11b6536 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -946,9 +946,18 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >      build_dbg2(tables_blob, tables->linker, vms);
> >  
> >      if (vms->ras) {
> > -        acpi_add_table(table_offsets, tables_blob);
> > -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> > -                        vms->oem_id, vms->oem_table_id);
> > +        AcpiGedState *acpi_ged_state;
> > +        AcpiGhesState *ags;
> > +
> > +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,  
>                             ^^^ will explode if object_resolve_path_type() returns NULL
> > +                                                       NULL));  
> 
> it's also expensive load-wise.
> You have access to vms with ged pointer here, use that
> (search for 'acpi_ged_state = ACPI_GED' example)

Ok, but the state binding on ghes were designed to use ACPI_GED. I moved
the code that it is using ACPI_GED() to the beginning of v5 series,
just after the HEST table test addition.

With that, ACPI_GED() is now used only on two places inside ghes:

- at virt_acpi_build(), during VM initialization;
- at acpi_ghes_get_state().

If you want to replace it by some other solution, IMO we should do
it on some separate series, as this is not related to neither error
injection nor with offset calculation to get read ack address. 

> > +        if (acpi_ged_state) {  
> 
>                 hence, this check is not really needed,
>                 we have to have GED at this point or abort
> 
>                 earlier code that instantiates GED should take care of
>                 cleanly exiting if it failed to create GED so we would never get
>                 to missing GED here

I dropped this check on v5.

Thanks,
Mauro

