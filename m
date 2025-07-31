Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F8DC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhba0-0002E1-KK; Thu, 31 Jul 2025 18:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbY9-0000cA-GP
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:14:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbY0-0006NH-Ku
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:14:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-24063eac495so2280065ad.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754000085; x=1754604885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uAu17frkcTkEkXcaZkcm0cS7GetCOGzF/S0l64Jrf5Q=;
 b=Sb59WQTbS3ekC5HET7+xhEj+3IO1GWbZXDjpQSh4KsJh+wXpC0QEVaE305kKHZsO/z
 KBqKBAkUbmb/j5jRjwJmxiwjcgNypY16cjnAgqj1RXI1RArpydNOKiMLU1WE4xsujV+p
 J5Cq87QCxK7fNpaRKnQ00ZEVzs/T5f+h/d4BEJiruHvaIf054fJNyqzPqOlSVh5ilHDI
 g9C7/eA1KqngZ+hh/CIQX92OTLon/NpAliR5Z13ZvF+q8KES+p0yCX764exAjIh63Q2p
 ZF5BB0zi/j5+3K0RQKf7bg77U/sPwJeCN2jPmlzwU/amUMEeKrSkBljLafv1Ab/iNnVa
 t7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754000085; x=1754604885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uAu17frkcTkEkXcaZkcm0cS7GetCOGzF/S0l64Jrf5Q=;
 b=VQI016T279WiHI0q6dYT3XoQcJyDdF+uYtYljOmPnpFXDix9ZmwiRs3MKVBH0OfeK2
 JDg/BPXcCYx5mv5aWQjm7040o/ut88bG8KfXPTgH9w+sQWxaOUlQy4gydQgvMg/sUPt4
 StOxcOX6gMdgZ1GqXVDpFQQ18hWS92Sq58PRJEsCMzCi+UcK7G/8xFoM6LZoqR5/i7WY
 QQnyRpRQ3I33N8kNZ6eAbyDebmQVnAd3QgD4Yhxeys3IG/8QAinEuDlXfp6+1fMQCeLA
 Cso+QaVDg2geEYsh8ZzJucGBrqdv+CSoi7xAcuHyV/jFyxs4LdPSK4D3Prlh2srBCtq9
 VQGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSOmRlkxTiwcrt6EA8rJXMqhFa7AeZsraNIXyHIVjUlA9Yw/A4HK8qVbMgXb0YiCNg4stmdfv5eepB@nongnu.org
X-Gm-Message-State: AOJu0YyvAK3H1gJCHwsLQjoLMy/aEFqc8U1skhSoqZmIaQuvRCMR1Wf1
 1KCaTACFJDKkLi3ucE8dxdmZnuSQ5llA42+YCvpgVf8iwBuahCnmO1iaHu/CNwc43ox+GC3xrUT
 6a5Tb
X-Gm-Gg: ASbGncu4clUqFkMG+HfoIo9nq9DXPn5NL/La1pvdfBs2oyjBdFudG3Y9Fl6qnMQrkSd
 xBXDusjz42R/5fQ0cyiNXF7Cw+ZtYtz8qz4nJVpty0izMo6MN9paagvA0794mX2D2GC00J1Oelv
 5KSfHCm6zC54rpc2O3hkHI2hoOuzunZjO6OsnXOftKUpsAm2p7jUNjc+03S+ONB0uTWWEbPaqM/
 gA8sCE/aolV+5Qt2CzGahaQTXPrfnHkhnvuKG1740lwORpf7BVLQXWLgfnES5SYDUROA1LdRpr0
 kEYa5YnckZ9nj6Lu+vZmwdEAuwQbUHOyWgfd0AHiJOR/hBFmHirE65jNJts3KexuYrvFDXzpjtB
 KcTXfJgPFyxBUorf1rxDKgqJYuVIKQ6tLtfY=
X-Google-Smtp-Source: AGHT+IFVGcoBQvyFh7w09rKGnfQLog400lM8DRrLXl1Ky0v5n9Zca14zhWn4yotjuNr/SvqMwIlDfA==
X-Received: by 2002:a17:903:32cb:b0:23f:d47a:c9d3 with SMTP id
 d9443c01a7336-24096ae6857mr123735935ad.15.1754000084960; 
 Thu, 31 Jul 2025 15:14:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef67a3sm26714115ad.15.2025.07.31.15.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 15:14:44 -0700 (PDT)
Message-ID: <b992d6ab-308d-49de-a92e-091b9e71973a@linaro.org>
Date: Thu, 31 Jul 2025 15:14:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 82/82] tests/tcg/aarch64: Add gcsss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-83-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-83-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Validate stack switching and recursion depth.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/aarch64/gcs.h           |  9 ++++
>   tests/tcg/aarch64/gcsss.c         | 74 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/Makefile.target |  2 +-
>   3 files changed, 84 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/aarch64/gcsss.c

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


