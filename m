Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE6FC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyd-0004wW-5B; Wed, 21 Feb 2024 16:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyZ-0004dH-9o
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyX-00011N-Mn
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:59 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412698cdd77so1284735e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550276; x=1709155076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eeX4i0DK4SphSxibAwB75cUwYg+pHr9ZvM93pY2qrKc=;
 b=YsthKlxpwx0ABbNuvx5StoyKbvdEd9X3dCodQt0+hypP4OTiIJibDZHDuMpK9mPWhO
 g87nAYrNkl0HZcJwW6wqRwORIUtrgsgCaULte7NWuFBKATlV6olddEZzrF8ytXXcQTEk
 YHhqerg/rL95wJedqTHtp9KJa1DkNxTvKuGGTe2PtYoCDibXb76UHMkbYFK8vD7S0j31
 OB4Wasz1FKVgDtOSslv3L/BJzO/GUjr9sPuTSWONIbHKF5/LD99cIUWcyICsvQ+1UwJ6
 Ew3Gy7F6WIZP3MuqKMav8wtiFuAOseSkS/OdN5eQZVNkPc9ad5tUX2EJUBTNfg97jyq2
 qvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550276; x=1709155076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eeX4i0DK4SphSxibAwB75cUwYg+pHr9ZvM93pY2qrKc=;
 b=B9fca6+gpiynvkG8y5nSHjtft2QrR0a8bAOrHyXlM42473jKP4ZYoSyaV8qL+sBBF9
 w21TtakWk83sUu/n7KMjPxpuodmCY7r7bt8JoBQMAvRTQn76nGYPnsieNvkQoMn92Fl4
 yFV0KYAi3HVoOfxDUAcHYJ6VeiZROvV5IskScL4Mcoaw74vU+R6sBJcEDZWeswEsE509
 8D/wt8tU8uskOm1kUUPYFBQMIAXhgh7Vt33V95mvs0rEO0c/aezEpLQQssoooKtK/fKd
 7r2IgYY5qqBUHcossNgJrK3Slld9+zkOzCnxTOrxY1n89dhuhUnwte0NMnNzz/+e+azo
 iz6g==
X-Gm-Message-State: AOJu0Yy5PNNK6tVGQ33XCY9TeblnOBtjJl5f3hjB6fLGNHDzsaXlKC2z
 gzXRn6ggnol/Kdk74uRErPmG3c0NBsW6LkGHC5vMSqxmS9pBUM9wkgFrz7KVtX/3n4muiBHQ3L4
 fzKQ=
X-Google-Smtp-Source: AGHT+IFOj7PyKzNFCqo+SYS30UxmV+sSq12WHe/P4LXDe7KdIc+6yJB5mBYlVdXE29jZtMYzAiF4lQ==
X-Received: by 2002:a05:600c:4686:b0:412:568b:50b5 with SMTP id
 p6-20020a05600c468600b00412568b50b5mr614541wmo.14.1708550275864; 
 Wed, 21 Feb 2024 13:17:55 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c00c700b0040fb783ad93sm18906438wmm.48.2024.02.21.13.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:17:54 -0800 (PST)
Message-ID: <a38ae499-a5a3-4fb7-81c5-1380ecb965a1@linaro.org>
Date: Wed, 21 Feb 2024 22:17:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/i386: Move SGX under KVM and use QDev API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240215142035.73331-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215142035.73331-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 15:20, Philippe Mathieu-Daudé wrote:
> - Update MAINTAINERS
> - Move SGX files with KVM ones
> - Use QDev API
> 
> Supersedes: <20240213071613.72566-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (3):
>    MAINTAINERS: Cover hw/i386/kvm/ in 'X86 KVM CPUs' section
>    hw/i386: Move SGX files within the kvm/ directory
>    hw/i386/sgx: Use QDev API

Ping?


