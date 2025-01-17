Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292D5C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjjN-0006GE-6G; Fri, 17 Jan 2025 05:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYjjL-0006G3-RI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYjjK-0006Bc-BM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737110251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIv18XoOYrdqnoTyS3/Z9KVTSp6n+0RJSIQO452ksPg=;
 b=aXlWc8Jo6FMI4smvfytNa0txwDyrzCET+mkFPnzarWEnSeyFM8aqJeHVc343yeHILYiU37
 db1WYhbXvEcRo/gGyBLyPZ3HrIuv8haXHOG0BUGIf5yedv7+VEjn8jEMY658u/p0OWuNDX
 HQ7BCICdTepsrBmJ6CKFMXzlqgQ92M0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-EHwHLvqLPiKNvQHinByUfw-1; Fri, 17 Jan 2025 05:37:30 -0500
X-MC-Unique: EHwHLvqLPiKNvQHinByUfw-1
X-Mimecast-MFC-AGG-ID: EHwHLvqLPiKNvQHinByUfw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so9677105e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110249; x=1737715049;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xIv18XoOYrdqnoTyS3/Z9KVTSp6n+0RJSIQO452ksPg=;
 b=KrUooJ5r6RofXLB6MdInYQm3euC+Ci6XQVfX8i3l6CZivmgmwKX02uVcBjRP1n7EbC
 77WEg0YWCaI3G9XoPQpgyHaX6tcR2RKIpzqqT7blS0vGEOGuGtSHVaMURmPNLCVKgb4B
 Seg8oRhaOPVhNtOA9hj48wBCDVNwkWWEzsNU5zBlyrEfB8xXAhLaoAVn+b0ahqBo39Iu
 DVFuatPUjVlcsNS00V3NerGdk9pPg7ctu+hwfiwJ5uFDkEufeNNjapNSKlGsAM/KIsQ+
 yHBQnFyHIi8MGARAbAdxejWsKC+0wyVGYZbDrPi+ZVsSNv7GXA4T2MohXy4xCtDtHTs6
 uGaQ==
X-Gm-Message-State: AOJu0YyqOnvs+bOdBSNTJDrra1XvB0HsUsENi38W9GFBVU2ntnxQKnZz
 AHTPFuB6rS8i09snSa8J7TmD8pOLV9zRVPQRJWDwFYfc2OCeGX/S2KCdDSk1bPGxREv0WQJ62Vp
 +t7IULprCfNM4+/dGJUW7nnygbHFO95HODX0awt+EQ+BPlKFzArzb
X-Gm-Gg: ASbGncstYKRF5ZYlUHbYjA8G0avhzCVfaBCPtJPYi8M2ph/vPcs0pUEsmhOjkgJxnJ/
 rqEGs4/gQrXHWj/sauunHEbUMy5bL3wY0U+VdxVe7O96HcNv23LSrEbtWAmUnUi+IZWA51+PZ7X
 bNTmxmlB2Mp3hKjYaH4OEwt5GtCwfuLphWevUjgvzYkDnsjo0IMwCMb+Hme5Y5Fm+1Zha3NejhJ
 RqxKrlYsDSRFSjBZXZ3eHqvLxx+3JRlXx5/274P8g52wahBcQU=
X-Received: by 2002:a05:600c:3b02:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-4389144d5a1mr21076655e9.30.1737110248859; 
 Fri, 17 Jan 2025 02:37:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9A0pwmsa2GME/FCih+XyngkAjwxLEiIfgIrEH14VWOBKEogAMBB1kQYm0q6bzpnrmNLcAeA==
X-Received: by 2002:a05:600c:3b02:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-4389144d5a1mr21076265e9.30.1737110248492; 
 Fri, 17 Jan 2025 02:37:28 -0800 (PST)
Received: from redhat.com ([2a02:14f:176:ec4a:872c:4127:e393:c8f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac604sm88949045e9.13.2025.01.17.02.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:37:27 -0800 (PST)
Date: Fri, 17 Jan 2025 05:37:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 00/21] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
Message-ID: <20250117053711-mutt-send-email-mst@kernel.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 16, 2025 at 12:22:26AM +0100, Philippe Mathieu-Daudé wrote:
> The versioned 'pc' and 'q35' machines up to 2.12 been marked
> as deprecated two releases ago, and are older than 6 years,
> so according to our support policy we can remove them.
> 
> This series only includes the 2.4 and 2.5 machines removal,
> as it is a big enough number of LoC removed. Rest will
> follow. Highlight is the legacy fw_cfg API removal :)

tagged, thanks!

> Philippe Mathieu-Daudé (21):
>   hw/i386/pc: Remove unused pc_compat_2_3 declarations
>   hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
>   hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
>   hw/i386/pc: Remove pc_compat_2_4[] array
>   target/i386/cpu: Remove X86CPU::check_cpuid field
>   target/i386/cpu: Pass Error** to x86_cpu_filter_features()
>   hw/core/machine: Remove hw_compat_2_4[] array
>   hw/net/e1000: Remove unused E1000_FLAG_MAC flag
>   hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
>   hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_DISABLE_PCIE definition
>   hw/i386/pc: Remove deprecated pc-q35-2.5 and pc-i440fx-2.5 machines
>   hw/i386/x86: Remove X86MachineClass::save_tsc_khz field
>   hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
>   hw/core/machine: Remove hw_compat_2_5[] array
>   hw/block/fdc-isa: Remove 'fallback' property
>   hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_OLD_PCI_CONFIGURATION
>     definition
>   hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
>   hw/scsi/vmw_pvscsi: Convert DeviceRealize -> InstanceInit
>   hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
>   hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
>   hw/net/vmxnet3: Merge DeviceRealize in InstanceInit
> 
>  docs/about/removed-features.rst |   4 ++
>  include/hw/boards.h             |   9 +--
>  include/hw/i386/pc.h            |  10 ---
>  include/hw/i386/x86.h           |   5 --
>  include/hw/loader.h             |   2 -
>  include/hw/nvram/fw_cfg.h       |  10 ---
>  include/hw/virtio/virtio-pci.h  |   8 ---
>  target/i386/cpu.h               |   1 -
>  hw/block/fdc-isa.c              |   4 +-
>  hw/core/loader.c                |  14 ----
>  hw/core/machine.c               |  18 ------
>  hw/i386/pc.c                    |  42 ++----------
>  hw/i386/pc_piix.c               |  26 --------
>  hw/i386/pc_q35.c                |  26 --------
>  hw/i386/x86.c                   |   1 -
>  hw/net/e1000.c                  |  63 ++++--------------
>  hw/net/vmxnet3.c                |  44 ++-----------
>  hw/nvram/fw_cfg.c               | 109 ++------------------------------
>  hw/scsi/vmw_pvscsi.c            |  67 ++++----------------
>  hw/virtio/virtio-pci.c          |  15 +----
>  system/vl.c                     |   5 --
>  target/i386/cpu.c               |  27 +++-----
>  target/i386/machine.c           |   5 +-
>  23 files changed, 61 insertions(+), 454 deletions(-)
> 
> -- 
> 2.47.1


