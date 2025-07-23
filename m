Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355DFC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 11:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueY6T-0007ZN-2S; Wed, 23 Jul 2025 07:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueY6P-0007V7-KK
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 07:57:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueY6L-0004L8-Nu
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 07:57:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45617887276so43655295e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753271854; x=1753876654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gnEhE68jUDos2afC+O90TFdO69KnVtwupeGrYPuGans=;
 b=gx1LnOnmPhy6aYjaObWKhCvdxQb0wMuCD09zO0lWJ8cYDo+rLvw97M2F0K/yxRrmMM
 o0AkCKBgMccNvaJ50BnYQ6TS05XcZBqo18/wO+wunoKIFFoaQgS1sm0vknMJI0qDHt53
 qD6ocNjtmGJv2DZPVgBcN699Kn2z+FUqnCVlnj32FcqokY+pw+XzpeH1BpAw/JP1Vjwj
 xicGZtVk4eGhU7ADfOy1gi5ZRILSlOGNjT+UNgbuZYVJVo4woGsnepgj6fvQjE/kZ1sX
 S8dfzvGomjZ11IeLrosUV7Y7MQdBpWY/Xt5rgm4yLwGbHsKEo0RKELZMj5NypOLG5E93
 AGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753271854; x=1753876654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnEhE68jUDos2afC+O90TFdO69KnVtwupeGrYPuGans=;
 b=pH6Z/K8pKhrjs8POCX8zf+kGlFW0ZyUKbQpxqy1UQT7topn7qfcxdmqHd1Cn8FdmE7
 dMeXRqg4HGfnN3ejpS0dpBtirKbexkSJUUFoUo8aTOjcxqQQHZRQW859L5KJSKCTei3o
 0lt41n0hwu55cr9xm+hUa9fdSalwAFFlhZOm9MXuhdwqgP1xQm4/JdCQod8tdVlw5XTB
 9QJBGMBQ2BxxgAUVQFBIe64BSAVOJed5I4lyRtjyzqox1jfjD06etQyju8i0bqSa44My
 NADjZjl2WQnb02YF5odWwrMWvJHIZfxAevXBK4VEMN4sAC7wVQGh80wBXNFZ4wI28H7x
 qLig==
X-Gm-Message-State: AOJu0Yy+YNUt8ArxZKyGSErbRXx3tjHD+L7IHePmheGPRwKTu4fhQZ17
 VziRe2MaALnnHD8wLDbuhWr5ms195+7tf6kDK1lb1Kg3c/Wq4KKOK9vAljx8OAZl8CQ=
X-Gm-Gg: ASbGncsqs5aONl3ciJs9P0WYrjBQBvKmOT4M44/UN4T1DmCqv15afU+f9xYMNKNBG1D
 QvbrgYVtRIB+NDQPXjXGmSWXAqmUvF1eII8FspPz+r9aRdqmgS4H2bb1+qDSOj+Nhlos8y4J/Vj
 GlBcBXTALHwlNokvtCFodFFFdI1tdTkF5FWUMzLVyq9QBef4dyoSSJRjc6+1Zb5CxCcaSVp48O2
 iCjlBqA3LqF1Bb2sNiPbQgcxOen+fej2BpzuNcn+UNBIsYiqZPXA1TWLkLHnUad37S9jFxeUhAC
 3HX7myp8I5D8vVa3f5cqFhsRh+DzGA20WftIM5zEqcwQ/lDhr8dMuHnXEwI8qDRLp0xVnsEC+eA
 MG0/m+U0ZShj77habnyw+S++UWWJiwldrH/+HuZ98wZyxo4fOWtnL72gaI04e3khbXbmJtlc=
X-Google-Smtp-Source: AGHT+IG0kjAWb28+5DgtDZ8Bct8J1Lxf0tfvtOfHZc/S9bZ3LgCPlvPCvOgWCmofixBS8QMnSPAb2Q==
X-Received: by 2002:a05:600c:4f16:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-4586d78e0bfmr186995e9.10.1753271853628; 
 Wed, 23 Jul 2025 04:57:33 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693cd23bsm20639425e9.20.2025.07.23.04.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 04:57:33 -0700 (PDT)
Message-ID: <35ca215a-d7df-478f-9f9a-e84fb6f0becd@linaro.org>
Date: Wed, 23 Jul 2025 13:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] accel/kvm: Zero out mem explicitly in
 kvm_set_user_memory_region()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250723070951.1134374-1-xiaoyao.li@intel.com>
 <20250723070951.1134374-3-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250723070951.1134374-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/7/25 09:09, Xiaoyao Li wrote:
> Zero out the entire mem explicitly before it's used, to ensure the unused
> feilds (pad1, pad2) are all zeros. Otherwise, it might cause problem when
> the pad fields are extended by future KVM.
> 
> Fixes: ce5a983233b4 ("kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   accel/kvm/kvm-all.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 14d47246ca63..4f4c30fc84b2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -361,6 +361,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
>       struct kvm_userspace_memory_region2 mem;

Or:

         struct kvm_userspace_memory_region2 mem = { };

Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       int ret;
>   
> +    memset(&mem, 0, sizeof(mem));
>       mem.slot = slot->slot | (kml->as_id << 16);
>       mem.guest_phys_addr = slot->start_addr;
>       mem.userspace_addr = (unsigned long)slot->ram;


