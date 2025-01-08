Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFB7E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdCP-000430-C9; Wed, 08 Jan 2025 16:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdCN-00042n-Mg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:02:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdCM-0008Gw-5b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:02:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43626213fffso8587155e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736370160; x=1736974960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OPa3xwd7BLWXSGLfpOs5WzA4dsyKTu+0Pq6NgIqYv6E=;
 b=DZ3rQEvqzd6DgDfiFGN9vjtZT0n+AbgvAVjyHaUsZlW6z1Aj5njge1VfrD6Z6C07Ay
 l9qRsuPZG2MgKVdecJE/Tb9v/hOCx/0X9YnIOJfnynpNR+UU4awfcXtnNUOtHlDOs2j6
 jZLFNVAj0SsbzauxkwL7pjhkuVQePttOkErHo0o3aVvc0yroBMJBvx/nRr5Gt6v3kEV7
 UraGiMnYZVWI6uAH4n8QTxyRhECx2Sx8NTaIlf5ZGzPe5cfThdIiK9Pgy8xP3db8YPGL
 f6Ml4iRPc4umLRwYV+wmCQ9qzwfbGO/QjhOK+k2t+M19JV0PIoDywB7Ph39fj0J4F1f0
 lrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370160; x=1736974960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OPa3xwd7BLWXSGLfpOs5WzA4dsyKTu+0Pq6NgIqYv6E=;
 b=E6f4aNPBy1mVc9fUC3tMmkhEmW56bRnwaYu8vpqA1UJg31pEiQ/2BuWdFflR6yeFeg
 7y47WqKj+kvYHXi43+XHvveiN68jNy1I0KGGar9tKnPV1620dqGVxyX/FXnN/zijDUnU
 +Z7xiIwvvL53uM+PJoZVMLgPahtZU/PDKvd8rZxhpsg8H1+RrcpCXn583SYTFoIFIrxO
 Vu4stZYqS+MXhph379rsTrWRqOWwfqUoTYys2nFSrlIApo4AgGN5mmhqYge+rprUgpVy
 OPWFw6JOFDE5N858epMh9+kqk/srzWExB1tmVaXmjCKseyyja6/WUKIyDcnex0EYGV1Q
 uQnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUw/XDTohs/AEUFlZppXwXlJc4yfjxJL9ap1/PiXD907H0VeOZdWr5pTyarN0D1x5xRONxGQ7JzFnJ@nongnu.org
X-Gm-Message-State: AOJu0YzLK/VjbUTulhMOHV+tJNu7nmB1ekAIds5E1TDxYqYLXJqlMQUd
 IwPzQlMKMsIpNFmyeg5mzUAg2ojKApggGGrLRNQ8vnqGw80yqaNhQgYr0iHi2rw=
X-Gm-Gg: ASbGncv7NDdXC6RIKizOTZAnONl7PI6eLGbsakcGvbJ2ZQAic2UxmYbnEG4Bkl4ptWB
 xJXMW4piivAlyRco53K76gkYQQOWy0yGbXqOKLkrv428FOjOg+f15Zuj5goVzrsIA1AwCQ5Rhxt
 y687dkG19XeUG7PH8DI8GU4Hqf/a6UWDSWFt2gdHF08mp6NKFoQidFUVw8gPDsOESdeS0pCVLcP
 10emKcesvFQgSLKBDc+JqbnYK7hBr6a8MS+tzlP5ST2r9HimtXiSs7RBwoflsWN2KCrWZfHsJp+
 dM7k9Kt6CmHKm8vlCVyyKrei
X-Google-Smtp-Source: AGHT+IF6U10wDTWbIMHXgHIN+Kv/2gl1XmhjeFKLF1AE4vlZDWCfwPBdo3bZgi2PZiPv+mQfZdHTZQ==
X-Received: by 2002:a5d:5f91:0:b0:386:3afc:14a7 with SMTP id
 ffacd0b85a97d-38a8b0c7177mr540001f8f.7.1736370159959; 
 Wed, 08 Jan 2025 13:02:39 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e0215esm33053265e9.28.2025.01.08.13.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:02:39 -0800 (PST)
Message-ID: <515bd4ac-a36e-4b5f-822c-32c15cbfe3a1@linaro.org>
Date: Wed, 8 Jan 2025 22:02:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 77/81] tcg: Merge INDEX_op_sub_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-78-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-78-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 7/1/25 09:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           |  4 ++--
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                | 10 +++-------
>   tcg/tci.c                |  5 ++---
>   tcg/tci/tcg-target.c.inc |  2 +-
>   6 files changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


