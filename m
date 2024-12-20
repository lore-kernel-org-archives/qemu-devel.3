Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1E1E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOZoS-0006sY-7k; Fri, 20 Dec 2024 05:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOZoJ-0006rR-Pk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:00:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOZoI-0007T9-BU
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734688837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmFirKV26W/E2lBowMVcDhXhR5xV3pEKHDozlg0t/G0=;
 b=NpX5H/GN/IeJZEANSr5BrTmGEPB+l/zTGS5eJ6EHSlNtloF58dHIEGo1PQaiyDRp2h7E0Y
 Sy6dgQs2KSYWxp1l0+zTCcfClyAOB6Sm8XRTPkJv0Fqo5sOviHdpJ+tSnEqJ/SAbS7EKum
 +KytFHh4sKxV3gBKJ0/GSbxtzOHhSi8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-z2XvCyprOZWmC9vDPTwsaQ-1; Fri, 20 Dec 2024 05:00:35 -0500
X-MC-Unique: z2XvCyprOZWmC9vDPTwsaQ-1
X-Mimecast-MFC-AGG-ID: z2XvCyprOZWmC9vDPTwsaQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa63b02c69cso16023466b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734688834; x=1735293634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DmFirKV26W/E2lBowMVcDhXhR5xV3pEKHDozlg0t/G0=;
 b=qXIk4ByloFmDGOxdwO8z/5yubK5DDWFb2mHrhW/oHd6Ap3dEgs0nPuVVnf4bNp7oBj
 D+xag6ilJOaGQUjn+u916adVM97CXlVjjUMwtmxTGUuHFLOg47PKMi4dGpXxqjiVJ3G8
 V2f8muDEacFzl5voXJ1YziOPZxj/nHbwAfDihDeD+UaNg93FFAHCqz9cnl4LXirTaIMt
 i1e86YO/Z9HHKZ+wejJxUH/2ElzbM4H2nmwGxmFhUDuF+CRawR9HXYiapC5thhtJiYoN
 jqwX6nt1xbN4kgDkdtWXClX6m3IqWL4pmjrFfkEJJqakFTuUJfNPLbjCEDcgDei2TX9U
 Kyrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU37sOLY9GxdYZHH+/5QD6z1XPyYEdMXOk2Oz3646HpLvLWeZdgecRDHy9SNTNeMePLT6bMVj3kOFXp@nongnu.org
X-Gm-Message-State: AOJu0Yxp4iTIJyjy7dLQHZ7k5I5ohNAWpkoqSRDlyT30IF0YjMSE7Kk+
 w9MvY41HexaK1K3t5TRQ6CNhjKzu4pF3p7WIxHY7cx+VUfwtTHyjXt4grpGouPQx9e7MLt173jF
 838THu7NkqsXz8ou5bFOJgxfslBjHy5VK7t94Bwntt/VoeeR6TpcZHaHsYtiflgJRci28hD9zEq
 5RJJN62W6APmBvZFkWmyyzV7RyQpI=
X-Gm-Gg: ASbGncuiJ/DLQ1cmTAjJu+X5VRUPM1wXrluvqTp64OCPNuZz1TU9wj08WYxkRaWiVt8
 Q1t6GinRCvrg5o/mazSe66oZ9TTPKONn3jbY=
X-Received: by 2002:a17:907:3faa:b0:aa6:9540:570f with SMTP id
 a640c23a62f3a-aac081579eemr567803466b.18.1734688833986; 
 Fri, 20 Dec 2024 02:00:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKRsF3CGOxV0V8k+ckEgpJ+rUn7u3PtsSCX49lAoLScQ85jasAhkWyRhr2LqkRxOW3CKPaNe//PD1EfPhic7A=
X-Received: by 2002:a17:907:3faa:b0:aa6:9540:570f with SMTP id
 a640c23a62f3a-aac081579eemr567800666b.18.1734688833571; Fri, 20 Dec 2024
 02:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
 <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
 <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
 <CAK3XEhNN9EO75vgsdRboMZ7nwZbaL0eenSwSy-7Hze-ukyTZsQ@mail.gmail.com>
 <7c1a7e86-8996-43ab-aa07-6763387b2bc5@linaro.org>
 <CAK3XEhOZ50Co0hAS31KYyQA+mgwXSoGCxMu_vhZXmpP0RwT6Mw@mail.gmail.com>
In-Reply-To: <CAK3XEhOZ50Co0hAS31KYyQA+mgwXSoGCxMu_vhZXmpP0RwT6Mw@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 20 Dec 2024 15:30:22 +0530
Message-ID: <CAK3XEhOAD1cueixs6w2ojvudOwz5YrTxzN4x_kgZTkg_EfFXsA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> > Either add the I386 dependency or don't use PC_MACHINE, because on
> > non-x86 targets PC_MACHINE(qdev_get_machine()) will crash.
>
> Ah this is where we have a disconnect. I assumed that
> > pcms = PC_MACHINE(m_obj)
>
> would return NULL on non-x86.
>
> Seems a better way to do this (as is done in vga.c) is to use
> object_dynamic_cast()
> How about
>
> diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> index 0e90bd10e1..19d042b929 100644
> --- a/hw/misc/vmfwupdate.c
> +++ b/hw/misc/vmfwupdate.c
> @@ -32,9 +32,11 @@ static inline VMFwUpdateState *vmfwupdate_find(void)
>  static uint64_t get_max_fw_size(void)
>  {
>      Object *m_obj = qdev_get_machine();
> -    PCMachineState *pcms = PC_MACHINE(m_obj);
> +    MachineState *ms = MACHINE(m_obj);
> +    PCMachineState *pcms;
> -    if (pcms) {
> +    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> +        pcms = PC_MACHINE(m_obj);
>          return pcms->max_fw_size;
>      } else {
>          return 0;
>

For the records, I tested this with arm and the following command line
does not crash QEMU;

./qemu-system-arm -machine virt-9.2 -device vmfwupdate

I have also added a separate functional test to exercise basic device
creation which will be part of v5 when I send it out.


