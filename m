Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0AEFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIUZ-0001aD-1o; Mon, 27 Apr 2026 05:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHIUF-0001Ub-8Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:42:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHIUB-00038c-E9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:42:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so168914165e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282957; x=1777887757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0he6pqaoBN0v22JJ9ptOckfcFmH0/oENDhYshcs/54w=;
 b=DELLONtJajF+f/vG2Ye3qCXpTpMz5XmzWNrNqjQrQlqqD6+6E3CaUgWnO5oyI7MctO
 LKuY/kdcq9npJf5YbMG4Rl0dapxc3HvpHU3qu/f1VhYIIMBcxc9R4k8ynV6ThdJsMft/
 2zwzfCpy8T3IGy8hvQNrlC8jKJkiiOTKJ29/KDpnY1VUENiJHniIvIxWypyUZ7pLXRLx
 Z30rkREDEM6TjINPJNsM0eSkWms8R/kmXaqpHHtAKyl2br+Uj6ugtVVbrp1jByyOJNP5
 afDKPU9Zmj1jFpqSENVSEe8qoJiAmb694JRCMvMdX10QtzYnCBrzmnWZ79ImwAbm4YFk
 mP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282957; x=1777887757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0he6pqaoBN0v22JJ9ptOckfcFmH0/oENDhYshcs/54w=;
 b=EfUolhxj6BiM7PSm8tl96trBJUUh3Gtbq6paYbVO1HbZvSbixKr8oMm+q69TOzQIbt
 SRtm+puPVtfI9cMm2e4daGeUqrsUGEvEWyHbfgSONPMOc6ejHBUt5l3Q6D+5jxPU457o
 YgQqaoScawuv1fJ6Dfnt02STwUxyqGzFDSpuZJc5P8UkEHLwchs7/wDa569X/PuHg5vZ
 GTd1/xL+TyXB8x50bJW28F/BnfFvoKKDOcO/0hE3uR3i4fZCxX6Js0ZmmB9pn43oZ7gC
 q609mWKQmyHBdD3s3xqAdTKvdEPZ9Z86u8qdvDg9Cn7ol45uBXw/MD/vTSgHZPQMvOe4
 e7Kg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zsXImhazc4/rnsJEBcXUX7km1VcPm3EmCiwdThcs6LDKTUdNpCmBIp5pXioteYiJq7V53kmZOyQ4Z@nongnu.org
X-Gm-Message-State: AOJu0YxAEdEg9Kdz+t7UVRUf2WMw5PMPQScaTNG+hgNIrz9eSkFZ+qNw
 9gzL6VxonZdHYmH2sQamIx5FReBMe80jTMT/Jy1gZieviIBub5FDjlvUb4XKCYUUxXM=
X-Gm-Gg: AeBDieu3rIraczjB4woi84X/1MsHWw3wxnWGazqKLH78XDkPgMWCGsL9rjrdKuiGhDt
 lPuZXIuJCETsTnwxRCdrztL8NJcipfK5auHav1oNCgN7fJm+5bT7shodn+agYsy4hx2J7cJ6WMc
 ps0jj0rBkv8wL57vkqZx4rXOd4kgP9JvTxf5ag9yPBqDES8x01jPpDvNtVRHVLfDPNVivl8r66Z
 uhArNLWmHDDIP2zVTBagwSJqlw5qWfgYGJ4hIIAHrpJFfcObaFKUIadIAbRfLt7DbR0inz+OYNq
 L0r10RhqyShU/1dXvTNHQm9unyarE1vvXxIPqmskpjcvSfsBPqYmLmzBCL17hENlZwh35cgxFQB
 P/IU43guOMzlmx4qh1oLNtl0+KEq1NHOEb/9q6x8/EYfqkW8ToRiojre1GrwjhHLmlsKxhRgJ8T
 CEwsTpyb54EPYaODPuPfCwKv90rmJ3ralr3cctfDe9q/iYxiZcqJwRbjhKz36y8XUTZBJP9S50P
 Nuk
X-Received: by 2002:a05:600c:3110:b0:488:8c89:cfaa with SMTP id
 5b1f17b1804b1-488fb73841dmr607025815e9.3.1777282957022; 
 Mon, 27 Apr 2026 02:42:37 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c789sm234608325e9.5.2026.04.27.02.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 02:42:36 -0700 (PDT)
Message-ID: <930bf65d-07c0-4e36-ba65-6162186c0807@linaro.org>
Date: Mon, 27 Apr 2026 11:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/84] fpu: Drop parts_modrem
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-16-richard.henderson@linaro.org>
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_modrem at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

