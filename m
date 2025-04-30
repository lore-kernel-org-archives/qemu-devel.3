Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBAEC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACTc-0002T5-9n; Wed, 30 Apr 2025 14:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACTT-0002SC-K2
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:48:04 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACTR-00081w-RZ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:48:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso245812b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746038880; x=1746643680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6JkT8Xl1TSD2JMlrucYuTh8fIekL0brqGTy6sex4sQU=;
 b=Y7f44WdnwvwL0FwlOsIHYF4zF4MC17JQY0pwQHZaLJra0eUqLoArgEIYY/hVeb4ZOi
 z9YsyMpaVHmLAPB36F5wV+YmMMSg9jkrljiKbwIh0c/xc8AY6mISBdlUWXo7r5ry71B+
 EebcwvmBY+E3dymUrwwymDUlkUn7cUd0O+v6Wq/hu6ZJZiSXzI75Z/sT9yP+94WJ0ccI
 SNvHIXbawvgKJmzJCxY4DEN5w6BjrV7OqqgX3HHZNxEBBRZXLWwIItmneJjcEyq/Rtrz
 9s2KHdeUhGgYKOO//Osh202aP4tr1r43rs1UBqghtwxGFqmBdwHW2vgEBegA1ibThMLU
 bRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038880; x=1746643680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6JkT8Xl1TSD2JMlrucYuTh8fIekL0brqGTy6sex4sQU=;
 b=GjWrfwGDaUwX67naFSZiCOFHTpzzMRTjVFuyfJXTNFhRrUj9jEF5FyrU014xdB/1oy
 bf3hhs9aMSz8OykJS502rBZJzXGqFF3Mb80JDYQuIVIumV4DPikL87l5+XbqwOWvFN4E
 b7cvnmD/WVPU6dfHy/mv6TeNDum6RKVYaH3vTQxgiIQxpaYckRTUEc2O3fPxEN6qaj6B
 NxDoijboc4WatjfRMoGRoSqTSkmCwRTSxlRFSDSb+r+f6B5Nm2UwtV0yTeGBUrjutnOZ
 fHdtihmjInyMWI4x4+dqVyppgTQVkk6XVTRefLsnhGK53V5xnjbpkUcacX2l+yQJcUbV
 ISlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9f9MmSGa53YvJQak2uHWxEcyiwjp8LD33LpSottL98lJQWT7LpIgqv+dRqc4fRBFrmb2Eib1yQWOv@nongnu.org
X-Gm-Message-State: AOJu0YwFMCeKXJSeeAqcpKW1ZqVhMVYsq33b4lzTP0QxEjDpniQuovEr
 Vmzn6N5N9HCz3Ftolo3geS5TrfH1XmHl1mpwriFKkK/bilukNf1Mxazm810/fw4=
X-Gm-Gg: ASbGnct883qYQXe0kql7iuj0xkBRE4mQzWYn3H/iGTGDrQABKL8KdmJ672fCgqO9Ev4
 cibUlyOTQC/cTjHx/JI8ttJsjMd26BVTl+swtJB71J8uHuohCym8onHgBBqJA9RLpzeeWFB3cHE
 TQUKqyvZKVdP22pxmUABuOvUTsY821FUoSva3llQe7RgB6hnaC62dxY0l+j5tSJ5UyLU7VR8vyI
 fJAp2vl3SPgTVcNrj1aJoYXnFd2jn4sR7+KFBjUjaaG6sCRz0g36ltc8JoVBXOdjblTeCgm/hxU
 D/PV9a7VGWqMjT5dNaiACS1zuoJ9hWBKJ8GPuSNDvuaFfHFpBDd0Fc7mlWETtr3B0Aq7XlNj6Ix
 A+++t6p4=
X-Google-Smtp-Source: AGHT+IHBg+zhfXus0cSoBM1olqTbRBiyZ7d5GFmOywBPYAuNBzjBpfDak2xp1ElEStVqIw5M9m1Wjw==
X-Received: by 2002:a05:6a21:398f:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-20ba6a2019cmr465941637.5.1746038879803; 
 Wed, 30 Apr 2025 11:47:59 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa80fbb5sm11036284a12.55.2025.04.30.11.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:47:59 -0700 (PDT)
Message-ID: <8520456e-3e44-4028-976a-45d683610a8e@linaro.org>
Date: Wed, 30 Apr 2025 11:47:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-11-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> new file mode 100644
> index 00000000000..fda7ccee4b5
> --- /dev/null
> +++ b/target/arm/cpu32-stubs.c
> @@ -0,0 +1,24 @@
> +#include "qemu/osdep.h"
> +#include "target/arm/cpu.h"

Need license comment.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

