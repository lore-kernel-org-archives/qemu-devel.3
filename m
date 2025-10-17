Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEE9CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 23:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9uIk-0003du-1A; Fri, 17 Oct 2025 19:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9uIi-0003dc-Ei
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 19:56:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9uIg-0000Fx-IY
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 19:56:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so2261882b3a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 16:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760745356; x=1761350156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HJ112Z/iurXexrQzBPlsWARs2RDVzkngIeWSCqLcO2o=;
 b=dmgKUYzmbl0HQvY0MTuLK8u88+fXTiVc9tKc5gQeqBwQ142eM1fx8ULTwgPd7Mfr51
 CY4YIrhvXOzSw1si3afTjefpvJ804/HSJ695i/yZD1INjn8Ivm2EYXyw95YnwsyPN20s
 3B5VotyGs7KHmzFHin7/ao5+Rl0T3od2bc3MXXBuBY2zSdeL6fzOyTk4XJwabXHmWVM5
 dOumf0fYTnnLi2CIJxseXmrEESCzwYHPO1fYAjvGoVnUhiRS3y2bzII5oqc4fKq4Cedc
 6Kg41DFswQbeAfUWREjO2JplMYpyyX3uwhFUW8mJUzHYD2oJNDFItRgoGgJc1xmJ5vQa
 QuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760745356; x=1761350156;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HJ112Z/iurXexrQzBPlsWARs2RDVzkngIeWSCqLcO2o=;
 b=dMM5yVaSi4oMLw7zQacnGqNS9Oiae2MD/aZJqyMGe02iQjM6c/Lmu5nvF8+/Pmn+Jr
 DVmgtSmXW0Otb9W7QTgOCLmwAzycSRoa5MWHB1lx/lMlgIzWpJp1GQIocZkwss8hadyi
 uz5FI2NEfomLNFvHVMy5IOF7VGsVMwS1nkv8x0ecT/geH+HMN7CjBU0/wCRhkk8gRVvR
 k8mFKWP91/GoCRUhmOvCmmCy8QQ3ssm+wro4zzALr99pGH71nN0Dzi4OPLNGLidEi846
 oYgTzkPt++cMUeptnsdtEOBohGXR9pmHLscn34gr5zumHDDmHtA5b/yHNumiQDhcBRku
 JbyQ==
X-Gm-Message-State: AOJu0Ywy42K0S6/sk3HY/xfqiz95//vIaew7ytcNOBnXRsnyhhlfVPvU
 fnL8/8PIcW19xUPS11Vx5UFdmt5NJynDEavXgThgsLmROAO1Wnb6gUjimHabihqe6tEAKso4RB6
 G6HvizDE=
X-Gm-Gg: ASbGncvarU51Mb5Eo1ExNFO7EtjrOQ4sBcWwkX77XaCGUdCThwNDnsy5kGI8sOaU+eK
 DsDUMwtSFRkD0oQmKG9ZblW+EybBnPbEBMGWEWdLETK07sxwLuzy9IEImgSQnwI0an9TMHbPz3j
 GjrCLSzU4a7FP+4x8HHm8pcOZk6KZ99wJgYE/8BBRVzatPKLHfyiuRDDIy56nsnJ/NtvT+ki8MG
 +bH0vSip83HtFpsXpHICGzqL2jMaaHMRl7SqSVfzHZ/AWQkZmdnFm6cXgyRuxfDqG+wL8z1QuZh
 2IYHIZMDQTIQpbdbWheSTYAzFiOmmDjrV2WDH0RE/ioKj/A5MHs4j9AUEFYEeu5v+ZOOWlvWwwR
 nFbEuYX5eV9246odGBU+ZxzG5Cq+vt52tvfXjqHRNgiAqwDiKRRZ4KtBOTVm+6wMFTQVqGwsDEh
 sHKaIF6oi78xDpO3c5St30GPXX
X-Google-Smtp-Source: AGHT+IEAdf6ewHijFUa7qXNcAHuVfeRvvS4mCELbFzmpktT5sTbrFMPoDYv/glc9IgGagArg/PWCig==
X-Received: by 2002:a05:6a00:188b:b0:781:2757:1b4f with SMTP id
 d2e1a72fcca58-7a2206eb750mr5785949b3a.7.1760745356158; 
 Fri, 17 Oct 2025 16:55:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff5d76bsm818020b3a.33.2025.10.17.16.55.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 16:55:55 -0700 (PDT)
Message-ID: <240a1736-2850-454d-8b7b-4574f5a9576b@linaro.org>
Date: Fri, 17 Oct 2025 16:55:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] gdbstub: Export host_to_gdb_errno File-I/O helper
 function
To: qemu-devel@nongnu.org
References: <20251017211149.163762-1-yodel.eldar@yodel.dev>
 <20251017211149.163762-3-yodel.eldar@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017211149.163762-3-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/17/25 14:11, Yodel Eldar via wrote:
> Move host_to_gdb_errno from target/m68k/m68k-semi.c to
> gdbstub/syscalls.c. Declare it in include/gdbstub/syscalls.h.
> 
> Add both newly added GDB File-I/O supported errno values, EIO and
> ENOSYS, to the mapping.
> 
> Signed-off-by: Yodel Eldar<yodel.eldar@yodel.dev>
> ---
>   gdbstub/syscalls.c         | 36 ++++++++++++++++++++++++++++++++++++
>   include/gdbstub/syscalls.h |  9 +++++++++
>   target/m68k/m68k-semi.c    | 29 -----------------------------
>   3 files changed, 45 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

