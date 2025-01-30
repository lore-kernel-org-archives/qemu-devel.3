Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAA6C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdd3A-0000tR-KP; Thu, 30 Jan 2025 17:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdd36-0000pc-W4
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:30:13 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdd35-0002pI-6C
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:30:12 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so817816f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738276209; x=1738881009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CKEuFidLzY2Y9YChEbBVYYZfHQNghpZNjDmL3Z0hS3w=;
 b=z0YEMsDf81VJBlLGuxqcY7g1Mp0OdkgGlYAn9F8P+Hq4u3gFYTUfE51oKW9Mk6B5+o
 KRLFj+H7jY+XtKhGmt7tPviEnmnEwzncKP5bMSBDX7ZhLdOc50eAc9CElFk7elFy8nNY
 eqeoYpVZwtJTTe2Xz937Ad6y0QahlVOpguEPEADIBcqMkCMyI2v8bcXlI8tfO6twSJVt
 EL6lH9S8OVSivZ3djtY/JWmYqmaE8cEDrx3R7cED5tpw06onPYlAfTlP3MIQz3EJpFdW
 jeIgxZN7lG2m0YXlMoF5jJspXQsqo6EqQMZ+pjDZHIfcRtLIw+PYkxswROmLkXGslST7
 gKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738276209; x=1738881009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CKEuFidLzY2Y9YChEbBVYYZfHQNghpZNjDmL3Z0hS3w=;
 b=ndADl+o5/8qi67gcHMxl8FIEsnCk44TQG02qxwtKa/PeGPYHfxU/2gelBYFMvMm94g
 y7UC4DvMzRzQkckmYDGzesireKD70dcCCaI3og8oFtkCeuRKuR5TddVNGUW5zQ+0IfkW
 VniLIcol5/x6z/PBhKeQNK5OBvfzVhxciIvPG+Rp2gwuPhtYMgM5R9BMSoxlGPB6j3U1
 9yiXFdZ8T0gbDL5vSw0Lss70NBn3KIKOLsycS02pBu9UPGWab8ssZJxUmrydNGMis9gt
 M8ZopSwkcrk9IRUp6GtmHZOx9r7Gwrat+dKa8jSOOJ2DmJAwsMaFwU9WnRabDaNl6WMY
 sHcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJnwXVySTeqqcfw/wB0TFBNGS0m+i0xPCqg+QP4spiq9EqEl7dOCEOzOJEcu4/PB8dXRGI9cAMSOr1@nongnu.org
X-Gm-Message-State: AOJu0YyRZ/uOMko0PlBRhqvIjlpC9nyoogT5qYA6KSUjPoeCRYQ5DRyo
 a866fr8lHeXPZpCo5yBPsSXlrK3O7+dDRoepoCrNQ0z/a2OeeSza/t/AURQs+lUVa4bwGPIzl37
 viKA=
X-Gm-Gg: ASbGncvnhE6uGHcSNBAHR4Vv8HN0W+rQt3J/wA5+7iFTFgf/Ac/4JGXuCnyTHsBGsGR
 BvK0Y7FetysgGeYVXxzKgo3A2DQK5vZL1vs6Im93/F3KnMB2IEwsjREJS0BM1ZjqomUR7OhrLp0
 IK1Q3kYMyMtpsjEwjcekeW/cvggvQJiqMtVC7s/MaBRKEhDXW2lnxNYltzU6jQ7TzIa7baJ5vhO
 YZeLVzcS27fqaXC963zMNZAmxBh+oj0uorbAZEURyakPd7+EKQaiua25vyzIJr1Y/SCqsPZ8hwW
 7q99SBuQeXw3tzgwkLAAglZRen0aanDgp4H4Bkh0KdKPHPI4NOS2H+8myXg=
X-Google-Smtp-Source: AGHT+IEtlfkixjT4jdCSayuWzRQTeaDxbcuvXxpo9avxZF7U878mpmYvoV/nJIelPD3CsI0Y18SSpg==
X-Received: by 2002:a05:6000:188d:b0:38a:4184:1529 with SMTP id
 ffacd0b85a97d-38c5195e5cfmr7096733f8f.12.1738276209086; 
 Thu, 30 Jan 2025 14:30:09 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244f38esm36766315e9.26.2025.01.30.14.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:30:08 -0800 (PST)
Message-ID: <e4a1974a-4966-44d6-b4fc-0d0167b46944@linaro.org>
Date: Thu, 30 Jan 2025 23:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] hw/sd/omap_mmc: Do a minimal conversion to QDev
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 28/1/25 11:45, Peter Maydell wrote:
> Do a minimal conversion of the omap_mmc device model to QDev.
> 
> In this commit we do the bare minimum to produce a working device:
>   * add the SysBusDevice parent_obj and the usual type boilerplate
>   * omap_mmc_init() now returns a DeviceState*
>   * reset is handled by sysbus reset, so the SoC reset function
>     doesn't need to call omap_mmc_reset() any more
>   * code that should obviously be in init/realize is moved there
>     from omap_mmc_init()
> 
> We leave various pieces of cleanup to later commits:
>   * rationalizing 'struct omap_mmc_s *' to 'OMAPMMCState *'
>   * using gpio lines rather than having omap_mmc_init() directly
>     set s->irq, s->dma
>   * switching away from the legacy SD API and instead having
>     the SD card plugged into a bus
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h | 15 ++++----
>   hw/arm/omap1.c        |  1 -
>   hw/sd/omap_mmc.c      | 83 +++++++++++++++++++++++++++++++++++--------
>   3 files changed, 76 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


