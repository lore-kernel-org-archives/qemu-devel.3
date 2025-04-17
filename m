Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13783C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5M69-0004jq-B8; Thu, 17 Apr 2025 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M66-0004jT-TL
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:03:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M65-0002y6-7y
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:03:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so3825595e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744884231; x=1745489031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+9OazFjJ2GwrqSr2NRAO6WfgQ7/F0cQNBFQsAGMnRc=;
 b=z6y5YsZ3Iq+jVXUJw3aiFk2ZRcKncUWFowAc88EX4shncV6tyAJ8f4ABZ6oIjXUl9T
 Pf38pz7FrmZ6caLZF6GZtGb6UgkwPyn9LjzcFYoZGziOk4UBW32NDH4aUFWKokyDRb2r
 KaHvH0voHRCCtXLaImaC1ztLQZn63kFC/Xz9YogwJZ9BwH8ckJDZsc0Wm35r/GssjOy2
 Nn/XSNL1cn/q++XjrZmcqVDsAJjUtYca+l4TpkSPl6Y4FkCr1QusswrMUjFsxrywhzzt
 IJQO7WZCohqX/HRXzW4KqZlLkUhGg9hamI5OEMXE8wlAGPTaOLVi81pwBSwLX1HK33ps
 N5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744884231; x=1745489031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+9OazFjJ2GwrqSr2NRAO6WfgQ7/F0cQNBFQsAGMnRc=;
 b=kgXmnqZorh9RKHrkzUM8X9uYwzpSHSjHLbAg7vA1VWKy0M9VODQcuyiDkOOHA1Slp1
 LxY2+rk94CSJZY46YqrC7EAvLkUIGOBVRjU3AFu7X62U5kll/OGxRLHkm3rMBTydr/5Q
 H66HqVMuopAuX0mIaLM98W2Yoi+k7XzdxiFv1Fq3sMqw18CeyDPjb4kznLwRMP7psKj1
 QWuieYekrVvmNmKOii0STF6AoX+zur6T/2Egp1Uv3f92Umsfyg7aEPccx8wXJ6N+PfbS
 owKvmGCXfeFK9/9kCXb/os5yFU3hGY5lVLeMMo2ZaFv4Vzyng2Wbk23FpVbKb39nmXpf
 6Z4Q==
X-Gm-Message-State: AOJu0Yw35RwcGUpK40waOi7scnTxcOzaiRTN2XAsx2dtNrCl6V5LaOGz
 4mEq2Eq80zRL20TF/0tRcSt50d5CgNYbZnyOWAN70exSIcMWMIXaA5RYGjjV5t8+UrJtywGs8J1
 9
X-Gm-Gg: ASbGncsZ2TFKL0NKBgumIUiDDamfBtndJWB/ScfuPp1UloO3tuJeRYxfb2OKMl99SFT
 TagMVDrO2ua9WMbtHmVb+qNmNDXt2DYXIXKi8/p95EhZk2g4dDRqN0nyWR0L7YiVLedLJUXMtEl
 +R5FSOkQX+N7TBtr467MmTvKZUiQkb3R4kOEDIF/0zWk0Hn2wWhjQOM0dd3djCvjv2q+6IBaL06
 nhhddky17ilZHbk/QYOg5ZjtTNarM0hWRaAGr/eCN103bIr5uyIZ/yCehUSHlzNucc6OkZRLjmF
 YvA+97CS9GthD94j8Fq2A0Lgn8MXTv8UBBI0aMaQjJ+ns7qFysfcNf4YPb1D8Kj824k5toAPgrG
 oc4tCoWk2Jab8TFhoQLM=
X-Google-Smtp-Source: AGHT+IEXa/3nmVDUU8VfYPZPn/F6pNeu5YMsCbtrMTQDudwhURxqIS5+2qjHtAMFFuR069rCTLAKbA==
X-Received: by 2002:a05:600c:8711:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-440634ad300mr19599765e9.4.1744884231168; 
 Thu, 17 Apr 2025 03:03:51 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977a34sm19687248f8f.44.2025.04.17.03.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 03:03:50 -0700 (PDT)
Message-ID: <d8f0f7ab-d67c-4dc6-b135-31b46b89c7d3@linaro.org>
Date: Thu, 17 Apr 2025 12:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] target/loongarch: Code cleanup with function
 loongarch_map_address
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250417035143.268248-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250417035143.268248-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Bibo,

On 17/4/25 05:51, Bibo Mao wrote:
> Get physical address from virtual address is important for qmp command to
> dump memory content. In TCG mode, it searches TLB tables firstly and
> then do page table walker. In KVM mode, there are no TLB tables and page
> table walker is used directly.
> 
> Here TLB tables searching is moved to directory tcg, and code about page
> table walker is put in the common part so that it can be used in KVM mode
> also.

Can you add a cross-loongarch64-kvm-only job in
.gitlab-ci.d/crossbuilds.yml to ensure we cover
this configuration on our CI?

Thanks,

Phil.

