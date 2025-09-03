Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4C2CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 16:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utqjr-0004LA-BV; Wed, 03 Sep 2025 12:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1utqjn-0004IR-8z
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 12:53:35 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1utqjl-0007RJ-Dj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 12:53:35 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2445805aa2eso1756515ad.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1756918411; x=1757523211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4cG4f9JgMDGnqH3OmMRaNeWvcJJZQ4otU2Q4xxdEaeY=;
 b=MdvqgDzn6EIhnojsZSgki93tyE8H59lENFAY1H2nY8+qJrdTkwJEtgb0SbLw+gBFi7
 stiUANu0Y0TAcMhucv2EzUmOvCFgryuQRrSduDRoCvD3eMVq9wuI9g2gR8/UAVVN0XjF
 k6oqu71QIP4VVI9SlJ/x/TRWVjL62Lr2nEztPwb82CN0CDKwBrNwbhUPAWeR/mngDjuT
 /JyWnG/EswDT0T0X4uxD2zybfhUfICg6XlaRoiIi06XyjeU74LZmhwENNTz3peWrwId3
 P7ZfQ0G1wzszJLLdQ6KF7WRKPbb5DhLMSrCbrhhNe2DOW232oGELonK+YPs/lH5NQyuU
 0MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756918411; x=1757523211;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4cG4f9JgMDGnqH3OmMRaNeWvcJJZQ4otU2Q4xxdEaeY=;
 b=cX8Hy3Te8kUhMo/HK3hRO81zljZxomZEEOwcYcC+30PXKhLNyPvyr7+1okgaTwp4AH
 up4CSY8XBlPhO9GNFF4w/vhvOly/Ju7zQmiwwEu2Yzx3iILV83Hvr2PrjlmSjGzx1ugQ
 O1d46Aqiuzv/Lbv7KjmdREvBRhG3kgjjEns9vhM8AIUAm4qn+MY8s3Uo3z7J4McgBlwk
 9xWZU/YNIGb/Q1uwhouCGaNPFF2w9v/VZSZmR6u81QwPN5uxPahEIPTQaxDCFhEuwpQz
 /7AtMRe/68uAh5ZpJ5c5bNOxWqPc3Qposx91O+kuvWrmHNZWm/LFnxUt/+L9fIZbB637
 4jTw==
X-Gm-Message-State: AOJu0YwENsPpzLsaKAfgV6GsJFGwYgufUeAiwBMZ62+RJiQMZrJYCc3Q
 fPMjR9Q2lna1WFrleSPJsIWdcFdE0CWgeVLf+EYbhK0+SS4gMt4xkBjJtElAREEyyMDxpcm0Kgu
 qF0GX
X-Gm-Gg: ASbGnct/S3Fk3YlVLU1ovMonc3sbaZkUiNKC2+A3YrU5+jb4sVKBslPHxUl5cjwWOzx
 dSfdVugkZw4DRXHw08SX3V1AnnnfP+HGcOe+GLGy7qOoTIJAJvcjXHfEk6dFDWy2i72O5kS75oX
 iHGy5gPH4xJi2S3AhW5bF1rqhFhhCdxJ1NxEz5w/2cYTEexHVUjfgNL2PehpO8LL9hg8nTriurr
 aImAiEou3YUrJqSwz1zv86WbjH5aLzdarHddWKiFws34PNi8o4ccKNF8h3jsNY0Ae1tEOTlEZbn
 j+84VLVy7QQkPeDGO5goqAubrAKm6s5wRSOzcFVRYZBUBXOXVVXruWOugffkvRO/hZ6M7zRdhQG
 I+LjmBCJo8/LY9tKmkuQh4ZFlTtoDlYK3/0UF
X-Google-Smtp-Source: AGHT+IG7LllPmrR4osGLxY+5SrQesUCxtCydiv2rCTODLd4H1Ny03lo6wedl+ATL+VLUUOd3Aqpwhw==
X-Received: by 2002:a17:903:186:b0:249:1bac:eefb with SMTP id
 d9443c01a7336-24944b1fe75mr194529145ad.54.1756918411239; 
 Wed, 03 Sep 2025 09:53:31 -0700 (PDT)
Received: from [192.168.68.110] ([187.10.187.251])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b1589e480sm51902225ad.130.2025.09.03.09.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 09:53:30 -0700 (PDT)
Message-ID: <e9ff707e-baf1-472b-b762-eae9d958b14a@ventanamicro.com>
Date: Wed, 3 Sep 2025 13:53:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] riscv: add all available CSRs to 'info registers'
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250623172119.997166-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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

Ping

On 6/23/25 2:21 PM, Daniel Henrique Barboza wrote:
> Hi,
> 
> The output of HMP 'info registers', implemented by the cpu_dump_state
> callback, returns way less CSRs than what we have available in the
> default rv64 CPU with default options.
> 
> This series changes the callback to add all available non-vector CSRs
> when issuing 'info registers'. The vector CSRs are being handled by
> another patch [1].
> 
> Patches based on alistair/riscv-to-apply.next.
> 
> [1] https://lore.kernel.org/qemu-riscv/20250623145306.991562-1-dbarboza@ventanamicro.com/
> 
> 
> Daniel Henrique Barboza (3):
>    target/riscv/cpu: add riscv_dump_csr() helper
>    target/riscv/cpu: print all FPU CSRs in riscv_cpu_dump_state()
>    target/riscv: print all available CSRs in riscv_cpu_dump_state()
> 
>   target/riscv/cpu.c | 107 +++++++++++++++++----------------------------
>   target/riscv/cpu.h |   2 +
>   target/riscv/csr.c |  18 ++++++++
>   3 files changed, 61 insertions(+), 66 deletions(-)
> 


