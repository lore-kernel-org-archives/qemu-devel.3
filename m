Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B3FC87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLmw-0003b8-7h; Sat, 02 Aug 2025 19:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLll-00023W-0m
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:06 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLli-0005en-Nz
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:04 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso2744131fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177761; x=1754782561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3OYt7eBlj6TLScUOSH96PIY9qJXoKg6RVtO5072AqU8=;
 b=paTa2Xd7unomAhxKrzPmnt5tXZXOrTJIaoOFvck/PbnFEDYgyZ9IT1DfxWY5SLOfmr
 cfVGG1IPEztw26yrMIN4UlyLKPuZ32ywfMSCUqoV0Te/iJ9kX7fSTocun1uRqfWS+Iof
 9oyS6e9tgIW/WAjmt4NjqaoMciqv+hr1QBLm1CY9wdpk6jRXWdJrgdO3wXNWxS7bS0he
 fREZiGoXZz175xqR9hiqnRS0Tb2KyBVTmJSl+/cohFVp/4OU2pAxaz6bow3PM/8SKQm/
 440aflZ0O7E5hUz6/BvdrOoTCnC3e8RVNBarfjoeHGfIqsnmgNl/N8gpHsB1ZXeh3mJh
 f04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177761; x=1754782561;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3OYt7eBlj6TLScUOSH96PIY9qJXoKg6RVtO5072AqU8=;
 b=vXlSgPB12IrYlz29CkiFyg34bG3g3EwuCTe1155v9pBsXlkv6u1bgsALQ1/BAG71MJ
 P2NE7InlXO6mxNvTwv1nFmuZFVDpx+pcMFAcOImQIFZweIZRWTsPwvXUDAAR6NOwPne0
 UnPaLHMosR3yncE3eTnfyVzs7vjqaRXxsLSBYwqAhNkVEFtmka8Rvi7FkN3T56x2r0w8
 jjfl+2XS/asb9szPto+8kKF5rXOaqrE+6xGTnixoRr78f9PPfhWML5GVtnlHXaFytaBv
 aMNLUjr9J8lO2y1DK9vRe6qDkpZ1UkEUUA8XYcBAK1Zamd1eSaoITDzzfokyUZ9bdOi5
 4bZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUpMFdUugV9HfuEiTQC/JgGGWSiFobQReje8lv67ImO3xA1pwxr4l099D3XhpdTz28WqY9OkI1HXh2@nongnu.org
X-Gm-Message-State: AOJu0YzFbU1Tbqlgev4FoZjM+BkQo6Hf40bBatrpW3ZZVqWdndfGUfz3
 PSj7ZZXTV6Nmq3et6LU6aSx60AvMdcwYNJL2h3KzNnZA+yDaWJJSs42MTEsVmwZ/hFM=
X-Gm-Gg: ASbGncuZN4LE2UFPviTZuJT0Iccrhvaa3MsriK9wMm9ztVcD7hfvwvwTaZrdN7aFUjF
 0FPaNRhgKZ0IQB0xxr6j/328vlgBwkOobiWbuKM59+mc4ABLbKJJOK31FknPNMkym7+Frw6S4mL
 Qi9OqMkNPlE22SEYa8U7fYbagdndxEyUSre58HIW6QPzD8spgHf6t/nBos1QGQ5tv6fitQE+siL
 9PJxXxsRtNePi3RyFiLle5cDAgjI+ZNXfH3Wvz+NGuhcZfiVlZObGac08E4mUXzCyOD7IOEqiSl
 Y/KNlymTIVuBLg6mVjx8Gj9bLvBnsyNgsPCatpTW3ufmCKzMC3vpU6Jc2DjaLrhQkuMq3eV606+
 HapAiZVMZ4I2PALSkZwu8Of2t39Rz/Sisp0gt9JSNt22X0qj/6E2F/x6Tp/NiKlG7
X-Google-Smtp-Source: AGHT+IGQUwudy5SgY6i5USrh60dcm17cESa/gJPtegao9tuuoomqw2SYZdOE6Pdx7rIKZQKKh73HMw==
X-Received: by 2002:a05:6870:c0c2:b0:307:1af1:60a1 with SMTP id
 586e51a60fabf-30b6799392bmr2632095fac.19.1754177761361; 
 Sat, 02 Aug 2025 16:36:01 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a717b99esm1765800fac.10.2025.08.02.16.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 16:36:00 -0700 (PDT)
Message-ID: <f0d2da41-56eb-473c-95b8-061b69b44a47@linaro.org>
Date: Sun, 3 Aug 2025 09:35:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] semihosting/syscall: replace uint64_t with vaddr
 where appropriate
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
 <20250801232609.2744557-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250801232609.2744557-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/2/25 09:26, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   semihosting/syscalls.c | 78 +++++++++++++++++++++---------------------
>   1 file changed, 39 insertions(+), 39 deletions(-)

Ooo ahh.  Later came very soon.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

