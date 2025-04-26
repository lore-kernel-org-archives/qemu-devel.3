Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D388FC369D1
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Apr 2025 08:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8avz-00045m-Mo; Sat, 26 Apr 2025 04:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8avu-00043v-De
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 04:30:49 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8avq-0004L9-No
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 04:30:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so2961063b3a.3
 for <qemu-devel@nongnu.org>; Sat, 26 Apr 2025 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745656241; x=1746261041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pXbbJQSWqPpaCc2U+T+WKRvaPpL1EgR83G6V9j6LHHQ=;
 b=n6Om5nX21Z9ZMF75qgAhPvbDnLJYDSKtyKNfNG8daWU5IgqZSMJtejXtF5CVsxBJYY
 NAneUPGuUjczZ3snG516d0Z/ZpMI6f2p9aQMTW2xLZI7h6l3KpBtv4psrKERYi9uybfe
 rmmiFKSNlNFWDLedYQ1vjGSSoH/GKfS8c9FcmwLVATxcwS5MmpYgeRCz3vv9kMIf/OCF
 NgEqA3iQRTV459zodHAlmXl4+WnVAE1CZnBb54phiJGYOPTklyamqi5TM78DHTF3/+LC
 KjOegpDnJtU8XbeV5xQE/f9ayV2+z1coCOMELM/jHghg5bjBImUNJFnzLssCv6ItmUfw
 WINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745656241; x=1746261041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXbbJQSWqPpaCc2U+T+WKRvaPpL1EgR83G6V9j6LHHQ=;
 b=m67w6mSphjGv0GhWx9g8gfyhWUNXnn/gZ4MfuazVdcFYwxWyCdbHNEEIQ7shtOZ/6f
 kUGfT7PWuCsML1tiLaNVvy30WAjtCF7wLll5uksp0OFchDwNWWT0yQ7O5eun7sDVcd7S
 xXUyH1OlOrtNTdM90zDgoFBcqOA2P4hNjwCH0enOW0nuwK4B2Yl40v0s3/SE0HOy5PrX
 DaJRC+8O2alSrkywBbXgMuDfy7Lsb30SQzXnzJbz7u8KkoV/lvBNT2W8839b2IBtxCLy
 8pEQWzZjQK0mgGFfXvp8hZq7Bwjo8dLc87Esv3WarQfI3HMdGCCa7hSBIk9W4lPVvB9b
 Zqyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdDr22gbJXcBhtssiX60GkrK3fzFwV02dAwKLqTBn5cidXN3N+ImDQ8hFVnUVN7sHpaHtDGdpcRzLW@nongnu.org
X-Gm-Message-State: AOJu0Yz8/TG3tLYH3zgu0WQRO9zPfD4vOLwPhEdydADVBlYdH+9AjBzH
 ZjzbVClIjrJ159h3yPrTGtGtjq9RW5NeIN5mCMons6pkfJZb0GuLTM7kZFYmMQM=
X-Gm-Gg: ASbGncs6ivtwpoV+aMBOM9BfXYnHi/q/OMVt21cBSOAm79DY8Tt6I3HHbzYO69e37Hm
 71P/XbpUqU4J4GS/gaTgfEim49buLLqYudobVXcgGFVuZETHkXmq5LVEjThVNn0dNUQEWNVawSy
 tBI0tO6OtZE+dJwqs/PYJkZ7x3IVhkzFA2K9UJStVDUo+Wor0T7aI5G0hfibL/8JXnPKSBKNujY
 EJGxfOysUGSoqMW+7JzKScSCImtkRAPhpOD7LYVV3R8f1LbPmCVRLsucdSfeIQCBQctjVhoE3iI
 6VRbjaXsMAOEen9cO/KZXP/lajmW+uOGotc5m6J+DbV2YZM+QkTIvqI=
X-Google-Smtp-Source: AGHT+IEdichjp3aJs5LwTnmSDYswayiBj6itqmJs3n1QWQxjZcTSfMCAT5h7eeVanHpycRuz1KuN5w==
X-Received: by 2002:a05:6a21:3296:b0:204:695f:47e1 with SMTP id
 adf61e73a8af0-2046a58d91cmr2699305637.23.1745656241271; 
 Sat, 26 Apr 2025 01:30:41 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9d44esm4534556b3a.148.2025.04.26.01.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Apr 2025 01:30:40 -0700 (PDT)
Message-ID: <d95a3068-7c0a-4190-bc0f-90a82b7e907d@ventanamicro.com>
Date: Sat, 26 Apr 2025 05:30:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH alternate 0/2] target/riscv: Fix write_misa vs aligned
 next_pc
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20250425165055.807801-1-richard.henderson@linaro.org>
 <4cfc3a69-bae7-41ae-9f82-13eee8a8164e@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <4cfc3a69-bae7-41ae-9f82-13eee8a8164e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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



On 4/25/25 7:35 PM, Philippe Mathieu-Daudé wrote:
> On 25/4/25 18:50, Richard Henderson wrote:
>> This is an alternate, but less exact approach.  It assumes that there
>> will never be a 16 or 48-bit csr write instruction.  This feels dirtier,
>> but it's a fair assumption involves much less faff.
> 
> I prefer the other safer version which properly propagate $ra, which
> could be useful for callees.

Both are fine to me. Alistair can pick the one he likes more.



Thanks,

Daniel

