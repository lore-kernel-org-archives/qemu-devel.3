Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50A8D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcP6-0008P0-2u; Thu, 14 Nov 2024 11:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcP0-00088t-2Y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:09:03 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcOx-0003Td-Qh
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:09:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso5963585e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600537; x=1732205337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uRbudzxjvOjvh17i77OJUOFln9vHlmvdUzGGXOeVBoM=;
 b=vVAb4dFaim+uACXuLF7O3Fz6ZvWCLSGm9nS9xKhpeFOq5KCrncFX/M5PJdXLtsSAYJ
 sGzSDS71FaUS/4yavBQz2fZCveuXWGM+u3o5ayg1Wn/ELpJ7elLNRqGFmBgx2JwIrkmh
 kNXJYhzcplSEhYdLg/QMrXAQdmqfclzc6EzkcOo0JwW4fxnUxq7QBWH7XXeTN4bfgG0P
 QPwe4OG74bBW8SB+LTHhdbPbmlr3g4zaL+kVtPclbl+J/cU1nJiqa0B6rSi4CfJLmbzW
 mTyxq7FIrw2OZZjtT/UkRLHVTSeX3g182qme2d/UQVNNpEikYggs0/uWM+VuCLcWocpK
 ligw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600537; x=1732205337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uRbudzxjvOjvh17i77OJUOFln9vHlmvdUzGGXOeVBoM=;
 b=jTagkPIM+tLB4Bc+wra5oILKrco7sbvm5rxiREC9Rfgfu+wHo/aSOaFigXiaDAJ9eg
 hJkzxT+0GZQ+sQDhoxKY2Ie5LopLtf+wZKqWMi7gMclm4OZnw7AOXJxQnjfutvLB1FOx
 /UMtbxGsLJRMtpB3y+ceveOh9S648XiTBY77OlcMeQkqj2sh7rpg9aqiHn1zpJgpCknH
 8mxmm+goV1PoqhPAlkZwEhEOUz4MQKM62YFg+D83W6CNHgh14s5v3VAnH1QOs6NkvTSl
 SeJ+x0jqSp2wfk4Fvq3XZUXvQevI55AvvB9e1tMAHcO78UOl61g9HsfPvAn49eXXlqrT
 UkkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmhbVXuCxnX4L81boRCi9jGiLBfaAmGKldnQ3l2XXvzEs6MAFn7j0Xvr3Py2LR7TyOvlvpp5ExNl2y@nongnu.org
X-Gm-Message-State: AOJu0YxbK8D7AJ+mU+OZPFcU4dg+Yy7OuYhDcEgIf7Ymc68KxjwLBKPW
 wUJVDKJO3Fvrc+if8uBT52vDdEEx6bTXCnHK17n4gOw7QAOWu3wDLlfRaw9t1tI=
X-Google-Smtp-Source: AGHT+IFtj+sQe6gXh9ad87pHl8AKUHYBRm8jttpa3fTeJ03mwhk01DUgIlBTkrQ9sHD3/H23KqxhUg==
X-Received: by 2002:a05:600c:1907:b0:431:52da:9d89 with SMTP id
 5b1f17b1804b1-432d973dd20mr37922455e9.1.1731600537028; 
 Thu, 14 Nov 2024 08:08:57 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1f409sm24647175e9.37.2024.11.14.08.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 08:08:56 -0800 (PST)
Message-ID: <87e88f4c-3ca5-48b9-bcb6-5444fe2471b3@linaro.org>
Date: Thu, 14 Nov 2024 17:08:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] linux-user/loongarch64: Reduce vdso alignment to 4k
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241112203757.804320-1-richard.henderson@linaro.org>
 <20241112203757.804320-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112203757.804320-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 12/11/24 20:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/loongarch64/Makefile.vdso |   3 ++-
>   linux-user/loongarch64/vdso.so       | Bin 3560 -> 3560 bytes
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

