Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749D5C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryaDo-0007wI-1v; Sun, 21 Apr 2024 12:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaDm-0007vB-Ih
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:39:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaDk-0000uz-0V
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:39:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f28bb6d747so421932b3a.3
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713717554; x=1714322354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KBIKe8zgLoNCoWSrF2oAO7S40KS5rkTLrzC/jSW5AhA=;
 b=hylT1XZn2561fHs160ZGrRG4BC0GXT2TzYKaVVC4e0IkGAmt1ZpRBlERXRDfrFtKHO
 VJOYc+QeQVwB/paQPkJ691talUJxFDT40luytN/gFGN6XuAGuF0trSnMcMtKeW9QjlX1
 5EeRG4/BN9d1xcyaCJC4Vj8T3bRD0jKh65663dnTiai7awEBQgwhhhOzIa7ehWhfxBZf
 sBdMCHzCgERT4uPbqpgOo3z9AdW0Sh21aLGotrzfh1J8LyI0xLFBEwMSBLOibjn1bd6I
 2lSBll2ifonZroS9e+20EA6nsx10UQf281MzyP9mjthKt9D/5d265uAuSdlPApC36eMu
 sBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713717554; x=1714322354;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KBIKe8zgLoNCoWSrF2oAO7S40KS5rkTLrzC/jSW5AhA=;
 b=h15tnFegwfiWXDsq4Te2PjZsvFWaRbEKQ22oBV7dcVPqez1/Qb8nKr7uWgNkomDa7z
 eUj+FPRadVwCcidhGklY0OhIE42Yq4Bto90oUC+NNiqAMevPWJO9cmUL66IiJkDBUAbz
 XtoCGicgOfJdrdYS6SjqEZ4TJGJGssVvpKEFX5TWz2eJNvHZ4dSWO2JWSPLVyJvbDP5V
 xTMy9OpLfcNSPB/dNa2n8gbNK+cLiX2QX4oOtzXfNJgShR6OB5b5Ebb4EeNv1DCgiGPt
 TDe/m0DKRnj3z+Yv3rYCWccqbqo2oSche7GxaWUyxA4bBksP9AeZxuJyLvrE5eui78Df
 Dipw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsSUasf0lYIlwAmvYxRvs1UgrhC9Kl27aF4bSS/m+Y83paPUOH947apWEsts0tdavWgLtH0olj/HdtpFb7kmX/IJxTerg=
X-Gm-Message-State: AOJu0YxSE8BrPs5RUiP36LYHQXPZ3h3K7a8qR1ivOZOPTIasGTuGIRUC
 9hQ//YPXuRnP1VzD7488zqR24QGDqFHCCau9EnOchyD+sDnZYe0PWI4f6YusMzk=
X-Google-Smtp-Source: AGHT+IGCwGjfAvYRcqjA2Bi2AYbsyA1QQoJSzL60PWGPM8M7/QMuG7JcYk5iQbZ3aKx71eqxHRHL1w==
X-Received: by 2002:a05:6a00:3a1e:b0:6ed:5f66:602 with SMTP id
 fj30-20020a056a003a1e00b006ed5f660602mr8896814pfb.9.1713717554235; 
 Sun, 21 Apr 2024 09:39:14 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a62aa0f000000b006ece85910edsm6342752pff.152.2024.04.21.09.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:39:13 -0700 (PDT)
Message-ID: <6cf18e2b-f914-4ae7-be96-8c9d469c48df@linaro.org>
Date: Sun, 21 Apr 2024 09:39:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/24] exec: Move CPUTLBEntry helpers to cputlb.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> The following CPUTLBEntry helpers are only used in accel/tcg/cputlb.c:
>    - tlb_index()
>    - tlb_entry()
>    - tlb_read_idx()
>    - tlb_addr_write()
> 
> Move them to this file, allowing to remove the huge "cpu.h" header
> inclusion from "exec/cpu_ldst.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h | 55 -----------------------------------------
>   accel/tcg/cputlb.c      | 51 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+), 55 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

