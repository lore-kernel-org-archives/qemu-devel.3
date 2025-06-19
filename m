Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C11C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM7P-0001jz-Re; Thu, 19 Jun 2025 16:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM7N-0001e4-VU
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:44:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM7M-0005jN-8I
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:44:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so744625f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750365854; x=1750970654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tI1EgBtTvh/FMoCXd1TWOvkSoVKI+P6KzD64S5iYHJI=;
 b=Hg2NOcbWdTi5phx9XQyfsiN3/KrkwB7VKV+13VAPHOLSOS8bODbIIJPjan8HwFIB1w
 F/27ICGbApOenb6cu2+45EXBKB9cEwT8/SLQGLHsL2Yjk0wFtV0BUQtH5aWtBzVKi5nj
 R7AlUrBV4wyf/bmqQ7udX+a6r7N/GlTELUh4Leq8aJq3YYbB8KB39fpaoRErmInETF5n
 qcUTCl8Ggb2lc4YT8A7CGABcUHQrqY9UqHq4MhVLyoVYa4txVTING5x6EX8TpWfpvl2Y
 YFG+hC2bvMAXnNPuTu93+XUTFrmbBTrp4JzH76FQugayi82aKM5expnPAxSVS2wqOWt1
 FY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365854; x=1750970654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tI1EgBtTvh/FMoCXd1TWOvkSoVKI+P6KzD64S5iYHJI=;
 b=jimW5sKWXj/dANWWF7lXjL8K64Bd1SSqk1aixiYWsZOYBaxv8BnZfAV37yeE0v3FsR
 aK/Vj/J120JMKrEuuHHcrD8tMkML+DPhUWI9vnQoZnAlTlKl4qadhyEJfAUBhWkS5asV
 ng0wRtH8pS9wOLHQ/6O0eElD9CDMNBKVl7AzDB+INL7VqWl5DBo8oO8BMvaMUc8rSvSw
 cCY4t/VoM8KD4aH/K8UE0ZZwApTfXy6PHguRN/8a82log04vBBJbITtFOC2wzQkD0EAN
 YEZQIPSCVQGVYjMvBbLFSKwok+RA9fpk8P3zALiUHn2/A6vIDbdUA5uOd4lgxn2AoNAt
 /bLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULIfyA3yQwCIEQIFj8aR3LJv6Y09XoqdAIxFB/t6OI+aiLtSLUS4bCqVR8z6BDS4xQggKxcsJ1tlvc@nongnu.org
X-Gm-Message-State: AOJu0YyBWlYOMOqks8szh+I6ba7Rom09L9X5bURO/euT7SX7dAjgrlOf
 POdJbZbPzEgb3Ww3dcdN90xFUOIs/TTlEHW09ESHHq3z8MZDKfxv9b+DVVVBKHCAOW4=
X-Gm-Gg: ASbGncsiwlqp9+PjHNN3L6ZPhpfmD6VbQgc2V7BU0evZGohR0wLI5ThnbPGyUKpCdFL
 tpdZLoM9sakHTLPOkzZ2clePF8X2YQtL1Bqk9jKOrQ6dtponx2BxbqofIzS9vMGagm5uLACpHyW
 vz7CCs4pYORdVgT0QBVebz4xY0766yAgOUxAbYvSWW8rE5C5k9wt2lDSLg+p9seazn8ebFJQOKu
 xfrhaN/NdhD1A5Uzj2zLKtvsBi8O9iGjodx3xcjuGzHs6w66bMIDGTHWGDvhrkdzrV7xN6HyUYC
 91LRad8AysrS2KgyVjXd4AELRD+XRtFNamjX5NPgS56V1R6e06hQMRILGQ6hWfPi6arnsPIrBL7
 KyGlKCw+cMrDjkXccH/2dF5Zja7V6dQ==
X-Google-Smtp-Source: AGHT+IFaV+2JauysUDVJbhND1YpzWY2HO7A3Ib3fo7f05SSDptah0kOX19utrxSvVmfBAIoJG/CNug==
X-Received: by 2002:a05:6000:4205:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3a6c971ce53mr4328628f8f.18.1750365854587; 
 Thu, 19 Jun 2025 13:44:14 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364703701sm4580025e9.27.2025.06.19.13.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:44:14 -0700 (PDT)
Message-ID: <d934c4a0-3db2-4fb9-b7d3-38801e0893f2@linaro.org>
Date: Thu, 19 Jun 2025 22:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-8-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-8-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
> hardcoded to 0.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


