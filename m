Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB60F33A74
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9km-0001Gh-Sw; Thu, 05 Mar 2026 09:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vy9kb-0001GS-AH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:32:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vy9kX-00033M-3D
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772721143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6za8SSlrlrDg4vm+gabi5050nkq9IKreXRaredyCO7w=;
 b=Dbke8BJiUHtOTn0dQhYhcT98lerqy2Ek7j9mv/HT2WBinCNT/hyCzVHuAvUtyO2sdg0hnf
 IRFLhIiIvw7M4lF6NHHZRIL28op00W5c/ngRnks018f4E9VWCIHhZVCtiRcZvxU5Ax13nB
 pc+iMqG3izDJdWxejiA1UxUcTB0EYBY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-tIG6oEpeNrWat4m1GvccNg-1; Thu, 05 Mar 2026 09:32:21 -0500
X-MC-Unique: tIG6oEpeNrWat4m1GvccNg-1
X-Mimecast-MFC-AGG-ID: tIG6oEpeNrWat4m1GvccNg_1772721140
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836c819456so61164955e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772721140; x=1773325940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6za8SSlrlrDg4vm+gabi5050nkq9IKreXRaredyCO7w=;
 b=r1WCqQx58d01qxFP2csHApEGUXcaAkaEyaIdMW4kTuMzcGu88n+CL6568aH68RblfW
 knKkINgNN7jyofKMrMEw+Q3WjX8H9jaKx5W9q4U/hjor7t3EIZ2RQmFgKf9HJ+JsPGvB
 q4yfNIfbkP0KKEnKt2vKh8WuIvM7s84t7WxboK1lZxjd+dFN9PPrWyxDhkDOD8vWC/py
 go+qWfo0W0SinFw9zp+bPbsvrhFzJuvSa9niuF1Xs0Xmppuh9fKInG//v1vqaGnwaaHu
 VyKX24UkC/wBfHbTUXX7LNGWXI9K1eDBwOVmAygsbGp4PRZ92iCsMHQX5g3/MLAblUWU
 Uz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772721140; x=1773325940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6za8SSlrlrDg4vm+gabi5050nkq9IKreXRaredyCO7w=;
 b=Barr95nXQhMuAoU3wo3BNRwR0AyWxB2Qi3q49ZzpahJbN6wKHy8i0JNSKOgfqbzTQb
 FASZDEDxf0mbxDQXYWsIiAXsfrao4om4dZTjfclG5PbLd6/kCGjlJmFLvUsOzcAxk3h4
 roVqbAWXpY8xswct1RZxWF8UdKv6kkYP+R/Cr+bnl+M8WSJ5+5RpSAQOYMHBKkXbrBxd
 Mz8K50jzNW03wzETq7RY6vMf2C8PBgqMONBFLK1Wdvg/1cD9xxvEh1rlbFMboFK3uZ9v
 CHQ3v1dfCCPtBRXV4lWJib87RJHfcNc+sGjkK3ZvNEJObJ+7b8igjaBQmdj8oKYpcNlR
 Y1tA==
X-Gm-Message-State: AOJu0YySv3AUbvn+7O04YM0sh77bBo4oBJOcNvY0ZHC5ZNaEtzYdDPWc
 A/6wFG/buIkHEVo6IaLSwYKc3vwEdHbN2sUW0cVQRixx5uSD0bqmpYAOt/6dFu8W3/lz+R8T8Ht
 Uq7m+OdZMvY6ApNDKFyfQiqheASAxm7LtBhQb+ZFwZKOzzRMJQVPaEyRV
X-Gm-Gg: ATEYQzwoATLAfEXMG7h7xAfZtegu82fCng2da8WnRkprO30i2DIDuwcPuHy9eyAPzqR
 015ea7KGLZzA2zQWqgZ7Lxn0FyYkW+abEatQVP+1EXHNXg3Ea7pooFSAJ29Ib78+BR6s+s7uDIi
 2KzCtaNLnthpA6tgkm/jo0asRCCPmsqIzQsTThtFvt7wgTqgFbN9c74NhVtnqkjPW5ZIGzIBETP
 qpPCp6aKIqosPT9sQY2A4jcB6OD9HA4ou+iea/7OoNS6r7A1ZS2Q/245ysZ+QzyWM5tU/xlV1++
 oPZVN5Kr69ZamwCmabzbytGm4QZpbg/cf2fjVDy5xOFFZM0duJ6WvTFyF8jfwGzjt1eZld1aFXM
 gpDz4yQ==
X-Received: by 2002:a05:600c:8b02:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-48519888e54mr100972975e9.21.1772721140455; 
 Thu, 05 Mar 2026 06:32:20 -0800 (PST)
X-Received: by 2002:a05:600c:8b02:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-48519888e54mr100972395e9.21.1772721139989; 
 Thu, 05 Mar 2026 06:32:19 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851ec74bc7sm38358185e9.0.2026.03.05.06.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 06:32:19 -0800 (PST)
Date: Thu, 5 Mar 2026 15:32:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 philmd@linaro.org, kraxel@redhat.com
Subject: Re: [PATCH 17/16] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
Message-ID: <20260305153218.15a04d00@imammedo>
In-Reply-To: <872edff8-f5b4-4b94-ac0f-33677fb09131@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
 <20260303140058.2423099-1-imammedo@redhat.com>
 <061e1cc4-7099-4e2e-a164-04c34a6a0c10@redhat.com>
 <20260305131001.71024353@imammedo>
 <872edff8-f5b4-4b94-ac0f-33677fb09131@redhat.com>
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

On Thu, 5 Mar 2026 13:33:21 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 05/03/2026 13.10, Igor Mammedov wrote:
> > On Wed, 4 Mar 2026 18:20:27 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >  =20
> >> On 03/03/2026 15.00, Igor Mammedov wrote: =20
> >>> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>
> >>> v2:
> >>>      - do not check for SMI features if hotplug happens when
> >>>        SMI is not enabled. (matters for qtest and possibly seabios)
> >>>      - removing property also removes default ICH9_LPC_SMI_F_BROADCAS=
T_BIT
> >>>        put default back in place only set it initfn() instead
> >>>
> >>> The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
> >>> in the pc_compat_2_8[] array, via the 'x-smi-broadcast=3Doff'
> >>> property. We removed all machines using that array, lets remove
> >>> that property and all the code around it.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> ---
> >>>    hw/acpi/ich9.c    |  4 ++--
> >>>    hw/isa/lpc_ich9.c | 23 ++++-------------------
> >>>    2 files changed, 6 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> >>> index bbb1bd60a2..87afe86bcc 100644
> >>> --- a/hw/acpi/ich9.c
> >>> +++ b/hw/acpi/ich9.c
> >>> @@ -432,7 +432,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> >>>        if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> >>>            uint64_t negotiated =3D lpc->smi_negotiated_features;
> >>>   =20
> >>> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> >>> +        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
> >>>                !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT)=
)) {
> >>>                error_setg(errp, "cpu hotplug with SMI wasn't enabled =
by firmware");
> >>>                error_append_hint(errp, "update machine type to newer =
than 5.1 "
> >>> @@ -476,7 +476,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHand=
ler *hotplug_dev,
> >>>        } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> >>>            uint64_t negotiated =3D lpc->smi_negotiated_features;
> >>>   =20
> >>> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> >>> +        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
> >>>                !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_B=
IT))) {
> >>>                error_setg(errp, "cpu hot-unplug with SMI wasn't enabl=
ed "
> >>>                                 "by firmware");
> >>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> >>> index 51dc680029..04169ffa24 100644
> >>> --- a/hw/isa/lpc_ich9.c
> >>> +++ b/hw/isa/lpc_ich9.c
> >>> @@ -404,15 +404,6 @@ static void smi_features_ok_callback(void *opaqu=
e)
> >>>        guest_cpu_hotplug_features =3D guest_features &
> >>>                                     (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPL=
UG_BIT) |
> >>>                                      BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_U=
NPLUG_BIT));
> >>> -    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
> >>> -        guest_cpu_hotplug_features) {
> >>> -        /*
> >>> -         * cpu hot-[un]plug with SMI requires SMI broadcast,
> >>> -         * leave @features_ok at zero
> >>> -         */
> >>> -        return;
> >>> -    }
> >>> -
> >>>        if (guest_cpu_hotplug_features =3D=3D
> >>>            BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)) {
> >>>            /* cpu hot-unplug is unsupported without cpu-hotplug */
> >>> @@ -474,14 +465,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, =
void *arg)
> >>>   =20
> >>>        /* SMI_EN =3D PMBASE + 30. SMI control and enable register */
> >>>        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
> >>> -        if (lpc->smi_negotiated_features &
> >>> -            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
> >>> -            CPUState *cs;
> >>> -            CPU_FOREACH(cs) {
> >>> -                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> >>> -            }
> >>> -        } else {
> >>> -            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> >>> +        CPUState *cs;
> >>> +        CPU_FOREACH(cs) {
> >>> +            cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> >>>            }
> >>>        }
> >>>    }
> >>> @@ -685,6 +671,7 @@ static void ich9_lpc_initfn(Object *obj)
> >>>   =20
> >>>        static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
> >>>        static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABL=
E;
> >>> +    lpc->smi_host_features =3D BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)=
; =20
> >>
> >> Shouldn't that rather be a "|=3D" instead of the "=3D" so that we don'=
t lose the
> >> other bits? =20
> >=20
> > Indeed it should be '|=3D',
> > can you fix it up on merge or should I better send fixed up version? =20
>=20
> I tried to fix it, but I still see an issue with the bios-tables-test qte=
st=20
> during "make check" - it does not finish anymore and is finally killed by=
=20
> the timeout. Does "make check-qtest" work for you?

cpu hotplug test did work, let me fix and check tests again=20

>=20
>   Thomas
>=20


