Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CAECA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvusk-0004qs-M3; Tue, 09 Sep 2025 05:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvusT-0004qD-90
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvusO-0001zC-JP
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757410976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8JNMZJzpDQ1BDE7ng0IXn7m0+OzTXdiSyTijcSWoROk=;
 b=VZ9kZXoz/qxtGisTVOVSCTpCZfNPMCRazZjUwjFz5DDWav7G3TPU+ML8fzTmC1V9+uW81l
 9Yp78u1tVeB0y9FCMYKd8kmynWcOfPRm9owuVHnvmJYi3owOF8Bx2A5Jc/6REZkip4ga1f
 TZ1JuAgX8AvSnVp7aJeTnfmn54yeODA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-i0djVEuTMgqKsP7e1q3UxQ-1; Tue, 09 Sep 2025 05:42:55 -0400
X-MC-Unique: i0djVEuTMgqKsP7e1q3UxQ-1
X-Mimecast-MFC-AGG-ID: i0djVEuTMgqKsP7e1q3UxQ_1757410974
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ccd58af2bbso2942591f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 02:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757410974; x=1758015774;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8JNMZJzpDQ1BDE7ng0IXn7m0+OzTXdiSyTijcSWoROk=;
 b=bm/WQo/t9xPp78yJsUUhwyMDw6Z4C8uU77n9iP1V5tdNcuiqaCSTm8uyQiCGSZfjTi
 vYjZY/9snOcYkZ995b32zPbP3/kU5iROE0kkdCjevWu2D/6LpzNo+fZ7my59l7UUytna
 F4fzbJwzHtc1ERLJsFWGEGg6vQslmNT681uPGD+88KD5PdQE56HFbDiAA9MtXxwJvjnK
 GED+NTF/HDzSaCSy8iOvbL5zJzwW9EUk384IjqfF0s9H7HAi3kE/PZnjF9ovuHkv3nel
 fXnRs705fRZJQXLW/6VB55o7Z5Zr+TkiHqeXkQVQmrXYi5rZX2tqLPgyagD76HjqMSj6
 J2HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZgNXs24AmGJSJLBBOlLXNJjL3Uy3CaebUXli28IA3iLQ9SDFvrhUHTeAi65iN7ioGFdqx5RktitdX@nongnu.org
X-Gm-Message-State: AOJu0YwDzhjnXUDxPgvBeBm51U4wCafeABksyWtQaojpnUwDUk5a7nA7
 LQtbfFUrI8s29YEOYj7KquZI/9/ZaOkPWEe/m9gUBIapQ3gtmwgpsHmsCTFwEclDN2eH4ZV5G3E
 nwTN8bVMT9e2D/RB0O88n0yNlYJdB03SR6f8l/o/d78XHm8cCkLKCkLKJ
X-Gm-Gg: ASbGncuZIjqK+xMAUzDEq8qpHLs8RT6DWSJMn0C1UAEl8VOP2e24JttHG0Ogbs2npvu
 xJc6g44/fzPXvyFF8fNnoYt6hc4dR91ZvJYvU2ljQUB3EtruEg++/wUxkGjy843qEFfVYgYXCPx
 5hPaldEjUfIldM3hkEwmv1E4u0JDwzcza70dfu7weYdk7N0DJPRhhuSgvu5OP8ZBRUb6gBph/vi
 JBNzUAvf7LIYVG9tnBwrT71RAHZQqrvVE7XsNKml/QFVn/G2Y6iYFPI2mD1H048SAbldCtLGaJ/
 ebefRn3RAY1Auwq+Mr6/p8bDsyAYmvdv5R7K1dDtXuAbX0xVM0sv3H302BYqxkc9wWG7EqTvPU5
 /lPw6Dg==
X-Received: by 2002:a5d:5886:0:b0:3cb:fee1:de33 with SMTP id
 ffacd0b85a97d-3e628046364mr12108114f8f.7.1757410973953; 
 Tue, 09 Sep 2025 02:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzQ4yKmHeHKxfLwj1vPUB3wb5+Q/bHIeXL96uhMnut6EM4EyjqMKJV+yWl+FrpwYsc9FfWYA==
X-Received: by 2002:a5d:5886:0:b0:3cb:fee1:de33 with SMTP id
 ffacd0b85a97d-3e628046364mr12108086f8f.7.1757410973446; 
 Tue, 09 Sep 2025 02:42:53 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223e99csm1930130f8f.43.2025.09.09.02.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 02:42:52 -0700 (PDT)
Message-ID: <c24112e8-dc1a-4f52-b2ec-6f9e35ec1b0b@redhat.com>
Date: Tue, 9 Sep 2025 11:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] target/xtensa: Fix AddressSpace exposure timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-5-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250906-use-v1-5-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/09/2025 04.11, Akihiko Odaki wrote:
> xtensa-cpu is not hotpluggable but its instance can still be created and
> finalized when processing the device-list-properties QMP command.
> Exposing such a temporary instance to AddressSpace should be
> avoided because it leaks the instance.
> 
> Expose instances to the AddressSpace at their realization time so that
> it won't happen for the temporary instances.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   target/xtensa/cpu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index ea9b6df3aa24178c8e6a88b02afda5db659199da..63edc3a5b2778c8379a30125481f65361655fe1c 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -243,7 +243,11 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
>       Error *local_err = NULL;
>   
>   #ifndef CONFIG_USER_ONLY
> -    xtensa_irq_init(&XTENSA_CPU(dev)->env);
> +    CPUXtensaState *env = &XTENSA_CPU(dev)->env;
> +
> +    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
> +    address_space_init(env->address_space_er, env->system_er, "ER");
> +    xtensa_irq_init(env);
>   #endif
>   
>       cpu_exec_realizefn(cs, &local_err);
> @@ -268,11 +272,9 @@ static void xtensa_cpu_initfn(Object *obj)
>       env->config = xcc->config;
>   
>   #ifndef CONFIG_USER_ONLY
> -    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
>       env->system_er = g_malloc(sizeof(*env->system_er));
>       memory_region_init_io(env->system_er, obj, NULL, env, "er",
>                             UINT64_C(0x100000000));
> -    address_space_init(env->address_space_er, env->system_er, "ER");
>   
>       cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
>       clock_set_hz(cpu->clock, env->config->clock_freq_khz * 1000);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


