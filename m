Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF41E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTpg-0002qE-TU; Fri, 06 Dec 2024 03:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTpZ-0002jg-KW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:37:00 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTpU-0000a6-EP
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:36:55 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862df95f92so203623f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474210; x=1734079010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QCl3PHmt6qlGcM3ZvZDaCsEoIvJJJgXeqbaj9gb5HVM=;
 b=b0udav+b5vvr3nK9fCEEkkdJvRF5Guho60exIjRgBfeKdg6xRZedKQHGY3Te/ofgoH
 W9S3oanRTv+/051PZg5PTaGYsQw+npcPbykfswAip2MyRO7NjF6QM+jS8KF728UCvrT9
 syvEBdRToX1BjT6TMbEON9ADT7DrQEEYfBtoGwyegfeMqmLv7xT9wfxJZhK9rPYS31Cd
 aq6ecm7LyyI2u9ymdo16KIUrLdd7VxGmupVXxdUYbcgNlyj1oCNUxtQLtJhKZCAkSLpG
 oUCBwYT6X2kEyxFOX9XB4Rexml/1PWMibWlDKts7Do22A1NPzG4siA6hVswB6ZQRMPpe
 wGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474210; x=1734079010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QCl3PHmt6qlGcM3ZvZDaCsEoIvJJJgXeqbaj9gb5HVM=;
 b=HmJrTMHuITSyAfntLe3FuTP87Iq6botiTq5jX8Mqid5ljGoy302KWlvaDI7GujeLHX
 ylC5GNYYIxJlRju7lce1cs3X1+a8qBtVOLY9OdXtWWRUJYPKenv4zu3pL13rno3iGezb
 8k4foGIHsfn3vp01VFsLX2zThlKzQPoOiyn9D3jUpPgkX033wgfIuYpiup0pJ4aiLEoX
 ozsRMp0MTviRaVcqWiR6u9N9fT/KjARL+6AUwD9C6mzhu4tUjSl4HtRv4fcqYdV7gVy5
 gNlSOCh9AssBXQpfOYOdhGpQOFHyNlMVGD6tuS6JZP9DidRz/mahmToLbUTLbYwEzukc
 lazQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk6BtON1vuhOPq8pv1/MuP4TNFLLHi45nfXxMHgjWYiLhkqHLoPays0UUVn4D3P4BSoDwE91RLrd1r@nongnu.org
X-Gm-Message-State: AOJu0YwxjxFcTaPvgZvP/M2AkyjLdT7B6emvRBRLdhHzQw8sxFFeMyWX
 NaEMsSyrhHsHa336+5OUuzGiUAJHejybwtJ242Stm5bgI0daYeCglAG5ign2uac=
X-Gm-Gg: ASbGnctk/Oc8I+JxlAaD91yRXYZHuCHan2r2DzUYUIZs+seB7E9EPGEVm40SpTVQRHl
 4cRGoKFItrC3RDboo/fJE7foF96FgBidrAkSbH+/QxnrsY0EGFVFTCHTz9jXu/VrzpKHOgxUZvr
 w96bErFT5xO9pIs/g2Ib1MccSQxhv8ZRjI5gfbjlHQhGEAgmSUhX5juKGmk2tNLTUfzYz2nHm06
 Xn2J0PJLMtgz3gJtsffhi0A/96UQY4lMQp+G89nZKGITl1rEXQnCjw+l5GkvtUgaILAPMuxRBh0
 9Z3AdQmG0DG4CMS1+g==
X-Google-Smtp-Source: AGHT+IHYJ+AewWISfToaisOnKs0F34pTyE7k92g+6gh9OcoDT+pSbTyv5WB1wFsDaeO9zAYXMKlEkg==
X-Received: by 2002:a05:6000:1846:b0:385:e13c:5406 with SMTP id
 ffacd0b85a97d-3862b36ab39mr1600845f8f.21.1733474210026; 
 Fri, 06 Dec 2024 00:36:50 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861fd46844sm3976953f8f.53.2024.12.06.00.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:36:49 -0800 (PST)
Message-ID: <4ab03d91-fedc-403f-840d-2989357356d9@linaro.org>
Date: Fri, 6 Dec 2024 09:36:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/arm: Convert vec_helper.c to fpst alias
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031224.78525-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 6/12/24 04:12, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h         | 284 ++++++++++++++++++------------------
>   target/arm/tcg/helper-a64.h |  18 +--
>   target/arm/tcg/helper-sve.h |  12 +-
>   target/arm/tcg/vec_helper.c |  60 ++++----
>   4 files changed, 183 insertions(+), 191 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


