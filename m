Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72BDD10F5D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOH8K-0005EI-Qi; Wed, 26 Nov 2025 10:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOH8A-0005Cl-SO
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:08:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOH88-0002aG-U6
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:08:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so52260365e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764169707; x=1764774507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gqGAzMw9ESOvsjAfVjtOrCVchAEIO7VlyQNMCvu2rOo=;
 b=z4C9dflLMeAMWH2uIWuKGCUH7je6kKU5hyQCEB6ubhjxpfD5Hlg5E9pIas/Ez3fOYI
 Igov4oP7Wki9BpkDCJvf/k3eVLLM43514uvkufFtogPXQKknU1qB6J4ZQvWgnUuwe0zg
 lzd+tZFzUh1JtglKMti/txqqK+vbfDY7eTdNakKEhgi80dVMPSrPm17t6uM3Su+9Cbhq
 CtedUVIoXayHRQeLBukZX2z+eGyAqyPJIbSDNs8Mx8KT6f0L3ZeF1oEVTAf6qcObS3vS
 S8h5V6W32ByMVB0uj1N91YJDaefQkAgJEVJxd7TjH0h9dIiFJDNp1bvhmdpuufhv6cw1
 Kc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764169707; x=1764774507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gqGAzMw9ESOvsjAfVjtOrCVchAEIO7VlyQNMCvu2rOo=;
 b=O+ixfaLI/s7kE/1bPFO57zZbM80sYP0X3UK2JYvl3uvlA5EEvkEByhIBGDuvST694z
 Y2OXLaJJS1ZPwLqO+gGwLiI4dbz4n5I+Iowcd26LDZ2+ZAu91S3TErZ+Y+b9m+TyJv25
 qpwtH1TG8aRKSs7+3HQhGCOSD5n1GZb9Wn+eljpAqHI3U/2ufCucdR4HMxCKbzDCy/OZ
 MgK7/w0kie8XvBGa1yKMJynOIDT+ImSjEDqPXbmAjX/eQEMCpBmnM1jcOYm4KzDu7Fn/
 6c6MpJCWxjR9SYGKx77pUc2Cu785DSNEv2SqvP77u97l+EQ7hNjmeraQed12eHi5vD4t
 jIwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf6eCvcfZ0sjJK4yy8n5p5ffb6+avn7T+ieiFNALfj2PYPhOWUG89RiE+YjM8qNV3qFnK1JjpLRHgG@nongnu.org
X-Gm-Message-State: AOJu0Yy9VhASfhwk3+F1S9sIPYG9yxpGcEgZB6RtlkYD9jw3T2prYqTI
 kWCNRux8VPj5Xcf/68e9Y5lx2CWTyF+cW15ttxKNzWQ9bStrOKEbcEt+QSNFUDRs1SA=
X-Gm-Gg: ASbGncvqAErMbUeKQhImxECXS8BrhT+35GupFM/tF2qO/R+QCcaMqavMxtOMTLLbKLA
 XraUBIiaQebRJoye7ET2DX2BzAMX7LiC4jib9jEdacpkOG/1/0T8xBrOmnhfk6tzC7vnC/iT5g9
 5BbNFdZLUoTnsRY8/V6s1I959xdzF80VQMRE3FtAZQ5Q/GxW9UgWL1GeeL9kPOaDaAxQEY9sq6V
 bmahamy8L4/aksPdHmxJbCZd28+g6y4g2rSMHX0ratttnRCBM7NROfE3b3HXAzaamWtpyWOdSQh
 va4V/Rk9gA0rdx3fIXGweCMUH+NRsCtzoZ+iEAUPr1aDj7nvkl++8VaspXaCgvR/L6W98kmt/vr
 szCJqWqkVsbteCpF8Vio2izJ9ru5e7IOJAVwqoEMIrwMUIHFQw/u59b1HWHfbAahGt+JrOrbXb9
 ZP6tj2cvnq8RXPj21rRshwZvylnzgYytTdLFuIAz9YFNmwVe2AmPE17A==
X-Google-Smtp-Source: AGHT+IFEiqUHO1ZPb0R2oI9bJ07UHGYBQBHUFhIiiDObO7u/IvwHLg0VuGERe6WCCtL03uj49PsGIg==
X-Received: by 2002:a05:600c:1c8a:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-477c01ff636mr216867265e9.32.1764169706764; 
 Wed, 26 Nov 2025 07:08:26 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add608bsm49441675e9.5.2025.11.26.07.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 07:08:26 -0800 (PST)
Message-ID: <0384e63d-7bdc-4887-9244-0bebbd00b561@linaro.org>
Date: Wed, 26 Nov 2025 16:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] edk2: drop 32-bit build config (ia32 and arm), update
 aarch64 vars
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20251126142116.4077056-1-kraxel@redhat.com>
 <20251126142116.4077056-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126142116.4077056-5-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 26/11/25 15:21, Gerd Hoffmann wrote:
> Upstream edk2 has dropped support for 32-bit architectures.  Remove the
> build config for these builds, update aarch64 (which used to share the
> 'vars' image with arm).
> 
> Drop references to the 32-bit builds in a number of places.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/qtest/bios-tables-test.c               | 28 ++++++-------
>   pc-bios/descriptors/50-edk2-i386-secure.json | 34 ---------------
>   pc-bios/descriptors/60-edk2-aarch64.json     |  2 +-
>   pc-bios/descriptors/60-edk2-arm.json         | 31 --------------
>   pc-bios/descriptors/60-edk2-i386.json        | 33 ---------------
>   pc-bios/descriptors/meson.build              |  3 --
>   pc-bios/meson.build                          |  6 +--
>   roms/edk2-build.config                       | 44 ++------------------
>   8 files changed, 19 insertions(+), 162 deletions(-)
>   delete mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
>   delete mode 100644 pc-bios/descriptors/60-edk2-arm.json
>   delete mode 100644 pc-bios/descriptors/60-edk2-i386.json

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


