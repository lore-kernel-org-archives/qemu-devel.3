Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC4C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6vC-00021Y-5x; Mon, 17 Feb 2025 14:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6v2-00020T-Uu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:36:41 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6v1-0000jP-Da
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:36:40 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso9471462a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820997; x=1740425797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9+xnPYV/Y2GCTN+4P+3j7PfZxpOj4ENew8IpS/+IoKE=;
 b=RxndN6m/V/p3JmMvHbt3QK9jfMJvpyzMyDQGm//pt5eynbulyne92NBh1c79A1/hQn
 bHEnbYYPWau5kQns0Nl0u0LILs7HCx2kKzBGA9+M4fUsVB2KwaarySZyKb8C1/RnH0aG
 6Md2ELJp4vrAwO8E9bQRUIX3Gqk0n4hDL3Ab42zmzxS0fJGSFap08YWmB8geTBqUS4GP
 cNFWJNVt32gcMTqAx+xRoiiOBQRpvd4wM81+GCXLJ8vwBd/+S+JpohdnyfVTh8g7aZsq
 CBONVz/BZljhm66M3jR502BPvdC3+fg5iqyQWn0xzSBM/lxz87stspHrjVV6BlnvIIY6
 788Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820997; x=1740425797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9+xnPYV/Y2GCTN+4P+3j7PfZxpOj4ENew8IpS/+IoKE=;
 b=dWd7z4NAE0fzfRS7lIZY0YQS8csvOE5rJA3tlla275a20UCW+f+CGAX/Fbriz1EbZ7
 8coOoq+P9qVdJm8TFftzCzZK1iW1oyY85hR6AiAg/LKiYObBczgRrleCn/DJ/crZtgAb
 neF1BzHRIarBoBUxb9hDbWYxetrQQj6xXwBBApPySPf7leKXZHof5n49jzHxSpevBy2e
 lvlzvl/xtR4gAg2DQhomn1sDxTaUyVI8zTRjs2yAB23c4Tk2/PrcUoo76JF1DiVfiLSE
 ijEs+P7nrGNP3z4ld9tY0s9atQ7JRyHt+JR+JNpqpnE6Rke2F9zEiP5rntnl9M3bHEZr
 Bzkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmeOMOE9Qb1S80Z3uC/HphPTvKoGdE8C/oYGP+WIwa5Mjv7EOux3Rqa4eA6wUM5dUacK1oawdShFYl@nongnu.org
X-Gm-Message-State: AOJu0Yz1x5Syp8GgZZqeUJM1QE0fIN+F4GlY0bgBHcxZnSgXsTK6n4Qt
 +qZzWyMbrJoCIxd74ncIUFf6sWjgpeou3TDPpCDlyxHt+p/gWv+5Mn0ONfDfa4A=
X-Gm-Gg: ASbGnctFy/T9i5QaUW45dS8AZCryLt4DenjagusptIkRo4FyhaOkEFTv3xlQ/Feaos1
 1Zn5j7Tnc5Fs7/H/tSVUjD8SOI/sRnVpW94SZel8qmBbHfu/gtyKnrMf1hljjJPP6Ly0TYtBAIw
 vfMIEJt5EsNdmqgLTJKAStEjcNKnaqKdZyHXFOgrPBOuV9lgIhYMaSuI3xdiTfsD4H50JN/2Opa
 IATn7+BfwFwn4afBo/c/ix+Z9ACDyvpFo4snbQ6jfeCF9oHoRDH9JtxvBWfYWADf1sAbZ6Z4fNo
 1gTWKNuQa81o4tqhrEUDVStuEx4f1iRF2bJonsPt+0JdfmaOWPns2eY=
X-Google-Smtp-Source: AGHT+IFtyK2Sz0sNntUpl8+tHHKVorMnT+4XRRSRe7K5GlSsGwObTmtlANrqU1BWebvUP2ew0zk+Lw==
X-Received: by 2002:a17:90b:1e46:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-2fc40c1b98emr17124630a91.1.1739820997569; 
 Mon, 17 Feb 2025 11:36:37 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5590770sm74660925ad.231.2025.02.17.11.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:36:37 -0800 (PST)
Message-ID: <67c6879d-6213-4204-9dff-183c831f11a2@linaro.org>
Date: Mon, 17 Feb 2025 11:36:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] accel/tcg: Include missing bswap headers in
 user-exec.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250217130610.18313-1-philmd@linaro.org>
 <20250217130610.18313-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217130610.18313-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 2/17/25 05:06, Philippe Mathieu-Daudé wrote:
> Commit 35c653c4029 ("tcg: Add 128-bit guest memory
> primitives") introduced the use of bswap128() which is
> declared in "qemu/int128.h", commit de95016dfbf ("accel/tcg:
> Implement helper_{ld,st}*_mmu for user-only") introduced the
> other bswap*() uses, which are declared in "qemu/bswap.h".
> Include the missing headers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/user-exec.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

