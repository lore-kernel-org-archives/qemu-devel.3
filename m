Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA05ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmnB-00014C-4p; Mon, 09 Sep 2024 18:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmn8-0000tm-KH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:23:26 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmn7-0000c7-1d
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:23:26 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c24c92f699so5410155a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920603; x=1726525403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pxk8r8VE6TsU4lhynGt6juAvn7u0BzinDNzJxKZ1O70=;
 b=ThU39WjuJJ81s35J5BoK2pxLv5zkqk4tBnQoyKoeajfw+52ys+jxAyjYlwSJ3/wp+h
 PAp71z+fD9DSDyGIpB+LxLekDhjyqmKrRjLnKK07LMw7SsZn96Xo62OvqR1akF0u2vQI
 YcrzBd/2oxSJ8851pgf8WdjMmjH4vOAFjIoJhJXBmynjoXORR28gzW62dP+1akSMtiBw
 JJ55fLvB4xJ2zKozSJqvh6WKzlwx9aa9t1Gx8oMY74upKOT3hWc7P5XxhVK4KVu4+fek
 g36vtHHB/DWFxLcLq0B6a13eiMTbbQbcuik7uNpDihf0wMJiEEXATSH81PxOY2rcmFFb
 TJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920603; x=1726525403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxk8r8VE6TsU4lhynGt6juAvn7u0BzinDNzJxKZ1O70=;
 b=JW+U9xmS67ol0eTsXm3UU501sLaT0mpq0h6uUcJTpQnoz1ahLgdekLszj/iZn4cXxU
 E9ZdkQWHfnCCslwYgSRGKzd+TP9scNfHddVi4uVnitBS/KT1XP3qX4EScKC3aiOEmDIR
 YodcVPe1GWnJJWzRkb5EkyKhKRD9QrsHmv+jZrQMBMphfZWu1XsLbKY6/B443hnsFFNn
 pP33PhJww9khXnZhk11q94d2jiSpTuOvFIbIDtS1reSfKLed2NkzJdZ0iMono9xODC1r
 29ld4spR1K3k+5LCbDXg3NPuJieJLG1FuyJYN+Z5Bvb1VN70TJUpnkiOBeYj76g2hTfA
 A+aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXSY2n4egaBT3NzSYDD3kVN0ZHPw8GhU54xGmVG9E2HsbtpA38zCYwDbnWe2PeRgb2wNnWlEBqb9+y@nongnu.org
X-Gm-Message-State: AOJu0YxKF7aLuJxsNRrH10b9wyg36CGnkJK9qfKH9XDIVH7C5fXRC/dT
 kTVJcz8DsN+Hle83IE+Hb/mClSnEhcV2NB6g47Vgm6uiwD0Dhe6jJuQ1dgZEv5w=
X-Google-Smtp-Source: AGHT+IEaJVLesE5IGa2pnUwJmCPZzz9MRA6rk4VicdhCwTfa2jpaWQrF/4kCZk0yQqMc0WxzjlnJdQ==
X-Received: by 2002:a05:6402:13d6:b0:5c3:f4ad:2304 with SMTP id
 4fb4d7f45d1cf-5c3f4ad2476mr5464187a12.10.1725920603412; 
 Mon, 09 Sep 2024 15:23:23 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd468fesm3517783a12.39.2024.09.09.15.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:23:22 -0700 (PDT)
Message-ID: <5fa87f5c-6881-470f-b68a-a3cd97d23938@linaro.org>
Date: Tue, 10 Sep 2024 00:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/29] target/arm: Convert TBL, TBX to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
 <20240909162240.647173-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909162240.647173-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Reviewed:
https://lore.kernel.org/qemu-devel/37096dc8-7827-4a4c-a27b-4f8343aa9c6c@linaro.org/

On 9/9/24 18:22, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 47 ++++++++++------------------------
>   target/arm/tcg/a64.decode      |  4 +++
>   2 files changed, 18 insertions(+), 33 deletions(-)


