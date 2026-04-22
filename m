Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E66FA1FD9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFaql-0000cJ-3S; Wed, 22 Apr 2026 12:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFaqj-0000ZL-K8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:54:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFaqf-0001Ry-JO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:54:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso74389975e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776876885; x=1777481685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dyX6iB+ghmF0Liu8wzTVBQQmwfbY34crzFr77oC5wv0=;
 b=x0ZAh4yIKWMg7DDADun/MF5G4vci11WYesvGFLHtQrXeBDjTmUh9slrWNgV7npBR8D
 79gWd3hWcX9YPS2b/vNyphbieOXE5lL7KyNdN8x+zuA26ktVkcScxeOBecL3fCJnpY2r
 KgTbYMydlAJArfrgtCySEAEQG1oPC2G9YQJ2crTz8TmrkEjMQ1eOkE/0Hh0KCFi1FBtU
 Dx+Z33XzS40uGP/cZhX6s8gyBwofLktiftgitgi145PcW7uBMo2yiM6LcBBUXt6ovEmL
 Zs57uLAfNQ2WPERkgs6zwC8AfNYuyQhoAkzMAssizq6sXgCDGD+kTQzquh14HJgbblOT
 Gpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776876885; x=1777481685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dyX6iB+ghmF0Liu8wzTVBQQmwfbY34crzFr77oC5wv0=;
 b=jmN7GNq7/t8PcHP0j8tZILBtbDqPlx/QceOVpEOLvNAu5I6hwV09SMIp7UfOdPRj9E
 kB1SkhxQlg3fTw5LKX2hvHU7M/LeCu5H2v7k14r4dkradQl4lI+nU335j8zv+9fVbei5
 lKoQNafoFMQPtbmKPjQo2ku+GS/XpYg8RG026MSIgvdQy9wVcLu75zZo/bqEm0hk2Jde
 Uj5YI+IS1e2qWi5GvMKUaOUNCsc7HmyHiWebTgega61FzuzA+rKgmIrpmomF1cycsOhw
 GbRYT1E8Wqjev8tGM0Tx5KNOYeH/khcDqcntjxCPAQX3mDYBO00FuDNbwq1nqTSt2R0S
 4W3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9clI7drd2Wguot+7fLUTJ0KTYXyMHWG0qdli6Sd6Vfjc7HAPSE8S0no+OkAXqoVSSzuw9hXuVmGmXh@nongnu.org
X-Gm-Message-State: AOJu0YyzOznEmCa1O2Q24x+ez+9pMfT2HFKb9FGq2FU0y2MNotkdjDoY
 hoHzUb3Fjj3El8WLhgYApphtG4EZ5Bg2xJbtpZztZmn9lTszSRKlyvmKKB6jFVxruaM=
X-Gm-Gg: AeBDieskZ2IfMb8lMXkLsSEBgZ/yIw1aTqO5FR2AmOv7bZUtG+SD//F1Mzb3D2EYvd9
 aqPNhUwds4bVBRMKRKFNpF3nlzKxsDH2jqP8AuQ3rU994GZEd0yIUD0G+7r5I9qrmcwF+qYTJOo
 vqQZJEfVedBQgEW2E5Sdthkuq9PVtq0WpVX0SIkE9delgfbRdIfFDx7ggXVDcBSid9Rx2o2v7uY
 +3QnOffGQ4uvc+u90hAv9VzxD6fW3p0f4w30gV8f3jcum96yTvfYh7HnUR4RRnf5LIOUQmbUxaW
 H33ZIr5K/yNIHFomVI7MaPbWrBevOCj6jW6EguLztLk4lRBMO+Yt++enylpjN/Zq56yAFRRmTnv
 4hCx9eQ7zmIrS8HTTTM8B+hMY4zhBY61HzhnaLbXwMDiHUEVh/GW3nCLBY9FMJ3IjGSrAP4a4pa
 zwrf3qrBihgKWhWyclHzB3FnRmZPwJXzYG8YEdjl6P/MxcSVAyVVgZGhG4yoswfJ3LOI9NNxy1e
 kDK
X-Received: by 2002:a05:600c:3483:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-488fb7787d7mr309014715e9.15.1776876885245; 
 Wed, 22 Apr 2026 09:54:45 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891941e05bsm90327535e9.36.2026.04.22.09.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 09:54:44 -0700 (PDT)
Message-ID: <080d3c06-a90a-421e-8254-0b834c146784@linaro.org>
Date: Wed, 22 Apr 2026 18:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/32] target/arm: make hvf use syndrome helpers for
 decode
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-20-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260422125250.1303100-20-alex.bennee@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/4/26 14:52, Alex Bennée wrote:
> Rather than open coding a bunch of shifts and masks we can use the
> syndrome definitions.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


