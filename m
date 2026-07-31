Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D19C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpjsy-0001nL-QQ; Fri, 31 Jul 2026 05:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpjsx-0001nB-QX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpjsw-0004r3-7w
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785491432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KA/Voh0KXZYqMjc8S+t9OLapCdIVsZxOpfxpuak6XVk=;
 b=KC2BVMx5RGnaTwVSIQLHy1S2df2c/JtrwF0g1c/85paVMS+UXOq7ThGuBV0Kcj5KvaXazQ
 Ip3tVAt3Hd3d9ijoFADUIjDMzEzzbnsmHxnKJAwQpGitJBDCs0gaeGfYEcU2uqpnkIrLzt
 aNh4enPSJae2Kc3iHs1FdMWWdo8lC5E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-UImU8a1fNaS8c7WW2pjk-Q-1; Fri, 31 Jul 2026 05:50:31 -0400
X-MC-Unique: UImU8a1fNaS8c7WW2pjk-Q-1
X-Mimecast-MFC-AGG-ID: UImU8a1fNaS8c7WW2pjk-Q_1785491430
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6983e384c66so751027a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 02:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785491430; x=1786096230; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KA/Voh0KXZYqMjc8S+t9OLapCdIVsZxOpfxpuak6XVk=;
 b=kwVQrf2ONqTAprhsI2IZ7+S73SrN3g75LmjNc5F0PWtqm2g3OPMxezeplScPeMaYRm
 txnf3RK7/14J3fJ/TFWWMUzEVNvNxA8sVlhd2q4JIobte8r2aT+gjeW9edFWOJWX1lv7
 Uqwio1Ysgj5CopEL+jVDKLjD4EnUVT26qXAuBKzcdyT2WpkKTVqZ6PklrSsV+npVeoNn
 iLhEhQShgmNKQokLULWCBthfBqWnUicap28DWxVDeKVZ6fdNrBqdSxmSagJmRqqk7XX8
 xKuTKjnMh5N0Gby6PP/rEflP9h0tm5HMiNM59N0UzbJVEVCilc6xL9C6gp/mQms8CVw6
 0KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785491430; x=1786096230;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KA/Voh0KXZYqMjc8S+t9OLapCdIVsZxOpfxpuak6XVk=;
 b=fzpTRgN0fAonsPOQITyz9iWe+m/Im2yDYACnGfAgplsMASjAm/p3n3yAz8gY1IKYMq
 Z8g9OaVFmTipm17COR69+VjhZ4iH0O64ez6CbdBl/z8TVwMlfDvlGwoEqnqohBysPrHv
 5wuIJBkzBcPy+tbcCsOIfTIZBx5+hPHeyKvlmjZ5AGp0CL6B5czj0vNA0RBk2WkGTC/Y
 GzOG+F/sWW+Etx+O7ZY98BI34qBVKse4EDJnn7QBzvtqQtEAIi1TLP2i1F+065eEwcJ0
 yasbJm7za5WNknyaTW/JuZ+sr2Y+yHXGy4QIquh0n6DOqvTr7Vy5nZuaQFBf3oEyeJUy
 jMhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrS7vyotJuqHioRI/hdVd0r/hL/F9zYG7UX44dZbCL0P0nspZMOZGzAESda1SfntVZN+pAOJBN1/Uff@nongnu.org
X-Gm-Message-State: AOJu0YzNcLBy453WeWqtNGsw7Bj8K0bPJkA+FOG3NIv+WBAY2LWl4lqS
 SALePE07luhFaqh73VI40/FHWR26Ge3az4ar12X0rzZLMag9HloBM3RzYdlhEJ96S8WBh3/YHZ8
 wXFiVywb8VFE3QDzJ3n2/BeN7Tvre9goqr1JbaCiwx+LbOUGN22Vrxw3e
X-Gm-Gg: AR+sD108WoeTZly/e+cj+L37cFStoF1/f2fmJWYlAX8eMyHI9BpMTwSf2Z8ZwlNwYMd
 SB+0k8WWsqursjg++FyTpX4JVE7obyfkF5pJbPoxJk6hU4xK6HUveXXvJg+Gam1egjXeWcf2CpL
 W46NRjQYFzBEEsb7vxKEz4MTwXp/xk9M9tMuFleIy6b7C24e+aTWTJzKj6+hLNyMXdTXJz5AnAY
 6+y5gusEI4INRkNlJh93vMNgZmBJAU3IG9/eSYHKcWBvgOzsrZa4X3EOumzaEdbI8RskNQSYHoy
 x4Drw5VXOZYzkgHR2z5kkicb8Lqqo5Ow05QgDqHND9tGv7hgt6G4AGGtv4KILAlE3Xuav+QLDVn
 tDtuQcvPfnwxv9ySRTgIhxO0=
X-Received: by 2002:a05:6402:42d0:b0:687:7fa4:faa0 with SMTP id
 4fb4d7f45d1cf-6a098d097e7mr723638a12.23.1785491429869; 
 Fri, 31 Jul 2026 02:50:29 -0700 (PDT)
X-Received: by 2002:a05:6402:42d0:b0:687:7fa4:faa0 with SMTP id
 4fb4d7f45d1cf-6a098d097e7mr723626a12.23.1785491429425; 
 Fri, 31 Jul 2026 02:50:29 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c5b11d2sm767290a12.8.2026.07.31.02.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 02:50:28 -0700 (PDT)
Date: Fri, 31 Jul 2026 05:50:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
Message-ID: <20260731054920-mutt-send-email-mst@kernel.org>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511123937.32743-5-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 06:09:33PM +0530, Sairaj Kodilkar wrote:
> Currently, build_amd_iommu() uses "addr" property to build the device ID for
> IOMMU device and advertise it throught IVRS. But this property does not encode
> IOMMU bus. This will be a problem if IOMMU is attached to different bus.
> Hence use iommu pci device which provides bus, to build the IOMMU device ID.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

But is this called after firmware has enumerated the pci bus?
And I guess OS better not change that bus number eh?

> ---
>  hw/i386/acpi-build.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index e4ad01eec037..718e3f546b18 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1752,10 +1752,13 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>                  const char *oem_table_id)
>  {
>      AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
> +    PCIDevice *iommu_dev = &(s->pci->dev);
>      GArray *ivhd_blob = g_array_new(false, true, 1);
>      AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
>                          .oem_table_id = oem_table_id };
>      uint64_t feature_report;
> +    int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
> +    uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
>  
>      acpi_table_begin(&table, table_data);
>      /* IVinfo - IO virtualization information common to all
> @@ -1816,9 +1819,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>      /* IVHD length */
>      build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
>      /* DeviceID */
> -    build_append_int_noprefix(table_data,
> -                              object_property_get_int(OBJECT(s->pci), "addr",
> -                                                      &error_abort), 2);
> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>      /* Capability offset */
>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>      /* IOMMU base address */
> @@ -1850,10 +1851,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>  
>      /* IVHD length */
>      build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
> +
>      /* DeviceID */
> -    build_append_int_noprefix(table_data,
> -                              object_property_get_int(OBJECT(s->pci), "addr",
> -                                                      &error_abort), 2);
> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>      /* Capability offset */
>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>      /* IOMMU base address */
> -- 
> 2.34.1


