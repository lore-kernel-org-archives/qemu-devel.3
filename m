Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588FCC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 07:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueqch-0004sW-C5; Thu, 24 Jul 2025 03:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueqcc-0004nB-BP
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueqcZ-0005qv-8P
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753343045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsMs+hTXpOhnnm2IoD38T+4FAzcrBd+o6vY4v5w8Q3Q=;
 b=B7nksCmuTQYcBvuHHqcuyRMuURmJKJ8roJwNSffzxzyAm1hW1LPsewGzjKrqkkSNiD5Dfj
 s9iKTcfFSD1IPZ60EuHAUP51wnI3IJalkoKM+k1ug009wnlZe2gYB1s2jKBaPSkNp1z6rH
 NPgWDW+NMBHVz27GVdKpag1dAI4aBrA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-VQTZiopsPZCv49ysm69tvg-1; Thu, 24 Jul 2025 03:44:01 -0400
X-MC-Unique: VQTZiopsPZCv49ysm69tvg-1
X-Mimecast-MFC-AGG-ID: VQTZiopsPZCv49ysm69tvg_1753343040
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45600d19a2aso4821075e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 00:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753343040; x=1753947840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsMs+hTXpOhnnm2IoD38T+4FAzcrBd+o6vY4v5w8Q3Q=;
 b=Q5oNLrHTMm/bWTllYmhzQ+RGQfcZqyktpN3vT52Bq/3XtczihP1T2NfbpzDOoRtF5e
 9z6E4sKmLwVuVvgdhqxInqhAVT0yiJVFfa95KcOVpwlobr48ZXzLK2VWJR9KOpdS9dx3
 Q3ldILjxFVe/bVPQX3/S91YKH1Ei5T/qELvSJjFJrv/alEXS6VKMEHPfCGGjOrmnIjwa
 Cqhw2z3RB/bx1D5aABxD2wM1IDS6PnKVtkbb8kCzui3T3OvbrcZh4X1h6oymYGhQv1rp
 7XrRCydmV/ZO0WN2uxJXuCKmVEQ0VwwjoyTDUmsnrOULOKb1On3muedmxZmfSBxEBMLg
 6XxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX93sITuNFeoiECt6o0p8YlVECCYYuazSdZvqf0EOgBztIldCjL0urXBzABZj/cyTVWf13+qdPvKNJ2@nongnu.org
X-Gm-Message-State: AOJu0YxWph8BpInWB1ravQYOyHC4DzFeTEuDI6h4r56hyjPFkAtXTQnE
 awOdzkfsDgxl5uLhRYbQFOLNQ8Af8bymPXlpS3uE7u1EvPzWc1ejAOKc5aLRpNriJdEC9s8L6ZB
 9AVTXwcqgNcl0xPXB0oI+t50/qseZyB0GwTi3qaA6ZfjBRjPP8inp0JUP
X-Gm-Gg: ASbGncsyCu7mw5Cp2VSNvlJ87tXh+ajZBWuQtJveGbC1JxDxznH160gZtJLUl4CE/fb
 pLOdVvpKyeVtv2LS1Qi83bCe/IjjITk/IxsUpF/tVJlDY+EXlT/WRiVRo0x1HVFviOmkl0V0loQ
 dV2QitRMu7GessX8DRWfyI9SgFzAF/gdM+Bzd6PJMtuPKvM+kzmr8XIyNlIX/kfttNvQtkGBsEo
 xCsU5w/HDSIA7kKa7A3SIuJgz+B4OXiyNvpWn8NFZbGm0FBKztVzcFazl6NZdQHC87DAxBDBwDe
 f33WvGG1kGDs0IWlgpEW7Xxy3fBrt8EcdsU=
X-Received: by 2002:a05:600c:1c22:b0:455:eda0:8a8e with SMTP id
 5b1f17b1804b1-45868d22a5dmr50546755e9.27.1753343040317; 
 Thu, 24 Jul 2025 00:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUwhURWyMtQLQaEKbzpcAd6IbEiR7/GvDVakSMVnMwZuQouWq1Sn5gifZh2kC45cJaxFdmpw==
X-Received: by 2002:a05:600c:1c22:b0:455:eda0:8a8e with SMTP id
 5b1f17b1804b1-45868d22a5dmr50546525e9.27.1753343039850; 
 Thu, 24 Jul 2025 00:43:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcc43c2sm1246772f8f.83.2025.07.24.00.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 00:43:59 -0700 (PDT)
Date: Thu, 24 Jul 2025 03:43:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: peng guo <engguopeng@buaa.edu.cn>
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, wyguopeng@163.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <20250724034335-mutt-send-email-mst@kernel.org>
References: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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

Cc Jonathan.
Any input on this?


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


