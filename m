Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B48C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURY8-0007Wj-Br; Wed, 25 Jun 2025 10:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURY6-0007S7-4g
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:56:30 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURY4-0006kO-DM
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:56:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-313b6625cf1so50799a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863386; x=1751468186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aj1Ez0bkF0VnsUzVGs7mii/yJJOz0xUwp5Pcvn5DCMg=;
 b=XNBhMC34klSkKZq0JEpFjzxNfzZdI3JjQGjZOjWpU0vYWqI/LLfshRZvh6LnP1MBGZ
 bbTUQPXeUlNrryXoCFwa0wdeuoHM0MdrprZZoLzcnYWcQIiDJPK/XB6OQkiPa0DYxws5
 nCFziFroFbtnTToPXnGVJThugftF+1bU6R0hzmJhldVwxel0MaC9QTrFo6Js3iaW95+4
 ji0uzMbMYT1jSXBELpmMJkZgOsm6rZHBukpJp5dhN6zVc8uYl2M15DkGD19dRtUwia3n
 fhYjFBv9hW48FNQe5kXimJnPCKvCxF/uJnqDY51crpK4bo8PqP00S//l+aSQPkx4f0Rk
 O14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863386; x=1751468186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aj1Ez0bkF0VnsUzVGs7mii/yJJOz0xUwp5Pcvn5DCMg=;
 b=d8o6lxRyApRdKK6HvxoOUuZQTNB0xHTle+WzF6e6bm2swg635sCByhOIw+sIgsyEfN
 Ie/tnH3EE3A3Cmz/A8WhkDMR+3pOSlW1vhtMeCSSww/ImWCyoVQ5sCjewYkErOMUfqb6
 2OXP4U0AuDhN1D5oYS2pSZh8EZk8A2T/AVdT4Ud/Gaz5tXL75Ox00ggUjyIUW+PNJGnG
 +KoQ/TCDV77QVTB0fGQYtHHF7xRHICpiEpD9iSKtO/GFeT1ohiykImkEiRx6PGPXKEHJ
 JAd3HtjHpHrau/gb801kdOy9gC0nM1xiz52u3OLWv0zgu1MtEQryntD5YgKqz058JyKP
 YbPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkX0J1ORywOu0RgK+52PfOt9mqYtD+uYNRJFrjFV4UcCYLu1CHIZ/xVkUez2z56oltnso49b9qXbaB@nongnu.org
X-Gm-Message-State: AOJu0YzHUAGaydKpzIJkk0WpWNH3/RXfv//ibZi7M7cVNds7zIYGyOi4
 oGReDAQatRbS+DMACF1gX/H2sm6sRuSVP62pY3tT5BcsWOaR0rl0z/Tc/q18GytypVM=
X-Gm-Gg: ASbGncupVgHfGKl0gKri4LccfF1H5HIsD+/k2OGkQDuoMpBIcETCfr3Hos7X4l0IGXP
 coQvEkTf6IOImalAzDHIRMR6vTRTMiT9rBEfaNTllorrWZZxQJnFmtSMgkzrIMGHKknOMwmw7Ox
 hQzN296jbVzJbD8jU9PPW/TqCEr+ZEVD1NjSmM/gAamHlIgKkk06DlayGlGN8+CtDAxOhN82LUn
 Scq94MzVlnKxYqPfiHSvOLuOwbA1coUMM+4rjx8AJAD8iQOxet8bwkI8S9pLKcgLw1clyk+GbjY
 IgidQFXmhQu6O8C3P++aCg1AXyZOny/SJvZWqlvcczKOor/i6Y/iVaQn1P5pLhHvNfL+nSlxUu8
 =
X-Google-Smtp-Source: AGHT+IGhnGk9/f3oL4aXkGfUcasa1cL0MwXESsTKiZQxW99t8w3LWqi3JmOLdZXxwuO0qzZ8jUpOqg==
X-Received: by 2002:a17:90b:2708:b0:313:d7ec:b7b7 with SMTP id
 98e67ed59e1d1-315ccd57f7amr11952372a91.13.1750863386463; 
 Wed, 25 Jun 2025 07:56:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f53ecb7dsm1931687a91.44.2025.06.25.07.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:56:26 -0700 (PDT)
Message-ID: <d9989663-dd48-444f-a646-2ed32d555069@linaro.org>
Date: Wed, 25 Jun 2025 07:56:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/27] tcg/optimize: Use fold_and in
 do_constant_folding_cond[12]
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> When lowering tst comparisons, completely fold the and
> opcode that we generate.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


