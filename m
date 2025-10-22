Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C465CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZqS-00066C-2R; Wed, 22 Oct 2025 10:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBZqO-00065v-DX
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:29:41 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBZqK-0004lZ-KJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:29:39 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-44575bc8d88so1943964b6e.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761143373; x=1761748173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gtKjwt2uw3AHi2g6FRHSAGnxG+XjSD4UHpww+w9jcH8=;
 b=YHoU0jb5GO8qqrshla/WRiqirHG9vvBeVhlDwqHgt+CsZHEkJDIAGwHqitE5xuKsSe
 cPJUhkaY+WSduhxLSarJM5zoJx7lqr9mHTlY9mRQRDS80kqqaIIXSZYGv1X3rrTH/3WX
 fy/8Pi20j7oY16gEkZySskNPkC2WHOyRCtPiChiBaRWeybvFCnMHIvoypkFo4iiBI+BO
 MqKMjrJgmk7aXHAKtVu9T3/FEwNggHCVhoqE1p52wJzUyetnemcMJ5m62t81SMa3WRf6
 sN1gNvhLdt+3ggKK9EpWMm6JHWes1jbJFqy9Cley+ymW/dNB9It1TG/uZ+ZttRSmXzTw
 yXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761143373; x=1761748173;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtKjwt2uw3AHi2g6FRHSAGnxG+XjSD4UHpww+w9jcH8=;
 b=bXDZVqwgjYxUUOA4qrT1IQc53jnViFWMuLpX2xoVlgR5RJ7Acn7gYYgY5PGwmO8VsH
 mLK8nV70OX9rd8Ml0HFHNNRy80CXqw4i5XCxGAB0Br4Q/+bL/wvG4yfR4m0jaPJKmjO8
 YWcr9KiQmae1l/J16ClDNMGq8sR7hpuJNzWdyEuG90TmzT1RwBpSgLcI1Rvpd3mX8YMB
 PUZrmr4NOH7C1fszwgJZU/MWSMZjT1Zz3Y4SnUXxh36O8ChFkiLBJbwx1jsh8I/t5Gxi
 nios2Ecnn2doxQ57duLeF1ovcHqFlYvpAyzx61KK3w1O48q9t4nivcJGvPT2vFdDrLBb
 KdKQ==
X-Gm-Message-State: AOJu0YyN55I1/x9xng4SYMkxo5KrPAM2dQDtNph3oWa+SLl22XYUxfB2
 edzJOioKO4A3Fs63scS8IJpbrCVsAmQZtA/wjEhjIByiQ2T2Qj9TmzcJValBo5e6+95oaXrZVhH
 +DTj8
X-Gm-Gg: ASbGnctWbx2PZVkTMJPafpRc0OWlACOrI4xL847dx32aVWuxGSKHHhZSX18+k6r9Iwz
 P4tqV1EN/WN28LdA+sMa8WoRI5YacOTne0z+yLtTN+qNzKvI7KiJJT/7QsYdp7EXCcmAwJPwyYZ
 UFZryhY58HOYcQP0ejlCcISm7jHF0DeZurdSxb3m5O1qEJxYiq5h1Z8kmmvuP9oy2+WT2p/4XFd
 1YMmbYpPQdqGb64QuP/Duywr24CGlSoX0BnHqVrHklVuggYet+iMCt8N0/HwQTuPteVBP3cnxaJ
 knps5Bf0THSaOTmCILRhyratoG2IC9r6Kk7p3JqiP0ShFMHef+ULe8rKWFgS+L64S3km8xvERBu
 1KArxTIySTVHv5JGhbFsq+l1DPPe9cjrz3AwH5SbMkTFgOd+hvDbRrXCYxxfQhQEJ9SIPMINiAG
 jeigcO/iANXyuA2srJQachIGzDj5Pn0yymYPuKnA==
X-Google-Smtp-Source: AGHT+IGD8xkBbVCHZF7+RH1nCFoLhPB0DQnKXSLeLPYGBGgtNDm4lvnMfokjv8LBzy2NgYtBQfXH+Q==
X-Received: by 2002:a05:6808:1b0d:b0:441:8f74:f11 with SMTP id
 5614622812f47-443a314433fmr10189098b6e.59.1761143373283; 
 Wed, 22 Oct 2025 07:29:33 -0700 (PDT)
Received: from [10.128.41.227] ([50.194.179.134])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d3a9a5casm3488789eaf.2.2025.10.22.07.29.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 07:29:32 -0700 (PDT)
Message-ID: <5892c81b-f0e7-4358-b0ee-645cd633c104@linaro.org>
Date: Wed, 22 Oct 2025 09:29:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/45] Misc HW patches for 2025-10-21
To: qemu-devel@nongnu.org
References: <20251021204700.56072-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 10/21/25 15:46, Philippe Mathieu-Daudé wrote:
> The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:
> 
>    Merge tag 'pull-request-2025-10-21' ofhttps://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20251021
> 
> for you to fetch changes up to 3365d7da6156d7db990490f6cae2dc89950ac920:
> 
>    docs: Update mentions of removed '-soundhw' command line option (2025-10-21 22:33:49 +0200)
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Replace compile-time checks by runtime ones to build virtio-mem.c once
> - Cleanups in Raven PCI host bridge, audio and PC devices
> - Allow machine dynamic registration of valid CPU types
> - Introduce DEFINE_MACHINE_WITH_INTERFACE[_ARRAY]() macros
> - Set DDR2 minimum write recovery time in EEPROM SPD
> - Have PPCe500 machines abort gracefully when using invalid CPU
> - Prevent buffer overflow in openrisc_sim_init()
> - Pass PCI domain to Xen xc_physdev_map_pirq_msi()
> - Fix register API leaks
> - Simplify Xilinx CANFD model
> - Unconditionally create System I/O on PReP machine
> - Update documentation around '-soundhw' command line option
> 
> Various "WARNING: line over 80 characters" ignored.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

