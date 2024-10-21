Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BEFD17130
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 20:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ydP-0004Zy-H5; Mon, 21 Oct 2024 16:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2ydN-0004V1-Kr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:04:09 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2ydM-0003Mk-0g
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:04:09 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ead1edbf1dso1715308a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729541046; x=1730145846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23VON7e9obGXRFqC4rn3GhRrZeVog9BlvBFL90y4CDw=;
 b=eHiN3w/s3W2csWnX/uft3v3/v+wxYmKQBE4AmZVYErcxaiiOw8+Ha2TyTQ4hzrnL6n
 kUlFttElsX9uoa+jytytptPKgvUS2Pw6RmMTmTX75B9Ch/zPo9lWabTB64u9MCtkPNNC
 43aeR4fdGggF5MJab62R8NRosUE2ESM4V1FzPy1ANOA8bfj0eM5LFa6ypdJINdJ1jM8z
 uZKbTZC9YQzHc/ZCBnt+p/K2UGlgvbAYdFF3UKSRoLl9SKD2USvSZlJlFSMnOErN1rzz
 WL+YZrik+HQvvqRbg1K/A29tNPoeC5pPfFQ28LHjlMpNIX35OyzFoFL/VNF8JI8feIwt
 1rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729541046; x=1730145846;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23VON7e9obGXRFqC4rn3GhRrZeVog9BlvBFL90y4CDw=;
 b=NteadXL09mu0/8NwoJ+pXiPrejlhDbWU6IfrK//ZK/+WMUTBPMhJSUS94fCT3qfr5V
 SP5VMUmWnpoShzxJRBQ4BsZO7B4/YzI3XAKAbtUHZOf6jLW/Rp0Cm4AOqVNSAuiN+RVD
 SWFzqM+cRmrZW60SE0M4CU1DiXuWp+mTY8ACeqPVRWK8a4bwUNJAiTARifSAn28eMJXV
 QZ+r/uNJOD0XSpNpO8PKoSMxgAyY9eoCiK49t+CFWkA9VJPP2Atp3sdNFd+BrkoJ33Hl
 6SxL7btyZZZVd4cZ3VCsLW8NhLhxl1FggXh7SqAVFBJVG6GUGPPaoB6S9GvnPrOuPi/b
 FtFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE1zAHapLzBKR/E8wNd2I1TvHLk7kMiQpIs/rkAnUy/Vz/g0p/FnuRyLFSioRNAiy/0f1Ssmmybkzl@nongnu.org
X-Gm-Message-State: AOJu0YzRnHtwtMvASOVMN5ZBEdfPG57zMzXB0emWE6SvXgWh5ZT83Opr
 4AKnayJ/p7lidFB9/FxTY21DoPjbLBQVbRDqdSZK8TtDsHApN9iEU99ro1cJbqM=
X-Google-Smtp-Source: AGHT+IHYNma1Ww9pJvXQtkWm7bwTsoziJVfWwhWKY7QtUCVa/rxCYOp6qaE2Ws8MD7TuHRr2XS9+xQ==
X-Received: by 2002:a17:90a:2c46:b0:2e2:d859:1603 with SMTP id
 98e67ed59e1d1-2e5ddc5c66dmr273775a91.25.1729541046008; 
 Mon, 21 Oct 2024 13:04:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5df4162ddsm3782a91.0.2024.10.21.13.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 13:04:05 -0700 (PDT)
Message-ID: <ffc7aafc-5dc4-4595-b90b-dab0257c9b6f@linaro.org>
Date: Mon, 21 Oct 2024 13:04:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove unused CPUMIPSState::current_fpu field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Aleksandar Rikalo
 <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241021151253.36443-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241021151253.36443-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 10/21/24 08:12, Philippe Mathieu-Daudé wrote:
> The 'current_fpu' field is unused since commit f01be154589
> ("Move the active FPU registers into env again, and use more
> TCG registers to access them").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/cpu.h            | 1 -
>   target/mips/sysemu/machine.c | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

