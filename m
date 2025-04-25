Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5371C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ko9-00085R-H4; Fri, 25 Apr 2025 11:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Ko8-00085C-G3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:17:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Ko6-0002B0-Qu
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:17:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so21233635e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594256; x=1746199056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBz8dRCZaNYrp7wStvZe2NFzJC37ejSswKG5b1aTM60=;
 b=CI7XKUFXAmXt+WCr0X98HXTtMatHQWumriyKZcL9D+uqXsFTbzqcaNAvvP0vhzsU8q
 BeJQHZwG7vYJuktZXl90U1/Aces0ZqsJqGZuREOjtBieoxgByk2924ymUViK01rkcTSj
 1gzjM77hTcUJtMPhQmaOpZ/M7FquE1lG1MI8CwDGps6GNPKH37csA1Dm4JIj4epNOV3K
 3+npL4X455/UmYmVHYnQ9bjfMId/23mQCQqlnT7s0AS+5C0wna6EQ4US/9hbp5oSt5Ys
 FtwTlB7f1QY4AiHlQStKW9zcye5NEg1rUw3uE/9nEt6s3QHGVnfbEC3kXSrJpnGYki0A
 NYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594256; x=1746199056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBz8dRCZaNYrp7wStvZe2NFzJC37ejSswKG5b1aTM60=;
 b=P33Co9AIJT3Mn7KDWGmpth5V7vtml9St+4CVxYXukT+yHkdWjsPa7BczmEr4PXgHDt
 qhBbtlkUPmIxIEk+3KJg5u//5LUZGps+we0dDvzxLAM9t2HM90nuSHt2UWclEzxb2tZF
 Kul/s6uXeVxhMWriBqQL3sFS9dUBreYA574+j61MGuuEDgRg+6im/PEMBEoERFU7lYJj
 rtizDQPu/XhTZ9IW10TatOrLV8oN1CEPUhL06Qj2mqIxlM9FMN6GEGX/y/571HbW3/rT
 J+moJWLxtzfsON5JUswWr6Yfmonn4Re6WJW0xLOb6IpPzpOqnEOy/OegaITnFHEJiapy
 jR2A==
X-Gm-Message-State: AOJu0YxiQc/duUKcBDjfGUNO5zqemEZM1UlKbYvQ2MfNmy69zVqvdipf
 IFedhdQyTUMeqebzQ0eKOWufoChVWFu0EfrxHXL/jocoymzHtDbnAP+ubpHkC8iM8HliIqFOz9P
 /
X-Gm-Gg: ASbGncvlydrHVqcX6ekzLmB7hwDza/9BeZedQS/HDhoNCNt1ousukspgnkidbgJY4cU
 sWwD3dgXHkgFJe8f94X9bXVj4IuLerQahqiUf1KQhASSlxw5QE97CAzcLxYK7OoXeVOS+ck0+dB
 jv6/WsCJ4CL+HyzlIp1SVISY9cshJSfPSYHQa8uRSyDhAbVKOLBVM5OGdS5du/k2Ftsvk6/VyyP
 NC5sWq6y6ZSk9SpV5spR9l+Xp0+vbZ3QDyG9IUvTk/GfWvManl6JQafmWolq4nqg85kN3QzLL2J
 BiIHK5lrk/GhzXD/cQHuDm7thicVeMhpKM7uUNXdl/DocBJq/NVJPu5PzhnIqclRwLGa8/DBncf
 YB93MYkep
X-Google-Smtp-Source: AGHT+IHZEmMxHXDalp95aBaDP4o/1YtADwoLWachaJQVXFaebCZsFnKbyCVu/eqtw9RfNqd1VjZ1Fg==
X-Received: by 2002:a05:600c:3d96:b0:43d:98e7:38dc with SMTP id
 5b1f17b1804b1-440a65bb0d8mr23086085e9.5.1745594256320; 
 Fri, 25 Apr 2025 08:17:36 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2d8976sm59516395e9.27.2025.04.25.08.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 08:17:35 -0700 (PDT)
Message-ID: <f4cdfb6f-0be0-422a-861b-25f9a35aa28a@linaro.org>
Date: Fri, 25 Apr 2025 17:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] misc: Prefer evaluating TARGET_BIG_ENDIAN in C
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
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

On 17/4/25 15:09, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (8):
>    linux-user/elfload: Use target_needs_bswap()
>    accel/kvm: Use target_needs_bswap()
>    target/mips: Check CPU endianness at runtime using env_is_bigendian()

>    target/xtensa: Evaluate TARGET_BIG_ENDIAN at compile time
>    hw/mips: Evaluate TARGET_BIG_ENDIAN at compile time
>    hw/microblaze: Evaluate TARGET_BIG_ENDIAN at compile time

Reviewed patches queued, thanks.

