Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD76CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ67Q-0004NR-5k; Thu, 21 May 2026 12:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ67O-0004N6-U4
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:19:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ67N-0003rP-94
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:19:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so2797025e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779380368; x=1779985168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p6enKjOcUmJ5M0UToV3tBoUnqEh9fRbA5/lDecXwyfw=;
 b=IU0ipk+jNHek1vNwulpqSiQRLI8tmGo2tVEtqfhlxMGgBH72uCnE+Puzgjw3ygPuN4
 wVrsq0UkdKX8KAmBk/847894e/cW8nISd2oTM89NjvoHQ3h6mjjLrU4OHKQVbRk3dje0
 WcD+LM41hcx4DkMF1TAuPq1ZwphEii4GFP8103kVMmbc+GGYEWdtpbc/Dz7BTf1OBDlx
 RDEfizoKv1MAaCMMHeYOtAMJmXam6yB58e7GXNstFBZDJwtss/8cBdv5Q80TH/fYdunl
 3VVZDP9dFDpEYd/A9839l8CeuvNbQZox+r8fHWSSZBe9CCRZ4Txui4XZBm0H3XLdFqWh
 wo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779380368; x=1779985168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6enKjOcUmJ5M0UToV3tBoUnqEh9fRbA5/lDecXwyfw=;
 b=Awp70NcQo4QZ73F/5PHRUx3h+Fj6flORHCJSWHMkGrAGHwlm7OEyHCXm1dUbHEdrG/
 54sX27bY/8+fQERQOkYoff6W+btC+OB2iVsQKqkrH2wYEJVOnhYOqewBeB7s8HbsLK6L
 Qeal5SkWMLsUcWgKHhZbGIhatnpTVZQOeGWaVCV2ESDONx+EqPBhulJuJYg7MINPDCkU
 qG+rh5IZdlGKTZRyaRk/QAsEzWAjlQiwIH//u9UleA4Ft38/2GTQzMepBbi1U0szmQ6V
 Hbkt2hTYiteggjj2VHXcTTBCGm41LxMWyMOYbJfNvCYbtaOP7mDNKU/ug44M2aJvuqD0
 0yVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/SZsQsolK6l8xAS2Amakc0TwzSMu5ym8QS07dG9/flonIxXf3PcikoHZrfTYT9srznLEvuFRQuFaL@nongnu.org
X-Gm-Message-State: AOJu0Yw9eJh9sx7m9R80GFGYejkXVrZWAVHxYnlm+KS4BJ3v7LALmjgg
 acdLUh/qo1fh7UxRxGlQ1TkeaawfTA9ljDjiZb7d24bURuwZX2OAiQApnbkgDIUxbQU=
X-Gm-Gg: Acq92OHO13ogS16lHubOd/b+N0pEeI5GN8V3/1BvIKWFlpqbwKrwdawMmMkso3hAWOk
 rlXVSsW2ZKGvukFrWGT43x3v9Tq5UbZdL0PFmdzKZGqfRqdj8UVCCglW1gu30C3FOJW/q2vy0BL
 aZWHxwR5VJrsH3Z8f4KxEaULylLW/uT25HZ1YfuIFQeMLt+6XYATZ4OKF3TEKgAtEIwxiAk4Gy2
 XOxON4bKwJkVMGDo4XkiifWF4z9axifX6KX9chTaGxG4s09Kue+FYtUuPA8S0yM1t3QKiNjzXrI
 iea/85GY1gp67ZhFzgcAj/KuU9Nu5Q+hgd3pFCgLjpI8wDd+X+d309970cEMfrCDPamBA0EMgTS
 pq8w5z9uKGPKcFBm8+NhnbkpTVwmSuvATClUOIS6BAoz1Le4mOD4+Lpw7htgDbnzCDJAAnjJL8Y
 SfaL41VZnHqqpbnOkWg22hecPkozXr2q0EHZY30+KfORfD87swJWSjbrpR
X-Received: by 2002:a05:600c:e494:10b0:490:3d45:48d7 with SMTP id
 5b1f17b1804b1-4903d454a8bmr24395525e9.6.1779380367663; 
 Thu, 21 May 2026 09:19:27 -0700 (PDT)
Received: from [10.139.182.66] (79.170.88.92.rev.sfr.net. [92.88.170.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d44705sm69310555e9.4.2026.05.21.09.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 09:19:25 -0700 (PDT)
Message-ID: <f2d1d8cd-bd3a-4304-8393-a09706534eda@linaro.org>
Date: Thu, 21 May 2026 18:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Mark Multi-process QEMU as Odd Fixes
Content-Language: en-US
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, clg@redhat.com, elena.ufimtseva@oracle.com,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260521143827.64285-1-jag.raman@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521143827.64285-1-jag.raman@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 21/5/26 16:38, Jagannathan Raman wrote:
> Reflect the current maintenance expectations for Multi-process QEMU by
> changing its status from Maintained to Odd Fixes.
> 
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

