Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D2E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 00:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS3Jm-00007v-Bi; Sun, 29 Dec 2024 19:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tS3Jj-00007e-2u
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 19:07:31 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tS3Jh-00049x-GO
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 19:07:30 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so11713797a91.2
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 16:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735517247; x=1736122047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H0TbGEQT/jNkPqJpSu03WbZR6sUxicW+w6nZ3Cqj8K0=;
 b=hM9a6uMDbTD8kq/wjXCtwhVwYqg8yZFpziv1FvlWE4hTduyIv6AYf+w3B27K0/ZDrl
 I7B4U31zR06Zp22AzycPYIYNJOEcnxCflGxB1flcSRvDr/4Fvbtm8hlQL6tHkD3gGL2F
 +YYnktm/etH2FpYhLmqGX+Xg+DJeyvIaRPoz4c2i/OE3cIE3gvrsrbjqErJO8BUn+JVU
 B4MgQK6G6bV7yHP7UpHyxEj6GO0djhBOUHH30SNMRHJdt6/oMqUx1OK5ndoycoNRx7M4
 W908bn3HHni3hN0wllWtLV6T09MUDtTLdrmJrELdQKc9jzHg4LTC1ljUPXdA0nFsEmEh
 MCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735517247; x=1736122047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H0TbGEQT/jNkPqJpSu03WbZR6sUxicW+w6nZ3Cqj8K0=;
 b=SonaWGSw5olH+TV6PM1S/A1otRYqnQy8SPAoub3mRoOAnuCnRtQlqD3ticFSxBMcHj
 AGlkZa+riTJ6xEsNx9bd9fy6t5PQQcCQGzEogGPbX3BKtl3gmF2zHnEgUCspfy5A6Wnq
 1EztL0Nj1k2aYr3lqKbOpUKY7qKVmkQ9LXIEUPaJckKH0UjGKB6jKs8+kpSFNyOxEp0A
 ySq3gATC/XhsEcB8Gkbzn2lMYc3vlCXfcek3VBtSChPeGwMKeHtzFWV/iXzCbH2PwG/U
 zLCL/sn01xqZ/rpLz8HrSIOKEeDcsKPovKLiMQL1ZcGJYGklATKlAxLhw923gbQiPNyf
 glpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFmkca/Kum8M4SC8l3qEyX1z2VTdAXVOXsWCnAJg5U5amLIYsJkmNmcw7lBqeXH1D2YOR67cXz+GXH@nongnu.org
X-Gm-Message-State: AOJu0Ywq9Dj2yoh68yiQrVQZDglVJSXOVEXOWxtkWb2cyw6VywXJlkja
 6uVofoK+tpkaTxUkh0Ito//TmuWnDWHeW/r7OcNEnk/q37We3f9Hv0kiXM8429A=
X-Gm-Gg: ASbGncvZXZWy5zm+grI/AH3cWANHsC35DbjnBTCMz/wp2QhhePDpVY1c7v/N//qszDQ
 Eh42+i3ZJXbTXBSyCN67p5wu2jZWCCbx0ElNTMYfFADenpp27ksQSpgvZfQNxUvUqNJKraCKcYg
 +Y9LktYimWZv4Kj1BQRxQFs9cUf+0T7P5oKWI8Ku6A0d5o07HukuNS2piDj59Q+m78MVXooMGRg
 si6JzEYuJ4NwZcwVORVgFrdp3MBLzdw4QkrDJY1QhqvajuT1sEIGUxLGVBpkQ9uUUUUAXc9WGhF
 j1Bg067Y1QTTeVvqYpxswWEIvVgsknyfK4Veqp8=
X-Google-Smtp-Source: AGHT+IEDRVMg0cZzdQJkO8HU/srubvPTrvZdWXqcQ1n3QiL7bJawzJEJzvIV9vDUP6T0vWR9rjnGCA==
X-Received: by 2002:a17:90b:6cb:b0:2f2:f6e0:3f6a with SMTP id
 98e67ed59e1d1-2f452e1ea53mr48756279a91.14.1735517247048; 
 Sun, 29 Dec 2024 16:07:27 -0800 (PST)
Received: from [192.168.132.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dd77sm23710373a91.33.2024.12.29.16.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2024 16:07:26 -0800 (PST)
Message-ID: <870c5a36-8ac3-4d6b-ae11-568101bdc9dd@linaro.org>
Date: Sun, 29 Dec 2024 16:07:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hppa: Add CPU reset method
To: deller@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20241229234154.32250-1-deller@kernel.org>
 <20241229234154.32250-2-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241229234154.32250-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 12/29/24 15:41, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Add the CPU reset method, which resets all CPU registers and the TLB to
> zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) and
> start execution at address 0xf0000004.
> Although we currently want to zero out all values in the CPUHPPAState
> struct, add the end_reset_fields marker in case the state structs gets
> extended with other variables later on which should not be reset.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> 
> V4:
> - Drop initialization of exception_index in hppa_cpu_initfn()
> 
> V3:
> - Call reset function from hppa_machine_reset() instead
> 
> V2:
> - Add end_reset_fields marker
> - call reset function in hppa_cpu_initfn()
> ---
>   hw/hppa/machine.c |  6 +++---
>   target/hppa/cpu.c | 26 ++++++++++++++++++++++++--
>   target/hppa/cpu.h |  5 +++++
>   3 files changed, 32 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

