Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443D6FCEEBD
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvUXv-0001vs-U3; Thu, 26 Feb 2026 01:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvUXu-0001ve-KS
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:08:22 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvUXt-0005vE-5F
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:08:22 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4bc6a8021so351048a34.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 22:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772086099; x=1772690899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ff5hIIbg8fChI24jTOxw6x17MuERso6czd0Z/NgtD/g=;
 b=P4o6oaHnebQNboQU8HxTUKrMW47vrHKBFUN7aupP0MFilFHT1siSV7ktwyq/EL0Lqu
 DuidbdvsDkU94PYPMYQL9zcuLus+jkKQ0v3YyYVp0hmu9Df7k6Cno3rDl5dqO0m8qNGw
 S5kSsUXSMjO8o9zOBEeK1LZouqj+BvnRkIDi9edTc+qsV8vx0+KVzzlDZrZx7tNHrLmy
 4u+yTghvxg1rZ0qw4dwIC/bxREq6nA7s7ItVc/L1MIz5GIk0jNre/XFDMM/lFUEGzOio
 q23EcbSwNrWS/SlshNaDvCBLw+3GgT9MqZ4m+C4xbYV9KwLXEwbadT3GB82pi5g2qMio
 Zj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772086099; x=1772690899;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ff5hIIbg8fChI24jTOxw6x17MuERso6czd0Z/NgtD/g=;
 b=pN//CFh+lXbijYvomY6WZDfn7aR7qtw97soTsFKGPN0pkI8F2ov7c++lMxlSZyEok9
 LjLZWvvFjAEdJ+oPRAYrtjAznW0S+8BMebSGWp7bjttPllMVj/YSOdISZeouZ1L3BtDc
 DHqDEsi9eeEYWWyKAhCtRvMJNcpZay5kCqzHJWTl+ZxU6i488FbRq5wudwaRHS537cFF
 iXw9oFw6Vnxs1C1u9cVN3CvA1NOqdCDO4+Tv6ypDBR956PE1gcpeul75IwyENwZA4vTM
 8cEdZ/alMnPiH19ZG+A7fTxegjPnSDiG/GkSRBBrI0pEvimsV8P+gjzP+5bOGLrERXmi
 hl0w==
X-Gm-Message-State: AOJu0Yw4oinT/UBSkT8LqFC4W1vS2ZxojPkK38Xx6BqpbhmpN0k9lwd9
 dGpI6fVWOvfhVACQs6AhfB4sCIvudhoedhxrNrIIa1Y4vcmKQRhimLV1IjY/+s8Zw45gMhi1HeI
 Fnwnr
X-Gm-Gg: ATEYQzyoyCLGeOGqO1NilofClVySWvsrfH3Vhy4W8yegnZD2WS8X/2dvkMNIKA7SlPT
 BDPruDdUjaCNVU38z8Z7KhfFErUPp1frpzAINiXBJl1sxcGdD87Es1cdWwCxFD+BFjfUmv2mPxG
 P3r809W/KCHvtbvA82DFpFo/6lsCrWsNj0pjMCwlYaE8smWoueb7tEvhkktp9QXSgKS7UZFRckM
 IvSB6MQigi1K99b8685u/CEaI+cmW3LTUcDz2401OdZhpge2icyKKQJAECVEDdVcqsKm5N9k6kK
 GtvNZhRaBf0ryd5rjIVobWuDHQU+Hvg0/IbvdALFNsMYYtocqDPcex4usXOs4e3FQPJHQqVgGKx
 OVQ2hprbnM/Z0yZtNIMb2T7w6GUsePnMWGykQC8m9F9OfyGfw3btSI+gC6uwoU3FYn8qfsewJBv
 2KZJ4HL74k7dvpvXPvNN8NkMPPS1VcD2EjKzflIm0oFA8MNvQpymCRHsV8aIsroJg=
X-Received: by 2002:a05:6830:6c13:b0:7c7:64b7:83e2 with SMTP id
 46e09a7af769-7d582a9831dmr1791793a34.31.1772086099112; 
 Wed, 25 Feb 2026 22:08:19 -0800 (PST)
Received: from [10.34.149.227] ([172.59.194.143])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5866557c6sm975344a34.24.2026.02.25.22.08.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 22:08:18 -0800 (PST)
Message-ID: <cfaa6031-d000-4a80-a7ef-6fb50c5eed65@linaro.org>
Date: Thu, 26 Feb 2026 17:08:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel: Try to build without target-specific knowledge
To: qemu-devel@nongnu.org
References: <20260225051303.91614-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225051303.91614-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 2/25/26 16:12, Philippe Mathieu-Daudé wrote:
> Code in accel/ aims to be target-agnostic. Not all accelerators
> are ready for that, but start by enforcing a few easy ones.
> 
> Philippe Mathieu-Daudé (5):
>    accel/kvm: Include missing 'exec/cpu-common.h' header
>    accel/mshv: Forward-declare mshv_root_hvcall structure
>    accel/mshv: Build without target-specific knowledge
>    accel/hvf: Build without target-specific knowledge
>    accel/xen: Build without target-specific knowledge

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

