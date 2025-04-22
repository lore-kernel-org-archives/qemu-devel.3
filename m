Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2990CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KUp-0003zK-S9; Tue, 22 Apr 2025 16:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KUk-0003wi-S7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:45:32 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KUi-0006F6-Q6
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:45:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2255003f4c6so64349795ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745354724; x=1745959524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uw21VBvQ40tl39GlE4diwHST6RdyQIUynRSXaKixexI=;
 b=wr/tx6t5oxLph5Z2Dp6tXLuo5akwpWeWqAWGHdrRvIvm7uZnwaDSfIax0iosEDMiVH
 ytVxTaHskzefFvdgjW8Rc+MpcApa87E00kirxP3UzkbDpM6Z9wvzRpVotaAwOs0M2KBw
 fAqy2iAzBTgE2XkPAEtu2Typ11xVk3qhymTb714uvFk0SEFG2u3TY+MX+fM7aDJD/gRU
 OEjitXHNuJQ1D7vE76A71RO28sEDwwhD9od6T6doxE5Ig6xl11YZI2D6X1KJMcqgHNlD
 JwK0581FvQQ/gYriDEX4kaJj3Wc9CwiwEOIYXS8k6hGDizEdkbWLyZv0t7iunE+Wpwab
 DxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745354724; x=1745959524;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uw21VBvQ40tl39GlE4diwHST6RdyQIUynRSXaKixexI=;
 b=QJ7ybmpHcPgCtC5OU2otpPhLfFBXcaWJBdQdOJ81R+a19cOfAOBnpKcNq9Hh10dO81
 Fkjc7KS4H4VD2ifZXvGSkY2Zc+j0yy/SVu50+cU3oA/w7P+3EvtkIQXxsouF7oxHFMG4
 +7lqsREZLLN3lt1cbhnH7KQbJ3DWy2R0BfVTbfvDVjnoC47NCFPfwANwmzvqaSuZwE2h
 jqXLB3Qtpv3wSbAuoqVlbYHHO7jYbW7/geo+TgUi1eqN6zmpnhF7+C0K324N4my3TgxE
 kibJIJQm673NPNuAwFAjox5gb0eIUkWhx0GnXji2xoo/ZyFy98b/xUgsB9hZyT1XY49p
 D6gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjnfEZdxWVIKoNerK9QntS9T4FLDgqIeNrMN8cEsWYS1FJGebH+dnXNAukp1ozNzV5ElK/NFcLtcNN@nongnu.org
X-Gm-Message-State: AOJu0YwC7Ed1ov3ARmpL/Vtmzh45QJ5VoPlF47Ga0tBZ20iNCZs2SVC8
 HegnBNLKJeTvixHTWhy4MSN5EJG4AYh2TTshYLF8+Xgxfic4cuhYWIuEQ67BS20wXO+JY6HlNpW
 n
X-Gm-Gg: ASbGnctDTYURgiDNbqibaqXhhqBr2KYvYp1v948tr4qa5j/T7D17QvuMnuiNnZFi6u1
 iXNTw/sEmCdowYtsysS2M+wQjKocsBAw5xsnVqcPA4wV6kQRylRy2753TaCpAUDCbqxpB3FZD7N
 p4nverqvjm7WdR4pNsfcVv71lFUMGFd8ZH6m+53agnTtIcL45eDrmAWfJFiTa3/VzzUnvJRmtmv
 ognVbSaJwz/ID+1EEMYlrnMgY7qrFv10p4Xp0yfwZ2gx4Zt5unOMGa4dQkBgTnwIimY764BzaI8
 pvKa5/0VeGXgY0kCR9Q8JzJ07NWVye4NY8oBb1Hn2XgZrrsitleIQg==
X-Google-Smtp-Source: AGHT+IEZrOgbPnM9it0R+6X9gzMRfUWRwJJVBgoY2uW2m9l814pSblGer/7kbau3JZYuz8ciYlUaHQ==
X-Received: by 2002:a17:902:f546:b0:223:65dc:4580 with SMTP id
 d9443c01a7336-22c5363003cmr220773665ad.52.1745354723843; 
 Tue, 22 Apr 2025 13:45:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf90d7easm9076174b3a.84.2025.04.22.13.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:45:23 -0700 (PDT)
Message-ID: <9f672417-4646-4ac2-8a3a-b9a9d66a7cdb@linaro.org>
Date: Tue, 22 Apr 2025 13:45:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 057/147] include/exec: Protect icount_enabled from
 poisoned symbols
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-58-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-58-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/22/25 12:26, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/icount.h | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


