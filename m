Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2272C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uharT-00068A-BE; Thu, 31 Jul 2025 17:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaU1-0004xo-J7
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:06:37 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaU0-0004Ib-13
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:06:37 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b3be5c0eb99so819864a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753995994; x=1754600794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XuAq1KTK/G4AkOm78fXnI9JtAWLzT47y9hX7qWh0Lb0=;
 b=qAWO/0JSn4btH6xOFPEiiKH8j8sW57jilJKAmoJoFDHoeG2LV8dsur7ra8fVvAgYOR
 XbTD0LwBDQQN/ezNzHkR5M7PPMX7m93e5PqjD2IPa9I1CdY2be4P5pPSBVaU9vYIrmdn
 HVais9RcoROTftuUfInZFZiQnWoj9am6UV90FRg+YqW29VczriR3B1/Ey/4ZQvllfyHe
 gzgyh6a0RHXW7NYB5NeZ/1XYMtDiQWpT2jpVA5ryvSgFaqemXSzkm5oS5qRNL2Zz3VEU
 9gVwq2RCSKNqvjTLzsiRdW51WkRscukGxlhQ0gB80CqoCB/QI4fmzLuoPGABL+QNDr63
 XneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753995994; x=1754600794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XuAq1KTK/G4AkOm78fXnI9JtAWLzT47y9hX7qWh0Lb0=;
 b=Sg1b1+1h2rpK9lKYVTci5VHX2yQCX6ncfYcfRMVwUMOFEXrMx/gr9l1AdX4ZZCjNH6
 i40YupNPxs/0TNeNyESkuueJVeJMbAS4lQGsQ8zBQPmodxBrFDyWkaLbhCUmaTOwGyM7
 bT8/gVZKNmJEbvgJJV6re8hRCFuVzhrDDez4A1LVv1aA+oD9pXTjptOhnoxgrfPHJ5pQ
 p+V2utkDONhEStAgE2ARn+QdUQfd7W+NKN2oJdE8AHYxxPU++2HDGnu0vWGLvmNcsWDA
 dyuhgwks053fSb9gioYFZZ/cYcb8JWXpESTy7prRxqtypbXuEseWXc+YKlOZAl2vVeqi
 F0Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS4NOPP/ZEVxErI11X2fxkCZXHd0W8gQNXDzHm5Qt6sSWvfAVGqBfWHZUMxp4dl+XpXlg1H3yMzK/M@nongnu.org
X-Gm-Message-State: AOJu0Yzb9ZGR8ESvjR2XaYh49hdhcy0f+BTUk5Dnte7OwzzGXfjiIybq
 X0wdDpRwI49gNs78nDdDUuSE/KN0vWW+lkrXuu5Jto1PjV8gG0HRklia3ECBYiQl/RlFcxFC4CO
 ZWbk8
X-Gm-Gg: ASbGncvjZFSUrlsED6EjZZ3c7qNeCMrOFyh4A/lEztrDuRcmzToE6/xyXOS+/5SYntG
 28woHx7DH//5Z0Pzoq3ZXFppi5Y0sAXTfFVsGxA4SO84D1podm9dfti7u3IT8Kng7FU2J/rZzfC
 stF8y0r6fIylAz0CAj+K1yZsDSPE0+CYnflqSUwt4ABv0cpFBzkOiyBNLtDInve1aTXwG0ahx7X
 rCXSCzGjS0ttRSun7dfAW0QEU8c/F2Xiyt9Cl8wtIgzvQ1vXdzQVK0Kfa5l+9K0VWcXl1ynoiXf
 Kgc4IAwCoVS1jNui6n33RPy8dxOVr7GsllgmUM/BCd52+XLHl5UeKfWbDXtSvF508iMUTYJJu5J
 ZxlPqH/cRAQjZqjAVVwX+PfABbv4OpUTYEmA=
X-Google-Smtp-Source: AGHT+IH8UEtYFa2PQBqHiG17v5BAz5LPh0mAqz63ndCBKoqIlBzrLcUFETWuEhP/ByE6Y77daHlgbw==
X-Received: by 2002:a17:902:fc50:b0:240:2efe:c384 with SMTP id
 d9443c01a7336-24096aa7f5emr109094365ad.19.1753995994426; 
 Thu, 31 Jul 2025 14:06:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef66fdsm25920015ad.38.2025.07.31.14.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:06:33 -0700 (PDT)
Message-ID: <7ffd2eeb-ae68-43a7-a45a-ec05ece0b71b@linaro.org>
Date: Thu, 31 Jul 2025 14:06:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/82] target/arm: Split {arm,core}_user_mem_index
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-51-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-51-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Separate current to unpriv and arm to core mmu conversions
> into two separate functions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)

If I followed correctly, we replaced all calls to get_a64_user_mem_index 
by core_user_mem_index. Thus, why not rename directly the function 
get_a64_user_mem_index in core_user_mem_index?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


