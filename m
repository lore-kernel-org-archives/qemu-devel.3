Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3D2D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzuL-000835-KO; Fri, 15 Nov 2024 12:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBzuJ-00082q-Lx
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:14:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBzuF-0007cU-TU
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:14:53 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-211c1bd70f6so17143945ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731690890; x=1732295690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S0hV1H1Pa1V2z8tB206ORc0kQTkJ1XgZ5f2CeC4qScU=;
 b=TB0nF0tRnTGT8e9mcwNNL7CSaewpxr7+Dx0g9gi1IOyAVIo8CKNRSui42xAL4L/3yB
 RLLDphLkRW8Lgl2ECETRj5a0dJmvAy9METwGPXs/MJD9I3/p9pep18FpyyY1Oc9a1R79
 9Wo2R7oC/EpamhDi2/CUkVyGeM3YslqV96z/lYRfGWF2qscp6gNOP/nIjkQwvvi55Is6
 yw8sSe5SVUjSQFpApIYzYLh1wCu4piR+a8UNg71e1NQdUQieW0zaXDnRlxunixAzeL5W
 D2Z0aSA0ERT+qXKTPqCngjA2EnhzQklicZkf/M4DlikdpWoHIWM62cvYpRrV5TFghu49
 q6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731690890; x=1732295690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S0hV1H1Pa1V2z8tB206ORc0kQTkJ1XgZ5f2CeC4qScU=;
 b=ESRm2ZfDbwDVBJZeU4/DyXj5mbGqS/VRbUWGks2eDwqMxWGgeIwSQnq+okWwdFr7Po
 tXBO1BSxTvtlPwdt+J0wXW0OvdmfNqgdlMX6uky3F7yTfyhg7rDzcbBZe8KGc9fQ9VvK
 gPRFSbFEoAH2TfI8i7XpG7Hd3SE4KWfV142D0GhbXlpDu7X9uoH3b9FLlUwJc54MJVSY
 NXNtkS7E18xP0hvwRAOiRqPF+9Px+mcjY7Db778BbhWHFDIRBE2hFuiYSR5+z47/Mnt5
 Nkwo1j96XgpCPgVR4NRg+5+2aP8c8aiiCGs9AGSS+nOW0SAiLsx8lHYw3J0NzNPAJAzX
 F5EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0ynayO9hHpJam/KqhXVx3BGZJqViMtz4WhJFAQWCfi9Ma3U3TQuV1jJFwWNh0kuAhHPrsb+rN0PEU@nongnu.org
X-Gm-Message-State: AOJu0YxyJzHPh+K7xzLFadJfzbEOnazNqU7xH5PvJeAvHcwmwITJMNdG
 o4qGl1PDBCWuTxhQ/H5a7Ra2qIQ9pOa34mPcttbB15+ImYN9ynh/seMMBaLgP0P6LxQf5tJtj8u
 N
X-Google-Smtp-Source: AGHT+IHxFo/lrDnfBQYMNLV6blF6OtoNmh1LMUr0nHBO5z+Nkt9+fVsmT5fF6jjTipjVqVOmlStT7A==
X-Received: by 2002:a17:903:228d:b0:20b:a409:329 with SMTP id
 d9443c01a7336-211c0f0a592mr118962765ad.5.1731690889947; 
 Fri, 15 Nov 2024 09:14:49 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72477120a13sm1648067b3a.60.2024.11.15.09.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 09:14:49 -0800 (PST)
Message-ID: <df17e565-0463-42f7-8f43-2def86ffd39a@linaro.org>
Date: Fri, 15 Nov 2024 09:14:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] target/mips: Drop left-over comment about Jazz
 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241115152053.66442-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 11/15/24 07:20, Philippe Mathieu-Daudé wrote:
> Commit 3803b6b427 ("target/mips: Fold jazz behaviour into
> mips_cpu_do_transaction_failed") removed update on TCGCPUOps
> and commit 119065574d ("hw/core: Constify TCGCPUOps") made
> it const. Remove the now irrelevant comment.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index d0a43b6d5c..7c6f438e5d 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -546,10 +546,6 @@ static Property mips_cpu_properties[] = {
>   
>   #ifdef CONFIG_TCG
>   #include "hw/core/tcg-cpu-ops.h"
> -/*
> - * NB: cannot be const, as some elements are changed for specific
> - * mips hardware (see hw/mips/jazz.c).
> - */
>   static const TCGCPUOps mips_tcg_ops = {
>       .initialize = mips_tcg_init,
>       .synchronize_from_tb = mips_cpu_synchronize_from_tb,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

