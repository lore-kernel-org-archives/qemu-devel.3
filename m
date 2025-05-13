Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE36EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmX0-0006sN-7S; Tue, 13 May 2025 06:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmWz-0006s0-5r
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:06:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmWx-0007px-C3
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:06:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so39004565e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130793; x=1747735593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J4FOJ3+jCdkOTdzBlJQDGCZ0Aj6URs9ripel+V7MJhs=;
 b=Mucnc3OZZSBIIRc44pIO6pNJZ9TkWGn14fy4Og2Jt75M0jSuHxxYME1TKf31Vpwwdy
 L5UOGAeTjDUSqyKYgDinGpl8x8idRTMP+B5iRwVe64Xqx6gStBJxs2FJBxTWDI8xv6I0
 K1Fl25YTSZc8CNnPmet7vrU+sLD3hy3YfojjJwD1MglYh9a2mJCToCe7OWcoOA2BvGnA
 h/f0LqQQr1ge0t+Zn/DNtjp2D2k4KQb3SLP3iY/T8OtOY+tLw26koRVqO8pBGYLzjB1f
 NCqkmLUXJTz+kDPIxvkr0JfSaHjixqyIOtt0QvLkKUlStgIiSOu13hbRUNrgLe8lG6s+
 k1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130793; x=1747735593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J4FOJ3+jCdkOTdzBlJQDGCZ0Aj6URs9ripel+V7MJhs=;
 b=oV6dGIOTh+evyYEcwoHNw6MDhUSA9IeiMMNcaptoTmKN7wUzpTKtPqb7piwACzOpr2
 Tk1olo52c3OrTgzDi8jTHpKOKamw5n1g2NyezM0nwlUg8fsD40xlbnhKny/wfQw9iLtG
 dtkVoXUkAhv7zy2lLzgXlT9S7MTA5qUpFyTxn3WYxfCCls9YtmhxCmUZSvbpT5hkdUzl
 8uFpVzGiR7t/UZxvtSfY87LpW89FofcST8HahAnHtHtNJuA/9VauvbXjqAn6kEZgn2VI
 gTZBa83CBRY5BBoovhl6tgt7atWpRQU6Khjp8+5zpROV1SvCFqudQSsMR/lZxbPwQl5h
 6U9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOW0Tcp3kU/252a5Z+yfvv5NTfGI57udWagXaATL4DqfxssR5pgbkTSSS02dfiIYbMdJbE2Uz5GSMv@nongnu.org
X-Gm-Message-State: AOJu0YzFMfrbP9TjeyV3WXLvyY5sAyp+TN/sZwIa8sxxc/XnZaFCuqcw
 C8+q5//GGRH9h5xu+ZGgHN8aGdkMcLD7i86hW1N+vn9H3voryIGfC6X1wKR4ITM=
X-Gm-Gg: ASbGncvaAv7Y9qHitWVqnWtV45rc7ZZ8j/fdwMCd2sl9cSVjd8pZ6bsVDaLd7lgJuZk
 RsenpuH7MP91pv/z/B3lqf69a3y0XpWlW2uA0oc/jJj3l5vCPE1gxRyPkxX1EvDnSZ8iFpJGTPZ
 IL63oUTRQelr7R7dWKxXFLxg2PmtER1l28gIHm55PHSgzfvXiQrhg6fr8N8ixNh85adwRy98q2v
 MOOi4p6hYXuENWSF7mhaTJ2b8SzgWD7soN+fwqNYcodOv3LfAZLHFEAzS6Nc9LRkyxqdv8PW7cf
 dJNxLkifMtWdTS/QLu1XzGLJOwHhsHistO3pmx83eEdaTI3pGnArsOpilmijF9URlRWhf0gJOYP
 nU9MqqbCOUrUd32FizA==
X-Google-Smtp-Source: AGHT+IFHLrSF9XA++jfCq5+p5aY1/NBqp7sUwHhhZmRH0EhB15YL0OESBl1s/DFkWQ+4RjFm1GwXZQ==
X-Received: by 2002:a05:6000:401e:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-3a1f6429791mr13293184f8f.1.1747130793581; 
 Tue, 13 May 2025 03:06:33 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4d0dbsm15346027f8f.88.2025.05.13.03.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:06:33 -0700 (PDT)
Message-ID: <e5c421d4-2e8a-440f-ab1c-87aa642f529b@linaro.org>
Date: Tue, 13 May 2025 11:06:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 22/48] target/arm/helper: remove remaining
 TARGET_AARCH64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-23-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-23-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> They were hiding aarch64_sve_narrow_vq and aarch64_sve_change_el, which
> we can expose safely.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


