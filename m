Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB004D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvxu-0005XF-RK; Tue, 26 Nov 2024 08:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvxs-0005Wo-Ux
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:50:52 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvxr-0003AD-Gs
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:50:52 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29645a83b1bso3436460fac.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629050; x=1733233850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kWG8kpPdyMFpHGdoYW3LZdqzNMbMZaNdMp4KCdEz1QQ=;
 b=dKxqSvWy1TnnEdQ/kG9WWF1YfLrW82PuSfPycEzoHA8g9hfPiK7j9YdffLmLUdE4cH
 QM2Fj3x/dn8M4lwEy5LNIYWOqPP4tjBPP4a83LOvxYwFrJI6qn8BS1fP6O0K8VzbRKaN
 ezojJZi3u6MEO3ZteCATvaOwwqsGVZTh5E82EBqDAKfGumjSAuskMhS9GQ/4hQjjeUyd
 421JvZ2MdL2Sm7vi5VDHrhhXwriRoX5IWRFyUdubj0RQYTedZhWXqghCoUbCqQB2h7yf
 GeY0hcNpxFSui+vg6DVxGiBC3mGoq2eFchz/NIL6Qa4j7by4mR/2SbyuAm6M3Sd2lB7w
 vnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629050; x=1733233850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kWG8kpPdyMFpHGdoYW3LZdqzNMbMZaNdMp4KCdEz1QQ=;
 b=vb3To0EnFN4q74D3fSnGyUA4HnNwjVnLmAHPXaL5pogICBZuRtYfS4ngAkwXYn+tjZ
 qFhNMpURgYftBaE39zmXI7m6lWsceYYePuokvc6n0RIi70cu2hnii8+dMJ9MtJLMhloP
 WS0KAkIr7pdRIGziX7nZPZ/ST7jRIppjozTAgS8AQX9YKxfr16Iq8fGoBL+gNjHKB8v9
 0USDwPOt05+3EGQWMurKFUJ/Rx/l5Ph5aV01gieH/zaavBbsquGP0k40RY5TY8W6lHxQ
 NIKumUxqodrEk9soq8KEDrNvGva9XFQq8oDAB5J9TlHEunv9wHeyEO0/I7DQ1lw5Isrl
 m5Tg==
X-Gm-Message-State: AOJu0YwAxPXzUa8ojVi9Zx/CxtD2fjsPZxKoxs/F1Y34HrRHizeF6JDE
 HSM3Bs2eLQJCiijtbUGuI+0o2cf3nQG+kWp3cAqIcHX/SOK+8z/+zJtpEOBS84ByHRvbCqHrli4
 7
X-Gm-Gg: ASbGncvNaUkTkZonwmJ+iU9iGSuCG8IuOYGObNPkJJEO2hAHG6A0VHZ7EAB66SMVgwj
 A7NZRyrMAv//MCv75Lt4bBhbE/0x92qC2BTOv2WRAznsCrDZLHrtVBf0qITn20mb6g4aM1Mr6lm
 SccvKUeAaVlNjfpRzVZ1dHqL9sjkgvCPWMVOOS6dSQRCxUOXSzpbGdwU7mat44tMSN+Dl0QYq0q
 fk/x8MWaD7mVvXjJV0ggBHXIEFDrt3nzJA7f+vmu71ycbZ6UFVUCarjvJtUTpnEhA==
X-Google-Smtp-Source: AGHT+IF31TGrg2yB0FYmgHiM+SVyTfUZ44zelvyDFfaB02a4Q2UL9jF/K46OZaZ+KVV/6yRm2r2jXA==
X-Received: by 2002:a05:6870:7d0d:b0:296:e779:f912 with SMTP id
 586e51a60fabf-29720b8e632mr13653297fac.13.1732629050262; 
 Tue, 26 Nov 2024 05:50:50 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d889d0esm3949605fac.48.2024.11.26.05.50.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:50:49 -0800 (PST)
Message-ID: <32383264-401d-4221-92b7-389849548a7c@linaro.org>
Date: Tue, 26 Nov 2024 07:50:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] target/mips: Rename gen_store_gpr() ->
 gen_store_gpr_tl()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> MIPS gen_store_gpr() takes a target-specific TCGv argument.
> Rename it as gen_store_gpr_tl() to clarify, like other TCG
> core helpers.
> 
> Mechanical change doing:
> 
>    $ sed -i -e 's/gen_store_gpr/gen_store_gpr_tl/' \
>       $(git grep -l gen_store_gpr)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

