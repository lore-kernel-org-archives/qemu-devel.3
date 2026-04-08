Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3526C10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYQ1-0003VX-EO; Wed, 08 Apr 2026 15:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wAYNo-0007rI-IG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wAPjR-0005Du-95
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 06:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775642516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wl7wxwNvvDkcHef4Te7a8kkFngeE3QU8CtlN2AbUdAc=;
 b=cK3Bd5G46PTEtPz/bX1E2/JrzCw52IIT2C0VAmsJ4OojYv+zYnmhQHycnWEsxLABTSdlsJ
 nBN4jSEt8cataxKfsHpSY1QHRLcYKEtjxXAcZ1G8x7jn2YHImqaixzOCrt7EADJEWUIeEn
 YevdcNMOMlT1S2qIKr9UhNVwzruRjVk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-nC38eEnoMHWuyogoFrL5qw-1; Wed, 08 Apr 2026 06:01:54 -0400
X-MC-Unique: nC38eEnoMHWuyogoFrL5qw-1
X-Mimecast-MFC-AGG-ID: nC38eEnoMHWuyogoFrL5qw_1775642513
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so7068745e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775642513; x=1776247313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wl7wxwNvvDkcHef4Te7a8kkFngeE3QU8CtlN2AbUdAc=;
 b=hvgPki2tpU7Ct022vI94A841Wk0xFvT/ueBOmJsdde+VxVPrDf7rcdn5DHM5RDnp5X
 HoJjxI5uf8wUCebAu/NJXqd1RYWfbGFd4cM/jskjwKBwC/10LHSV3Mux1R98IFPCh1Ok
 WLbtDxswa0T8VTzYQBlshGd8rx/PjK9vvGBSM4Jrpv/qWyuJjxgc14YW3/BPUxQwngoC
 SJB5BImi5OXczY2yjfcofV1KKVW9Tjs8OExXcRzI0Wm0Z0fFTGPRLK2ZluHCCMWfa8Oi
 GubWE1tzwEZtvqht5mlIFZmE+xQe266qKe+DUHWUo1FN7IwMQTHTdgaIPdyBYIisOOih
 1D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775642513; x=1776247313;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wl7wxwNvvDkcHef4Te7a8kkFngeE3QU8CtlN2AbUdAc=;
 b=MTiGnUXCloqsrLbm0iQI1xzX1cJFQZ4bQ7v+SffJ/hNgmkQ5FsNGbJn2umo+1xKZYy
 iy4h1vSbFK3btu76e3SWNzobIC2ziudK9pg8lFpjYvqplhj8FLTKkH1DE6sHBJeQefnO
 Lip+UHFbnshL61J1CpMSF6OIZFcznXNABgS9ZTv96glAdssq05dgvMFzppfkPOUd7RQ4
 OR8Z9NO8eUfvk2sgcF1r14mFNz/318naRbBLY/ATSUkq6jd406ZV6bfaFPXyJzJTzTzs
 t4jdYjQL0r5vu4HS08niP7M/07qCx6XlbzMWO/IyJQ/Td2E0ozyqJrF+7JXc68XRMEcr
 PWsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK6haz2Qn4Bdizh2yZmNy8Mkx+/ooZXf1G1i7Yh+GLibKmDz0jD+2g1SPpiDUAHeQa8Ka/Cm2W3Aq0@nongnu.org
X-Gm-Message-State: AOJu0YzoCg3Mv8Tvcsinl3zkneZEgjqzxwC7nVgLZ/Zp664am3eDCDJt
 3BAApyD0wHHTzawB15K6L3EDsTxba58Ram1vW9ED02sltGNGphHLFgDut6Tarw59QMK8WeqSTbU
 yQUChPJwSnptfOhPDSMF31hT2ONBrvb0RZzfxA0C1VAmDGKLIVGO2FImU
X-Gm-Gg: AeBDiesLvfanG+h2xa/xEKKiG84DakIfhfvfvXV5m3suG+fFA5QPU1qj06YiZliQhb2
 cdWvKBYZM6AddEIrh1AtrZfhFBfP3N3dYy1UVkzmI5lmVPE40auBZmCmI/Jsnzc5Zf8R+G6HWj4
 absv9901ytGa9g1ByiDrXWP+rvNAEqgO7yq8YP/GYqO2Espn3rqVkGDHOPPRNkDvYVbnKxa2qbT
 6BTGqdM9HH/BNUJF5PFDGNXK0HaxWPAS3y0AwFqJQbwsxBEj0xpgjzLUaGLQwTciilFBxgSYB+W
 QFbn0snzqHTA3mcF2p1wu0FVsMyR3Z2x7nfePOE4YqRV9zRTCvzWRUoFqvEROez9fX5qRXL/+hp
 cveg/6fn1qeRPwFrJXfq4i2NeLN2veN2+SSNl4cLMBSxRrL8=
X-Received: by 2002:a05:600c:5289:b0:487:22ad:403e with SMTP id
 5b1f17b1804b1-488994b34b4mr296660205e9.14.1775642513093; 
 Wed, 08 Apr 2026 03:01:53 -0700 (PDT)
X-Received: by 2002:a05:600c:5289:b0:487:22ad:403e with SMTP id
 5b1f17b1804b1-488994b34b4mr296659175e9.14.1775642512569; 
 Wed, 08 Apr 2026 03:01:52 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a7165aasm630712975e9.14.2026.04.08.03.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 03:01:52 -0700 (PDT)
Message-ID: <021768ba-9871-421d-8b45-80c5ade6a456@redhat.com>
Date: Wed, 8 Apr 2026 12:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] s390x/pci: Implement migration for emulated devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260402022921.298818-1-kshk@linux.ibm.com>
 <20260402022921.298818-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260402022921.298818-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 02/04/2026 04.29, Konstantin Shkolnyy wrote:
> Implement zPCI device state migration, consequently enabling migration
> of VMs that have emulated PCI devices, whether virtio or not.
> Migration is allowed for devices whose function handle has the
> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
> state of its zPCI emulator.
> 
> Passthrough devices will continue to block migration.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 112 ++++++++++++++++++++++++++++++--
>   hw/s390x/s390-pci-inst.c        |   2 +-
>   include/hw/s390x/s390-pci-bus.h |   2 +
>   3 files changed, 110 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index f339a0fd94..b3037b9a8a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
>...
> +static const VMStateDescription s390_pci_device_vmstate = {
> +    .name = TYPE_S390_PCI_DEVICE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = s390_pci_device_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(state, S390PCIBusDevice),
> +        VMSTATE_UINT16(uid, S390PCIBusDevice),
> +        VMSTATE_UINT32(idx, S390PCIBusDevice),
> +        VMSTATE_UINT32(fh, S390PCIBusDevice),
> +        VMSTATE_UINT32(fid, S390PCIBusDevice),
> +        VMSTATE_BOOL(fid_defined, S390PCIBusDevice),
> +        VMSTATE_UINT64(fmb_addr, S390PCIBusDevice),
> +        VMSTATE_UINT32(fmb.format, S390PCIBusDevice),
> +        VMSTATE_UINT32(fmb.sample, S390PCIBusDevice),
> +        VMSTATE_UINT64(fmb.last_update, S390PCIBusDevice),
> +        VMSTATE_UINT64_ARRAY(fmb.counter, S390PCIBusDevice,
> +                ARRAY_SIZE(((S390PCIBusDevice *)0)->fmb.counter)),
> +        VMSTATE_UINT64(fmb.fmt0.dma_rbytes, S390PCIBusDevice),
> +        VMSTATE_UINT64(fmb.fmt0.dma_wbytes, S390PCIBusDevice),
> +        VMSTATE_UINT8(isc, S390PCIBusDevice),
> +        VMSTATE_UINT16(noi, S390PCIBusDevice),
> +        VMSTATE_UINT8(sum, S390PCIBusDevice),
> +        VMSTATE_UINT8(pft, S390PCIBusDevice),
> +        VMSTATE_UINT64(routes.adapter.ind_addr, S390PCIBusDevice),
> +        VMSTATE_UINT64(routes.adapter.summary_addr, S390PCIBusDevice),
> +        VMSTATE_UINT64(routes.adapter.ind_offset, S390PCIBusDevice),
> +        VMSTATE_UINT32(routes.adapter.summary_offset, S390PCIBusDevice),
> +        VMSTATE_UINT32(routes.adapter.adapter_id, S390PCIBusDevice),
> +        VMSTATE_BOOL(iommu_enabled, S390PCIBusDevice),
> +        VMSTATE_UINT64(g_iota, S390PCIBusDevice),
> +        VMSTATE_UINT64(pba, S390PCIBusDevice),
> +        VMSTATE_UINT64(pal, S390PCIBusDevice),
> +        VMSTATE_UINT64(max_dma_limit, S390PCIBusDevice),
> +        VMSTATE_PTR_TO_IND_ADDR(summary_ind, S390PCIBusDevice),
> +        VMSTATE_PTR_TO_IND_ADDR(indicator, S390PCIBusDevice),
> +        VMSTATE_BOOL(pci_unplug_request_processed, S390PCIBusDevice),
> +        VMSTATE_BOOL(unplug_requested, S390PCIBusDevice),
> +        VMSTATE_BOOL(interp, S390PCIBusDevice),
> +        VMSTATE_BOOL(forwarding_assist, S390PCIBusDevice),
> +        VMSTATE_BOOL(aif, S390PCIBusDevice),
> +        VMSTATE_BOOL(rtr_avail, S390PCIBusDevice),
> +        VMSTATE_END_OF_LIST()
> +    }
>   };
  Hi!

I assume this will likely break backward migration with old machine types?

Could you please try whether migrating a s390-ccw-virtio-10.2 machine from 
an old version of QEMU to a version of QEMU that includes your patches, and 
back from the new version to the old version works as expected?

If not, you might need to add a ".needed = ..." line to the 
s390_pci_device_vmstate, with a function that checks a variable from the 
machine state whether the PCI state is allowed or not. And then enable that 
variable only on the newest -11.1 machine type once it is available.

  HTH,
   Thomas


