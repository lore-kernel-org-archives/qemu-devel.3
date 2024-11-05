Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479AFD1266B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Fbz-0005c5-NC; Tue, 05 Nov 2024 04:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8Fbx-0005br-Cl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:12:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8Fbv-00030O-N4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730797945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NhHekBJKBLKEFOcVbXBFd9KjnJiTeNetvbObd1n9nOI=;
 b=Ao73BCl26dpqlLWsoBEbiHDZm0VarAw2Icr03okYlnexw0firkA3K+PscjNZwf5YVlfnHu
 WPzfD2xe36CMlna83Ij17Lrp8VVLEAn8HtnvnINxCftQdwgNIaDg/xsaYN1jTeeSn9saDK
 8xpKj5Dvk1fs5r187VdxfmCsOYy0AM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-7uICjkCbPUy_AL-p3dINeA-1; Tue, 05 Nov 2024 04:12:24 -0500
X-MC-Unique: 7uICjkCbPUy_AL-p3dINeA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso33061095e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 01:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730797943; x=1731402743;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhHekBJKBLKEFOcVbXBFd9KjnJiTeNetvbObd1n9nOI=;
 b=Oiw4C8sWrMj2T1Gx/jMPo6n7w+I2B8zTHU3YAmzNyn0Rshjn5IRVSKxkY8E97r7D6Z
 B9CkSRrUARDYTS06XQx+wI4NalrdWX8CK7+Bi7uIrlyN5kyvkacefZdzzhGSaXuTmd7G
 ErBbVqjGLV8ES1eOqgVrfgtIcgZ4xdrKqZlQe5b51gUCyqR4xEYQPymoB05sNm7zTBmQ
 7zgBsyCyN5huv7Qibggtmn5M0NnT/5MzAvQ84WWtGFGH0Teyx5+/KA8gfa1orex15M4i
 YTVdHTojiwqnyNKXttZCmOd6geqP42I4tDuFBCUbkg6vZ6NH+icUraeyAiVWdSV696Qw
 CiUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUe8Kyas384Sn5LgKh9N6SBENL5gZtCDVGVekrCCj3mHpv8YIZTFIYSXUjmHrw0XvURemueSN8z5nl@nongnu.org
X-Gm-Message-State: AOJu0Yza+7uNd8/a8dEyLYym9U4c3hbMHd4vySz4P4IDvJP7P3kl+J8z
 2A9pl7VwTYY8k2qX2SsnAjsMWVA3qW4vXLjbc2Uyt45H6aGxmHuyQbkV1iZfIy8MBl5gPZ/uQRz
 G5jS7GQehEL2XV+/AAYKz9cA6ztpckPuR0Dcczj1hZyZIO4A56VXS
X-Received: by 2002:a05:600c:1d01:b0:42c:a6da:a149 with SMTP id
 5b1f17b1804b1-4319ad048cdmr327242665e9.25.1730797943134; 
 Tue, 05 Nov 2024 01:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6zUjTp7xP0AwB0ZSBo252NNKx5L6LZGi6+tnqrcbUMgGK5sFPj5ZjdSvFrJqfhDDyesQb7A==
X-Received: by 2002:a05:600c:1d01:b0:42c:a6da:a149 with SMTP id
 5b1f17b1804b1-4319ad048cdmr327242375e9.25.1730797942776; 
 Tue, 05 Nov 2024 01:12:22 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4342sm15432868f8f.32.2024.11.05.01.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 01:12:22 -0800 (PST)
Message-ID: <9601f5a1-f1f1-47ab-a240-30331946b584@redhat.com>
Date: Tue, 5 Nov 2024 10:12:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 59/60] i386/cpu: Set up CPUID_HT in x86_cpu_realizefn()
 instead of cpu_x86_cpuid()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-60-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241105062408.3533704-60-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/5/24 07:24, Xiaoyao Li wrote:
> Otherwise, it gets warnings like below when number of vcpus > 1:
> 
>    warning: TDX enforces set the feature: CPUID.01H:EDX.ht [bit 28]
> 
> This is because x86_confidential_guest_check_features() checks
> env->features[] instead of the cpuid date set up by cpu_x86_cpuid()
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/cpu.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 472ab206d8fe..214a1b00a815 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6571,7 +6571,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           *edx = env->features[FEAT_1_EDX];
>           if (threads_per_pkg > 1) {
>               *ebx |= threads_per_pkg << 16;
> -            *edx |= CPUID_HT;
>           }
>           if (!cpu->enable_pmu) {
>               *ecx &= ~CPUID_EXT_PDCM;
> @@ -7784,6 +7783,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>       Error *local_err = NULL;
>       unsigned requested_lbr_fmt;
>   
> +    qemu_early_init_vcpu(cs);
> +
>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>       /* Use pc-relative instructions in system-mode */
>       tcg_cflags_set(cs, CF_PCREL);
> @@ -7851,6 +7852,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    /*
> +     * It needs to called after feature filter because KVM doesn't report HT
> +     * as supported

Does it, since kvm_arch_get_supported_cpuid() has the following line?

     if (function == 1 && reg == R_EDX) {
         ...
         /* KVM never reports CPUID_HT but QEMU can support when vcpus > 1 */
         ret |= CPUID_HT;

?

Paolo

> +     */
> +    if (cs->nr_cores * cs->nr_threads > 1) {
> +        env->features[FEAT_1_EDX] |= CPUID_HT;
> +    }


