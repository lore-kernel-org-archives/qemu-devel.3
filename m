Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41943D778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 20:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjOEN-00073s-Ig; Fri, 23 Jan 2026 15:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjOEL-000723-I2
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:58:09 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjOEJ-0007hV-Eu
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:58:08 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-823075fed75so1438692b3a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769201885; x=1769806685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qsn2TFW1xBcwtHBAOanBFLp/sUREh4S2eJYCoxENly8=;
 b=laA/IGQVU3FpMjpdlzW5rDBdjX4sDBwOIgNN5MVDTnJCAUiLfSnnH8pFo8xSd1ZMS1
 LVve/68vg/dRZ3gPVpptCdH0AJDv6nGgpO4ZJK0qvmx45LiK2CALWOVz71WBFPOHmcMQ
 61NEEAMJ5wHzNwk/tmj0u7zNedSW/8kyqNw9k73OX2MvpsPmDZ1Ti30EBdlW6bFBbNbJ
 WBvC8L5Cv45jOxlxzNRvTaRlvh5VorIy7Khpt9RUl1+CJ7dDEZpAKSJkaLiwrimue9P9
 xPSjcyc2/YJxDotMvpBYffPgoDl+Pf8iAhb6y+A+JXMnzTeficyQqlBL4E+6Hr6UpPGl
 SYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769201885; x=1769806685;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qsn2TFW1xBcwtHBAOanBFLp/sUREh4S2eJYCoxENly8=;
 b=XhQwgqeLoBmNA19Pko6mrGpV5MOljIC7BCLXdNXHtJoXJ2N5CwWF8jVN7ZOcsVXU6z
 e7Mvrp6nolaP6NRuJNrPcinlJatiHgA++WykvCihaJY5utCa9MPJSiyBVs6y/6FkuLfh
 K9oikbLzzKIswogsVJgqzSPexVfMsoF9UjVmCg0s+D+0fs45zvtDIOHN5fY6QNxNe98Y
 OM15KtJfCh2qQXpEjCp/NlqclPE8GstHxyiXhJebZdGRJ5RDnMiLJwbTg6lqk2mSWVXI
 mcpnIdgU158NBP/ez4wdmsJEHUPfvsDKKfmhJBdxxKfKF7znInPebZ5smq6iM0M4O3ql
 uAJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbolamdnpSvdH1n+1q3+7ixr1TRov5uq6s5lv6C78H3bjryga3F9wUAdWKr6p+H8QK6EzZ2MY45kIb@nongnu.org
X-Gm-Message-State: AOJu0YzgWCA6lF5uZW1jbREhOkDJHUcej+yLmiU37CfP3MaQCO6GQnO5
 i8GnkV83YQWIGh7NVOtgxBBgmzcl7rIltZ6vqAWYZWTZ06pCfmxsJwVMUUR0KDuQnB6DTL0Zag9
 LXbpyrLFyOg==
X-Gm-Gg: AZuq6aJAyHQ4lKVP+xnP+Ze3MAtNqmqHa5yCvfJUzWg03tfvSDztgKlU6NicfWr0jTG
 0qsA5eYcDZGJ5d+rTUAhhJzMA6A6cGMM+xmbXodKqf9i6Rl0JD02rgQ/LKBZGuysDBHj2AUv59H
 bF0XWGdE2QSOqWDqO4Bft+7C8vkJwNGnOTjyZy0pEkU1bxSYnSG0V05M1Ve1w/osUO0zj6Phy93
 snLQcZJZdcm+2T9aCM3+c+SkqOsxjGghFm2zZ9w2cRKwG8oioF/xLlcv+++prOfjrz4pb7BdOOH
 4G/Gxfa2xxkIKbnC7qYsWpyHmP0CeaqwKCOPrCKWY4fxlOTjrKHXBnUDcBRD3C1Gd8NTjYoxXNE
 c15C59NvSZT+I31L6Ceh97HnmoJlUXOG2doS1pm4aAtzUCoukRfbNrLkNUQthLhvM86OSC8aYbt
 Yyi5dCotlDLsYE/oSzlphhW9lIt0mHg4uYWoydf7nU
X-Received: by 2002:a05:6a00:4f8b:b0:7b8:acdd:23c3 with SMTP id
 d2e1a72fcca58-82197914069mr6690459b3a.11.1769201885251; 
 Fri, 23 Jan 2026 12:58:05 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871f2b5sm2938176b3a.37.2026.01.23.12.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jan 2026 12:58:04 -0800 (PST)
Message-ID: <84367f37-5829-4bde-acf2-fdde00197d9f@linaro.org>
Date: Sat, 24 Jan 2026 07:58:00 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/37] Memory API patches for 2026-01-22
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260122111639.32346-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260122111639.32346-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/22/26 22:16, Philippe Mathieu-Daudé wrote:
> The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:
> 
>    Merge tag 'hw-misc-20260120' ofhttps://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/memory-api-20260122
> 
> for you to fetch changes up to 1280ec826e98342db4e7c35daf7680d09121bde6:
> 
>    cpus: Allocate maximum number of ASes supported by the arch (2026-01-22 10:48:46 +0100)
> 
> ----------------------------------------------------------------
> Memory API patches
> 
> - Use explicit endianness for cpu_ld/st_data*() on some targets
> - Reduce 'qemu/bswap.h' uses
> - Introduce ldm_p/stm_p (MemOp) load/store helpers
> - Allow restricting the legacy 'native-endian' APIs
> - Forbid various targets to use legacy native endianness APIs
> - Simplify cpu_address_space_init() API


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

