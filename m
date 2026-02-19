Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D65C531D4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBgh-0007bo-Ff; Thu, 19 Feb 2026 16:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgP-000737-0Q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:38 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgH-0002eD-5e
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:36 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8249aca0affso796051b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536928; x=1772141728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DCYTBJ3hWBpTCxlCFEXbPI9fJp7uFNlyYhn/T2zrpiE=;
 b=S3f8GP6MFiGc7T/b0owZZkl1TSpC0YiH0sWLS2OHvU7YHO3Z3EgYwOW39oVC44faks
 9kAbzX5r7Y5iC2aDdljGUSUe0q1XjdnWJUht2z6hrarHKTB1KQyWBx4c2hzShdPTjgR6
 MnUOZBrvy5NLZCyAXevHs+iPMNaa02d0Qai4xHpMdOf9yxiVYrd2fDGFIbr4J4dBhyRi
 +hJ31i2QISHUPPidx4CkFAONQwOkNQz7/W0rrAYcmRGaA08HOFFYQdH9t4zSeGUTQK8j
 oRF2lAHgKw34LxX7s3TEpAJ5bVQPxBUcwY99AGhKXuFiqnFgrniOJWyFQcx63wm085NL
 hzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536928; x=1772141728;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCYTBJ3hWBpTCxlCFEXbPI9fJp7uFNlyYhn/T2zrpiE=;
 b=wRGqlvGUwO8SSIDOIcsds/nV++cOT6SUDDeLeyxsm9b6f6wkR0rg0edsj204pqHcuN
 E8+OblC2/yjxJE8u+wWoTy0gsPA9+/PIkL4uuXW2fHOOKMASRsQMMag9HPYMwz8PaPJg
 DW5A6HmUrjOmO8giqBv/SW5nK2CBxBIVc/E9In+dsh1qPOi+9kNBqi7VR97r5Hiozo80
 c3DIYy7npmdiF/bLcIFFXCr1xAnI/GPbjuS1Fjg8bxXjXM5W8P38wREoFAj8q4rXBej7
 LQsT1iZnIYlVpg5RcvBKNRIUXAqRX1biPUpfy8jLvgdt+FDRuEmiaTVYV6FePqU/GWja
 ymVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW9B6gbgeoqm6JV18qKRlcdEch0rfJJb0BpHMyps96odTu9VD5twQ4MPnrbsDNlppgByRgknsIp+aK@nongnu.org
X-Gm-Message-State: AOJu0YxUiVHpRp2bct2oVLWaeW9Ru6EhpgeUm6sjXU9M37VZB/aS2SmR
 +c9koI5axoj9R6/ZPJoyOEqXqKPwRg/JCu1KwkHFqRiTZ40TD8OWgKV16KFabW6No+E=
X-Gm-Gg: AZuq6aJZkcMWb9dLK9OeFNHdBxjQNR8UZnkkq6vCmEytLI3mn+GqzpVTkyoFANIQmj/
 3Cf+fDiU+WYoKIJoCgv3mhy57ShqYmCWcexIViTnuiq5qPfjyw+ZC8lJTOWin9TLEY2Sry47ivI
 SbEepSZKRXdLm6frabLFVN4N394psWG54psAsV730Mtii/twgS8w4Qsm9K2tB8LYk9CdR9sxsgL
 QOfCrGD1/4S/jFARuNy5InwrUMf33/66Bb8RV2W4SLjayWZDjUAFB6IYU+a6M9Wa/gYhk30uePe
 P72dDuQGBIm8+6Q9R96pkNyA9A2NJfJoR0HOOh7QZLzr0JzgkTs/nYCjO+8MTTZWF/1YyTtbtg2
 Awx+XniP0ChegGVCp/Zv2iRGwg6L/wTzZzyK12e8xOJZuTH4wZD7+1jbNEtwMntiUzZvyi3dxcv
 WTdFD4ns/ZUFNybPxkGWyso0RgjSKWO2jH+PkTL1ioI813dEkd2M17gSm/o/UM4ZomDmFC
X-Received: by 2002:a05:6300:2204:b0:35d:58d3:2904 with SMTP id
 adf61e73a8af0-394838e4da2mr19421968637.31.1771536927595; 
 Thu, 19 Feb 2026 13:35:27 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e52fcff01sm16619125a12.2.2026.02.19.13.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:27 -0800 (PST)
Message-ID: <8039c526-c19a-433f-83a2-312e8b3e438e@linaro.org>
Date: Thu, 19 Feb 2026 13:34:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 49/50] target/tricore: Build 'gdbstub.c' once for
 system single binary
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@rumtueddeln.de>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-50-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-50-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> There is a single qemu-system-tricore binary, but by moving
> 'gdbstub.c' in the target_common_system_arch[] source set
> the resulting object can be linked into a single qemu-sytem
> binary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/meson.build | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

