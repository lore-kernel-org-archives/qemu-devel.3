Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1EACD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZryg-0001oE-53; Wed, 17 Jun 2026 11:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZryZ-0001nE-Ct
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:14:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZryX-0000Kl-RN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:14:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8453427d3f4so268234b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781709284; x=1782314084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z4+Qlk5hwUeY1QVjcsd3HUVVSz7zrwKYW2IUR312y90=;
 b=RyhWeK40pmAgbOe8nplaAdezOHqiDULU1Ervkm18O9agKtxgRP73dAdN2gQ1zNlsEL
 b+3YJP0cwRZaKIGRAzv5B34QREAyr+Ho2gwfpjibNb2esbcoEKAg6UPWYGlz4mvJUnIc
 YGMVHUEecHdNSqQ1klSJUmhlzZ3frNCnZ6f+hgoCsbVnfCoOQrEXQ0+JwAp41oWk+iEz
 ftOM120m8HknM009Ctk1anyf3fxTix5LW0yskDf9gfv8rOvbNdlpp4TvY0biqnpDxxlT
 RJ93bw/QRqoCxLYY6pEBW+paGKmPuHyIANmtHure38HmsWw4yTiq9eXaVqTfL7DRJUHJ
 rqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709284; x=1782314084;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z4+Qlk5hwUeY1QVjcsd3HUVVSz7zrwKYW2IUR312y90=;
 b=SCAMca38nn1ZE09xZNgWqPSF0BBbR/8ftbMTrWdYjN+6AXQFqisGoGHGzQ7LMaEC5G
 PUVvqQnUNoG++xYBgA66qsiCnUaDyc8Y36N+OlrIA3ITJsZovDARlFM3EGBjM7SpHQv+
 65lRDtWJm640MzgtI9esHC8GpmquE/71cpZPqxU8qVzCoRWNs6bQYbE9NR5K4ZBrk7h0
 Q2SQATvR8JRqzIiRPpHHVcaf4ZLP+ezg2tGdUElmoErlXaUecftThRyzOgWyNqqRwaRv
 DTUCh2HOa1T7TrAj12UCT4cquoFUhnMsHQYwqZQ5HthsQmRETrethgrZsibXGmWtQUNg
 bCjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/v11nZskt5NT28DulxAXzXW1TIgBtHTNBEaJnCEyfSwpoqHXtb2WcZPRzW2sNk6wQxKHYCqtyC7uyd@nongnu.org
X-Gm-Message-State: AOJu0Yxa863NTorU5us6WM10tigC5hnaP8XuScAhfW683Mc07OhwO9LJ
 JixPV0YvJVIdrLw/s+ma74SQEhVAqS5XXD+yMrCUoWXn3HWWvsInsO7YjlNuaWcNbf8=
X-Gm-Gg: Acq92OF0118UNiVQ5e9Q1bx8JwlxP3SOP/1SVcYc1D+x7+79xNXwcWRUHPRpk/aHFWW
 L3MyCTlN8f7MMzLPOuYNkVB8J7Tes5HDRRc01akaAA9iPELYRT5W2x9Zymd898Ej2rPrcSt2KGC
 isVQP3ol6MdU/gjHUvUiHc2O8qKysWPNyxWabQ5PQW6IHm5JOy+PFOjeBZ3OaIZhelvBr9IgKwF
 P7otWImR0D06N5RERaqYpHpbs3JDw8wsH6FpzyKJIIJ6JMPl3rYLH6QbCrdL15MrWDqyTE7nJPe
 YXUufW2dgZ3yPl9fyFTbcGBdPySQ5xOzLoqJZpEKvBq40/+o5AowJtSq15nqI4KdI7fj8Gr3Oxr
 /LcRLsvqKn5YPRhItaDDQlYJmLVVHIpw4MacHQqo81UKxNEcV4Ic3z1+tP+QKSztcXl7mM+KFAC
 e5p+YfREJvGmnq6d80kBaYff3Z5uQLsl3ht03HPK+hCiGyxpGl0+NNbU3SSA==
X-Received: by 2002:a05:6a00:1da5:b0:83a:ebec:452f with SMTP id
 d2e1a72fcca58-845246b6b72mr4160819b3a.42.1781709283919; 
 Wed, 17 Jun 2026 08:14:43 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b055095sm19752930b3a.57.2026.06.17.08.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 08:14:43 -0700 (PDT)
Message-ID: <753707e7-b9fe-4e58-8227-90a126a6be18@linaro.org>
Date: Wed, 17 Jun 2026 08:14:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] system/memory: Rename cpu_exec_init_all() ->
 machine_memory_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260616153754.93545-1-philmd@oss.qualcomm.com>
 <20260616153754.93545-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616153754.93545-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/16/26 08:37, Philippe Mathieu-Daudé wrote:
> cpu_exec_init_all() is system specific: it initializes globals
> for the memory subsystem. Rename it as machine_memory_init()
> and restrict its declaration to 'system/' namespace.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h | 1 -
>   system/memory-internal.h  | 2 ++
>   system/physmem.c          | 2 +-
>   system/vl.c               | 3 ++-
>   4 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

