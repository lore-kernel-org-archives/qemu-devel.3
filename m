Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F31CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tvM-0007cB-AB; Thu, 09 Oct 2025 12:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tvG-0007aZ-5K
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:55:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tv1-0006An-IW
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:55:19 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-267facf9b58so7833825ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028899; x=1760633699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FWU/DjIfFPTUo1gApvEVzBkwErgjVTIG2wFt5b87CHc=;
 b=CR5iovY/o3eeL5/FSo+URUS6A9zv0UHdN0vCyviYnfGJLwVM1WwMsiiD1o33KuN1E8
 x6NtYUPTJSTy5rLzVHgUVKUSMdNcI76Md/l7lAn9Vl4QdcgfvSsgDH1u1qEG0h0HTQ8N
 dKFoW6/LI9gTjvouZ/09el9PBoynIGXbjXJC9I55uCUEcMOy0yHgjTcMjk2WpSfsDLb3
 XFqClq/IFmSuCjv7D2MLUXpepxEEn3UaeArd/NGIkOvU2NjdbqlOVRxRIyHelSUb6Btf
 h36HT7YX5fZlT9mwTLpL7XbwRiBrIt0wU7Bnjqygs6n1KsQOlGHVATCoUPb04blJO0FY
 VKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028899; x=1760633699;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FWU/DjIfFPTUo1gApvEVzBkwErgjVTIG2wFt5b87CHc=;
 b=Cj4K+ndoJQV6gmT28DNNtPX6QsvVq81k83gYoadI8T3tG8QuKH+IVkqQxNqr49NTAo
 JBGwhUzkg2lMqfYjHWGYckTbn12w7Hsx1iCA526uH65HNNAyzq8S2uvw+iIVs6O0EdrT
 q3mrxDITrfAjivu1aZuNuMadH1buW8rQOju2b+WwP+kkBKorrEne5ExO2clygYwFQRMN
 j7Bp9OuHsLUcAiy7kCWyx2kYvtX9tXQWtqunzfXmEhnGNMBjqPQK4kiELIvi+lUWPnHi
 VUR7HzbfpxU/QV3GOrESBYJfewOLPTBUiKjGKFjkF66bmfqtabYxyHJTfM3Y61uzBH9/
 mOZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6lejxFZU+hgpKohns2L56eLQZx3hr/Nw1d/Al6hu/8dd8vUKDaE8anZV5QtDdD5P1MuscwiiTP1P6@nongnu.org
X-Gm-Message-State: AOJu0Yy9X+u9eJKqa6RMNpr8Vv3+svzGKRu9lxIgddyBuG14+lwuTnG1
 DTSZhdA421IxLhfWHsCYk7z2AiAK6pQPDouy8x/YkIaEJqUmiUzzUsVJz4ZF673TW7bJaBNT/wA
 MoJLGs+0=
X-Gm-Gg: ASbGnctJAav07+k2yKGqEnC7XnYVyu1WC56veUFdr853ZNARU/A09TbnClR892eJos0
 6wTwpH/csC/v5ma7nqVUR3mkAQ9PY6Aue7mwO0flpm4LXW2DTU6mshBk4NZjslwGF2s//90W1Qk
 /Z2lfB2QkO7lv9YfJFXGWSIFYwkDTZhJRsYtN1/rLktknJ3hPgfO4oxODGp3UBLaMEml8BBaC6L
 jX9k2U4QzynM5tTpyjN827hq7UICZJBQ9MSuf+R9G2OPbrqPKllOxS/A7JK6jkV+cWuReIv9qdD
 4V/tqTKw/NzaIahP2jx8kBoYMwUIANI2lAKsPEgJZ9vx/DngSd8Hbs4CPva5v5tn7iCyTiLwq6o
 Axa3eqlcJ+H8oVngF8/4qAwG8ilmhVETwbj34a/DkpuumS5xA/IaBg2g75zTBM4pq
X-Google-Smtp-Source: AGHT+IEiG4vSI4288VKHA9m5fZzGfNZtKevvopml1JtuldOu4QwEvl1lKCfJiMajWT+evKVVmY9RhA==
X-Received: by 2002:a17:902:c94f:b0:271:479d:3ddc with SMTP id
 d9443c01a7336-290273748efmr107314445ad.15.1760028899202; 
 Thu, 09 Oct 2025 09:54:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f4ae6csm33675075ad.108.2025.10.09.09.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:54:58 -0700 (PDT)
Message-ID: <7a558894-d9aa-40e9-a0ae-7d941b9474b3@linaro.org>
Date: Thu, 9 Oct 2025 09:54:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/hppa: Use hwaddr type for HPPATLBEntry::pa
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
> HPPATLBEntry::@pa is a physical address, use the appropriate type.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/cpu.h        | 2 +-
>   target/hppa/trace-events | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 672ab3750c8..869a75876e2 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -187,7 +187,7 @@ typedef struct HPPATLBEntry {
>           struct HPPATLBEntry *unused_next;
>       };
>   
> -    target_ulong pa;
> +    hwaddr pa;
>   
>       unsigned entry_valid : 1;
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

