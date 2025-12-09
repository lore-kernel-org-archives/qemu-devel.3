Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736ACD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSrlq-0003w3-KW; Tue, 09 Dec 2025 02:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrlp-0003vl-Cj
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:04:25 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrln-00085M-LU
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:04:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so66543235e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 23:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765263858; x=1765868658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NlEcoy5+5oc6M380clZhLFLgHuuIPuJq9Y784u5sO88=;
 b=WHbuZ6oW9Eq5DXadkMrsTfCV4obFlBgdkxmCf8uQ8iIVMRNev/zquBGnpnXaWvMjt5
 wqhwu0OxdA3JiC34dGVli6IGvXL+J7ai+yiX20MtuiAf4fcTkitzn71Mwod0rEfLcCHI
 GyjivUzpDRwf9IyMzPqJp7D++0eL1iEFjzASgWAIE13XS+RuGYYUU+c0R4xvVJ21uAtc
 P2h9o/PK4WKLBgvBNE/ihWFPwFWtyMXXCGUjJf3Doh9YnMsuL2IHORkvXdaKJNvrZMdd
 iaJpl7eD8zgRWDHdizaMhlFGVZhpts5DCFEje08Q2TTBWAXk4ULrLxceA9uhCGmvKBlH
 SsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765263858; x=1765868658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlEcoy5+5oc6M380clZhLFLgHuuIPuJq9Y784u5sO88=;
 b=Qedbxnhcb2RCReqJeRVAUuypc6gCCI/zFzZmG1vA4A8NlzqtvA9zaQNmyjbY6f/+wj
 y1IqTZEHCWiG4J5ICmaJf6cPxjcTUr10iZ6isCYvl6LK/qF5W/37HFLdddtpvHGnCcbp
 Y7TTRFxZp903sjwlaGAYGAZqfT+1sZsmcRowjfpEWxqOT9j+ChvHSQtrg1KwqvPV6p76
 KY+PttWo+suMumoG1HftZmSMGllZ3lJr71JSkdD+A7FHXFfSQ9+lGXkSmtxDIqVdAkep
 BnU6aBgAX8rSLi0ohUVdZRnojruUbdHvtTtna1NEvHvoFLiH8d8X+SwWLByQlBbCZq/7
 rrwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr0w4BzfixNtRtEuJC+IcGHrHLNGpM/Ma7DEs+oX1AKzEeOBsaUQ8xzNqVnunI0TYjOHDzQsPgOTr9@nongnu.org
X-Gm-Message-State: AOJu0YxFHkpimFxhcwo07LZiMdSvvhiY7mqp4aN4F9Y2KZ+kt44t8/zT
 FkBTjZHovXB9I7OAdLcJD9wijci0LBE5J7MEHWKvGWc1DTgRDDw0C/gdvud5FMrp2ws=
X-Gm-Gg: ASbGncvF8YEDPnv0yKJlh/DWMWQB8L6PJEYoyNIJJhyg030zOzIv0sl3ZVhpjreOA6K
 c/ATPv+N5tsIgCDwDLWiKpucLQ3+pSNWQfrWwUKGCXJjrEqakpD8UHNhDRPpDFoVx/1DBPZTp4+
 IMyTabyMFvpd3Vsr84JU56NniK4CSt352Jd7NwlRucgy4F1p4OubUPpsJCeZhblqctFgLIkeuFe
 Rol0Qb7sKjCWZJ5o6n8oTDbx3/TZaKlZaQ7aOYVqU2GHl3gyh8CA024Tl9Gqr0n6jo4Xukw5oHw
 AyQ95jB3J1xo0hA/ned7OPxaqHUL/XJpA8uCUrWyMN7nEOCMOAXO2R9Q/Nbj3wR/sZZg6W5G0iA
 3R+NW3gXe0tk9j5W0cNI64gpKOf+dCBdrnKpjL+yrLILePFiAvTh1QadscFmyUuXuZvj3ZoPZYw
 eigKVMSlU30ORkEHAHwWsevtHu+Cjp5WpqAX25VbWy/v3jGDBbiDgbXQ==
X-Google-Smtp-Source: AGHT+IGgHKIRaFgA3uLnqdatnFReEJg64vFXOTEyGRoLMdYgwFxOvEvX3N2ncAdjYCbtKidjzUBPbA==
X-Received: by 2002:a05:6000:2dc2:b0:42b:36f4:cd24 with SMTP id
 ffacd0b85a97d-42f89f0bf85mr10662388f8f.24.1765263858163; 
 Mon, 08 Dec 2025 23:04:18 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d3319ccsm29287964f8f.34.2025.12.08.23.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 23:04:17 -0800 (PST)
Message-ID: <74e2fe5b-3b62-4032-a11b-74a5b13bccc9@linaro.org>
Date: Tue, 9 Dec 2025 08:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: ensure PSCI register updates are flushed
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>
References: <20251205151115.2035930-1-alex.bennee@linaro.org>
 <20251205151115.2035930-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251205151115.2035930-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/12/25 16:11, Alex Bennée wrote:
> When we handle a host call we report state back to the caller via
> registers. Set vcpu_dirty to indicate QEMU is currently the reference
> and hoist the flush_cpu_state() and make the call unconditional.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3228
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


