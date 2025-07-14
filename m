Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2118AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKqb-0006zJ-8b; Mon, 14 Jul 2025 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubJSJ-000716-0i
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:42:56 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubJSD-0003DT-6a
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:42:54 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2eacb421554so1660029fac.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752500566; x=1753105366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xBaadnYzOfBJ6cTf5c2NAo95E7nZ9KE3isU/dbqV4dk=;
 b=kWV6XIw6D+aK2VyGpyvUbTenvZmjPnIqhdpZt37+fwvXGvGmkhIeOLiwu+F2QZvF2p
 NysVeQW68KNmb0AncO4Ry/Z5LhA22qKa/LDv0JJ39ssKwgDhBQwsZxOnklBVYJq3d9vQ
 BCKq1EAGXwwk3ByrakbKUQDFZgo4k1Gtlylprk5o67BqXBmHVO86gaqQ+V854CIeXrGb
 oJsZD0Cfu49p11H3HQaXS8SRn1Nbw2oN4DAiz7KWUiTNijqyNUlKqwT8bjZVGIknEbA6
 UJf6Sx/bhekiqYqnIf82VoHtwAvr38NDjoic5AACCOdbkNU3Peh0UVgx8Txn2OmZCsmO
 nGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752500566; x=1753105366;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xBaadnYzOfBJ6cTf5c2NAo95E7nZ9KE3isU/dbqV4dk=;
 b=J8ZZqOcuTprZaP6AEN+fV68Z+Ixj4HcBC8Ih9MIMqpfwlX7QqNJber2yzdptBRrYtG
 e5lgATDHFsnWboEMSIIO50IdgBDhoLmquxf7G8cNKKUVK0PX3Xpawp682grUb/A6cqTw
 2+T8HrONpFjVujqWrrMyBI9usWbtiub1/DfBjJI/3JJ54kQ0IH7goBB0YR6Dio4LY+eX
 sULHGdfo/yY8FwhnA2p0/IrVMM96UTd41Ve9o31UlLYQfcIVIeWuT660wAvvm6FdGtuc
 CAdUqNQQVNi/y7dVlor/J3QINVBJTgN/W+KHioUBsXPJ/znePc6xMoI50rNR07ybzRcW
 CHkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWUNr2Z9xo/pfqbTQeSKXssCj+iHRInH61ZNAHBPmoRH/YogM6uwQSaaS+P4cX6D2z+i3ugexABQNL@nongnu.org
X-Gm-Message-State: AOJu0Yzi8ktEzJfHlwtptr/75XGshbf6pgf7P9wYGEbX/oj5qTtAVYRN
 fuI26lgp8Ppw2eU4EOVlWu4AxO0gWV454GlBkl6fWTpxYjAcSsYF8yDN3vdq9Pt9GUQ=
X-Gm-Gg: ASbGncsM7rqXaIpBrroPJAnIo2dMw9M3WymNCSCRBrDgrEAIZssjmtCQ7rgEUHL9+2Z
 PPTqR38OMA2KHisCrU3/XEqWeAMx/sd9zOGIjBMBZ7JGVlJy9HBcL9glwgnPo2120IgIkGorhZF
 JBUTTDmgBAVpg3VxeG+kYlyn5dGB90oSs90R03uginvl4A82l36dlBI9mm4c8XFHZuQnqwkIOH9
 1d3EQLmJdPJYWn9HNDw9KUorvmwc8HcFQT017SYBfTBj1pROzsgRa7WNx1QHickJ31Ya/epiG7a
 E9LWxa1n+KqzMtS7NBeOxuxmQN/WEWi1JFvr2z90pxFQ/djL3sVGNVnWZJdNXy5cBxu5DHdhUTO
 c2Vbu3ukbpdvgD4AqK3fqtFaDXz8t19vjafNqHr3oUnsh0j1PVVtBiMFCek52rE4GmSsyMkWW73
 fv0O/BwKurZqw=
X-Google-Smtp-Source: AGHT+IGv7rDQ99lcBFL/P0/LzHz5JYgMexrlmLGjR6O8tR87V2maoF111EFOe3v49ufMGhdf3zJEyw==
X-Received: by 2002:a05:6870:3b0e:b0:2d5:b914:fe38 with SMTP id
 586e51a60fabf-2ff26adb16emr8455140fac.37.1752500565616; 
 Mon, 14 Jul 2025 06:42:45 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff11680db6sm1942451fac.25.2025.07.14.06.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 06:42:45 -0700 (PDT)
Message-ID: <e2bf9f69-80bb-42f7-be3f-b51c1d85e244@linaro.org>
Date: Mon, 14 Jul 2025 07:42:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: do not call GETPC() in
 check_ret_from_m_mode()
From: Richard Henderson <richard.henderson@linaro.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
 <22834f14-4fb0-4cf1-94a4-0c53ab094765@linaro.org>
Content-Language: en-US
In-Reply-To: <22834f14-4fb0-4cf1-94a4-0c53ab094765@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 7/14/25 07:40, Richard Henderson wrote:
> On 7/14/25 07:37, Daniel Henrique Barboza wrote:
>> GETPC() should always be called from the top level helper, e.g. the
>> first helper that is called by the translation code. We stopped doing
>> that in commit 3157a553ec, and then we introduced problems when
>> unwinding the exceptions being thrown by helper_mret(), as reported by
>> [1].
>>
>> Call GETPC() at the top level helper and pass the value along.
>>
>> [1]https://gitlab.com/qemu-project/qemu/-/issues/3020
>>
>> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
>> Fixes: 3157a553ec ("target/riscv: Add Smrnmi mnret instruction")
>> Closes:https://gitlab.com/qemu-project/qemu/-/issues/3020
>> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/op_helper.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Cc: qemu-stable@nongnu.org


r~

