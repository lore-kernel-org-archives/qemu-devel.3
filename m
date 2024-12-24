Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30DEE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7EC-0004bC-Cd; Tue, 24 Dec 2024 10:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ7EA-0004ay-5S
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:53:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ7E7-0000DJ-50
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735055621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rpwUlF2+hfvdP8OnbqhutbLTrztQBNU9uyxVoaDuj+0=;
 b=VfhuQd5FNS/dEfpXkT5dmMuJ41FRuUMrpTly8xIVPsQLubx4j+ZFuDavslz5hfe2wCzGD9
 p/s+1+CJdqHZ2kmoE1Gp3FA/u+kH68OGBm7wmGdfvba7/h7mOq91qZi55jJk7zGtvQ932p
 FuRbtCLhxfi/uKXTAywjs0NEPVq6sLo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-l5ClZKQeML6sM_83HsmHbw-1; Tue, 24 Dec 2024 10:53:40 -0500
X-MC-Unique: l5ClZKQeML6sM_83HsmHbw-1
X-Mimecast-MFC-AGG-ID: l5ClZKQeML6sM_83HsmHbw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so2206926f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 07:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735055619; x=1735660419;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpwUlF2+hfvdP8OnbqhutbLTrztQBNU9uyxVoaDuj+0=;
 b=Nly043hrxRUJMY+jXWUpkfOvVz15EeFoRT9iOg2pFMho5zi/eHSMpCPoGJFsi2KSVU
 iyRYWX+mqQ8wdsyRVsPLNEDR03lft2CYmUiBdoMS1mZT33273SOtancakd+PRqBNI744
 OMS9dQRamqoRXNjpiL4dKHFt7JFWrG3VjbIAzdU3au6+uqTNMbQ7T5omLF4biAoreT8L
 +oZzDNzNffTzoDrNxZJ4pSqH28qw6May4BDpJzcxmLbT7ex1HxMZTCDVXCZt6jcrVOpY
 0dJJPsO3Ov9rve6lJhvIMM2WVkZZVIfwWr9VsBLHRHpWRx2g+3lmnize4NIw7qnO/zGO
 vroA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxMbOi1qhEGVMeGL/w4NVIkdC0zM2kHaAI1FHFlUFC4gRjyqtRyc5eDbVk3QqIv6pI0vdbHNi7n2N+@nongnu.org
X-Gm-Message-State: AOJu0YzD+3pR0wts8vR/ej3zZGJ2ZGvnZUTeV1bToCMXrth5rcsBk4oM
 MbT72bIU87LQwbf8MJNDXeC8C0T/aG9TzDS0vdDKihCTIdgHd8sPcR7qhCHAHdmP8JYE33wDsDn
 wrjadg2yS9GaT5ZipT/07Xlg5x2OOWY+lE39YPg9ckZI93H8aAMv9
X-Gm-Gg: ASbGncsk+DeX3Qn4xdjE5Di2NcQpIK/k5kUhrb7TpDD/cG7cumEi/8qCPLbJEzNToZu
 MeFqqB/8miq7EY7PddL7GhZG96cQOt7LkDUriyZ9evsFBv+a7XhDaZQiYMaBR1U2jlmfEM4rGdj
 SPCqkE4y0WO+tlfwd1bkW6kdKMEYeRrKcykXIWA5Kn+zXalQ4Vc5MgSWx2wctTjWFbU6ZK5FqNl
 m6GLVXDDs2SlwOIwNniap90rZTSpNKuYmpdxdUs3uwcIosRmySI4VJbZ/oG
X-Received: by 2002:a05:6000:4a0a:b0:385:ef39:6ce9 with SMTP id
 ffacd0b85a97d-38a221f1716mr17022023f8f.21.1735055619026; 
 Tue, 24 Dec 2024 07:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy9XW2NulrQYqV0MVeF/XsUmbOaFu2z92cG6Vt4kGG5ZVAIDbCB38c22EYDJB0tagRQEFq8A==
X-Received: by 2002:a05:6000:4a0a:b0:385:ef39:6ce9 with SMTP id
 ffacd0b85a97d-38a221f1716mr17022007f8f.21.1735055618638; 
 Tue, 24 Dec 2024 07:53:38 -0800 (PST)
Received: from [192.168.10.27] ([151.62.105.73])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acc02sm14301906f8f.104.2024.12.24.07.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 07:53:38 -0800 (PST)
Message-ID: <ff866f4c-766c-4637-ba73-bbbdd4b15a2c@redhat.com>
Date: Tue, 24 Dec 2024 16:53:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] target/i386/kvm: Clean up error handling in
 kvm_arch_init()
To: Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-11-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241106030728.553238-11-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/6/24 04:07, Zhao Liu wrote:
> Currently, there're following incorrect error handling cases in
> kvm_arch_init():
> * Missed to handle failure of kvm_get_supported_feature_msrs().
> * Missed to return when kvm_vm_enable_disable_exits() fails.

At least in these two cases I think it was intentional to avoid hard 
failures.  It's probably not a very likely case and I think your patch 
is overall a good idea.

Paolo

> * MSR filter related cases called exit() directly instead of returning
>    to kvm_init(). (The caller of kvm_arch_init() - kvm_init() - needs to
>    know if kvm_arch_init() fails in order to perform cleanup).
> 
> Fix the above cases.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Zide Chen <zide.chen@intel.com>
> ---
> v5: cleaned up kvm_vm_enable_energy_msrs().
> v3: new commit.
> ---
>   target/i386/kvm/kvm.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 69825b53b6da..013c0359acbe 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3147,7 +3147,7 @@ static int kvm_vm_enable_userspace_msr(KVMState *s)
>       return 0;
>   }
>   
> -static void kvm_vm_enable_energy_msrs(KVMState *s)
> +static int kvm_vm_enable_energy_msrs(KVMState *s)
>   {
>       int ret;
>   
> @@ -3157,7 +3157,7 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
>           if (ret < 0) {
>               error_report("Could not install MSR_RAPL_POWER_UNIT handler: %s",
>                            strerror(-ret));
> -            exit(1);
> +            return ret;
>           }
>   
>           ret = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
> @@ -3165,7 +3165,7 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
>           if (ret < 0) {
>               error_report("Could not install MSR_PKG_POWER_LIMIT handler: %s",
>                            strerror(-ret));
> -            exit(1);
> +            return ret;
>           }
>   
>           ret = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
> @@ -3173,17 +3173,17 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
>           if (ret < 0) {
>               error_report("Could not install MSR_PKG_POWER_INFO handler: %s",
>                            strerror(-ret));
> -            exit(1);
> +            return ret;
>           }
>           ret = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
>                                kvm_rdmsr_pkg_energy_status, NULL);
>           if (ret < 0) {
>               error_report("Could not install MSR_PKG_ENERGY_STATUS handler: %s",
>                            strerror(-ret));
> -            exit(1);
> +            return ret;
>           }
>       }
> -    return;
> +    return 0;
>   }
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s)
> @@ -3250,7 +3250,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           return ret;
>       }
>   
> -    kvm_get_supported_feature_msrs(s);
> +    ret = kvm_get_supported_feature_msrs(s);
> +    if (ret < 0) {
> +        return ret;
> +    }
>   
>       uname(&utsname);
>       lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
> @@ -3286,6 +3289,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           if (ret < 0) {
>               error_report("kvm: guest stopping CPU not supported: %s",
>                            strerror(-ret));
> +            return ret;
>           }
>       }
>   
> @@ -3317,12 +3321,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>   
>           if (s->msr_energy.enable == true) {
> -            kvm_vm_enable_energy_msrs(s);
> +            ret = kvm_vm_enable_energy_msrs(s);
> +            if (ret < 0) {
> +                return ret;
> +            }
>   
>               ret = kvm_msr_energy_thread_init(s, ms);
>               if (ret < 0) {
>                   error_report("kvm : error RAPL feature requirement not met");
> -                exit(1);
> +                return ret;
>               }
>           }
>       }


