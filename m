Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE57C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDjj-0001yl-G6; Wed, 30 Jul 2025 16:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDPX-0006KA-DW
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:28:27 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDPV-0004OO-S1
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:28:27 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b391ca6146eso165874a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907304; x=1754512104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mchl5aQJgXEcTBdFhrF4huPC8Whj59CsWg1DOihZU90=;
 b=j1S6FM1X4cleQAI0EHK/BLBpzK/nqxe1Smxz04LZ+l9hOCu0NVnl9E3uex7KrXHM84
 V9VA+bIoHdJSEym1U8By9fvEzRNcT4Rcu5jLT3U+lfsD2ViR2hSyA1pCBhdjlWFfTq0O
 6DgYcryAqO+q2wANw2j8hWywoVctWoIRq1mQCgMURgcDZ2X4lQN6OLsorYGcKzHTxb67
 3jD1kqc2hetLgtH7a4HamFre+EZSQLFTHytwAHWHGNCDV39zgFJxwAvaqIo6lOXdLJIP
 xMSPvATEdjzu/Xk4Na7kKuUxxNRPoBVgWRhfEdVWVytJiElv8/KjoM+p83QOC67iYJmv
 5S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907304; x=1754512104;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mchl5aQJgXEcTBdFhrF4huPC8Whj59CsWg1DOihZU90=;
 b=tREnXW7mp2tjv85mPMay06HSGrenzz4H0f86jk+crBa5SF+fC/DKoUQ8+Fvw/3pDGI
 rhOhE1ak9zoVY+WDHuQy1iRuLoam9QqOH2ss6OoakqDBiuv9eBjthB4x0zthQFM2nUEt
 oCJqA8jPsxDHHGpAdNYm6Pba8OLzbpf1iUQgoXMOJjQ6mXYWOGDHM4+eTPFUgKqcHrMJ
 S5vH9RY5RSNF1vBF48lmQQueeC2qJC8U3cF2OeSd4Oy349Nk5sX0FGJpj9OIPTENZ35l
 pB0S9uxTGc9xMl2M79FvmfG565QcsQhnWXep/+NReVW4FEfQw4cycQrFyxqKlWSIojij
 Dv0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtWRuuWs7nfif88tyZJMWqPNjhfn+XV+p3mR4+3QdJ6uvdC32DzHxTkzyt031VQHdhX6QtMj9wDcCZ@nongnu.org
X-Gm-Message-State: AOJu0Yw/kYWjslOjpxyx8xulcXY2TXYQGFuq01Y6udB6iSkHssFXdL1v
 I7UNoSRjCABFzZCRI1292tiYCFdy5OfPzImOMslNRUmblgy3xPjmyCDA/bN+s6MBjbY=
X-Gm-Gg: ASbGncvdi2ky5J2maTpDgpKDJk3EHMqhu350hO0HKVjU8+JzKgZSuUPnbL8ZAlSmnL5
 DP41+Tjkf6sECB9V8X3yaa2D5moCDAn5dHEBmd+cW7R1P5PeJDWvM0fRzOxJsxkMtNJpFK6S+Uf
 Y2mEzhQMWKCRLoGdiRz3+Guk7jRebYfKXmMf4j8gC8u4Qn0NMrcrvsC7GuK1CxXKlUvOSGI02Gu
 ur+4QWCsRrfzKewqdaKLWUTa2V+OWu2rpgQ/bguwxHH2xPwC/bCoHC3Gl4ETsvWFA9yDPb8rqCs
 BM0BCv+Ehye72y8yYaygZvVbLjhCIJk62wgi5tun8ghurWBb4s2+XpMV0/pIqtUb8OA2a++F2iA
 b6tC/LLoowAF8q3iANZ6L2ICBFGf4KkArv9E=
X-Google-Smtp-Source: AGHT+IFA7n6ZMvqAk2gNrEFi9GMUdICC4HgviybEZXPYwCAZ50Tpt7we8PgCqI2vSso+ovNv3OtaOA==
X-Received: by 2002:a17:90b:538c:b0:313:f6fa:5bb3 with SMTP id
 98e67ed59e1d1-31f5de55640mr5919610a91.26.1753907304355; 
 Wed, 30 Jul 2025 13:28:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63f0cc41sm2743196a91.32.2025.07.30.13.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:28:23 -0700 (PDT)
Message-ID: <df5e8ce2-b578-47da-a82c-9642f2e5308c@linaro.org>
Date: Wed, 30 Jul 2025 13:28:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/82] target/arm: Skip permission check from
 arm_cpu_get_phys_page_attrs_debug
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Do not require read permission when translating addresses
> for debugging purposes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


