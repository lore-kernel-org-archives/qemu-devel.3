Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445F0FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbQt-0003UZ-Fb; Tue, 28 Apr 2026 01:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbQS-0003HJ-67
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:56:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbQP-0003A2-Ln
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:56:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so135181745e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 22:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777355760; x=1777960560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ACBbrxXxUQ2STFHLM46XTonI3ly/vyfZTDjx+AD5bI=;
 b=PbKlwgw7eHoX5Xp/2LNZAJMxJ+GmGC88iNzQBbP/l4gavNF24g3gW9ivkwjWGRIMt5
 +5rhPcqtUU8+nQoL0iWw1H5Az5EyzP4GqQ13uNNXLZebti2PDkevQzzcfmelFCWTv+4o
 kuH4tz7VYCSaF4TnTZlPWZ0h3vZ+2xMUy1SzbD8BTBlG3+pjHSdaX0mwwp2wlnXdrXAu
 N+XFo7unwOfA+0zeH4Vg0MQSXajzN4nXlXxnE8m/RGm3HUJC+ylA7SUm/OcEbgy1bWEC
 hSaYH4N1LmrtRC6/k2fEmTVS/UI6FIT6fdknuVCprL3La7kOBoYC27ElcXFmqBXzZjRg
 QWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777355760; x=1777960560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ACBbrxXxUQ2STFHLM46XTonI3ly/vyfZTDjx+AD5bI=;
 b=A1AzVsFev+Qbu10SZ8QUrm4FMewyC8z5+7zIf+nM9N20m+fU2bAZgagtxFeHR8GuQt
 aLc1CLUbUn/0AF06xOCN15CeeIWV+4knr/2Dmp3CohcKpS9txQMFXKFEW/GyGB/u7EUt
 gzatlRkX5gqzXe839RUoQgoPUbxvF+6wvWrx5KuhRa43QSSxKwOxLaVwWn3al3f2sIqR
 br82dM+aQsW7kmZAkTjbPoDPzm7lf8HIELq+mreSg+l2eL6gxmyMIgeQuqOA+83MCNeI
 srOD+YzdfDgfq9VOtLabM2mh7o2RkbfVgdQrpw/7jh+DBwQsl6TLerfj6hq1vjPIkr0m
 OBqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6SYzYGLjSwtJusHk1gXQcj5qokE43CTqPJEZjjCjdIcuWnuT5sxUEiyHr2m+xjUuMy5A+mou6fof7@nongnu.org
X-Gm-Message-State: AOJu0YwPS7vbNUq7HflNJqGI1C9bu2L3OyB/sGrlxQIsoAoHstu8kqyC
 Z6mWTioQwQ2EdVS/3uA4rY6Jjg50/6pwFned2enqkdqG7t3OHICZ3obpe+/gxjQzr7s=
X-Gm-Gg: AeBDiesNidnKRp6UisiRrs9bz+iwbvWz8M0gjO9T98sO51osAkP5kly2eQQOgqtVF+R
 1DRpsxlU1herLrlLEgyVe8mRnHsWm87hVz1PHUVfFadvlhMeYrS74ht+8mlpeKfrpfj7/85MRR/
 WSdw3pk7LMjIbm5fHpa41MICYcr7dndKj9JkFUrilHPrKLyEVOVvGj3mNK7wuuyb0chZb4ekTRj
 VKAiyB94NAXRNO69RZmpOupUJSWnwCdlVz55PLYx+nLLojxncPVx432BjVANhz7//chWhW4q47/
 ufMmXRKh5dTDCuzbPiK6Yrof+LzVBF6Vnh0Z+0Qetj6zs9SR6XZXySqCVUw3BBQWJRZo08kqcy7
 8O0MQKe8vVJz1qZ4ha7zw3EHYIVsYHpCOVJa15eu93ShFEEuj8odpkJD/o+linCc9Y8eY7GpoRF
 ix2ZUMtpHjTb0pzDF8qlwGKaxHhZVNL2fi/tgHTu6c2jx4SaA7VNUYng7UcxZM//BBPQZgNslWT
 kJK
X-Received: by 2002:a05:600c:8208:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-48a77ad5f64mr23420035e9.4.1777355759693; 
 Mon, 27 Apr 2026 22:55:59 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77afabcdsm44800605e9.8.2026.04.27.22.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 22:55:59 -0700 (PDT)
Message-ID: <363d4325-bc90-4706-ac85-0011a777df91@linaro.org>
Date: Tue, 28 Apr 2026 07:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/84] fpu: Drop parts_minmax
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Use parts{64,128}_minmax at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

