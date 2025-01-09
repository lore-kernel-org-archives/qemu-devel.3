Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136C4E7719C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1YX-0002T4-Fk; Thu, 09 Jan 2025 18:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1YU-0002Si-3x
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:03:10 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1YS-0000AF-08
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:03:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so17616225e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736463785; x=1737068585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CiAk5iRd1bwynalMMts2Qew4YN57TtBi23qzBlqTbwc=;
 b=oM4qGINcMhiHA7SvUQMr7BKlQogyPPtxzV5yzlOo44qXZcMcuVgkExj6J1anql8Woz
 qrSvSSKdYtbsAgI7TEjeG8QAffmb3kp+3scoqPSr/OdjcVYYMZS+UxnHvtUmjzDiqbfX
 g5afFkD8JlKzflmIlKUt1bxH9pVF8tzVZvtfh5QnvxO3Z76bvnFVmXhA5MgouDJkx8ir
 kmkyXL3cMS2Tlw13vpTEM/SEuzpN+S4oxJxQQAYJGJbo0H9YzIRVqsHcdpVFnNRRgQ+Y
 5n5AwPH1xekyaJDvk6BQIAk3PfRAJr+hu3Zcrkf1JziTaH+eVcfL5+sSlJsehTQWideP
 +39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736463785; x=1737068585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CiAk5iRd1bwynalMMts2Qew4YN57TtBi23qzBlqTbwc=;
 b=Huk3H8QYkHnfPVA9kShhNiKZ5uWWkdZ8/BpJszMvCddIHdB9EtqfvCNkuA55nZaFUQ
 bTZQfO8AIRmbzJn3PVZlK4db+oE4kAO67kwE4ZYycncCgoiXixCE2TK6DEZvu6mNlXe2
 66VVI7L+/1ToZ4Uv19ZAG68K7Bg69FQTPRLIqhocF2pSUR8fujjv060qvgUl7eCaGaj+
 DwBnuklc5OaN5jLFUS2FLgh0adcwvH1HtBfMMQN0DXMKvwN1xFiVHZ/EG7ZKPZH8I9pF
 993rZTZbQy+TFohopd8LqcHK/zNjQMf47CeczVHzGcrpXElWTf3WFA4/DJfiD6BrDmPC
 qWGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPNyoMSt+kqJLkEd1RdmkIMNWe8KTS1ZRrXO5NILGlJ8aGgSWDK/GN3OIEy52025SnHm/uYfYnXuHI@nongnu.org
X-Gm-Message-State: AOJu0Ywf+YpjbTPTaliPHfJr7KtyzpovJBth3pYh0P6DcGKILMcHfTBl
 PpIfAXeuwC2kix96UuuQIjcUZDb09xRs0F3B60frQTUQrTSvXJurB3Zj2zhQHbE=
X-Gm-Gg: ASbGnctmLNSF0mbxxqUVm5otsvz6JG7RLzHJzp16/Iz37Rx/zb0G/KpbAg8saHZRppm
 svk10auusecLBWleAOiqQF4ZHMOFE6aHB/cd1FxpoVv+Q36uM8l/nRgMIFSetA+psJPtkQxEcLr
 cEiQgC+8rRVUORurmKVSALetKFfgpB8Mzzo6ekJ6wVoO87zHA4qn3wF/wYd4ZNCemKHCX8HffGx
 Uix9QLA0A+bUuAnqWPQp+jsfF+ThEfVg/2AdEFbAQZpJxvtinH2n7VViVjI0Mp1gZmZojHgt1cx
 hIP+F8/ZjWZiZWKMjWMbJuBceMY=
X-Google-Smtp-Source: AGHT+IHDVm+ba+3kYrd7tGhyN1mWfrKaUAgHBKF9i8z+tG17i0X9rxeSVOiaPobzat8CuOQ1Ih891w==
X-Received: by 2002:a05:600c:1f86:b0:434:fd15:3adc with SMTP id
 5b1f17b1804b1-436e2707303mr68121485e9.25.1736463785117; 
 Thu, 09 Jan 2025 15:03:05 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92f7bsm68920605e9.38.2025.01.09.15.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:03:04 -0800 (PST)
Message-ID: <f1263c54-b79e-4801-88b1-085812898266@linaro.org>
Date: Fri, 10 Jan 2025 00:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/81] tcg/aarch64: Provide TCG_TARGET_{s}extract_valid
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-36-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Trivially mirrors TCG_TARGET_HAS_{s}extract_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


