Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E8DF3D31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBDk-0003bX-LR; Thu, 05 Mar 2026 11:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vyBDS-0003WB-TV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vyBDP-0002hp-Vb
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772726771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U32yOwyhruvOHY9wsf/JnAp0BG1PgS2Bu7Ki3QIytX8=;
 b=WkCpdkjhVSbRhAHxuaNdPPt8l3q10n0phxqxzouOwk17Ux75jUVCREwxR6FANO1X1q4uY7
 VfF5+yrvLp/rtbb3WsYpFypbTFPfZZypOQkhHo3WoCzCd6MhbmrFZa1W4GZU+n5DAPyEEX
 s7CjVgBW1yljrM8nOcBvH8hHAZC+n4Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-waRxLFhJOE-UsNGmgINCag-1; Thu, 05 Mar 2026 11:06:09 -0500
X-MC-Unique: waRxLFhJOE-UsNGmgINCag-1
X-Mimecast-MFC-AGG-ID: waRxLFhJOE-UsNGmgINCag_1772726768
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837f288194so66898535e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772726768; x=1773331568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U32yOwyhruvOHY9wsf/JnAp0BG1PgS2Bu7Ki3QIytX8=;
 b=JcqJrRugtlDO2ufrEII2xOr6P6QPRvXNThRlOXBvk/nq8AqQspZq/OBHR9gbc8Pyqr
 veKDhezOBicuKpefDqeRsxCg2ig/e5R3zmO023DpDrgn2JVHEdISadMFownG/QxBIPhx
 7GlykrpeBIrJvBwUijWtWojlewhix3gHyYF+gxoXMMUzJjgclvY591w8UeqSfkxWuMMw
 sbSJh2igGI76+468OADC/W2WY8SM0v1AG+pcit8lM4TW7G8Im9jTCEC0xxiT6oef/cBO
 lZKYYeiyq45eY3jsq6CXh3SoWqk7kqbL1ReXHtiSeU8mQYNGBoUE79cH+k9oWxMeh4jn
 rzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772726768; x=1773331568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U32yOwyhruvOHY9wsf/JnAp0BG1PgS2Bu7Ki3QIytX8=;
 b=Pu558m3IpqlbXyRc5x1ZebT8fedehMAaJQ1w+NGjCd+OIJv6R/KWc2U567uzXrLi3h
 cGOT9Hw9FccSU9h6178JbokI3cngguOTXHvBu6bBQvwO2/p0+JW35HzFDaFP5OzaOMhB
 yqz5HDy0cTjX1X9ndOmCwHoneQhG98YKCWzu8Y/ZOdK3SjL28IFL1RyGWfCiFaoItvEh
 wzvFo+HWZIzS1w0SrOAfEfL5BONPKuUt/cRtgUgR3kw2ttAEnlrfRY6H3aJ68O09rKML
 QVpCBtlO91N54atMabzAXr171YzE+TDaEoFteMrfTDlh7ucrD/NcunwHMTlF3vCLAawd
 JQMQ==
X-Gm-Message-State: AOJu0YygfStJwdmmCPLJCMOWkGCavS26oy4SmB/3mskOgN/mapOo97KP
 s7SkCuI8aOFUH48j1yn4wR52FEG5kbY3plLC0s8cuwhOMNKxRDjG3LpBgmKuPzJdgj+k7BQHiLa
 9i/X9jS7MS9C1xG4/+VX8I3EIFh5R/uGI6Oy+vvGFDaXk8/t2aHP4MjAn
X-Gm-Gg: ATEYQzw2kjaJS+IbqlYMiI3zzTDtNXQt0fi3YLnnzi8NPqkbieyTi4EfU0b3G5n10wY
 m7hIgfP6QKxiv6mDEC72Tk52vZnyp6vfjWOyfFSJ3sB8abdQhpvZVXQ2FQ2r32/TxiWcUJPFS6L
 yaNwzxwrEYxSgFaNKYl8syp6bgbxRdp0s6vueOe7mGguyKGSqP7X9m6D5tIY+QRxiS65+icIfeg
 kTBZ/au81rNy+PH+/uCV1N1+qQsCZO2uKH4d6lwUPtMKWFIFeqQrK1CTHT9CPMAO46sx0d00x5P
 KCS7t1w543xZZtl2g2AEoVxBbjZG2Tblydz7EKDUoylbeyxT5wlWSuNbdeYO1E6cPYNdBawK+1x
 rGaJbDg==
X-Received: by 2002:a05:600c:6309:b0:483:c771:10e with SMTP id
 5b1f17b1804b1-48519888ce5mr101285795e9.20.1772726768070; 
 Thu, 05 Mar 2026 08:06:08 -0800 (PST)
X-Received: by 2002:a05:600c:6309:b0:483:c771:10e with SMTP id
 5b1f17b1804b1-48519888ce5mr101285015e9.20.1772726767520; 
 Thu, 05 Mar 2026 08:06:07 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851acfbd1bsm57061185e9.6.2026.03.05.08.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 08:06:06 -0800 (PST)
Date: Thu, 5 Mar 2026 17:06:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 philmd@linaro.org, kraxel@redhat.com
Subject: Re: [PATCH 17/16] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
Message-ID: <20260305170605.6533ea0f@imammedo>
In-Reply-To: <20260305153218.15a04d00@imammedo>
References: <20260225092024.794595-1-thuth@redhat.com>
 <20260303140058.2423099-1-imammedo@redhat.com>
 <061e1cc4-7099-4e2e-a164-04c34a6a0c10@redhat.com>
 <20260305131001.71024353@imammedo>
 <872edff8-f5b4-4b94-ac0f-33677fb09131@redhat.com>
 <20260305153218.15a04d00@imammedo>
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

On Thu, 5 Mar 2026 15:32:18 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 5 Mar 2026 13:33:21 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> > On 05/03/2026 13.10, Igor Mammedov wrote: =20
> > > On Wed, 4 Mar 2026 18:20:27 +0100
> > > Thomas Huth <thuth@redhat.com> wrote:
> > >    =20
> > >> On 03/03/2026 15.00, Igor Mammedov wrote:   =20
> > >>> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > >>>
> > >>> v2:
> > >>>      - do not check for SMI features if hotplug happens when
> > >>>        SMI is not enabled. (matters for qtest and possibly seabios)
> > >>>      - removing property also removes default ICH9_LPC_SMI_F_BROADC=
AST_BIT
> > >>>        put default back in place only set it initfn() instead
> > >>>
> > >>> The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
> > >>> in the pc_compat_2_8[] array, via the 'x-smi-broadcast=3Doff'
> > >>> property. We removed all machines using that array, lets remove
> > >>> that property and all the code around it.
> > >>>
> > >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > >>> ---
> > >>>    hw/acpi/ich9.c    |  4 ++--
> > >>>    hw/isa/lpc_ich9.c | 23 ++++-------------------
> > >>>    2 files changed, 6 insertions(+), 21 deletions(-)
> > >>>
> > >>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > >>> index bbb1bd60a2..87afe86bcc 100644
> > >>> --- a/hw/acpi/ich9.c
> > >>> +++ b/hw/acpi/ich9.c
> > >>> @@ -432,7 +432,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler =
*hotplug_dev, DeviceState *dev,
> > >>>        if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > >>>            uint64_t negotiated =3D lpc->smi_negotiated_features;
> > >>>   =20
> > >>> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> > >>> +        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
> > >>>                !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BI=
T))) {
> > >>>                error_setg(errp, "cpu hotplug with SMI wasn't enable=
d by firmware");
> > >>>                error_append_hint(errp, "update machine type to newe=
r than 5.1 "
> > >>> @@ -476,7 +476,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHa=
ndler *hotplug_dev,
> > >>>        } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > >>>            uint64_t negotiated =3D lpc->smi_negotiated_features;
> > >>>   =20
> > >>> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> > >>> +        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
> > >>>                !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG=
_BIT))) {
> > >>>                error_setg(errp, "cpu hot-unplug with SMI wasn't ena=
bled "
> > >>>                                 "by firmware");
> > >>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> > >>> index 51dc680029..04169ffa24 100644
> > >>> --- a/hw/isa/lpc_ich9.c
> > >>> +++ b/hw/isa/lpc_ich9.c
> > >>> @@ -404,15 +404,6 @@ static void smi_features_ok_callback(void *opa=
que)
> > >>>        guest_cpu_hotplug_features =3D guest_features &
> > >>>                                     (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT=
PLUG_BIT) |
> > >>>                                      BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT=
_UNPLUG_BIT));
> > >>> -    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) =
&&
> > >>> -        guest_cpu_hotplug_features) {
> > >>> -        /*
> > >>> -         * cpu hot-[un]plug with SMI requires SMI broadcast,
> > >>> -         * leave @features_ok at zero
> > >>> -         */
> > >>> -        return;
> > >>> -    }
> > >>> -
> > >>>        if (guest_cpu_hotplug_features =3D=3D
> > >>>            BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)) {
> > >>>            /* cpu hot-unplug is unsupported without cpu-hotplug */
> > >>> @@ -474,14 +465,9 @@ static void ich9_apm_ctrl_changed(uint32_t val=
, void *arg)
> > >>>   =20
> > >>>        /* SMI_EN =3D PMBASE + 30. SMI control and enable register */
> > >>>        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
> > >>> -        if (lpc->smi_negotiated_features &
> > >>> -            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
> > >>> -            CPUState *cs;
> > >>> -            CPU_FOREACH(cs) {
> > >>> -                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> > >>> -            }
> > >>> -        } else {
> > >>> -            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> > >>> +        CPUState *cs;
> > >>> +        CPU_FOREACH(cs) {
> > >>> +            cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> > >>>            }
> > >>>        }
> > >>>    }
> > >>> @@ -685,6 +671,7 @@ static void ich9_lpc_initfn(Object *obj)
> > >>>   =20
> > >>>        static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABL=
E;
> > >>>        static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISA=
BLE;
> > >>> +    lpc->smi_host_features =3D BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BI=
T);   =20
> > >>
> > >> Shouldn't that rather be a "|=3D" instead of the "=3D" so that we do=
n't lose the
> > >> other bits?   =20
> > >=20
> > > Indeed it should be '|=3D',
> > > can you fix it up on merge or should I better send fixed up version? =
  =20
> >=20
> > I tried to fix it, but I still see an issue with the bios-tables-test q=
test=20
> > during "make check" - it does not finish anymore and is finally killed =
by=20
> > the timeout. Does "make check-qtest" work for you? =20
>=20
> cpu hotplug test did work, let me fix and check tests again=20

what breaks is '-M q35 -smp >1 + seabios",
where the later asks for SMI =3D> unexpected broadcast with this patch
and as result unhappy SeaBIOS, I'll send v3 as reply here.=20

>=20
> >=20
> >   Thomas
> >  =20
>=20


