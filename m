Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDF3CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OkO-0005YH-5s; Thu, 02 Oct 2025 15:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4OkK-0005W3-12
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:13:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Ok7-0002tq-Bf
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:13:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-27eed7bdfeeso18193735ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759432406; x=1760037206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sy6C1YETPjlsStjgJ4SZIG7nbW4id5Om7Rm7WDPFPq4=;
 b=yviwOo/BrWfUW8VwDnEZF+k39VGEuvGpf7L0Hdrt9xFf2AnVJ3X5n1dLwdgobL1Udg
 pBmJqiI5sQE+RS7jjdgky4MPRHHSvVnPPjEYmUfd6NdEiLNd3YSyIcskJSQ1Wk7U4cgF
 tED6INVARIlKp2yjVqBIpEHRWKWT8CH+Ee/+oMwC3VpnTsgcMe27SzNSlJ6yADaSj+MU
 LKALRpD+S+Vah6EIT2H1vQPrGyTg16MVrUUY1AcaoQUqOGkKtMI8d003d3XyPEtAT8Hh
 xnb3ROOm4sAM//fraVKegtHrlDBO+B3l8Fs9QskZuX7HcUyZiTrixJY9XGsvy5Z4/YTE
 zqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759432406; x=1760037206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sy6C1YETPjlsStjgJ4SZIG7nbW4id5Om7Rm7WDPFPq4=;
 b=FWrYu5jTqqrIO/fgJPdrYgi3aqZ4ZzoajuJY2gMibCJfuOHieVXhYxpndkjFzw0k2T
 fXrn2qslmoEKr0F88G/EhQBRnHY8Mc8pH4Om3i069zTWxtJJQHkJlIP2usTy8DdErLR8
 XQtLCH+kCArVNkzSfhC+dLRHCGvkZnIlB5/52cMTdA5H+DZfvp0sYGGGhQg5QE1mwOk9
 a6l0/bM34FMGEPL+uM+hfz6RVgT2dt/SVcMqEa6+fj3GuuEbWvJrbPej3L8oFUlnyPVg
 ZOMtASWOZRN080gp8GPrD/zhZriBdwyDE0+hgC2fQvnKqnmTgSNSAhliXDoqlBWLKYkG
 i0RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXagmcM0JZMOg9gDf9OvmIHRcloN9c9IpWEqqjUmq0p3kMaTmi1rjbUVAY8XBH6rxC9sHLoUMKNbOuV@nongnu.org
X-Gm-Message-State: AOJu0Ywy61HBWWdCOmr+Ket0nWapFTvNrdwo6+c7Zb6Aiu6azq/88Jyz
 vUuYkEvHKxXV3G36YaDC0J1dY3LwbeWIUjLn/umkaBGNcuB1Y07Qo5a5gKmV2fsPnxg=
X-Gm-Gg: ASbGncvwFmiPhR8brmlfTQP3wPuyB1jkFOMM7ocEEon24OCFKQi0cmthVjQ3pU05a7S
 TpytmehgTR+dyOLVQL1zLI/WGHYnpSC66kO0xbtPWZwhwcZKmcRLMxwiEF3eZZFgiv38nuxpPWf
 pZnW9hQMS1Ye4BUo1cQsiqL7oLqQtINsisRMNjkjV+AySPOxUGOBOiR1HI9WnnBKo5ul3pCtBh2
 O50mO/pbX3ns9bnfPwSjXOmf/7HnMjlqeXq2PJMzAV9Ve13xvqnbjJPskHalAkKAyhM9uTZswgI
 8WKj/XiE9c0Jeg6sh7FAmSgt+SbwznA9BErQbyqLVb5XspJ23ReRUf9If6GMehm4K033WhG+up+
 Xd5UW/QiOdngg1n0JJ0GthRSLsLz5T4lST8rvXFWUvk1k5nsGjExsR5FG1LA1QlleFhYu48vMeA
 ==
X-Google-Smtp-Source: AGHT+IHUEP+T9yRhsz7JWwSaTsErIZo+GtzG1u6/oLelAs7Kqgd8k2rQqSf9D96iKJ7hEvthm8OqzA==
X-Received: by 2002:a17:903:190:b0:271:9b0e:54ca with SMTP id
 d9443c01a7336-28e8d04f303mr62321315ad.13.1759432406289; 
 Thu, 02 Oct 2025 12:13:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b88c5sm28193955ad.70.2025.10.02.12.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:13:25 -0700 (PDT)
Message-ID: <954bb819-9c25-4dea-aaa8-3672820b45d7@linaro.org>
Date: Thu, 2 Oct 2025 12:13:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/33] target/riscv: Combine mcyclecfg and mcyclecfgh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-7-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-7-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
> According to version 20250508 of the privileged specification, mcyclecfg
> is a 64-bit register and mcyclecfgh refers to the top 32 bits of this
> register when XLEN == 32.  No real advantage is gained by keeping
> them separate, and combining them allows for slight simplification.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h |  3 +--
>   target/riscv/csr.c | 28 +++++++++++++++++-----------
>   2 files changed, 18 insertions(+), 13 deletions(-)

Clearer on this patch.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

