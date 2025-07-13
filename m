Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E7EC83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 16:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uazYa-0006ED-G8; Sun, 13 Jul 2025 12:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uazYZ-0006Dc-3B
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 12:28:03 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uazYX-0001Pd-Cn
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 12:28:02 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6138aedd718so1675090eaf.0
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752424079; x=1753028879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jbx24NSWzXacGSJ303R1WrqUJsiDF52LqLTJiQV5sX8=;
 b=UTTKKsJwzvxrjkhYVOxQ/ztTzklVKlI7ZACcKCDpLX5QruEeZtiKotGvH+vY5Mlr8s
 GT7tbavi4yvQaaRrDUgYngBVPHGwDx/a1tGOcgwDcTBJ3DLR0Y/rUTOGNoqkYdRMaORm
 CQ1wb6C3hzzxO9V8ezIlZUeWmY9xbIaWm201h4z4txbdKnDRPtiJ8RcfAnQIlBKHKJOx
 4Ni38LzqIW2a1Jhh9rPZGSSbBtNMlzMCNk9OI34BHEtoHDfbf+29HoEtAQVp2UFhs605
 ZIQb+CA+99l/JCDV2ouP71qXzeylzCSivZ4o+v1p6D56N9yGg+0JNhi7ZfuYEV8tMaVZ
 RS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752424079; x=1753028879;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbx24NSWzXacGSJ303R1WrqUJsiDF52LqLTJiQV5sX8=;
 b=V8y1NU+GAPTrM8ZPlg0abwgRBiziIyNE3PajlbF9AlLWJRIACSawW8fElkkZDq/vna
 yRUJcj6h3fYxhNXyuW/YV3FxrjBhh6L/4seO3C46hMGWeZUILnhEJD/5slJK2qSdvpoM
 mkTtlaZc9r9vhFTK23b33QxvbhqTYEI4C6usGJmM/FqYcRtJwiqT0XQFCdqxtjGKnfCX
 HjRLGxBaVmEGXR1HWP8Qx+0QxAgE5xHwL8y/QxMpAUbmCcPgYhW45sGJwNnzs1FX/TJ/
 OTFiEIrqxuxN0jLRsmRdasayJD3miLYSsCtOCfPETs74EGQadEq3HPmsgGPokprKVmcE
 r5/A==
X-Gm-Message-State: AOJu0YwNYfzaE5yYhuzng1Miuikemsbmogs80v3KCDIN5IKv/fJzaPBt
 iTXBkmAJXX33Q5Q7gejrpW6SFBfNicESJbozYuehqd+Q6Mnz/TdHi3lArbDPZACYukI=
X-Gm-Gg: ASbGncvQMi6s5F+pZG64ReaTw7Ksec0ytRvCQGedt38cfbR4x9ghCU0F1C7AaE2WjsM
 ULXZbRsLpXuFQzyhLUBY3K2OKJm1fLsaHnBqCL4+oUToTBQRqe/I8fxV3bQd5VJwWp0r8vpVOJ6
 1mU4thWIxmMH8/qeuueJADDzB4A9wdxF+VO2ddI6gbxW7tvgEVYJBU9ZtMmkhoVA8znA4C5Nehq
 wosYvSjBb4DVyjRLNoOb/SxfHLCH4Rvc/p2BadA41z35nYA+YQR7RFQPG/Z5JAGQKr+UPVg60g6
 09nhDkXVEC6Ex9jWHvapCzSy6TWsShhgJmtYwV37RE/Q0j2YVYrGHxoNgbTWs7HSP5rvSMDb65A
 BPRBSzy62CzsUbuZVzahdHAEuF8CebKKy0oRXcQI=
X-Google-Smtp-Source: AGHT+IFfYDo1ILx9PrCmX5r9AgdTUF4yldNe4yC3rCji1dM3dGZj3ZKEy3rRQKrmmzd0so9uZhV/tw==
X-Received: by 2002:a4a:ee87:0:b0:611:3e54:8d0a with SMTP id
 006d021491bc7-613e5875d4cmr7337534eaf.1.1752424079576; 
 Sun, 13 Jul 2025 09:27:59 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12a4c21sm1273777a34.46.2025.07.13.09.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Jul 2025 09:27:58 -0700 (PDT)
Message-ID: <268ae2cf-503f-4a51-b644-d227417fedb2@linaro.org>
Date: Sun, 13 Jul 2025 10:27:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] target/arm: Add FEAT_SCTLR2
From: Richard Henderson <richard.henderson@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
 <20250711140828.1714666-4-gustavo.romero@linaro.org>
 <09497926-db8a-4475-b361-7e8338597326@linaro.org>
Content-Language: en-US
Cc: qemu-devel <qemu-devel@nongnu.org>
In-Reply-To: <09497926-db8a-4475-b361-7e8338597326@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

On 7/11/25 23:02, Richard Henderson wrote:
> On 7/11/25 08:08, Gustavo Romero wrote:
>> Add FEAT_SCTLR2, which introduces the SCTLR2_EL1, SCTLR2_EL2, and
>> SCTLR2_EL3 registers. These registers are extensions of the SCTLR_ELx
>> ones.
>>
>> Because the bits in these registers depend on other CPU features, and
>> only FEAT_MEC is supported at the moment, this commit only implements
>> the EMEC bits in CTLR2_EL2 and SCTLR2_EL3.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   docs/system/arm/emulation.rst |  1 +
>>   target/arm/cpu-features.h     |  5 +++
>>   target/arm/cpu.c              |  3 ++
>>   target/arm/cpu.h              | 15 +++++++
>>   target/arm/helper.c           | 80 +++++++++++++++++++++++++++++++++++
>>   target/arm/internals.h        |  1 +
>>   target/arm/tcg/cpu64.c        |  5 ++-
>>   7 files changed, 109 insertions(+), 1 deletion(-)
> 
> Bisect points to this patch as breaking
> 
> 45/60 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_rme_sbsaref 
>         TIMEOUT        1200.01s   killed by signal 15 SIGTERM
> 46/60 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_rme_virt 
>         TIMEOUT        1200.02s   killed by signal 15 SIGTERM
> 
> Try make check-functional-aarch64.

This is caused by the realm os being new enough to try to access SCTLR2, but the op-tee 
firmware is not new enough to enable access to SCTLR2.  So Realm EL2 unexpectedly but 
correctly traps to EL3, and the whole stack gets wedged:

2025-07-13 10:16:12,680: SMC_RMI_REALM_ACTIVATE
2025-07-13 10:16:12,680: 10045c6c000 > RMI_SUCCESS
2025-07-13 10:16:12,689: Unexpected exception on CPU #0:

Pierrick, I believe you built the rme test images.  Is there perhaps a newer version of 
the firmware that supports (at least) SCTLR2 and TCR2?


r~

