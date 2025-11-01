Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58DFCCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 11:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF9Wj-0007uV-AU; Sat, 01 Nov 2025 07:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF9WU-0007st-9j
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 07:11:54 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF9WP-0005S9-QN
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 07:11:51 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63c3d913b3bso5743138a12.2
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761995506; x=1762600306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=51kPi4dYc3eUaVmK5npSELX9Pn2ZA6qJGcNdbBFAurU=;
 b=HxylmjS4+BKKlc6XNPcEsUFUDc1r0pv32ydO33pqcplW2NrNFa+oGJWSnbtfXgDV73
 j1ZUNHVhYTNa6PAhvtyZInRHehWy6dXe4QCWZxuSlYAS3iAy+O+uDsXdpjcklfxjjY1l
 47/Z4AIHwTczkGI3ewoR/uxqIYMe4iupz5r4te5oe4qf/ANF6OCDKHCo0PaZfIIASAbH
 aGZ1o+EZ0iXBHyA1BeU5mgBLdWTOYzx15cZCsVcRgO5GBeFOCjq4Y+Lx5sRVU9igt/uG
 SKIEy2Xg3PxUjaI3dS1ERE+gVQi37Yf+abxKhaDXKjoM9Vyw8hUpZlFJAOlQ3LHDZ/F4
 WjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761995506; x=1762600306;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=51kPi4dYc3eUaVmK5npSELX9Pn2ZA6qJGcNdbBFAurU=;
 b=n+4yj/aK4LimYGISonDe+GbhewG8E0XVJVjexDCAWWpS+zijwLNqXjxkPPC0SFzPo/
 bHCQdegVdVTRNYxQUZL8efhkYB/ZV7svgfiigyb8Kf1f3FpeIFphPkTdRTiTPUfakHz4
 g/NE/OtGJJq1cVRjgO4l8ijRTwM8Z/F9bCi5LwVDHTRo+l7/j1zdpsCTlmsN2brnGIoM
 87f8RO+ftTcQm3XbMWBcNJwtiIixVGiEVjOPs1dLyWiYdhtkOy/zeLcwYnIWjnRGBe7e
 Z+cZXi9lmQEZS45SgMT2Bl9lvmerKAOMtANkSys+IohDM0XUXMM5l/CFbyNGDkc+oZk1
 6N2A==
X-Gm-Message-State: AOJu0YxBfj9jHzflJctpUR5duDGgV0gkollbXXFcP9tv76L5+hayT9Tw
 XXy8rX+fUP/aPJzYzDIXT1DsVZ5Q0YkkX1k+9+WSJG9QOH4QxYI/Bz0UqT5jB4nt45LYHfewfTT
 x6b6yBAM=
X-Gm-Gg: ASbGncsVBZVP5m++zoKc2DOBMbMflDATrRJ/tqRwR60/ZCT11H0uy0AXrIq3x6VCxgx
 TCmV0peWPotOJhUozLUyXRi8g32dKMriEsTXOow2COEY96NGfpeE2NrtFvOp+7oY7CnXNpXD351
 zOtX6+P3Aft5ghMDRILI/BqVyj4efpuxFfSVeFLcwLZx4ykdF/oQKKMxMKMvWkwWNY6I2/AaqTO
 /t898gAgJqWtt3kFiAVsuM3wEIa+JcM20V7omgayFXcPoAhz8aPpYvYFAwqWYKFhSsZ5I/r79h1
 FcHmUZ4esbYqP4Y/BhbLEgnXIp087CrDxLu6776etHc9iXm1ciKI6hvZPi929gTOvTF9xP53q4I
 Awarj8CNiJFcbz4Zs3DxFQdQj4by3AQibeAa5F39tyZKmcXSIaxf89NPj5zXtI8PmMnvYH1X0mv
 wN+iYdGszVtgHdtAg/zQPvoi154uwwaOpCBeZ2hyuvvx5PN4x9bhQ=
X-Google-Smtp-Source: AGHT+IGWCkiwjI/8OSPGqxmpNYFxXRqAAbrxISuBfJCwHRn5co+VNbXpGea+5eVee+AoqNycPRVC8w==
X-Received: by 2002:a17:907:9403:b0:b40:6d68:349a with SMTP id
 a640c23a62f3a-b70704dc16bmr621464966b.39.1761995506443; 
 Sat, 01 Nov 2025 04:11:46 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077d065e1sm431383266b.71.2025.11.01.04.11.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 04:11:46 -0700 (PDT)
Message-ID: <06e169b2-9e93-4619-9215-b36136c950a9@linaro.org>
Date: Sat, 1 Nov 2025 12:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/38] target-arm queue
To: qemu-devel@nongnu.org
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52c.google.com
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

On 10/31/25 19:32, Peter Maydell wrote:
> Hi; here's an arm pullreq for the freeze. Mostly this is Philippe's
> hvf cleanup work, but there are some other smaller things in here too.
> 
> thanks
> -- PMM
> 
> The following changes since commit 3728de31925ae9658e2ce3d1ff9b63c83609f310:
> 
>    Merge tag 'single-binary-20251030' ofhttps://github.com/philmd/qemu into staging (2025-10-31 10:26:34 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251031
> 
> for you to fetch changes up to 8b733be9f408f9b550fc998c790e32aded5119f1:
> 
>    accel/hvf: Trace prefetch abort (2025-10-31 16:26:46 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   *  hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
>   * docs/system/arm/virt: Document user-creatable SMMUv3
>   * docs/system/security: Restrict "virtualization use case" to specific machines
>   * target/arm: Add assert to arm_to_core_mmu_idx()
>   * hw/arm/virt: remove deprecated virt-4.1 and virt-4.2 machine types
>   * hvf: Refactorings and cleanups


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

