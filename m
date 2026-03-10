Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55422FD2D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwPO-0003iG-FE; Tue, 10 Mar 2026 08:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vzwPK-0003hv-2o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vzwP2-0000ht-68
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773146493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXZZhVilBn7/gTuoU/EAA/2jPzoF/WmrlclnD2JOkuI=;
 b=Rw34s/SdOWBiFq66txFZm9io9/8BMqOcB6VEY7sOlwIMA+w27wKt/mr4Aq/9S6AyLGofnq
 ggVzLmqP6KRJV1vAOXO0pX4nmS5V8/jmI8wPLmLcqumeY2LRzmqPMn5nHEdeJfa2ZSIFvq
 dEb1gNnBnczkvrVXItoEk+CRJwW4Lzo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-qKvjMqw6OZO2K9UTbo3h5w-1; Tue, 10 Mar 2026 08:41:32 -0400
X-MC-Unique: qKvjMqw6OZO2K9UTbo3h5w-1
X-Mimecast-MFC-AGG-ID: qKvjMqw6OZO2K9UTbo3h5w_1773146492
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b8bc43aeso6927665f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773146491; x=1773751291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXZZhVilBn7/gTuoU/EAA/2jPzoF/WmrlclnD2JOkuI=;
 b=WHelUnS67ebKlMOsaqc1SgdSlnrFTknn1NvlP5SYQKh/7oOghBthNFmzoM8rw0pfoA
 2AYntdDKMQk59uGpcDJCiRjmdI5kFlaCz+nDbrZrCgkduL6ektFDzksMpUfvsLJSBz7j
 Kt2Vct1GZj+RCrbLgWurpnhh0e0O0c5ls/HY1VPbCFxmg/sDKfwEJCcSkiy861afqPUR
 G/hCwgwmpMa16FbFVRLzaGB0sDNw3DWRQeBqjJqL1//9dqZQUNJQ68/NEbT3SGpcnQfU
 9vs9rBLIlyWBlUh9DlKTZwLGoS1Aqt7o8Pyed4JcRWvjHL78lCOZIok2i1eyu3CeTmcf
 ptjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773146491; x=1773751291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AXZZhVilBn7/gTuoU/EAA/2jPzoF/WmrlclnD2JOkuI=;
 b=PO5C4tHUEn/MhoBuNwE1obmUzltlPhidcQocKnsIOumLADXD2GSeWFO3z9CMPefww/
 52OwICM7nDy9uq3jzaMBP5/JCehdCxx9fF+oDmi/ePEPlMh3/4tYUwQO+xu78+gBQtvt
 USsrqCcaoK6gILDcSR4nEiv9WFUOKZPvXjWPanXOhpiAyzoPI5+Hd+a4Rn6JyRtoTNvT
 kZCQhYJifFl05ddAVSHCKGoEo3a77BGHGe3u/8dUxdRghtlJp+uq33hWi+VxlPlMq0N4
 VyDd8afth3vvSM4Nf1MzYLMNV0V2vOwX7gtkbuJ6W6lEs2qS4g9mMAORxkmnGnnDezFC
 ZQsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHdx+mPtmpQh02U8ETTqM9kPH+ED3NidbQv1GqGBKa/qBXs/DhdaU9MIby8QGKbbhRlT8s4KPrhztu@nongnu.org
X-Gm-Message-State: AOJu0Yx25jl7g514HFxLnWjQO33G5Njt0ve7zkyyJSTWUfTi8odVt5TS
 VII1h+hgOI/KGdNHeOWaenoeRt+EYEcTAcpD2ehh23I1znHhcAMl49002eeDDvhCk/UcEbYV/uo
 8nVfkS7ywaSbKiiIg9yiZlWPDO2/M6MU4f7tKtMYujgczUN6y7u9PBIrj
X-Gm-Gg: ATEYQzwbew2KijOw0zqTQsdFiBjxW0yNg7nFnYbJUNCVLHp26T9wwBEsmVJyvZu6v1g
 UJnDtyWIPggveiVUrbRhQgvEvtw4h6fGEMUtpvO1Vg0lvN8iQsM75F+h9w8pEzuK0mRhzDR0MU4
 ydMNIcbLtKLMC2hXStEjw+DqoFzhQbZw+ozes9WHiknEPczlCuGMnYf3dR4zNe3P7j9YjLvwcFF
 A77iNBh4XQpx8hutM/nYIL1hzJVLhm4fuk1O2ErE/8tcf+3rsRuf153lGMfGPBVhKmcHHW183Vx
 PihGRneN7bprRTwVfbjaHQfQKuhsyEFhP/mY+YB5o2z8WS3HLL8lAkRn3+WLCsFU6dbHsWh6nWC
 ItiAiGA==
X-Received: by 2002:a05:600c:8b26:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-4852697a5c1mr242500805e9.27.1773146491210; 
 Tue, 10 Mar 2026 05:41:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8b26:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-4852697a5c1mr242500275e9.27.1773146490740; 
 Tue, 10 Mar 2026 05:41:30 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852378e700sm201351005e9.0.2026.03.10.05.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 05:41:30 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:41:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
Message-ID: <20260310134127.5c1e5976@imammedo>
In-Reply-To: <4fc1a28b-36e3-4d1a-8de7-3c703b589a44@nutanix.com>
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
 <20260227134611.1229390-5-mark.caveayland@nutanix.com>
 <20260304122251.217cd93b@imammedo>
 <c578ab0a-d8b8-4474-8d5b-538a26a85c85@nutanix.com>
 <20260305134913.78e63dd0@imammedo>
 <4fc1a28b-36e3-4d1a-8de7-3c703b589a44@nutanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Mon, 9 Mar 2026 12:24:47 +0000
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> On 05/03/2026 12:49, Igor Mammedov wrote:
> 
> > On Wed, 4 Mar 2026 14:36:14 +0000
> > Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> >   
> >> On 04/03/2026 11:22, Igor Mammedov wrote:
> >>  
> >>> On Fri, 27 Feb 2026 13:44:58 +0000
> >>> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> >>>      
> >>>>   From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
> >>>> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
> >>>> Descriptor is used then the interrupt is considered to be high true, edge
> >>>> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
> >>>> an IRQ then if more than 2 serial ports are added, Windows indicates a
> >>>> conflict in Device Manager and these combinations cannot be used together.
> >>>>
> >>>> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
> >>>> ISA serial IRQ is low true, edge sensitive and shareable, along with a
> >>>> corresponding _PRS resource so that the legacy serial ports also appear
> >>>> at a fixed address. This enables all 4 legacy serial ports to be used in
> >>>> Windows without conflict.  
> >>>
> >>> What happens if we just replace aml_irq_no_flags() with aml_irq()
> >>> (without compat knob and _PRS)
> >>>
> >>> wrt _PRS could you elaborate some more why it's needed and what happens
> >>> if it doesn't exists?  
> >>
> >> Good question. I based the implementation on the technote from Microchip
> >> at https://urldefense.proofpoint.com/v2/url?u=https-3A__ww1.microchip.com_downloads_en_DeviceDoc_00001879A.pdf&d=DwICAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=Nx9ld5Tg6QCayccyKhC9WQbm1DwiJT2Ja3jlwtlv8RkPFaZcU_oTHCkJZetgQLfd&s=k-ubK6tfBDM7A3BN_S3lNy3s-SJGR0fU9O5oj-GWF3A&e=  and
> >> found that it worked fine here on Windows 11.
> >>
> >> My concern from deviating from the document would be that any changes
> >> would work fine on Windows 11, but then fail on older versions of Windows.
> >>
> >> I can try and locate a copy of Windows 8.1 internally if you still think
> >> that is worth pursuing?  
> > 
> > with _CRS present, I don't think we need _PRS especially in absence of _SRS
> > and means to actually changes used IRQs/IO.
> > 
> > What I'd like to avoid is adding not needed code and compat logic
> > if it's possible.
> > The later unfortunately achievable only by tedious testing of
> > the change with older Windows versions (the older it is,
> > the more loose spec interperetation).  
> 
> I've done some more experiments with both Windows 8.1 and Windows 11, 
> and I can confirm that the _PRS isn't needed for Device Manager to 
> detect and configure the serial ports for both OSs.
> 
> However it seems that indicating a shared interrupt with aml_irq() *IS* 
> required for Device Manager to detect all 4 serial ports without conflict.
> 
> I think it would be fine to unconditionally replace aml_irq_no_flags() 
> with aml_irq() in this case, however since the ACPI tables visible to 
> the guest OS will have changed, wouldn't this still require a machine 
> compatibility property? Or do we not care because Windows will almost 
> certainly insist on a reboot for changes to legacy hardware regardless.

usually we do not do compat for ACPItables changes,
unless it introduces breaking change.
drawback of such approach is that sometimes we have to fix it afterwards
in stable when an issue is found.
But on positive side we won't drown out in compat kobs.

considering it is not default config and was broken before,
fixing it without compat knob should be fine.
 
> 
> ATB,
> 
> Mark.
> 


