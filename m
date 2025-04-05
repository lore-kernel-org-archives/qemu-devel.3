Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BD4C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u15xI-000355-Fq; Sat, 05 Apr 2025 12:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15x6-0002we-PA
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:01:05 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15x5-0003o3-9A
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:01:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so2451990b3a.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743868858; x=1744473658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YcmaZAJ41qN5uUSkcCPQwfPmp8vk4/ZMFtX+6nm5kbA=;
 b=wdHmrzYyvzDQ+NntJNuvMxMj5T4FWYqbHEBJcHHv4DRITAXYPr9om+Jhaz/WjNcW7F
 QriG6xz8NSOZvf2NKSWLhUUNiJfBC+W012bx9s/yjd02UeiaUPHSyzDtE6lw85ZLv8qf
 YC4npYVKJidvDwo72gKQzjKjrw6B9KhUe2tidVbRCxSTUPGIf9AaKm/566nWSDpBYd2O
 8JuFV7EY35LiBH5m2ZWtfA86mPcU/inYwvcbcEpTctSmFHtfNnAae7DEtGOoaoI5CXPF
 NNZkW0vDcyPFwtxsnJnSpVf8/OWUzgjgy+G7azx+W43ZbhPzZvkd0mz5JMcPSFfUAAku
 pSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743868858; x=1744473658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YcmaZAJ41qN5uUSkcCPQwfPmp8vk4/ZMFtX+6nm5kbA=;
 b=LFD84lnPPr8CVqadutRPThbd8B8GzNSs8oM2HsQnjhaLGTOxkfO0kxJXDGh5nEJHHb
 XAwfmEgf/Zf/THpvy6Dn6aUj8V4DJo3glFkWq++i07vEZfGM4pZetPeAlt637EPnmeDh
 GpMtbWLKC69MlL6YAl+Ggs2sjreLVDYS0nhKSTtT10cHxL6ywkzhDn5hZWE7uC2H+/U3
 WQK+FEghGSz6fyPS+1akcF9LXD6Xb/vtQw7GuUD+yTLVPzwxyh/8MLvKX6+hmHAB+v5S
 l0aozc7LBzG+Zk5ljzY26k5W9Eaugd/bDO9Y8HGEIS79sGFAfC7cnb9FubSXVoZyiqcL
 0kKA==
X-Gm-Message-State: AOJu0YxEWRsPGyA+meIwqYECJQYF0UMH7kLEDG16AkDvgOUgEeZDAoU3
 c4S3q8gbfS3Em312E+nB2I+hiCHmigY8/anFOJ84hwM7JK10p+uQvDIKnzWXDI6YqwS9ubEZ0ZF
 V
X-Gm-Gg: ASbGncsRp8fwGYVC/vL+K/duUmzFxDyUS4a0+uK+YPR4mkXF+WGOLfI7fogG8h0aI9r
 eAN1OFCkRtQFaPI613bwPA+CL9onK56mXK4j+4+fPLRvwZBHaptyyxJjxFdqHAcvIloZLWM+KPo
 McOLVXvNuW4avmp9snlAu0jKiyy+PXo8wuNJYBB4MZeFHOg9qz02UEUCFjaW0Ca5P+mVMuJMNfA
 xhsqFxIwqiqtaA5CQP3+BbQR2Zdcfyp8I4r7aJ4DuIVATTFYqijs6QwGUPRMmCJiINZ6jjX5H+6
 TecXzBNZz5e/wdAGKn4wluczhCgIudIcN4ALjMy2C7JBr6o4D/Md60S0PutlV02lsFmjLPa0VYE
 =
X-Google-Smtp-Source: AGHT+IFjrcwKS/64HKNVdbEug9TkQedgILzEWDI1qbFX6y9MhN9BIB9MSeYt9io4vZ3WFNujz93J3Q==
X-Received: by 2002:a05:6a00:398d:b0:736:34ca:deee with SMTP id
 d2e1a72fcca58-739e492f5b6mr11133780b3a.7.1743868857731; 
 Sat, 05 Apr 2025 09:00:57 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d95e6e57sm5415151b3a.0.2025.04.05.09.00.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:00:57 -0700 (PDT)
Message-ID: <dc06eeb6-6283-47b1-b2c7-a119e366c4dd@linaro.org>
Date: Sat, 5 Apr 2025 09:00:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/9] target/arm: Remove use of TARGET_AARCH64 in
 dump.c
To: qemu-devel@nongnu.org
References: <20250404223521.38781-1-philmd@linaro.org>
 <20250404223521.38781-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404223521.38781-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/4/25 15:35, Philippe Mathieu-Daudé wrote:
> It is safe to remove TARGET_AARCH64 #ifdef'ry for code
> guarded by runtime check on aa64_sve ISA feature, which
> is only available for Aarch64 CPUs.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu.c | 11 -----------
>   1 file changed, 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

