Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3FDC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx4dz-0003j5-D8; Tue, 25 Mar 2025 09:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx4dr-0003cT-Ah
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:48:32 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx4dp-0005ed-I2
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:48:31 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2255003f4c6so107547005ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742910507; x=1743515307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Czzon5K/5x/I60Y0Bh+t941XjCpVSTS9Se92DssohBY=;
 b=pUAQVbm1WhDsupAWdcMyX15IVYjHa7ENsxWmi4d7kapx3Hlymt4OrvsQeSSEkfx9ns
 5p0wtnPyP1mscAQTBOFAF1IGxasJgg2XU4E5B+IFo8H+At0+4OUsZxdw0ZFNi2qQX4uF
 4AUOanns4WfPxAzUOlIBqOOzxnvvUoMmGuJZD9ZPOiW9ZlnHlKQSdnWM68+Jd6Gvmk+R
 8NkcLQK2OfVxTCBGiCXu71rRKc0lj9banVaUfzZuF93p+l728iiMNuj68pQroOOvYPDo
 /bhcw7nPy4YR/nSCyRcQ5pQkKXwa6vfJEOguDHXnAL23VMm7ptfYzyIEfeyVfrp101Sq
 Gs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742910507; x=1743515307;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Czzon5K/5x/I60Y0Bh+t941XjCpVSTS9Se92DssohBY=;
 b=CvKhSf+LwZ9UUVUtoIdmZL2IAfh2cPnoY/CqOCUJaAxc8YFp9qZviuf2tB6Wv4v6LL
 TR6RuJheLsy8BgOe3tc4e5+Rko/voZLN0MGhjmh+/Cu8DDuyrpXhw72+t5W4Lwu0pJom
 8fZuddfgxcN7zci0acS8X05Saq4DKrU4JSQOYfFjUkLEG1cnBcSY7bCAVpP6/GnqgMxx
 8NYX6DKRB2ywmxmSaU84J1SCUlyudHEnzFwVWs4QS/+h1X1R1KEchvspwfkTSp7StPia
 xp+98KIn/sSPWi6RRYm08kg4FBdXmx0EkxzJ1Z7P/0IbWI7CcKRyAwy2Z/srlJzM/N0w
 dY2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOfA9HWnaIfcSf9OEH+RMGUNFlNjlXvSo0A6AkSxUhefHtKX8EsI/nBbaiAOJAEoVrwajtW0wFNeaG@nongnu.org
X-Gm-Message-State: AOJu0Yx0EHMIYCk92bqeJMIyt/QwAfZpeaKYAIduBW3nLw+fjc30T33m
 5Eg0dkzfa1eYB7Y02e35lrA0gqwNOy5st0JztGhZMplih70u+Al2QfxfY9U8T80=
X-Gm-Gg: ASbGnct2w1o5i0oUYpPMoM6ki/GKJBIIB3iEMc/cuGA8JKIh2MiZYa/spUWSjcgp/qM
 voljHKrRJWRuxDuG8wRNkTxAtQAp5VZhxRQWzIQeQaZY5PlDMZbRU5j9WtboZq7USkCaiea7ic4
 v6LWCXIu7k2o1y7qtbL8cHb6In+a/KaCQpPzjZsovW9X8LyaVWp26VgeDffWpGSq2+UNF/neG6l
 /CCVpdS67nzsUjuLwYUG79coFrIdPjG+HKKEsS4mfXIV+rS5WYXQGPlSkoYEbHHFMgZm3o7Mgbr
 1UzCQSKvVqcvm892pXqLz4vi94dI88jeUJ//VKmLPBPS8C6Sdwc9jrkKswwSsfJD5ODGPEgyuvH
 qieD6fXHn
X-Google-Smtp-Source: AGHT+IFcdpYS+uKF+J1EgsZI5eiNN9BVElD3ZDRfyrrFJLZQviH4BtDOOL8LpWju8ZmZttT4DsLLWA==
X-Received: by 2002:a05:6a21:4603:b0:1ee:a914:1d64 with SMTP id
 adf61e73a8af0-1fe4300f794mr29581203637.28.1742910507190; 
 Tue, 25 Mar 2025 06:48:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a27db581sm9034954a12.8.2025.03.25.06.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 06:48:26 -0700 (PDT)
Message-ID: <7df3dc8f-c4ad-47fc-96b7-7ddad3274d51@linaro.org>
Date: Tue, 25 Mar 2025 06:48:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] target/avr: Move cpu register accesses into system
 memory
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-6-richard.henderson@linaro.org>
 <fcd2d092-f37d-4912-97e2-a55c475e0540@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fcd2d092-f37d-4912-97e2-a55c475e0540@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/24/25 18:07, Pierrick Bouvier wrote:
> A simple nit, maybe we could define constant for register names. This way, it can be used 
> in the two switch for read/access.

Which constant?

   - The absolute address (0x58-0x5f)
   - The i/o port address (0x38-0x3f)
   - or the region offset (0-7)

?  That's where I got stuck and didn't add such.

> By the way, are there other architectures where cpu registers are mapped in memory like AVR?

Not that I know of.


r~

