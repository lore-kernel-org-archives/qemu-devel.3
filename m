Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BECC55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpxAh-0001lm-PG; Fri, 31 Jul 2026 20:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpxAg-0001le-0r
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpxAe-0007vC-3K
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785542502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/s0ZwxACe1q2NMD99WoL81ObRltFpIQLThtpcCAyLdU=;
 b=ioqzMGx7ZhRytni/Xz+Kf/3FyevTo+/05KG3vYWVDoaR2urgi6ttX4LIj6UGsxJcvQ40mI
 Ll1KjK2HGPbllxwEr5pUxoPuXhws6ES+c/AC81D6nebx0hRDOgxjXAg2oUB73Rvxjl7am8
 TS7ntEzlbvmg62PrZtqRMfkYw1uImj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-hcMJIuE1Mxu-p75Sg7dFtA-1; Fri, 31 Jul 2026 20:01:40 -0400
X-MC-Unique: hcMJIuE1Mxu-p75Sg7dFtA-1
X-Mimecast-MFC-AGG-ID: hcMJIuE1Mxu-p75Sg7dFtA_1785542499
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955fd77c18so1664445e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785542499; x=1786147299; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/s0ZwxACe1q2NMD99WoL81ObRltFpIQLThtpcCAyLdU=;
 b=tRv0BnREeFnnX8828I3enZpwUcogwxV0JFLtejLMiLLYFslkGyZBhz1pCkwHmbqwES
 q6O0wqjlGu++M/QEXKIfAosb1qHBzBGqvmzNfVJGKYICcPEhwOcCbsK0nLHN0xXKDWeA
 RVUIn1/ocFpddsIQhu0ZmNvarPiTszUN3G7ocX6j7umNv10evry4a4Rl3c4pa978sM8e
 63YchszBeXYh+muKtbDMGrHhKiAu87cE3OruL3bsN108BdiZp+tGg/uKpLZISj/PKSjo
 /raYQMtnbub1a0vWgAIh+4AqECUbe0gs6BHr0ubVu1hPjqnuTEcDNUeXcLwpjuCM7ZCm
 BdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785542499; x=1786147299;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/s0ZwxACe1q2NMD99WoL81ObRltFpIQLThtpcCAyLdU=;
 b=CCgKSxbqBuWI2m6U+znkcF47DZt7jIJIz/ww41dJrLg9yLZ6qkiV9vLrQ+chg14hMf
 NnhAcUVW15mId7bzXM2wld+cHCbA3L8KpEqwh4CAKNiXZoo9QrKNHZW6XwR68tpDorH8
 tOd1VSbiKQwLMURpJzukNv4K24AuIvJGSGUdz0XzOFAW87vD0+xfqyOGAwu5eSGAFxkn
 FQkySlWJ6DIBfHpjnSq+QcDKTOh4jE2oUzkZh55QSBzKprXO4j6wOSSbqxhEziYBAsXa
 uzAgtfhk3CI81YH+gro5M4NLxUe/CYNaCMm1UPWD9LDK8ob3pFvR9R0h8KuRBVEYq5JH
 48jQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoByUTW9RwpELz5BF6zWypHDQaiOp5FC9tpR1R1+aWWyQZcQs5R7DaR9rR+dpPkdhF5qu3wsOW1RdQn@nongnu.org
X-Gm-Message-State: AOJu0YzK/5IxtzfNvTThKW4BK8EwPAY6WW9yK3A6iE3+EegSoMWGZThT
 ByusslJ8qTPpBvfQ7KSd9R1M1EKKpcLg+d/ai+EYoqzlEyccfTQBUJtVTTohPNXLHWj9N2rKS2G
 7QkkNW9ktc+ObPmcF3FVn+WkpL7gasccRUjIjl93ZhjRa1noUi9ix6q+5
X-Gm-Gg: AR+sD12yJbxFnjgAiSUVvszMiQYsdV2p//ez7v2sX5G69Xu8dnXjt7r3cVKkaeKXYQK
 Bfg2cKjDkQYgkD/rHtzWLCruK0HE8T422Z0Mh7KVbWFmV6Z2Mx3rbKMrcIyvpj3JycmClJUDYLn
 Dy7S1BYn9fvyPWQiIxaYGUmCVnFIhDqmMVnkr4Nxo2DIypOkVTs0AJhOiu3QH4qKG52UmocaTwA
 42ZZCOxyzYoM3Fv1BovgYlMGcw2bvT4A1mlwBT/QtJO+nwA7O1Y74mYnbhd73bA4KObGRR69Ofc
 sdAJVZPkLZlZZhi86tIYofaRkPq+xlruQogLGCZcWCDF7QjKzHhIJppILbLV8R7yZm57QvSHqAK
 SF/7w1mCO6o8xk7INkegCqLE=
X-Received: by 2002:a05:600c:c1c8:10b0:498:3ba:6318 with SMTP id
 5b1f17b1804b1-4980c6a6cefmr2239535e9.34.1785542499468; 
 Fri, 31 Jul 2026 17:01:39 -0700 (PDT)
X-Received: by 2002:a05:600c:c1c8:10b0:498:3ba:6318 with SMTP id
 5b1f17b1804b1-4980c6a6cefmr2239185e9.34.1785542499013; 
 Fri, 31 Jul 2026 17:01:39 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807eb1256sm2831565e9.2.2026.07.31.17.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 17:01:37 -0700 (PDT)
Date: Fri, 31 Jul 2026 20:01:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
Message-ID: <20260731200122-mutt-send-email-mst@kernel.org>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
 <20260731054920-mutt-send-email-mst@kernel.org>
 <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
 <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 31, 2026 at 05:47:18PM -0400, Alejandro Jimenez wrote:
> 
> On 7/31/26 8:32 AM, Sairaj Kodilkar wrote:
> > On 7/31/2026 3: 20 PM, Michael S. Tsirkin wrote: > On Mon, May 11, 2026 at
> > 06: 09: 33PM +0530, Sairaj Kodilkar wrote: >> Currently, build_amd_iommu()
> > uses "addr" property to build the device ID for >> IOMMU device and
> > advertise it
> > 
> > 
> > On 7/31/2026 3:20 PM, Michael S. Tsirkin wrote:
> >> On Mon, May 11, 2026 at 06:09:33PM +0530, Sairaj Kodilkar wrote:
> >>> Currently, build_amd_iommu() uses "addr" property to build the device ID for
> >>> IOMMU device and advertise it throught IVRS. But this property does not encode
> >>> IOMMU bus. This will be a problem if IOMMU is attached to different bus.
> >>> Hence use iommu pci device which provides bus, to build the IOMMU device ID.
> >>>
> >>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> >>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> >> 
> >> But is this called after firmware has enumerated the pci bus?
> >> And I guess OS better not change that bus number eh?
> 
> The above line sounds fairly threatening :) so I dug a bit more into the
> details.
> Short story: I tested placing the IOMMU behind a PCI bridge, which the
> implementation currently allows, and the guest can (easily) change the bus
> number. That changes the IOMMU BDF, so the DeviceID encoded in IVRS becomes
> incorrect.
> 
> The spec doesn't forbid the above scenario, but "strongly recommends":
> 
> • An IOMMU should be a root-complex device (i.e., appear directly on the
> bus at the top of the PCI tree hierarchy).
> • Some system software may prohibit an IOMMU from appearing under a
> PCI-to-PCI bridge.
> 
> (from Section 4.5 Software and Platform Firmware Implementation Issues)
> 
> While I don't know if that is the case in all HW implementations, my
> Genoa/Zen4 system does follow the recommended topology i.e. it exposes all
> of its 8 IOMMU functions directly on a PCI root bus, with no bridges.
> 
> So I think a reasonable choice is to enforce that an AMDVI-PCI device must
> always be directly attached to a PCI root bus. There is precedent for this
> in the virtio-iommu implementation already, the code change would be
> basically the same in amdvi_pci_realize(), see:
> 
> e72cfabf4ef2 ("hw/virtio/virtio-iommu-pci: Enforce the device is plugged on
> the root bus")
> 
> MST: does this address your concern?

Indeed, it is.

> Sairaj: Am I missing anything, perhaps from your unpublished patches, that
> makes this approach non-viable?
> 
> Thank you,
> Alejandro
> 
> > 
> > Hi Michael
> > 
> > Yes, the ACPI function is called two times -- during qemu initialization
> > and firmware writes. During first call, bus numbers are 0 and during
> > second call, IVRS is created with bus number. This second IVRS
> > overwrites the first one.
> > 
> > Thanks
> > Sairaj
> > 
> >>> ---
> >>>  hw/i386/acpi-build.c | 12 ++++++------
> >>>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >>> index e4ad01eec037..718e3f546b18 100644
> >>> --- a/hw/i386/acpi-build.c
> >>> +++ b/hw/i386/acpi-build.c
> >>> @@ -1752,10 +1752,13 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
> >>>                  const char *oem_table_id)
> >>>  {
> >>>      AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
> >>> +    PCIDevice *iommu_dev = &(s->pci->dev);
> >>>      GArray *ivhd_blob = g_array_new(false, true, 1);
> >>>      AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
> >>>                          .oem_table_id = oem_table_id };
> >>>      uint64_t feature_report;
> >>> +    int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
> >>> +    uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
> >>>  
> >>>      acpi_table_begin(&table, table_data);
> >>>      /* IVinfo - IO virtualization information common to all
> >>> @@ -1816,9 +1819,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
> >>>      /* IVHD length */
> >>>      build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
> >>>      /* DeviceID */
> >>> -    build_append_int_noprefix(table_data,
> >>> -                              object_property_get_int(OBJECT(s->pci), "addr",
> >>> -                                                      &error_abort), 2);
> >>> +    build_append_int_noprefix(table_data, iommu_devid, 2);
> >>>      /* Capability offset */
> >>>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
> >>>      /* IOMMU base address */
> >>> @@ -1850,10 +1851,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
> >>>  
> >>>      /* IVHD length */
> >>>      build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
> >>> +
> >>>      /* DeviceID */
> >>> -    build_append_int_noprefix(table_data,
> >>> -                              object_property_get_int(OBJECT(s->pci), "addr",
> >>> -                                                      &error_abort), 2);
> >>> +    build_append_int_noprefix(table_data, iommu_devid, 2);
> >>>      /* Capability offset */
> >>>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
> >>>      /* IOMMU base address */
> >>> -- 
> >>> 2.34.1
> >> 
> > 


