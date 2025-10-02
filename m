Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9601DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PYc-0003IL-Up; Thu, 02 Oct 2025 16:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PYZ-0003Hj-KF
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:05:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PYK-0001Lb-Lh
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:05:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-781010ff051so1126516b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435511; x=1760040311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lG5WbTFm3U8NiJFo5CobQ2Qfh9mEqy+r2CGJCgj21tk=;
 b=Z/PzpwOwo1ds1F5jKYu+sO17hH+mDyDsSb9c1AyFoX5h51SUB4D4RxPDOMnirTyf72
 vnT77RG1D8059oslyY8SgcLIDzyREEnNVeHQEWC0S2vd6KMqrO/SOh3v0z24nrOOBtam
 l2A5UBQ8Ct1S+x5hEVB3ORWrdHFoPMUVTAa6mY0QCvqG1ssLegfFqRm148YOKNMeNTQu
 +oyPEMVdyVdYqJeHcVyaRik4Zdg/CU4I491H7TqaoJ5dnwUk1AxYrYAmOlc8A6GW0iv2
 tCqaDBUF8TxX5e9BDMRdCDMiOCru+Ujt4CRAK3XF9f4707k1fhWsGyaFGUFRZU4DQRwA
 bHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435511; x=1760040311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lG5WbTFm3U8NiJFo5CobQ2Qfh9mEqy+r2CGJCgj21tk=;
 b=QXGycVkkrx8whh2toHoxn3T94MvXkWHWj6a5B2PjOrQ4sJ0TFmQH/p4D1N7R7T/1T0
 VZzdQ0K01atb+OJb4+EejenfhFRoLDVrZWfX0caV5YA7KVDJwvzsrSNLNEI+6PsW6agP
 PGa9rcdjJNmgU2Ubk7VYQWZqy/+LWTa8sC4bjQcBt/sFLbHv13rrMltI9ztJRgwN1F3H
 NCxt6LBPyed0gVdwLThac8VUUZoUBviEF1XlOCt//hP0iqUbLtIB3hsEIEl+IksbhYfP
 K/ff0MZd7d0c5gi3sDe70Byk87HsAX0xMvKde/HRLLEi0m9iZQ7PJc9+F7seurvpktSm
 Xqiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXghnAp/8Qjc7uC5hmUVKFjhIIrkCWD0WT5Z2sPA7qSFXLvu59/Xoe1qLFoqBXhJtGsvhFmThK1BLkq@nongnu.org
X-Gm-Message-State: AOJu0YxbZ2y6VjjHSu8bPA3wYP5imDbAqINKQNEOYqnEY9gFg7iMtKKr
 SVlG9XBzabIqoKYFaVjU75WkXFjw270MDd5g8ypVqMsQDNkznJjrvcVpq3Ofum1Qq3g=
X-Gm-Gg: ASbGncvRZJf1RFd4I1xhI9Tal4J6QuY9Ob8qtCrtlWo7ccbckvIcDdPF0hc/9CsHXRq
 57lqCLzsxbq2fntEw6NJE+iMeeJf7VI9OwrcMk9ZqKzsjgCrihEIACVmtVX6jq7CIVpLVS8Dyww
 VP23972tjQZS1XAN+3uNkthMtUcoUCQaujj0STkk5o7vwF45H5Kfp8zPpx7K30lJa6QBDniloEN
 +7iyDZPrzWxKxI5K5noqFZ7nUdNug6eALqM6+Z3tXezptqx+MwypG9TQVDmC37Yb3j/KENswy3A
 K9fzWh45LeIFv7nhDFpZo3sR3hv0J4LtVmcI/zSgKK8/bIytZBV5wGhqRpgmCB4VE7VJNq/y7f3
 N6VfSInHhyl4UsWVlKUkUR4r7BXysVn8TqL+9rifPZxlGFEqFbxH5oklvlmNj7Ts=
X-Google-Smtp-Source: AGHT+IG8B+EXkoIyWCxymmZFg+Wy+wErrrb1vNXaMJGTtj05z+wfojZzvkfrOfRbzGxETlFEihuE8Q==
X-Received: by 2002:a05:6a00:b86:b0:781:1b5a:95b2 with SMTP id
 d2e1a72fcca58-78c98cc3212mr948259b3a.28.1759435510945; 
 Thu, 02 Oct 2025 13:05:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b020537e0sm2893989b3a.56.2025.10.02.13.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:05:10 -0700 (PDT)
Message-ID: <ad2e133b-36cf-43d1-9725-ec29d47742bf@linaro.org>
Date: Thu, 2 Oct 2025 13:05:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/33] target/riscv: Fix size of retxh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-17-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-17-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> 128-bit helpers only make sense for MXL_RV128, TARGET_RISCV64,
> and TCGv == TCGv_i64, therefore fix retxh to 64 bits.
> 
> For the sake of being pedandic, update 128-bit instructions to access
> retxh via 64 bit TCG ops, even if they only make sense when TCGv ==
> TCGv_i64.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h                      |  2 +-
>   target/riscv/insn_trans/trans_rvi.c.inc |  8 ++++++--
>   target/riscv/insn_trans/trans_rvm.c.inc | 16 ++++++++++++----
>   3 files changed, 19 insertions(+), 7 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


