Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A90F8DFD0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUyR-0002Sg-ST; Thu, 16 Apr 2026 18:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDUyP-0002SY-TA
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:14:10 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDUyO-00060j-9V
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:14:09 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c79662bbd2eso26462a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776377646; x=1776982446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gf9pO1FMDvnjAn+niAKCLwJB+VsYcLOsdva0xwYyZcY=;
 b=WoQa0xrAzVhqlLwjfNHhcGNLu6ntMP1rqplplsPd9iOuEuIcGZDVMiMPRO8Z09Tr9+
 mdQ6e/ITJ7q33ygxueoEneis5OU55GosBnSA3PEdErGsl6juGdxde0ZBrj2Eroz58QBx
 EqjBTZncjxo2YbN43FLZ95dS1xKs94LYyQ/fFJJZUlN3E80NEzETw5S39yBVfGlWYn23
 GswzPkGcsLsimZzWLkdzN1b1r9qbM0Sj5S/LF2PuZ+OST621acncgnrude5A0mA2m9/P
 PDHgL70jk1c67wxoMLKDC5jVKdXwXu+OKu+QTwhPaByOHMvGHcLV7iS2EwuCSO99vp3a
 isDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776377646; x=1776982446;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gf9pO1FMDvnjAn+niAKCLwJB+VsYcLOsdva0xwYyZcY=;
 b=Y5T5+Xqc0WD6gV5WHug97a3o2H/WhAN1+lFlhZeWgcgtK0h0wTaKmvh/Dd2bWlUdLh
 VhQ/7lG+mi1c4Z8fUUGg0f24mE8CgNKXjHj6u52oqet0KKtJCiGEY5/ibJp9hANOAAj7
 KMBFZcR3anKJPQ9hudEE/Fvlxr2tgj1BDIkLS0qn0R7+ZgmlQba54ifMET2OUHeKsRwZ
 QGsDtUWVkXiyErYYA2oX9aUQkBj6HCZJm7Zbs12Z4x8vxvD2nKkwQKGosLR7wfd5q1LZ
 KTXtHSzCJ1XLhY4hWU9BE1Gox+POuSewLQvHoxZUK5mjLnk7fizaJlm4NcPmSogZEc18
 iSVQ==
X-Gm-Message-State: AOJu0Yw79tWu9y0l/9+rVknmV3yEscxeyCE6PalpGHs5vaUiZMzlguJQ
 Bl0f8up7FPX9bzk+JTQWiKa5Vn1Dic9ro+N00187JUAl0lkYp32cTm6zlOW4GxR9Ifo8bC1pyZG
 rgdzXPNQ=
X-Gm-Gg: AeBDiettg0s1dY5yEg2pUgBBlnqg2ydmNObO0orxTpf/h6y9hXQF5W4C7Jnn8I9J8E7
 fyegIfcGFiz8TzNa9UdDi/w1TzLfoCwvtcbsAxH83D9wxZ5CGQaVXz/8y3TP3AHikIPNTgNd2n5
 76U9g6tXptWh65q1BQjI5xubmgC8Wyh+aNH8RWG5QKkO+8supiZbF1VV9Biq+Pe1SNgnNdKzNsR
 lYHRjHiZw6zFIu8bFX7Pqvs+9g8pGWCpn8K11kmezcpIVkVy3EjevcE2KlNyt6Vg/96UCRJq2sJ
 eiB1fw4t0/GjuJSKGSnmVMcKawGlkKQuIePGZ+pUjq+F08Sdl1c4d6D5gN7dah6wxxqLwgbqUPr
 +lSKXC0NwobJ9K0Iu3s5dtvHCh9wob5NGSeALHHY9bV8tMeFuM7A0CykagvM3bZnFHmRFqfVzo3
 GLZIb/ERRwCcCdhCEYtlfttGt9eMhIaquXtcd+XC7SrtqT6Ysub/aSOaQaIUPAPfRm28dBoq44A
 vSrEd8WC6sVgYEOb+GGzve9
X-Received: by 2002:a05:6a20:9392:b0:39e:f994:f671 with SMTP id
 adf61e73a8af0-3a08d68e495mr153212637.11.1776377645693; 
 Thu, 16 Apr 2026 15:14:05 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 ([2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79581a2d85sm5030478a12.19.2026.04.16.15.14.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 15:14:04 -0700 (PDT)
Message-ID: <f68c53a0-1ea0-4265-9fe6-8b726cca7029@linaro.org>
Date: Fri, 17 Apr 2026 08:13:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm/cpu-features.c: Add RMEGDI to AA64MMFR4
To: qemu-devel@nongnu.org
References: <20260416-jmac-feat_rme_gdi-v1-0-d9fa0781ed58@linaro.org>
 <20260416-jmac-feat_rme_gdi-v1-1-d9fa0781ed58@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416-jmac-feat_rme_gdi-v1-1-d9fa0781ed58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/16/26 21:12, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-features.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index b683c9551a..3f2a9a0c36 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -348,6 +348,7 @@ FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
>   
>   FIELD(ID_AA64MMFR4, ASID2, 8, 4)
>   FIELD(ID_AA64MMFR4, E2H0, 24, 4)
> +FIELD(ID_AA64MMFR4, RMEGDI, 28, 4)
>   
>   FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
>   FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

It's often worthwhile to simply sync the entire register with the docs.
The current M.a.a document has 10 fields here.


r~

