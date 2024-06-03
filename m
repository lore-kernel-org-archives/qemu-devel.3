Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5758C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE79z-0004Er-PI; Mon, 03 Jun 2024 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE79y-0004Dl-7G
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:51:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE79w-00017D-BV
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:51:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35dd0c06577so3086856f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717419090; x=1718023890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/TCi1hXDdr6ML3cgHG8exi4yKjzx8smiXXUITaxURQ=;
 b=IMbqi4R797nt6ZSW620F/eTI0g4uGuq72xK6i7+1RWxJDjrPX56KvlWBjCX2tk5HhW
 qhSelwi/d7/5NK0VLDwSIToAjpm6MXN1eXLR5lm4rM4TrQvmdIxMQ3sCP5pilxbpKWPk
 GdBWCWE0Rilss/fjNSYEaASoIYPpvqYD4om7C0nGXPB+8mEa/SazXbUJ5fEVYJ04DkXm
 ifMCiNtFqFNneghIAMRRPft26Q6sbaY58hukJ7U+iK7s+G2T0M75IMPq73KumTKJlPzS
 XHP0+RYqW19kW57TEgmuOKITU4nWmSaOaU/mQ9osUfFbak0SPTCtin5fy5ApWshRvgiF
 hPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419090; x=1718023890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E/TCi1hXDdr6ML3cgHG8exi4yKjzx8smiXXUITaxURQ=;
 b=Buf6YskW5l9qrwVAoDWAQlfTBd0YjfSK2sPy97t+oDaIeevJocPO5uRj+ZUW+GqKRA
 TL0sD3B9w6uNRf7FCpjOYjkcPZgvS4OBo51GGZx+TrV3Qp5nXCpSYg/JLmaCRF7+xRP5
 pgbvjo9+sxqifg8RRpu30Sk1QLwj1E6fqTkbuNI2s8axkvaTM1F7ro9CU3tZdrvzoeUU
 BMX46/KCNkYnqfQ+eJkS4dea7imO69WpGADKH6wuH3fW7eYoh4IE8uygPPrqtN7xT+nD
 FuI0GrggxUZQCo3BNahBxTLEyQB1rLok+moh3CTERpz7Gjwbr3DtHsuB1SqdnNY+X4MK
 be8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPb0dMmT1WcTybM/GxkGQBPvaQhelufQwFQ+stxxSjOBIFYbN3nwNGiWyjq81J85XmMFM/Wau1fyJceKfp7AJvZnahWMI=
X-Gm-Message-State: AOJu0YzSx3uzG5dDyV9F+jJqK0f+SZoKVis9yzekLneuIGlILyk53V43
 GNBsNEzvU8wJ//zh9Fj/BtFZSbuJTMY99SvHAxgWMK+obijD9N0NCkY6zZlO1+rpYfXYgpr3FjZ
 i
X-Google-Smtp-Source: AGHT+IEHQ5cMQi3xlGzhdThY+nDgnzlQHThme0tuY60BVC4HGo4WThkTYW6gDuZosG7SoEdDNbE/FA==
X-Received: by 2002:a5d:5f8b:0:b0:355:796:15ef with SMTP id
 ffacd0b85a97d-35e0f25e488mr7647387f8f.10.1717419090582; 
 Mon, 03 Jun 2024 05:51:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064affasm8693017f8f.106.2024.06.03.05.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:51:30 -0700 (PDT)
Message-ID: <72f7fe62-5561-4f2f-a23f-f21bd65c0921@linaro.org>
Date: Mon, 3 Jun 2024 14:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/27] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Alistair,

On 3/6/24 13:16, Alistair Francis wrote:
> The following changes since commit 74abb45dac6979e7ff76172b7f0a24e869405184:
> 
>    Merge tag 'pull-target-arm-20240531' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-05-31 11:10:10 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240603
> 
> for you to fetch changes up to 915758c537b5fe09575291f4acd87e2d377a93de:
> 
>    disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs (2024-06-03 11:12:12 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 9.1
> 
> * APLICs add child earlier than realize
> * Fix exposure of Zkr
> * Raise exceptions on wrs.nto
> * Implement SBI debug console (DBCN) calls for KVM
> * Support 64-bit addresses for initrd
> * Change RISCV_EXCP_SEMIHOST exception number to 63
> * Tolerate KVM disable ext errors
> * Set tval in breakpoints
> * Add support for Zve32x extension
> * Add support for Zve64x extension
> * Relax vector register check in RISCV gdbstub
> * Fix the element agnostic Vector function problem
> * Fix Zvkb extension config
> * Implement dynamic establishment of custom decoder
> * Add th.sxstatus CSR emulation
> * Fix Zvfhmin checking for vfwcvt.f.f.v and vfncvt.f.f.w instructions
> * Check single width operator for vector fp widen instructions
> * Check single width operator for vfncvt.rod.f.f.w
> * Remove redudant SEW checking for vector fp narrow/widen instructions
> * Prioritize pmp errors in raise_mmu_exception()
> * Do not set mtval2 for non guest-page faults
> * Remove experimental prefix from "B" extension
> * Fixup CBO extension register calculation
> * Fix the hart bit setting of AIA
> * Fix reg_width in ricsv_gen_dynamic_vector_feature()
> * Decode all of the pmpcfg and pmpaddr CSRs
> 
> ----------------------------------------------------------------

Please have a look at this bugfix:
https://lore.kernel.org/qemu-devel/20240419110514.69697-1-philmd@linaro.org/

