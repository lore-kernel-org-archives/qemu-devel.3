Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A71AC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 14:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL12o-0006RA-Qy; Fri, 30 May 2025 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uL12m-0006QQ-H7
 for qemu-devel@nongnu.org; Fri, 30 May 2025 10:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uL12i-0007yR-KZ
 for qemu-devel@nongnu.org; Fri, 30 May 2025 10:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748616547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqepNYXQjbf85ZLuzzTPOpz+hwwqGB6HGZsk6zu1D10=;
 b=E9gXIZ6GA5GQ6zC+sYvJKHbDROxGm+JtbsKLxncOCwi8ZqXlXDm+SSkBP1DTgFk+ERfGQ+
 k6rtVlfxKMkEqoV9EOZ5ebdAiBX+r3sZsGrgalaIQoPrGMOSrvq3uIXt/wmVGPkkCOm96k
 HuG7Hnoi7+gBOSo3Vsyf54DwhyH+s0k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-1ptzu_V1MLG5WWhpG3teLA-1; Fri, 30 May 2025 10:49:06 -0400
X-MC-Unique: 1ptzu_V1MLG5WWhpG3teLA-1
X-Mimecast-MFC-AGG-ID: 1ptzu_V1MLG5WWhpG3teLA_1748616545
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442f4a3851fso17961635e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 07:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748616545; x=1749221345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqepNYXQjbf85ZLuzzTPOpz+hwwqGB6HGZsk6zu1D10=;
 b=sjeQMDkBgua5jw5N9lMuETsE87ddIvSEVrRcv+xF4OZTKOzGyiOo22yTfQ/wkjDORU
 uIoWmmMjJ7d4v0SMZhkqrtlgtBn/XJTxs6WcKkwLd4Rz020+gJ2/TJfd68zE/ILJa76P
 CDmp9cLXljDM68ndaYxdgnzck3cIUbsrsmMzOrYMmVo4F4MUwPXEZcnVUmKHm2jA/sq1
 v8sovmRBgQ8oc9T+GCJJw5zqFF0MfB/XZ2gKLVRR5XhFPGd8zwrpX2MwXNf9A6np6lVm
 nFu3Adoi5os2WnrITeMNM+TAdlAAjwef96KvuYEGs4HtCDBxKXWxgJSIEq2CosZehrKy
 PdOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURdQL9zE7gWCP59WwUGNuBkBOFUcFozakaBXHeXyZHBuf+7FzkgGj5u64xNWaVD/46v8nfhWB24mJk@nongnu.org
X-Gm-Message-State: AOJu0Yy/UTJKYopMHkRo4TMoiDWco0HybbP4N6Yh0+DvyG+72l0vVo+M
 7uzjCqNba1sIRyGuPtfKKu/Qcp7SUG/g0vP3QUxQWvs3ZycoUD+60JP42IlBr/pfn1y996k8A2s
 gFNaRPg4CHWyzHSbWkEjQYg7x/pf9TYY5e4dDrhpcAmfi9cWeGvRRcij/
X-Gm-Gg: ASbGncssaGA1v/WL5CoTnFb81qDSccdEDFa1buQwubIhe6H0BjL1XLRFkkpVE6m3sy+
 9WWa40O7PmdMdhXm38e/5Aq+NKLpJBjBSMgKzaTnihGHnsqIvqRctld6/YB3+gAvCAro4GYWSFL
 t4HKFxIb5OdOEGqJV9Xjm8hBC8NlQgfJyshwQ+BV/NmntL+qpR8emUEs7yzAqoxyO0EqyBCvb1X
 F8GfkBCYhXlfZHDRXKb+n716O+zCxezqJAW9w6iE1Uq+5WiNcMEmpteNKwgfAQkqMPB4QXG+day
 xO1ybsfXe+BIAUPSTxmsTniX57U9zcHy
X-Received: by 2002:a05:600c:45cc:b0:44d:a244:4983 with SMTP id
 5b1f17b1804b1-450d87fd9bemr29521675e9.3.1748616544762; 
 Fri, 30 May 2025 07:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1wWSt4EOdCrn3nu9eAYOCpvVHbBH3wN274HNH/BJAXiBBKw/lUmBOmEnT4BiZNKp2UDKduw==
X-Received: by 2002:a05:600c:45cc:b0:44d:a244:4983 with SMTP id
 5b1f17b1804b1-450d87fd9bemr29521355e9.3.1748616544335; 
 Fri, 30 May 2025 07:49:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb051bsm19991885e9.18.2025.05.30.07.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 07:49:03 -0700 (PDT)
Date: Fri, 30 May 2025 16:49:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/20] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250530164903.0f9f8444@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250530080120-mutt-send-email-mst@kernel.org>
References: <cover.1747722973.git.mchehab+huawei@kernel.org>
 <aa74b756f633dbee5442cf4baa2c1d81a669d2f9.1747722973.git.mchehab+huawei@kernel.org>
 <20250528174212.2823d3de@imammedo.users.ipa.redhat.com>
 <20250530080120-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 30 May 2025 08:01:28 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, May 28, 2025 at 05:42:12PM +0200, Igor Mammedov wrote:
> > On Tue, 20 May 2025 08:41:31 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Create a new property (x-has-hest-addr) and use it to detect if
> > > the GHES table offsets can be calculated from the HEST address
> > > (qemu 10.0 and upper) or via the legacy way via an offset obtained
> > > from the hardware_errors firmware file.  
> > 
> > 
> > it doesn't apply to current master anymore  
> 
> indeed. Mauro?

Michael,
it's trivial conflict in machine compat,
could you fix it up while applying?

we have another series in queue that depends on this one being in merged. 

> 
> >   
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  hw/acpi/generic_event_device.c |  2 ++
> > >  hw/arm/virt-acpi-build.c       | 18 ++++++++++++++++--
> > >  hw/core/machine.c              |  5 ++++-
> > >  3 files changed, 22 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > index d292f61b4e41..3cf9dab0d01a 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -318,6 +318,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> > >  
> > >  static const Property acpi_ged_properties[] = {
> > >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > > +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
> > > +                     ghes_state.use_hest_addr, false),
> > >  };
> > >  
> > >  static const VMStateDescription vmstate_memhp_state = {
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index da3ebf403ef9..3126234e657d 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -893,6 +893,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
> > >      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> > >  };
> > >  
> > > +static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
> > > +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> > > +};
> > > +
> > >  static
> > >  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > >  {
> > > @@ -947,15 +951,25 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > >  
> > >      if (vms->ras) {
> > >          AcpiGedState *acpi_ged_state;
> > > +        static const AcpiNotificationSourceId *notify;
> > > +        unsigned int notify_sz;
> > >          AcpiGhesState *ags;
> > >  
> > >          acpi_ged_state = ACPI_GED(vms->acpi_dev);
> > >          ags = &acpi_ged_state->ghes_state;
> > >          if (ags) {
> > >              acpi_add_table(table_offsets, tables_blob);
> > > +
> > > +            if (!ags->use_hest_addr) {
> > > +                notify = hest_ghes_notify_10_0;
> > > +                notify_sz = ARRAY_SIZE(hest_ghes_notify_10_0);
> > > +            } else {
> > > +                notify = hest_ghes_notify;
> > > +                notify_sz = ARRAY_SIZE(hest_ghes_notify);
> > > +            }
> > > +
> > >              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> > > -                            tables->linker, hest_ghes_notify,
> > > -                            ARRAY_SIZE(hest_ghes_notify),
> > > +                            tables->linker, notify, notify_sz,
> > >                              vms->oem_id, vms->oem_table_id);
> > >          }
> > >      }
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index b8ae155dfa11..dfd36cf063c7 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -35,9 +35,12 @@
> > >  #include "hw/virtio/virtio-pci.h"
> > >  #include "hw/virtio/virtio-net.h"
> > >  #include "hw/virtio/virtio-iommu.h"
> > > +#include "hw/acpi/generic_event_device.h"
> > >  #include "audio/audio.h"
> > >  
> > > -GlobalProperty hw_compat_10_0[] = {};
> > > +GlobalProperty hw_compat_10_0[] = {
> > > +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> > > +};
> > >  const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
> > >  
> > >  GlobalProperty hw_compat_9_2[] = {  
> 


