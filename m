Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEF5CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 00:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8oyN-0007M3-28; Tue, 14 Oct 2025 20:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v8oyJ-0007LP-Le
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 20:02:29 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v8oyH-0002ia-8E
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 20:02:27 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3305c08d9f6so347083a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 17:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760486542; x=1761091342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R8COgXH1ebkpcfSfLdBYECLUfxmKPOTaSeHRmqCzzTA=;
 b=y/SiVLu6gfYvoe+F+TZuwLFOJAdc8i4jTm2XYEGPG/V/Ei0GqfdyDvqL9NUGr+oHGt
 4r1fgiOm+Qcq15czkzZoFmOZUYLUoFTKG2hVGrCJl47WbYXFp1j3yIKa74BwbYSbkCvx
 TPzexRFZP1cUDrcXcLDq4SWKeBn2ipUrw7iN2zFlcTkTaTaEQ7h7Bv33f0YYChzaxZgB
 IYZuGzmlmJK8D+2TMp3vvUXkKCIGVmhQ7nxYISJ2FQEC1Ym8JAWb1f2p1VvQkvoGVfXY
 aPVWO7ch+U9NraG0mgqwo4Tcus1mr9NrwdDLZNwzJHWsU8MSJE0ahF/0OXktT+oULd/N
 CLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760486542; x=1761091342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R8COgXH1ebkpcfSfLdBYECLUfxmKPOTaSeHRmqCzzTA=;
 b=pSq50GJQSks8dpMbE63YnwpKCnmPniyl2adwTH3+8us5N1KlptKiwTvYZKQKJSY6zE
 tRjZY/+w2McOwYoWBsuDylSOBeb0mgsHKmpTOgKRcrgwxaOE58lY4Dc9jT5Djz+nA+z9
 KEgd6ao4P1/7pnkUvQaCGC78U9xL+ISC0rCCQxn3qhP5/5XKluWiI2pMZNWAk94hiANY
 yulFpFa7s6nmDbN0KJKZvu4AXhiLQVVi/9wlYtU81GlaOXPNEZQ3MoR9FPYOsL3Ivgqm
 IoJUKgeIIgF8KW4AWwxfVvGcxl5cXoJapnHhbxtRCfrMO/BX4/RDle2S4QtgyrywhZvi
 6mog==
X-Gm-Message-State: AOJu0YweBqE+7oGX2XM6zNZTiakFp4F8iDleYNbg5u3RcmbShwD4O32K
 Y7Yfwc1VyPLKPxL5WGA2pVXlfLsuY8qVXNvWA6RdpwtDsKMSR94C7elTVojOH+u3xQ8=
X-Gm-Gg: ASbGncso3tYVpGNuHdxz4emQlt8Oo77d/3KxeOehmrNzVq5rtK+YZN7DXJLYO+J4xY0
 w0jwV37Vu3hNzC/M5VQjcoPUgH5lr6eHz/1LsgOd3C7EiJa+SctBN097Z/MWKaHW1l+gCXKjR/Q
 AYDU5ZOadYlzJZXX30bg07+echtt53I7D8UyfA04AskH+0iCUguJEpnyek2/34nNPZK60KfHy7M
 PO/2Jh74cDamAefZ6gSFoNRRmSkGu/q8BPDyWyxc67fxwWLiduFxIpn/F7TfL2mHeNmVfABbxnV
 3G09vxA89QTpeM9R5kREyL/kNtxvCL7osnY7SdtXN+BqHz66wf4MWKCkpEPP0iKeDz45nWseuev
 dk28daweXGzICLGOHn0NJGK8oUAm7SZRcp6Tcv2F6XnKi4jWFvu/chxMRoIOO6pg7m9Ic
X-Google-Smtp-Source: AGHT+IHGVFLr7tqjeW67nmNpsy9MVddGNRjIN/SNGCXtbN7bg6BCBFod8KyjZSOopcmhJUgjmhz5Ng==
X-Received: by 2002:a17:90b:57ce:b0:339:e8c7:d47d with SMTP id
 98e67ed59e1d1-33b516fc531mr35421760a91.9.1760486541932; 
 Tue, 14 Oct 2025 17:02:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b97860773sm123128a91.6.2025.10.14.17.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 17:02:21 -0700 (PDT)
Message-ID: <dbc4d33e-3477-4f39-a745-4fdc0866fc08@linaro.org>
Date: Tue, 14 Oct 2025 17:02:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 19/21] hw/arm/smmuv3: Use iommu_index to represent the
 security context
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151501.4131026-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251012151501.4131026-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Tao,

On 10/12/25 8:15 AM, Tao Tang wrote:
> The Arm SMMUv3 architecture uses a SEC_SID (Secure StreamID) to select
> the programming interface. To support future extensions like RME, which
> defines four security states (Non-secure, Secure, Realm, and Root), the
> QEMU model must cleanly separate these contexts for all operations.
> 
> This commit leverages the generic iommu_index to represent this
> security context. The core IOMMU layer now uses the SMMU's .attrs_to_index
> callback to map a transaction's ARMSecuritySpace attribute to the
> corresponding iommu_index.
> 
> This index is then passed down to smmuv3_translate and used throughout
> the model to select the correct register bank and processing logic. This
> makes the iommu_index the clear QEMU equivalent of the architectural
> SEC_SID, cleanly separating the contexts for all subsequent lookups.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index c9c742c80b..b44859540f 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1080,6 +1080,38 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
>       }
>   }
>   
> +static SMMUSecSID smmuv3_attrs_to_sec_sid(MemTxAttrs attrs)
> +{
> +    switch (attrs.space) {
> +    case ARMSS_Secure:
> +        return SMMU_SEC_SID_S;
> +    case ARMSS_NonSecure:
> +    default:
> +        return SMMU_SEC_SID_NS;
> +    }
> +}
> +
> +/*
> + * ARM IOMMU index mapping (implements SEC_SID from ARM SMMU):
> + * iommu_idx = 0: Non-secure transactions
> + * iommu_idx = 1: Secure transactions
> + *
> + * The iommu_idx parameter effectively implements the SEC_SID
> + * (Security Stream ID) attribute from the ARM SMMU architecture specification,
> + * which allows the SMMU to differentiate between different security state
> + * transactions at the hardware level.
> + */
> +static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
> +{
> +    return (int)smmuv3_attrs_to_sec_sid(attrs);
> +}
> +
> +static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
> +{
> +    /* Support 2 IOMMU indexes for now: NS/S */
> +    return SMMU_SEC_SID_NUM;
> +}
> +
>   /* Entry point to SMMU, does everything. */
>   static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                         IOMMUAccessFlags flag, int iommu_idx)
> @@ -1087,7 +1119,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>       SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>       SMMUv3State *s = sdev->smmu;
>       uint32_t sid = smmu_get_sid(sdev);
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> +    SMMUSecSID sec_sid = iommu_idx;
>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>       SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>                              .sid = sid,
> @@ -2540,6 +2572,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>   
>       imrc->translate = smmuv3_translate;
>       imrc->notify_flag_changed = smmuv3_notify_flag_changed;
> +    imrc->attrs_to_index = smmuv3_attrs_to_index;
> +    imrc->num_indexes = smmuv3_num_indexes;
>   }
>   
>   static const TypeInfo smmuv3_type_info = {

I noticed that this commit breaks boot of a simple Linux kernel. It was 
already the case with v2, and it seems there is a deeper issue.

Virtio drive initialization hangs up with:
[    9.421906] virtio_blk virtio2: [vda] 20971520 512-byte logical 
blocks (10.7 GB/10.0 GiB)
smmuv3_translate_disable smmuv3-iommu-memory-region-24-3 sid=0x18 bypass 
(smmu disabled) iova:0xfffff040 is_write=1

You can reproduce that with any kernel/rootfs, but if you want a simple 
recipe (you need podman and qemu-user-static):
$ git clone https://github.com/pbo-linaro/qemu-linux-stack
$ cd qemu-linux-stack
$ ./build_kernel.sh
$ ./build_rootfs.sh
$ /path/to/qemu-system-aarch64 \
-nographic -M virt,iommu=smmuv3 -cpu max -kernel out/Image.gz \
-append "root=/dev/vda rw" out/host.ext4 -trace 'smmuv3*'

Looking more closely,
we reach SMMU_TRANS_DISABLE, because iommu_idx associated is 1.
This values comes from smmuv3_attrs_to_sec_sid, by reading attrs.space, 
which is ArmSS_Secure.

The problem is that it's impossible to have anything Secure given that 
all the code above runs in NonSecure world.
After investigation, the original value read from attrs.space has not 
been set anywhere, and is just the default zero-initialized value coming 
from pci_msi_trigger. It happens that it defaults to SEC_SID_S, which 
probably matches your use case with hafnium, but it's an happy accident.

Looking at the SMMU spec, I understand that SEC_SID is configured for 
each stream, and can change dynamically.
On the opposite, a StreamID is fixed and derived from PCI bus and slot 
for a given device.

Thus, I think we are missing some logic here.
I'm still trying to understand where the SEC_SID should come from initially.
"The association between a device and the Security state of the 
programming interface is a system-defined property."
Does it mean we should be able to set a QEMU property for any device?

Does anyone familiar with this has some idea?

As well, we should check the SEC_SID found based on SMMU_S_IDR1.SECURE_IMPL.
3.10.1 StreamID Security state (SEC_SID)
If SMMU_S_IDR1.SECURE_IMPL == 0, then incoming transactions have a 
StreamID, and either:
• A SEC_SID identifier with a value of 0.
• No SEC_SID identifer, and SEC_SID is implicitly treated as 0.
If SMMU_S_IDR1.SECURE_IMPL == 1, incoming transactions have a StreamID, 
and a SEC_SID identifier.

Regards,
Pierrick

