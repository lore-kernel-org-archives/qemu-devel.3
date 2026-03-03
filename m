Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50C4EC1452
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQAd-0007cg-2I; Tue, 03 Mar 2026 08:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxQAa-0007bx-5D
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:52:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxQAX-0003Hb-67
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772545931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YG5Abu6Icg/Wp5BnDroNplSAMFUyy4A9czYj1n5LX+c=;
 b=Q5j3RGM3/Rcx6EgBs8ZQEYcfr8GL3Vax1lTNll5rLlXyL6GOL2JaWpQJqcSooOGvOfAmS3
 vEQN5j6VFHJU/mqnUILiOy66VUw658U5stVbmSU4IIhGYKjVzDAWGcrnWefSgKdmvRjUJ7
 bspJdOKVEQ3YCosP5+qQnrJ+swez/tk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-NuIjvdM9PEWLiG6dZ8RBvw-1; Tue, 03 Mar 2026 08:52:10 -0500
X-MC-Unique: NuIjvdM9PEWLiG6dZ8RBvw-1
X-Mimecast-MFC-AGG-ID: NuIjvdM9PEWLiG6dZ8RBvw_1772545929
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so55200035e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 05:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772545929; x=1773150729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YG5Abu6Icg/Wp5BnDroNplSAMFUyy4A9czYj1n5LX+c=;
 b=SmyPCW1s1FdUD7mO/dVqESZcH85u7r19VuzpWqFfeF64TXAomF1MeRB9nb17+Z0FOt
 R1rEGZff9wHoDkS9hPu8vKtoSoF9amfvhS28BWdjmD8GylhN18Qxldv/Rx81D+aT5/cv
 wIdwtP1d//wuJKXjYsW+9RTFIwdomYHtZe1JH2DTYbCxgINNtYz4wD8ql0T7iRKT9Oin
 ug/5H9KHEUc9tUfO0Q6sDcdwVABH0qwKasTtOYXRHGRidflyRyFzR8evuHjERA+OHEdm
 C3/TT3gcI8nn8fnOXrTBsmjyxJEUXN6yfmpaDRqcTzwpCBHw+hhG/OkN32o0R7/o2wq4
 gMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772545929; x=1773150729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YG5Abu6Icg/Wp5BnDroNplSAMFUyy4A9czYj1n5LX+c=;
 b=khxTUw8v/xxy1PGGd0RUyGIFtLe6eXMruwqN4feQPiBGH2MYEHUFOVA2qDg5A8gmlt
 gNWou1RUeRKrqeTfJVqRRfqZH0wLFl6YklQgLMZMgamH+jmeGE12iAi25bRtUaOi3Xgw
 HhyI+4Sx0n728UuavtQj/Ed7SWa63VFaaxaZh4Bcd7RnLhVfz8el6POMcDI5zuoaEtVw
 2HdTWH1AtzntVRxSGlxYYuyu6EtmbN5L30deX5Ha6iWbelb9oteE40/wshtlxU9zfduG
 8YPqyPrpnPfCg6JlegxbsOU7KtBMn3hv4PQ9jyAOd0MKzV/06jLZ9j+zR+67c1nno39Z
 eLyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbGwROVLg29+BqYKkQtvi5LrIMcqLdr9ItVWsuDrCjhQB96j3xRTPTX8/t4fPI4pH+UcRSG/AkAe3I@nongnu.org
X-Gm-Message-State: AOJu0YyzjuHQTD2J3bRcjmA15PSXXzkFIleb9Mk1wIGFKsySkhm/9AOU
 37u29plO6E9I2o5T8yl2nub7+peBdbRCUk75HqHPVt54GfIrmkwSTUTCwg1b8YJWJoP3jJatEbY
 uVz9Qg9soy7Jl4vAjw9FRzALIpKoZf+FObUNOMvgjbPAfl6+TYZ6Q8cqz
X-Gm-Gg: ATEYQzyDtWUvR5OluvHY4MfDSEMebFkaoCSJcLQEKot423V5HVhhdBWP1ybOMTiLdcg
 Om7FsYPzr2ekPam1QlG/d/ZiKrrwX6KyU4SsFABDeLMlxxkf82wXgJyTUnrGOI+2A0LrbuFsIse
 GA2pxLIKm3XO744Mnegye/9GTNDV1SOftomtCwM9lgoF3zYTNpen6m3Ahl44kzP2fpaXI8V3ub6
 ApZejpbfLoC9Ewuh1cETpO5oPcJjbUsuSYKHmb0zmUqSX830grhPYhOWsVkil1sZWTK2W3e2CUv
 3BTbAHc1xMGYjEF1fQr73aJQ84XOU8214AdbbeFE8k/bo3QFyw0HhLcxUTahPnrnf3FOFZMCLDz
 xkcZ/dA==
X-Received: by 2002:a05:600c:8108:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-483c9c0baf4mr271730845e9.28.1772545929114; 
 Tue, 03 Mar 2026 05:52:09 -0800 (PST)
X-Received: by 2002:a05:600c:8108:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-483c9c0baf4mr271730295e9.28.1772545928628; 
 Tue, 03 Mar 2026 05:52:08 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851334f9edsm27894425e9.4.2026.03.03.05.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:52:07 -0800 (PST)
Date: Tue, 3 Mar 2026 14:52:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH 03/18] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
Message-ID: <20260303145206.5ea63265@imammedo>
In-Reply-To: <6cc22a39-a8de-4795-8ddc-b83caef8a17e@redhat.com>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-4-philmd@linaro.org>
 <6cc22a39-a8de-4795-8ddc-b83caef8a17e@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 24 Feb 2026 16:24:10 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 01/05/2025 23.04, Philippe Mathieu-Daud=C3=A9 wrote:
> > The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
> > in the pc_compat_2_8[] array, via the 'x-smi-broadcast=3Doff'
> > property. We removed all machines using that array, lets remove
> > that property and all the code around it.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   include/hw/southbridge/ich9.h |  1 -
> >   hw/acpi/ich9.c                |  6 ++----
> >   hw/isa/lpc_ich9.c             | 22 +++-------------------
> >   3 files changed, 5 insertions(+), 24 deletions(-) =20
>=20
> FWIW, this patch seems to break tests/qtest/cpu-plug-test ... I get the=20
> error message "cpu hotplug with SMI wasn't enabled by firmware".
> Sounds like the guest has the enable this feature, too, so I assume we=20
> cannot simply assume that it is always available now?

I'll post fixed up patch as reply to your latest respin of this series

>=20
>   Thomas
>=20
>=20
>=20
> > diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich=
9.h
> > index 1e231e89c92..4764c03ac2d 100644
> > --- a/include/hw/southbridge/ich9.h
> > +++ b/include/hw/southbridge/ich9.h
> > @@ -244,7 +244,6 @@ struct ICH9LPCState {
> >   #define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
> >  =20
> >   /* bit positions used in fw_cfg SMI feature negotiation */
> > -#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
> >   #define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
> >   #define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
> >  =20
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index c7a735bf642..40564605735 100644
> > --- a/hw/acpi/ich9.c
> > +++ b/hw/acpi/ich9.c
> > @@ -477,8 +477,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hot=
plug_dev, DeviceState *dev,
> >       if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> >           uint64_t negotiated =3D lpc->smi_negotiated_features;
> >  =20
> > -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> > -            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
> > +        if (!(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
> >               error_setg(errp, "cpu hotplug with SMI wasn't enabled by =
firmware");
> >               error_append_hint(errp, "update machine type to newer tha=
n 5.1 "
> >                   "and firmware that suppors CPU hotplug with SMM");
> > @@ -526,8 +525,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandle=
r *hotplug_dev,
> >                  !lpc->pm.cpu_hotplug_legacy) {
> >           uint64_t negotiated =3D lpc->smi_negotiated_features;
> >  =20
> > -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> > -            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))=
) {
> > +        if (!(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))=
) {
> >               error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
> >                                "by firmware");
> >               error_append_hint(errp, "update machine type to a version=
 having "
> > diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> > index 71afb45b631..c57a06e0dde 100644
> > --- a/hw/isa/lpc_ich9.c
> > +++ b/hw/isa/lpc_ich9.c
> > @@ -400,15 +400,6 @@ static void smi_features_ok_callback(void *opaque)
> >       guest_cpu_hotplug_features =3D guest_features &
> >                                    (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_=
BIT) |
> >                                     BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPL=
UG_BIT));
> > -    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
> > -        guest_cpu_hotplug_features) {
> > -        /*
> > -         * cpu hot-[un]plug with SMI requires SMI broadcast,
> > -         * leave @features_ok at zero
> > -         */
> > -        return;
> > -    }
> > -
> >       if (guest_cpu_hotplug_features =3D=3D
> >           BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)) {
> >           /* cpu hot-unplug is unsupported without cpu-hotplug */
> > @@ -470,14 +461,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, vo=
id *arg)
> >  =20
> >       /* SMI_EN =3D PMBASE + 30. SMI control and enable register */
> >       if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
> > -        if (lpc->smi_negotiated_features &
> > -            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
> > -            CPUState *cs;
> > -            CPU_FOREACH(cs) {
> > -                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> > -            }
> > -        } else {
> > -            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> > +        CPUState *cs;
> > +        CPU_FOREACH(cs) {
> > +            cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> >           }
> >       }
> >   }
> > @@ -830,8 +816,6 @@ static const Property ich9_lpc_properties[] =3D {
> >       DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, fal=
se),
> >       DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false=
),
> >       DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, fal=
se),
> > -    DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_featur=
es,
> > -                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
> >       DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_fea=
tures,
> >                         ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
> >       DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_f=
eatures, =20
>=20


