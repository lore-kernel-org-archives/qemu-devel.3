Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B36C83F1D
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Jul 2025 21:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uahlo-0008G9-6k; Sat, 12 Jul 2025 17:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uahkA-0007AP-SY
 for qemu-devel@nongnu.org; Sat, 12 Jul 2025 17:26:56 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uahk9-0000YA-E3
 for qemu-devel@nongnu.org; Sat, 12 Jul 2025 17:26:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so2692250f8f.2
 for <qemu-devel@nongnu.org>; Sat, 12 Jul 2025 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752355608; x=1752960408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q6vGY1B+bXe0vZlUaZxSWoq9+p7SL4/nosGYSCILT3o=;
 b=WrXzmOgPoGtqVMhNCbM+rWxtlTyZ2mNWznDRMBebUhHa6CcCPO2OL1POb19AYe333X
 XgPbRa6ERQqWoDPDl63mB/BAZci9X2OKHN7igrokPBpxlhV9GgZ9kxNFnmMqUkxxtsET
 nHmTX0CrefVFoJz0x6vfSzwvLKcigx6VgFX0moEj+2fa6aYWwMAX4Mk29GKho3dy2ZkP
 voL7mHCFUNbcFOI0d8eF3xygwjN6fmulUeGi4WH+J0cbqbfTAo8XXCVsMHbwhgLmJsJe
 n/VzdWj/AD2ZhCyBZlBp+hsgI+Fy8uC5pVsXHdSsGb+GptSOrl1CnGXilNxF+1N6yCxz
 vLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752355608; x=1752960408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q6vGY1B+bXe0vZlUaZxSWoq9+p7SL4/nosGYSCILT3o=;
 b=NsgUY618Wzlje6bnVi1ZeSiFjD/YHdmZY7aT9KNBaqmCc/bgRu4QH5X/hWWPU1cnZ4
 U+YrODrGJO5QJfYfdffWrJcWBJLkiDi/N0SOSgLOwr7V4341iPg/Op9mPOhvid6O+8ne
 /jA0nGkob+/3uHhLHacrvH8MwWgcIiyoEmIPUiZOUkMYl6mP6WRdvFPYqS4KaDw4GHvd
 xVYomwdoL0gXrwAYCfkOushUhBeBoDpXw5d47WQh+Bn3G6EqBxKhS2rmNyfwrjGzDzz2
 y4XyGEewwn6cbrL7D0f/NFm2Gkb1mPMMnrPqttcA4tBU0I2853oFHJGPyOmWRP6x0Q4l
 6CZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFUFTEXSymTCNUsUs/QGlAWccSbc0UXHzXGuKBo+08OaNba6RSG2SSh9wlr/w61sZfGMsn/TPRBCVO@nongnu.org
X-Gm-Message-State: AOJu0YwkADFAWDzHwGPZg69X5Bm2qeVHLQi/7Yc8vRQl60PLys96eS3j
 UW5XCJ04NOTwg/yetrD+3vRErez8c2k9qGFNsrXjLbj8LlXxbz2/kTdUleNvuuFcgG4=
X-Gm-Gg: ASbGncuKug44M5evVENetOtG93AJH30tlKQXoO+FbuLua2smNIK7aXwCqcFFJLFdn96
 cahs33rron8/XgsZx0Loi1jxX1y1iOTFMVh58m2PWKXGjaDRFYEFHum5cczOi+mOlnk6r0+PMCb
 e0YRf7KFUSrCQBUDjAQWMNhIFB5TMB6C2AtJ3SaqR3Wps13ywo4QmRO1Wf6yRQRhWGNDZfVJH5x
 BX1AC7iUooYiPvNHowFwSv0lrsgllQOJQNBpFaSS0oyo55PzVVnMFLRWLbZN5MQD+fpVXkrMJfI
 0Kp9bY0+3MtaaWVglHPaumihZnRK8q8HXToAT5O4zRI1S5HVootakugwJKPFkvrRTdDL6bsq2NY
 jnBaPtB41YO9APAicYPeE8K5djzQGPA4hxViZdfD2AnqCx1AjtSoRe7B5onzrDS700NJUgxPhpL
 xLLzg=
X-Google-Smtp-Source: AGHT+IE7lSbIxuftJzkrufiPXV72luIfttwPDNCQDnN1HCdfn7dfwro/ADV4CtIj3Y3IVJWRiskWxg==
X-Received: by 2002:a05:6000:2d85:b0:3a5:75a6:73b9 with SMTP id
 ffacd0b85a97d-3b5f187d131mr4758271f8f.11.1752355607798; 
 Sat, 12 Jul 2025 14:26:47 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26c97sm8296908f8f.90.2025.07.12.14.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Jul 2025 14:26:47 -0700 (PDT)
Message-ID: <ca980064-885e-4a45-a068-d7924b7c0e25@linaro.org>
Date: Sat, 12 Jul 2025 23:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/arm: Convert do_ats_write to access_perm
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250711224915.62369-1-richard.henderson@linaro.org>
 <20250711224915.62369-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711224915.62369-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 12/7/25 00:49, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpregs-at.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


