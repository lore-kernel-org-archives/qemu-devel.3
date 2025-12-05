Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5300D32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXTV-0004vz-M9; Fri, 05 Dec 2025 10:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRXTJ-0004YA-Od
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:11:51 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRXTI-0001VX-64
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:11:49 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4511f736011so2189954b6e.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764947506; x=1765552306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m23IJjqqMukIBBgSiJZdjQOmsfWT72QFikpiERbNuhE=;
 b=k/ATWOdOgJlVFuJgab8FN7Qs8CG73iNO6RbMccjDALMYUfFJLKAPh4VtQPeugdUC5K
 o36m9LdSMJBkFAzwagALnoFruxtc/DQNAXcHDbFkbLa2qOfmYOYdiqz4EoqdYI9bYI99
 6+7qEYDcazTR0D3tjYowHHxDeROwqTPwb4VW1/kq+ZnXjujZnK2x0qdZ5RwXEG5XAt9H
 KQgFKuPR8bD5/teJHd+t7qMqB1LTjFEkCeK1g+pAxg3WHS3OoLPxkzpw4zbwDU6toKOr
 pwk3PD14ZvMJ1WZyrys0TVerTjir6LPtdGhJkNnaZY5a2j4tWU8NbFg99ou/wYSAo3E4
 Py1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947506; x=1765552306;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m23IJjqqMukIBBgSiJZdjQOmsfWT72QFikpiERbNuhE=;
 b=O1qLJEfYjKFrlB/uadvKWzo4/XpssZWse7td7+vBoiyICOHOKfTEgZkv1LZfPNy3Us
 qk0ePIkK3ict57u9YfLXreE04d6smjbR0SftW14kgy/L+2U5rRPvOZnCUyz5OBX7LrwQ
 9B+1uWMDQpHM94Ko2LDrJ4HEsYwPb8WHNXyMDIsUrhnWSYbnujkybZp2P503s1O9qrvJ
 +2n3vofHrHE8OiQVC2+LoxBXfja2EK6zMempWgmdigmMAUNueSzoQNrCPdYv99iM7WRv
 DAUrifVpfsDozmqiz7S62lmD+X74mZd+alOvJeuMtyJyUQT8RZ5sHaaC1Dvv1yFlbv9M
 hjjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSTV1m8PeH/ir1hnFhlCSz4UblsYDKeBMX3ezFU5gBUkUd/0DrAXFLkW9hNGmKbgi7i1XxYbZG03AS@nongnu.org
X-Gm-Message-State: AOJu0Yxwe8+AiU1eMwZAQ0bL/n63uqM8+6MltleFPe0/n6RIntdKy1D8
 n8nHoEly4EXRYUFqMGoJAWKEYxA1I58Z+C5mhoFyKRM55tlyS+qRe178mDIjUC3G288=
X-Gm-Gg: ASbGnctAfuSfBZDdFejF7MfJo1jSLc01g6v8FrgNeWy1+jhZBNx3mYMBou1QdOH8Pb5
 MrCDyGKsT/n4xjGiBUZNIiAQd15MxT+I9GTWbwyKkrl19f+g1dYFGGTFAv8TnlvlgGcW3Ut8323
 2ls5HomOYaGBHeLCNiO7ZxhvgRqmCg5uM9+e4v2AfROpXfhD0Gxb0e+9JFCuYg5mI/w13gkthNR
 Q8Mng2gHOa4SOy4K6sNVfmmJy4ScOcDAgKVvp4QZAtlRVhP2KNGi4sPZr+WeD2qbAl3IVk7pVhx
 NOUgCb3Nl5hUys3YXTa6DdRdTeLNsgLtQJ1n3K1VHWlk4aYYBXY2SMjkXByELJli2UIVmQpMKQJ
 g53KCwvsfflZ1d6b5wxQHExbxXW0KuZpJkWbXfspUXbKyKVB+k20h0HRpEbM6EpF/z2A+ZcLtx/
 0ML2jNjKATnfJx0K0DFK4YE1ZSyhATV+H40WESsCgU19sgXCo4Ru0gueYl1EohGGNQ
X-Google-Smtp-Source: AGHT+IFuQD+VlFU7dW8yCB6Ih1dPSnZYtwo5O2x+ErBih2+ZUEu51gKIr65nLwUU7gh0QmvMzOVjPQ==
X-Received: by 2002:a05:6808:528e:b0:44d:aa31:d929 with SMTP id
 5614622812f47-45378e937b6mr4280160b6e.20.1764947506441; 
 Fri, 05 Dec 2025 07:11:46 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50a727d7csm3630333fac.0.2025.12.05.07.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 07:11:45 -0800 (PST)
Message-ID: <19527bca-4209-42d2-bedb-18dff9639987@linaro.org>
Date: Fri, 5 Dec 2025 09:11:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/arm: handle unaligned PC during tlb probe
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jessica Clarke <jrtc27@jrtc27.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20251204203540.1381896-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251204203540.1381896-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 12/4/25 14:35, Alex Bennée wrote:
> PC alignment faults have priority over instruction aborts and we have
> code to deal with this in the translation front-ends. However during
> tb_lookup we can see a potentially faulting probe which doesn't get a
> MemOp set. If the page isn't available this results in
> EC_INSNABORT (0x20) instead of EC_PCALIGNMENT (0x22).
> 
> As there is no easy way to set the appropriate MemOp in the
> instruction fetch probe path lets just detect it in
> arm_cpu_tlb_fill_align() ahead of the main alignment check. We also
> teach arm_deliver_fault to deliver the right syndrome for
> MMU_INST_FETCH alignment issues.
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/3233
> Tested-by: Jessica Clarke<jrtc27@jrtc27.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - don't mess with MemOp for alignment check
>    - expand arm_deliver_fault to pick up alignment issues
> v3
>    - update commit message
> ---
>   target/arm/tcg/tlb_helper.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

