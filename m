Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15602C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNuU-0007My-53; Tue, 20 May 2025 10:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNuM-0007MZ-7K
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNuH-0002wD-7M
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747751123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0F1RLQx1wpJNy373HzOcgz7CQ7Ie/dR5ZDtzCamxPZ4=;
 b=DHjaXrGNkGAaqOSvk38wFKOgTCMf8JLUP+RxtprzX0EuEwXHopWBsTRPEXSXMvQV7e11sn
 NKqtxOfpuhFuzT5Q/Fyv9+CNr1kRiEifwCfgaQqS+e4PW10UHwu/CGIjdjFtdXohx5mCQv
 F5HA7aG8sxl9ghfwuqYwnd//mhK8k7k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-5sRUIhQdNjWbatd7QCUurQ-1; Tue, 20 May 2025 10:25:03 -0400
X-MC-Unique: 5sRUIhQdNjWbatd7QCUurQ-1
X-Mimecast-MFC-AGG-ID: 5sRUIhQdNjWbatd7QCUurQ_1747751102
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac6ef2d1b7dso445937366b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747751100; x=1748355900;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0F1RLQx1wpJNy373HzOcgz7CQ7Ie/dR5ZDtzCamxPZ4=;
 b=k+L2nnLRaecyM8pbDDXptiI38CjKLpaaq8ikSoiOC1zizPUyu4vPi9Q5kYEI/B72N0
 CrmN6kVt4+3+J4HiaaYO8ZzCS4+fpR2ZLoLWblXn7YN3CWzVjHCN68C0KHBkPyZ/cmjk
 V1zUnMTKH4LnCCzbJRtPvOAm1z+TL706T6qJPIzfzBWio4/bIr5yL2f1WAxXKfDrfNcC
 fqQLkRmjoxL+X0cX3nixIXNcEuJF7doShtqtCMvbv0wktVsVTkiz1VBuqq14/ho0sB1k
 dobordQq/I+JnDGZY5cfRj6xYm2YQfDtAamh7hOJkBVWvQwcKDiK0b70aPbyeo7IlvPO
 CGYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyarOJRumj14mVU2lf7OTAGvny2/zsk1LXP3TwafepCV5x1QoOYxfYvfS1v4w9/U154EvT0EcDG4BA@nongnu.org
X-Gm-Message-State: AOJu0YwoRYnWzjr6zsXELXZXFc/lC72rRFNNMevh5wQ/p6kMOJR9PQ/Y
 Cb92/ipToHc6EOKJP8fZfbNdhUGxJWtwT4FiLEPBkAKjA5Sx3MMXZulK1OBbE3oJ+/aMFeC+ngH
 hNrD+SfCZC6ZenSRCi3NvPOrt/o/3X2ddXAMtyo7BmrcDV+kROeervGBIJNEaKT/Q
X-Gm-Gg: ASbGncsst/fepBmZPh7WzKTInssrjsmz84N/EXKFr5fXhPwd/QTHzbRZg1T7SNRlSoj
 9Gog5DmdeQrMT9wPKxDPe9hm+TC8nfJNXXyQsH1EYkMTcPpGxPnUA9r0Xah0XtM3hapvhX+lgAF
 OsMc8BLb9/XBvhDnFIVRj8JUfbWOAw8a3rMFwZjarTVfW/VyxM0hf7BYSyv6K3VEtaL5nOq9uYt
 1PxYrfdYE6b4t00F6ktlnTAVMfVDFTMdQb+aCYWHSxm4Tq6kg9MlWlpf45lyJ/pJTVZxVEG30hH
 jOW2wtpmkJcgWQ==
X-Received: by 2002:a17:907:1c29:b0:ad5:7499:2644 with SMTP id
 a640c23a62f3a-ad574992f9amr603619166b.54.1747751100162; 
 Tue, 20 May 2025 07:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa5ogUPLlFK2/NGuZtXJRrXnU7HKpJn4V5kOgMysIyQThNrcBUcWR5vxj47xUmxcD/35Mxhw==
X-Received: by 2002:a17:907:2d2a:b0:ad5:1e70:7145 with SMTP id
 a640c23a62f3a-ad52d4e746dmr1622126366b.22.1747751089325; 
 Tue, 20 May 2025 07:24:49 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383d6sm744041566b.102.2025.05.20.07.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:24:48 -0700 (PDT)
Message-ID: <90efb003-6cf3-4555-ac4b-1aeae141e79c@redhat.com>
Date: Tue, 20 May 2025 16:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/25] include/hw/hyperv: Add MSHV ABI header
 definitions
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-6-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-6-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/20/25 13:29, Magnus Kulke wrote:
> Introduce headers for the Microsoft Hypervisor (MSHV) userspace ABI,
> including IOCTLs and structures used to interface with the hypervisor.
> 
> These definitions are based on the upstream Linux MSHV interface and
> will be used by the MSHV accelerator backend in later patches.
> 
> Note that for the time being the header `linux-mshv.h` is also being
> included to allow building on machines that do not ship the header yet.
> The header will be available in kernel 6.15 (at the time of writing
> we're at -rc6) we will probably drop it in later revisions of the
> patch set.

We do ship headers copied from Linux in QEMU; please modify 
scripts/update-linux-headers.sh to include linux/mshv.h as 
linux-headers/linux/mshv.h.

The other three can remain in include/hw/hyperv, since the Linux 
versions are not intended for consumption outside the kernel (they're 
not in include/uapi/).  But when you copy them...

> +#ifndef HW_HYPERV_HVHDK_H
> +#define HW_HYPERV_HVHDK_H
> +
> +#define HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS 1
> +
> +struct hv_input_set_partition_property {
> +    __u64 partition_id;
> +    __u32 property_code; /* enum hv_partition_property_code */
> +    __u32 padding;
> +    __u64 property_value;

... please change the types to uintNN_t and drop <linux/types.h>.

Thanks,

Paolo


