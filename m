Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D4DC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyQf-0005fm-8I; Fri, 30 May 2025 08:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyQd-0005fM-CG
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyQb-0004GW-9O
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748606496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WPaWb2DBUzybHtEtz5+SIZgM6ykPPLxKGgnQITZGiM=;
 b=CL6A4bzAkKdGySR7tuFX9HdB8tMJIaLsISVJe1Jf5DBTFSJXUMn6d+DiKU5P8szVOXaBWA
 NXDvnA1t/kxa1suukX6/R+ZmDh6ERC4Yhk5pMTPDfScJwtYsNC0SQ35kup/o9y0JmMA2SZ
 yf1nFHKEZN4nYcN8okiHIF3mZdABFNs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-1zDxxngDPcKjeeMb11vOtw-1; Fri, 30 May 2025 08:01:34 -0400
X-MC-Unique: 1zDxxngDPcKjeeMb11vOtw-1
X-Mimecast-MFC-AGG-ID: 1zDxxngDPcKjeeMb11vOtw_1748606494
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a362939f61so906008f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748606493; x=1749211293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WPaWb2DBUzybHtEtz5+SIZgM6ykPPLxKGgnQITZGiM=;
 b=YfiH5gAcFzWqXdB+R10nbHyA/3FEBaUCnF8ldMImWyMVUl5rhdOfBRd5/jQ273+T4I
 rHzGkar51KId9FVmN1BOlo6y4gGcLhiCHvUB68HCPRegTcjwlQEQ1rA/okzOoCfVVjid
 LSZ9EQEr3jCrRxNJaA2A58lPp9/CoG3pF1QRQ0RVCNWQ8AZiQD8A+9Wol/I0CSqFp0k3
 +Nqqc8PyrV0N5Ov1RMbO1fjCDXpt6i4HV74J+bvTE80V3r0aTUILEqJZvb7GSUDpcCzl
 YmNVM/4UpaPGYmxh6DY60vUzfCQJ05F4dY48wSJnmnYHVu3lYc5PZZAJlkDKl2Ah8hEY
 l52g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmvDsLj1agjm95K8XQIJ0XE4aynHafR7O8Q4H+Fquqg7YMH7zwlQPSJrvre/Voq55QkQpztIxm5xHT@nongnu.org
X-Gm-Message-State: AOJu0Yype1VICpU3nheDS/XqM3UGdbsMbbas7gCECnu7jlUiohVdsEgb
 DE97/gzSwaA/sD0JrRc803ouSVrAbPp1KomfYvKJHVM+J6JX7w/+7u3+cDsc88dVPFAI9V42u0U
 1tWHGlZUo5tm6HK35wcQBGL1uxwP9pmuQtCBRgCeICeoMWYHDdYfTCVv3s2ekV0/x
X-Gm-Gg: ASbGnctlponLP8Sz9qSxZPaVWvidsqfK7SD7GgyLN/YCNwzRS636aUPeGAe5yjSabmw
 A4eHlBAdpAEPb1zwKbYtkZbKtBaGwlazgzqhf0/Mr7PeU+sQMxD66in51AdGUKOsiFOFndZGiJI
 hpP9ea0IT55S2U6OEA3ZxiiRd5YaE66wDFl3WZJ7UwCmDiwCSC1FQN0AmG3sh5P776aYgaItfZC
 IFtz/q+8eLhGJzDkOud3aRpsu0kih4CnCpLbwja18rH028sZLfZhSThLKUVp4WTVScWSHgavymJ
 JbC/3w==
X-Received: by 2002:a05:6000:4023:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3a4f89a7defmr1467420f8f.6.1748606493157; 
 Fri, 30 May 2025 05:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1gVcqHAhAJ9QWvV4I/CcNLL95rHuwb8avC98d08tABfzwj9pgURbSqB3ZvasaIXJegFy+Dg==
X-Received: by 2002:a05:6000:4023:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3a4f89a7defmr1467369f8f.6.1748606492597; 
 Fri, 30 May 2025 05:01:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b7b0sm4698399f8f.10.2025.05.30.05.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:01:31 -0700 (PDT)
Date: Fri, 30 May 2025 08:01:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/20] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250530080120-mutt-send-email-mst@kernel.org>
References: <cover.1747722973.git.mchehab+huawei@kernel.org>
 <aa74b756f633dbee5442cf4baa2c1d81a669d2f9.1747722973.git.mchehab+huawei@kernel.org>
 <20250528174212.2823d3de@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528174212.2823d3de@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 28, 2025 at 05:42:12PM +0200, Igor Mammedov wrote:
> On Tue, 20 May 2025 08:41:31 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Create a new property (x-has-hest-addr) and use it to detect if
> > the GHES table offsets can be calculated from the HEST address
> > (qemu 10.0 and upper) or via the legacy way via an offset obtained
> > from the hardware_errors firmware file.
> 
> 
> it doesn't apply to current master anymore

indeed. Mauro?

> 
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/acpi/generic_event_device.c |  2 ++
> >  hw/arm/virt-acpi-build.c       | 18 ++++++++++++++++--
> >  hw/core/machine.c              |  5 ++++-
> >  3 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index d292f61b4e41..3cf9dab0d01a 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -318,6 +318,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> >  
> >  static const Property acpi_ged_properties[] = {
> >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
> > +                     ghes_state.use_hest_addr, false),
> >  };
> >  
> >  static const VMStateDescription vmstate_memhp_state = {
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index da3ebf403ef9..3126234e657d 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -893,6 +893,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
> >      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> >  };
> >  
> > +static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
> > +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> > +};
> > +
> >  static
> >  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >  {
> > @@ -947,15 +951,25 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >  
> >      if (vms->ras) {
> >          AcpiGedState *acpi_ged_state;
> > +        static const AcpiNotificationSourceId *notify;
> > +        unsigned int notify_sz;
> >          AcpiGhesState *ags;
> >  
> >          acpi_ged_state = ACPI_GED(vms->acpi_dev);
> >          ags = &acpi_ged_state->ghes_state;
> >          if (ags) {
> >              acpi_add_table(table_offsets, tables_blob);
> > +
> > +            if (!ags->use_hest_addr) {
> > +                notify = hest_ghes_notify_10_0;
> > +                notify_sz = ARRAY_SIZE(hest_ghes_notify_10_0);
> > +            } else {
> > +                notify = hest_ghes_notify;
> > +                notify_sz = ARRAY_SIZE(hest_ghes_notify);
> > +            }
> > +
> >              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> > -                            tables->linker, hest_ghes_notify,
> > -                            ARRAY_SIZE(hest_ghes_notify),
> > +                            tables->linker, notify, notify_sz,
> >                              vms->oem_id, vms->oem_table_id);
> >          }
> >      }
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index b8ae155dfa11..dfd36cf063c7 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -35,9 +35,12 @@
> >  #include "hw/virtio/virtio-pci.h"
> >  #include "hw/virtio/virtio-net.h"
> >  #include "hw/virtio/virtio-iommu.h"
> > +#include "hw/acpi/generic_event_device.h"
> >  #include "audio/audio.h"
> >  
> > -GlobalProperty hw_compat_10_0[] = {};
> > +GlobalProperty hw_compat_10_0[] = {
> > +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> > +};
> >  const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
> >  
> >  GlobalProperty hw_compat_9_2[] = {


