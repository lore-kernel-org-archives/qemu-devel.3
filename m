Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D373CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1Kq-0003u7-3R; Mon, 05 May 2025 15:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1Ko-0003sC-B9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:18:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1Km-0001ln-J7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:18:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22e331215dbso1609235ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746472714; x=1747077514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qgUGiM/DYUpZaxD+L893gwF6KdedTU2Fc07gbGMU5x0=;
 b=CW/1TtG8VjtboeOmBxf22kOcRmzfibWZlPcK877o0A1WZ/hr2mxhJ7TbElUX4grCaF
 HX+mzOvS//O+gBFq0m2ImNnXdA7szRttDFVtLM0pjol1IvoWOqaZLG7DDLgjCK+6cf+G
 pXx0WWBIETi+7hpK8oT9mvlT+Bp9AH1QNvmGdSjkb/sySgoXs5Fe5zDeoxZs3t7ET1NC
 gDIXnLb1AUnODe8oW4JpyiDVMQ53XP7fbibj1KjiDZMiv8A8mtTavfIb9cve+BJYIiZR
 gmFYJiBQxwmgrd05Edm3ZOG5It6BRjMtwqwIhg34xUxzINiQ8CB9xZRd1zbeOkhQ/Asi
 xupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746472714; x=1747077514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgUGiM/DYUpZaxD+L893gwF6KdedTU2Fc07gbGMU5x0=;
 b=TvqL+s7J/MDk2QUzPzgWLTqIId0bgfpcxCOW2aqUbPt2irXbiId/6pQ0kP3N0Mfrpg
 awW3Cbc08O1OLdp0Y8utVru2ZZ49gghSpJBuqDZoaOkAEkRG+w0IcrndzCtmyseSOSsy
 MfMYThDJfLoRoxyP78t5sA87221nfIbvTB9QexjVy379r5Ai7lDP2vbbnWYRgNx2UfZE
 6h2JNuY+S938wc179pk5DGnd0wxtk9icl+GwVgXkS7kfmEWjC0AtZ2eX/+Xh3Wg7pCFT
 1HC2GtsFgiLfVjE1SKU98B05tmuQCfhbGb3ucSL2KcztYKZ5o59LF7DX80y/hxy35jGG
 BSTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ODSPI3FRVJefAyMhkha0yJPR+XoRzTLUGuA0L8WMkPGnjaWyKWa0l5Dn9QbkiTrLLJuAEE/QmKmE@nongnu.org
X-Gm-Message-State: AOJu0YwOxmMLsemTL7iTXh6SLCD5akVQBzcWB2BOurx2C7uOrLGuCZM1
 X0dGPthhwNyNVrzNHr+V6x+GSrfEt+rmXX21KcINZgQodaUIoCwqqU80woXzYU0=
X-Gm-Gg: ASbGncvUXgqw762/VQZMnq+3psLecp62hVCtf+a4BTgaxI/iTdgO6ydFeoHe/0Om6AM
 ay5bAHiv4FRrJaBf3w48x9RYs2Y4f0kZbpY9twIDCv2nreEm61LIfUd85KagveItBBXywCE5JXJ
 fZVBdEH7r8/opo6M/TQck9ocdcVo0ETtnVe8/UgX9NzEqMd2ewFGF6h/RLS6Weoyri3iTkQNqtG
 XlPEJBx0WrqaIFb5izKvVC7Ct0c5iUpiBe4i0MLf8Mp4SBP+wE47J4TInX6oOMKAUfYcd1ZQmBX
 JbuYCDl58O0h47gZnlxjo9CWRurw4lTRldXah0m0wogLZqDQJ8OKjQ==
X-Google-Smtp-Source: AGHT+IHIZp9iXH90LNiEVwJbpi1Wd+mM2hRGG2JijV+Y1BkDIa/U6IW8Pa8ko2+EKFWM6e6m28nelw==
X-Received: by 2002:a17:903:110f:b0:221:1497:7b08 with SMTP id
 d9443c01a7336-22e328cc817mr8874575ad.23.1746472714255; 
 Mon, 05 May 2025 12:18:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3b7c5b8sm4963587a12.39.2025.05.05.12.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:18:33 -0700 (PDT)
Message-ID: <45230c51-4fc1-4953-a914-eb61dd6add99@linaro.org>
Date: Mon, 5 May 2025 12:18:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 43/48] target/arm/tcg/iwmmxt_helper: compile file twice
 (system, user)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-44-pierrick.bouvier@linaro.org>
 <2c005b5f-1308-4c7e-9b0c-9640aef294e9@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2c005b5f-1308-4c7e-9b0c-9640aef294e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/5/25 11:43 AM, Richard Henderson wrote:
> On 5/4/25 18:52, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/iwmmxt_helper.c | 4 +++-
>>    target/arm/tcg/meson.build     | 3 ++-
>>    2 files changed, 5 insertions(+), 2 deletions(-)
> 
> It appears iwmmxt_helper.c could be built once, like crypto_helper.c.
> 

It needs to access env->iwmmxt.cregs, and ARM_IWMMXT_wCASF define, so it 
pulls cpu.h, which contains CONFIG_USER_ONLY ifdefs.
So we need to compile it twice for now.

> 
> r~
> 


