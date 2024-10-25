Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6971D0BB56
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4M0c-0000fx-OO; Fri, 25 Oct 2024 11:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4M0a-0000fQ-Fb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:13:48 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4M0Y-0006uY-V4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:13:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d8901cb98so2160400f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729869225; x=1730474025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VEp46HwqG83YzIKjAnKmR+KgI1Of4qgSpqP97jzmFAs=;
 b=w2ZHJP7IBiaZxsFHYDSNL0V9SYJBNA82Uy3rOCLa7rT4hIJ0ugdZoFnjGjlp3Jbbnl
 GKd1vRTSEBKgOvxxUMDCu4TDOTs82hywzDaPp54jxWzNWb3ZGn4DH9o1/X4MFlFCWOj0
 K7nKaDagxj2EAxGc+2kXetV+DnS7eulWsaOGYRE8vlH9zV+cbrcgPLln8s00vHLlUtI7
 uvePJ7zJUechI/XtNUDGTu94m4FEGLJpshBC1QrXGHhZH2lklCypCMWc+WUacUix9+Qi
 UADqJMPF9WgNMVvPI+tm5AFD1kiJywFCU8SenYeBWOmTk9viChzP+Kzuewrdfg0hZQHu
 cONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729869225; x=1730474025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEp46HwqG83YzIKjAnKmR+KgI1Of4qgSpqP97jzmFAs=;
 b=aKI6jWcaRc0j+krjtSTk142W+QyKJiR9KJHadrzNqXVv4EA6zUKRUrdbFjZp7Mef+g
 l8+FTfCYSDK2ge69KKOcNyMfaiFAauKax2tE4GrL7LsDAMTI+p8ED/2v5sHuEyNlUey1
 LEz9axElah29UF0k7aLNmLdqdD+6+EJx084lG2rGlUNUHKheiUMyL1xNzb7B6ki/AT5J
 72luAhon9zXen2IuQuRVdSbzqZYO2r40B6RQFBmgLCm++o7hbHONYMWyq5U5yloFpvG3
 yRLzZUHezMe2rh0pKs5KJKcWavt0b4dhoDstctR6PgHGWjvDcjMduJM5Wv+bMKMffbqY
 jxtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZNmFSux215qIakRa3M4KAhkj8V+CHWeE1RsJH5aQYxM14+Zq3FsEMBmhPw8RbP1Tj+ajDkapBUYG0@nongnu.org
X-Gm-Message-State: AOJu0YyvX9V5yMh8aGYTMfHfqB6FzIgusgS1LwrzMsrtudDJL7irck7l
 uw517mPNJuT3I53TP07DVcblGQKSbvjrDiX3MOUdLCE/0MlRolO8ivIBKoQSr7o=
X-Google-Smtp-Source: AGHT+IEpSi5e707vnKaRGkmDCdHLPfjoWrGlZ4c53wkRBoueyqcZK4qQz8IjyMvCKB2RsbP0s1xkVg==
X-Received: by 2002:adf:f10d:0:b0:37d:39ff:a9cf with SMTP id
 ffacd0b85a97d-3803abc5251mr4552885f8f.5.1729869224224; 
 Fri, 25 Oct 2024 08:13:44 -0700 (PDT)
Received: from [192.168.5.26] ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193594fe7sm20383465e9.14.2024.10.25.08.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 08:13:43 -0700 (PDT)
Message-ID: <d34143a1-2ed3-4d72-a00a-5472adbc55ce@linaro.org>
Date: Fri, 25 Oct 2024 16:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/arm: Fix arithmetic underflow in SETM
 instruction
To: Ido Plat <ido.plat1@ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241025024909.799989-1-ido.plat1@ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025024909.799989-1-ido.plat1@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 10/25/24 03:48, Ido Plat wrote:
> Pass the stage size to step function callback,
> otherwise do_setm would hang when size is larger then page size because stage size would underflow.
> This fix changes do_setm to be more inline with do_setp.
> 
> Fixes: 0e92818887dee ("target/arm: Implement the SET* instructions")
> Signed-off-by: Ido Plat<ido.plat1@ibm.com>
> ---
>   target/arm/tcg/helper-a64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Fixes: 0e92818887d ("target/arm: Implement the SET* instructions")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

