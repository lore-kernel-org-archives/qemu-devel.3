Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F135F9937E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsW4-0007zT-5q; Thu, 23 Apr 2026 07:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsVs-0007og-EH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:46:40 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsVn-0007cY-U2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:46:32 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c79506f3c40so2402261a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776944785; x=1777549585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HfQz5NhL/c1AlZ2z7e9dEyGX9R0LfoLUssBy8VAyd6o=;
 b=xo/jdLIelMha9nt6/L2m/Qf5bWRjrZk8K/ZAH1vBsyghRbjEhaXCtjo3WCDYMhVRlm
 Rqjhvlzq6AKT2Amxg/5PIe04gpD5B5GnJzEUZguoNfpH1DV/xtnwOkrhtVoykCXZheO1
 g9aKBKXqc2mjBd3zrbMOU1Qx8Mulgt9LlKO6lpywkaYawJxxLy5dJf2XTxY67znsm9K7
 uYc4zw0qTvXindgGV64mcWtvadhhRAdzAKR/czLs46u9O815OzQhOxAWmJlfl0US8QAZ
 T9DL7itI7ytW4tbn5G6WSBg7iYaY9atliO1JctHaZA21DgdM2khCZPfUcT9T/+zGsWwO
 rLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944785; x=1777549585;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HfQz5NhL/c1AlZ2z7e9dEyGX9R0LfoLUssBy8VAyd6o=;
 b=VD8zww5x0oynZzb5QqA4Ip6DvYDtgUPtHEX/X8dv0ux7wEJohXaeeH1VJg267z5o97
 bITjpbDRZCzLFj5K3/GrLiB1cPXJapC63NDlYi83UqVHnLrbbyG6nyfJHDcNPChshVX7
 8FGtaniLuje1hWdn7z1D7Fc44f7N3TNjgortBl0fhe6chYc5RF7oM3aO98ZvNFyEdYHQ
 0NJl8xvmJ22TlwEWCaXV+OLv+w+zmKE6kimd6AV25XhYSIm/J+l1QcUc37a1Bet3XY3L
 QwhcTQc4I54CKnT9DThOM/iBXLDgRhWQjZhftAwmVhSXPkcwbnfc7svAZN27A43cutzL
 CF9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lHW9IYdUu5/Uq/ug63Y0xo1k1w7gD9TiSN+fR9QlC/ik8cWki/b2s9Bk8OwwJlftaFVTYtw0+oXaD@nongnu.org
X-Gm-Message-State: AOJu0YywtaX+EOpwg6tXQoNHtV0VUOpv5XqlgYH/43ekL8Egt6iTTxnX
 Vr+wVVF41vOhHiNoB6tPYYUGkW9RMObdlcTtmB3RIuryW0pwKhW9NIKkn/kQqPqyAJg=
X-Gm-Gg: AeBDieuM2bUt0VFKFObISOWHK7pH/7TJ+CvlBfuMx5XhFXXHfgys7SwbtkvnTq8GHb2
 66tJZdx0Fwxo8WKaU8JNk5PlAUDZW3N5zOSiIKnh70pE3w4vS7oQ+Lcg6jVqHuj9gPwDuOc7tE7
 z5IN9JOe/JUj2/Awsap5MQ+hPNfFixAMzuibkMt8KZfyPn0PCVnHoqnshm3nsJghCT9vb28fIrF
 VozVlvwXoOReOPcBicQyh2KNyacpwR3S0bNIoeKg+FU9KIKxX/c1GMnOBC1I58SViZ4+z1W/dVw
 JXfvwuBPLkNjRjocIQx0DeaHGqdBssaWS7793sdIaxb/yw+t3ZvDFWxq58m6HJ15y7EntlZy/uN
 4DFKvpsGdzssxP+JfXO9KMBSkMpqo84nZaXl18ic8Nm5YZUOlsg6KRuaQKtUkTUA5hHNzUYg6h1
 maM1+mcYlSOvT8ZbaGdSpdY4O9+dIxxkrTTq+Znq21NXmyWbRbwQ==
X-Received: by 2002:a05:6a20:a12b:b0:3a2:d79c:414f with SMTP id
 adf61e73a8af0-3a2d79c440fmr18953078637.48.1776944785453; 
 Thu, 23 Apr 2026 04:46:25 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f8f356sm15448827a12.4.2026.04.23.04.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:46:24 -0700 (PDT)
Message-ID: <3d2edd58-54b9-43f2-ad06-c7135bc3e067@linaro.org>
Date: Thu, 23 Apr 2026 21:46:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/microblaze: Introduce common system/user meson
 source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> Introduce a source set common to system / user.
> No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/meson.build | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

