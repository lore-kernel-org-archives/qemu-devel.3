Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25426C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5px0-0001ie-6A; Fri, 18 Apr 2025 13:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pwy-0001iP-M5
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:56:28 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pwx-0003b7-4Q
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:56:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2243803b776so33355545ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744998985; x=1745603785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wdo8MuvmTbBAQg/6PRMWyDjc6MpBdISCGbeToyuJN4Y=;
 b=ueBR19YXnOv09dQmPJVnVfvlUUXexY9A9ZcdHkOJEf9cgw3Sh435gAmveKZag2wXfr
 W90Fhx5p9NGuRPtZ/REis2MbjeEZsa4yuR/J+HHBc/ysL96udbGOtL80DlmrGSef6TL4
 QjA0HBrET4zuO6GVbr+laM7bYPApaLf20nSg7gHM+IA1iIcLQCyrL5NC2AI1eOXT9VFY
 9gk69VXsceDpj9hGvMZY8S0Wa05ZUoBS0FHME5u10a3eGRhN4hgOk/1uHfxMZ4MU/qhK
 0XCzeQrnnjutPjmFLFWuirvMP0unPjDNduHl/cXGKE7rI6qHduaxq59jMOltpceOH4Ge
 uxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744998985; x=1745603785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wdo8MuvmTbBAQg/6PRMWyDjc6MpBdISCGbeToyuJN4Y=;
 b=fluC4mUZuv2RIpUFWKLFr85BdKyhkmJTWcWanDwIKpHMuU1oXbv9sw2qFIt7QWNaKX
 F8MFfYQxwL1/c2XflgmLi9E+UPwyoNM9/RgWH9YL2+X/Ist3gwv7JGbQ0AURd+Fqi7UF
 C5uD+oe9rfeF2Y1WOmmxKoJlTbpWRfYEnuGodQjz7Q+wTbqOh7CxaayZhEEEUzCSfiBB
 q31ybaJZpIWLSCx1b5pyq3gEhALbGrp6Db0kB9bTa1Ouwx9TOoew0Epng7wGfyTMeJBu
 giwGJylTuV9B8tw9FziBoW6hjaHjrA9J3jeqBxaA68pI0nbqtSSoLEs9gYW5Ozr/yNcW
 hfqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTLCLkhQxtOhY/IzxYEd2KIAC74QMXocIh1qC2hvujF98HKUeJ99+bdOEwVboAGLlsPgONvqeEaVVr@nongnu.org
X-Gm-Message-State: AOJu0YzDsYsqrhTcE4lEkKGyUDntQKoGbGNut5qSUpbaLEKNRgJcVUz0
 LU9V8pXRCULJvlw2Cwg1vKqACIVQvsXAbRvCTU20OpXmFEX6ahQcprM7XPzA77w=
X-Gm-Gg: ASbGncucfN9cx9zoo1rc3W0/dfOn/uPEccByVL5HWMqkiveX9Zta4AFCHjqgThSfx+h
 jMMTlyHAXK3QjlvbjVQm3U0knaeAgicBeI8A6ERFzvIOLfAN4rptupOKQ5JfWF5/DCqNa259Weu
 +zETqFxaqsL/Ky4+9WSEf9GkygOIkmSXuTzvYOHMiyDJ4pBwOxMrl3jHSwk9UyrmMNh24dFdULj
 clj3u78fbAA1TS7Xb3COOPs5K3MmbJ88JNdhhfbvLFO7npbJIJoErXd8ZkDdRn/ho8ILVQhQOK5
 mvH6m1tMIl9QIQNjuQXKvfRUP3GRyz1npxIdAhXLLZ6QTYnoIBJpL2jXh5YmhQiRvU6qrfh6Xwf
 R95wJua0y/LAxBF+DGQ==
X-Google-Smtp-Source: AGHT+IGLOxSQDAtwXm3tAR9yMgBGdnZbQCqEH9pIuMpOZ8Kqu+PVWmf93QSz+j0isj5dvJ02r+S6pA==
X-Received: by 2002:a17:902:ce82:b0:223:6455:8752 with SMTP id
 d9443c01a7336-22c536420c6mr46332475ad.43.1744998985636; 
 Fri, 18 Apr 2025 10:56:25 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4b9asm19621995ad.156.2025.04.18.10.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:56:25 -0700 (PDT)
Message-ID: <5f8246a0-5120-444b-be34-047b77660a36@linaro.org>
Date: Fri, 18 Apr 2025 10:56:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/ppc: Evaluate TARGET_BIG_ENDIAN at compile time
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417131004.47205-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/17/25 06:10, Philippe Mathieu-Daudé wrote:
>   static inline bool needs_byteswap(const CPUPPCState *env)
>   {
> -#if TARGET_BIG_ENDIAN
> -  return FIELD_EX64(env->msr, MSR, LE);
> -#else
> -  return !FIELD_EX64(env->msr, MSR, LE);
> -#endif
> +  return TARGET_BIG_ENDIAN ^ FIELD_EX64(env->msr, MSR, LE);
>   }

This is wrong.  You wanted

    !TARGET_BIG_ENDIAN ^ ...

Likewise in the other instance in translate.c.


r~

