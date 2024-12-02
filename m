Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7D5D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIA2j-0005Ns-G5; Mon, 02 Dec 2024 12:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA2h-0005Nj-Sc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:17:03 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA2g-0006Df-AD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:17:03 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4668978858aso32329711cf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733159820; x=1733764620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VaOPkThrxi3YLKAvg1L/DfXQJ+dlLIhrSRg/rmrlYx4=;
 b=qaXi1854+K7MXOZtRqbboA4xlqNgQCpW6Cj156HT9/0uZ/zCpxxLMJj9qepjsiMgTK
 sJCD6r6aH6TJbJmH6vW+GTL0ZC7C1i8Mepc9wY1vah2JrLohAHU5GjD95B26GupDl+rx
 Nove615v8OmFxnPcqFQQqHlBCqCSPdhnBch57JCgAJWfKgQCKPMSDBbhktpE5JkVkWGY
 LTUgDEenlRiwZKwEOABYXQ48WaEKrjY+Cb7FmbJiSBwoXHPbzFmNcN2UbPj+/5daKBHb
 CZfm05mnbqr2gzQEnZl6TS927TuMlHnjsJVy2OWU3uDAelZJ/Kn3jhQLRKtP4fpxVK7i
 avhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733159820; x=1733764620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VaOPkThrxi3YLKAvg1L/DfXQJ+dlLIhrSRg/rmrlYx4=;
 b=g8WGmoDg3QND2NQc7zoXlPb13xpixaZnJNbplLuG9ZZis/KXiQSuHkOZUp+lwVqbfi
 L+9ruHps0HWIk5+eBGgdV2IJGHI7qbgo3RrbNWVHCFSJ+FhiB7sLhMBdYLybbCQnD210
 JjnEIZ0FWuy14BNvb63O9+4didsI3tmSFGuOSTX1wqh6FZiFqK0lDTTNfUymZ5U/byI/
 fdKsFmv9e9JW6Ylvnlp1+9XwxmLKVZXxgLOCQzL6cNEcS7/dxOw1RVcYbFz9PbKfNj+6
 HhVcdWbjN/ZOZViWpM+sLslN2CETDHNhc9p583FhksTpge6VCEPb9QmamH4JE1RAybuM
 Yy5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU80RGV2hCzSMNcbEvcmVxx9r/hLgy02MpZk7/iUmnPLkhBuVYdjyOYEbVNQ6/BdeA8iGrY8KInRY+f@nongnu.org
X-Gm-Message-State: AOJu0Yz2MCMKLM684oHqlMGs749qFeoQqsgzCojnMfp47z+L0n09FUNy
 W+Rjz4HAaT6n+zOflIdVx+ZeBl/Ne7MTbXG8wOstEfxcGDD8p5nvSgU4I9gYYgQ=
X-Gm-Gg: ASbGnct4xpkXdJQbyVQDqKEJpj6SikzMVR/WX6ZlpOEr5lJPLRWbsiJBNziJHf8dsJ0
 or4+9cxRrgACq5z3effrEtf6UeNkQEzSLwOnoOjrZp5BpiUrHY/Sh/62vwN5I6TTxO0i4GDp6Hp
 XugmR6Wo/4ulFJ8ZEZ8lKNwIoHZY7mQPdSWyD0g0/FKdMSNEATC3cuq4mtEyXAG+atu5DGTlOQ0
 GRvXM5cN7+6l5QlU7nZGq5a4EjNp3gh4h3lxWOO95EhVrN91YT4wi4YuM8Xx3pFXWfn1sU=
X-Google-Smtp-Source: AGHT+IFKHlrHmTHePpvXo4RCXXgp3IIQZXJ2r5aRmtMIQRSTPZRXPpxUmd6n8il2mVK+R0je+bWaXg==
X-Received: by 2002:a05:6214:d6a:b0:6d8:a092:47f6 with SMTP id
 6a1803df08f44-6d8a09248b2mr111716026d6.46.1733159819943; 
 Mon, 02 Dec 2024 09:16:59 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b684942096sm422898585a.49.2024.12.02.09.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:16:59 -0800 (PST)
Message-ID: <0e419e07-7a43-404d-9b58-119e9728ec69@linaro.org>
Date: Mon, 2 Dec 2024 11:16:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 27/54] target/m68k: Don't pass NULL
 float_status to floatx80_default_nan()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-28-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-28-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Currently m68k_cpu_reset_hold() calls floatx80_default_nan(NULL)
> to get the NaN bit pattern to reset the FPU registers. This
> works because it happens that our implementation of
> floatx80_default_nan() doesn't actually look at the float_status
> pointer except for TARGET_MIPS. However, this isn't guaranteed,
> and to be able to remove the ifdef in floatx80_default_nan()
> we're going to need a real float_status here.
> 
> Rearrange m68k_cpu_reset_hold() so that we initialize env->fp_status
> earlier, and thus can pass it to floatx80_default_nan().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/m68k/cpu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

