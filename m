Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B50DC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 15:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6tVZ-0008EC-Hv; Mon, 21 Apr 2025 11:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u6tVV-0008Dl-8v
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:56:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u6tVT-0007Ig-KV
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:56:28 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso3841213b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745250985; x=1745855785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CbeghtFKJMvPvSCo/t9Q/qkbffq6jFD41IugSZ7i6ek=;
 b=PVirl1/ZG2xA9p+XgpnHu1BbLqEMbNIlogl1bYnq7ZUzlcOg7Yy5bQ6+FHxdd8gfaU
 78wHQx9R5ZGTClEj5OnqU+PKnkcj+e6J8s/Wr9kG/iSVcs1Xdq3uybuX/Yg7849jl568
 f1/KVAYM2QyD0l84ac0SJ4//HOFfA38j4s4ODaJxKSU5ka4UnSe62MVLGstLnnxke81L
 rZZxWJIiZHbJSMBPWWx5pARqOysFQCN6XlNk9wUqH4Kz891BO8gfcM1B1YkbUnWqFZIS
 3cGNg/RHNLRsGd4if+/xv/TC7HzgCYxxw8f6NPDJyjEuhljTW00pa09rO9tQSDEzCvca
 bQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745250985; x=1745855785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CbeghtFKJMvPvSCo/t9Q/qkbffq6jFD41IugSZ7i6ek=;
 b=aZAu8CrlKAz7nrdlBMsW1fK27p+QtQVreXxJ9orV/Y7s73MVdB4KaGYIb2HU7jOKVJ
 oMlNql/Wa+F5nae5zXbXNwNNoHsulCmVAglBkAZEodntY7+t+wWN1LYw03L9rhH5urpD
 G9y1T0Wplz+P6A7Hmzd17qWubhiv+YCzCweIF7G2kqg1LLDWWApg8a84X2CYUSbONc5f
 K0oYUQkfZcuLoM2h1dijYQ7imLHdJEtI5I0RohZsmAz42mTJY2ztGeXAdytcu2GKWsZn
 AQSRnrz+aZtdHhWD0UDUxuDbNfRgzGQzEaTTyX53VD/S/cBZS6wcKM08u8hRK7s5ZnmB
 +W1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwEBqJGi/mQqQa9aHG8YJcKCywiQPyAAb5WkO5djmnvi/+44WnMSyoW0TVv27zJq72hX0BW+JTYZu5@nongnu.org
X-Gm-Message-State: AOJu0Yw21lehWBt8LKtFiOrvEZYW8Nin7s0OD59SlX/jOqlatl7H+sF3
 Gj5E75WynoXfcdT7nqUnaIXNR7212JJ+GzF3lX6IHBXeWLwKr0Mj9tizuUTL540bmWxVdo2t3cw
 i
X-Gm-Gg: ASbGncsKWX4OJ0F48ARxPRIPMhAZwm5Npvyts0rr9ghJPAyx/zu1IAED3q44I64ZTIy
 2h2uRaMNQQ+MPo+iU9wHJT0zHJbRWHFPKNytveLHu0sh2Q61uTtiUaVgU8K4C6W1IcTycue2/gp
 aAcQFGUDjPVlMAQyPZWXk0/2w1kCnlzf1iSxtd6sPVlbTln/YO40V2wMQzTQKhD5VU9Q1wY/eB8
 6InV4Q3yA5NTMYK8I/yxeos1Ms73ZcgrTc0wjqpIVmZgazafs/znTmY7K4OmR1NLWDE49qPi0A+
 7cfEqb6pkhlcar+GS72sl/lOX4UyFfhRPZH/aZEf0UIMNlOIzxZ1JV/uZrYSTGSxUuH0qRnLkt8
 2agtBTX2i60Wmd1M1Pg==
X-Google-Smtp-Source: AGHT+IGcpzPwrOiBlAA53akbQvd94QtgEGbTDjqpiSTfijF17MxqDtf0DtmMGRQ8G9+Q+HckW0cluA==
X-Received: by 2002:a05:6a21:158d:b0:1f5:591b:4f73 with SMTP id
 adf61e73a8af0-203cbd36613mr20272204637.34.1745250984952; 
 Mon, 21 Apr 2025 08:56:24 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db157bb7dsm5756596a12.69.2025.04.21.08.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 08:56:24 -0700 (PDT)
Message-ID: <ea5efda4-01bf-430d-afb1-06c82b7bec3f@linaro.org>
Date: Mon, 21 Apr 2025 08:56:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/14] qemu: Convert target_name() to TargetInfo API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250418172908.25147-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/18/25 10:28, Philippe Mathieu-Daudé wrote:
>   include/hw/core/cpu.h           |  2 --
>   include/qemu/target_info-impl.h | 23 +++++++++++++++++++++++
>   include/qemu/target_info.h      | 19 +++++++++++++++++++
>   cpu-target.c                    |  5 -----
>   hw/core/machine-qmp-cmds.c      |  1 +
>   plugins/loader.c                |  2 +-
>   system/vl.c                     |  2 +-
>   target_info-stub.c              | 19 +++++++++++++++++++
>   target_info.c                   | 16 ++++++++++++++++

Can we not mix and match _ and - in file names?
It's weird.


r~

