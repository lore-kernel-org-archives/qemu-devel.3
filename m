Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A7CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCAp3-0008DH-8m; Thu, 01 Oct 2026 03:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCAoz-00087k-1w
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 03:03:13 -0400
Received: from mail-ed2-x2b.google.com ([2a00:1450:4864:33::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCAox-0002lt-Dq
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 03:03:12 -0400
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae3a72e02eso850723a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790838189; x=1791442989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZvLkqhQdcAp8w+k/zs8/bx5Gowx29UYirS7acVR10Vg=;
 b=Wgzf+ydzgL1zoePFVZpET9dMV6FgDwHoD02QYmfzaA/KL9PNfGCMP5en6ZledJIR4c
 dtv2GhwKv8zc32i/grlq0um0yaFev90abnqjXzaiugk0W1eK/SSArXRGGAxN5x3aeKk0
 c53CrTxj7Z2I+EKpKh39UBvAs0bS/cniQCf5ZZyuEeYJ5dUk+U/OfgZ8fDALqFlXZD6Q
 0CO3/KrnpMgNs3prG0r5TZLWsb56SqinbKL9qmD6gwWap7XeXRKTXBiN+yBRRGRp8lcE
 36MPJ/NePFhJOzd5y6zEOBTG6lOvQ7sZ0f0dARpMDpL8YGf+zaZG+d833AGgxWbhJ/vQ
 vR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790838189; x=1791442989;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZvLkqhQdcAp8w+k/zs8/bx5Gowx29UYirS7acVR10Vg=;
 b=ZyKky0R9sPHUpGm5dPlV4sCSTln3qXKbR8kzsLm1uejAGym2CdYNCTUPU/kEVJrYd7
 wyymFvSefI8yA+yVudnL/11y4wSlJsCt3CJvmllsJTkgPn/2YnwolF6L+NMQHYSsm17u
 7wpqT0s6XUCOw4QOpTrGrnrzhHTcfTCyXEfpK9suBrQCZXPneoaWBatThm3jGVOmMQYV
 rXe0teTbGta+2HVFKy9t7/DVdClE87z4vJdxXzgqPr9jrY/DuJEAsxwgr3V+i5I6ZnGS
 3elKe9LwkPSBYY3dH/ppSUCnHBzY/J+cKPywzqeSAxnla2rZBQbGCp9xX+AaPBM0xbHW
 GVoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1nQQLtsXHiZwlmC4y/MVbNwR6atgiBprElk5lo+4idbKLJLWzsYedWevs9NPPgHN8VVk/qrTTQ8pf@nongnu.org
X-Gm-Message-State: AFq9FYI5bAHM3iGU0+Zu3VVWth9u38CZe7XwF2Y3aV/c6ws10Q0WhgTR
 XVAp4myfsoYhMB+9mi6Uvuuo7DGgiGpMJOYOrtAfiIj816kJtSWyxtSos9e7cI0gE2JGhpRRLwQ
 Bvhpk+TI=
X-Gm-Gg: AYBFou2fh5ydkn3Q9nwVq8bNhIngOtnDlOPE1+jQwxMAFgy4XxzofldtZ7Qr+HkvIHj
 euOrLqzzKjqxPucd2fr/8XH5M0qIulUhLPDteIct3csxdZmWTLE/K5DfFLOvdC1Mtrsdiy4jBwR
 kH+cv63BDPSRonC+QJ0EkaS6jJS79xgmk8bWFdSz0FcXTElJgDVJzUq7MiOLiKB3uGUGXLlXbfR
 asS80yrgzzMNFxSijXgtGeMZSNllk0y4iJZ1jJnBV3EA7/m/nYejwkZ2FCT6MxJngE9tWS/zW+C
 aU5sx4MozXWEKWILYIgrTr/5m79ft/hp7s9LcJclKQhBdBh1MNidrrQSyxTc5aoXPBATJ2NBw+S
 gILhnS/A0V9Ku3AI+1dIXTmj1s8JIDWP0Y5LQC3nhTMbd2ddcKSE+tqiP/BzV6egLFLbppte3Tz
 6LD23l40IkNPkraYmygIOFdfI4wDtUb5dsHHKYw5G2klUeiY3PsYJbxvpGti0fXy4wC1bv/qOn/
 NnoXBIwTA==
X-Received: by 2002:a05:6402:3609:b0:6aa:f809:ef35 with SMTP id
 4fb4d7f45d1cf-6ae19943eb4mr3151670a12.29.1790838188789; 
 Thu, 01 Oct 2026 00:03:08 -0700 (PDT)
Received: from [10.70.4.59] ([157.231.30.34]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ae5ca44e64sm552424a12.8.2026.10.01.00.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 00:03:08 -0700 (PDT)
Message-ID: <05dfff86-ff8d-4e31-9b58-0fa3a057e8b8@linaro.org>
Date: Thu, 1 Oct 2026 08:03:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] loongarch queue
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260930070227.1079521-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260930070227.1079521-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:33::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/30/26 08:02, Bibo Mao wrote:
> The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a5f74:
> 
>    Merge tag 'pull-target-arm-20260929' ofhttps://gitlab.com/pm215/qemu into staging (2026-09-30 06:25:37 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20260930
> 
> for you to fetch changes up to d31587eb925e4ab646b4e01ce985406b839595f2:
> 
>    target/loongarch: Set CPU_INTERRUPT_HARD unless no pending irq (2026-09-30 14:56:11 +0800)
> 
> ----------------------------------------------------------------
> tags/pull-loongarch-20260930 queue

Applied, thanks.

r~

