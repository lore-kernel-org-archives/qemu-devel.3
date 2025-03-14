Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F28C282DE
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 00:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tssmm-0006fd-Ec; Thu, 13 Mar 2025 20:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tssmi-0006f8-Qu
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 20:20:21 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tssmf-0005sn-P8
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 20:20:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2241053582dso39272665ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741911616; x=1742516416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ab9WO9Q2CaOz84Rlok9TfoK2wAni5HdHf10j7XiYsY=;
 b=UyIQjou+qxb/P8TZ3Td6c6EoygYTGxl3KQ6e6aKaEX1vC8ETYCIXXnprBrGdselQpT
 Vh5gXIFSvNaANd2/EYiYSyYvjkiZnWGG5GCMheQoPOMrMce7pSEOO+ba7RDv0eGnpKi4
 UwqSA8PnOilzewSp5uxP8F3tU5kukyNzHjahB4BtZCHnSwNZIb+RfbHysgLZMVa4akRb
 65il05q4QSnRWNKONDHBxdtIMdhD6+jdWN7IQaOqZ1e1zL9wpFTYOVEfiVBKfgqYJF8n
 zYdsnEhzMPK2toswFrqG8uVau6zWk5dy18GnJiqSbhkSN9Y6HOayTWf1pjcN5pkRnuTu
 zFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741911616; x=1742516416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ab9WO9Q2CaOz84Rlok9TfoK2wAni5HdHf10j7XiYsY=;
 b=p6aM4ai5sYilK/aYPhRspk4CXIEoo8asq8VWBX3R07PzwlDIQQfvbSM5srTq9vLuz4
 8jefdqAQN4V7HCeXpKBlfkozePf0hf0WzBNkwJftsaynE7581xdpHHvOp32N1z6fP44+
 E1wX0JlBkEEkKyTLlC3GYvXsLHfENqN4MEwA1g1e1D++1KEboKAzv0E5vYTLtKVMtGes
 jZ3E/erGvU//tfXMa/lAi+94+U0QfT0q0GMi1kXHdRE+NJT/hl1HIkNNJrz3Cks+J0C/
 oieEFbOf2DTX6ILHdbg6JM/oW1L2ftE9ccu4DTvT9cPm97p4sOA/8ocjd2zabVeFLWRr
 Sfhg==
X-Gm-Message-State: AOJu0Yx9w4Oj/clnGAgFC+KfoDwrMcia1xCxe8vrIrIWx8TvrxzFb8I9
 azZa7jhd/vAzFfdKfPOjI7Bf7MFIxcrO9dz7ISGdrRphWCw4DQpxm1AgamiQZTE=
X-Gm-Gg: ASbGncsQwQFmCWwpzJai3gCHc7svAmkibJbyF4X488PD4n+MyRkAMWa4Abih1Olif/d
 iIp95Ivn/7hWoFcBPMwDCW3usKrWMgK9SlIxmLPk5SvO3vYU1DzaRJOYCNftH+McewLJoKQ10aO
 IR4MipWiBp2KuNyvI1uzvkDIP4J34NAWgATAcxsQv7Oq9XuUbGQsI3PjnOgWiV01oOp5XRswbkM
 7BSjYukS904Vi91Eaq6r8jwf7HfD1veEzYT0R8s3A5/lYr5orrZ3/8jBwaw1xtMzUBTwzUChNvz
 CLyTzsvQpHHfiO0SguciFeszwR86xmqjWjjPUTcYDl146ey5OotSyQDqz0+LP4uFGBUR5NtwJk+
 ekEki8CNn
X-Google-Smtp-Source: AGHT+IGp62avIjoOmIZiqjVOmBhl8JDVwWIAWsysEnyr1dKg/bwgHFCg9+gGu/xzzmuuPxgd8+S8TA==
X-Received: by 2002:a17:903:11c4:b0:21f:85ee:f2df with SMTP id
 d9443c01a7336-225e0a896a9mr7310955ad.15.1741911615714; 
 Thu, 13 Mar 2025 17:20:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30138b47560sm2030679a91.13.2025.03.13.17.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 17:20:14 -0700 (PDT)
Message-ID: <8018fe1f-d757-4170-9354-6c6813772242@linaro.org>
Date: Thu, 13 Mar 2025 17:20:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/37] include/exec: Inline *_data_ra memory operations
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-7-richard.henderson@linaro.org>
 <87msdo52a5.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87msdo52a5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/13/25 09:22, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> These expand inline to the *_mmuidx_ra api with
>> a lookup of the target's cpu_mmu_index().
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This is where my re-based bisect broke. Fixed by moving cpu.h
> 
> modified   target/ppc/tcg-excp_helper.c
> @@ -19,6 +19,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/log.h"
> +#include "cpu.h"
>   #include "exec/cpu_ldst.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
> @@ -27,7 +28,6 @@
>   #include "helper_regs.h"
>   #include "hw/ppc/ppc.h"
>   #include "internal.h"
> -#include "cpu.h"
>   #include "trace.h"

I shall move up the cpu-mmu-index.h split, so that I can include
it in the proper place here in cpu_ldst.h.


r~


