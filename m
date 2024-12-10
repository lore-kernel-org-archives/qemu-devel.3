Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D112E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4pf-0002Gm-Ps; Tue, 10 Dec 2024 13:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4pW-0002AF-OR
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:19:35 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4pR-0003Mi-7v
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:19:27 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b6e8fe401eso42636585a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854764; x=1734459564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v5vVpSaK0rwMrRGmrE82bb0OAKnJkCZfB5odOngnjZM=;
 b=WPI+sSWAAW2OPoW7tgn7Cmw0Z0ujkIq1jx4yAvKuO47P/U676yICW45n6gbF5jpUUU
 jMod/mC2glv/lYS4zzghizhvqEOPXvH9dzczrp5eV+t+Y4QofHvnz5FH27fZYBfpbN7R
 LwXm5VasrSS2YwZuRVZ6huW+qbmICpR9Otcvvy8ZWNSj5V24jr2OPHhPAo6letHdHOS+
 lWN9w0tJpbKqkEKD/IOmAPp/sBlxBS1dOzqG6gkJXs2hqdkA8hAd+ZAGaLvRka3HkidK
 dQ4/JKyYlGXRHGloSxTahufgN5Ntvbkx1sny00Y1vwnkRQd1Wg6t9pcfTrYwy9XYfgFl
 teow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854764; x=1734459564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v5vVpSaK0rwMrRGmrE82bb0OAKnJkCZfB5odOngnjZM=;
 b=jjWaN5KZWdOPSqq6GvRvKfHQCo8c2tEiMRFhOhT+vRXmE73xkcciSa74JCWND9xZGu
 9E+Hq22mQSlRIFQuRDu4npNa0mQaUbe0f7UPbLJM8mjS/JXcf56s5EZAtQBhEWRmn2YM
 CwS6OakH22cEqJob8p7K3DkOU26QN3Aq0Sgrtvjp4dPTDrZvskiDoWGWaL7NLDSADcM0
 zaUZfTLiAZ8izXhXhJN+Nt9lPstp+x0K3V3+SVg4XZ5Ki5EbhYqXQaSU+exd/Wfhm6IP
 Huvpe9Jv1dCFpc/GZamjcLH+RiWk7ptcD8O44pQHKRBOf8mb+dWzqj47Vgw0H1QkCx4f
 6FEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmGEgJoyB2VNVDChRqHv9NuG+gVX1hX8G46togV4hQv3P0Yx5Xf0GIouNigAjjR2tk6BrtZuOoJ2U6@nongnu.org
X-Gm-Message-State: AOJu0Yz0FdJtOTkyTL6LcMp37nh8Vf7gmJPnqCf5gNDi0zl56+DRV2RW
 mUZkWxbMBQUGq8qJfOi8kNDsUvEZH/xuxYPPQZfSD+fjtfiuB2C+SQ+yPvR0gIQ=
X-Gm-Gg: ASbGnctNDZVHgBCmg6MpsGG0OBUW9qklLC/wYbRKnZkRXLpS4di92IaByNl8v6mtXz6
 Ak4AlJuq715LyP4KCN4tY8+C17+T9FkHFYGKrtuHxVb1rldB9ZW++cmkhIR+XS9TAFRTaeaDlGg
 6zEUW1UrJt5y3cX40IiT3CJquvCVfAHBZLXPAzuDpJkKP5t1gXNYTUrJWi8dgq02XrlNWlDX9sT
 LgLbh9szMYuliyWhHDfT7GeQevDstVN04K4IF3MImfIrQXDlexQavzaqxdlPTXZkR3E0dY=
X-Google-Smtp-Source: AGHT+IH30HjOuMNJzDJMUM07lIV7ueD5wtthg0jsq0IPsysRhJomiLMgJ+iIt9bExdUf9WlPy4haEQ==
X-Received: by 2002:a05:620a:7189:b0:7b6:d026:293 with SMTP id
 af79cd13be357-7b6eb43085emr20421985a.9.1733854763995; 
 Tue, 10 Dec 2024 10:19:23 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6dbb3b67fsm143996485a.10.2024.12.10.10.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:19:23 -0800 (PST)
Message-ID: <d47f5a35-186d-4b18-9c06-c17bcc515067@linaro.org>
Date: Tue, 10 Dec 2024 12:19:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] target/arm: Move the TLBI OS insns to tlb-insns.c.
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72d.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> Move the TLBI OS insns across to tlb-insns.c.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c        | 80 --------------------------------------
>   target/arm/tcg/tlb-insns.c | 80 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+), 80 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

