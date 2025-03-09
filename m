Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556E8C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trGrO-0002X2-9F; Sun, 09 Mar 2025 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trGrM-0002Wc-Tn
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:38:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trGrL-0006vV-DX
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:38:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso600190f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741527505; x=1742132305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oVfRmG3N0agKxZ/pzScoqVCWi/34yYIo+YBpdzeyP5Y=;
 b=kL6/U+XcoVLqIIMd/ZZtkZm4dOMzUcrlZt2iBJPxJRUVi5afbz0HOdWiUcilh+6pnT
 l2zC1WhwT82kxGRmk4Wo81a4A+TE8mSiWAu9XjaopY6hXfJfklZcA8SYOf1UYa/vSOWt
 pyc34QfZPVg3Fs3zK+MhU0hu2jEXXQKPj/SgK53DQAK04n7qwgYNECqY/Prp1mi2Sp/j
 4u8wYri62yqbB9zd0VMeS+/68BOhB8FoA72vGkLmHttPa2dF0SlGwbhQ8tsJVWNd0qU0
 TVGMff7Yu/uKDj9pUTa6zNLq+ui0fCWygWQvVZU+RdYUfNT4fdeEzerbee7wSRa0r9Ia
 sQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741527505; x=1742132305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVfRmG3N0agKxZ/pzScoqVCWi/34yYIo+YBpdzeyP5Y=;
 b=w0NSszHG0QFE5rLhbgSMZCtpOGF6AzIUWuZuKMsajvf5+TkiqiMO27bY0bTbeH7y5W
 y0jIbK8ej8P68+DZGKvQP3Vg5h8vkH2G05IyESnBixkJOqBBhqzuM9HND0mxX1k1/MGq
 amIwUTQeEcUZr8Q2o3/8/J6IHYEALboONYcV/Y3rlXnYw8wqTjv3fAi3/aelFUt8tWwf
 KNCIYiJFjd3l3H4BK05fcz1i5qnJbay/uv3GAqFF0G7fMgkyCinDNpkF4PbxEsrauE/6
 Gzv5qK5lxmjvNkL89Q7S27sTL3tmFWNvqa4lGivhg5Xg7mF3YA+6CzvHqnd7+EKEItZ+
 gi7Q==
X-Gm-Message-State: AOJu0YxCsBs+/LHV+Jzbx0WHAYgKXaNedtQN2I8KwE7dSwt6irCV9zPf
 UE8I0JuVMNv3ihAMD96jO33c+QH0zHXRtXv9yZK3m7zaBPPUJMPcgAfQ+51KgSC7bGOdeLOOWWA
 scpY=
X-Gm-Gg: ASbGncu2rNF/AodTHo/KBodmVcBYM1l3Oq24cc8LUiweCpV7U069FVWaX/2Sgdyxr3a
 N1mIr85bJNkkoKk6N+DqNd5IEKnbQLbhetqCNKzq4aoyr1pvTIAxcq0ueZJgqkZZknl2WtHCDFI
 Ps1gNZ7W4ZdI43lxI9OqJpBYQYHQRib8Yb1IzL5+whHCcaDdM5mhEVYZ824nUQ9t7pXCDNO424A
 OqMOjHEYk3ReDMoUVLZ6WD3CaGQ0o3Bf7kwMFpSlP/PaF3Li0VtuL8haELI9wWg0TjKJJnavdc5
 Esza1PSjC1yC+2JVAmuCHvoW71RM953Jbk827Fy6bO7CYTUWCLEYx8BNaPzjY2gmgZlm7ufgyzU
 LzsXNcztsQFh4
X-Google-Smtp-Source: AGHT+IGbkdKgP6Ox4qywKYNJ6WtAQ4ipCXtwlwQUaBMtrzQ+0Ce4CP0R1CUcC30eFXrO60cSoBNX2w==
X-Received: by 2002:a5d:64ab:0:b0:390:f9d0:5e7 with SMTP id
 ffacd0b85a97d-3913af025b1mr4079448f8f.13.1741527505105; 
 Sun, 09 Mar 2025 06:38:25 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cd31sm11983489f8f.52.2025.03.09.06.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 06:38:24 -0700 (PDT)
Message-ID: <17d686cd-dee5-457f-8089-0ae92dfebd57@linaro.org>
Date: Sun, 9 Mar 2025 14:38:23 +0100
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

Series queued, thanks.

