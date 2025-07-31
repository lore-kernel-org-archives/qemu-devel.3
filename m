Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9331BC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhazf-0000rF-Jc; Thu, 31 Jul 2025 17:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhama-0003dd-7H
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:25:52 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhamY-0007OA-Ah
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:25:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1476894b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997144; x=1754601944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B6UH//wo/VmgG639UCu7tCAm+lKhvQMnF3AqSS0GqJw=;
 b=FUcyLUz9OLb+W9IaVa6BiEsF4tj29K4WlhRZ0yvrd8JYSlNqkqAcamj72l3tlyAmoy
 S6+ivB8HMPMQNqf43ifkXTSV/I+QUPGvCcsrgsfXk82YiL4InGkugAE8YR+M6UXzVecs
 fycyYYTKOP8JUIVESOvbwJ/TcLov4CjoNHe1p0UDuXmvy66vjlun7H+BRJTOWOIZszmW
 IrgxDRSrTDaTa0aB1ZWlcMDE+jCtfHMNy//p8aqZ2AnfMrrelp0hbuMfQ8Ov6ZYw+Pb6
 12edby1JZal1dE0JrWY7s8zhSR+lcmsZASTnYhNR306rpVoD7rBT+6bErB/kJAloew8e
 g5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997144; x=1754601944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B6UH//wo/VmgG639UCu7tCAm+lKhvQMnF3AqSS0GqJw=;
 b=AwbVPa8HuQCwqE4fiQ7p9nE8LbtkXcjDHmICbfChbjqoaqgjl2puXIGRQ9NAHwAa3s
 m7Uczps81McDuUwEwO6zB794V0Qct3TgnHbNb6OBmcuILxl1O81MMtpBPAI91JADAo9j
 QfwONe/rGAk1J20z7kTAI9Rip0hzOKHTpchYbJ3ABd79tBdASJhswQYNgoFgqCEz+aqW
 28ahy7EsitMgyF5Z7BSmpH5hFuNsWTwiefdQyKPYqqk4D3ASKeKAb1kgZEt581fgTzcD
 faCD1P476PAhtKFiNbq+t/VYM+rMTQIpQ9UCvx0kas4Ao01o9LRMDI9TSREsycpYrY+D
 +m6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3BkAQMGptvQpO564enSS8d2XvSl9Xwux2YdVQJOst+Y6PW92i9Ps6ItjYkPRbucWuVECyeFMM/9je@nongnu.org
X-Gm-Message-State: AOJu0YxqzIPjJwc/ZP90OE//I/14CMn/YgKVCPAxkOlql6HqITH/OPN4
 qfyl2i0f5bFfhGjkhUntoT6MCrOeVqFZnUB927e0CCylveE7cblqTXXyhcBxIN/wL1c=
X-Gm-Gg: ASbGncs0yYOJA+OZnuU106fTtLmy90kPCIGxrA/+6gqqPN8NuCjAEgnolxFVrwePtiB
 v6rrSItx2YT1abIjmlYKbn+VW6H9P4PSjrLtYxo+Dyfi0p8u2+utNZjH5l2nSY3Cbu3CA5aJmB0
 ctYyZ3Zgv0kUB56R/9PgHJVHTDFCejnh07bAFYXrMpz2iN4fRsu9WhujFXYqdmfafLLgeXdJ8Yt
 5KWDpU5uM587hBwd44Q+XHrbBJnfCyQ/Ho7uQ/hwGj5YHyNl/fUyxph7VJSmN4PBOjKYhkEl925
 1l3Wga7KVU+UbJg2i1t7wX2sXvJPicYn6lerrduPDe4m4SrPW72L11syoS/twy+/2a1QX2T+tVe
 zOi0NLrlB50uLKq8VhDgwbnNJ+U4PgAiGtJw=
X-Google-Smtp-Source: AGHT+IEV1PuA2YfOZeuOb/o100H+mE5COIC/w3S1vmViMkW29LubFHU48+11ZX8Dc8H/ejGqeZFIFQ==
X-Received: by 2002:a05:6a20:3ca8:b0:234:80f6:2b3a with SMTP id
 adf61e73a8af0-23dc0cf78ecmr14192540637.4.1753997144582; 
 Thu, 31 Jul 2025 14:25:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd7887522sm1214637b3a.20.2025.07.31.14.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:25:44 -0700 (PDT)
Message-ID: <17282aef-11f1-4815-8465-314f99c1d380@linaro.org>
Date: Thu, 31 Jul 2025 14:25:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 54/82] target/arm: Implement GCSSTR, GCSSTTR
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-55-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-55-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Note that CreateAccDescGCS() does not enable tagchecked,
> and Data Aborts from GCS instructions do not set iss.isv.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
>   target/arm/tcg/a64.decode      |  3 +++
>   2 files changed, 45 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


