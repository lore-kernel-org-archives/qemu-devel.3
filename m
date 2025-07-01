Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A38BC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUpn-0001SU-Qa; Tue, 01 Jul 2025 02:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWUpl-0001P3-MO
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWUpa-0006ry-1A
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751352657;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gf4lggQswakfca9ShW+YSv63cYv0Ld0SFqUv8ep8JCQ=;
 b=Kk4WlToViLolfFN+56Ast0YFJmrgkNHf8IYnGibiDhHbzgU5YggnetxDyarmT8qlS+rwOb
 pZr0hvwXX408WBL1Dh3yMZbdWkFk1Twv90Cx5j5b4G7ARPJ0z3bK8R+mwYyqACuPWR2T1x
 1SghOF8JVpIg0VBGA0hLb9saYJ6kVVI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-fk88G0slPraVn-odO9hbRw-1; Tue, 01 Jul 2025 02:50:56 -0400
X-MC-Unique: fk88G0slPraVn-odO9hbRw-1
X-Mimecast-MFC-AGG-ID: fk88G0slPraVn-odO9hbRw_1751352655
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45311704d22so20386205e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 23:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751352654; x=1751957454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gf4lggQswakfca9ShW+YSv63cYv0Ld0SFqUv8ep8JCQ=;
 b=frslb7xYv8+Vhdnp1hviYhB/WVpnQEuqOc8yDmdvRWSDUQ9xZ1jodVsVOm3kjug8ed
 kQrzEZsNs9r07JmfjK9vBOxAvX0YDFcd/hJPWlI1sOY5T1m6DxkrxlE8Y617LFuM//yp
 k/TmR/BgiXYg264OtgYoRC8ONMeRUJ0YaFyKrcl0+Wh9u4mzxHIf38R/3VLPOHF27m70
 snsVWZ2HnJ1noyFXpuDSKwNkqsuxhU8Lc1NHG8YPbQYurB4QXiNN2OxdwkJyUh5bjrnW
 v+DV9t4wQRK634k8SF7JL4MIfK5gFYOj9yIlO+oQbpvK5UxxyNFdO0Pcu7r25kjfRIhK
 nqlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAKp3TKKeYg46EMSbdo63w7R56xCTXec6ijbblHpJsPynGBSPCwrQy+yA9u+GTnpqDmjcuRl+IrUN8@nongnu.org
X-Gm-Message-State: AOJu0YwPlcGWDtyn2UsY7I00mCeBWVLenwU4J/Sddoot4UnPBikZKoMi
 14hYKAfMshSyHNUZbA56hICmvf+k5tB6EbsHT7E48KQn0lTOUmBc+ndHUdoDoLAx3/3jKmeBdMY
 +hPfbQ8aAtPlPzpZntQvv146frT7vINuhjPUIenX8iFNWTN0tibRBLrmuyRsSYe6p
X-Gm-Gg: ASbGncuq8SuzdOGRvH6F9+cnhtjO43iQli/L84/tWj3kFvILv6EIe534EjpuCHvTDGG
 7k8AWJ0PtYd0ZEYA2cFzTrSn/6TgLe5AVrw4BbPe4vpJplxGT2R/lOSZvL+TO3WAiRltavwN7/E
 3/WzTdpQaSRTjwSQ9qeuErCJmkTvOvGErl/v70mg1s8BXGuQm9zsUMPv3+jh/lssJPhYQew/pc+
 Le6LBVkPkK7YwzGxMIzIBW6TGYHe2/fPaAL1lCMj5b2YoZ4UtndRujhEG5KMX9jXKDA2Xw5qGgZ
 ZUbld0/oKYoJ7uKYgqcJN0o5rwZurv65g6ePPxbb2egIJe1oyTDcyB35d2ipAPLtjs+OOg==
X-Received: by 2002:a05:600c:4fc5:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-4538f88349amr142832475e9.32.1751352654129; 
 Mon, 30 Jun 2025 23:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQRQAI0aZChlXhUe3EfpIYL5wXaSCtwaVaywwsVk20ZkLqg140tNArVF6gtCKld3YusmlhYQ==
X-Received: by 2002:a05:600c:4fc5:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-4538f88349amr142832255e9.32.1751352653687; 
 Mon, 30 Jun 2025 23:50:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453b3542838sm7454985e9.1.2025.06.30.23.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 23:50:52 -0700 (PDT)
Message-ID: <531385a3-0117-420b-a401-a9ddbff6d5f9@redhat.com>
Date: Tue, 1 Jul 2025 08:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] ARM Nested Virt Support
Content-Language: en-US
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, gkulkarni@amperecomputing.com,
 gankulkarni@os.amperecomputing.com
Cc: hi@alyssa.is
References: <20250619145047.1669471-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250619145047.1669471-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,
On 6/19/25 4:49 PM, Eric Auger wrote:
> The only change compared to v5 is the linux header update against
> kvm main branch. As discussed on the mailing list, KVM_ARM_VCPU_EL2_E2H0
> (non VHE version of the NV support) will be dealt with in a separate
> add-on series. Also the fallback to TCG does not apply if the host
> does not support nested and virtualization=on (which is aligned
> with the behavior along with other arm virt machine properties such as
> secure, mte, ...).
>
> For gaining virt functionality in KVM accelerated L1, The host needs to
> be booted with "kvm-arm.mode=nested" option and qemu needs to be invoked
> with: -machine virt,virtualization=on.
Gentle ping on this series. Any other comment? Missing R-b's/A-b's on
the 2 first patches.

Thanks

Eric
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v10.0.0-nv-v6
>
> Original version from Miguel:
> [1] https://lore.kernel.org/all/20230227163718.62003-1-miguel.luis@oracle.com/
> version from Haibo:
> [2] https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/
>
> History:
> v5 -> v6:
> - linux header update against v6.16-rc2
>
> v4 -> v5:
> - rebase on top of v10.0.0
>
> v3 -> v4:
> - fix: only set maint_irq if vms->virt
>
> v2 -> v3:
> - KVM EL2 only is set if virtualization option is set
> - fixes regression with virtualization=off
> - Add checks against unsupported GIC configs until the kernel does
>
>
> Eric Auger (1):
>   linux-headers: Update against  v6.16-rc2
>
> Haibo Xu (4):
>   hw/arm: Allow setting KVM vGIC maintenance IRQ
>   target/arm/kvm: Add helper to detect EL2 when using KVM
>   target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is supported
>   hw/arm/virt: Allow virt extensions with KVM
>
>  include/hw/intc/arm_gicv3_common.h            |   1 +
>  include/standard-headers/asm-x86/setup_data.h |  13 +-
>  include/standard-headers/drm/drm_fourcc.h     |  45 +++++++
>  include/standard-headers/linux/ethtool.h      | 124 +++++++++---------
>  include/standard-headers/linux/fuse.h         |   6 +-
>  .../linux/input-event-codes.h                 |   3 +-
>  include/standard-headers/linux/pci_regs.h     |  12 +-
>  include/standard-headers/linux/virtio_gpu.h   |   3 +-
>  include/standard-headers/linux/virtio_pci.h   |   1 +
>  linux-headers/asm-arm64/kvm.h                 |   9 +-
>  linux-headers/asm-x86/kvm.h                   |   1 +
>  linux-headers/linux/bits.h                    |   4 +-
>  linux-headers/linux/kvm.h                     |   3 +
>  linux-headers/linux/vhost.h                   |   4 +-
>  target/arm/kvm_arm.h                          |   7 +
>  hw/arm/virt.c                                 |  13 +-
>  hw/intc/arm_gicv3_common.c                    |   1 +
>  hw/intc/arm_gicv3_kvm.c                       |  21 +++
>  target/arm/kvm-stub.c                         |   5 +
>  target/arm/kvm.c                              |  21 +++
>  20 files changed, 223 insertions(+), 74 deletions(-)
>


