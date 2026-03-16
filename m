Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92658FB5E88
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 23:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2H6u-0000v3-I1; Mon, 16 Mar 2026 19:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2H6t-0000uZ-3W
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 19:12:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2H6r-0001Sr-CT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 19:12:30 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso2729260a91.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 16:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773702748; x=1774307548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=l8Ibq64nwCu6z73FszhoA/0pJMUfY9Lti1VEYYHLDng=;
 b=gcZNXg7ZnOhiq5ym+cUkDBrcJiVOSnWkqARYbsRJIvI/2kR9sVfw8VcBukLABNmj6p
 km29O0eNNAm8dWfOgIjk+/PP0pnX/7vdSLmxQTytHV02xXz0dROQLUlnrIz3KhWPAa73
 hMxwNb0QMjaUYoGE2KhZA3TS095KN3eccMIhAjXd4A8p4pAQ/IcUDMYpZWqe0I6W+hSo
 U+N8VgNMUu35CLWlYUnmC7qmBinn+WL3aW/9QlHwhQNmMHu9+r7Aiduzoe+lNnj1wpbT
 0keMWT+GFIpg6tHvt/InFXeJBADc8JnkXdOEGbYwSUcaKrd8pQe4iAOPNSd254aKjMlk
 Ojhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773702748; x=1774307548;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8Ibq64nwCu6z73FszhoA/0pJMUfY9Lti1VEYYHLDng=;
 b=RdV5nXY8IxnR9H0DnNzi2Mzr2ymNgKVL/Ki+dPjXzRhxSMbAtBZeoOjzCFto678aeP
 WJXUoFNAyKS6XCf+M0+EDnuihzK2Q8MRbnoRnMjbBQoHGWWdU/Fp1mZizKuwXb6JBy/P
 FhAbOpZWoLt7h4gK3/F+cTwy94HvRXZ69IBv7uYC9M3rw18C7YBXqlyobWNc7kYXliPh
 p/0IbWyyvXixoTkvdWPAyGrZu0ZWmJgLBO4+dODBfpN58HvHzsp/C/+80hl/UxKRUwLe
 Pj5N4X7CawbZmBQnI4sPq+xiXIxYhsBBTWcxyOmqsqVpmB7F4ynogoCY4Fj6tnGf2ad4
 cZDQ==
X-Gm-Message-State: AOJu0YwXsz/VBnDqmRx6PlkAe7oJNKDdNZlgQg11rw4knkRuJl+nNmSJ
 dg2arf1n8xGz1IUANG9gZFTgPtNz34QFfQb8dH0laxceO9BMqSt0fEMChfOwF3YRiUh7A9rb+A5
 9IAiLPiA=
X-Gm-Gg: ATEYQzwR9NIko8TxQg3Y31oCNzFT82wbXdc4SciMAttMnuaxK4kPxyOV3UN9me5v+/X
 w06YsdlxpEK8Vh5TkcZoZY175m0gYtEOw/FZpmNlnpYDQUXDXgBFWP3hGqixEjPNztanMPBj3G6
 5gTwfWmUJWNRvXRzIPYzrKRPBCCL8opOkG02wgQsT/4ZhdB5w2hwmU6jM0k/cnkH82SQnx8Tbqn
 QcRPoriZNszrgq7Gd+3ekzKd/ZYEnpRl98/c9TMKOAfFOr3/OyqnMH57LX19yCW3dPX3IG+5NlL
 lKWYnvCm7/Hi3h/MeofCcUigpuUYC2vrZRKP0xrafvxQi7NeqFuTKjgjaiLp2YzVcYM/fNjVZr7
 Ns09j4IBGz0VGhyXHJMd1chwTnS4EEzncGNDr74+L+tszClHKYmUJecbUSOZCDczS2SVu9d3Xsu
 CErHtIRkOrOxGNrUgENFq96eOohta6tMXVk99KjFOV8IMtNkTTQjp8XRGU/qHkacNopqMZ
X-Received: by 2002:a17:90b:3a45:b0:35b:96bb:47ba with SMTP id
 98e67ed59e1d1-35b96bb498amr6057791a91.26.1773702747492; 
 Mon, 16 Mar 2026 16:12:27 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35b93d07292sm2749756a91.0.2026.03.16.16.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 16:12:27 -0700 (PDT)
Message-ID: <c803bdaa-3473-41af-b2b1-4a41359956ff@linaro.org>
Date: Mon, 16 Mar 2026 16:12:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace.c: fix depth for exit events
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Honggyu Kim <honggyu.kp@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260313063441.2048882-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313063441.2048882-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/12/26 11:34 PM, Pierrick Bouvier wrote:
> Uftrace plugin was recording wrong depth for exit events, resulting in
> incoherent traces, especially for partial ones.
> 
> Thanks to Honggyu Kim, one of the original author of uftrace, who
> spotted the issue.
> https://github.com/namhyung/uftrace/pull/2031#issuecomment-4051762627
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Auto review to send this for hard freeze.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

