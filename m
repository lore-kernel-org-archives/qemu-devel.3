Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6818C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEnW-0001l5-2F; Tue, 08 Jul 2025 16:20:14 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uZBTN-0003Tk-MK
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uZBTB-0007d0-6D
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751993064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTs6rOWT79ZGR4KYVvYv4H7kZZHu4zBJKCcStY18YK8=;
 b=JxX3RupaR9dM4XWJ7u4MhijVyp++RQMPul9x5v+uHfvaOaCDphV7E8GRZ1T/JTE1Zo7+Hj
 qpaZdW80BIoH5HTYCYkmTeCKR9D1pqV+kN96p35TNGtY0JUpQEcn4k7Ub7fSg/xjO2PeiQ
 bNmC43ausSI7uBzFJi7/R6bUAwFFsDA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-lwTK8TZ-M4ujfVV1MrWEiQ-1; Tue, 08 Jul 2025 09:28:57 -0400
X-MC-Unique: lwTK8TZ-M4ujfVV1MrWEiQ-1
X-Mimecast-MFC-AGG-ID: lwTK8TZ-M4ujfVV1MrWEiQ_1751981337
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7dabc82916cso67583285a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 06:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751981337; x=1752586137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTs6rOWT79ZGR4KYVvYv4H7kZZHu4zBJKCcStY18YK8=;
 b=VdRBrr3Z7CkgnVrP2VqR3yMoKjaBA9ce3ZfsIMKoTm5OgO77/equRjtZghfS9xqa0Q
 tKf9XdOZfhUV8fFd6b4uOhce/w9ced5HR4FO77ugdbrkq9ucJhsYBKWN8xr/83STGpWj
 xVIdiGL8NK1mrEHqzV8OYQaeyPBzDLd+XzBQboY/BpyCFSMMBzMAC3PDoU9Wlt7GGstv
 p2h+HavyMXXKb4KdgV4ZiCR9BdTwZe5fBR/z82Bee8QPUlr3g11rcCfcRBPDrD7atnVh
 RzRxPpIYqD388bZC9OAdK8fvE55/jxioNsz44OfIn8+hy98YFGWIU8M6oOTdJWWxs6L0
 QTzw==
X-Gm-Message-State: AOJu0YyWkkcVzkxjH/Jr5IIeHBMoGrEyrSq2s40/UqBz13Zf7+0bO49u
 Sklkgf/S4aao1NNYRdJIUTFU+uBv+tC2N0xJNlQ+twxbQ/BVcPwUdtZS1WuWYE+6Ucbygl8N7fy
 NpFyi59kMpxHl+Shs18feRuf5/Qo+bKiNL7zyl6qiiA/XYkhcaJ8LMnc2
X-Gm-Gg: ASbGnctHDvZRHCGO7Uk/cuqK5jJbj6jaIZjO6ntcwasse9aB5Osic4MakSzwmRHXZV1
 gAc5kQh3/qy0f4n4rEA6cLlCvUTYLtvSR353fGdCulZDzI6BYDxOsuOnm9ib60AxOtWrLtQdxES
 JVXge2t66iPhZN7o/lHFygZx+/XBc0810O1POji/jiqtHg7xRr21SlyxvMaprS9senxeR6QnOOM
 iKaQ7P2ly9pD/msHLLvzwI48cENzdoRmZYokKGcVndLQQKVvwNM4/sZtW4Do+zqdszLMyK453Cs
 eMJfEj61k4EdhAsOQCD+L5Dm59wy
X-Received: by 2002:a05:620a:84c1:b0:7d5:c13d:291e with SMTP id
 af79cd13be357-7d5df0ccf29mr1868867385a.4.1751981336762; 
 Tue, 08 Jul 2025 06:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw4ISma3/XzrIlUyCJJ+iDvMudrRZA2h1oMCv913hlqu7dcg/MQEYmCEXhIlioreWPEFm0fw==
X-Received: by 2002:a05:620a:84c1:b0:7d5:c13d:291e with SMTP id
 af79cd13be357-7d5df0ccf29mr1868862385a.4.1751981336040; 
 Tue, 08 Jul 2025 06:28:56 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.163.103])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbdc536csm776019085a.49.2025.07.08.06.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 06:28:55 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:28:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
 Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v9 00/16] Introduce support for IGVM files
Message-ID: <2acameuzn4y7dgrvluvna42tcgzi2k6ryin6ykofcrq5vg6x6t@mbr2ewcsayyk>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 03, 2025 at 03:59:33PM +0100, Roy Hopkins wrote:
>Here is v9 of the set of patches to add support for IGVM files to QEMU. This is
>based on commit c77283dd5d79149f4e7e9edd00f65416c648ee59 of qemu.

I successfully tested this series with the IGVM file generated by
COCONUT SVSM [1] in this way:

$ cd svsm
$ FW_FILE=/path/to/edk2/Build/OvmfX64/DEBUG_GCC5/FV/OVMF.fd make
$ ./scripts/launch_guest.sh \
     --qemu /path/to/qemu/build/qemu-system-x86_64 \
     --image /path/to/fedora.qcow2 -- -vga none

Host kernel: https://github.com/coconut-svsm/linux/tree/svsm
QEMU: master (commit df6fe2abf2e990f767ce755d426bc439c7bba336) + this
       series
SVSM: commit 00b24f830a318a40b56b492b917466e28fde12e2
EDK2: https://github.com/coconut-svsm/edk2/tree/svsm
Guest kernel: Linux 6.16-rc5

[1] https://github.com/coconut-svsm/svsm

Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!

>
>Once again, this is mostly a rebase of the previous patch series. However,
>thanks to those reviewers who have provided feedback on v8 which has now been
>addressed in this new version.
>
>This v9 patch series is also available on github: [2]
>
>For testing IGVM support in QEMU you need to generate an IGVM file that is
>configured for the platform you want to launch. You can use the `buildigvm`
>test tool [3] to allow generation of IGVM files for all currently supported
>platforms. Patch 11/17 contains information on how to generate an IGVM file
>using this tool.
>
>Changes in v9:
>
>* Address review comments from v8
>* Add metadata to relevant commits.
>
>Patch summary:
>
>1-11: Add support and documentation for processing IGVM files for SEV, SEV-ES,
>SEV-SNP and native platforms.
>
>12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file.
>
>16: Add pre-processing of IGVM file to support synchronization of 'SEV_FEATURES'
>from IGVM VMSA to KVM.
>
>[1] Link to v8:
>https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg02324.html
>
>[2] v8 patches also available here:
>https://github.com/roy-hopkins/qemu/tree/igvm_master_v9
>
>[3] `buildigvm` tool v0.2.0
>https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0
>
>Roy Hopkins (16):
>  meson: Add optional dependency on IGVM library
>  backends/confidential-guest-support: Add functions to support IGVM
>  backends/igvm: Add IGVM loader and configuration
>  hw/i386: Add igvm-cfg object and processing for IGVM files
>  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
>    IGVM
>  sev: Update launch_update_data functions to use Error handling
>  target/i386: Allow setting of R_LDTR and R_TR with
>    cpu_x86_load_seg_cache()
>  i386/sev: Refactor setting of reset vector and initial CPU state
>  i386/sev: Implement ConfidentialGuestSupport functions for SEV
>  docs/system: Add documentation on support for IGVM
>  docs/interop/firmware.json: Add igvm to FirmwareDevice
>  backends/confidential-guest-support: Add set_guest_policy() function
>  backends/igvm: Process initialization sections in IGVM file
>  backends/igvm: Handle policy for SEV guests
>  i386/sev: Add implementation of CGS set_guest_policy()
>  sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2
>
> backends/confidential-guest-support.c       |  43 +
> backends/igvm-cfg.c                         |  51 +
> backends/igvm.c                             | 988 ++++++++++++++++++++
> backends/igvm.h                             |  22 +
> backends/meson.build                        |   5 +
> docs/interop/firmware.json                  |  30 +-
> docs/system/i386/amd-memory-encryption.rst  |   2 +
> docs/system/igvm.rst                        | 173 ++++
> docs/system/index.rst                       |   1 +
> hw/i386/pc.c                                |  12 +
> hw/i386/pc_piix.c                           |  10 +
> hw/i386/pc_q35.c                            |  10 +
> hw/i386/pc_sysfw.c                          |  31 +-
> include/hw/i386/x86.h                       |   3 +
> include/system/confidential-guest-support.h |  88 ++
> include/system/igvm-cfg.h                   |  49 +
> meson.build                                 |   8 +
> meson_options.txt                           |   2 +
> qapi/qom.json                               |  17 +
> qemu-options.hx                             |  28 +
> scripts/meson-buildoptions.sh               |   3 +
> target/i386/cpu.h                           |   9 +-
> target/i386/sev.c                           | 850 +++++++++++++++--
> target/i386/sev.h                           | 124 +++
> 24 files changed, 2475 insertions(+), 84 deletions(-)
> create mode 100644 backends/igvm-cfg.c
> create mode 100644 backends/igvm.c
> create mode 100644 backends/igvm.h
> create mode 100644 docs/system/igvm.rst
> create mode 100644 include/system/igvm-cfg.h
>
>-- 
>2.43.0
>


