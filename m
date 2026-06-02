Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78965CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUQVV-0006x2-Mr; Tue, 02 Jun 2026 10:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUQVS-0006vv-2v
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUQVQ-0001Qp-1R
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780412050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mf+srgazukN0W7EULQMT8jH2Ug1Hrj0u2E6Ql06yqRY=;
 b=iQLaHxlgcfIim/nXaxFjE+37hFggyyCqPvt0hwRPd/9Ycq6DWRuiXfOFZD73Vt8G26PeEY
 7qc44wm1XaVAZ5uKUkYeo2DuiSC2ClX2GhSG9Z15N0ICHQbrljnYJkM8WkjY1L4c5jxalB
 QdCd851QigO4u7M8175nDPOElDZtGqw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-TFyQG74GPg-AJBEdx8WpGA-1; Tue, 02 Jun 2026 10:54:09 -0400
X-MC-Unique: TFyQG74GPg-AJBEdx8WpGA-1
X-Mimecast-MFC-AGG-ID: TFyQG74GPg-AJBEdx8WpGA_1780412048
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45eee3f9f03so4786000f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780412048; x=1781016848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf+srgazukN0W7EULQMT8jH2Ug1Hrj0u2E6Ql06yqRY=;
 b=PHRfRl2/E3ForihEk5RY/Wqs5IfCcN+eT/Pr/K5IJm8/e0i83jeGtBQUj/TzZ1J0gI
 spRCVDmSuqXYY1nTdk6vtwXmjbwHsnuHA1nskb5Tq0+sq+r9MAVF29+ZCtocRm7LtgY3
 X4EsHesdtRWJqzYqsmQAU1dvq6ekPPHgvwK3eWzvzIfs2e++sDMdWGL45smLOes03xSR
 iE9s/LhdjY8gzJJcSCMioNdRlow7fNlTVC1EbCv1a6TM9yDSe76XVrQ6OSrDQ9wivlvt
 Wc2jcuYsPEIhenO0VfiHIGH4ZYlG0T4Etn47g8d4zPsCG01ompUGHcPY6Ty4vVj5r9J9
 Q5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780412048; x=1781016848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mf+srgazukN0W7EULQMT8jH2Ug1Hrj0u2E6Ql06yqRY=;
 b=DfZGUr9YqVK1/J7MvHhCDlxshzg1xh/YbRFSjdtT6kQyc2naRoPfGnegpySxXbvui5
 sLB1Q+wsJF8IuYPJ3D0m4aYV3wvB//sm1YTcW7A+lGzuI9cQH9jCiiYpvAiajsBOdjyy
 ZcCsxHLLaaR5nRPtAAog63dl13YzNIaPMYppzwG/cs9peNN2k6Apx0zw4FWPiRwEnCJ6
 0ZzDDJz9OQ2rkJKfTUiuDsvZb2u6c8ppsasWiPG9tzSrLk1xksNzoTVUPj1ubEH8TwWO
 fKLKt8e3EbUiyd7oCwhMBggC95u4k8gxwGXR//j4IC4QTczBWEkzPs6fAmJ8jGlzNna+
 gixA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qUhWpJWWPDKXmbDr4jVhyNYNVFcSllP4EFiZyLcGHntH74rzqTChHHh2md6E4loDNCwsdBAsvutX2@nongnu.org
X-Gm-Message-State: AOJu0Yw5a2Jrs9T0rWxmEVKr6RIF+G/BOLWQRXRul9aV4uM0IpC582jg
 cCUMynF2hgPYP1F/EIR7njoR/WiY4x0dTMItf2Fov2/zv9VKmjdTkAbzB5+DeTqJPTKJxkmAtwB
 Yz8jjqrk2SaLMIl9i2Y4Hb2UGeB3vQkQ8rwH1npPO1WQTe3Q2mwcn1s9P
X-Gm-Gg: Acq92OG2dIRuXGuyoEoQ4y9TNdgMGb0ieX4sViIFWsejKhkoN108irZZ51aZbOUIyIC
 GaM/4rdFyTuzCEsUnAnOUdpTR6wEd17x+eAY0S8D+tyrEXg7yUyC9QTfcMTxVyTDFrEkIrs24DI
 Opg30dE+CLF3NOh06e3zwpi4P+PPVdtRCartVOz4jOWYQyRbrGylsrdX/Ey72/ynl5zQrKUrNUX
 C+JzzAt5DolBim9lz/TbdYS/gyradlzi4I3D+vrl2wUpqE7wE/Yeaw5W9DTWNXYy5jxXQI+X/Ex
 cvIqPaxxZnXXPYaN9RS/cHTOfmsBTqj5/Tlb9g9ParqzdbFfhzP9qhBgLsaCh0wPHoq8Z6MwIST
 zuJoONELtD1Dwz8m9
X-Received: by 2002:adf:f611:0:b0:45e:f228:830d with SMTP id
 ffacd0b85a97d-45ef6b55ce3mr21835046f8f.23.1780412047847; 
 Tue, 02 Jun 2026 07:54:07 -0700 (PDT)
X-Received: by 2002:adf:f611:0:b0:45e:f228:830d with SMTP id
 ffacd0b85a97d-45ef6b55ce3mr21834998f8f.23.1780412047362; 
 Tue, 02 Jun 2026 07:54:07 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34bd320sm32567500f8f.13.2026.06.02.07.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 07:54:06 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:54:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sebastian Ott <sebott@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com, Eric Auger
 <eauger@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug
Message-ID: <20260602165404.3a8c8fc8@imammedo>
In-Reply-To: <48595a74-78b5-6136-8752-0a73501b9531@redhat.com>
References: <0de640a2-8807-69cf-4429-672263e3e759@redhat.com>
 <CAFEAcA-PkO3aeGoaAzpbJGrrE-_-RjJy9Q4D4MnQ=9W61--3hA@mail.gmail.com>
 <48595a74-78b5-6136-8752-0a73501b9531@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 29 May 2026 15:03:46 +0200 (CEST)
Sebastian Ott <sebott@redhat.com> wrote:

> On Thu, 28 May 2026, Peter Maydell wrote:
> > On Thu, 28 May 2026 at 10:23, Sebastian Ott <sebott@redhat.com> wrote:  
> >>
> >> ACPI PCI hotplug of a PCI device using a bar > 2M fails on ARM
> >> with a resource allocation failure in the guest kernel (Linux):
> >>
> >> qemu-system-aarch64 [..] -device pcie-root-port,id=rp1,bus=pcie.0 \
> >>                     -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on \
> >>                     -pflash /usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.qcow2
> >>
> >> (qemu) device_add pci-testdev,bus=rp1,membar=4M
> >>
> >> [   55.106283] pci 0000:01:00.0: [1b36:0005] type 00 class 0x00ff00 conventional PCI endpoint
> >> [   55.107627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> >> [   55.107864] pci 0000:01:00.0: BAR 1 [io  0x0000-0x00ff]
> >> [   55.108015] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x003fffff 64bit pref]
> >> [   55.118609] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
> >> [   55.118653] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
> >> [   55.118671] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
> >> [   55.122828] pci 0000:01:00.0: BAR 1 [io  0x1000-0x10ff]: assigned
> >> [   55.127090] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: releasing
> >> [   55.127098] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
> >> [   55.127102] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
> >> [   55.127106] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
> >>
> >> This behavior is exactly the same on x86 - except the busses are created
> >> with a default window size of 256M there. If the PCI devices being
> >> hotplugged use a bar > 256M you get the same failure like on ARM.
> >>
> >> The workaround on x86 is to specify "pref64-reserve=" for the PCIe
> >> root-port. On ARM this is currently ignored.  
> >
> > From the perspective of somebody who doesn't know much about
> > ACPI or PCI, this commit message doesn't really tell me why
> > QEMU needs to change. The above reads like "this is a kernel
> > problem" to me. Why is the kernel unable to allocate this BAR?  
> 
> Lack of resources on the parent bus/bridge device - the bridge windows are
> 2M per default on ARM. The native PCIe hotplug controller would add the
> additional resources to the parent bridge and retry allocation. The
> ACPI PCI hotplug controller does not do that. I'm curently playing with
> a hack that adds this to acpiphp.

some history:
ACPI PCIHP in kernel doesn't support bridge window resizing, and my attempt to
make it support bridge window resize like native PCIHP, didn't pan out as that
caused a regression. PCI resource assignment/enumeration in kernel is quite
a mess and when device enumerates in a few different ways, it's hard to
figure out edge cases. (I never had time to followup with  the case that got
patch reverted)

On Windows (past Vista) bridge window realloc worked fine for me
(Though I can't remember out if that applied to ACPI PCIHP or just native pcihp)

Now back to the issue at hand, the best would be (in case of ACPI PCIHP):
  * make ARM version of firmware do what x86 does (it had the same problems). 
  * make pref64-reserve= work for ARM as well, it's just a hint for firmware
    but mgmt to plan ahead and create a bridge with larger window
    assuming it knows what it's going to hotplug later.

but really if you don't need ACPI specific features (acpi-index, faster plug/unplug,
hotplug on older Windows versions that didn't have native PCIHP), then stick
with native pcihp.

> 
> Sebastian
> 
> 


