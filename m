Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1415C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLbl-0000El-Sl; Wed, 12 Mar 2025 08:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsLbe-0000E8-M6
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:54:44 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsLbc-0005hs-Vi
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:54:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2255003f4c6so73458525ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741784072; x=1742388872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dngr5MfQtDrFT5NQ0Rk2MEG5fPtbE9yfv/4XBK6maA0=;
 b=f8QGA1ClMzQwlTrUjOMDCpp3P/xZB7M+Vwb4ENFjsOo7rOaZOMXox7WPwo4mPlF2uf
 BmbOXc2SESpegpkEonQFtlAj5nwDeO5NxZ5UvGK8fA53UHijUFAYptmdIrng6KbROTE4
 8lgkhSZ1VAm1kH1mbfMvxDaEA6fsoX+pm8M3eus1xHhctmGu/57V30RhRN/l5Edst1vo
 zCLUffp3sTx92VehojOsmCNLuBSgDBiQQxVmPQgruZHVNNwNogr9SN9AhiOMnh9L5bW9
 FAxEuJa9iW7/CqrjE73E/H4B4+cIkpXAoSga2N1MwNqXbGl17EHdOBZBrvgEIVu6/Gs8
 BKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741784072; x=1742388872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dngr5MfQtDrFT5NQ0Rk2MEG5fPtbE9yfv/4XBK6maA0=;
 b=wtfuk4Bpfzf+lOCUfm5Ov/eYJWYOGg0Ctp4PTHtqbCaOp67QnHWpuhCt19NLtXdtue
 qu3Ksh5tbXuuMJDZe+EWkG0KhsOovmA6LlC2jaY/pavz/4/BDu5TAzjQwVk1fYwKKCN9
 qq6tHcxDE9D54eOLZogJz7jK4BN9WRbDcafGtLLtpGsnBrz2kS0iLxARUV5AoL3mSiCd
 c1h/zmBbtasVgVKucqM+RZEsvDzRKOPyS4cA+G4tSoUwwB+r+xV3IMc7NLGGJyKIAgT+
 l5fpWMcTnaI797hqKJqZStqo0AcCEuQ8oYJU/PFxNmr4kNmxOQZ+TDQT/VHVLB7rfT1t
 zKuA==
X-Gm-Message-State: AOJu0Yyw9v0QDYs5uLZU4R5prqpCSIDUdrHXrnt90CzN4VHlI6u1kT5+
 BfdTJEJVrKWd6Oey8TgFBOdg33tfuwStCtdXMEZ79JUJNlloXHmxSy99sPaG0lnQohW9oT04rkB
 B
X-Gm-Gg: ASbGncshNMjUGEiR6EnkaLXbu8olpRXlc8UdSWmoBu6fI6MEMGpvuMdKbAmOHdxoord
 sZue4X0zPAdhO3YlgxnuXfCH4rO2V9pGvtpVUNisYODkIzVx1Zo4y5aRSiSx6fQviw1MGxun8v2
 yeuRMthOGTh1IUe7s0EE1y94bKS8xbf0Dx+03lg9Vw+i+nIc3qM+znlQyFDsivRNlihEfS1e/CU
 QRVRk1OWMZir5kmnh2XTkEqmW/SFbQzLenPEztMP2BzYwMOIpsXCfhyHyQsjRIri+mKRuz5kztL
 o8Ro7gPDebCX79tm7Pcz5zlpOmwOuVccMdiKyx/lh0osiAfHf8Rn2HiV0J1gies5Ga/KFJORUFY
 STmGGxLij
X-Google-Smtp-Source: AGHT+IGHzs8OUKLE9WsrGOYJgiAQ/7TnE5SMfxWLLVsD07LOyCbu7XkEzx7NBPfZxGVYsGT/cJ/buw==
X-Received: by 2002:a05:6a00:178b:b0:736:3c6a:be02 with SMTP id
 d2e1a72fcca58-736eb7ea255mr9641917b3a.11.1741784071880; 
 Wed, 12 Mar 2025 05:54:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698204fbesm12205083b3a.36.2025.03.12.05.54.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 05:54:31 -0700 (PDT)
Message-ID: <521dd46e-75e5-4548-b073-3585d204e5da@linaro.org>
Date: Wed, 12 Mar 2025 05:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2] hw/arm/armv7m: Expose and access System
 Control Space as little endian
To: qemu-devel@nongnu.org
References: <20250312104821.1012-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250312104821.1012-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/12/25 03:48, Philippe Mathieu-Daudé wrote:
> We only build ARM system emulators using little
> endianness, so the MO_TE definition always expands to
> MO_LE, and DEVICE_TARGET_ENDIAN to DEVICE_LITTLE_ENDIAN.
> 
> Replace the definitions by their expanded value, making
> it closer to the Armv7-M Architecture Reference Manual
> (ARM DDI 0403E) description:
> 
>    The System Control Space (SCS, address range 0xE000E000 to
>    0xE000EFFF) is a memory-mapped 4KB address space that provides
>    32-bit registers for configuration, status reporting and control.
>    All accesses to the SCS are little endian.
> 
> Fixes: d5d680cacc ("memory: Access MemoryRegion with endianness")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/armv7m.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

