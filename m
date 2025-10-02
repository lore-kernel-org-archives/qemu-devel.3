Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C38CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ec1-0007Fs-9k; Thu, 02 Oct 2025 04:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Ebx-0007FE-CK
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:24:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Ebe-0008DJ-Nk
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:24:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso493624f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759393419; x=1759998219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20LDNmFwkfiVk61jWphsVdiDgC6U6aBSpattiB/Wm98=;
 b=cR92IIqyMoi3Kexa/z7BHXSLtLMoBqNLysfkkv36zaKsO+Tr4LocZUtMQaivOzYQ0O
 LH0qE4+793zXl732WAUWqNiqzeTQU5ssHhGV20R8XWTuwIUnt1GQKLVvMiOEeAPXVWZu
 BCVZeJO8VCR8iR/6slnPak4d4SbwsjGKPrKAnVLosRCirT5KJp2tF5IufhsqzLOFjjpd
 cLFJfJ1yLbX2y9d55lOSIEXQNOowj0CmRHPiFVJi0gRkTg8WkDJPgb+z2jb8SIEMISwu
 peB2JpM5pSdL2tKDyps8RCQW3ZGk4G995g0C4V1IxtrncEyUpBJ6qOfMxA+oqQEhW7i7
 KJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759393419; x=1759998219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=20LDNmFwkfiVk61jWphsVdiDgC6U6aBSpattiB/Wm98=;
 b=Qo8tlhWlJgZsx8faln1gJFRijIE0uhrne2SNgbNZLya/faq2i7ZsGMTcki73Ybezm6
 2gU+vjBLSG1Tktqdi5H56gJEP4PSF2+DJKPntrs1aoRvre/BefZWxSu8np84Ft1ULlQP
 WXMgaqWj0RQ7yJY4hnp4/tGTlPFobmb0g/jTzy0MaJLNAfthbdJL7f9D2oyu/DUTs+h1
 mS9DBCQ9u/DHp2G9jIefIQs5xRRbvzqYsuHl0N2pt5s/IqHPzT8y4gGfNgGhlUAjuYSN
 fYI/itvAEPBBJNeKUyR6HP3j3DkYTlj/MplPRh0qLgbDkThVTaShT9T1LWy2V3hyncSk
 gaIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX31+H8svs5dfvN+l3p8LgPkUsjQXgKu+005cIb/BwOR/PvlTLmVb8FG2fmPDgwK7dn+hOo1xdrDujj@nongnu.org
X-Gm-Message-State: AOJu0YxqguUanPFuiz8rQr55bpYlKf3xZbnso3GWSkm3ozcPXYWF6jla
 SjBEXy35s7BA9JvRI9dy/KduxCdHOHLPMBHsNG03ww8yqb0vQ9K0ZErg4uG1OspJcTQ=
X-Gm-Gg: ASbGncvRnp1SD0q29MLoFmzjS3Qh2Uq4N+1o2eD3Kjd3NC98UcTnE0MQcKWeikvGlzT
 zF/GgmzMht7OA9DzCpEhMAQEoaLslQJat8aKBafDQAWQnPG6xdbfgPaIU2brEbGfyv+AQvWxDHb
 pv+gKZrVVplp4o6mwm0nUb5n/m6RikE80x3JqEVLfZXEyN/gQN9tPHBOU6m+tdg224zpQP930qZ
 A7EIOrC4xPrkppOADUaawMTeYAJiT3+vmvt/hA3RHrOg52oiGPrgNbtIJ8XmyspPuOfEX+ADZWj
 3AWIj1Nwxp01cOB7e17emjDXrb44j6OZg9ZIK+ciZpTATMbI3J4qTxazB2X76pjYEB1XM74C1u6
 b4E1Pf5Ndb10WZryOFCye7GmxUQeGJISZZFZfuRZqgaKcjWLh0wsloL5zjtJsBtmKwp/C1g1ZBx
 HHhsTlxc+nv/hWhpOVqg==
X-Google-Smtp-Source: AGHT+IHYGMTEcSwLrD3/d0AnwhXckt6mkAPLz1q7/xpYZkUGtMMnsJP/2oWwUfXPWK6xW0Jvy8bHXw==
X-Received: by 2002:a05:6000:250e:b0:3fc:cbfc:fbee with SMTP id
 ffacd0b85a97d-4255d2ba6ebmr1387460f8f.19.1759393419362; 
 Thu, 02 Oct 2025 01:23:39 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f027csm2528397f8f.40.2025.10.02.01.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:23:38 -0700 (PDT)
Message-ID: <e132baba-6d75-4263-9203-65d7d7c7f739@linaro.org>
Date: Thu, 2 Oct 2025 10:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/27] accel: Add Meson and config support for MSHV
 accelerator
Content-Language: en-US
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Cameron Esfahani
 <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-2-magnuskulke@linux.microsoft.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916164847.77883-2-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 16/9/25 18:48, Magnus Kulke wrote:
> Introduce a Meson feature option and default-config entry to allow
> building QEMU with MSHV (Microsoft Hypervisor) acceleration support.
> 
> This is the first step toward implementing an MSHV backend in QEMU.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>   accel/Kconfig                 |  3 +++
>   meson.build                   | 10 ++++++++++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   4 files changed, 18 insertions(+)


> diff --git a/meson.build b/meson.build
> index 3d73873356..6bd1d897e3 100644
> --- a/meson.build
> +++ b/meson.build


> +if get_option('mshv').allowed() and host_os == 'linux'
> +  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
> +    error('mshv accelerator requires x64_64 host')

Either:

        error('MSHV accelerator requires x86_64 host')

Or simply:

        error('MSHV accelerator requires 64-bit host')

> +  endif
> +  accelerators += 'CONFIG_MSHV'
> +endif

