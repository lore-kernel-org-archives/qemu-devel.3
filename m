Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A009BCD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuqz-000184-Jk; Thu, 07 May 2026 05:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKuqx-00017v-16
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKuqu-0006Me-SK
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778145422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2VfPBtU/M0EGmu6cNxC0V5AwQ+Vcjx8txHLW+nX/QVM=;
 b=Pcvi0h9oGdUdhAgwsWQutv4YUIwsBNg176xmPePpfwAH4XiFX0L+2Z3zipaFkpAvl6k725
 L13YvUsWFVgMHGWHHk3cosYJDOgl5FLQHb6dZRLUYsiPxkL5lieHMmiyyDxE1KwLsD+2Tv
 EDloDIUSdVIpR7LFMIgZeOS1aaznzsc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-MKA9njx3N7q1-H35Sm8_Yw-1; Thu, 07 May 2026 05:17:01 -0400
X-MC-Unique: MKA9njx3N7q1-H35Sm8_Yw-1
X-Mimecast-MFC-AGG-ID: MKA9njx3N7q1-H35Sm8_Yw_1778145420
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4891f97aef0so3280775e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778145420; x=1778750220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2VfPBtU/M0EGmu6cNxC0V5AwQ+Vcjx8txHLW+nX/QVM=;
 b=tYaAZfhnAwhj+rf2T4TXm+xuA/hy8nwTP3FU8K3kTnJSs9KoNh8fpN+CySEn6t9pDA
 vcAWgEW2T+WcOqZwvKX7xdNDVOwR4i0d/msf+7qNKwNe0olC6JH80fxiCfXl1bLEjC8g
 n6RXuDWafEsqB44xNhbu9Xxkzp7z/oCaoanQTGw9g+IbflHefGuLNouHU7HFlPdYeycI
 yOCPftqkeoQUud3RBQc6U9MkCR/jY9Ud3BaaBVzjVzl05Xare17ADd/CRUwVS6veypGt
 Ln9gDQ0jx6ZccysvZHlhz0TtowwnmKmgcAaU94njruM3C9KscCYRDtYIvL1iTLiOnLAY
 NGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778145420; x=1778750220;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2VfPBtU/M0EGmu6cNxC0V5AwQ+Vcjx8txHLW+nX/QVM=;
 b=ZkK0DheSgtpUMKbZsH8kQ/MPCKaiTCMBPxB26Q6KpcSr35tjEzB+OFSxsXLryY/2un
 ogVAT4LQD9nfMSreO5ZpoqRGkcSHn/sShD3AfydUrLI0lDZm8USe4RUAeTOUXQ6grYQo
 zGsE++aLR8+aWiUG3vmX5UuBMTIoWiSgBAyEScXmA1mJRX2FrbCKR/j4nsrub3ZlkjwS
 gyDGbjCaFMiCjIOZotPUKsjn2VHmRy8TmBeK+YdWh5OmkQY8xzWxvsmjn3rIQitIOPPJ
 LTyu0VxUpoHnL4+2VgV/L1LUm2H4x/NoGQW25rmneWCA6J5P2v7pdXuqNcb6LYddWbax
 luhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cY0/qN0LZ0DmHWBGorYl2fvr0VtqghQeS9xdrJmBJboZDkt9flmZi3yg1rmbgo2Fgpv/LrGIUUI+u@nongnu.org
X-Gm-Message-State: AOJu0YxijaEmmQ842fZG1I3MLOfssWHqfPrSRoiRAXM3C6/01ntkQkHR
 VowAYu8GCmSMquLs/bDvqvda6iXoiuPBTlJzAsEz/ilbj7DzEuA4HMqY7eBV2sIo5UV9Amxdl+u
 DUcy3rZtI2YccWGYyrjO5x7l7GOTjm1o6Z/k4YTfUDp7anLwzg6wYjGkf
X-Gm-Gg: AeBDiesgY09ArE5VHg1SyXfoAYuFvAULzzWKtlqOTmFMiNLzYOPf3F0Mvxk7OXgzr2y
 jky0Ccen6qUcWeni57ly8txjDhkWkIDNT0fZNE8+2mjoxqDdnpMXWoXpxbkHghBg7T13yOE26w1
 ENMHXbM5ymeEVcArnjiPusKYyqhQtpcjyVR+looyEv9R3E82Es3l59fnzHxZvT8XH9qKGPj3GlT
 TFtRmGBm2L1tA1z/rr4PK5bNQzZndokzmbBQATkNNWyF98aWoshXIwPAu8xjvxIKpHgG3ZNFTeC
 F0kOuEzM8WaS5nHvdUX4S76nq0xNV+a+1fzlIZxg3Z5FbTqdEBn02iAPDCynyXthCaBENpA9kgb
 3z9B/JS02+ljFhO768WsMp5S0BMdumdgojfWOlQYujmaNXDPq24GFECdr9Kebmo1EAK8xlM++6G
 2fvaSY/A==
X-Received: by 2002:a05:600c:8b08:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48e51f32757mr125013265e9.16.1778145420016; 
 Thu, 07 May 2026 02:17:00 -0700 (PDT)
X-Received: by 2002:a05:600c:8b08:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48e51f32757mr125012535e9.16.1778145419382; 
 Thu, 07 May 2026 02:16:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538b6e9bsm190107805e9.10.2026.05.07.02.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 02:16:58 -0700 (PDT)
Message-ID: <70afce55-bd62-486c-acf1-f5c83f707569@redhat.com>
Date: Thu, 7 May 2026 11:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] linux-headers: Update to Linux v7.1-rc1
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, Song Gao <gaosong@loongson.cn>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-3-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260505081423.28326-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+ Song Gao

On 5/5/26 10:14, Avihai Horon wrote:
> Update Linux headers to get VFIO_PRECOPY_INFO_REINIT feature of VFIO
> migration uAPI.
> 
> The update was done by running `update-linux-headers.sh` on commit
> 254f49634ee1 ("Linux 7.1-rc1") in the Linux tree.
> 
> Signed-off-by: Avihai Horon<avihaih@nvidia.com>
> ---
>   include/standard-headers/drm/drm_fourcc.h     |  28 +-
>   include/standard-headers/linux/const.h        |  18 +
>   include/standard-headers/linux/ethtool.h      |  28 +-
>   .../linux/input-event-codes.h                 |  13 +
>   include/standard-headers/linux/pci_regs.h     |  71 ++-
>   include/standard-headers/linux/typelimits.h   |   8 +
>   include/standard-headers/linux/virtio_ring.h  |   3 +-
>   include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
>   include/standard-headers/linux/vmclock-abi.h  |  20 +
>   linux-headers/asm-arm64/kvm.h                 |   1 +
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/unistd.h            |   5 +-
>   linux-headers/asm-loongarch/kvm.h             |   5 +
>   linux-headers/asm-loongarch/kvm_para.h        |   1 +
>   linux-headers/asm-loongarch/unistd_64.h       |   2 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |  11 +-
>   linux-headers/asm-riscv/ptrace.h              |  37 ++
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>   linux-headers/asm-s390/unistd_64.h            |   1 +
>   linux-headers/asm-x86/kvm.h                   |  21 +-
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/const.h                   |  18 +
>   linux-headers/linux/iommufd.h                 |  48 ++
>   linux-headers/linux/kvm.h                     |  46 +-
>   linux-headers/linux/mshv.h                    |   4 +-
>   linux-headers/linux/psp-sev.h                 |   2 +-
>   linux-headers/linux/stddef.h                  |   4 +
>   linux-headers/linux/vduse.h                   |  85 +++-
>   linux-headers/linux/vfio.h                    |  30 +-
>   38 files changed, 711 insertions(+), 493 deletions(-)
>   create mode 100644 include/standard-headers/linux/typelimits.h
>   create mode 100644 include/standard-headers/linux/virtio_rtc.h
>   delete mode 100644 linux-headers/asm-s390/unistd_32.h

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


