Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BC9C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqB5g-0002n6-2M; Thu, 06 Mar 2025 08:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqB5N-0002mO-Ug
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:16:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqB5I-0002Ww-CG
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:16:23 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39104c1cbbdso348358f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741266977; x=1741871777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hHC3rFMa/39PIvnmBJFZjrc/UseH9CbghIfxWxRt0JI=;
 b=KhiaNcAODRpZj/HLJKQ8Vo50/61Jd8gQD6dht69PIEAFp/TXwJnRRqtqiYD/WkDIF/
 AtRO1440Wab5lDbYtp4CSapIRL/Kl/PrmNzE8hvdD7nyAFSXEEsYHWaeQzthB+cLbWis
 JKWTSAYOZQQidVuBekzdJGBM/Sc0qIBk8Krm3cTsP7RJZ1a3AjblBocJAbrtYlKbKB2m
 BUvddGJsv14DK+OModG2URQ/ZRDyKo0D2IuwbRawdCdvJN9SNqdKOc6L6/DHanHJxyfu
 cEn44tdsIiNHEsxozpPAzDQR3+5CqtWM8dENK7axqmjVY42d4hQRWzQ4z0fJnQpIgNRQ
 7bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741266977; x=1741871777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hHC3rFMa/39PIvnmBJFZjrc/UseH9CbghIfxWxRt0JI=;
 b=Trovh90d0M1jaZznJ60YvqIzy6yp2d8DBCCiTIZVXDG6/NO+zhPCB2yUEsrVm/p6y5
 t/9JsPReqQeHpG1oyxcbAnGVJrd4lTAuoYufJ+uAVET3Aqeej7vzfCQI4U1tOmXrFO8l
 6DvEq5KvvXmlMSp4a7QDsNjSYAR5rD1UgUwdXdYB5elZ9T/o5qxVktbsS34l5lKL+IZf
 XLbAzYLQ2OWSS2+G1BYIc5W3HFPwzlGFNnT+1Wtjcf8KUixPB2kHJJiu0DXJ/8XvmXGO
 4MDA2IOF+/PZdS1ScDKk77FKn/WCbaPUHUtzeuFcZgaxYWoqEobMyBh4o7fJZcydJ1Nc
 D2aw==
X-Gm-Message-State: AOJu0YymvNLAI/a2cSG7L+llQXcH7X+br51Kz6BYPZijgyr891nkLQ15
 lTygnWeN2dKGMiGZgijKkxJc3BDRT3oG95To4IuK6VqIiiaeWhzDAK62yDxJN/ZvDh66i5l/ZNs
 sbaQ=
X-Gm-Gg: ASbGnctC/5gpjLJKmfmXCWViPjKKmkn97bVvhPP0RXKFs+ekXRQuCZcEWFM0kWeUyqq
 pZZHmsfROE2HxcXKtYcJ1br+i5XySRc0Gkgs+tb9sUl1PURQSIqMi9oSV1t83EBVMgYqTT/Yg5+
 Hs94lK9NDQ8pKs3W/VcR2EuHjoi3rRRMDuMYq5uYVL4+la3UHvjRa5JlfM6UY3EnBmiqmuApNq5
 Id9uy0qN57TgBXWTTLiKp30kbcb/JPiZCaEYyuMeNxcImOsyYTo7Eyt0kJKWZseNdDvPAz7WYCb
 NfWkY9DpX0tX7MT9UHwTu8Ph7WOuBzBm/iuNSsdmS9YQcBCmG5LvW3WwbsqFdUJ//uWeEks1nmO
 KPULuGSCUcDI/
X-Google-Smtp-Source: AGHT+IEFKFjyj6T/l59aVF6cAUI1iCSDYTWNxwrwEzhJhxZ724R7xEXkYkteJCScIM3BiXxcowK3kA==
X-Received: by 2002:a5d:6d88:0:b0:391:c78:8895 with SMTP id
 ffacd0b85a97d-3911f7c7347mr6261638f8f.50.1741266977076; 
 Thu, 06 Mar 2025 05:16:17 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01957csm2018603f8f.47.2025.03.06.05.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 05:16:16 -0800 (PST)
Message-ID: <734ad320-5ad8-47c1-a3e2-cc82911f8b2d@linaro.org>
Date: Thu, 6 Mar 2025 14:16:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qom: Constify class_data
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
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

On 10/2/25 14:31, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (11):
>    target/i386: Constify X86CPUModel uses
>    target/sparc: Constify SPARCCPUClass::cpu_def
>    target/xtensa: Finalize config in xtensa_register_core()
>    target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL
>    target/riscv: Convert misa_mxl_max using GLib macros

Queuing cleanup patches 1-5.


