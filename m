Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B9F30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy7X2-0008Jj-Oz; Thu, 05 Mar 2026 07:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vy7Wz-0008Jb-4e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:10:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vy7Wt-0007dK-H8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772712608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/TsE/C3LzMPO8HlJY98uv+W9nWwSgAHHQnJ/StK2sI=;
 b=HEnygobjjA9a5gZ/LEpssGCgSlBldjnH3CLfIdJG3dDdzUzk97Tv4ELdEMbHhA7NYllM8S
 HdgEsDNEt368ucKhvyvd8697x4em5v4gYn7TdYD4PsUgyvS+wFBwE0orxBrpnT73iZgUU8
 nmY8W+XLbVuBCcLkg8queSyvQ5xCnP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-CmGW1C44M_KVVWVp0s-JYg-1; Thu, 05 Mar 2026 07:10:04 -0500
X-MC-Unique: CmGW1C44M_KVVWVp0s-JYg-1
X-Mimecast-MFC-AGG-ID: CmGW1C44M_KVVWVp0s-JYg_1772712603
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c794edd9so1719068f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772712603; x=1773317403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/TsE/C3LzMPO8HlJY98uv+W9nWwSgAHHQnJ/StK2sI=;
 b=uIsfuX3Mkqn3gAVTh5di8oYbQzFyhzwsoUEcH5CRhsX1pwghPbftnTcQ1FNKuB0Dkm
 +K/9TQCma9Tft11M8jH2ZcWlZEHAIiuekYVn1JpaY68OfiqDnasHWUJEsuigMyy5QPfl
 XkoXNpGKaltXvzgrIn2Ng804m0qq9+iTrUxrRPIELhzIgYt/CEpdojj+y8Ma6VrlZWSx
 0WJyQbczEY5xpg07qgbH+P3ELYUTViJAZgQB7OV0LS5wfbDeQ2AjKZghS7nKjQfE7fPn
 Tqp25ebjJGlX1yI75mcbb8YtohK0bPSLLgrLJWZIUfxUGuDQPDIFz8iA4C/ZQHtQ7EWP
 7pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772712603; x=1773317403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W/TsE/C3LzMPO8HlJY98uv+W9nWwSgAHHQnJ/StK2sI=;
 b=EA+MClkbN9LJcjAjJ1PdXrvpV/Io9Sl1WszZQ31zERNAxjJ6VDjoJb1eNnsce1TFIs
 lWeiW6u4A6cuWvCQdYnYPMJNviJpWiJik73p3/J9s4Kw5cjdzyx5FS0KHZa8Wm41ZmrL
 ZFAIR7xxBO//K+Tpc8aojb+tGAfTacuZz+U01uFO+/9uUuHsLyxI3d0Z2/EiG3Txp8Aw
 1C3bwT7wvu9b7gWz9dTvpYE5uM2SQSY85CAYy5Ushbdo/pyC4Tfi2hsVftNT5DQOi4OQ
 Jbv2JADjznmVkzASWNb1Jylh2VyGBNaCIs/QPHC9UJcV39gJP6uUhGZS4di932unVbO1
 oNyw==
X-Gm-Message-State: AOJu0Ywj3BD0Xbj1qi8bYypUvLLAqF1Uop8ZGFvU3usNFIuhKdm8O2V1
 X79owhKeEZSg75I0wJsjh91vq5apHvMDhx9meVzcwwXupym0EJIJr4GtCPxEFNL3ama6zrFhB3S
 dStSQHoK7hkhSsCmg15LTvKofSjZBQxOoxPErXAE0CURfxcpB1XpTwemI
X-Gm-Gg: ATEYQzzgke2zLCTvdEKU5KiY3miPYoLm7IrmvqUWsv1aE7S6zEP5Nunwj8tjUqMdSLs
 86bN7v8gJfw13o4a9uYlltMzHGjxd/cebPLTojxy//C1QF/GR36+ZxepsUEdfcJ37b/GwfHLS4O
 lDg0yIeolwQqo7IiP30R263QPjRPsE3kKjwO72jpNgOwBJ1vBb/mvdoyjmXGPc/HxPoS5x8rKYI
 UGc4lF/MQMkVXTzdUGom6QY5aLZXZNstgxqq+QTUxxDyTSj0R5JxMa2rBFzfTp7ExCNi7SKQCAQ
 Fn3AEUyyUOY1oC7AsLagS9G0NUC2r0M1Q54LDAO7PrPpgou+GCJ/mocYss9zbUahyOzbFB01IG7
 MKdktUQ==
X-Received: by 2002:a05:6000:12c2:b0:439:ccd7:cdfb with SMTP id
 ffacd0b85a97d-439ccd7cf74mr5270839f8f.53.1772712603338; 
 Thu, 05 Mar 2026 04:10:03 -0800 (PST)
X-Received: by 2002:a05:6000:12c2:b0:439:ccd7:cdfb with SMTP id
 ffacd0b85a97d-439ccd7cf74mr5270801f8f.53.1772712602840; 
 Thu, 05 Mar 2026 04:10:02 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439abdf5430sm39313088f8f.5.2026.03.05.04.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 04:10:02 -0800 (PST)
Date: Thu, 5 Mar 2026 13:10:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 philmd@linaro.org, kraxel@redhat.com
Subject: Re: [PATCH 17/16] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
Message-ID: <20260305131001.71024353@imammedo>
In-Reply-To: <061e1cc4-7099-4e2e-a164-04c34a6a0c10@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
 <20260303140058.2423099-1-imammedo@redhat.com>
 <061e1cc4-7099-4e2e-a164-04c34a6a0c10@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Wed, 4 Mar 2026 18:20:27 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 03/03/2026 15.00, Igor Mammedov wrote:
> > From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >=20
> > v2:
> >     - do not check for SMI features if hotplug happens when
> >       SMI is not enabled. (matters for qtest and possibly seabios)
> >     - removing property also removes default ICH9_LPC_SMI_F_BROADCAST_B=
IT
> >       put default back in place only set it initfn() instead
> >=20
> > The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
> > in the pc_compat_2_8[] array, via the 'x-smi-broadcast=3Doff'
> > property. We removed all machines using that array, lets remove
> > that property and all the code around it.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   hw/acpi/ich9.c    |  4 ++--
> >   hw/isa/lpc_ich9.c | 23 ++++-------------------
> >   2 files changed, 6 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index bbb1bd60a2..87afe86bcc 100644
> > --- a/hw/acpi/ich9.c
> > +++ b/hw/acpi/ich9.c
> > @@ -432,7 +432,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hot=
plug_dev, DeviceState *dev,
> >       if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> >           uint64_t negotiated =3D lpc->smi_negotiated_features;
> >  =20
> > -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> > +        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
> >               !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
> >               error_setg(errp, "cpu hotplug with SMI wasn't enabled by =
firmware");
> >               error_append_hint(errp, "update machine type to newer tha=
n 5.1 "
> > @@ -476,7 +476,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandle=
r *hotplug_dev,
> >       } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> >           uint64_t negotiated =3D lpc->smi_negotiated_features;
> >  =20
> > -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> > +        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
> >               !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)=
)) {
> >               error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
> >                                "by firmware");
> > diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> > index 51dc680029..04169ffa24 100644
> > --- a/hw/isa/lpc_ich9.c
> > +++ b/hw/isa/lpc_ich9.c
> > @@ -404,15 +404,6 @@ static void smi_features_ok_callback(void *opaque)
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
> > @@ -474,14 +465,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, vo=
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
> > @@ -685,6 +671,7 @@ static void ich9_lpc_initfn(Object *obj)
> >  =20
> >       static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
> >       static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
> > +    lpc->smi_host_features =3D BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT); =
=20
>=20
> Shouldn't that rather be a "|=3D" instead of the "=3D" so that we don't l=
ose the=20
> other bits?

Indeed it should be '|=3D',
can you fix it up on merge or should I better send fixed up version?

=20
>   Thomas
>=20
>=20
>=20
> >       object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
> >  =20
> > @@ -834,8 +821,6 @@ static const Property ich9_lpc_properties[] =3D {
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


