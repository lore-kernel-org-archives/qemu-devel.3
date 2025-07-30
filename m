Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1EDC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDs4-0004Qf-DJ; Wed, 30 Jul 2025 16:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDku-0005cu-Lv
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:50:32 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDkt-0001lt-0i
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:50:32 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af51596da56so157808a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908629; x=1754513429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hhBMgOxEupgUOfYMZVmI4S7+opyF7QRekpfmC633PTI=;
 b=Lr2/twu7RF174npuZ5pJHXONdUNTZRALqU4wTGWSCOezDaOTCR8jpO1+thXat3x3oX
 VGzK/oKJ3G45sCPp9ZnYaMFR+d+lLptQoSW//nZt35ntrbLxaX5ZPtPiwZyZ511bR3SJ
 PxFJnQ5QuizWhBps4dbpz7RzBud8Nr3FnrG1xAUj4qvUsxIA7S5ArSq7E4Y7TsQlDOGs
 yFbt594m4kCsuqi4J5NDs507hfzCmrE3VrDV5HwqBlYbY3lo0C4o+KuuMcMotUcGy2Ab
 UpKZdn09rYYMA+/DkAlWRv9IK03gieFZyBHppOrweEd13hejSwcgaQBfrR5kZQ7FLkLC
 MIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908629; x=1754513429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hhBMgOxEupgUOfYMZVmI4S7+opyF7QRekpfmC633PTI=;
 b=B7HNaG4fNfQC1Qh7Nr1on53y7rqlEUNyg/53G5uaTy4WVq2ClEAfV2Fw6tsxEX8xA3
 01Vw2Vaazo1jQn0fKik7GsuYPZ+d15yxmH1q7yR5yxLUoJupwGg0KC7J4mii3Rs5HmWf
 zpEgwtW9WJI9YRnV8CSvjmKMVgZ2AS8H5URY02ns1QoFNlT9ojLtyUzMwxzfV4aZNWrD
 1b0nYoVfaWJqGZw06Nkt5Ebx7taWKKxJkR8XnIlVHXjC3ZJq8IvRG/4iQX830+O8VYrm
 BgHuhg6xHTlcSC6y5hOQPf3+HbXYFGtcIM+IXMvXcrsjoY3IX9B/L8vVgyuZGyZP1oQP
 j5sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdNrJ8JapNKRlCWXOI6gTtr+ZXRIk6eWsikDlnQ/034Koz1DuYXHsvEueUxoeAPya1j6zNfIO8rFgc@nongnu.org
X-Gm-Message-State: AOJu0Yx5yh5sEjt2SFew9wsRLXsXqEIuqrNZU6OcUdJyGJXEAFHgbUv+
 Usa5xmQgsh8Wszmq3jZk3CxBPs3zIUv8WMDGauvlrwmITO8hRgF/50uT3wT4g3sjFhA=
X-Gm-Gg: ASbGncsIOKImaCD60YG6cr58iNV/LVbS5vgv5CJl/cKL2oVrZy1nSXQGLZJ2nHuIAoP
 EwXHn3lvrw+Xfb/Q2KmV1nLRAyxJn2i4qHFe1sbm100wX0ofi4nj+vDFgWZI+FGmIhGVC1V6mAo
 Zwn2HhbajnMm2hDO31rIJwoJqfRVwkbkeq35nPyKrksKqpVIUIl9uw+dFTKi+o5KpNjLyMk4Bya
 PHz/hiyZVRdoSYRC5EeHydpkGwvOKmMrGBEvUOX8aXlOU8E81DspF2WnIeqBv7xeXSXEqbg1Uxq
 gmPpY3LOM2pwidpk+Vvx6/q8d6mra5ZawYj8DguHIQmNOab2gU8RAIq4yVtqiQLorV1zCVkQoZ+
 Otaz7Pa96SOiai2zOEny+H/QGZWt5h7aQb4bR0Aks5Cf5iQ==
X-Google-Smtp-Source: AGHT+IFF7NwzO3JspknBGEko1JBNY9AunotgfrqpFf3dZYokNJyyNH67GK59nmKL7QcN6NqT7QdD3g==
X-Received: by 2002:a17:90b:384e:b0:31f:2bd7:a4d2 with SMTP id
 98e67ed59e1d1-31f5de69998mr6332366a91.35.1753908629164; 
 Wed, 30 Jul 2025 13:50:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207ebc10b2sm66265a91.12.2025.07.30.13.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:50:28 -0700 (PDT)
Message-ID: <a5317219-364d-473a-948f-75ae4fe430a0@linaro.org>
Date: Wed, 30 Jul 2025 13:50:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/82] target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on
 -cpu max
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpu64.c        | 2 ++
>   docs/system/arm/emulation.rst | 2 ++
>   2 files changed, 4 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


