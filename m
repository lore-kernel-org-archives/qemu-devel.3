Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A802ACD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBVu-0007DT-ON; Wed, 13 May 2026 11:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wNBVe-00071J-DP
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wNBVa-0003Va-6S
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778686089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRpgOAZ7+0bePiQu9eN5bPZwH8rZureOkJxlzx2kRt0=;
 b=eoPU/TRFOD+SipEk95bmnVj2FsHsagQdJH2IiR9WofoWxcWxltv2RvF+QelNhUsSCX+BXF
 sRFBrBfwZ79Rzsl3ECN/rDY9V/6RnmXVBeqAsH4wzcPkcYYVLAx4ffidB2bPRjocEJsfJU
 uXr5owdoJ2jPZvkFPb8uubF4Hm2BkBM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-eLdmr3bfN5GgHtpkten0qQ-1; Wed, 13 May 2026 11:28:07 -0400
X-MC-Unique: eLdmr3bfN5GgHtpkten0qQ-1
X-Mimecast-MFC-AGG-ID: eLdmr3bfN5GgHtpkten0qQ_1778686086
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b90484c398cso590744766b.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778686086; x=1779290886; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vRpgOAZ7+0bePiQu9eN5bPZwH8rZureOkJxlzx2kRt0=;
 b=i40VohrRqUCr9IdZqTJbdmd6qOQcmXXB89xAh5BaSZ9zHrhgzJJCX+pB45DjcetDBa
 KRttwIXVJeke0XcXARXK3wUwXzDWCTUe08RbhjnTqZEQzq3WT9OLhq+tEOr5IfnwtZFz
 mMoxHZ10ZMlfqABa9BVNw+JwRKMy2E0xtd9ZHXDFg7yKOVIpEb/FObBoBzHlkH3AZtiN
 0Ox2e1JAsoGeDryAOlMoHc1wvRF8xgVEUXCQxg3VCqwo/0mN6u9OJ1WWVx3X/RZHsMX0
 +zCfXkkMdkZWD5/upmn+vU7oOs7WgxxjFgEocL9tf+c1sqcA+qa0DgQFW8F0pWIgUIH7
 6GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778686086; x=1779290886;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vRpgOAZ7+0bePiQu9eN5bPZwH8rZureOkJxlzx2kRt0=;
 b=RiE364zXfVhW5mLLMYKy1g0EVGF+IE7FrYxwOD1xmhOqguG+yFOSTHTQKoWBDsb69p
 qbFjRSD54KaggrKqIv1So8cevnWsDwdg2iBjcWfRu9BJMK5XDZKmvteeail82HS+hmyt
 ZkkzVInIfNZSVuBpP0ofCQBuddmDm74Of1ygkeRVTYo/7HG2yOryKSCaH2ovqo5LLHSO
 iFmp7xXELYwL7SGEzNjcMqL5aGLWXlNM5jdcUAf3x+sEjH4FeLBAvt3NMUsBMFgPcWk4
 /k483Lgbusx+TS+T2BKJvDJULnLHLuJIQUDCmGoJutkOcQNqkIcUyCECworoSTPWd/EK
 dvgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/t2Gvjrzr+hTUjgq78l8B7mFUo+vgtwu7m2O2NVCjZZ/2hPu2lNNbObwK+6ZCiuOwmC3xM6htHtukB@nongnu.org
X-Gm-Message-State: AOJu0YxrXNod1XT72A965iT9iqXxJITl3JD2LuAS05MGvihpcwptuIdX
 Llohe8BkkUtu1G0EtGd7HfSSZRNFq8QiKpta9nx+bTOTd3bLFFnGw8OgQlirI4o2SuUUq86PYA/
 v55oDi80K0Cqo6m10yk8JCgb0JZT7X5pzKy/DKfQflMusogmNxO66SyO+
X-Gm-Gg: Acq92OGZWCxDj5P9+kpO9FHIkXkTxn/No7tMzhGUEL7eHSYdBigwCL1j+DZQqqRndUX
 L77AyXTXfB6ej8blD5qAEDq8xUSNwo3/IQ/px1OSsTCvpzH5BICm+h/UE6GvXn/yrleusM9N27N
 /IFE34c7oa6YUpcC6xdPceD1/+e6kxJJCJdU1S4M7eKFCeIJ1QbzYLeB1LXs01qprOIA3oUywNt
 SM0TBDbCO+gjZKJRkOcb5WAnodztpP23+Yc9Ut4fo8gTclKLlt2grGeBzivlRdCxmqSzpT/jB7o
 z4PC5Xu1M1m79LRiBjnLxfM7/6XpduIR6ztscz5xWQQ0hJdt1GW0+vYshN+D9pGojF7Fyw5KvaO
 J1k3W7KUeLaR3xULjdA/1vc6WeqYmFTD4JCIaL7r3
X-Received: by 2002:a17:907:388b:b0:bd1:d4e8:42a4 with SMTP id
 a640c23a62f3a-bd3bf77aca8mr270891866b.11.1778686086032; 
 Wed, 13 May 2026 08:28:06 -0700 (PDT)
X-Received: by 2002:a17:907:388b:b0:bd1:d4e8:42a4 with SMTP id
 a640c23a62f3a-bd3bf77aca8mr270881166b.11.1778686084558; 
 Wed, 13 May 2026 08:28:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-458b3664e3esm26206076f8f.3.2026.05.13.08.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:28:04 -0700 (PDT)
Date: Wed, 13 May 2026 11:28:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 anisinha@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, philmd@linaro.org, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 03/21] x86: q35: generate WDAT ACPI table
Message-ID: <20260513112745-mutt-send-email-mst@kernel.org>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-4-imammedo@redhat.com>
 <agSdBwKQh3C9UgdF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agSdBwKQh3C9UgdF@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 13, 2026 at 11:47:19PM +0800, Zhao Liu wrote:
> On Tue, Mar 03, 2026 at 10:25:14AM +0100, Igor Mammedov wrote:
> > Date: Tue,  3 Mar 2026 10:25:14 +0100
> > From: Igor Mammedov <imammedo@redhat.com>
> > Subject: [PATCH v2 03/21] x86: q35: generate WDAT ACPI table
> > 
> > It will generate WDAT table [1] customized for TCO watchdog.
> > This allows Windows guests (Windows Server 2008/Vista+) to
> > use TCO watchdog using built-in generic driver, which
> > alleviates need to install vendor specific drivers.
> > 
> > Given that enabling it might change guest behaviour
> > (both Windows/Linux) the feature is disabled by default.
> > 
> > Users that need it can enable the feature with
> > following CLI option.
> >     -machine wdat=on
> > 
> > 1)
> >    "Hardware Watchdog Timers Design Specification"
> >     https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  include/hw/acpi/wdat-ich9.h | 15 +++++++
> >  hw/acpi/meson.build         |  3 +-
> >  hw/acpi/wdat-ich9-stub.c    | 15 +++++++
> >  hw/acpi/wdat-ich9.c         | 90 +++++++++++++++++++++++++++++++++++++
> >  hw/i386/acpi-build.c        | 12 +++++
> >  5 files changed, 134 insertions(+), 1 deletion(-)
> >  create mode 100644 include/hw/acpi/wdat-ich9.h
> >  create mode 100644 hw/acpi/wdat-ich9-stub.c
> >  create mode 100644 hw/acpi/wdat-ich9.c
> 
> ...
> 
> > +void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
> > +                     const char *oem_table_id, uint64_t tco_base)
> > +{
> > +    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
> > +                        .oem_table_id = oem_table_id };
> > +    struct AcpiGenericAddress tco_rld =  TCO_REG(tco_base, 0x0, 16);
> > +    struct AcpiGenericAddress tco2_sts = TCO_REG(tco_base, 0x6, 16);
> > +    struct AcpiGenericAddress tco1_cnt = TCO_REG(tco_base, 0x8, 16);
> > +    struct AcpiGenericAddress tco_tmr =  TCO_REG(tco_base, 0x12, 16);
> > +
> > +    acpi_table_begin(&table, table_data);
> > +    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
> > +    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
> > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
> > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
> > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
> > +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> > +    /*
> > +     * limits/resolution are defined by ICH9 TCO spec
> > +     */
> > +    build_append_int_noprefix(table_data, 0x258, 4);/* Timer Period, ms */
> > +    build_append_int_noprefix(table_data, 0x3ff, 4);/* Maximum Count */
> > +    build_append_int_noprefix(table_data, 0x4, 4);  /* Minimum Count */
> 
> Spec said: The time-out period before the WDT fires is recommended to be at
> least 5 minutes and is required to be less than 4,294,967,296 count
> intervals.
> 
> Here we encode 0x4 * 0x258 = 2400ms, less than 5 minutes. But I
> understand because "5 minutes" is just "recommanded" by spec, so 2400ms is
> okay.
> 
> LGTM,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


maybe a comment why it's shorter?


