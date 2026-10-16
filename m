Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453AACC6B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 04:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHZFd-0004O9-Ex; Fri, 16 Oct 2026 00:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHZFW-0004Nd-2x
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 00:08:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHZFU-0003Pa-3q
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 00:08:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso8020f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792123729; x=1792728529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8KeO8JEBd/exSJ0KYLxbB77/RVV2kWhOnOQ8IPgKBXo=;
 b=kcU9VzZu65if+MvYsHM/vwtMS7vDkRxI2MBOmsFehfwkjnRkxf4Z9H7xSu42JidtaZ
 SQ28bSBKCpLb+WN14HNWc1NUvGi7XtHVJyZVlJZDly7HEP3y2cQi3fbJHJsqdyJ1Zmta
 phg/XbE6VCWcKCDsrmQm5Lx/AMgUBcKEkrUPfa9uUFt/WeO5LIg+if04sZIe/2Xe376z
 1KJjtAUd+VHQoR+lTqUn4SRL+2DZB0V6WCyNz3kQRsBLDZpnm9vDeXU1ZQq+ZmZ16G1H
 9fzDvrwt6o/NYmihXLgvC8FfmxWxxo/iWL0KcXajF8TE1igISU6v0oNixAm7EdAiWSC/
 fpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792123729; x=1792728529;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8KeO8JEBd/exSJ0KYLxbB77/RVV2kWhOnOQ8IPgKBXo=;
 b=JltRSxH7jIMJTWA4FM6AD1WiWnUR+JYXHV8cZgNaKGGeP345y8F/KNfR2IhvZ2EK6+
 YPUch3ABvnFaObyjeFYynWFhC+5y6DScSlPYR6U+g4fREUSvBuOe/yiNzm8PXBK+vEaD
 8Z4jY1bmbOW5j5OyyBGDGueL8ns9dDMhEvlG6nflIdzyKIMtP8/FGf/pvVXe8uOJhGP7
 mtBNHZEpEPEpUYVp/DJ7cDa+ijZqs0iyO2hnBsnWHfIJB3i/pQpPRZvVHe8ylb6ezzce
 nhSrk9rxaXuppF/wX1VOKejzzzqvHby1N3vDDGliIMan2o49FHyDH0RD1ip9H/kehTec
 nUlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtrk2Tzw5rDtMAbjXRZMwdr4qbM57oKrSXCkVifkLZz3EdPH9E8Ds+57Qk9kEkPzMAWjXoSX83Abrw@nongnu.org
X-Gm-Message-State: AFq9FYISMoFaCZjBwLuJKJUcpLQMtV4G7bGu3PXRbflHnHetvhZpZNTI
 PwCS9XB7Bf8aakTtxR60MZxbyHOYY4ygW52rp+y9RBrhPgawDvtdCclYdHg4ib8PLCs=
X-Gm-Gg: AYBFou0P7P9Jd5gxWZfp6viCOjzzvkw9EDa41Z0BlRIWMz6C3PYBv3WGIm57KwxZVNE
 RveIYIkaFsMLPWg6ZLW1Cw9YJbVnWMat0VDrQsCakyi5BSoJ1ynoW6Mq3vEElpeydldXtFC4W2s
 a3yto9vLS79NQsQVuvtjJrY+hhNV+Rde3gxaZTuY0ykfXv6NAoGqOOW7RflHdQ5Lc/876zZaeIJ
 hOeYWkJJ780hRE7sOVKgk+qVh2iS5j4JVn005skCIiCzGERWg0VHqVeL09MlNBRs+IihUgZE3bt
 EhdBKvn5Twf0wiYfJky5h2uYXwFBqpEEx31ENvEAUQBsx0dLuo0GS0TMwN5/kL9fqZ5olJyohiC
 6mBJxUC47vxpy62npV0uT002b3I9ijMB26OOtchkfhZUw89XxXX3z9MRGz0q89L9+pv4lkQQxse
 KsM9Y4zq6YnuIhSMV7z5ofQ3doeyBnclmAToabfkswa69eJL1AAHqEr0dqzpz1K3Ni5U9qbfUV6
 64AZMJPDrMApSo50st+rJ29c3lV9XGCzBt6iYn5pz1cXccOeedr/HkzuisUd/+CEXStBvndO/oT
 Jp8WMqUquI7S4R8xqzfm/0X76NGK0egtx7pXYgl/YfeC2FRuZg==
X-Received: by 2002:a5d:5d12:0:b0:48d:ff71:dd8e with SMTP id
 ffacd0b85a97d-48dff71e2d8mr899056f8f.3.1792123728945; 
 Thu, 15 Oct 2026 21:08:48 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:2224:251d:1d2:b25d?
 (p200300ca3f0f8b002224251d01d2b25d.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:2224:251d:1d2:b25d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c575esm1982044f8f.10.2026.10.15.21.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 21:08:48 -0700 (PDT)
Message-ID: <4640eccd-d19d-4aca-b5b7-2614963a39fb@linaro.org>
Date: Fri, 16 Oct 2026 06:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/15/26 20:08, Peter Maydell wrote:
> Smaller pullreq this time around; FEAT_IDTE3 plus a scattering
> of bug fixes.
> 
> -- PMM
> 
> The following changes since commit 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269:
> 
>    Merge tag 'pull-aspeed-20261015' ofhttps://github.com/legoater/qemu into staging (2026-10-15 14:58:28 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261015
> 
> for you to fetch changes up to c595a87dc3e318532460c654c36dea08e6ac993a:
> 
>    target/arm/tcg/gicv5-cpuif: Fix typo in ICC_PPI_SPENDR1_EL1 name (2026-10-15 17:38:38 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * fix user-mode emulation of ID_AA64MMFR0_EL1
>   * Fix handling of 52-bit TTBRs
>   * Emulate FEAT_IDTE3
>   * hw/arm/virt: Use TAG_GRANULE when creating tag memory
>   * hw/timer/stm32f2xx_timer: fix periodic mode and CEN handling
>   * hw/misc/stm32_rcc: Mirror clock ready and switch status bits
>   * hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value, not 0
>   * target/arm/tcg/gicv5-cpuif: Fix typo in ICC_PPI_SPENDR1_EL1 name
Applied, thanks.

r~

