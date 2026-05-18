Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750CACD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0CE-0002h8-C4; Mon, 18 May 2026 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0CC-0002gt-Vg
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:47:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0CB-0008Dx-KM
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:47:56 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c8016d642b2so1389165a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779119274; x=1779724074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PeIIMbQh8RZV9fo+32J328jjhSefM94hW5pjBX5lTjc=;
 b=GwCw1+XKe3ZYb7ZwWU1MoAN2gkMVhC3THs0muA75HXoNMdXpmU+6AJESOYTsUdO2xu
 G5PpAxcRQHBN2n36bH0CYAeTg6i2FhuMbv9xTSm9yUnpLHmb0J1X8SL8HbMvIHzIX0yU
 gNYr/cs/5QQH6ncbFYfwDKPFklKwSWarj7HM/5wmKopW9CeWxFplbWdNF3jViW0PLscL
 OREED5VHfTPesE/kRH0qmTvPsQ/vb0MqjPP2qH0HKqGKRzqeju6ymKakCSaR4ddqaMdp
 fcNSyeqO5Y81dWr95r37ckAyaER20zFYhKoc7Xi5kMsq1fYj68h9eX7b49+yh/8mJ3bJ
 JPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119274; x=1779724074;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PeIIMbQh8RZV9fo+32J328jjhSefM94hW5pjBX5lTjc=;
 b=AnX4oYLLKC8ztxsbxc4boDKyoRIXoVEFvvqYI5/No/LHVTh3PgNGvhp/EZBlKYHLTo
 aoBcmes7rFBRVPIOFISGmbL5Dtam2iWhvDjVh/U0wvIju7Ra6+HjZlCBLQd19+ucYrr3
 XwAvzYReB1B5FDw3IT7eg/dBNd7BiGWGnGxw8i3Z+PzfhiTV/r0RmN933iuCvm2vE4PZ
 N+6QfyZDA+G6SqFe/ZZQAWpSR0OWrpUKtuIeGvvlnUhBnpBT1zZoTAtEPNtKIOjhELwh
 Bxw5ieJsDDBPhWTICO4Z0vaA51Sp5TI0XY0TXrfsl28zX008EIEVa8acWEy32NGoGsMT
 hksw==
X-Gm-Message-State: AOJu0YyKcdWxEAhcxDFEhvMIf4V0aJ2ljx2hp23oCd/gSf0I+DKsiFZc
 Li2/NJ+GZ1pgUL6P+262wXg9G7hMdd4yVKUjJh69qBhQY/3kIXVdb8Zo4LG91pV34NywkMC29Ui
 eG4cB+/g=
X-Gm-Gg: Acq92OECO669Qv0iJk3iEHPwMobPT0/t2ElkR0NvZ9bJEKmIlacz9kEoKkr6u4Fq/rj
 sYRfohXhj8kfv0y/um8DpgzJxKazq0vbnfUuhL6+Uck9s1gKCkVjGM9O1wKALPsYZ/edRUiTghs
 /Jdm4+8Bah+z5nX8rauPIXPe215IWItLkRswyvI8MMSPjfWi6afR0aCptJsM2SqzLFIo+ZsQyIC
 420jTF1v9pV8ptTBGs/5HD8iY+8NDrYTSaWfiBoYTZsZbgN5FDQCGrxWYHp26rw6RoI89EzyiZm
 Z2tLAARTd7UVKtCeImpTqBGULeIHNJlRMDhQag0qA4kTJqj7NbM28VtBbseTSd7wLJ8mGilVgJa
 g/mBsAOkGSjMKS5POkNN2Bc8gUnbJJr7X/QeKqSyN+ZiEn4snFV/fy3gGp46Z2QQpzIQ3hBTIy7
 NvWAAmuMGXPVBPm9z+h01GkfQE7LKu7KBZQRPq
X-Received: by 2002:a17:903:3850:b0:2bd:6327:b507 with SMTP id
 d9443c01a7336-2bd6327b69bmr166991055ad.18.1779119273708; 
 Mon, 18 May 2026 08:47:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11d6easm168117745ad.72.2026.05.18.08.47.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:47:53 -0700 (PDT)
Message-ID: <26f6de90-9203-45d2-bf93-27aca4ceefd6@linaro.org>
Date: Mon, 18 May 2026 08:47:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/14] target/arm/ptw: Flip sense of
 get_phys_addr_twostage return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

