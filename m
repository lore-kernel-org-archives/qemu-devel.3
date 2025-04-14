Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86C3C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 21:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4RiV-0004ZV-Bv; Mon, 14 Apr 2025 17:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u4RiS-0004ZF-Ui
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 17:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u4RiQ-00067v-VT
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 17:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744667494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQf4kQG4E7GFG9ZyL7/sMK8EOEt3vEHh9ky5czW1BtA=;
 b=cvFDPbWhUu0a4Z847RVUvc4LHIU88jMQzhl+flmITFWXbPGmI20tggVd9b/C/cypirlpHQ
 ICuVK3sLUR11A1KkrMRrotLkkVjugM5/vN5sjR+ah3Y+QkalaO5i/IjoG39FWsvMm3y+6f
 n9lahhjJZII2vAzjHdyQJq+T92Y9QF8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-rg3k9RU4NdGF1y2rGBjuZw-1; Mon, 14 Apr 2025 17:51:31 -0400
X-MC-Unique: rg3k9RU4NdGF1y2rGBjuZw-1
X-Mimecast-MFC-AGG-ID: rg3k9RU4NdGF1y2rGBjuZw_1744667491
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-72b7c2161ceso1200231a34.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 14:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744667491; x=1745272291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQf4kQG4E7GFG9ZyL7/sMK8EOEt3vEHh9ky5czW1BtA=;
 b=AZTfmFrR7plYQH3bCwMHECTfuO4OOW4hkykiHskBLRRclVMUzLISzQXczXF00IGesM
 w/3iBd+vteXpqyipQO/KPPW3IqKw+ffDUBhD7YIhvAHRH0TXOSSm/WtXeq8KMm/xFJJw
 zNus51gbLyWg1tkF/+zo5SOdvxvj5Rb/YG0Ah7Kmf/Xz9TweUUynbEQZVNkBS++v1v8g
 tGaX85A0dArFBKUeOEJ03RcXgrgAUIxgt23+iYjJcdu6qlQMfZQrWPahE5/zvG0PeO/K
 zoLWd1tcn+4vi0nsSQdHd8X3wmq/15NjhgtX6hgThzw+O4/TUU9fetch6bqJGYSVN/py
 SaQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaiULXNQ+0QFVYwaV14S7p7nFr9iZwutwy3LRGTPvAnzMusSGny8L0dObrpvnWkpX6PJ3Btiwx4aqv@nongnu.org
X-Gm-Message-State: AOJu0YwdVU/qqt1OSDIG5duP0iSGgGWhLLNZ6dlNgYLvkVJ+SgtZ//sa
 9LW3TuIOkirll4jrpFDJu501M9vqTdoJrieAGEixybtEkMfQdgTbhFwBZ59A3ijxS6t58mj6dx9
 k5AlhjsCVmn59MwYYYnlRcPxOLW6RPUOr+ZTesf2RQ+uwlRjO/Hzq
X-Gm-Gg: ASbGncvJ2OpJSBoUMF+04xHHsZem9pcUtO9cxTQXP433XjRsfFRGG5fT7/ZAZ3oSJ+l
 g9OYWkyPztleeQpAYdkef/E3W6zN0zgj1iqEH/hRfYMwRJ32zKKfGE5vAL1KvbmL7EG2LJng6wL
 KMbQX9cuw1pwWG1hjZhJfxQjpvsi8k6LkMqe5hrvssqpIIRauOz6PkaeuuwbzbhIft8W3yqK67D
 G2pkE8I+CLZVGmnYrPTgrX93CSyakQnP/RvyOfm2btgb9sIpgzwFGiPdl/LxoXicbseTrb/OK+d
 t2Cr6reypBrzqKc=
X-Received: by 2002:a05:6870:ce47:b0:2c1:5011:56e2 with SMTP id
 586e51a60fabf-2d0d5c4f9cfmr2813563fac.3.1744667490880; 
 Mon, 14 Apr 2025 14:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGei5IztF2bzPXAN/NwaLhMK/N7udtqJNoPnzPgOF7/JylHCWOIaqru/IWRtWYvCKw4fGoUzA==
X-Received: by 2002:a05:6870:ce47:b0:2c1:5011:56e2 with SMTP id
 586e51a60fabf-2d0d5c4f9cfmr2813557fac.3.1744667490404; 
 Mon, 14 Apr 2025 14:51:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096d54927sm2640441fac.50.2025.04.14.14.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 14:51:29 -0700 (PDT)
Date: Mon, 14 Apr 2025 15:51:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
Message-ID: <20250414155126.6ad0bd9c.alex.williamson@redhat.com>
In-Reply-To: <50fe6263-2459-4e49-a6f3-a1166a0846f1@gmail.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
 <50fe6263-2459-4e49-a6f3-a1166a0846f1@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 13 Apr 2025 19:30:10 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> On 4/10/25 01:18, Alex Williamson wrote:
> > On Wed, 26 Mar 2025 01:22:39 +0800
> > Tomita Moeko <tomitamoeko@gmail.com> wrote:
> >   
> >> So far, all Intel VGA adapters, including discrete GPUs like A770 and
> >> B580, were treated as IGD devices. While this had no functional impact,
> >> a error about "unsupported IGD device" will be printed when passthrough
> >> Intel discrete GPUs.
> >>
> >> Since IGD devices must be at "0000:00:02.0", let's check the host PCI
> >> address when probing.
> >>
> >> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> >> ---
> >>  hw/vfio/igd.c | 23 +++++++++--------------
> >>  1 file changed, 9 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> >> index 265fffc2aa..ff250017b0 100644
> >> --- a/hw/vfio/igd.c
> >> +++ b/hw/vfio/igd.c
> >> @@ -53,6 +53,13 @@
> >>   * headless setup is desired, the OpRegion gets in the way of that.
> >>   */
> >>  
> >> +static bool vfio_is_igd(VFIOPCIDevice *vdev)
> >> +{
> >> +    return vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) &&
> >> +           vfio_is_vga(vdev) &&
> >> +           vfio_pci_host_match(&vdev->host, "0000:00:02.0");
> >> +}  
> > 
> > vfio-pci devices can also be specified via sysfsdev= rather than host=,
> > so at a minimum I think we'd need to test against vdev->vbasedev.name,
> > as other callers of vfio_pci_host_match do.  For example building a
> > local PCIHostDeviceAddress and comparing it to name.  This is also not
> > foolproof though if we start taking advantage of devices passed by fd.  
> 
> Sorry for my late reply. Yes `vfio_pci_host_match` does not work for
> sysfsdev of fd, I will drop this change.
> 
> > Could we instead rely PCIe capabilities?  A discrete GPU should
> > identify as either an endpoint or legacy endpoint and IGD should
> > identify as a root complex integrated endpoint, or maybe older versions
> > would lack the PCIe capability altogether.  
> 
> Older generations seems do not have PCIe capabilities in their config
> space, like the sandy bridge spec [1] does not mention it. I don't have
> a sandy bridge box for now to verify it :(

I have a Sandy Bridge i7-2760QM and can confirm there is no PCIe
capability:

# lspci -vvvs 02.0
00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21d1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 35
	Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 5000 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

# lspci -xxxs 02.0
00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller (rev 09)
00: 86 80 26 01 07 04 90 00 09 00 00 03 00 00 00 00
10: 04 00 00 f0 00 00 00 00 0c 00 00 e0 00 00 00 00
20: 01 50 00 00 00 00 00 00 00 00 00 00 aa 17 d1 21
30: 00 00 00 00 90 00 00 00 00 00 00 00 0b 01 00 00
40: 09 00 0c 01 9d 21 00 e2 90 00 00 14 00 00 00 00
50: 11 02 00 00 11 00 00 00 00 00 00 00 01 00 a0 db
60: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 05 d0 01 00 18 00 e0 fe 00 00 00 00 00 00 00 00
a0: 00 00 00 00 13 00 06 03 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 a4 22 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 01 00 00 00 00 80 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 06 00 18 60 ef da

> > Also I think the comments that were dropped below are still valid and
> > useful to transfer to this new helper.  I think those are actually
> > referring to the guest address of 00:02.0 though, which should maybe be
> > a test as well.  Thanks,
> > 
> > Alex  
> 
> Guest address of 00:02.0 is not mandatory, newer drivers does not depend
> on the address (probably thanks to the discrete GPU, they removed these
> hardcode). Though putting it at guest 00:02.0 is still recommended.
> I would prefer not making this a limit.

I suppose it was never enforced beyond the comment, so if you vouch
that it's not mandatory, let's not make it a requirement now.  Thanks,

Alex


