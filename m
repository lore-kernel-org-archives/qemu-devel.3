Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB41C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaow-000153-It; Tue, 14 Jul 2026 06:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wjaou-00014H-5z
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wjaos-00040j-D1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784026616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGmtfTaKNjnVMCFoWirR8Pe5xgMzaRCEBNCSNOefk+U=;
 b=fu+YGLcHLq/aEJWYFdaaHc/Wc2E2qPBCo0XuD6Gi+fISC9M0g/Q1zflcsVLcePRGCCjVpT
 47rTTaf6DufvP/yQk+DxIDQHcNLHBq7KaAdz+VeKVY5aBZW1R9gH+aV6RB/mdLokhMDrBU
 WRDLJAXdKjgnVWF654BogPKecHlRiM0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-kutLpW4jNVaI3oau_kZ9LA-1; Tue, 14 Jul 2026 06:56:55 -0400
X-MC-Unique: kutLpW4jNVaI3oau_kZ9LA-1
X-Mimecast-MFC-AGG-ID: kutLpW4jNVaI3oau_kZ9LA_1784026614
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cefa1a2be6so1917735ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784026614; x=1784631414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DGmtfTaKNjnVMCFoWirR8Pe5xgMzaRCEBNCSNOefk+U=;
 b=Wg47yV4sAOO6IRnWcfn3L4hsT86ehr++urywlr8meMSz+G3oLiQp/13ul/+O2bCFtT
 g6cBrssRsBeW/GgL7CXtHFa0gHQbGtWke7IWTswvuqRqQGc3mOSXI+QckioCKHEr7ne/
 zHCS2pv7/kjVDTdQbfxsKmanxEddBpyfVR1mgtgM1+O3Bt/ig2kP+nds1YYwhtuJP5XI
 Ffe3KsYJwjyfzAG2EqB4djLU3nKBOp3nm4CWdbw0dozBmXk2cvkp7EbTtuHFca1G6zmk
 fs7d3p4vXXh5pMZDid2vOKQH/ARqqgBs1ulKIPm/jmacEh/HqyDExi8IsR0uBH/DW1Ez
 muug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026614; x=1784631414;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DGmtfTaKNjnVMCFoWirR8Pe5xgMzaRCEBNCSNOefk+U=;
 b=TLJ9HvDf0RhMp2WRiZ9d3WElqgz+T6DZyArU3M3+vQMlbw07Kt/P0rLQS1u4P3jWuu
 SI/Q+uGNlwJAtlTpIJkSpl6CfvnVXRKDF0E5O11je9N9xzLnDwBMA+V0aeUpa3V7w+FN
 T+vqsTn6alTvNktD+urazTo4t3Z9TfdqoJ8KRlkJz0jjhOytYJ8LyXPDJVN1N49OPhR4
 dn1S9KlegcUL00+npgt+nCM9ATucFJeRJKK6YwbUnsZInFnKwZSY2c/vtfX663Aktk0w
 i7ZaU8MFp/dR45nbb/6jz97xBwFNx2Yy6RfpfPtZeobbIWlPsvCcsPK+WDk20OdSgWqz
 pQAw==
X-Gm-Message-State: AOJu0YzbQrYRqqtKYK2O2TkQuqJhtZX9FW72ocmE+fc7YgojF5ckJg7b
 POt1f3o3HY7/dpxnCbSwuKg085zkJa30l06AdDh77q+55tC6SOJyqswoMA7QfLgMo7lSv8wnGDM
 jQgQPWJfHZ46g6FRaKpO3fkKXQARRTUHIJsddcDPcf4K5Qut6OUMmC3bs
X-Gm-Gg: AfdE7clWf9WtoILgmFC02sVWI1DbsdJDh8PtlNSetJbNDMzNWajPAMIzZy3aJuN7Nqr
 AqFiGMAHH6Lqg3u93IBScoamthGlqdABHDWp18EBk2O2ekbJZ5MPHHPduHRDI5OFbLqR8ndlkRm
 KiffOsKn3/w8LKs/ZE2c4SD8Stw00+KXLB8AuvXl3B0W/WE5uArbjPzO2WDg+3HTYwklluZtd4M
 7eSiMr8hH1PhVsBU6zJpvjQmC83JZAsMQd6IflrOY/CScplT57in99iHxsSTrsUiGMI2d6cT0Gd
 sZh2B+aSjMiPAmOwHzoQb4f0ZFPeR7dOHjymCDQ3aFduHf7dXxDxiXKqWFasMzXz2oqTH6a4SSr
 D4v0sV1NxYZYSJ9D2vOiSiZT3a0cvzR9BJweDf263Ppvh9JoYHYeikg==
X-Received: by 2002:a17:902:c946:b0:2c9:97a8:aff0 with SMTP id
 d9443c01a7336-2ce9f3d32f3mr117741825ad.41.1784026614237; 
 Tue, 14 Jul 2026 03:56:54 -0700 (PDT)
X-Received: by 2002:a17:902:c946:b0:2c9:97a8:aff0 with SMTP id
 d9443c01a7336-2ce9f3d32f3mr117741485ad.41.1784026613721; 
 Tue, 14 Jul 2026 03:56:53 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm115846435ad.15.2026.07.14.03.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 03:56:52 -0700 (PDT)
Message-ID: <1bd09a58-a207-46ba-a470-f67cc8509f07@redhat.com>
Date: Tue, 14 Jul 2026 20:56:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 12/25] target/arm/kvm-rme: Populate Realm with runtime
 images
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-13-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-13-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Once the Realm descriptor has been created, tell KVM to transfer runtime
> images (kernel, DT, and rootfs) from guest memory to Realm memory.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 97ec7c8934c9..58669f4a50f1 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -44,12 +44,68 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>   
>   static RmeGuest *rme_guest;
>   
> +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> +                              Error **errp)
> +{
> +    int ret;
> +    void *host_ua;
> +    hwaddr size = region->size;
> +    hwaddr base = region->base;
> +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> +    struct kvm_arm_rmi_populate populate_args;
> +
> +    host_ua = address_space_map(region->as, base, &size, false,
> +                                MEMTXATTRS_UNSPECIFIED);
> +
> +    populate_args = (struct kvm_arm_rmi_populate) {
> +        .base = start,
> +        .size = end - start,
> +        .source_uaddr = (uintptr_t)host_ua,
> +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> +    };
> +
> +    while (populate_args.size > 0) {
> +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret,
> +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> +                start, end);
> +            break;
> +        }
> +    }
> +
> +    address_space_unmap(region->as, host_ua, size, false, 0);
> +
> +    return ret;
> +}
> +

Nit: The argument @measure isn't needed as it's always true, passed
by its only caller rme_populate_range(). I guess it's leftover for
the earlier host series.


> +static void rme_populate_ram_region(gpointer data, gpointer err)
> +{
> +    Error **errp = err;
> +    const RmeRamRegion *region = data;
> +
> +    if (*errp) {
> +        return;
> +    }
> +
> +    rme_populate_range(region, /* measure */ true, errp);
> +}
> +
>   static void rme_vm_state_change(void *opaque, bool running, RunState state)
>   {
> +    Error *errp = NULL;
> +
>       if (!running) {
>           return;
>       }
>   
> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> +    if (errp) {
> +        return;
> +    }
> +
>       kvm_mark_guest_state_protected();
>   }
>   

Thanks,
Gavin


