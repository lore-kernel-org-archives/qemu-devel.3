Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188B3C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmmY-0005Mc-HU; Thu, 13 Mar 2025 13:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsmmW-0005MC-Rf
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:55:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsmmV-00051o-8m
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:55:44 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so4474947a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741888541; x=1742493341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BfugPbaC06xWaH8Znui2BkAcvyGP6vY1YlyzBXRpBQU=;
 b=d/+l1FblNcO5UdnN09s4vBWrqhyF2xPNiQCxXYlbhXOOtlXnAgaYmvp3GMBBMokIKl
 3Iit7iS94vFvQEaavIxHX36sUdStGQX7DthoAs6ExAFS6pmUYSmIGGof3VQz5COVxISk
 yKlRq0HBBu7DpmLzLCQ67b0vEGBduukR5sc20k5Qy8RenWTUUMqz3eSAJ36ljsw7lecS
 cdLARHrzOyrzK1geZXwGe/Wl24e8/gCCYHnTKa+VEX0gR8djccH+JA8PcdLMrmvOEzNs
 EHgeKBtqcVruxqJW7UD5VmlqA7i5tQaMwJyiL84qxWWR1hFpK8MsT1GIjkw+iPp9h0wW
 EZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741888541; x=1742493341;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BfugPbaC06xWaH8Znui2BkAcvyGP6vY1YlyzBXRpBQU=;
 b=Qe47d+uQ0SijrPpeNsnji4NX0UWx16wRy8/77ZpJybFsvxMROI7jsAKJ0ttoo0RSby
 nyQXs7S/Q9T6bSdrZP4UDAnK5ZlPcGUkO/BHaaMXkEnhGc+t4N2TMg7zkaa/qqQgIOyu
 ww1fj2+aKq+2vNKVjKof6tqgdCqgb1GjEMv2+NrjWfJvnc4cuAv86aJo66Zb2MzsuvxN
 Gnw6o8pmKzHnAr89+woraq7lKnGDkFLNPUBqFBCZKtmzhM67uCD1q2dpYilHdHdRMK4F
 M7Mz/lbGpfUCs1HCGfPT+++KnZ38MrsZXnUi1ZVi18YoiP7zV8m25QpW59+Bme2bg2s9
 gW5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhXPvifo6T0q0ZldBBChbFrifrkBn4lBc40Gd7hEDRiKUzAaXfDPARyd2JddXSCok4ZC1YfqKRgBaZ@nongnu.org
X-Gm-Message-State: AOJu0YwsuciqoP7m36l2fOLPTbqF0yCvgigeP4SEKoA1WTjOz2X2JtGt
 ol0MFG/527xW8xjAiLpq685ApFRe3K9N5Ge0sKlIpWciZ8Mel62V8QpkuVnNoUGleZfdaW8AGgR
 C
X-Gm-Gg: ASbGnct9wLBgFjIgWKoj8BX2Ol/4IeJ5iHuOacR3JETpH6j2niAxhx43E32cSZeikFX
 QwKMGK4fMmVTmDdEqo/iKsPLLDKYMmzF8wRrqWrdxkfry19TlD3k7hkznJxVKVnONAxcaWVGiSk
 iWEPM1JULAiC8mfTNzkYZ8BYIcVnpkRLJiBC33650ajhlZz04t9cGZqcVV8dZtxE0xTD8BQBYol
 MpfzjIgAwcWih7bg5mQRL3u0GySU6TtFyBtt4w9KLbubY0e0SczMDrZfaq3BxSdfHDi6cFPKuui
 XeQytNq+pec96tgf0dM5MlUPifPFX/AZN3elJaFplY36pi4Ru2fRm2eMUobmgiWY+3LQ0UDRqQJ
 W+MTXdEQ3
X-Google-Smtp-Source: AGHT+IG9je7qLAXXiLwXT7xKjqYC2ZZ/IKSloGD/1QEAA1nvJ/vs6r3wCPXNvayp5xODUE/IfSTLSA==
X-Received: by 2002:a17:90b:5408:b0:2fe:93be:7c9d with SMTP id
 98e67ed59e1d1-30135eb696emr4656448a91.7.1741888541314; 
 Thu, 13 Mar 2025 10:55:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30138f8a1ecsm1816301a91.30.2025.03.13.10.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:55:40 -0700 (PDT)
Message-ID: <b715b613-916f-4a0b-98e2-60b24535c614@linaro.org>
Date: Thu, 13 Mar 2025 10:55:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] include/exec: Inline *_mmuidx_ra memory operations
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-6-richard.henderson@linaro.org>
 <c26694d8-3629-464c-910d-1999e51a1004@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c26694d8-3629-464c-910d-1999e51a1004@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/13/25 10:11, Pierrick Bouvier wrote:
>> -uint64_t cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr,
>> -                              int mmu_idx, uintptr_t ra);
> 
> Not related to the change, but the naming _ra is very confusing, since it means the 
> opposite of what it seems. *NO* requirement alignment, when you expect the opposite.

*_ra stands for "return address".


r~

