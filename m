Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C009C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 05:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sepu4-0001V7-M2; Fri, 16 Aug 2024 01:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sepu3-0001Rc-H1
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:53:35 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sepu1-0000gX-0V
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:53:35 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0C4E1CE0FFC;
 Fri, 16 Aug 2024 05:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1A2C32782;
 Fri, 16 Aug 2024 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723787609;
 bh=LWRRIA8wOeT0HTfKuLc/si+HYdOOXvHvaOnkPiGSYaY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E9FfHys3oOHsG3AabTuPIaj1EI+PmRSANhkHKbZ6CC36IpFsz1idJSIWiaedCIXcD
 5Lb6w4N50jOO1WK4hE5tsn0LPPEFFs3SWYuBbBf9brV6vh8owUMKYgIEbg0kKhNPTt
 VdD8EZG+E8QZMM2e4/v9QmYJ/5WMHVru65fzBg7MzJv1LolLxgFVrpdL+7mdAnx5dn
 fZwwldNqo++AAWO3jd/ytF2//EJfAs3nAPW8mBIc9oPhQX0tP4I/DxhX9z74vqKP0u
 1TT6FqCe9C4NtfpxRvHMJy/jyAnxEOMHY2gnWq4pCJFnPplY+kZ8uQ1muEoCu8eCpM
 uALvz1bwmc8dw==
Date: Fri, 16 Aug 2024 07:53:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, <linux-kernel@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 01/10] acpi/generic_event_device: add an APEI error
 device
Message-ID: <20240816075324.19d13670@foz.lan>
In-Reply-To: <20240814133321.00006401@Huawei.com>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
 <0be6db8d06b3abab551f24dcc645d46d72d3f668.1723591201.git.mchehab+huawei@kernel.org>
 <20240814133321.00006401@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

Em Wed, 14 Aug 2024 13:33:21 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 14 Aug 2024 01:23:23 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Adds a generic error device to handle generic hardware error
> > events as specified at ACPI 6.5 specification at 18.3.2.7.2:
> > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> > using HID PNP0C33.
> > 
> > The PNP0C33 device is used to report hardware errors to
> > the guest via ACPI APEI Generic Hardware Error Source (GHES).
> > 
> > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/acpi/aml-build.c                    | 10 ++++++++++
> >  hw/acpi/generic_event_device.c         |  8 ++++++++
> >  include/hw/acpi/acpi_dev_interface.h   |  1 +
> >  include/hw/acpi/aml-build.h            |  2 ++
> >  include/hw/acpi/generic_event_device.h |  1 +
> >  5 files changed, 22 insertions(+)
> > 
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index 6d4517cfbe3d..cb167523859f 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c
> > @@ -2520,3 +2520,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
> >  
> >      return var;
> >  }
> > +
> > +/* ACPI 5.0: 18.3.2.6.2 Event Notification For Generic Error Sources */  
> 
> Given this section got a rename maybe the comment should mention old
> name and current name for the section?

ACPI 6.5 has the same name for the section:

	18.3.2.7.2. Event Notification For Generic Error Sources

	An event notification is recommended for corrected errors where latency 
	in processing error reports is not critical to proper system operation. 
	The implementation of Event notification requires the platform to define
	a device with PNP ID PNP0C33 in the ACPI namespace, referred to as the
	error device. 

Just section number changed. IMO, it is still good enough to seek for
it at the docs.

Btw, in this specific case, the best is to use the search box of
Sphinx html output and seek for PNP0C33 ;-)

> 
> > +Aml *aml_error_device(void)
> > +{
> > +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> > +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> > +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > +
> > +    return dev;
> > +}
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 15b4c3ebbf24..1673e9695be3 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
> >      ACPI_GED_PWR_DOWN_EVT,
> >      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> >      ACPI_GED_CPU_HOTPLUG_EVT,
> > +    ACPI_GED_ERROR_EVT  
> 
> trailing comma missing.

I'll add.

Thanks,
Mauro

