Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08DECD37B2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSsU-00005J-PG; Mon, 11 May 2026 11:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMSsT-0008WS-94
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMSsP-0003Fp-Uq
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778514541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K/ct0BNnBbvXTY6hHd/PtnxtT3PVd9XSVKSqCr2mT1k=;
 b=gbsGe4a/4yL9PqjQnep3NClEslIX0cwhMS5wHOgEMHqmaKi+Z1BCTPtoyoaHF0JKrkqi9p
 qZ7OK4Dt4WCTg97MYv/6rk3hPCwqcEJ44M7NZVRmbwVNcdOXOX5V+5g8vKzy00qukEjMMz
 5fg56sreooHGnsUrzu9jGjF0QbUqvLs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-8bfbcqDqMqelbZHNlLnHTQ-1; Mon, 11 May 2026 11:48:59 -0400
X-MC-Unique: 8bfbcqDqMqelbZHNlLnHTQ-1
X-Mimecast-MFC-AGG-ID: 8bfbcqDqMqelbZHNlLnHTQ_1778514538
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488f973ddfeso32313015e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778514538; x=1779119338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=K/ct0BNnBbvXTY6hHd/PtnxtT3PVd9XSVKSqCr2mT1k=;
 b=sodOSXx9l6/6uFI4PVAlKIPqk3EcMrIvYcoYxPGA4o4DU9Fp1Um4KtEPqAkyd38+r4
 gf0XtCyegqtsmZgpgJsKptKS7BJP89NwkmBOjAIwRIS1a71bqRBxCy04MmpAyc8sCYfJ
 o2TnaoEG8T4eMADI9s7T1XIxSaWf3B8iP92rD4LcPvX0vvTsUprDUQ8rj5xHXK7EURRM
 YVxz9Zq4FDgwM4gHknNbL/xUVo/HGI6fa8n/08MUNn4RsGfjNMN+TCsFIIBLMK6ZA6XR
 kd6XArLZ3zJppHVsiM6xtSkclrnsK/GMfI94m9Dp0++aZHGYLFW/FB2xXub3h2Z903Jm
 NEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778514538; x=1779119338;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/ct0BNnBbvXTY6hHd/PtnxtT3PVd9XSVKSqCr2mT1k=;
 b=FA3bYft4yctU7NnMrNpUZ/w+MhZtgbaFsEuErULuLzraK25w68AfBCeyMgMmoMEUiK
 zInn3VZPhiWOVaiU6i8upb5VzPjL+lHpPHKRnZX4Y068acisjJ9YSjEZTqe5SSmoCjhF
 VdBO5LlIxlpM28JqN9Ew5mC7ZLFVjlWr14daUpLZqUFaOREXCDEeTM7ITbwPGVHT7K+b
 J685Pz1Rx4H/apFqfL1adzu9FzOodDQR+15kgMBuvX6Oi8vn2nbfe8kGRrpfdiX86YPG
 daCtmUaXz7BSqf/snfSRa0ILbtFDqlZTmTchHbxRhtgK3oW5+U7N7Roqiirb1TL1nwYP
 htnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dSqhgMCugm6kmypJTCL9OpKZD0oeguX2xgx1L8P9zf0a4TEcg5aHWrhwvVkkeGgS2nvVan3/kEe8K@nongnu.org
X-Gm-Message-State: AOJu0Yy+23RFnWnAJMT1eYza8NfKLypaNNF6VylGjtljEMiizDp2Sc5Z
 nJmsucWxbATMAbrOh1Yrt8DBF5kqZvvdQ3tRu3hLS+8pYmZohRaIU7HLaKgzqxbYlK8ki0zQIo9
 SFTGA5Du0hL+LaT646KYIKG5nMYPUHPTqxQDqXTySXzlb8gNZuAYyxvls
X-Gm-Gg: Acq92OH7wlTc+2fU7qNsA7roOMPWKM7UZN3dTVWKdFHHuVQh1Wuk9LsdItfab2m+l+P
 EMkn5prMDdxfuq21h03UoWpbTKBVw1BAmoPKb1icGVgR4S87tZLxdHNfl+aisU+koee1vJyntHJ
 qWTd/yREdWRhwwYQmuAVubXYSbmvD6koGGsbmOLExsaAj7oC0Geyub+x6n25iDaW9DBGesjtz1h
 c22o3RclPEoFR7DFc+9PRmgMAv/AAGa/Igy5vWLqtKW4+6pV4sk8ef96sxebJx/IO0mto/8Q6ZQ
 jQJiFlunrnRj9Mhi1OLx8RpXByqSRBrtBZWur8c+an1/WsHh3DvR4atm+8pXQl2pMMPo76Vdt/o
 XTX8i+MsVa9Q0evyC9Z867SGCXk/JU0bhQn4zXfno45q4pfogK2Nv7rlvQCI1k8uLMVAB1MQ=
X-Received: by 2002:a05:600c:470a:b0:488:a639:b772 with SMTP id
 5b1f17b1804b1-48e51e15485mr383332705e9.7.1778514538164; 
 Mon, 11 May 2026 08:48:58 -0700 (PDT)
X-Received: by 2002:a05:600c:470a:b0:488:a639:b772 with SMTP id
 5b1f17b1804b1-48e51e15485mr383332245e9.7.1778514537685; 
 Mon, 11 May 2026 08:48:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6db09a0fsm65003375e9.21.2026.05.11.08.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 08:48:57 -0700 (PDT)
Message-ID: <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
Date: Mon, 11 May 2026 17:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260506135524.20617-90-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
> Introduce a source set common to system / user. Start it
> with the files built in both sets: 'cpu_models_user.c'
> and 'gdbstub.c' No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20260423135035.50126-4-philmd@linaro.org>

This change introduced a regression with PCI passthrough which
stopped working. Guest kernel reports :

   [    0.156501] zpci: PCI is not supported because CPU facilities 69 or 71 are not available

and other devices (ap, ccw) are impacted too I think.

> ---
>   target/s390x/meson.build | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
> index 6f98ce34d73..44f58ac2919 100644
> --- a/target/s390x/meson.build
> +++ b/target/s390x/meson.build
> @@ -1,4 +1,9 @@
>   s390x_ss = ss.source_set()
> +s390x_common_ss = ss.source_set()
> +s390x_common_system_ss = ss.source_set()
> +s390x_system_ss = ss.source_set()
> +s390x_user_ss = ss.source_set()
> +
>   s390x_ss.add(files(
>     'cpu.c',
>     'cpu_features.c',
> @@ -15,15 +20,16 @@ gen_features_h = custom_target('gen-features.h',
>                                  capture: true,
>                                  command: gen_features)
>   
> -s390x_ss.add(gen_features_h)
> +s390x_common_ss.add(gen_features_h)
> +s390x_common_ss.add(files(
> +  'cpu_models_user.c',
> +  'gdbstub.c',
> +))
>   
> -s390x_system_ss = ss.source_set()
>   s390x_system_ss.add(files(
>     'ioinst.c',
>   ))
>   
> -s390x_common_system_ss = ss.source_set()
> -s390x_common_system_ss.add(gen_features_h)
>   s390x_common_system_ss.add(files(
>     'helper.c',
>     'arch_dump.c',
> @@ -32,19 +38,14 @@ s390x_common_system_ss.add(files(
>     'mmu_helper.c',
>     'sigp.c',
>     'cpu-system.c',
> -  'cpu_models_system.c',

This file is compiled anymore and the CPU features and facilities are
not propagated to the guest anymore.

Without this patch, cpuinfo reports :

   features	: esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2 nnpa
   facilities      : 0 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 47 48 49 50 51 52 53 54 57 58 59 60 61 64 65 69 71 72 73 74 75 76 77 78 80 81 82 129 130 131 133 134 135 138 139 140 146 147 148 150 151 152 155 156 165 192 193 194 196 197

with :

   features	: esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2
   acilities      : 0 1 2 3 4 6 7 8 9 10 11 13 14 16 17 18 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 57 58 59 60 61 64 72 73 74 75 76 77 78 80 81 82 129 130 131 133 134 135 138 139 146 147 148 150 151 152 155 192


Thanks,

C.


> -  'gdbstub.c',
> -))
> -
> -s390x_user_ss = ss.source_set()
> -s390x_user_ss.add(files(
> -  'cpu_models_user.c',
> -  'gdbstub.c',
>   ))
>   
>   subdir('tcg')
>   subdir('kvm')
>   
> +s390x_common_system_ss.add_all(s390x_common_ss)
> +s390x_user_ss.add_all(s390x_common_ss)
> +
>   target_arch += {'s390x': s390x_ss}
>   target_system_arch += {'s390x': s390x_system_ss}
>   target_common_system_arch += {'s390x': s390x_common_system_ss}


