Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691D5C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 17:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcpeh-0000YP-0V; Tue, 28 Jan 2025 12:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tcpeU-0000Rr-Ge
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 12:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tcpeR-0008OP-9R
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 12:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738086320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zfqr89imXWDmMtnNPX5X8QpR+faPY8u+j0Hd9gtBUJ8=;
 b=KhHXPhwi28fQSP1ce+jI1ao3RboaVdoHNu6A3AvqjMancemH4xAoTH5zkpe3GfFS2XCg+a
 T8hZWM5B925GDGKZLGVWDaiwgEGPiFW4aSHkipmcF/1NjWt/tK33pnvTzR+njxUN0HQtkz
 AFPcwMWSEMZFmBhsNZTKqZqMytxaYoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-_ngsqHd9OPyfsVjNTprp3A-1; Tue, 28 Jan 2025 12:45:19 -0500
X-MC-Unique: _ngsqHd9OPyfsVjNTprp3A-1
X-Mimecast-MFC-AGG-ID: _ngsqHd9OPyfsVjNTprp3A
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso2264486f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 09:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738086318; x=1738691118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zfqr89imXWDmMtnNPX5X8QpR+faPY8u+j0Hd9gtBUJ8=;
 b=VaUbCNGVOjLPIPj3KjaobRbci6+Mp0Zxt6ABtf4HrpcG3xdJHVOuardyckqEY6Gwik
 YlotAxFfrgudN0ieca2i3d6XJY8a3PvpCE9Ddh9obd1e0vpcIGNycSl/1Dd90fZinLTI
 FZ1JVv5RQ9sor9EBsIEvRyDL804bh1tYXWHkzvTaMRVUP2JqGbh+HiMmZYij9r3k/st6
 h1P6bgiWslgz+SCZkWZiYH1ZyZbmwYPATculk+6z49rWvVM4XTehe0LYPeJwbOE212xM
 kzCoSWlQV5OdRSAmbj1gYpyCCpP3/Q6aTy+5VqJf5Ws0zS+JLVIR64tzV/LseRzy2p3D
 mAXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl765f5BZQKe1t1GWfsZZz0wvempspbUGVEN8Ru4inDTcVGJkaLQREwk/3BZQ30GcTR6pD5FoII694@nongnu.org
X-Gm-Message-State: AOJu0YxF67YoioklanqlFPpPfL0run3F6UaLCtPKkpA6oxTHws86wDnF
 afSyDIOLtkv2dc8uf2yvvRamww5mawBaPBZK/cYFTrTyFVNhlg1bSCiN4HvKkuO/Bw/HnHNOdSy
 KYx7qMARHXcIQ9aW+ACupZq7TvZecysf5KArryRFWfcfgEjBLF/Nt
X-Gm-Gg: ASbGncucoK0NuNCSHvHHJ0Fh6RRp475jWLTbi9sJ4kgPlcoa7TkTH125ypUGaU4BZ0n
 fNlihgWRwEZLvoPjHjW5+vURZyZFISx5oxnpgC0GfYmnv5nOSv4FOOpAwGnEJ8DoKmCR0aNPPIW
 GIADfr0JKTjUJqev41mgaKATu3jQs89bD298GdEKe1P0RVImi7r5Wd0YfYxU7Mi3pYNYP/+Wlhs
 WUXC6Tp+/VSOOQvkrN7Hvn0GW6t6mQVBfPoFm+tFmdNlo1Cu9+JPRKdGL/AoM/YSb5RjkLy8Q==
X-Received: by 2002:a05:6000:1287:b0:38a:4184:151c with SMTP id
 ffacd0b85a97d-38bf5675482mr37150656f8f.27.1738086318245; 
 Tue, 28 Jan 2025 09:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG05BrGR1VyaTRayiSZONOSSIJjJsyNyeB94bV2zt+0V+DLja+3X5VG0RIFVxSQXk8rhI68UQ==
X-Received: by 2002:a05:6000:1287:b0:38a:4184:151c with SMTP id
 ffacd0b85a97d-38bf5675482mr37150632f8f.27.1738086317802; 
 Tue, 28 Jan 2025 09:45:17 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ed:1cfa:28ca:8a9:c621:2a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c4a160ba3sm3010862f8f.18.2025.01.28.09.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 09:45:16 -0800 (PST)
Date: Tue, 28 Jan 2025 12:45:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] acpi/generic_event_device: add an APEI error device
Message-ID: <20250128124438-mutt-send-email-mst@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <41b6846394154ddac4d00c3644cd2de577d10115.1737560101.git.mchehab+huawei@kernel.org>
 <20250124133054.1f06579c@imammedo.users.ipa.redhat.com>
 <20250128184202.14778f27@foz.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128184202.14778f27@foz.lan>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 28, 2025 at 06:42:02PM +0100, Mauro Carvalho Chehab wrote:
> Em Fri, 24 Jan 2025 13:30:54 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Wed, 22 Jan 2025 16:46:25 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > 
> > > Adds a generic error device to handle generic hardware error
> > > events as specified at ACPI 6.5 specification at 18.3.2.7.2:
> > > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> > > using HID PNP0C33.
> > > 
> > > The PNP0C33 device is used to report hardware errors to
> > > the guest via ACPI APEI Generic Hardware Error Source (GHES).
> > > 
> > > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  hw/acpi/aml-build.c                    | 10 ++++++++++
> > >  hw/acpi/generic_event_device.c         |  8 ++++++++
> > >  include/hw/acpi/acpi_dev_interface.h   |  1 +
> > >  include/hw/acpi/aml-build.h            |  2 ++
> > >  include/hw/acpi/generic_event_device.h |  1 +
> > >  5 files changed, 22 insertions(+)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index f8f93a9f66c8..e4bd7b611372 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -2614,3 +2614,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
> > >  
> > >      return var;
> > >  }
> > > +
> > > +/* ACPI 5.0b: 18.3.2.6.2 Event Notification For Generic Error Sources */
> > > +Aml *aml_error_device(void)
> > > +{
> > > +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> > > +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> > > +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > > +
> > > +    return dev;
> > > +}
> > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > index fe537ed05c66..ce00c80054f4 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
> > >      ACPI_GED_PWR_DOWN_EVT,
> > >      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> > >      ACPI_GED_CPU_HOTPLUG_EVT,
> > > +    ACPI_GED_ERROR_EVT,
> > >  };
> > >  
> > >  /*
> > > @@ -116,6 +117,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
> > >                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> > >                                        aml_int(0x80)));
> > >                  break;
> > > +            case ACPI_GED_ERROR_EVT:
> > > +                aml_append(if_ctx,
> > > +                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
> > > +                                      aml_int(0x80)));  
> >                                                  ^^^^^
> > nit: perhaps add a comment with intent and ref to spec wrt above  value
> 
> Will add this as with a define:
> 
> 	/*
> 	 * ACPI 5.0b: 5.6.6 Device Object Notifications
> 	 * Table 5-135 Error Device Notification Values
> 	 */
> 	#define ERROR_DEVICE_NOTIFICATION   0x80
> 
> (the spec here is the same as we used on this patch for aml_error_device()
> function)

we do not do a lot of defines definetely not for 1 time used constants.

just comment on top of the value.

> > 
> > > +                break;
> > >              case ACPI_GED_NVDIMM_HOTPLUG_EVT:
> > >                  aml_append(if_ctx,
> > >                             aml_notify(aml_name("\\_SB.NVDR"),
> > > @@ -295,6 +301,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> > >          sel = ACPI_GED_MEM_HOTPLUG_EVT;
> > >      } else if (ev & ACPI_POWER_DOWN_STATUS) {
> > >          sel = ACPI_GED_PWR_DOWN_EVT;
> > > +    } else if (ev & ACPI_GENERIC_ERROR) {
> > > +        sel = ACPI_GED_ERROR_EVT;
> > >      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
> > >          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> > >      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> > > diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> > > index 68d9d15f50aa..8294f8f0ccca 100644
> > > --- a/include/hw/acpi/acpi_dev_interface.h
> > > +++ b/include/hw/acpi/acpi_dev_interface.h
> > > @@ -13,6 +13,7 @@ typedef enum {
> > >      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
> > >      ACPI_VMGENID_CHANGE_STATUS = 32,
> > >      ACPI_POWER_DOWN_STATUS = 64,
> > > +    ACPI_GENERIC_ERROR = 128,
> > >  } AcpiEventStatusBits;
> > >  
> > >  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> > > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > > index c18f68134246..f38e12971932 100644
> > > --- a/include/hw/acpi/aml-build.h
> > > +++ b/include/hw/acpi/aml-build.h
> > > @@ -252,6 +252,7 @@ struct CrsRangeSet {
> > >  /* Consumer/Producer */
> > >  #define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
> > >  
> > > +#define ACPI_APEI_ERROR_DEVICE   "GEDD"
> > >  /**
> > >   * init_aml_allocator:
> > >   *
> > > @@ -382,6 +383,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
> > >               uint8_t channel);
> > >  Aml *aml_sleep(uint64_t msec);
> > >  Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
> > > +Aml *aml_error_device(void);
> > >  
> > >  /* Block AML object primitives */
> > >  Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
> > > diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> > > index d2dac87b4a9f..1c18ac296fcb 100644
> > > --- a/include/hw/acpi/generic_event_device.h
> > > +++ b/include/hw/acpi/generic_event_device.h
> > > @@ -101,6 +101,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> > >  #define ACPI_GED_PWR_DOWN_EVT      0x2
> > >  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> > >  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> > > +#define ACPI_GED_ERROR_EVT          0x10
> > >  
> > >  typedef struct GEDState {
> > >      MemoryRegion evt;  
> > 
> 
> 
> 
> Thanks,
> Mauro


