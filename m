Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91778D6ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGISS-0002X6-UP; Wed, 27 Nov 2024 08:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGISL-0002WJ-Dy
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGISJ-0005de-Ij
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDAmCEctBmZZ9OqWpHIthEdzVNElITChZj4pdstB/po=;
 b=R0f5C1RvrSI2eINc5czjDoXjFSD+EXx9AzYpsXiX0PnmPa121m9NvzFcTs/e55oeDno8Gu
 NDDf6V6dDLZX2F5VbST8mA4VvV6M9h1zKj+GYdn4fzXQCpNF0CjTHW/k7c20DCdETCe7wx
 +UVkFTIAiISJ03g3K/64y5kmndLOgag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-6SzZL5xiMhylhILVM-4htA-1; Wed, 27 Nov 2024 08:51:43 -0500
X-MC-Unique: 6SzZL5xiMhylhILVM-4htA-1
X-Mimecast-MFC-AGG-ID: 6SzZL5xiMhylhILVM-4htA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4349e97bfc4so33748455e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715503; x=1733320303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDAmCEctBmZZ9OqWpHIthEdzVNElITChZj4pdstB/po=;
 b=YOY/asGUsMtUJAZlsD3gjKVTRXFr+M7A9+LAQHpa4ZKn88AIu+57mYH+uyPnIDfbT3
 VWoACdVjypPUzfuWXl5r/qHkx1mBUsa+cZCWVeMVmGp8M2DeCZw1xC+UDSDeKNt/Y/Rt
 q6alBTgdz3rQiiRbFN024a4dfA2Bhh0GnzhpRgsFkM50RRCjLOSyx2El80nUoH0kl67F
 1XW8y9Fk41doP0PnBnMgEeoSH8E9VAWRq1BEMCzjLOzQ3zY8UXknBHnzmweVEL8qfsAw
 9uilChJ5euP4ovd8CjPyrCCpZOiD1KsUjmZs0cKExOfV7ZxtK60xqAHJHS4CiU2AxG01
 C/Ww==
X-Gm-Message-State: AOJu0YwwkkujA1t76PCh5Uh+KlrmI/5l4dEOcnw06xu3Qd8jGZ+mt/NI
 hjB7AShWqmuFTiLrg9snfvTQCNnjmkcpTU2PMhQ6y4Ge444Q5BmcOOSHHaGIgq12s9BFznAM5u7
 VCXe/4IIpdcbOxvGebVz8geiE9cUVWJneNVWbxzlBO0OQEeCM5P9X
X-Gm-Gg: ASbGncs3d7DehEbAvcjX1xyHJeI9LnDh4NQAgTucHVb3pHZJXogebArHN0PaGhBizKg
 rTVkPhQ7XuWGiASVDT0dIouM8Kxdgcdd+VEtFlwzOXtirymwizbgGGbrxHvydOWfpC6Fh4HXhNX
 EXPwPl4YmvlGadXLCGGDIwxSdzsKLK2IQxtIzRmVZJ/U/IfRm/yVIhwGfyzV2kNeWMMpepokkjy
 2eEgVzdkijZmy7NwgjVGGStyXxA6xrPZuHlicOhy5j8
X-Received: by 2002:a05:600c:3ba5:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-434a9df7c63mr25008685e9.28.1732715501189; 
 Wed, 27 Nov 2024 05:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlX+cXT3mj9jqYcH4pbF80551skp01CuHwKfxQ3YktkK7evaLHrQ/JqjE0GZAqNPiwkhZzoQ==
X-Received: by 2002:a05:600c:3ba5:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-434a9df7c63mr25007695e9.28.1732715499391; 
 Wed, 27 Nov 2024 05:51:39 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e5c85sm21667635e9.36.2024.11.27.05.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:51:38 -0800 (PST)
Date: Wed, 27 Nov 2024 08:51:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, salil.mehta@huawei.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com,
 anisinha@redhat.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, gustavo.romero@linaro.org
Subject: Re: [PATCH 0/7 for-9.2] Fix broken cpu hotplug after migration
Message-ID: <20241127085122-mutt-send-email-mst@kernel.org>
References: <20241112170258.2996640-1-imammedo@redhat.com>
 <20241127142646.15fa9a36@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127142646.15fa9a36@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 27, 2024 at 02:26:46PM +0100, Igor Mammedov wrote:
> On Tue, 12 Nov 2024 18:02:51 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > 1st 4 patches are fixing regression and getting rid of not needed changes
> > that were merged out of context (ARM CPU hotplug) without proper review,
> > by simply reverting offendining patches to keep history clean as patches
> > not 9.2 material to begin with.
> > 
> > The rest [5-7/7] are not tested RFC (not for merging to 9.2) for how problem
> > could be dealt with and could be adopted/changed for the future ARM CPU hotplug
> > series. 
> > 
> > Igor Mammedov (6):
> >   Revert "hw/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug
> >     states"
> >   Revert "hw/acpi: Make CPUs ACPI `presence` conditional during vCPU
> >     hot-unplug"
> 
> ping
> 
> Michael,
> are you going to pick it up for 9.2?


yes, I am testing a pull as we speak.

> 
> >   tests/acpi: update expected blobs
> >   acpi: cpuhp: add option to AML genrator to opt-in to always present
> >     vCPUs
> >   acpi: cpuhp: use 'realized' status of vCPU to check if CPU is enabled
> >   acpi: cpuhp: preserve always present vCPUs on unplug
> > 
> > Salil Mehta (1):
> >   qtest: allow ACPI DSDT Table changes
> > 
> >  include/hw/acpi/cpu.h                         |   5 +-
> >  include/hw/core/cpu.h                         |   2 -
> >  hw/acpi/acpi-cpu-hotplug-stub.c               |   3 +-
> >  hw/acpi/cpu.c                                 |  72 +++++-------------
> >  hw/acpi/cpu_hotplug.c                         |   2 +-
> >  hw/acpi/generic_event_device.c                |   2 +-
> >  tests/data/acpi/x86/pc/DSDT                   | Bin 8560 -> 8526 bytes
> >  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8471 -> 8437 bytes
> >  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9885 -> 9851 bytes
> >  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15431 -> 15397 bytes
> >  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9024 -> 8990 bytes
> >  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10214 -> 10180 bytes
> >  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8511 -> 8477 bytes
> >  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5067 -> 5033 bytes
> >  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8632 -> 8598 bytes
> >  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9919 -> 9885 bytes
> >  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8418 -> 8384 bytes
> >  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8566 -> 8532 bytes
> >  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12353 -> 12319 bytes
> >  tests/data/acpi/x86/q35/DSDT                  | Bin 8389 -> 8355 bytes
> >  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8406 -> 8372 bytes
> >  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9714 -> 9680 bytes
> >  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8668 -> 8634 bytes
> >  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8435 -> 8401 bytes
> >  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12002 -> 11968 bytes
> >  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12947 -> 12913 bytes
> >  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33804 -> 33770 bytes
> >  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8853 -> 8819 bytes
> >  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13180 -> 13146 bytes
> >  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10043 -> 10009 bytes
> >  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8464 -> 8430 bytes
> >  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8477 -> 8443 bytes
> >  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8406 -> 8372 bytes
> >  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9748 -> 9714 bytes
> >  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9519 -> 9485 bytes
> >  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13242 -> 13208 bytes
> >  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8269 -> 8235 bytes
> >  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8247 -> 8213 bytes
> >  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8395 -> 8361 bytes
> >  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8490 -> 8456 bytes
> >  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12947 -> 12913 bytes
> >  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33804 -> 33770 bytes
> >  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8995 -> 8961 bytes
> >  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9021 -> 8987 bytes
> >  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18623 -> 18589 bytes
> >  tests/data/acpi/x86/q35/DSDT.viot             | Bin 14646 -> 14612 bytes
> >  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35752 -> 35718 bytes
> >  47 files changed, 29 insertions(+), 57 deletions(-)
> > 


