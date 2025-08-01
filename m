Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82881C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 12:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhoqf-00031K-SV; Fri, 01 Aug 2025 08:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhoes-0005tA-HI
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhoek-0002Lp-Od
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754050473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5DxPr+Lt12YB86ZIw/7sgJOe6TrzxX/xm3c2q428kg=;
 b=KgH/F9XGZ/f4ATxZF4ZaBcThWfXskJ9Iy4lnEDMx1QpSwMujVk7wkrIgcLpRuBfcGAqbmn
 rsTAimsmbSnuf0kAY9iSl9UetFu4ychkdzrB5KbGaCB8QhlXFJBowQdaVz+WSl/5f5s05N
 WHnzrz/xbmphiaV70FoCjMx/cfkd5jM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-bFMW66B2NSuhHbldOURxLg-1; Fri, 01 Aug 2025 08:14:32 -0400
X-MC-Unique: bFMW66B2NSuhHbldOURxLg-1
X-Mimecast-MFC-AGG-ID: bFMW66B2NSuhHbldOURxLg_1754050471
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so902745e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 05:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754050471; x=1754655271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5DxPr+Lt12YB86ZIw/7sgJOe6TrzxX/xm3c2q428kg=;
 b=wFxfA9WL6dERquPeeWL98ARF8jJLUK9bmmpNvickmMopxcfrYGVFlZNBHA/heTjvB2
 zgGgp1w5+6K45c0HXaiYn5bvDn6DIHRSvnIMUosBMpLHr2SDmBGSPxmovVXJNWHTMY7P
 clkPyKxRWnGawhzWDLBW/JGgczTBCa2BRqlY7LJfCtsPC1QbXGWvQkOVN11N+rzuT1Rh
 RgsjkYg0fax8a/EWE6EVIriKxvTQoHI24Z0k38xrXhPyDzobqHWjSbKex0NEGOzdEZSQ
 8ogJ2zbRfW0dnxMm5FHeQgMzTYdMWCx7kQJMX4Tv57VPP0f+mwWRGmEteVXTcVX+mFS7
 gKSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpbeoI9HsbnGA904yYX1DBvehRjLldj3ocUKK1JALdu8xA0d374hNLifHooVNuioZPtqaRqQg4zjwZ@nongnu.org
X-Gm-Message-State: AOJu0YxWJkOuJBw+ZAerdm9lLM/aJMA/cUXxWb0BQRmVoVaP7XS5s6fr
 olAi4Y0mQFywGLylmQWfEWx1Jo8ZShCibuFuNJuUbg0JLb3Beda8SKuvrgO6QE3/ftfbLA6SbIF
 YB1mSWuLhtjWU58sCjZrG3WDnNgWQfvLrE3ioD0aznK1mehGYH8J5iDIQ
X-Gm-Gg: ASbGnctYKvZTqUTyUF0gl8DgvQ7urfAEO5ztRmtSJreiIF4Uv4sHX1YLZ1ocLVoOhDL
 18XYhZTfNUvAIrUzDwEbOxApRe0xfqrPVAtWD8Z8DJbtFCp6gtw4xJ4GlgfLpj+qBc7G6U1d7Kc
 oVGAKeZWoQxX2aF5Bd74AAV6xZeUJmXff2v0MMhluMVACMh+HSbrPaNVNpfv23so1k8tCl14ub8
 JmhxSmwVxk+Il9VYo3JQZ1raVki95mT/hbqiDAR6lKOX1sWEHU437UlOrx7+FMaRaa/Ou83TxJ8
 asyRZiOa0nS+9bcU+2DEPCAafZRJYZYb
X-Received: by 2002:a05:600d:108:20b0:456:26ad:46d2 with SMTP id
 5b1f17b1804b1-45893943cefmr60740295e9.6.1754050471204; 
 Fri, 01 Aug 2025 05:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf/uN8giiXWsyE8MRI1JdmXzBuptgXe0qs6y0z4fBmaFxeSJp5O8RxtgWgJSOwmMUJSdr6TQ==
X-Received: by 2002:a05:600d:108:20b0:456:26ad:46d2 with SMTP id
 5b1f17b1804b1-45893943cefmr60740085e9.6.1754050470790; 
 Fri, 01 Aug 2025 05:14:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469093sm5824610f8f.51.2025.08.01.05.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 05:14:30 -0700 (PDT)
Date: Fri, 1 Aug 2025 08:14:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: peng guo <engguopeng@buaa.edu.cn>
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, wyguopeng@163.com
Subject: Re: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <20250801081408-mutt-send-email-mst@kernel.org>
References: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 18, 2025 at 09:35:45PM +0800, peng guo wrote:
> When using a CXL Type 3 device together with a virtio 9p device in QEMU, the
> 9p device fails to initialize properly. The kernel reports the following:
> 
>     virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
>     9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with error -22
> 
> Further investigation revealed that the 64-bit BAR space assigned to the 9pnet
> device was overlapped by the memory window allocated for the CXL devices. As a
> result, the kernel could not correctly access the BAR region, causing the
> virtio device to malfunction.
> 
> An excerpt from /proc/iomem shows:
> 
>     480010000-cffffffff : CXL Window 0
>       480010000-4bfffffff : PCI Bus 0000:00
>       4c0000000-4c01fffff : PCI Bus 0000:0c
>         4c0000000-4c01fffff : PCI Bus 0000:0d
>       4c0200000-cffffffff : PCI Bus 0000:00
>         4c0200000-4c0203fff : 0000:00:03.0
>           4c0200000-4c0203fff : virtio-pci-modern
> 
> To address this issue, this patch uses the value of `cxl_resv_end` to reserve
> sufficient address space and ensure that CXL memory windows are allocated
> beyond all PCI 64-bit BARs. This prevents overlap with 64-bit BARs regions such 
> as those used by virtio or other pcie devices, resolving the conflict.
> 
> QEMU Build Configuration:
> 
>     ./configure --prefix=/home/work/qemu_master/build/ \
>                 --target-list=x86_64-softmmu \
>                 --enable-kvm \
>                 --enable-virtfs
> 
> QEMU Boot Command:
> 
>     sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
>         -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
>         -hda /home/work/gp_qemu/rootfs.img \
>         -virtfs local,path=/home/work/gp_qemu/share,mount_tag=host0,security_model=passthrough,id=host0 \
>         -kernel /home/work/linux_output/arch/x86/boot/bzImage \
>         --append "console=ttyS0 crashkernel=256M root=/dev/sda rootfstype=ext4 rw loglevel=8" \
>         -object memory-backend-ram,id=vmem0,share=on,size=4096M \
>         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>         -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>         -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
>         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> 
> Tested in a QEMU setup with a CXL Type 3 device and a 9pnet virtio device.
> 
> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>


To clarify I am expecting a new version of this.

> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2f58e73d3347..180bc615f3f0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -975,7 +975,7 @@ void pc_memory_init(PCMachineState *pcms,
>  
>      rom_set_fw(fw_cfg);
>  
> -    if (machine->device_memory) {
> +    if (machine->device_memory || cxl_resv_end) {
>          uint64_t *val = g_malloc(sizeof(*val));
>          uint64_t res_mem_end;
>  
> -- 
> 2.43.0


