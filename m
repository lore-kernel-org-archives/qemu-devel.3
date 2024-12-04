Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC15E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIieU-0001ZW-DR; Wed, 04 Dec 2024 01:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIieT-0001ZE-3l
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:14:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIieR-00040X-K3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:14:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a90fed23so54002745e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 22:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733292857; x=1733897657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H0oRnCUGpxZ0I69IEwbcxtmQzL6+vLo+oPiYFqZLNok=;
 b=cjbzQsHT/a5fEGOug++ZEcLholm13SXScScojdZ8egZyjJSutiWzIfQ0Pv+WzlRx3k
 gmIya27ExNrPdtj0uFzDZ/WspK8sYPptQ8reSCY45Um+MQFobxOzd/ACoQbDi1hhvz0v
 HKyPDrj/p05TSkbGE1SsN90vHL+9ETau3vzrch8X5xiRtV7s/8/YuzFfluGQVPaL9ueu
 CyFeezAzLSJB6ZmftACJb98SyJ/YTymYOoGTlde3ZG3UbZLhuUflD6/SMAlljyBQ2aob
 cgbXely615s+oDJH6qbQjyQxKXdW6rAX0dBGhvh6nKugFSEcht+oWTIw+1XL54xhOPHN
 Fqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733292857; x=1733897657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H0oRnCUGpxZ0I69IEwbcxtmQzL6+vLo+oPiYFqZLNok=;
 b=rTWpc/MZIaND461lnX5ttbCcL5CSbzU2UuWgwNTM7jnLf8kWZF99jVZOTrsEKKjXho
 y2Zt8Mi00Ub/CG3G91zd71nFdFeBfDHBEy+Pt52FTWYtlpk0A3+4LNVj15KbXKqZa8D5
 sGApiuohUv9+6iX/phYnsk3y3E0O6VX/W5lf2MXYQuBHOVX73dhrx+R90OGPlxnKnrrO
 UkwHkAttry7jMErAuIVy/8Dx5yLKTcBYDCJQzb3t9XWNCZ+YFjtUvnqOpvyOXCtAPNBd
 Xah2K9dtfw3IyXpBSc+NZ8Lq2UJNczhFKP5b7dqEvFYRNoH+aSd0eMh82vaTDiFBgz+G
 NArw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPjehYuDuh8k9XqMRweSFeUDJe5dBEi7zbNP0aM1Xatgn3bKwcmSKQdI79bddiN3z5dP6VBoauBN7t@nongnu.org
X-Gm-Message-State: AOJu0YyfOaXT8CmlWFb/5GqSvsPJAHq7xOyl/G1Cu51G9RRlfjiSDk8H
 vuiDVnorKmjQKoYDCYWy7TZ/fVPtWCXf8hdVN+k5DzkAQguOy2jd0oAyKT6YvyGF2ln6SB1YI2D
 1
X-Gm-Gg: ASbGncuS2P9jDtp0RwlWhG85J3+k4qcHh5muDjeh862QeVTFy1aZ2kkGKD5ILHK4h/s
 OnSlFhTy0EG4a5jREQ98rYf82cInevlUms8zmPymMAjDbW8qde9sIlJq6r5BlcasSLDmYEscEtA
 mcn/lwG0a/PtT1Q9wq3XP41PP9aOzcJU+GsfwkgFq1R9VXxY/Yv1r4pwLZG2pFXJhzuYGbnAzpP
 b9zSBFdW5ov0jyzXwc2sB2EThL1cXwEUsE18O+JuqRb+CSE0KiYlZk3EATL+9tNGySpaZTfRF5R
 T+JnYbPUYzKpK0uH1sthbYKVTvMh9FcMHkCS06XMyA==
X-Google-Smtp-Source: AGHT+IE0asJ6M4ggt3L8yeUHAgz7mq4wGJuZWF4RR3lUEoHbWwxkTMWeisBj4YEsYRHLgTh3X419ew==
X-Received: by 2002:a05:600c:3aca:b0:434:a10f:52fa with SMTP id
 5b1f17b1804b1-434d0a1d4b8mr40151095e9.32.1733292857222; 
 Tue, 03 Dec 2024 22:14:17 -0800 (PST)
Received: from [192.168.69.223] (sml13-h01-176-184-15-95.dsl.sta.abo.bbox.fr.
 [176.184.15.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52b5677sm12177295e9.37.2024.12.03.22.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:14:16 -0800 (PST)
Message-ID: <52c7a812-886b-4298-bdc0-5fa66fe9875c@linaro.org>
Date: Wed, 4 Dec 2024 07:14:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/arm: Copy entire float_status in is_ebf
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203203949.483774-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 3/12/24 21:39, Richard Henderson wrote:
> Now that float_status has a bunch of fp parameters,
> it is easier to copy an existing structure than create
> one from scratch.  Begin by copying the structure that
> corresponds to the FPSR and make only the adjustments
> required for BFloat16 semantics.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_helper.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


