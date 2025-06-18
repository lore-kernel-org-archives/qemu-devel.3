Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8EC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 01:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRhvi-0004YV-Rb; Tue, 17 Jun 2025 21:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uRhvg-0004Xt-8J
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 21:49:32 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uRhve-0004Db-L2
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 21:49:31 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so6152136a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 18:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750211368; x=1750816168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SD2yc9qKLTutFsyX3Z0eImcycxX62NNrTkBqJJGc4Hw=;
 b=aGgl0D1yi3kCf8g+0b73tiqt97zDYFOQwcTJL6YYWKBQVqTzYZtqqiEdC1D9Ou4OdX
 mKENRkM6p4a7nRkpi0YBr60C+LG3CYMum8P3MJws/Ww9ykDWulDzVsL0HEmIawHG2cJa
 MQWK2t00w0FzVXLGcNWr0f+UU+VXd1cwuiMNol+MbsgplPEkxXlB+DcOST5S3BVQeGYj
 FqiQigPcBM2g8duyocVz5l6CWMfKy3/41t+VGYoBQqVoTawEU1ga/PO1WCdQOZ5XzIwT
 qY6XruydD3YSxA4i1RlXsCfFnDmyGQ/iKC2AhyUXIm1jO7Q8gD68uBTPOFGaJcloC7FM
 Bq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750211368; x=1750816168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SD2yc9qKLTutFsyX3Z0eImcycxX62NNrTkBqJJGc4Hw=;
 b=o7lXhvx6nWY1G56TPojwM4rg26gjoYTu/mRUAgJuhWf9aPqmw9IimVGbx0xUzhG5gH
 P7PFKyisvMv6BvNbH1Kh66ukofEhgCQ/XbYijMzhHZZOMW9jO5Fdg59AXpd+YZS4pE3v
 QH9gC7jkohGv9wFHjOWPMCCJpwxxnLh0QyHMNmiYhMnMFjPjNDO8YIVGd2tNnquV+Etx
 6CgKHgAE50yvCHD5ls9ElBuDSCJkNXMg528W2bKsyAN2/ujwheCCPDIxfuiaKS2qJln0
 D1JotCeOKCJgS4IQbE+Uj+U2ccxFVvnozi33Tz2fNUki0dEZ9hcBUeBEu4T6W3AJtUzD
 nVVA==
X-Gm-Message-State: AOJu0YyWh35FKpu50zjtRwO8zk7I7RfgNL9PzgMfQZlMiLufRC5Ss+oZ
 APa+gozPjf4JDe4pX0KvGMofHkPz5vGGZbb99tskughniZnzAEg6O9E4jvTFC/Fsaa8B1jivBHP
 wCr9FVpY=
X-Gm-Gg: ASbGncs2t3CljMZol41nJYqfA5ceMXC92PIQZaOEZxNSqBh07IvMC+zS/hP6Av1h+1+
 LIptZigQGJuJzUe421qLOoYB7MI05tKQYmwkvxTz0VvfGQ0r70Q1yC/tC09hs+PkKqvoHFoUPqO
 eS6ZH1KXh2fvQ2+QURJbiLUziSZeC8l9fEIiZeWzlVxBGCDGMQWW9e9VFLroyUFN7PUkEtLXtlp
 6/FIf8cGmScnjYne17mpZgzPuLqqZ0MponMougxJhZT2EakdENb9u6cjhnmtV8IsyHB0WrT8SyF
 rTPV18p4Cm5x+6bcm8/SqBYnD9ouGOCCXLBTHLBOeNM36hgRdI30jImONlFt/37WfEv2wz3HgSL
 4txu2SmDLwm0ZP1fey545rDazOCgr
X-Google-Smtp-Source: AGHT+IHEJj8xpKyLAbzpSh5+VIfmEvpF5kRn9DaKkurPiijp5zYl+zT7NKQRWuqZ7hDRaNWeUsquNg==
X-Received: by 2002:a05:6a21:2d04:b0:215:d14d:6626 with SMTP id
 adf61e73a8af0-21fbd525b89mr21348303637.12.1750211368544; 
 Tue, 17 Jun 2025 18:49:28 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b319dc80726sm5537990a12.68.2025.06.17.18.49.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 18:49:28 -0700 (PDT)
Message-ID: <b8053a21-9c7e-4e45-9b37-5ba74f3802c9@linaro.org>
Date: Tue, 17 Jun 2025 18:49:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Make RETA[AB] UNDEF when pauth is not
 implemented
To: qemu-devel@nongnu.org
References: <20250616171549.59190-1-root@wjsota.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250616171549.59190-1-root@wjsota.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 6/16/25 10:15, Solomon Tan wrote:
> According to the Arm A-profile A64 Instruction Set Architecture,
> RETA[AB] should be decoded as UNDEF if the pauth feature is not
> implemented.
> 
> Fixes: 0ebbe9021254f ("target/arm: Convert BRA[AB]Z, BLR[AB]Z, RETA[AB] to decodetree")
> Signed-off-by: Solomon Tan<root@wjsota.com>
> ---
>   target/arm/tcg/translate-a64.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

