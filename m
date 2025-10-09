Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2CFCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yWz-0003zQ-5G; Thu, 09 Oct 2025 17:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yWw-0003zE-NR
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:50:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yWu-000136-My
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:50:34 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7930132f59aso2041030b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760046630; x=1760651430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=indt9iIpGX6J59pJb4jLa2MG3sFqHzJUKXiZlOomYUk=;
 b=gzcafW+OwsvJfzht8txrldIBJuuufcAgmSB5UNeJeJHf8ny2YSehQN+oqXraDk7rLM
 vRuAJkocACFD9IK1NVFJ53tFVih4DJi+8pJ0PYkQDkpKp2sDBdAP1f8PFhmqiEEkGyn4
 g0tlwOQ1mdJ4vMu0qGEahds1Lh8aQ/BppsLBn2KzXY9YonJal4fgHeu+mY+bmuhl73S1
 2FEy5+LvhELuNiI4q36s6xDo0uGnKJz4xVkZf4ZRW1RuPnEaNSwexPgYa/Cihn/6xu8t
 vwh6+g3UzZwKprwroeIbJJaIZ0aaFw9paOBl96eQuVgeRyIb97kGeztQgxAvx/pIIdSG
 eSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760046630; x=1760651430;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=indt9iIpGX6J59pJb4jLa2MG3sFqHzJUKXiZlOomYUk=;
 b=bbkiMKyYS90JwZftKSlJKRJGHJsQuHRCjfahU/x2JSYpNzxsl/EcUPN6OSzUsiw6cj
 3XvAS9LhBaBBNwTTze8Z3+TJWoJxNbbxXh2/56DF1Ym3PIVjlCC/hCxl2/EZs+b4m2bY
 fl446pAKp/eNrXSrBH8AaKQXc5d/tXOLqgDR5daE2knRgC1y/z4L0CYEwD8Sfz3Dc2Lf
 VQRZyyAxaht1AIic4VNizgRfwqkyHwR+YPGEJapfguqjI2kCHQD+Y+nk1cG67DlCo3zr
 m6sb5jx44DUyKHyuf6A/bZxynEuz6YryZG1l3FDwetaf6/GfcQPAL3vQ2NytxrAuXcVf
 ieLg==
X-Gm-Message-State: AOJu0YyV1rV2se5rxsZWdWrlEkXdJpddHb0oMQt4D9UKdgY5hq9B1/JV
 1bbw/4DctfZGcaxkaYx3LKwyi4OTTtO/3qKMMPOVN+jwWpmOXK5yWhAEzZtm3jucqc7AE29yIEx
 k0YUGJxg=
X-Gm-Gg: ASbGncv8lA2mBYUnnrk0lOp5f1IDWpLwWuWFDxZqqbBzvPsP0zGzFFCCL7U1kABmf2G
 HNwAgKPi1O/nnCDWHEOSEXWrLgA7Cwe6o/61F+xNgSUU12wrxUGcXCCj4VWAVojEC/a3DvzMWuM
 ygbloVnm2Ogb522MIlbVLDvRK1RhhmNn5/Rj61KgT1LDe/m4J40obXqhkd1xcXQSa6cPODdiofj
 QwOtvyrtB+lm9xW0ugejx0TyorgxSf9OvY+AKPO1c5qycDfM8HzOvYU30pYUauNAzCpuHyw4I6j
 l9wR3Nl3lUP/cn/8Esaf9uDzoMHLQyUekRFm57vXHO7FbAj2w65DW4lS9BOEpxR5gogaR7tl0rE
 k8INev1dnlFsU59ddI5Ve3X4vvCWvwxE6KaEO9Hap5L+QgTrHHgZptHYOoSlaxTWc
X-Google-Smtp-Source: AGHT+IEH++fU+J0YX0RqWxWo6gd5ruOSu+CunZ0dLLPNUEx+5Qfz2O0LOZXcChfWdbsUdATsk3sp9A==
X-Received: by 2002:a05:6a00:891:b0:77e:cac4:446e with SMTP id
 d2e1a72fcca58-79387e0539cmr10388289b3a.31.1760046630530; 
 Thu, 09 Oct 2025 14:50:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b060a38sm776735b3a.5.2025.10.09.14.50.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 14:50:30 -0700 (PDT)
Message-ID: <c11b76b6-3e58-44d3-83a0-c5bbcdd6394b@linaro.org>
Date: Thu, 9 Oct 2025 14:50:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/loongarch: Do not use target_ulong type for
 LDDIR level
To: qemu-devel@nongnu.org
References: <20251009201947.34643-1-philmd@linaro.org>
 <20251009201947.34643-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009201947.34643-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/9/25 13:19, Philippe Mathieu-Daudé wrote:
> The LDDIR level page table is a 5-bit immediate. Using the
> uint32_t type for it is sufficient. Avoid the target_ulong type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/cpu-mmu.h                             | 2 +-
>   target/loongarch/tcg/helper.h                          | 2 +-
>   target/loongarch/cpu_helper.c                          | 2 +-
>   target/loongarch/tcg/tlb_helper.c                      | 4 ++--
>   target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
>   5 files changed, 6 insertions(+), 6 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

