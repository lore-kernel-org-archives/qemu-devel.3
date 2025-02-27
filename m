Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750AAC197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnmDb-0001vn-6N; Thu, 27 Feb 2025 17:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmDO-0001rw-96
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:18:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmDM-0001vZ-IY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:18:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso9701175e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 14:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740694723; x=1741299523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hCptzdxldMl3pzZW66domjqhVCcDOR6hIsxI8YUcwI4=;
 b=Sih3v+FxDGpm783AYbpFRqbn2iTFOnmHBUFCPBFrUQfPBwhZH6p2U5TdfxK+jYYo+o
 oLup9LZQtD+LT+Ek5+Zq+8aDaaufZ0NUgAVkz02GK4u/NBbXfhm3X0TikBUVqpe+iebA
 Rq4zep5P6ANOlsZAF7y2oB08A/X3y9OHJrNX5ghnHtZCtGHszSElMPM77/hpUg1CBzJV
 JRn6ozxPBGo8mTxTTCpaCp34n3uF+qH9fyv7qvCgVy2EQEaiUJKLJ/yQ15Lmb/y6H8FK
 DO+yW0PC0YyEec2wnzITEcWjkTxFd8xRPOjh8KE89ys2MQxtRjijLHC01SzWXI/x4Nnj
 o+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740694723; x=1741299523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hCptzdxldMl3pzZW66domjqhVCcDOR6hIsxI8YUcwI4=;
 b=kY1p035lNFLWfvgMIz2dJfQpKS4WzZ38dSjFwDRzCdmeWNIEXPCZT2StSOfmBg8/SV
 GpSAm4F9O3FOj34aiwS8FTOW2XlE82PESp57ltX6csseRkshBiR7vnPTusZwyvXb65C+
 yrnlYlAUpQ2/p2t3DYMmdKAZZP3VqDJ7ij7p8Xdf5IHu4EQTc/gDiDyE1Mg5Ga9eLB+E
 nphitzg4J6qQOL+8U0iteVaJdP/y4qAimdL0UAnBUHMDZD6Fu1nER+6WQ/KNvIMR3DhU
 VBrRqbEf6Mqdt3wuv+IywBlfMpRnlxaylbirUTu9vhuUrqAPCd6MwOHvwoliFbXtGVmD
 o8qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVga/JcX4H2c0iBZWaiWlkRkj5pXeh7F0A6aOhN2HQteOWTXwxO5WaOXba4xEuXTm7yaP0JCDWI7OEq@nongnu.org
X-Gm-Message-State: AOJu0Yw8aaAGlESQfvWEv+0c0rioZTe/GHD1KlO4VY0XLRp1/rp5q4nA
 4bU1JY4hxj8qw8PesgSLD+mcskzzdcug6S+XwF9wZgdI+FlUOL/1UI8Y1q9fQ1M=
X-Gm-Gg: ASbGncvND3bn5Vma16+egnfjQMJOivxSgKfvuQzX32Z/3dHrtNZeH48PfkqMyw+2aIZ
 K7UzY4QrTo5CyHgcpVoVnC2d8fjTbLrl4wsJhf64qsnHP0QygYFds0DZFUcfTrmJLdz/TUuCn1j
 PMCoos/64AQgFYsnRTe3yUOSnm9c3TbHS4C55QZrU8jUpmHpIbtyxDRa+JuMOmPAuDR0BKqXhjO
 sDpmhOds6FXf3dCsf9CFhUMaj8bsLYtYO/hjCjDOukIGvcLLhBtPx0X2smRJW+RsWpuZu3DRN/D
 8Kil86pOGYswEUoWOp/I603FNS/MEx3ernFnyY0rgfIufbgq/2ax/BLUaKAnssnQ4qtMkg==
X-Google-Smtp-Source: AGHT+IECS8nLQgkPPLd3GsXXz8/uFE3Tef4hIQu9hXGBC7JLawTSnVB3KyEHZqIQcz8qrJtvXPjgHg==
X-Received: by 2002:a05:600c:4f89:b0:439:9951:1220 with SMTP id
 5b1f17b1804b1-43ba66fa281mr6982655e9.13.1740694722654; 
 Thu, 27 Feb 2025 14:18:42 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6ddesm3286202f8f.41.2025.02.27.14.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 14:18:42 -0800 (PST)
Message-ID: <ed2cba1b-f0f4-4b33-9452-4279f84bc088@linaro.org>
Date: Thu, 27 Feb 2025 23:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/arm/versatilepb: Convert printfs to LOG_GUEST_ERROR
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
 <20250227170117.1726895-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250227170117.1726895-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 27/2/25 18:01, Peter Maydell wrote:
> Convert some printf() calls for attempts to access nonexistent
> registers into LOG_GUEST_ERROR logging.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/versatilepb.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


