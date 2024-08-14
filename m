Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDBDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 17:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seHam-0003lj-5V; Wed, 14 Aug 2024 13:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1seHag-0003Uj-AQ; Wed, 14 Aug 2024 13:15:18 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1seHad-00076M-Cj; Wed, 14 Aug 2024 13:15:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 65DF861B24;
 Wed, 14 Aug 2024 17:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F8C4AF0F;
 Wed, 14 Aug 2024 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723655713;
 bh=CNLvWdFSpWetfnrk3/sCACP6QDOdIi1nd9Px9y/UFMs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TfzfbRKD9wGn4D9M8fk4CCETgUFtL32SrbiMFdKE23lCkGfwf1rDw55LhbzMvFBrT
 EgdUBKJ3s6013h0AiFvGZ31h4DL306mX7ipmx/kgLFP+FXQUhBZPEPKzTZoqRpTYXm
 kvNM4Fuo6gi+MmF1P9/KaxhpzPiqjTREwkdgbSP+R+YYswCBTfT3YfjQGRsfQyKZ0d
 g8WdX2pvpPsNS5K8lwY5VjMoG/rkLf+fQadbaz9t7//pKNCKrAy9ltNyfxcy+fh+6v
 ojvvVZN6XlBObYLsOXrzEBX25z9bdqs7K7PLsJ75lbXZ8IasDPqo7L78Oi7XSlpBAY
 vCucE9LlzDM1Q==
Date: Wed, 14 Aug 2024 19:15:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 04/10] qapi/acpi-hest: add an interface to do generic
 CPER error injection
Message-ID: <20240814191506.21894ac7@foz.lan>
In-Reply-To: <20240814145322.00002dcb@Huawei.com>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
 <c44e6c39e6cf95a738999b721cdf71e4887258a9.1723591201.git.mchehab+huawei@kernel.org>
 <20240814145322.00002dcb@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
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

Em Wed, 14 Aug 2024 14:53:22 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 14 Aug 2024 01:23:26 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Creates a QMP command to be used for generic ACPI APEI hardware error
> > injection (HEST) via GHESv2.
> > 
> > The actual GHES code will be added at the followup patch.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> A few trivial things from a quick glance at this
> (to remind myself of how this fits together).
> 
> > diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> > index e07d3204eb36..73ffbb82c150 100644
> > --- a/hw/acpi/Kconfig
> > +++ b/hw/acpi/Kconfig
> > @@ -51,6 +51,11 @@ config ACPI_APEI
> >      bool
> >      depends on ACPI
> >  
> > +config GHES_CPER
> > +    bool
> > +    depends on ACPI_APEI
> > +    default y
> > +
> >  config ACPI_PCI
> >      bool
> >      depends on ACPI && PCI
> > diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> > new file mode 100644
> > index 000000000000..92ca84d738de
> > --- /dev/null
> > +++ b/hw/acpi/ghes_cper.c
> > @@ -0,0 +1,33 @@  
> 
> > +#include "qapi/qapi-commands-acpi-hest.h"
> > +#include "hw/acpi/ghes.h"
> > +
> > +void qmp_ghes_cper(const char *qmp_cper,
> > +                   Error **errp)  

Heh, with all code changes, this is not a lot simpler than before ;-)

I'll address it on a next spin.

> That's a very short line wrap.
> 
> > +{
> > +
> > +    uint8_t *cper;
> > +    size_t  len;
> > +
> > +    cper = qbase64_decode(qmp_cper, -1, &len, errp);
> > +    if (!cper) {
> > +        error_setg(errp, "missing GHES CPER payload");
> > +        return;
> > +    }
> > +
> > +    /* TODO: call a function at ghes */
> > +}  
> 
> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 419a97d5cbd9..99d12d69c864 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -23,6 +23,7 @@
> >  #define ACPI_GHES_H
> >  
> >  #include "hw/acpi/bios-linker-loader.h"
> > +#include "qapi/error.h"  
> Odd to have an include added with no other changes in file?
> Wrong patch maybe?  Or should it be included by a c file instead?

Removing it would cause a compilation breakage. It might be moved
to a c file, but patch 5/10 requires it at ghes.h, as it adds
this to ghes.h:

	void ghes_record_cper_errors(uint8_t *cper, size_t len,
        	                     enum AcpiGhesNotifyType notify,Error **errp);

So, instead of poking around moving this to/from .c/.h, I opted to
place it on its final place.

> >  #include "qemu/notify.h"
> >  
> >  extern NotifierList acpi_generic_error_notifiers;
> > diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json  
> 
> 



Thanks,
Mauro

