Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26303D767FF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 13:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWaEw-00009a-JB; Fri, 19 Dec 2025 08:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWaEq-00009M-Gg
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 08:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWaEn-0001Ob-Lx
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 08:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766149778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uffUYzH4hZM4uYB5GjzxhfgSUKIVobgoDQM6/VUOOxo=;
 b=dCc/8fHdl1jcp3X9n1GSqfOV5z2HkmDOI7PalgwP7IAKHNrAleo+HVOuNP4KBbOrJ7FcB6
 eSXnM7i14nDqoohlArtM6dNfOEc6OmNujIjIHSkmxoVcjHQQJ6PKfW+FM20arGmUEE58Gm
 HEwdiGEEHlnyj+Ljr3Zqqabet7ZnP3o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-Q0BL-PsSM76MLWs1cwVcIA-1; Fri, 19 Dec 2025 08:09:36 -0500
X-MC-Unique: Q0BL-PsSM76MLWs1cwVcIA-1
X-Mimecast-MFC-AGG-ID: Q0BL-PsSM76MLWs1cwVcIA_1766149776
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f4609e80so821543f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 05:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766149775; x=1766754575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uffUYzH4hZM4uYB5GjzxhfgSUKIVobgoDQM6/VUOOxo=;
 b=Zl7J1ZNreN6okcN8OgTYxZpGxuXwjpetbSb2UOBxNQsw/I2rvX5+LXF9rnGV7Wmt1h
 NrjwGweMGa0SfyIO+BLK7M0loBP7bnBs6wUalSjGQY/fCh5uUAaRY21N6Oz3brAeIu9T
 3Hbt0r9GS1mCVxgxkbvW13lsta9cDYrYNEUYKt3nQM0m9s7aOUVFEZyhkOiDHX3FzXws
 +WBd2fbjggqzdMPiWeYIk6LmaVYKE7MyQeMBXeXTU9Uu2jw1WdN/0A0ujEe6PnvMCDlF
 x7fK8Jf0wNXjCBj31bdE9Z87p3AOxq+B4i0PcG8eCJqS5DN5ZWbyTJaW3cYGu/mvUkBS
 7SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766149775; x=1766754575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uffUYzH4hZM4uYB5GjzxhfgSUKIVobgoDQM6/VUOOxo=;
 b=ogSa3EDmHErWcW+roORXwXulu1e9revAe9Hb+8XipLULQSHqkhYSj8S1WxjCBp/Daj
 v7P4OKFgN5dpIgLW9a3uexAXJF2RReGqkBoYlrxNSjHjCDD3nxWCbWRTu7nnA7AEmjFw
 Tf1wTYumAexqIhBQ5zM2WQG5gJZUF+dKzI1Vocr0CtDRCh1E3ubycxzsqH9RTOlPVsUY
 k+z4P2Aan3lTAtz4X4VZo9Hx+Y00EwHQws+NFrcHn6YYnQrQ5Lgg7l3BX3fKaKVhaB7m
 f4Js6GlTrGAGihIfn/E7jpgq0FPmHSGEcvTfkgQrZE9zlGZMpBycLLB4N+yG801FBIFu
 3kzw==
X-Gm-Message-State: AOJu0Yz2UFM96yUJcv/eg3GiTxs62KEnfmQwrDaEJ4Q6q3Kg84dBT1Hn
 fpcIcnxKwPXYz0u5AQF+6E/6ho+19g5Uh8mU0OiAxC/59YYl/GdtzhIdxEgTPJhjLtjcxGAnCxq
 uj2cqIpkjnQQ7uJdtJOlfW86ws8Uqs4K5gQLWADvJwwYM0rxyrlk2PDJr
X-Gm-Gg: AY/fxX6MbD0V2ANwuQ0fNkmtOOfAL1GLy+9K5WWjVT50nETV9b/TNnsVsTflcCD4dDp
 lBkpDwhwn9e/Wp1mic2YEWEL7qEvMf/I1XJbxkgbS8hlt4fdUAH5XUma6qSUFfWlfz0WaVRsQx8
 QBQStf8INDwfa0invgo+0t5vNMbtt20u0ipr89cDEJQkvTfGc0JLY9csfgDXlh8bT5wBeJMWi/E
 GbvMgINCbX2OjQXduNeOHQLts0Tgq5ynh5KKy7UqvIXvsuuqqpU2Fzu8SWMHswbseMsughPQc8F
 c1FilDXRL6PX5r3GM5tQ2UwufLiALzgV2ynU964WZ8ptB5pgPpa3asqBTJDlZiSiENCsQA==
X-Received: by 2002:a05:6000:2403:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-4324e70492amr3602466f8f.62.1766149775432; 
 Fri, 19 Dec 2025 05:09:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHunbsxrkvblgZHsEGkkAXpuWl8VogPXtLRDJCnAmHnAaCs1luS+kVWJ0dtZxScRakdkDjERg==
X-Received: by 2002:a05:6000:2403:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-4324e70492amr3602430f8f.62.1766149774972; 
 Fri, 19 Dec 2025 05:09:34 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82fddsm4861315f8f.25.2025.12.19.05.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 05:09:34 -0800 (PST)
Date: Fri, 19 Dec 2025 14:09:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>, Luigi
 Leonardi <leonardi@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 0/3] igvm: Supply MADT via IGVM parameter
Message-ID: <20251219140933.7b102fc5@imammedo>
In-Reply-To: <20251211103136.1578463-1-osteffen@redhat.com>
References: <20251211103136.1578463-1-osteffen@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 11 Dec 2025 11:31:33 +0100
Oliver Steffen <osteffen@redhat.com> wrote:

> When launching using an IGVM file, supply a copy of the MADT (part of the ACPI
> tables) via an IGVM parameter (IGVM_VHY_MADT) to the guest, in addition to the
> regular fw_cfg mechanism.
> 
> The IGVM parameter can be consumed by Coconut SVSM [1], instead of relying on
> the fw_cfg interface, which has caused problems before due to unexpected access
> [2,3]. Using IGVM parameters is the default way for Coconut SVSM; switching
> over would allow removing specialized code paths for QEMU in Coconut.
> 
> In any case OVMF, which runs after SVSM has already been initialized, will
> continue reading all ACPI tables via fw_cfg and provide fixed up ACPI data to
> the OS as before.
> 
> This series makes ACPI table building more generic by making the BIOS linker
> optional. This allows the MADT to be generated outside of the ACPI build
> context. A new function (acpi_build_madt_standalone()) is added for that. With
> that, the IGVM MADT parameter field can be filled with the MADT data during
> processing of the IGVM file.
> 
> Generating the MADT twice (IGVM processing and ACPI table building) seems
> acceptable, since there is no infrastructure to obtain the MADT out of the ACPI
> table memory area during IGVM processing.


looking at #2 and #3, it seems that root cause is still unknown,
one should be able read tables multiple times from fw_cg.
(so there is a but in QEMU or guest doesn't load ACPI tables correctly).

Also seeing that regenerating tables every time helps,
it hints that PCI subsystem is not configured when tables read 1st time.
Why that causes guest kernel errors is still unclear.

Main conditions to get acpi blob representing is that they should be read
after guest firmware enumerated/configured PCI subsystem and
firmware should use BIOSlinker workflow to load/postprocess
tables otherwise all bets are off (even if this series works for now,
it's subject to break without notice since user doesn't follow proper
procedures for reading/processing ACPI blob).
Hence I dislike this approach.

Alternatively, instead of ACPI tables one can use FW_CFG_MAX_CPUS
like old SeaBIOS used to do if all you need is APIC IDs.
Limitation of this approach is that one can't use sparse APIC ID
configs.
Benefit is that no QEMU change is required whatsoever.

If you still wish to proceed with standalone MADT approach,
please add to justification exact root cause of what corrupts
ACPI tables blob later on. With that, It would be easier to decide if
standalone MADT is an acceptable hack. 

> [1] https://github.com/coconut-svsm/svsm/pull/858
> [2] https://gitlab.com/qemu-project/qemu/-/issues/2882
> [3] https://github.com/coconut-svsm/svsm/issues/646
> 
> v2:
> - Provide more context in the message of the main commit
> - Document the madt parameter of IgvmCfgClass::process()
> - Document why no MADT data is provided the the process call in sev.c
> 
> Based-On: <20251118122133.1695767-1-kraxel@redhat.com>
> Signed-off-by: Oliver Steffen <osteffen@redhat.com>
> 
> Oliver Steffen (3):
>   hw/acpi: Make BIOS linker optional
>   hw/acpi: Add standalone function to build MADT
>   igvm: Fill MADT IGVM parameter field
> 
>  backends/igvm-cfg.c       |  8 +++++++-
>  backends/igvm.c           | 37 ++++++++++++++++++++++++++++++++++++-
>  hw/acpi/aml-build.c       |  7 +++++--
>  hw/i386/acpi-build.c      |  8 ++++++++
>  hw/i386/acpi-build.h      |  2 ++
>  include/system/igvm-cfg.h |  5 ++++-
>  include/system/igvm.h     |  2 +-
>  target/i386/sev.c         |  5 +++--
>  8 files changed, 66 insertions(+), 8 deletions(-)
> 


