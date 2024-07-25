Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9C5C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 08:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtsL-0002CS-KZ; Thu, 25 Jul 2024 04:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWtsG-00022v-3J
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWtsE-0000pW-60
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721896253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uWI1h/w9Act3yKoYCsfqzuimTCk6ZNQnmbh558KFqJg=;
 b=h3V6H/oJ6Ap5hAlcs/h0yIQHmgjLI3JoRGwNcm8XIaZLRC3Dvo8MmIYOVtcPPP7cBAGRNK
 LtTDbEnNVMt1Gk8p4dFNJSNxXoYApo4trTPIY2dbyDAo3BBIbF9f0PLbhgm9YmeXdEbPfy
 CpyojPkRB9x9nbqL8JeXrTQNhwqpafQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Mv43Hmx0PdquI-v97KzfoA-1; Thu, 25 Jul 2024 04:30:50 -0400
X-MC-Unique: Mv43Hmx0PdquI-v97KzfoA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-369bf135b49so354663f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 01:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721896249; x=1722501049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWI1h/w9Act3yKoYCsfqzuimTCk6ZNQnmbh558KFqJg=;
 b=CarmwwpreoqXAcFfTKhbHEwxQjqGW/3ZTrSZnMbZOwdqDtRMB/baI/bC82NqAvsUeY
 99XhlenjK+wO/nWdbO37R9E66FA5dOnv65HksxuMuH6S9d7NrvcnPVSgiJsz/x4LHLGk
 uSH4L2cL0whKWDsax+AntCNCC7Lq8fx4kgouk2QeF1sxUCfl/IWMeUdOz1L3Lv/ddTCR
 LTaJjbtJUqVc+6tHWOVP2/bLEjbpToC/Sem4Wau+SOEs1b/FmfbYyDcd63DUYtDMdHgF
 8SzUVS+UweedH5uPbuggP5GKF+raicbZgJvndA7McgwkyNJ3Gw60gah/dX48h3XjAvWR
 AZlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUca4IcOwytsRe1tkXUQFSkaOQBc/o2dg7S0xtofMNAaZplU8jIWdNMeiFXdmeJ29ScbEK7Y1olOxFWz+yx3tstNYOf6Mo=
X-Gm-Message-State: AOJu0Yx3EQNnT7o2ITh2Ztb+6M3Wxwe6CnbHyPcSgirki+li5ZpCaj2/
 979HX5u2vTkpaht4in4augMS0tWHsP6/8u8kzqkolO8jWPhzIAU2KJukZnwtxvOWfBbwIRGcCdv
 /EfWc33wiNZ7ZvE+Iosjq/ufS6xH4Y/kiULkEyFQ+1H3bVFZ+XfhH
X-Received: by 2002:adf:a3d4:0:b0:368:377a:e8bb with SMTP id
 ffacd0b85a97d-369f6706278mr2865468f8f.28.1721896249439; 
 Thu, 25 Jul 2024 01:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmE+QiQfWlHn4VDvmJKx0UxPqpzExB1A/kq0jkCC7t7id5OwBKQu1MVdUIi+b8vGOIkZUIFQ==
X-Received: by 2002:adf:a3d4:0:b0:368:377a:e8bb with SMTP id
 ffacd0b85a97d-369f6706278mr2865401f8f.28.1721896248315; 
 Thu, 25 Jul 2024 01:30:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42808b83b46sm933295e9.1.2024.07.25.01.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 01:30:47 -0700 (PDT)
Date: Thu, 25 Jul 2024 04:30:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 1/3] acpi/ged: Implement S3 and S4 sleep
Message-ID: <20240725042431-mutt-send-email-mst@kernel.org>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <20240613-loongarch64-sleep-v1-1-d2ef0aaa543a@flygoat.com>
 <20240725102215.4046ecc2@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725102215.4046ecc2@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 25, 2024 at 10:22:15AM +0200, Igor Mammedov wrote:
> On Thu, 13 Jun 2024 18:30:15 +0100
> Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 
> > Implement S3 and S4 sleep with ACPI_GED_REG_SLEEP_CTL.SLP_TYP
> > writes.
> > 
> > Implement wakeup callback and WAK_STS register to inform guest
> > about current states.
> > 
> > All new functions are gated by "slp-typs" property, it is defaulted
> > to S5 only and machines can opt-in for S3 and S4.
> 
> subject says S3 + S4 and don't mention S5
> the same happens throughout the series, please fix it up
> 
> PS:
> please reference relevant ACPI portions in the patch below,
> so reader could easily find and understand what code does.
> 
> > 
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  hw/acpi/generic_event_device.c         | 70 ++++++++++++++++++++++++++++++----
> >  include/hw/acpi/generic_event_device.h | 12 +++++-
> >  2 files changed, 73 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 2d6e91b124e5..f1fc99c04011 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -11,6 +11,7 @@
> >  
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> > +#include "qapi/qapi-events-run-state.h"
> >  #include "hw/acpi/acpi.h"
> >  #include "hw/acpi/generic_event_device.h"
> >  #include "hw/irq.h"
> > @@ -186,24 +187,53 @@ static const MemoryRegionOps ged_evt_ops = {
> >  
> >  static uint64_t ged_regs_read(void *opaque, hwaddr addr, unsigned size)
> >  {
> > +    GEDState *ged_st = opaque;
> > +
> > +    switch (addr) {
> > +    case ACPI_GED_REG_SLEEP_STS:
> > +        return ged_st->sleep_sts;
> > +    default:
> > +        break;
> > +    }
> > +
> >      return 0;
> >  }
> >  
> >  static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
> >                             unsigned int size)
> >  {
> > -    bool slp_en;
> > -    int slp_typ;
> > +    GEDState *ged_st = opaque;
> > +    AcpiGedState *s = container_of(ged_st, AcpiGedState, ged_state);
> >  
> >      switch (addr) {
> >      case ACPI_GED_REG_SLEEP_CTL:
> > -        slp_typ = (data >> 2) & 0x07;
> > -        slp_en  = (data >> 5) & 0x01;
> maybe use defines instead of magic numbers, it's also good to add
> coments here referring to concrete chapter in APCI spec that describe
> what these numbers are.

In fact if you add comments you do not need defines.
One time use defines are a waste of time and hard to parse.

 slp_typ = (data >> 2 /* x Yz */ ) & 0x07 /* bits 0 to 3 */;

is clearer than

#define ACPI_S3_X_YZ 2
#define ACPI_S3_MASK 7

because that "x Yz" can match spec text *exactly*, you do
text search and you find where it is. With macros
you have to guess.

build_amd_iommu is a nice example I think.

> 
> > -        if (slp_en && slp_typ == 5) {
>                                     ^^^
> ditto

this is deleted code, isn't it?

> > -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > +        if (data & ACPI_GED_SLP_EN) {
> > +            switch (extract8(data, 2, 3)) {
> > +            case ACPI_GED_SLP_TYP_S3:
> > +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S3)) {
> 
> why not use existing helpers like test_bit()
> the same applies to following bit checks
> 
> > +                    qemu_system_suspend_request();
> > +                }
> > +                break;
> > +            case ACPI_GED_SLP_TYP_S4:
> > +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S4)) {
> > +                    qapi_event_send_suspend_disk();
> > +                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > +                }
> > +                break;
> > +            case ACPI_GED_SLP_TYP_S5:
> > +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S5)) {
> > +                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > +                }
> > +                break;
> > +            default:
> > +                break;
> > +            }
> >          }
> >          return;
> >      case ACPI_GED_REG_SLEEP_STS:
> > +        if (data & ACPI_GED_WAK_STS) {
> > +            ged_st->sleep_sts &= ~ACPI_GED_WAK_STS;
> > +        }
> >          return;
> >      case ACPI_GED_REG_RESET:
> >          if (data == ACPI_GED_RESET_VALUE) {
> > @@ -223,6 +253,14 @@ static const MemoryRegionOps ged_regs_ops = {
> >      },
> >  };
> >  
> > +static void acpi_ged_notify_wakeup(Notifier *notifier, void *data)
> > +{
> > +    GEDState *ged_st = container_of(notifier, GEDState, wakeup);
> > +
> > +    ged_st->sleep_sts |= ACPI_GED_WAK_STS;
> 
> describe somewhere workflow how it is supposed to work 
> (commit message or add ged specific doc in docs/specs/
> as the 1st patch)
> 
> > +}
> > +
> > +
> >  static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
> >                                      DeviceState *dev, Error **errp)
> >  {
> > @@ -305,6 +343,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> >  
> >  static Property acpi_ged_properties[] = {
> >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > +    DEFINE_PROP_UINT32("slp-typs", AcpiGedState, slp_typs_bitmap,
> > +                        (1 << ACPI_GED_SLP_TYP_S5)),
> 
> I'd default to everything enabled, and use compat mechanism
> to disable it on older machine types.
> 
> You have to do this as ged is also used by versioned arm/virt machine
> 
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > @@ -320,10 +360,11 @@ static const VMStateDescription vmstate_memhp_state = {
> >  
> >  static const VMStateDescription vmstate_ged_state = {
> >      .name = "acpi-ged-state",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > +    .version_id = 2,
> > +    .minimum_version_id = 2,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_UINT32(sel, GEDState),
> > +        VMSTATE_UINT8(sleep_sts, GEDState),
> >          VMSTATE_END_OF_LIST()
> >      }
> >  };
> 
> see for example
> commit 829600a519386c7b188d5d813e78ba69bf0bd323
>     hpet: recover timer offset correctly
> 
> 
> 
> > @@ -371,6 +412,18 @@ static const VMStateDescription vmstate_acpi_ged = {
> >      }
> >  };
> >  
> > +static void acpi_ged_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AcpiGedState *s = ACPI_GED(dev);
> > +    GEDState *ged_st = &s->ged_state;
> > +
> > +    if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S3)) {
> > +        ged_st->wakeup.notify = acpi_ged_notify_wakeup;
> > +        qemu_register_wakeup_notifier(&ged_st->wakeup);
> > +        qemu_register_wakeup_support();
> > +    }
> > +}
> > +
> >  static void acpi_ged_initfn(Object *obj)
> >  {
> >      DeviceState *dev = DEVICE(obj);
> > @@ -409,6 +462,7 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
> >      AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
> >  
> >      dc->desc = "ACPI Generic Event Device";
> > +    dc->realize = acpi_ged_realize;
> 
> realize was added recently (currently in master),
> please rebase on top of current master tree
> 
> >      device_class_set_props(dc, acpi_ged_properties);
> >      dc->vmsd = &vmstate_acpi_ged;
> >  
> > diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> > index ba84ce021477..1ea3cb848679 100644
> > --- a/include/hw/acpi/generic_event_device.h
> > +++ b/include/hw/acpi/generic_event_device.h
> > @@ -80,9 +80,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> >  /* ACPI_GED_REG_RESET value for reset*/
> >  #define ACPI_GED_RESET_VALUE       0x42
> >  
> > -/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
> > +/* ACPI_GED_REG_SLEEP_CTL.SLP_EN bit */
> > +#define ACPI_GED_SLP_EN            (1 << 5)
> > +
> > +/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP values */
> > +#define ACPI_GED_SLP_TYP_S3        0x03
> > +#define ACPI_GED_SLP_TYP_S4        0x04
> >  #define ACPI_GED_SLP_TYP_S5        0x05
> >  
> > +#define ACPI_GED_WAK_STS           (1 << 7)
> > +
> >  #define GED_DEVICE      "GED"
> >  #define AML_GED_EVT_REG "EREG"
> >  #define AML_GED_EVT_SEL "ESEL"
> > @@ -99,7 +106,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> >  typedef struct GEDState {
> >      MemoryRegion evt;
> >      MemoryRegion regs;
> > +    Notifier     wakeup;
> >      uint32_t     sel;
> > +    uint8_t      sleep_sts;
> >  } GEDState;
> >  
> >  struct AcpiGedState {
> > @@ -108,6 +117,7 @@ struct AcpiGedState {
> >      MemoryRegion container_memhp;
> >      GEDState ged_state;
> >      uint32_t ged_event_bitmap;
> > +    uint32_t slp_typs_bitmap;
> >      qemu_irq irq;
> >      AcpiGhesState ghes_state;
> >  };
> > 


