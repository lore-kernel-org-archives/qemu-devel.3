Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7B9C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyBq-00080m-I2; Fri, 30 May 2025 07:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyBl-0007xq-FT
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyBj-0002fF-PT
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748605574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7AVWysd1BqZq+3s0pq68jhe+Q+/S7SxUFoVwp9karhY=;
 b=LO3AfS2DnJbBGlssiKy1f4t/eJKY/YkDtemnipHKlOf9pdIgk3H15YzpxR6VD00PDDEoVe
 KpffuK5Ldknm+0euspCAW/OS1znQPNizOzGyniVkt0ixLuJvuiSY7SnCHNQzgYOrNt33LB
 YRRRKL7wntI6Ni8XvA6N/+bz37kBEb0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-B-elROjIPTmvxUZQNyTN4A-1; Fri, 30 May 2025 07:46:13 -0400
X-MC-Unique: B-elROjIPTmvxUZQNyTN4A-1
X-Mimecast-MFC-AGG-ID: B-elROjIPTmvxUZQNyTN4A_1748605572
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a367b3bc13so822022f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748605572; x=1749210372;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AVWysd1BqZq+3s0pq68jhe+Q+/S7SxUFoVwp9karhY=;
 b=AT4Wi/wqaHBtfvIuEpxdfMUV83KwjmBUMxvSowMX3RO+Z1zHgpJe2l7GP+35cZVXaI
 +fcWhGIDh+FQQLLysoHO76E2E8ghxYw7hDq8/LJiqHW0/qTbrWx3MJppue6Hmd+VJyi9
 O0gGvqNnGZ3k+wKE2cjjV1w0bAhzfRzzmQEQhhWylzAMjI34ILqqnPeVarBeUJIjXkOL
 V8CiLwAOQpaPrMyESn8g7s2xliJcbw7KOwNNyclW5lhZmIJAnweh+F1p/OhhId5Xd38N
 3IFx+DAJzR1xcfuM+v6pA2BZj89ZUFGX4x9XWG9+3AZhpIERZxVi1QQXFv9eTzwrezMa
 2Dmw==
X-Gm-Message-State: AOJu0YxeFg3r7FDpCzGnp+mQIpNB4/uCpo8fXvDY9TYmKQf5GNeXY56n
 XocnA5f7kOAdwWYsNU2SwIl4SXK5C/XHKu4/jp7Kxs7kRWsLRUa7+WiRDcmOJlvHrHpgq21W6s5
 di+F9TQLDkJ6Q5rVF1rQuu9OHyXgpGpzsObmNLboBd4s4E0BKH33myIoo
X-Gm-Gg: ASbGncunpjQRkP7aJjWBZtTnCl/OlBFSpt0/Yf+HjQKR4gNOfy8Lv0U1fiAUOrlI0Kl
 nOO1fPZrSmjwaOu5aTBL9WGIkclKr7/pDXLRchZAK3GGwWyLfrJcJbE9qRMG6c4+AM7iReFGCp+
 +d66CfHx2gaqIeY6xBnEEmemA0trXODnbHjrJ52NmIpwebscRHGu53rDnX+LZBHCAoPnpx5qyHU
 4iUiwN1sPJc1L+lvMXR5IcxG0CXA83mvg1TgvK6Zjow2ehmMGi4j4YpXouzWs9uWHbeCVkzf5n8
 2bFZdA==
X-Received: by 2002:a05:6000:4020:b0:3a4:d6ed:8df8 with SMTP id
 ffacd0b85a97d-3a4f7a9c3eemr2323700f8f.39.1748605571688; 
 Fri, 30 May 2025 04:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKTkmnptDu/9HlSy8Q7TclLS2UWYEHGLMYx0Oi8QBACNCJlGZhDSJ5KLdSNnOjJ+YWLeDt0A==
X-Received: by 2002:a05:6000:4020:b0:3a4:d6ed:8df8 with SMTP id
 ffacd0b85a97d-3a4f7a9c3eemr2323662f8f.39.1748605571289; 
 Fri, 30 May 2025 04:46:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009fbf7sm4540624f8f.83.2025.05.30.04.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 04:46:10 -0700 (PDT)
Date: Fri, 30 May 2025 07:46:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
Message-ID: <20250530074537-mutt-send-email-mst@kernel.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 12, 2025 at 10:39:29AM +0200, Philippe Mathieu-Daudé wrote:
> (series reviewed)

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


Thomas, since you wanted to do it, pls feel free to merge.


> Since v3:
> - Fixed 2 issues noticed by Thomas (floppy fallback, e1000)
> 
> Since v2:
> - Removed qtest in test-x86-cpuid-compat.c
> 
> Since v1:
> - Fixed issues noticed by Thomas
> 
> The versioned 'pc' and 'q35' machines up to 2.12 been marked
> as deprecated two releases ago, and are older than 6 years,
> so according to our support policy we can remove them.
> 
> This series only includes the 2.4 and 2.5 machines removal,
> as it is a big enough number of LoC removed. Rest will
> follow. Highlight is the legacy fw_cfg API removal :)
> 
> Philippe Mathieu-Daudé (19):
>   hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
>   hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
>   hw/i386/pc: Remove pc_compat_2_4[] array
>   target/i386/cpu: Remove X86CPU::check_cpuid field
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
>  include/hw/boards.h                 |   9 +--
>  include/hw/i386/pc.h                |   7 --
>  include/hw/i386/x86.h               |   5 --
>  include/hw/loader.h                 |   2 -
>  include/hw/nvram/fw_cfg.h           |  10 ---
>  include/hw/virtio/virtio-pci.h      |   8 --
>  target/i386/cpu.h                   |   1 -
>  hw/block/fdc-isa.c                  |   4 +-
>  hw/core/loader.c                    |  14 ----
>  hw/core/machine.c                   |  18 -----
>  hw/i386/pc.c                        |  42 ++---------
>  hw/i386/pc_piix.c                   |  26 -------
>  hw/i386/pc_q35.c                    |  26 -------
>  hw/i386/x86.c                       |   1 -
>  hw/net/e1000.c                      |  93 ++++++++++--------------
>  hw/net/vmxnet3.c                    |  44 ++---------
>  hw/nvram/fw_cfg.c                   | 109 ++--------------------------
>  hw/scsi/vmw_pvscsi.c                |  67 +++--------------
>  hw/virtio/virtio-pci.c              |  11 +--
>  system/vl.c                         |   5 --
>  target/i386/cpu.c                   |   3 +-
>  target/i386/machine.c               |   5 +-
>  tests/qtest/test-x86-cpuid-compat.c |  14 ----
>  23 files changed, 77 insertions(+), 447 deletions(-)
> 
> -- 
> 2.47.1


