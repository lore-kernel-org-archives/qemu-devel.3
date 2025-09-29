Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86BCCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3MuI-0001WB-4Q; Mon, 29 Sep 2025 19:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MuG-0001Vq-Eh
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:03:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MuE-0007M3-I6
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:03:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so78770685ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759187019; x=1759791819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sYY2XvuHENwHSRr3EEarBgRkn3IBsLX3Aru/2X6eCkw=;
 b=hY3t7dtDbHuf8Fijkhpwt41gZulGDssmyN8gKpDi1A9h+e+CI7hiwTnM7EwPOz4paL
 h6fu1e0mYf4QgVWI3+pnVW+xGoCccwRKrwXndkwKlj7LzUhKxgj5qxGKGAx/YKdAWX14
 rjuJ+9w4WUOJoS+rBLVy2Z51X59P3ZOeuXURgrg0K4RBWbJRuF2StO8Pd/bU9m4nu4cG
 WA46cczuom9z7cJyWtQ7UrUZ0bOMeqFY9drfOy9RkVV3GGqNamcqMDdwl7tVncxjo0bE
 6PTZIYlBWu58Y4SkcT+thkhvcytzv5bwCfZtAfV03vTUlawNeGEEjgTFSDoaoRjNyeMx
 3aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759187019; x=1759791819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYY2XvuHENwHSRr3EEarBgRkn3IBsLX3Aru/2X6eCkw=;
 b=bETeHg3isj2Yaozp/MSxg7rUJIhVDEjVqpd1vmOWulBdjcEZNPaolyeHCImDR559H2
 Z5xFgY9Um17JeUGDmfZ3P0cTSTP1yROCbjvZeVdMm/yGCjgZmnmyBkb4iLaB2cD+jw4R
 4exEcwhwFSdsMYJ92EmF5mpWefXX4XQzzaqPXu4vYj/B+JW00yHkkxnGhxx4c2hYsORV
 iAnZyOOdt2twc20DvVmaZBpWTJqN7dvYTlBl/F5q5R3ErWdwlMn0V7HpAz0G2HdZrzMS
 dMyZJJT3BIu/FWp0s+VVo4WgUjl3r9JYHejP8xNUJbeDUdbF9tEUiI4DxhxcXwhVqFK0
 pGzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOD4llyo5qoBnxpo+JLimGNUXEQzWLm6SRXAv1QwLXPZODwpLa8BibYX+MWKqdh1ggOOJn/rGDAUoT@nongnu.org
X-Gm-Message-State: AOJu0YyC8/FAR27lmbDemP6qceUvMxeftFHc7hLuO1ZCOoSRgvhrIJMy
 cYi2DZIxxfFkuNKU6Ywzcbgt+c4ehmJ1EiJyy+G9WBpTi+4P5mr6L4JEl7MUNm4GnyA=
X-Gm-Gg: ASbGncuMX3KY79vXONB4IbhsUHYBl40aefgfxc1q5Zgvm9DGdPLJTpMnz9uMUtQy8xQ
 +gXpdQytFvtbm/1rthV2MZt5T0pPimzCWwjSyqyNSFdVb1Zv286NMlOvxs8wQ2j1m9Mz+slgAVk
 q1As4qNO8PsVsehHjC4edGXu8r92NH7q+LBhq9EnFZOlPCf8AkX/94F8yPoB1/cyEBlCZv5fsqx
 2xzHjVbbujJa5tryYJukZE2p3bkL+hkaOh8z0MEKf1OLTvBoJyuaZ7tyj5OXR1vEsJgb5FREpbC
 DSGvkerOROdBXmLGfgnFPUZunYys6XzpLAknp0gXmBTPlOoSQRUodyxGl2Hy1cE05wXyQO2qf3j
 kdP/RELe6hUdy6sgG8ct33hxwyDjsaUN21ZA=
X-Google-Smtp-Source: AGHT+IG60c8gP2WTcic+TvBrflnrjol/Mb40nCOw97XuOXkSJboLmlYkj3bl3u/A0DI6y6ukcTjtcw==
X-Received: by 2002:a17:902:d58c:b0:28d:18d3:46bc with SMTP id
 d9443c01a7336-28d18d34794mr20359705ad.19.1759187019561; 
 Mon, 29 Sep 2025 16:03:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6715f0esm141132875ad.52.2025.09.29.16.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:03:39 -0700 (PDT)
Message-ID: <2c625d14-2237-4a85-99fa-6acd9a4809cc@linaro.org>
Date: Mon, 29 Sep 2025 16:03:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] target/arm: GPT_Secure is reserved without FEAT_SEL2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 9/25/25 5:11 PM, Richard Henderson wrote:
> For GPT_Secure, if SEL2 is not enabled, raise a GPCF_Walk exception.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


