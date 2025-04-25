Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E7FC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RPh-0000Y3-V0; Fri, 25 Apr 2025 18:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RPH-0008UK-EX
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:20:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RPE-00042p-NH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:20:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so2024837f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745619622; x=1746224422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GJKJgio1HwLLCQXI3JKY2Y0Zv7tXIUqEqNO//GML4Hk=;
 b=B4v61FTEBi55jV7DDiYbQWi/0LtNuoO2wEwkJ4FyStqlVTYjNFILIPRX2aFOMURMH2
 V6XBOBxl9deNAyMJxfzHi/4kFtreqGnAlMJsNxhj003f0I95FzPL4YfdsZKLSD/0zKcs
 5kDh5H7arK5cyFtQ7Pf9x4dmWHI7nQM4v/GJTIms/oweeGYQMnKQ16ur6NNaRrJynjzm
 qWZ1f4qkm2HvH1ko1hVzI0OOQI4pmpoQooAMIHS9UO6OqSZEJt/u3rZeO6NiQ7fvj1lz
 +7YM9qxqTfo9FlkHDgDLlA5Ji/pqbdzTW+3XsjU6wrzNIR2ba2U7Hd0SFoIjTnNv3fw1
 jjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745619622; x=1746224422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GJKJgio1HwLLCQXI3JKY2Y0Zv7tXIUqEqNO//GML4Hk=;
 b=aWRrPsb2A5QrMO0z9XJpoKWoJrAcy4gzzoYnwgQnB/F38vCtJPKvMGtExFWuKwYS4M
 GEvj4bYOaaxuFQa8wRG6YLQBycj8ia8qACgYtcSrCMikXiwCxK5i7VrbHEKIMkPO1xjf
 tFuS6B3OPfChVRPGxo2sIZimdJTcvfrR3VEd120Jj9ew2VNGfjE71kTgDLi98W4akecQ
 W8PaTHFzM4fBJ3DpZqGDRN2w0DCM9AijZKtbKC1sUfBP6xhSWJuX5Dkm6p/9h3sYLDCP
 pL2NzpFuLU08UGvRz0w3OaObcICzKWsh5u18hyEtnfQU689GwGQCOGjOAIcCQW0sZQcB
 Ldhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCLV+KodR4imUN+pReSA4sUwacg5XVia7ivtsloFprd2PDgQEmurggv3tbmpAi8uRypOmK4mst9QAW@nongnu.org
X-Gm-Message-State: AOJu0Yx72ahVWoX2S6wGTw++390iAQIYRUKkLOlwp9Swc+usH5XA6r+N
 Mth+4TiuS94fwz5rtXflsDacp+O1qDShuiNUOAg+Zf2rYVhDo9MObCeMjOQUZD8=
X-Gm-Gg: ASbGncvl6IqhbZnWSpTEA8k20GPYuHzW0egv99mNmCVTQYk57HQE8eZEjB5GVKxpdNe
 xX/ezlrf5d1KROUpKE/YeNBtMyHCJCKOByLS6IleYbHXJ/n7gKrk6PV6reWaHmfu02d5syGSdWm
 p2PN8JnlH24y+BQE6UdKDIUsS1aEc1Jgq2rCVFdXkLRndbcsUDDFkZ4hHMbDomKcBB8YUeDW8p4
 fL9UEnpjkWX8RNqLwotO7eT5DogDOJpZpR+M2tKtghE0veCS6nswXPv/0n+AzkHm/bTmp0Sf55E
 SN/bv75WJsOdGMF2yiIBy7ZuXoiIoSxWc+ANN2KwF1hBMym4Nzja57NThUj33vrz2uGv2fRGxen
 oKRMlutnY9QgVXxq77rw=
X-Google-Smtp-Source: AGHT+IELZmxIGqRwg3u3ZxEmyACERLpQX2+YZNa/y2+uvqh9mK0Mb5wnHCQY6eWGYqujRET41XPR7Q==
X-Received: by 2002:a5d:588b:0:b0:39c:1257:dba8 with SMTP id
 ffacd0b85a97d-3a074f8fb48mr3144375f8f.56.1745619621792; 
 Fri, 25 Apr 2025 15:20:21 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e345sm3547236f8f.94.2025.04.25.15.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:20:20 -0700 (PDT)
Message-ID: <aef1ceb9-17c1-4ae6-8f8d-ef0a9d860656@linaro.org>
Date: Sat, 26 Apr 2025 00:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/sparc64: Unexport use_vis3_instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250425200024.853260-1-richard.henderson@linaro.org>
 <20250425200024.853260-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425200024.853260-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 25/4/25 22:00, Richard Henderson wrote:
> This variable is no longer used outside tcg-target.c.inc.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target-has.h | 6 ------
>   tcg/sparc64/tcg-target.c.inc | 6 ++++--
>   2 files changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


