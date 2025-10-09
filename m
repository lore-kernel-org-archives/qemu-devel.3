Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EE6CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6u4C-0005I2-0w; Thu, 09 Oct 2025 13:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6u49-0005GK-5q
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:04:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6u44-00081U-K4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:04:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so1113390b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029463; x=1760634263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NOk4G83rA6p/0bnV7+xPoGK6Y5FL79tMXgcdFyUkQd4=;
 b=xwm0aIkEhyX+siZU91O4NUqVABsTPny3zQKMsGz7FNhObG+D/EAeQlDMRraxUe4gWu
 N5gwFYN07xkLbvwwwmCwk84ScHHqiJ1VE0BhJpul1NVcNP+au9ZTk6oKH+B2uYRz+3Oc
 ejBq2mBp3clrFPLQqkAslFRLo8H8OznjXwWbXdHnORHZSNB9n6dz3M5ajIN2X5qlhc8o
 CdoFcUCa+eJCFnVfJb+DavrcdLS9Eo0SLu8leR16hTgJeey3qWVmNXZ9yr5j090o6TUR
 0QbEd3xisLw02R5bpnn6UJ49Cvo1bfe9mMo6T+IRPCxWTV34zPhuJnD6lYgGU121Uew5
 PLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029463; x=1760634263;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NOk4G83rA6p/0bnV7+xPoGK6Y5FL79tMXgcdFyUkQd4=;
 b=dDMsObGI7JFQzt6lUyJKyuEriukRnc7A096uVKzJ7TXEZkujW18Xpr8ro8/uiNctVe
 iNjtNaL8Yy7wMFPeynQtNivPcNfKHkx3OspnFIpq9qYa0XVl/g06825rAU4l4+PWZwlJ
 OnQ6/xtKuU7z9qKadZwMIXKxaazz3o8VF5Ux6aDkQ5EkFEvBY1W/QDY4z10shK/lptt5
 KJbTktyLc04rsXFwlgQ2ryb/zIU5F3aODyiAHAmTOrQOTxLdFlJWSPUFA8hkCsWWmXDH
 6qj6p8siC2TRxb4R7taP8McW9d3mpEbx3kbCA4cp5zApIgGF6YqRNRsYHyNsAXAiiYto
 +tlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLWe6QSkY1vxkA0rc3U9selMyP99THujAABhJQOCfUnPchSVaz5jR94yZuRhHwBFYhQF3LMBde1e4N@nongnu.org
X-Gm-Message-State: AOJu0YzD1Lvj4B5EGlXk0t2kUwbVGowSenNevDar1JF4PeuOFFcD772c
 QJnEcNGiam3Gm13utru2iWv7NoFt0LjrGOU1BwKQnL8XRV0XUdwcVyXjZGMbjM5Kk3A=
X-Gm-Gg: ASbGncsYxb9lZnQnXU3BXyePliznjwM0O2W/t5giVHAmirQ5uP9gGZ9ddi32z7MBlum
 +O2JirnL/fn4dPNgO0w9qt3vSf5DkpcsRovs+l5l0e8Dpo+InIPq/KNDoswt7iDRkabK/8Gi0Mp
 ZucYNPpsrkZ8Z9n07Dkt59zu3+fuErnomKHQPZUc8WuZkcuvt7Mgz1zmN3sHvFx+9X/r0viIN81
 gj/QnWhbsbMyysig2C7vZXn4RzAxF5KZ6mUhyPOB0akwxiXZPVhVz0Rnoa2cuOwD14f578efxOv
 0RujwKtwSYzowoLbUlcMx2+hg2wHcxm8xLrJxmIpr7XN+FTuSVNbCEYOYBwmESjUoRwKNsvW20B
 Wa9uv3UT/kJt9L6msh2U+mhZAp6s0alwPMbjmCmbTX7Y4EycZkEKgj2ToDhAwjW3B
X-Google-Smtp-Source: AGHT+IF5cIP3RdOG1ZYCDwlHU8MGr+aAiPJJub25o3CgYj6Zfn7lwu438Dg3OIjj7zVwflFDC75uQA==
X-Received: by 2002:a17:902:fc4c:b0:28e:a875:f7d1 with SMTP id
 d9443c01a7336-2902729036bmr95426145ad.10.1760029463422; 
 Thu, 09 Oct 2025 10:04:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df4ba7fsm169125a12.32.2025.10.09.10.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:04:23 -0700 (PDT)
Message-ID: <2079231a-e7e9-4b1f-80a6-b60e2431c8e1@linaro.org>
Date: Thu, 9 Oct 2025 10:04:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/hppa: Replace MO_TE -> MO_BE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
> We only build the PA-RISC targets using big endianness order:
> 
>    $ git grep TARGET_BIG_ENDIAN configs/targets/hppa-*
>    configs/targets/hppa-linux-user.mak:5:TARGET_BIG_ENDIAN=y
>    configs/targets/hppa-softmmu.mak:2:TARGET_BIG_ENDIAN=y
> 
> Therefore the MO_TE definition always expands to MO_BE. Use the
> latter to simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 6fec63cb433..c9009441ad0 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -106,7 +106,7 @@ typedef struct DisasContext {
>   
>   static inline MemOp mo_endian(DisasContext *ctx)
>   {
> -    return MO_TE;
> +    return MO_BE;
>   }
>   
>   /* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Indeed.  Like ppc64, hppa always defaults to big-endian and has a PSW bit to enable 
little-endian.  (Which we don't implement, and quite possibly was never implemented in any 
hardware.)


r~

