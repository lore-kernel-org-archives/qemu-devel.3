Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01440CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ubQ-00033L-6C; Thu, 09 Oct 2025 13:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6ubM-000339-Vk
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:38:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6ubI-0004sk-3z
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:38:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso1007096b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031522; x=1760636322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R4HqC0xY2YFn5wJKlagqSl6R0tn6uK5yeAC8Qtq31VA=;
 b=dZ3Mi6+wJjnlFfUzvMLHBLByYsVEOiew7piHigUFA2uyHlWT1/bbGtL+Kyy5IvPWHL
 lzgSImObx4WkPyjj+TkHM9ZTz0r29XT+FulEG4CE8E4n/cnWCsIcXfuoJGKEfI+YDT8y
 6s8wFrDM4sK5vwlljVW6kYaH+pta7rtHoFbxQHaxBMjqTdKo8V+gQPKVhVuWpr0BWpM3
 3UpDS4FYTzR6uSLzS2zvQ7uHCPwDp43Q7vzDrLOTuA0PXEfzEjK0wOWgvxGleEp/eTxP
 UUGm/aAEanP/RDJqkoIpqs/pZetkgjehyEFHY2jy3dzTAewienkZ2Y/1LT6VAyrRjf6h
 bovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031522; x=1760636322;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R4HqC0xY2YFn5wJKlagqSl6R0tn6uK5yeAC8Qtq31VA=;
 b=qBBD0mijsWVyMZVmFsiUUE5CA9JN1JhMrDwxnhOS8RpFPrfED7UyaoYBIPbxZXxIaI
 fqTJR8CyGs+e5XbRzbDpatCwat+9Nf3EbLzEoh9YCl8/zgwMjfkaDsB4httnl8GFehNK
 OtF5mK3yVGPrslC2/PpN3A0W8yF6E36wj2e6dCHC19z6qUOPMoD/YaPzbo68z29Raan5
 lr2O8UaFI60/BczdCQn7VX7tVMQUdUDOvy38b9oqJQyjUdP9QZc47nDilPhXdTWzbzh/
 ZvXy04DCLnnfKlK3nAN8a60xyYkUECbRAghBQfV10SVp6QOkRv0RRJ8lSSDP6V5KPs59
 EzOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU017mLVWy8Bi5/juZYC1RRqyMGFh/TUBtBepabbIgviNRc00MjTpmlBTyB4l555vSGyjSnviomNQlY@nongnu.org
X-Gm-Message-State: AOJu0Yzb4gEHj+YUJgJ7h4ewJnLIoxzJuRLv8NT1wt0VD3jH1bav3KZz
 Q5Amz0wNf1OKHxLpHfKDq0V5P/k8/Y+IGvGR+0mtvN9u9Jd9dc6N1s++yOQl86C7fpA=
X-Gm-Gg: ASbGncuh2RLdiM7GiwlKLBbghsX43wtWn62asYitWVhBRgD+L8encw9MTUEitS9G7RQ
 RQjKu1eDYshIT7B8BK0gZm2qlG3cFBNPZGcMsBowYD5lD3kqndRcR49n/LWfo4qYCTtUtPpB2dQ
 jglPPwSHF80DnBV+H7z11Ysl9bv4gWcH4hFdRjDMsSqLv9EVfOSbOyD5jYl1Q4o5nnUy3E8Sqhj
 bjtdiBvxYUojppJZexS3WqCjN/gM73gZaSQhUCPVuZNazV3uWHF48mC6wJvnrMOCI8pL7Dpp1MD
 ViUnK7pxSkk6ujkcfzAfnzlLHrvZVY0yAqKUm+bcVR0ZQU6J8SPH/Jdy2giyP+lc3pZKabHy+rk
 d1G6i7ozYpBZSaVi43ppQeHlmoLcR4qwCmmB0Xdoc0+S6CaODdPhuaRWOeO86COi5
X-Google-Smtp-Source: AGHT+IH6GV0fupNVGLxh1j3gVcUaZ8rnBPuG+bt23WP5S5lb4V+S5vmZPBq6kqYGcdginayn1Acmvg==
X-Received: by 2002:a05:6a20:6a28:b0:25b:f1b8:b421 with SMTP id
 adf61e73a8af0-32da81f3ad0mr10717146637.27.1760031522467; 
 Thu, 09 Oct 2025 10:38:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d993853sm289926b3a.74.2025.10.09.10.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:38:42 -0700 (PDT)
Message-ID: <b9e34640-43bf-4345-9718-f319ff185c1a@linaro.org>
Date: Thu, 9 Oct 2025 10:38:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: Restrict qemu_ld2 and qemu_st2 opcodes to 32-bit
 hosts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250820134937.45077-1-philmd@linaro.org>
 <226ab909-0482-493f-bacf-5d2930d07ad7@linaro.org>
 <f745f163-6bad-47ad-a1c0-4be96b604266@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <f745f163-6bad-47ad-a1c0-4be96b604266@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 10/9/25 10:23, Philippe Mathieu-Daudé wrote:
> On 21/8/25 22:27, Richard Henderson wrote:
>> On 8/20/25 23:49, Philippe Mathieu-Daudé wrote:
>>> qemu_ld2 and qemu_st2 opcodes are band-aid for 32-bit hosts
>>> and can't be reached on 64-bit ones. See in commit 3bedb9d3e28
>>> ("tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}") and 86fe5c2597c
>>> ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}") their constraint
>>> is C_NotImplemented.
>>
>> Not true: ld2/st2 are also used for 128-bit load store.
>>
>> See: aarch64, x86_64, loongarch64, ppc64, s390x.
> 
> OK. Hmm I guess I need to add a __attribute__((unused)) check like
> you did in commit f408df587a0 ("tcg: Convert brcond2_i32 to
> TCGOutOpBrcond2") to outop_qemu_ld2/st2 then.

Why?  Please expand on the error you're seeing.


r~

