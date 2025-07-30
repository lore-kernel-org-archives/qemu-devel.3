Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633E2C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 05:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugzle-00069p-F7; Wed, 30 Jul 2025 01:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzlY-000672-IA
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:54:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzlW-0005fp-Tw
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:54:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2401248e4aaso37355705ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 22:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753854853; x=1754459653; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lWNN9WB1syoEngVmG1Zfdqg2oERvJW9qUBgkf8NcAy8=;
 b=yLEJjh/MoP+Nv9tsExuCs83FdsL7T0IPI/Xz8y9OyRnOu2BAD97fe99FejGP1RqENX
 ZIODs7khhOR91/tYiWxrVWAD4NtY9EgK++G6HrQnoqwY85iHq/BoVc8dyk3LzJlkHnx+
 GeAMY23+DlRsl/Kjxz9cXzmJ7EedkRLhPZM25wfnalHdsrhil/ixo8uqvvbZ+Q5+zmrv
 BQ/azenPoLoXxvlttApzVETfdur82debMhwbaYwPpZFV4DOic16AXN6G2JvQPckmyyVL
 p940t+uhKMwoIGs4QrZe5aolNlo+I2bCy4aMfqwEKvOptbcVmwnjYrkNmEUaG9/EEcx7
 Wzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753854853; x=1754459653;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWNN9WB1syoEngVmG1Zfdqg2oERvJW9qUBgkf8NcAy8=;
 b=bFz8I92amAmy65Cpo3PavyCw8TzdDLptlrzf+ebJ+wQ/cpQaJag8KrZjKOoF6MTSeQ
 GjqltNVGJaDEJTTK1A500RoqZCuAXCJyNyKG+YqLx8J5N61JgumJQzF5aoB9hLlBmpzK
 yNQxyorvtUJEfvYqu6Pmu/IRduTI45+q0EUlsXN4DTnCjDEF5tYuVGS0sL/A9bdp/c6d
 TmVN9GwkgeLRb2Fx/N6jCmQuiciV6jD+sfzJna96Y6kmGq+PSytbm8DNwh5LgAgL8q1Q
 LXNE7DrPG+Cagx6tSZFbnQPnZFLBEo9yBLMevTuDYRLcVMRrT4EA1tnEkzPbGyOrv+SV
 bwjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFw+xMZl83oc4PyWtfZkfBvN9UDB+dHGvT1iH0JHENwPE4RPwXNsMtLC0fjcXhE1ZJNjrFhI3/y11/@nongnu.org
X-Gm-Message-State: AOJu0YyNQ66fHCLrBkjotZXqQe2UjzkVGrYFittOm4YjyiCvsVKZ6THl
 yniiEpeK9YLDcG96IzhGYfuz4lPH1FPoA6CfvHmdTPjgHeUSYv/xhI2k2+Ki+TdliMUP1fNZur+
 zt7NV
X-Gm-Gg: ASbGncu4H8ZNoMCoQOPbEsZMCl2YjPrEvI3Jc5UKLTvWWrwaAvlg0mcnkwLPf6ix8Hc
 62IIBAF8Kzqwy0E2njLL3uUpcayjYe99SchvtdC9i1YDPBpLODkOe73Kfq/OYaUE0ZbfyiFFgcb
 cT5okPD+bAPqkB6lun97IOaMwJkoNcvJq2Ee0v40W9nNjJT0b/LjjlxbJwH2G2k4aGlXS5Fhag6
 ykCwF8peeNzf29tw00umyzWwMNeQYDlrZBtgWjh8onSUgd55vC4dz81YRA5Zl7WH+Y8JugOvZlr
 CCbrCjVucDenJev+UPTzZhZQRIAZ9X0Plh++Mp+fgJ1iFqW+eEcjj4QS3kRwKLE8f/D2itW8OV7
 L3PE/Lca/z/I3+Hj5j68iR1hQBgkZPrYAcn5WV+z5BZhOFvEgPQiDNQADZcZuqj0oQSx1VH0yOH
 1CUzP8nZXp/WxY
X-Google-Smtp-Source: AGHT+IFa1TwruvCjWfyjyZlJjszeMBo7EmvjLmHAmuw9HV/lS0eOYb7S4mdzkEuF5+aAqVTovYD9gQ==
X-Received: by 2002:a17:902:d505:b0:240:6740:6b11 with SMTP id
 d9443c01a7336-24096b0faa3mr28572085ad.40.1753854852854; 
 Tue, 29 Jul 2025 22:54:12 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23ff3893975sm76189365ad.183.2025.07.29.22.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 22:54:12 -0700 (PDT)
Message-ID: <9295a3e5-7477-4abb-8275-831307c76f01@linaro.org>
Date: Tue, 29 Jul 2025 19:54:09 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/19] target/loongarch: Use vaddr in
 get_physical_address()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-7-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730030202.3425934-7-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 7/29/25 17:01, Bibo Mao wrote:
> Replace target_ulong type with vaddr in function get_physical_address()
> and the same with its calling functions.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-mmu.h        |  2 +-
>   target/loongarch/cpu_helper.c     |  9 ++++-----
>   target/loongarch/tcg/tlb_helper.c | 11 ++++++-----
>   3 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

