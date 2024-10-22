Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD5D2CE14
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 18:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3JU6-000495-68; Tue, 22 Oct 2024 14:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3JU3-00047f-LK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 14:19:55 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3JU1-00015w-V3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 14:19:55 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e56df894d4so3395442a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729621192; x=1730225992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ku0LZy+v53x3KzWmrYcWxRweLTou8zLvtNzv6CVipQc=;
 b=pHYolGo5u4xPGjCqhDKu/Rd8Wg+GPcWsLlvSqKTsGKlPBV9KGncdAf5KA9or3vZEKq
 peqlQqUZsf6AU/euo3jQj4t5QqxZlG919SWAle5BAI8htweN+fApCBQ3TNd2PouTEg7f
 PoIft8txpONTcSQ3tqT5qpsij96VBWKOa6fxztJ7CFvebN+B4BKXLkyRfFiBLQ5HDHYn
 SngvLPh0uZDVcn9ThWXdGbDiDUJEoGWlBf778OM/192Flm7IfmuB8o8ysIRAj3JvdGPF
 ILI7+SxeZpTE25H8r/Ugh6WTaC6kasRxIfYKfKB16+D9Pd2StRQgx13d5sGW274+oqaf
 D4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729621192; x=1730225992;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ku0LZy+v53x3KzWmrYcWxRweLTou8zLvtNzv6CVipQc=;
 b=hghVBEcbP4Te9MrUZuySwghUoieGH8rRqYBdZDFy+n/onx18/bijBehIMHQgjF73Re
 G+zGPtLooOgZFdH96D0wLhMpUbnhMBalzQNNu3pcLBcf+czrnI63Vdid3YXqYnAhjLPn
 Zc5SXBgQ6+B4ZYWX2U7eReDZk4aJOUNYJCNdFATcQelpkmW2Qv0Ettg1EMRvNmG5U+6f
 3q3Jd28dss5YmFteqrE5/j5mDcu37RjTGUOK4DWnKHQqsLL+z5rNVJeajeHq/6PY/7cT
 FwX/ME9Bl9RM0GNh08d5vpZoGrBeJANO3lNn6XNiaZp9HcjBZLDMGtbqRNzMr7LzmSp7
 iIqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJDkfjJlLrnhJVsANbN4IIGsRgYNCr23yQbqJHfPf1P2hdt6+PDGLhLOSS2QXy4TUCeadLLOzucP4e@nongnu.org
X-Gm-Message-State: AOJu0YyPJq9iV40oPHPkoT2xwgp2QeebzJ7lmQcJ31bjSak194KiFe39
 Gb6RhE5IMSoXe8832kSOPfxcvyPh7X4Cdr2jNONGRcQApqRlH0njh9DqnwS9kcU=
X-Google-Smtp-Source: AGHT+IGzlc31lAw06OTVqhw2WDwqyHi4y61pzUSm6iyRnq7BhhjzXYs+xaR/RSMWK1nh1oEWo8+dJg==
X-Received: by 2002:a17:90a:2c46:b0:2e2:d859:1603 with SMTP id
 98e67ed59e1d1-2e5ddc5c66dmr3680816a91.25.1729621192009; 
 Tue, 22 Oct 2024 11:19:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5e20357b1sm1368098a91.1.2024.10.22.11.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 11:19:51 -0700 (PDT)
Message-ID: <a7630078-cdba-43d0-aa47-45faebba6b99@linaro.org>
Date: Tue, 22 Oct 2024 11:19:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/ppc/tcg-target.c.inc: Fix tcg_out_rlw_rc
To: Dani Szebenyi <szedani@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
References: <20241022133535.69351-2-szedani@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241022133535.69351-2-szedani@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 10/22/24 06:34, Dani Szebenyi wrote:
> The previous message I sent was corrupted, sending again.
> 
> The TCG IR sequence:
> mov_i32 tmp97,$0xc4240000                dead: 1  pref=0xffffffff
> mov_i32 tmp98,$0x0                       pref=0xffffffff
> rotr_i32 tmp97,tmp97,tmp98               dead: 1 2  pref=0xffffffff
> 
> was translated to `slwi	r15, r14, 0` instead of `slwi	r14, r14, 0` due to SH field overflow.
> 
> SH field is 5 bits, and tcg_out_rlw is called in some situations with `32-n`, when `n` is 0 it results in an overflow to RA field.
> 
> This commit prevents overflow of that field and adds debug assertions for the other fields
> 
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Dani Szebenyi <szedani@linux.ibm.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued.


r~

