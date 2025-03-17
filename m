Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A8EC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCfH-0005lp-HB; Mon, 17 Mar 2025 11:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCfD-0005je-AG
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:46:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCfB-0007IY-JO
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:46:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3996af42857so207512f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742226360; x=1742831160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0eRG5gcCqa7m7F3Krq5y+swCXkYKUlszqAvhvUF9uy8=;
 b=OnHUnNtNXWnZFM6xOBUeFq0pn9A1hRPMhUmQRjN5i7s/ZVRo5pqnRnXpeo8Z3rFXbT
 +/hJxNv0QoKGp75uJKROsxJbzgDt6JWFsu6R98LmcdNPwmOv4+QUSWpPRxwDkiLk8nV9
 DBPhRreRKa9hONxHF7T95Qc36TCunMssXPlvHGZ/g4XBq7PivHmi541UuN2ksDpEFM3T
 2q1/Jgbz8o0aqL0CYwD+w/RGL30YpNl9U2dHXwyhGWvwmFN6VC1LFj1OwwsdPRDBZbhg
 Nk0Fwz1aPp9tPFU8HmImMbTsLA/lYLN1gltKRRD2J4yAAGb9T73p6g+3gjVDXGc3SSFc
 UNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742226360; x=1742831160;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0eRG5gcCqa7m7F3Krq5y+swCXkYKUlszqAvhvUF9uy8=;
 b=JLVRjap0eXT+sDfocLZ3ZcWMk6RTWR+4DQVG5mkcpK3/8VCixeTN/TLhBLkBdI5yPv
 /kAe3BetQy6QTTT3DoD+o17VpPrR5LsYL2LvGHm6DWkVtoqzpBqy07HNTs2GqMMlDoeE
 jPy3MDwZxoUqRrty9EKnyQegs9OSeZBPyGctA8QfDd/m1Z/90N4FtjXLUqTVKApY16AG
 jO6bBHg6eSxUi/J0A459V1A2BK2+Y6R1CzoY211gcVK0nqogQd9ILDndTzJwqX3WZm6v
 JZa/kQ44bjZt2U0OMPiqQq956JbRWCskv774EaLPYbb4qdAd0lf+EdCBur+4Q0MKQfUn
 KZ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/7FKrm00tM4iJo9TnM22K2y9tBfj9hx0KMGmyqPqvn4cOf6PhF6kDQ9hSDUovwc7fsfHYWOeycfE6@nongnu.org
X-Gm-Message-State: AOJu0Yyq1KeHyieVqQve1VjhVXlX+4PYIau6IG4XYY1TZyQU/S879tmb
 Yp4SEd/mfuueU6UbjnP6DiN70LKcqazRO8ynMSbFftNweaxetd04S2amqiD+JDg=
X-Gm-Gg: ASbGncuweqQ2MZfvurDif3/4bmlu/Dp/VnoaIunQV/RgIs3SPc0UOq6FwBWtfGDZE5u
 YP82LkoWcXhrmwMGYjpQ+wZRnaXk7fow0xgVJXdA3uCTpAI2AmAVlKwZmmvAKUzAyTWZvn/jxfl
 ZXr8vGcBk6AkbTd3knZ2gBKnv3z/VOLu5EIhhKGQ/eA9GSzzWTi/fEzlNT7zh/92SaEFB48kD3n
 JYT9p19vm33EGq1Ie93oWiJTxLuI78goxp0lUu/hZ0u+7gUGgpDF4Ul0bmJ+6HSz09h7WthAqNv
 9yGuVH5M57yCvlNUiLdQoUhat3HRdZ4slxUMYkNYHTCjftBWpNvlmhjSbaO9bsnBB4T1b7X2DAM
 Ek1QwDnQkiQ==
X-Google-Smtp-Source: AGHT+IFi0CQMbfZYJT+i9Fv/VL/kOBLiDXQ9TfO1qoZq1janaejNl5+HHj8hWXwEFPPh19rA4xlg2A==
X-Received: by 2002:a05:6000:1447:b0:391:65c:1b05 with SMTP id
 ffacd0b85a97d-3971bfce005mr14122212f8f.11.1742226360019; 
 Mon, 17 Mar 2025 08:46:00 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975b34sm15472567f8f.55.2025.03.17.08.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:45:59 -0700 (PDT)
Message-ID: <d6cf2bbc-337d-48ae-b28e-cd1fb425cb40@linaro.org>
Date: Mon, 17 Mar 2025 16:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 3/9] target/arm: Handle AArch64 in TYPE_ARM_CPU
 gdb_arch_name
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-4-peter.maydell@linaro.org>
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

On 17/3/25 15:28, Peter Maydell wrote:
> Instead of having the TYPE_AARCH64_CPU subclass set
> CPUClass::gdb_arch_name to a different function, make the
> TYPE_ARM_CPU implementation of the method handle AArch64.
> 
> For the moment we make the "is this AArch64?" function test "is the
> CPU of TYPE_AARCH64_CPU?", so that this produces no behavioural
> change.  When we've moved all the gdbstub related methods across to
> the base class, we will be able to change this to be "does the CPU
> have the ARM_FEATURE_AARCH64 feature?".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 6 ++++++
>   target/arm/cpu.c       | 3 +++
>   target/arm/cpu64.c     | 6 ------
>   3 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


