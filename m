Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5795EC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbmK-0004YH-Qd; Mon, 10 Feb 2025 16:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbmI-0004SE-M1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:57:18 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbmH-0006lU-1U
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:57:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dc6d9b292so1980755f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739224635; x=1739829435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o6gphRIG9alUJ++BUa7VDTc58wW05LbxmLQ/klp3wKY=;
 b=N0G1DpQih7AT29oS761vAv/jcLfnR1qtrop1Sg6rVRkKtBWBQm5OGSK9eb3zKod8Op
 3bmRa8uW7jgVK4Eo7hCOqdYFA2i9dloAp2xyFsnEk1dvUZ9vZxjRIzsJGb9s0CvbEpGR
 QGETvkF9a1Bb0QPrLdJkcONbc0D87VrD08SB6GGUHrZ0SR7ZYu/Y0kHiw+YZZtG6FG4L
 oGxFbAnZERQrCEbTdMhHADOcuT7gbuuKfzUHwLg269r12uOjhageY56z4K6zTHExqrSL
 v0R4lS9hHZHRVEOwfNqSg9GtAwWSDS5KRMaGQqrn/7c8RtcNOcAp5WS9BrcHv8ntkFov
 zdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739224635; x=1739829435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o6gphRIG9alUJ++BUa7VDTc58wW05LbxmLQ/klp3wKY=;
 b=vX+qR8Ys8f8dWe82k39EESpy4BfRdeXhI+kulzHQ2jNd9lOcQGNZrcvblG4JDT0glq
 pxti0/kYr2r0jxEyRrql0/mVfvp6B8f0t0rwRKc2uaQ6h2F0oQpOkwdpCVmz/IShtMLu
 ZWyqdOGxiaX75Hql8lgj5kIZ57WyneGrhPag51UfH6hSeSSiohjCekIda4nCwQiUvhKt
 RiCUDxVPdMxr9PjEr0jIZard1SgsRg8x+jAUaYQSRPZiM0+BU4vsvb8FkVmTZdnJKeOG
 7huxqPmJmpKA+NAB+pxGKlz2JqPKNk2nnI7cqaT9hJm4Up2tyK36/DzZpQYhFR3FJNwg
 zcAQ==
X-Gm-Message-State: AOJu0Yx/DpoXnYw5I3x5OwiZ9tGPIYh5hRg6K/aTJ8JG3tTeR2QS3oa/
 oAqaIdEfPtq0Ev8wejFYUo2KlEQBwDlkjWrKFGqkZdg1o5svuzsdYollNX/C6pdDXPg38arKqSx
 rb0M=
X-Gm-Gg: ASbGncsSn29pKadrfUn/Eo0akxa9/YSuq+9hv6AyKs1b3vzYdGDhqRmXx4qS/BQ8S3m
 7GQoXDuqRFpEsOXj96U7UovD72vIpcqAlfukICaV0ucLeYaoHIGFtJhVY6VWUkrf9zku3Qhz7Yv
 HyA7Uqf/hW5ZhKO9nkUHZ/IOa7lrIBHriDdol6Ip1AEHeK+uu3Ly2KYwOPRYq0D8mtgOjCKv3Hs
 X0xnJxjfbr4zM93ymkJ5BtvfJ1askrULhh1VqxP8C35vrcOBoWzqFETgY/3fQ1VCZ8aIPeyq2GX
 C4znKVavAg3dh7QiQqnXi693YV0jQ3yMu510BLKqqXyyN9BX0PgszXzzVqM=
X-Google-Smtp-Source: AGHT+IGsvw84IRf+vxlI+5pcqbw/WBZT0Yico7maHi5zHcECMKovIuLLwLZEAs1GuAbDb2oO65E80w==
X-Received: by 2002:a5d:6d0b:0:b0:38d:bd41:2f8b with SMTP id
 ffacd0b85a97d-38de41bdfe9mr1369784f8f.44.1739224633631; 
 Mon, 10 Feb 2025 13:57:13 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2e0765esm8063622f8f.82.2025.02.10.13.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 13:57:13 -0800 (PST)
Message-ID: <04dc6d9b-2886-4184-9aa7-0628b76e8998@linaro.org>
Date: Mon, 10 Feb 2025 22:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/24] cpus: Restrict CPU has_work() handlers to system
 emulation
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 25/1/25 18:01, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (24):
>    cpus: Restrict cpu_has_work() to system emulation
>    cpus: Un-inline cpu_has_work()
>    cpus: Introduce SysemuCPUOps::has_work() handler
>    target/alpha: Move has_work() from CPUClass to SysemuCPUOps
>    target/arm: Move has_work() from CPUClass to SysemuCPUOps
>    target/avr: Move has_work() from CPUClass to SysemuCPUOps
>    target/hexagon: Remove CPUClass:has_work() handler
>    target/hppa: Move has_work() from CPUClass to SysemuCPUOps
>    target/i386: Move has_work() from CPUClass to SysemuCPUOps
>    target/loongarch: Move has_work() from CPUClass to SysemuCPUOps
>    target/m68k: Move has_work() from CPUClass to SysemuCPUOps
>    target/microblaze: Move has_work() from CPUClass to SysemuCPUOps
>    target/mips: Move has_work() from CPUClass to SysemuCPUOps
>    target/openrisc: Move has_work() from CPUClass to SysemuCPUOps
>    target/ppc: Move has_work() from CPUClass to SysemuCPUOps
>    target/riscv: Move has_work() from CPUClass to SysemuCPUOps
>    target/rx: Move has_work() from CPUClass to SysemuCPUOps
>    target/s390x: Restrict I/O handler installers to system emulation
>    target/s390x: Move has_work() from CPUClass to SysemuCPUOps
>    target/sh4: Move has_work() from CPUClass to SysemuCPUOps
>    target/sparc: Move has_work() from CPUClass to SysemuCPUOps
>    target/tricore: Move has_work() from CPUClass to SysemuCPUOps
>    target/xtensa: Move has_work() from CPUClass to SysemuCPUOps
>    cpus: Remove CPUClass::has_work() handler

Series queued with patch #24 description expanded, thanks.

