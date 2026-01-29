Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCD3D3566B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 04:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlK2B-0003hU-P3; Wed, 28 Jan 2026 23:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlK29-0003fY-Kg
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 23:53:33 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlK27-0000yp-Re
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 23:53:33 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f47610542so297540b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 20:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769662409; x=1770267209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gx7tYBRfvu3PySLv+vIrVtqIdZH4y8RMyV5WV5qVltg=;
 b=oh9AGjvwJ1EwHrROOP7mgDHmxIKRmN9Mr//ZSc7kOkbyjvm+uYnp3UJzzY0pMTUxoV
 +G/2JA/Y9Zh/tqeh4zAtkm/lNbm50bl3yOdrg6Bl4KEYtSlVya5z0wKskSVCDEIvSSCs
 Y/PIiw4MsbDuf5XzyB3p2yzF39iAf0E69hbBkBhdfNdvzfqW/adRPlRsm+PPHWYEr48L
 SRlWVwq5JLbMk4Yz8s/zWB/VyHd8LRxIDYqCGR5/FW597zT0QP05BhMLSFQSyC1FOqXD
 TmhPgQXNURDX0drIjiazZX2Eur4D/Iv1HyPoa1CiPrws80RfOVB06teMXwZxJ8thWL9W
 r/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769662409; x=1770267209;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gx7tYBRfvu3PySLv+vIrVtqIdZH4y8RMyV5WV5qVltg=;
 b=NJLM1QlFdrHJekkmP3v+8bI+79jVFUzaAkJkvwGdWnVgufAbFeudSGveEmh9X7Opn8
 qDOjWqv8lOsVmONZLAq2AnL4CRK9gCuY00Uv1IveciaHK+p19YaKlAmuXZOfAQ4LaA0R
 hFwKUpo2oftACZPY9/E9CV87LJjJykvS+tSvmYP1Jg07lbntnIPrl3A32NwdtehUsutq
 eRUFk72Wl7srQbBQ9/UrgZH3GKx0lCFNMIihKURYdbhWgCvQonnuwtgeUlN/ILxSLbDR
 Li9yjZrGf5vNXyualiwFSFWlKDuyX5FDSUg7bH623ebvFhiTdfqEFsc8RDGjFbyPpxwr
 8UuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlpd+LiKQRmb7RC/F1djSoGS2t8zQ8ZzE+kE27Ydz0EkjQTwzxthigVg3sEqOxccsOglPEanfnOB6n@nongnu.org
X-Gm-Message-State: AOJu0Yw1Sc4hGqF0G4pgQd9m6wAh1MG2pi/7GsaXM4xjTOjgzt1fjeye
 YfkBUfqP4MkJA+Win+jZTqZdJIT/5NjrxKidOxKHt8q/a7GumHC5yjpY1O+ZBt2wLGw=
X-Gm-Gg: AZuq6aIbyE/puppNRm9HyDN+uRS9vg8WAhYJpLDhY8Q+FVmXEs09KK3FyQiFYcZoXvc
 jDP5WiwY297wJxXh8cKDG54eS9HWQT+5FQW1sO8DvZTlrwS3kC3IQk+K+795YCCXPy4y4nzxUoM
 LGyj5DoV3/OokKluvNHV0y/gWYe6ZVtB662oL5lCd5Cz9blO3U129u4wiKt39M5aCpuUW2ysorg
 l3Whf/WG2PPNcvRgztuf8q2xoRQb8XZnAq+d82rqanMsskd7n7Wm+thzXalRYCPHty2YwH9W79M
 rSol/9qu9a2eON3BlFBRz8AQreqZT4V00EFt6ch+7f7wp2c3qQTl5rdigrbIjp6duuqJ0/i36rE
 pbNV1UYfyiIWs1DTF5HJvogHpDXbWuVjsEMA0hcrnzTmhMAnW5dx5juhYoCaM84lhcxlESOiRQc
 0abdqIU8x2FyAn3p2YbH313GbU+4y1aw==
X-Received: by 2002:a05:6a00:1c83:b0:81f:4e60:1c6f with SMTP id
 d2e1a72fcca58-823692f366bmr7636867b3a.64.1769662409193; 
 Wed, 28 Jan 2026 20:53:29 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b65068sm4435181b3a.27.2026.01.28.20.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 20:53:28 -0800 (PST)
Message-ID: <c073b0b7-08aa-404e-9a22-6678e36af040@linaro.org>
Date: Thu, 29 Jan 2026 15:53:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Build fix with --enable-modules
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20260129013658.3961469-1-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260129013658.3961469-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/29/26 12:36, Pierrick Bouvier wrote:
> The following changes since commit 9ad7f544c696d73ce377bbad83f3cf8b4dd8dcac:
> 
>    Merge tag 'pull-request-2026-01-27' ofhttps://gitlab.com/thuth/qemu into staging (2026-01-28 10:04:17 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pbo-linaro/qemu tags/pr-build_fix-20260128
> 
> for you to fetch changes up to 8eff45dfe93b34b1a027bd22fd8dffe6424f480d:
> 
>    meson: fix build of qemu-system-microblaze with --enable-modules (2026-01-28 17:35:52 -0800)
> 
> ----------------------------------------------------------------
> Fix build with --enable-modules
Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

