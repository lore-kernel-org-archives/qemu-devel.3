Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1AFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yTt-0005cK-Pe; Wed, 01 Oct 2025 11:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yTd-0005Gc-MT
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:10:52 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3ySJ-00019F-AG
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:10:42 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b556284db11so7058304a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331356; x=1759936156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2BgWijj4yc0Wl5GOcnIluvnyIQ9jJr2ffo2g0g4m7x4=;
 b=MLHo3v204kM/wk3mnRlrlEXDgGeu4LD5ETcSsNv0D5fn1HAPmp4zo2LzW2ebpMoJaJ
 ElpR4tjcFHHs4vPn0Fru4slQxsXjrlYJeTJVglg/LEVes9DT0y/IH7ZoOT5zTP0Il3Fr
 kYluUHiACgo2nkOXc1luWYOVP71x1sYPZoUHCEnSe635vHoqk6vOIrUxi+5lZgh1UAM8
 fFXX31nIZBln/+9zFXGbIdYw3ouUAcBLBZz9/QYSA5R5dKI705kRWwEjqYTm18I6xpat
 Ql6pNgf3EsiBTAgrQf5AbLyuNMPo8C3HKvueCNhfYpghdJUydTpya3+iA/04UiBMXrpm
 ivFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331356; x=1759936156;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2BgWijj4yc0Wl5GOcnIluvnyIQ9jJr2ffo2g0g4m7x4=;
 b=jcIoWY00zLy17dxuGHxjZajGzrdMnhHwWXW/SoWIQrh9RAhfeyuDFQgpgQc1vafCk0
 F32nvFz/Fu8KUlpHY9Je7IkRQVJ22VsgkWp/9SSAPuN9euOxmwsl6K3ljamo3G3V7ceA
 aQAev/X4oithbgfQObVQr9byyLGtF0mXumHbtf3K/6Xz14N+o8s0vv+ROhshCP/2sck0
 zdRFrbQjpa+W6wx9eVcca8G5Y5hNLW8iYBZDS/v5tlbPrsPkJ1LYwM1JzellQm7QHQF8
 lA+YVcxtX6Db4bnaFsI3Etf3IK/VQyR1t20w0LCRceYKdF2TD+SOQUXKuH2iYtK25eYD
 L+Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViPD9Dmi04MFOzMDKKW2xXXaJRJWcdvuP9BX3ThpY5oLhxdCF0aifNvc71ye+NZbsuCdRiOVIJxmut@nongnu.org
X-Gm-Message-State: AOJu0YzhQpsxA7CxSzZ5CYk2xJAI/c3r2SGRU281gOf/orwao5Tvq05y
 M+hRrzWkWhFAFL5JH4Z/3HNj60/psblkLTDL6fLE40flU7zBTXoK2RFIGrwqkA7lEcRUhJMHmCg
 nsDzw
X-Gm-Gg: ASbGncsmyZHgBWPZMMi+F1L/OsPpyj2oisVKG1JxNLTzwmMUFWr1K+q1gdoWF4hLXOk
 HFwbNrcoS4aYX4Q/YyAvXtqyHpciNj9UXPg1Ag5RvU+78ZsM8XxPcrywLcsBusGrC+b5AIk6LiZ
 2SLZ/k8rt37W55LDxcYXs18qYdVw/kaiuNXuMRlHr755TsnQ+79kh4Rp5xjr+i9kL+oVcwt9Ct7
 5O7QLRvy3uQw46QIkVMP5p3Zyo2ibBGmKWLy7JN/vKbPnsuw26CMX7Le8W4z2ecDLjnmGNyA6Rx
 FK+b3np66K4tFKlz9OHjz84hz7mRn5pyajGjhKINAYF9+46wFiq4Qp3H4Z2YuamTcNFygs72yrh
 crPZHIbkW/mASvof7xuW7KmKGRymtc6aPLvkFYLfki1jC50353oWLdAS2VBL5IoCqTA7jOZR79M
 X8EYC6rsxk1/dqgL01gf/IidhSpPDtGYc=
X-Google-Smtp-Source: AGHT+IFf0k9wAtduUaabDT20luewEKEXe126A2Sx5h1KDoBwN4q2LRNK9WRju2/5AkMLkem/+/cucQ==
X-Received: by 2002:a17:902:f64b:b0:27e:ed0d:f4ef with SMTP id
 d9443c01a7336-28e7f2fef13mr41884545ad.41.1759331356448; 
 Wed, 01 Oct 2025 08:09:16 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53b9ce9sm16191006a12.1.2025.10.01.08.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:09:15 -0700 (PDT)
Message-ID: <e0e18ac5-3fba-4f92-8b08-d50ad5111bfa@linaro.org>
Date: Wed, 1 Oct 2025 08:09:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/25] system/physmem: Un-inline
 cpu_physical_memory_is_clean()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Avoid maintaining large functions in header, rely on the
> linker to optimize at linking time.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 9 +--------
>   system/physmem.c          | 9 +++++++++
>   2 files changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

