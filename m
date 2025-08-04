Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191A7C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj11f-0003lx-9F; Mon, 04 Aug 2025 15:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj10d-0002eG-Ob
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:38:11 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj10a-0004zc-58
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:38:10 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-31eb75f4ce1so4271638a91.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 12:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754336286; x=1754941086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1zsubyvwVn30bSAS37p6BLVoe8qvxmpIX/1NZepylo=;
 b=zy/cY2DkN0+jI1pYaWM3BCawOO7xsVW8uKK90dzDZW2aknXiur0SdfrNJTDcWHFSFg
 nPRnLS7QdZIIqN3p/n2WtL/6dpfnDqTORizGVvsqCwA68NMADxVNyOs9cBXW7KVvqII0
 KgR7ggYQ5ANezAJ6/5+v+DXJazgcyXssCMTnOvxUO7PIcyD6IgZAsjC5Q7yQKl9ldQQY
 GdeA2YAggjjJwNOfylNlNpM7m+/H7utYIZAgknsH5ORkL9vgEgp28VTkE62Nn7m1IvLG
 fkn7bEVomYcUooDCeSTYkLloaED5t6KhH+Ox4uf6j3/wQbRvb/JG02BTs/PFLaD7uj//
 GYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754336286; x=1754941086;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1zsubyvwVn30bSAS37p6BLVoe8qvxmpIX/1NZepylo=;
 b=o+/bFDr/P6fTopY1mX3SRi0BhMgrhgbjdZNIFSTXTna4tHjy229LhyQeKgyUUafdYy
 Ra1I3v+DCXFN42Sfk0Z3KoIJfXFtaG4IEoT0UoawIWlBEIYbR1ttwH98WJJGuEtosyzR
 xniSkLw1yQieHZCEMOwSOcUUBmiJzOUiUNEAwG9NzrL0WUs+5oeFUz4eOmhhYaG5gml7
 Z0YTNzPCcYCZl6UXKRU2idFOAb6NflaqoZ71optf50eumrLTIRWwS6GiOitiT2uvIhTf
 OjyAtXbxQlbHq5ZVUL8sft1Ppiw9mEXtzPShyHa2Mk0oMt/55sTTJreWoqZ1n5hDwLJ5
 qzlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7H1cgBQd6CFaLBsAfyvjy1NBe4Z7F72u7OtfX1jhDTdHfnD6ZVCqDip+3Yw0WOzWbt26sd6W87Z7m@nongnu.org
X-Gm-Message-State: AOJu0YyS8DTBFdnosAxXKVmtIsWZwMs/adP9X0rk0+ScKzl2/5jkceCG
 xFTa8lmCkK7G/zeypkp3W5kmxsxn33q9yXMwlIEJlIDVWmglnNH7CiN/01O8LQU+vrk=
X-Gm-Gg: ASbGncuJ1PBQq35lfSARHY8OQVe2VXQSuwEVt6AEDfsL5/sdMSlVEmGZnKLMWhDSDho
 ECmOsnP2UVENm9mVKMjYbnPIL6d21obmYxw3PrC0Hq2LNMJ61ZscOshvS8iFFL+dzgq6cn1Y7Ic
 8rH0elJzUDRcAt7Q0y1kmqgVG20PfQ0u0J8ZlE4k4kgwOafymeK5+Al8tFg4gfzae+v/M+mjuBY
 r9PLkvRikCAm7+NP9KQQxsVTUBLqgBaAxgLATfhmfDPK5x3W6LNeXcE+qMGQJlIZ7FOA3GzTnzS
 zUZp23GqZv0aimh00W92CcoCIrLhCh0HITMcsYbXHplJ02Pw2tgx/n5bWIn2sF4d4L2FZNT/RDv
 WgLk3PCvimvNVFxJn5zs7JxAmEudsoPs37ms=
X-Google-Smtp-Source: AGHT+IE5+Ucw4k581r3Clz4JLeCHdhrDNXmMgCFYxh9hDcukuxuOQYIMjRLHUp9cj5QKyW61/Ihhww==
X-Received: by 2002:a17:90b:39c5:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-321162bc325mr16157470a91.17.1754336286119; 
 Mon, 04 Aug 2025 12:38:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422bb19069sm9285105a12.65.2025.08.04.12.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 12:38:05 -0700 (PDT)
Message-ID: <00f14f71-aa5a-492c-9fd1-c22ced239197@linaro.org>
Date: Mon, 4 Aug 2025 12:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/17] whpx: Move around files before introducing
 AArch64 support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-4-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> Switch to a design where we can share whpx code between x86 and AArch64 when it makes sense to do so.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   MAINTAINERS                                           | 2 ++
>   accel/meson.build                                     | 1 +
>   accel/whpx/meson.build                                | 6 ++++++
>   {target/i386 => accel}/whpx/whpx-accel-ops.c          | 4 ++--
>   {target/i386/whpx => include/system}/whpx-accel-ops.h | 4 ++--
>   {target/i386/whpx => include/system}/whpx-internal.h  | 5 +++--
>   target/i386/whpx/meson.build                          | 1 -
>   target/i386/whpx/whpx-all.c                           | 4 ++--
>   target/i386/whpx/whpx-apic.c                          | 2 +-
>   9 files changed, 19 insertions(+), 10 deletions(-)
>   create mode 100644 accel/whpx/meson.build
>   rename {target/i386 => accel}/whpx/whpx-accel-ops.c (97%)
>   rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
>   rename {target/i386/whpx => include/system}/whpx-internal.h (98%)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


