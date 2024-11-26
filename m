Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EC7D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw0x-0001ET-KN; Tue, 26 Nov 2024 08:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFw0v-0001EH-6T
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:54:01 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFw0o-0003nF-PO
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:53:57 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-294ec8e1d8aso4445040fac.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629233; x=1733234033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OvM4wkDNDhxZ0WkzhKvMDzSa39Asok8aXVKeTY+fNyM=;
 b=iiM1t0X7tLSnQ4+3SnBUKzTjYdEV6/wq7JwKPl6/czY89+q5fC3HejlgC9g0Iv4bi7
 NRJmzxm30+Nd8h2C+0N1XCDnyoymaid2I0L9X2hZsvfQQ5wtG0TXidraNtIAKRE/ccfV
 MfaimVtQOedy3aOePJzOmuhITsEB/QoHCjDErzgFBzU+fbFOBJ0P9ohP53yLQKzBIFW3
 hYdOTJjuZJ1q3vLowku8f+W+WB1bHbRjniDb5aZQzflImqjgmgDqZ4UIulggXOd9v6SB
 jKYVjWM2ESU17lJIF8c270RgLTxqW20lWzXmA2JD1+41Yb5SHt3pMR+UVjZHewjjrX48
 QSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629233; x=1733234033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OvM4wkDNDhxZ0WkzhKvMDzSa39Asok8aXVKeTY+fNyM=;
 b=PARkhvYVtBOhN6fL5viiEdWrA719uOOJ1+mODUs8OBGzbozjGA0dIdONjHIuVhi1ZI
 rFkXKYS2DnGAXpFlJCSJP8Vo8FhrZ2XfYmCfaXBadCwRyn+NDwkaYAK3YXyr4VRWXlp2
 Ic2MfCpnNcnTC3Jjr3+c6sx9XA5VK59nzAt9QUYuHhVfM1jNjMxTpM1Oy40ajrsbijeJ
 L57tJ0NCOXF1RYpVk7uWs86Ec93ducw4dEMh4IOfckf080XnPbryIrI1mVHM1efJYCoo
 lgpmDnYMfAcbhCCix6W+tnNUVP3VyQCvrFGPFGU6+8kO4ek1BooY34a42MlDDZsfvroY
 FCbg==
X-Gm-Message-State: AOJu0YyjrinxKrk/zkFoJEFSorTXG1WC/YAtqmjZ82T4XquCCuq7jyJ5
 WX4DB/LNIRFygPeaGx78IucgUQCLFSLZkmY+1lnQH65a1QgDiIlTDzETKl20Us0ghJlLDFRqw0C
 u
X-Gm-Gg: ASbGnctcnxBGvO2mR9ArygpuEeel5bXfjmG2v+PtRe5v+r5EUIk9k3RYyMzVViHOEYO
 lUtb6TjkeouPBKaqXMoLzbexgvJY3BIgc24T0Z2CIrxM+VFjyoxkGh0sHfaEbz4evsHmJe06r6F
 u1NeYlIcalYQAwLZoipYJmoxISxEdcQjGUp/LANfGrCEGd6WfHMCXMImE84CVmjmxVeKHtAGDvc
 VcJli3YrxIEB97byVf6icpNEuDeR06gWd2c1X/Ei/mU6SpRODf+ZKcf6lw/6WDxYQ==
X-Google-Smtp-Source: AGHT+IFav0y8YKijeph3kbZBoWhoh7wZx4A8RA3zXZBrRfJ00EMJO8yjDHPYgNe/7MLsPjAgliRaAQ==
X-Received: by 2002:a05:6871:152:b0:270:1fc6:18 with SMTP id
 586e51a60fabf-29720b1abe8mr14044636fac.3.1732629233583; 
 Tue, 26 Nov 2024 05:53:53 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d58c3570csm704530a34.65.2024.11.26.05.53.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:53:53 -0800 (PST)
Message-ID: <6ee789b2-ad7f-47f4-bd22-38204f1cfbf7@linaro.org>
Date: Tue, 26 Nov 2024 07:53:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] target/mips: Introduce gen_load_gpr_i32()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> Similarly to the gen_load_gpr_tl() helper which loads a
> target-wide TCG register from the CPU generic purpose
> registers, add a helper to load 32-bit TCG register.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

