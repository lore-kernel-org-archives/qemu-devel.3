Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354BDC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tve4p-0005QG-6V; Fri, 21 Mar 2025 11:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tve4n-0005Po-55
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:14:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tve4l-0005tw-BB
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:14:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224341bbc1dso42767995ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742570061; x=1743174861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JrCdn86rDDAXwuWskR4pjptdT6EIdC+YqtF26TWE+kk=;
 b=DvL3aEpcApOwyqZ6Ke4HLAU3m1nT5m8I0CjzY5HQ/powj5pCFv6dWxYweLZbb0B6XN
 c9zHhSC4LNGnrnqNHr//FTcYHfj4y6Sx1Z9q8Y5+IlJtpSnQcDq7jjs7MKkHIykRnFX8
 0/is+v+hKtpzBq8Ct0NgwmkY6hoU+1OH0c9K3a65sdvaWRpu7pQJ/jRwSQYTulbrXDR/
 6DhcZYQhE8ByfEoIWjd8kGrh2C/P+Y4DaaoOwjUqHgGveyypbRYSv7OFJ4130yTNiwqT
 0v22K7KPX2tAmd25Gy9R8HNuwPKoc+2rDgTj9zgle35S+q9Rp+4iHqN+eygUn6syBPDJ
 tdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742570061; x=1743174861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JrCdn86rDDAXwuWskR4pjptdT6EIdC+YqtF26TWE+kk=;
 b=Qy+5D8Ys9eDWzlguiSOCQkJgqqheR8Zhl0FZ2uhsybdv+hTDyrzWtW3rnpov9f+3fw
 DADE/1hXjWHQoXIE7WfNICebthp0jhW+NK0WYY7McutpKVvsGTUSylh04q4z+cihXGSR
 +rfhGpkZQCY0xsTnmhP4WiGdhCW0vYhJOcH9BIOFYNLMR+n4lD7bhAGnOFI+veUYf7nd
 iL5EwN+CgoEbZw3HmMdX2ZmlfZcTArgR2SgVZVwEcscZ3ZrMld+dzumGv+/3qTD36emR
 VjBvXMxOtGrCZoKlF8bt6QMkfjFAw/a7685ps/WE0dwq6fuMMm0zKJ4spjNDfG4FXjv8
 ApGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuGBoTwBJJutOw+yNbVTNzbUtKBPTPM9MHVj7lE6QJzoPR+L6oef3rfNYpfF1OLCoVStYSdCrVoVUY@nongnu.org
X-Gm-Message-State: AOJu0Yw3Lf0RpCZy4toMIyWCF93uu/PBb+b5mkSr8K1m76U3xGltucsj
 wR/nr6GCXCjAtIwkYQJl/nPi9UKuiFCqwmUhlaKoZ8G9rmlGDUkJv3nYuNEGm+YXVJ4hAVjuXcn
 c
X-Gm-Gg: ASbGncsDRRYYgkjpuzH/DiuQSYOIS1CfzKtJt9qIhcb5hdfp3+NzcKy92WKT3mCKrFU
 //7ZdlE2PqadUex657DxGNVB8oE4ZqkxOqTXkWPjBHhvzL986MXf9nVvSnB09ZS0IMrBVaNmI7V
 xqOGBrBe9/zGQD0kkdoxCUGWscPaZMw1TQJVZfVPg3xbX3jNPHiTp2gMIc1m3uFjztTsP3z6MbI
 +DA3Qi97Tkg6MNs1nyzn7FWzxRGZGKolayOSQZ9qHGj1a2NXXI7V8BrhAMJ+2sygN2VMXkmjBd/
 QvJ1ubPwud5vBqpwMoDXbA0qq1vFbmoVgHjkLO8TgWSmWb+MmgMgeQVTSUOOMwMRpGnMFVxxgoc
 iYo2rtbzffqZylMRazD4=
X-Google-Smtp-Source: AGHT+IEifF5yuy2fptNw1VkXJkg/gFHQjHJ/k/5as093LIhKubsriZ7BC81AV+0lZBB82JXmkZJB3g==
X-Received: by 2002:a17:902:d58c:b0:220:ce37:e31f with SMTP id
 d9443c01a7336-22780d7e9bemr57843515ad.17.1742570061265; 
 Fri, 21 Mar 2025 08:14:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf61a44csm6161233a91.37.2025.03.21.08.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 08:14:20 -0700 (PDT)
Message-ID: <0944bf6d-2088-4d2c-a92e-ec98fe57eded@linaro.org>
Date: Fri, 21 Mar 2025 08:14:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/4] tcg: Simplify tcg_req_mo() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321125737.72839-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/21/25 05:57, Philippe Mathieu-Daudé wrote:
> Now that TCG_GUEST_DEFAULT_MO is always defined,
> simplify the tcg_req_mo() macro.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h | 9 +--------
>   accel/tcg/tcg-all.c         | 3 ---
>   2 files changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

