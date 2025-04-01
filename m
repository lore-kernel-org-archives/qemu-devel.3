Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB343C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 17:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzfgR-00031W-Pj; Tue, 01 Apr 2025 13:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzfgP-0002zK-Kd
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 13:45:53 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzfgO-000177-3v
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 13:45:53 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3fa6c54cc1aso3200340b6e.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743529549; x=1744134349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wsdr0v0a7qWUPkXTK30pF7Ubf1LqrBTEBGGQEFuukH8=;
 b=TABM5gTfqwK6xubCHhRZHfp4gpTmG7TCq6Z8/GL+wwiXCXsprBeTPJfGCwSdXFXJ0r
 mqe5hKfrQ2PK7flQNSO2WaGj947v9Tt00QY+ldrABFOHbigawF2zQvtFpzbuTt7aZqXA
 Kb6HVa+hGjYfIEz9qYTVYwBSXDlKvI7g9nFX9l77ACbUMTy0xjyPXADParRrQZEMgKU7
 dOT5QhRM9nftep3IbWS033+hvB6HwKBHkdfAvwlGNN2qi/TZ1qIFXl8fbYeriU0+0jpl
 WTLRf0zu9M2IAjfN2/r5Z2hYzX75XJd94c2TfStPMel6gd+y1ysvcjsuWShhP1teb9KV
 WQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743529549; x=1744134349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wsdr0v0a7qWUPkXTK30pF7Ubf1LqrBTEBGGQEFuukH8=;
 b=BmyOIi388Iaels9zqoo84NGJJ5xChv99qpO6QzBPKXuymhSgL396I8SUqNchlOrNwf
 n9WI7oKBykrzEkwitJp4CdaOa/i2xmyUFLJ/LhJqzS6ro+Uovdjrk29VEZmf1cd7TIjC
 oKWzgvOtHPFmN2ED5aLi4UzUsWM/54V+cLBj6S3KgAJ82L6RW133BMsX1LxFrLb3tajQ
 QoaZfiDt1e/IbC3ddERlwlvZ83p/zmZWqR5Ho9bYHIZNoghQ8UCtWb3lPphnCeKlPdXX
 Ghtsdd+ZdA8GclpxFnIcE3TefdKZsmcPov10PLYj/aCoehveX1VALgDWih3JwyESowAu
 mNrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhn9IWTnUGe4nr6+dus1d5Fm2UwgtPOhitfOAcZ5TqCpXGDUZ5pr9RPTI18tsPc8gzmVOKf3QJXdEH@nongnu.org
X-Gm-Message-State: AOJu0YzxrXHRQxtGzmpZJNtkaHwgBds6QLuhEaKRLDHA6G3S0yQtL3ss
 OOUnam3f98Lndhp22BloFgdBOtFkBO7IXFs7+Nzou0u+XANFvIOdaakaJi+Je+Y=
X-Gm-Gg: ASbGncs/CcFumRHIDly8Nhwci5oZ/Ln3j1SI0oslo8+SX0meWKin2Vw/HKWXy6JEGFJ
 4va89ASyCTZjku3YEUn2V+gWf4zZyaRGTAzP21dQvq6DlRlUAOhF/hpLhdTzcL32NRL01P9MZEN
 pHc0IbO6TM7eKkpSndur+sdmqCnYfmwAZN4VTNKvVA64DpNW1Iu2WWqfew5r9LhXHJGn1oW3heo
 iRfU5kMPCGKKAAd8dF+apxrnhGeuAkbHqSpjrNioOHhTlp7IW2HDkML1D3bafJ5FxZbPaDSMQY7
 I7um53QmnrXfA2ms6oFzsQPkVIxn9w7r6y0qS1znDFEhc2tssCteKFuR4Rj9hgaDaAqSy+cy+9m
 p+BzgEOV9NnEwEav6hIDxYM+yy4MBZKTg
X-Google-Smtp-Source: AGHT+IEVL4aLbLf3HbyZI6GnPGYM4NmfDT0oudrAqKla5p2N85gsoW+juInJPRqGcS3Ljf5ZFmPagA==
X-Received: by 2002:a05:6808:210e:b0:3fb:49cd:6bf5 with SMTP id
 5614622812f47-3ff0f664399mr7731638b6e.32.1743529549290; 
 Tue, 01 Apr 2025 10:45:49 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602844e69dasm1869845eaf.3.2025.04.01.10.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 10:45:48 -0700 (PDT)
Message-ID: <2cfdd4dc-1e4b-459e-ae77-4fab80dca750@linaro.org>
Date: Tue, 1 Apr 2025 12:45:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 0/3] exec: Restrict 'cpu.ldst*.h' headers to
 accel/tcg/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250401083232.33773-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401083232.33773-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 4/1/25 03:32, Philippe Mathieu-Daudé wrote:
> Move the TCG-specific cpu-ldst*.h headers to
> the accel/tcg/ namespace.
> 
> Philippe Mathieu-Daudé (3):
>    exec: Restrict 'cpu-ldst-common.h' to accel/tcg/
>    exec: Restrict 'cpu_ldst.h' to accel/tcg/
>    exec: Do not include 'accel/tcg/cpu-ldst.h' in 'exec-all.h'

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

