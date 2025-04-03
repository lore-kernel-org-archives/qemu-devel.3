Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91740C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OPl-0003Tg-IA; Thu, 03 Apr 2025 13:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OPg-0003T8-MA
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:31:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OPe-0007AW-Gb
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:31:36 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso1453790b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743701492; x=1744306292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZTaDmVjioQOvHiurialnVJTfakcHBh91bAWdCG+QtCk=;
 b=OAdWmFUh1l0F4WnVhXlmJDLbACywtsNHViA8bVcnpyfDnCkcfwF/HXP3NLBPG6/1Lo
 TRwZ4uqg/RXGGjFA6mBciU224k68bXpDOlhnIYFWFNdN1B39anS7hF2cr18lP3W+i7TZ
 KwnUTvF4OyEYjAKY90pT1uDFM5IIJJhA8z/dnKjKwmsDHgpyddgEGJBAEfF2OsGGHuql
 ygvNKV5YiisfpR17mUd87gjJaXKPw/41b51hTpqM++zzccFqHltScH+v+3TvzdlbOKWP
 1ebtlVWJRbPMvCufqDXXguPYJGYyuxecZSmhGniAQQINssjX2cKFvP4CBEWf0bJD4dby
 whkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743701492; x=1744306292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTaDmVjioQOvHiurialnVJTfakcHBh91bAWdCG+QtCk=;
 b=KrZUm0287f0bPJXUhIvqPjW6eWxgaToxIh5KGui1+cOZqzT66Zi4ZUfZ3Pi+Yl+otH
 nLe5fhJX+vPhauA+xANa04uXCqWb+rGDEWjHlRAC0CLbuXqBsNgKmtdaLe/JbTxm0aaU
 8Pf2AFUTeE9/fDUgvbUH31o2+weINjVtuudwtwwvQMqYkn+c+f36sHS+wRgOrxi2+ovg
 ymnHVEjOZbSYkdrGmGy5zH8EiaM/WZW5+XXzZJ5dZ3YT6LEucCyS4BFBYW5VQ/5kmCiS
 uQNp3AMLLYYf90oz8GELvRWlTaw9ovisOaz2MmkqQb1b15nzswza0nV2CGMEbVFH7cPQ
 xcnw==
X-Gm-Message-State: AOJu0Yy24Pef1MBUeKmtrdQ8S/dJpiGwn2ifhoOmy6FZ/A4xFwC4iKRW
 68OvQ6w0pEHrNXwL1dSdvZuFe2jHQ4Hs8pFcIkVXn2m12+qMJxFZbNcsjy6qFpGniVjPRORUhsV
 X
X-Gm-Gg: ASbGncvYx6b5kzcmqB2IUvu8fqFF2VLdsc+mZ/ZPH4rW+FBBLZDQFo54eejfseGeAGf
 e4SAVAgQ/uYCLiEOk78+d4ulTtrk93axWHMseHIJm89ZKGkks8v8V31n0xRnzI4ZYkkX/R+Q2XE
 a34PBfD9YUTXZVmnXrsKZSg1Lo+xJVZS+1h5NsKZ7roWWSnVqK0dmytQO20jYnBYKgmApQMWx4h
 NHwbJEibTNn15lLr2SLAyq5Srud15wI0q4F8jNuf/HcLiDtjTkd+HuiWT5GPCutdxap5DedhVTp
 2LheRBzITJMA3Ik9PrI2Yj3KX8VErz2MUDEYot/o9NLG8/7/2OJgP60MLyw8UBXd7Mm4SXonRxu
 yT6acjkFn
X-Google-Smtp-Source: AGHT+IEtcZVwUGJGegEBE1hIFgOstTTSqhON1IUNk+5gIL468J5lcagMSJpMLWId7J+Cf31j0l7GpA==
X-Received: by 2002:a05:6a20:c88b:b0:1f5:8748:76b0 with SMTP id
 adf61e73a8af0-20104720fecmr418461637.29.1743701491930; 
 Thu, 03 Apr 2025 10:31:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee713sm1822049b3a.51.2025.04.03.10.31.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:31:31 -0700 (PDT)
Message-ID: <c68cd058-851d-4eec-8edd-b6294c3ad362@linaro.org>
Date: Thu, 3 Apr 2025 10:31:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 02/14] tests/functional: Add a decorator for
 skipping tests on particular OS
To: qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403151829.44858-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
> +Decorator to skip execution of a test if the current
> +host operating system does not match one of the permitted
> +ones.
> +Example
> +
> +  @skipIfOperatingSystem("Linux", "Darwin")
> +'''
> +def skipIfOperatingSystem(*args):
> +    return skipIf(platform.system() in args,
> +                  'not running on one of the required OS(s) "%s"' %

s/required/prohibited/ ?

With that, or similar wording,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

