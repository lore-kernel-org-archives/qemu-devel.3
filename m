Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D18D277EB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 13:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veZ9z-0001Oi-PL; Sat, 10 Jan 2026 08:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veZ9x-0001NL-S1
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 08:37:42 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veZ9u-00037f-Su
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 08:37:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-29f30233d8aso35190775ad.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 05:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768052257; x=1768657057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZlnEJmjECHYAVrs/831vxM1i8mukhM+QTiLU4QoeOM=;
 b=wFWiC2ZGYSwnrO1aw8A98JAOsSQ9Yfvn82KA8CQHcrDzKFklPmlo6X9DuWbneqNCT/
 ZCmS0RimI+SjxTDHuVmJbFVc74qap2T1Rkwb9vWul3XKD+1yj1PDDgw7zlsi3T3PQysQ
 /PQRBbh/Fv0jxR2hW3NcbE4EwE82gVTpDMBwUuNP7XB/VYr1Anlz1Mm28rq+e1iYhAUv
 9bLcgMT7x6d24aewtSWuBxjh46dm+ShZf0YZFNTFpYNfO473cXp90MD08KdwTWfGQsdL
 JM7hV6zF4GbZtTa+yGyk4LYRUIjR16+XCUgyrC51ZV9A8uNOFtuo53B5a5MErC1d4hSC
 T6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768052257; x=1768657057;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xZlnEJmjECHYAVrs/831vxM1i8mukhM+QTiLU4QoeOM=;
 b=qDYabtQdNh04wTgWG4WBS27kH1WMekDP5H17Jw9gafXfXsu8ridSEWeklQsEXnPm1F
 bER08M3Nc0UShe6Xr+EHc+3rFO0BiP3uPx3PY57SMy7bLiyadYZYkYuXJTJqZ6GP0Hsh
 fuuyb4KmPY1pkUtIzJeJT3kHBco0lS6FVPOkacHIv7DZYwDVZCBGs7S8W6OOC9VMyOud
 3mqX6SbE0E/lfXulS9r3oQXTwsVQBUSMtEcvsUnukUnjAApPawzLhHMNys66xidR4bNh
 xLaUHMnHQnRX4GpOuDC+EacKsp99e7QARk2e9SSCayC65wZtugQiA62BX0f04x+BOTGx
 1K2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC+CFGTB+zqKMKhKIsqz9gM9DScBWX95DUc8xGhqxSvtSB1nqnGZWXUcMQb2imzjhIHYAhGOtY/eZm@nongnu.org
X-Gm-Message-State: AOJu0Yy7EgdREYbBaJYXl4F87lIoEg8bUdYkQXLaAtJ+3El+sNaQ5JAW
 z/z7xlHgy6upc+luEZBjWNe0tKGJ1QnYwcuU85I0Bml8YBd2pM7s8kDmu5qVqXUZ4Wg=
X-Gm-Gg: AY/fxX4KjrVovR2bjojV4j83ygpWCO30JxhAMrxdSIpXqEwUn+2MFyts9Mure+EBOIP
 dSJj1P2HdnuJGt87s/rX9lZOUut580d8VrUX2nAm6+5LTywsCw9CW5B+j3yd9JtpaD9PyF0zAcN
 ajfmWZiboG/MMguO7JOuwET3o0dF8swyflzp+DxjXTTLfHxwAs5W89hPiCB5C4v0WYoK6s1x716
 K/baw3i6wrwMuLeH7uSvQKPxxExn6FUcVoioUP/OSj4S6DP+e51sUcay9IxJnOcrdbN7Ylpv8xz
 dNJfPc+6IpsTzxqZLekw33Apft7GHcUtPeQP+af21Srto/4Vk1TWOikb8/TWGnwUI7zT3fM9Vte
 lJW0mtKwEkBrc0ubIo3r3pHBC0CiG9d102ySTHuXHPw+1QsLwDIaBjlVRFdZ+yUGS1JlVsalaLG
 tTRNBbMxzfptceYteQSCh6YoR5Aw==
X-Google-Smtp-Source: AGHT+IGoAiI+tiIO9bxbsVxUCn0jgttakHxUlNbtWr4PGIQqmGNZymgmLnqCaMvux5tfFg+0JTwLgw==
X-Received: by 2002:a17:902:da8d:b0:2a2:f2a5:4136 with SMTP id
 d9443c01a7336-2a3ee45b2f6mr129840955ad.22.1768052257198; 
 Sat, 10 Jan 2026 05:37:37 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2b4dsm132431385ad.54.2026.01.10.05.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 05:37:36 -0800 (PST)
Message-ID: <ecb580e3-83ec-4057-8861-1ee446e29697@linaro.org>
Date: Sun, 11 Jan 2026 00:37:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/34] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/9/26 17:54, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
> 
> The following changes since commit 3b5fe75e2c30e249acabe29924385782014c7632:
> 
>    Merge tag 'pull-monitor-2026-01-07' ofhttps://repo.or.cz/qemu/armbru into staging (2026-01-08 17:45:15 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260109
> 
> for you to fetch changes up to e71111e26bdf5e98243d6a896c9e595e205dd9bb:
> 
>    test/functional: Add test for boston-aia board (2026-01-09 15:14:58 +1000)
> 
> ----------------------------------------------------------------
> First RISC-V PR for 11.
> 
> * Remove unused import statement from sifive_u test
> * Free allocated memory in core/loader
> * Add all available CSRs to 'info registers'
> * Add 'riscv-aia' accel prop info to documentation
> * Fix IOMMU MemoryRegion owner
> * Make riscv cpu.h target partially independent
> * Expand AIA target[i] source handling and refactor related code
> * Don't look up DDT cache in Off and Bare modes
> * Add Zilsd and Zclsd extension support
> * Add RISCV ZALASR extension
> * Add support for MIPS P8700 CPU


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

