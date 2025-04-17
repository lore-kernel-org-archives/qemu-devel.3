Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4ABC369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TzL-0003tj-2k; Thu, 17 Apr 2025 14:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5TzJ-0003sW-Ng
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:29:25 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5TzI-0006uq-3f
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:29:25 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so768143a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744914562; x=1745519362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IdkRhV1bTd7+nm8z04rny63YmAzulUCJraG/xpkYApU=;
 b=RfDYzhxvRPS+3KQzZfSf28BnH9xENRacM6NRskn8EdfQ0J79d+IPE1UilR/S7qxPUI
 +4SNkqiot47Kiq08jQRHGUc2AGequQYMkpr6BpwWoJQ0fINC1rgWNaZAJEQYqLfTyYCH
 CTPIyFMx184NHaUZtwmvlQd9iTEpTnprO6wuDgaaqzlGw3lYHQVj3tHJzR9GiqAEQq8g
 K3HMPGFeT5vXOnY5Au7EUqE4EF6nIBr7YYTd73e9nHYPjBmiE4b0vx+bBRSxw4erk0HF
 iGCkiziXVae/dX/YOFZrfGL6vwcce1/zi8H9gm1TOJns2tGybIGejGy15ZUx7T+6Sdtq
 04yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744914562; x=1745519362;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdkRhV1bTd7+nm8z04rny63YmAzulUCJraG/xpkYApU=;
 b=l5SbSz8RdxO878KaiR+zKf1BykoJaC9jMZD2pmWAqHuKD9NCLF1RgzU/OVXWTZmbqI
 38XTg1+kcRL9um5z9BtjVNNoLJYaPtbivv61R22OVpgl9JGQ2TWAzdwP5AjBtU02Ubp9
 i3D9RRvKs7x1LijvJi+W+AwCmjCTTskHLZ/Z052WLdRcWWPDg/xDNXbFXUP9rfFL/0Ls
 3TBlYmu9BJGqvWVcvTUJnUEYqANdl1bRqFLer1uBHpJZXQm/eMt9ocsnOcLXAJjx7hXb
 wFmL5LTk+WJJqjiK9LGqUggxldsgTQ9VJzyxmbTO804BQb4WdpmrD/2LbIk1s3PrmSKX
 93tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ZPpBXjB+YEqRtuu9BtkJlvqIC03QeytLQuR0+azLmHaWZkdK5r9CVMxNvLJYPzQfEjIBe58L4tEu@nongnu.org
X-Gm-Message-State: AOJu0YyBLWbArSwEZScQ+ADONaVjdElSP9DkmWHPykl/SwvCVrM0c/7v
 jVjF6MHe/fDOBgKXETOLCItVJD1Gzg7hyqs0L4fi22zyFK+rIxrC1WH5JKRlXVE=
X-Gm-Gg: ASbGncs53fOGgJ4i4GkX8f2XblVyqQ849FzSESjjA0kjybKxfLiXqMI4bib89lAm9ZO
 tuWogAdrFEgz4b8Qj6i83csAH8Ewcs7u97CZNWrVF3KAxjIXoPXQ9gjYNY+zr0fs6mFb0Keqvgl
 c5e/SAQl+/vYdDmVtnq0e+1tsRb/1wrKl7Y/aZc6ahzCdjN0tQEJITZkQdSja9ZNZaItKuKiCrM
 IxFZdCIIk9zy58TV02r/QUiZ8agNsE8Awdtfvcc0oJewx570ATO8JAqyEX/Tg71I1h7auuAyZ4k
 BsXVzvpfGcfLCDJ2SzriGcJFj8xatPIul5BLKMcUp2CmCWgEaW0Fk5ORsuInh37Y
X-Google-Smtp-Source: AGHT+IHOmyQ2f4VQPeSfIY39FawWY2o/kbMu2aZnlui6+A9qBLFZwkrgEsGaEghwNecLUiaL+REaow==
X-Received: by 2002:a05:6a21:8cc6:b0:1f5:7007:9eb7 with SMTP id
 adf61e73a8af0-203cbd418famr148285637.37.1744914562348; 
 Thu, 17 Apr 2025 11:29:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13a3bdcsm202417a12.19.2025.04.17.11.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 11:29:21 -0700 (PDT)
Message-ID: <12094470-37f4-436a-af71-f55a9d006c70@linaro.org>
Date: Thu, 17 Apr 2025 11:29:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
 <84eaddaa-ad02-4cf9-be3d-3d8da7a2d312@linaro.org>
In-Reply-To: <84eaddaa-ad02-4cf9-be3d-3d8da7a2d312@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

On 4/17/25 11:28, Pierrick Bouvier wrote:
> Maybe it would be preferable to focus on providing a minimal but
> *complete* TargetInfo before upstreaming any of this, as it's really
> blocking the rest of the work for single binary.
> 
> Minimal requirements to have a complete series would be:
> - Rename QMP TargetInfo struct to use that name
> - Be able to query target cpu type (what this series does)
> - Be able to query machine cpu type

s/machine cpu/target machine

