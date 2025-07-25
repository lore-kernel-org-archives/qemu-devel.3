Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310FDC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 16:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLY7-0007pt-8d; Fri, 25 Jul 2025 12:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLY3-0007pS-3G
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:45:31 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLY1-0007Z6-48
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:45:30 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so1959410b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753461927; x=1754066727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HqMiNDfkvMYOuomvAPL/wjINCW5poUXOI2FNYtKyvgw=;
 b=BJ25IwIxHFXEuH0JbWuplr58/K+Byu4qAZjST+5aHtotAdwRZmZ3Lbe+fYBfdFX3cI
 jhQujJvjrKkWbFtXw4HpoTT2xXjPeY2KktNOn+BLEjfG8OTzD10vJzVj7XpDxzBak/8Z
 qw5V29QOtIQaGGZ9LiCAJ2H1q3RBQoiKLhjuLbRqWKrFD+pSl3A/4qGq4LZ6TmMow14a
 ybL0Ad4FW8XXVaGrbefY3gfEeDlFSsPmx936xyVeg52ODy8nvncvd13ZIb0rDGlrxg6O
 bl65sh7db2Bsl9jUqa1aY0bir0LoVPKNSTPMzB6gBf8SxgGc45E7vylEExmNjow8QSMu
 xLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753461927; x=1754066727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HqMiNDfkvMYOuomvAPL/wjINCW5poUXOI2FNYtKyvgw=;
 b=mxra54EGxpaZHtHYYakoMPRgHb++30xIlTCB6lxXMTY6KtrYqWjEcMz3jxHqkMXt+B
 xAaQMleu62zi/WJCIpI0dhijpsWCa9PnzO57XKdJLMLVy8/cNK9eFHhYvXjfMEYC/RxP
 wQbVPLi46jyrTaCX3D/aNAls1hZtVtDYXJU2VhC+S7Xeow/K3I1Psd61BT+1vabzgVgR
 21dr6Q4WvyaHJ/TcqvNDr05fZnTq4pmOp+mz97J5j2H92LBQeI+F8aEJXHsyuI/MFt8w
 LnAcfqmCc4sVedp2J9pmK9gKftVx8nGtLvFW5gROF5gmu+0Y+7dX1KUfcU4GibmU9h2Q
 MYtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbJWnjF1xcKLMXsRernceGmXLb627D0VyFOU+mPiDhbYq27uPO5nGiS9bgHZlHMG/EwvwOBPSGknFu@nongnu.org
X-Gm-Message-State: AOJu0Yw09CTCTHWcaE9WUbDZ5XvSIQ2sJ2tlGG8967WDgYqAVPdJaj+K
 7v8Jt4Eg001/sQR5bi42szYPUD0hef1L/kuSXyVDG0OacT8Jjzgp2z4UDNih5OMI7kU=
X-Gm-Gg: ASbGncsE6FIgNinjYTjccJB6udwh4UcNynrT8s9NQVERZFcdur9D8zI6V6WNG8xj4Dv
 W6R3E22ls3FFeuxiJKJg0VTVo1jLuJ/H+c7i4fKnTTILtbpXjRLy6rfuDY/Td4/XOj0/BNnXqQS
 83G8KYyXS31FpVWmGn/UopwvAf2TMIAlu1mK3HmTcQTKGzfxuAHrE1183hFV8nUUzO9GB2dmG/+
 vfCTNiN4CGbNToyny8O31IKTdCCQzztBQUlcjkDpPjDma5NyOIhYaLr+A7PkcoHihhCvAss3pUC
 oTUtlLdDuvC6jaddjlrUVlsBqaCd3T2ezQZ6fKiL2DHdIKc9BFRdRQDeW1IXZ1tzYjOtl//xrFb
 WTlcmbA09HKGj8xsW5qRKKhDv7ONrGQItAQK59FZeXdrh87va/FO0tvUuNl25ARzEtp1Gh58f2E
 ScQg==
X-Google-Smtp-Source: AGHT+IHCLjKrdzORXPbZl9RJ0qC6P9MAhci2Y8MqN6UofFavBT6+yszssqBk+tHirgxaqr6iAdX2mQ==
X-Received: by 2002:a05:6a00:2383:b0:74d:247f:fae4 with SMTP id
 d2e1a72fcca58-7633636aef3mr4303963b3a.4.1753461927019; 
 Fri, 25 Jul 2025 09:45:27 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b4c86afsm110007b3a.115.2025.07.25.09.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 09:45:26 -0700 (PDT)
Message-ID: <13da0e27-1775-48d9-a458-08d18e09b984@linaro.org>
Date: Fri, 25 Jul 2025 06:45:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 3/3] linux-user/aarch64: Support ZT_MAGIC signal
 frame record
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250725142240.3760452-1-peter.maydell@linaro.org>
 <20250725142240.3760452-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725142240.3760452-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/25/25 04:22, Peter Maydell wrote:
> @@ -428,6 +467,33 @@ static bool target_restore_tpidr2_record(CPUARMState *env,
>       return true;
>   }
>   
> +static bool target_restore_zt_record(CPUARMState *env,
> +                                     struct target_zt_context *zt, int size,
> +                                     int svcr)
> +{
> +    uint16_t nregs;
> +    uint64_t *z;
> +
> +    if (!cpu_isar_feature(aa64_sme2, env_archcpu(env))) {
> +        return false;
> +    }

I think this is better placed with case TARGET_ZT_MAGIC.

> +    if (!(FIELD_EX64(env->svcr, SVCR, ZA))) {

Need to check svcr the argument, which has not yet been stored to env.
You even knew that from the comment before calling this function.  :-)


r~

