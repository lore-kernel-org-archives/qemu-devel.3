Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A273CE7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJgpO-0000fe-6h; Fri, 06 Dec 2024 17:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJgpN-0000fW-H2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:29:37 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJgpM-0006n5-00
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:29:37 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f25da4f999so1309943eaf.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733524174; x=1734128974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jbZZIV5TMdZI79L8VBQe82kDtT1Hn2hmKK11vEnoH4Q=;
 b=q7qB5bUH1jWp64EvliP/wHXFn4vXVOQCGqJD6C4jMlOQrKCCinfwhaNQ621S5q1gJ9
 uEELlugvsRc4AUcGAXDcLkmHCnfbeSYjPRrYPFEWNvzxp9iHvF2uSWtEDBXpLc0P3Yse
 xiTfFhATIKQqJV/aqFzN7Ya6SNOxwdhqQgch5GkIkd1gHWTdmBo+miypDZ+O56oRlShf
 007Bj9a0xmrzJDyKN+doBevBCirz4Ssx2bIIdKODwbxWZ0b8oaFJ7HRj0maJBO65XHMC
 sgCk2/MpLCzV3o1/XhluGbU+GErpSo1iftJImmK31Ihp7Nhi/qkQqbfr0e+m2tliYQ+W
 Qndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733524174; x=1734128974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbZZIV5TMdZI79L8VBQe82kDtT1Hn2hmKK11vEnoH4Q=;
 b=URf+eILX+wPu0OIHJDLbSmQl5LwtKretOj2VbHweiwjtkomD2y7q5Elhrvbd6N9vjM
 7ucx+a9Q7qN6sf4psj/LwP3YlSyVpjBD3wOoZqkmdjQG8jTQArqFa6el9Zyz0b+d7FOd
 kecy+FOFLCVYEdNO+5VfGMie6pPYHBg+V0qk9yNi/cj8n28NguN4PbAejyX363teRNWl
 vGgllYzPhbdB9BU+9Eb7P9DZzY1y/Ajw537WLpnUlDmRipUgTzCw5iaSEXbiy8c1dATU
 Ktdz8ZTCXa0fnN1qngamxCHo2k2GEf8H29sOdnOk0kznB57mbVRBgs/RzMgrWjazQGa4
 Bcxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo2qwtJcJxAcg5BL7j+V3uifeWPz6UstAi13Z0U4whZ+0mQ5mjDg9ns70xyJ37DBYwEpo+nPz3l5n/@nongnu.org
X-Gm-Message-State: AOJu0YzJ3+jECCjLU5LbKzWqs5s/S74T8sbNiFyWraHysEi4YKAIUGVK
 /iIrbXglTJVam2uTrnQfMOzIVjjt4IQyxyJaYYNw+2Ky6WDCcKbpIuJ/JFfRIfc=
X-Gm-Gg: ASbGncuQxejLksEevV0cBZekddZs0JDHCvH4jemXUq2dwjuM3syLxRdEEYlF+gNH9wc
 Xhralowc059UViJIlgWh0xJczY0YYpP1Ra86iOHQxzU3Cs6rCfTjw/6MvoSpFU2WCPFSTm+CZk0
 kuSbMo0CqkfCKnz81JSfN1H4h5Cb+VevJVibO/9wmLpgwLtS7ooAlZRfJCu6Bn6R+/zHxOuDTKq
 WMBZ6vNcD265QK7XJ3Vu4C1gZYfVXJfGY6ibhbI/luNDPWYQ6Qa81rSzU6T+1Vb4asdZUhkCOZH
 x/n4u0B2AGf9i6zFg8+XzTuSNPzI
X-Google-Smtp-Source: AGHT+IHKBNsHgCD4MXVjVWdqTM7le6tySCPyR5Fk2ehNzQQ0eDXOoFc8gHNgEP/q4iqyWWUNeoNV1w==
X-Received: by 2002:a4a:e845:0:b0:5eb:b282:5916 with SMTP id
 006d021491bc7-5f287113ed6mr5247075eaf.7.1733524174597; 
 Fri, 06 Dec 2024 14:29:34 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f279244c05sm900534eaf.19.2024.12.06.14.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 14:29:34 -0800 (PST)
Message-ID: <ba552040-4ebc-4a99-be72-91937daa1055@linaro.org>
Date: Fri, 6 Dec 2024 16:29:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Enhance documentation for new developers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

On 12/6/24 13:28, Pierrick Bouvier wrote:
> Pierrick Bouvier (6):
>    docs/devel: remove dead video link for sourcehut submit process
>    docs/devel: add git-publish for patch submitting
>    docs/devel: add b4 for patch retrieval
>    docs/devel: add information on how to setup build environments
>    docs: add a codebase section
>    docs: add a glossary

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

