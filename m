Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239D8CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl8Ej-00042s-26; Mon, 02 Sep 2024 10:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl8Ei-00042L-2g
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl8Ef-0006nF-HD
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725288051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9/K3nLkP2+TpiC4/+hRJeLuQmqiE/fNtJIr8lZ/2rw=;
 b=Qcgn22UIjCJVDa+m+CquouQW8D+kIEegkBZQj0qH0A0ZUENqLWyT28ueJuvXIIi50ZV2MC
 vCYwBgBLlZY+naKkxnXkFVI+XODGGr1w/l2g6QXKKDlGj8o2ghLLLgK4bcFonQ8J4fhVtc
 e1zSYWKDeGFjdqe2Qf86YqwrkoVrE2A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-PeLQNHehN8edx-k6l2J0dQ-1; Mon, 02 Sep 2024 10:40:50 -0400
X-MC-Unique: PeLQNHehN8edx-k6l2J0dQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374ba33b2d2so1711425f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 07:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725288049; x=1725892849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9/K3nLkP2+TpiC4/+hRJeLuQmqiE/fNtJIr8lZ/2rw=;
 b=mbv1flg5p/9h5VR0N3/yQxwng96yFYKjKKg1qHl0HRAfYdBuss5KZoVlDGdervw7dc
 7i6BtSz14XWC0w5Vg9uOYaQlaRZ+F9n66VOGcKv+Xay4YA7XtZzxqSy9v+qHC95+4J4D
 uydKHy24Mf9YsnTgzehy1sk55vbBkOaeA14VGY7sK2IFbPps9I6nHEBrRYJwyDSEi6+O
 nuWSVz2BVSvL48btpEOs2j+PUvoa3KgiskE+5Or3BINWE97eDaxeQt1nMv2SVBO+4UIa
 3pVR+r+CWr1bceNQLlZN1ruRfJI0526ztPa213sb213U6a7XLk8YyikCjzmyLXFhCUeD
 l6pw==
X-Gm-Message-State: AOJu0Yzf4wh/QtWbnmDRYO7joVILDYP6vGvp8w+CRrRJSYY7HV1/KJOV
 cemeHyTq7bK/TkNrKwSVVxKniIAWpKjR1+5xLYvnzH5jh/JlnDhtsb/FtXCu8tX1g47+nvJUf3S
 V3TG6sc9QT4/F1JWw4V60v5tH9XjMbl4ZXj6u9R3bLE0u68Z/sM5U
X-Received: by 2002:a5d:6704:0:b0:374:ce15:998c with SMTP id
 ffacd0b85a97d-374eccc24aamr171491f8f.30.1725288048868; 
 Mon, 02 Sep 2024 07:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQgCBypxxEwQCHuT/AxogN7Ast8Zy5lKmy/pocVlF4aUnshVXxYtOdIATD2FX8Xc46TF+E6w==
X-Received: by 2002:a5d:6704:0:b0:374:ce15:998c with SMTP id
 ffacd0b85a97d-374eccc24aamr171461f8f.30.1725288048007; 
 Mon, 02 Sep 2024 07:40:48 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749efb15b8sm11595656f8f.105.2024.09.02.07.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 07:40:47 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:40:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 00/16] Introduce support for IGVM files
Message-ID: <t7dtj62vnfor6phu4zyosya7tgf37qk6o63d5nhw4n5hjkric5@ur4qscyy5g5s>
References: <cover.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 13, 2024 at 04:01:02PM GMT, Roy Hopkins wrote:
>Here is v5 of the set of patches to add support for IGVM files to QEMU. This is
>based on commit 0f397dcfec of qemu.
>
>This version addresses the review comments from v4 [1] plus changes required to
>rebase on the master commit. As always, thanks to those that have been following
>along, reviewing and testing this series. This v5 patch series is also available
>on github: [2]
>
>For testing IGVM support in QEMU you need to generate an IGVM file that is
>configured for the platform you want to launch. You can use the `buildigvm`
>test tool [3] to allow generation of IGVM files for all currently supported
>platforms. Patch 11/17 contains information on how to generate an IGVM file
>using this tool.

I left some minor comments, the patches I didn't respond to are too much
in detail for my knowledge, but I looked at them and I didn't find
anything obviously wrong, so for those feel free to add:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>Changes in v5:
>
>* Fix indentation and apply minimum version check for IGVM library in meson.build
>* Remove unneeded duplicate macro definitions in confidential-guest-support.h
>  and igvm-cvg.h
>* Make igvm-cfg object file parameter mandatory instead of optional. Removed
>  unused 'igvm_process()' function that checked the file was provided.
>* Rename all QEMU IGVM functions and structs using QIGVM/qigvm prefix.
>* A few small readability/style fixes.
>* Address review comments on error handling, including removal of the v4 patch
>  6: "Fix error handling in sev_encrypt_flash()".
>* Update `FirmwareMapping` union in firmware.json to include `igvm`.
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
>[1] Link to v4:
>https://lore.kernel.org/qemu-devel/cover.1720004383.git.roy.hopkins@suse.com/
>
>[2] v5 patches also available here:
>https://github.com/roy-hopkins/qemu/tree/igvm_master_v5
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
> backends/confidential-guest-support.c      |  43 +
> backends/igvm-cfg.c                        |  52 ++
> backends/igvm.c                            | 964 +++++++++++++++++++++
> backends/igvm.h                            |  23 +
> backends/meson.build                       |   5 +
> docs/interop/firmware.json                 |  30 +-
> docs/system/i386/amd-memory-encryption.rst |   2 +
> docs/system/igvm.rst                       | 173 ++++
> docs/system/index.rst                      |   1 +
> hw/i386/pc.c                               |  12 +
> hw/i386/pc_piix.c                          |  10 +
> hw/i386/pc_q35.c                           |  10 +
> hw/i386/pc_sysfw.c                         |  31 +-
> include/exec/confidential-guest-support.h  |  86 ++
> include/hw/i386/x86.h                      |   3 +
> include/sysemu/igvm-cfg.h                  |  47 +
> meson.build                                |   8 +
> meson_options.txt                          |   2 +
> qapi/qom.json                              |  17 +
> qemu-options.hx                            |  25 +
> scripts/meson-buildoptions.sh              |   3 +
> target/i386/cpu.h                          |   9 +-
> target/i386/sev.c                          | 850 ++++++++++++++++--
> target/i386/sev.h                          | 124 +++
> 24 files changed, 2446 insertions(+), 84 deletions(-)
> create mode 100644 backends/igvm-cfg.c
> create mode 100644 backends/igvm.c
> create mode 100644 backends/igvm.h
> create mode 100644 docs/system/igvm.rst
> create mode 100644 include/sysemu/igvm-cfg.h
>
>-- 
>2.43.0
>


