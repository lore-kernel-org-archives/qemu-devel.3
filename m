Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F42C021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 19:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjNqe-0004qu-IC; Sat, 15 Feb 2025 14:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjNqX-0004qZ-L0
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:29:04 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjNqV-0001K3-E3
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:29:00 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220c2a87378so44228535ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739647737; x=1740252537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ottySth3oETnK4sq8l5c4h2Zeg3wAls/HNv9d3+p5cQ=;
 b=Q+LzQNelD0P26B+jZ2uTQattlbBGIbJSW2922nVaTArr4zLdwno4s6em8Kr/1tI7LQ
 3vlhBWoK9IJVWBpQ0haEQLw4DauIfm0+tTfGy926StN+6uP4wJ6b5a2GHjGr9Kf2Qs0M
 5paO8IrKiNouKhfll6WUSS9r6jPQmAlb8txvEQHs21a+Q1LzQ3YeGdnmQeQ/wDaQUeR4
 ljwp0eajaJgFM0OttQd/+dehhTLmlIsPacMtGJQGKHUt0hn/dyyJrrRixbHv0xyv5O45
 6Xjl62SlhACRJhNOnltj+tZoIBDwe9N8eg/SC98VDu1/YF9w7QtcitM6Oj0HVt1WaYIk
 DXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739647737; x=1740252537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ottySth3oETnK4sq8l5c4h2Zeg3wAls/HNv9d3+p5cQ=;
 b=IRDuYwgbIREU66BwEZlMYbo2RdF27lEdRd+30eO+cEC2velHkVelVHSGvdgdP8HhWL
 WHUqqOoSt/iHYhArklhhg8FAwBaS7TbClOvtli5BRO8ebt9oceL6g2gtPnPvQAUNL2el
 A/s6wKzqgstZNUmfKxTtStgiQVfBK5Wv5BQjJoY3L1N6GHt00rcPPukLkjB4TonvvaUr
 AwDU9pI8eQxwnKpaf8K8MIafGQnvQkriDM/h94jP0N/0nNkUPI97heI0H9PNwexU7Nju
 d7LUtbYkYab1ojOovQt4edE/Yz1BzCfVmaO7Zpsm9tJ260NNEuHYSCRclboord0GmV2U
 3+Iw==
X-Gm-Message-State: AOJu0YwQZ9sxeR45Q11Skgl+wchHPO7qQRcfCICdMhEdV/bQewujPUv3
 hvO98fanmqEi8EleCruuYh4vH8peLJCbEdWjeHwaf3+jGkplhnO1GUewcoflzQo2EC/Dtc09kp0
 v
X-Gm-Gg: ASbGncsSABfW1Afma55b2MIvQC+D4MFESvRsU/2GrWp1ZOLCv0ygGTVA4vsPnzj5EL7
 Uc+XlqGgknHDJhpdiMBvhBymPRUd24YT+hwYnSv33lDUS4z8Xrmp+h/9raG23NGeZU91u1ksb9W
 K2c4HdzD7gwvulBRnFjlsAkAjy2pbTKaoA4I+OnMezr9ozjRKNE17dRKObbBluDUaK2clU7/Nmp
 d8XGFbAOb/pViHHmhBZCfLL6lx6YWBAz9JOpIB8mRsUdBNoOXwEUTWyTQIsVumOMg6mg9r7xxP+
 yMEnPEDUuhDBKN7Kibtk+UYAhlL4qtm9G172HAMLE/R+gTQ7FTDdyPQ=
X-Google-Smtp-Source: AGHT+IGDKeRoaXD909C5CJeOS0jE5yoCeEZpyX0Rcny/Fv1tOPd6snbz8lDk+l+4yBbgg/c7cH74tA==
X-Received: by 2002:a17:902:e841:b0:21f:4144:a06f with SMTP id
 d9443c01a7336-22103f14b7cmr63025275ad.13.1739647737349; 
 Sat, 15 Feb 2025 11:28:57 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5584d94sm46620425ad.207.2025.02.15.11.28.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 11:28:56 -0800 (PST)
Message-ID: <8ae3bbc8-bde8-4d92-b059-7435afaf7cd8@linaro.org>
Date: Sat, 15 Feb 2025 11:28:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Move TARGET_SA_RESTORER out of
 generic/signal.h
To: qemu-devel@nongnu.org
References: <mvmed060xc9.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmed060xc9.fsf@suse.de>
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

On 2/10/25 04:59, Andreas Schwab wrote:
> SA_RESTORER and the associated sa_restorer field of struct sigaction are
> an obsolete feature, not expected to be used by future architectures.
> They are also absent on RISC-V, LoongArch, Hexagon and OpenRISC, but
> defined due to their use of generic/signal.h.  This leads to corrupted
> data and out-of-bounds accesses.
> 
> Move the definition of TARGET_SA_RESTORER out of generic/signal.h into the
> target_signal.h files that need it.  Note that m68k has the sa_restorer
> field, but does not use it and does not define SA_RESTORER.
> 
> Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/aarch64/target_signal.h    | 2 ++
>   linux-user/arm/target_signal.h        | 2 ++
>   linux-user/generic/signal.h           | 1 -
>   linux-user/i386/target_signal.h       | 2 ++
>   linux-user/m68k/target_signal.h       | 1 +
>   linux-user/microblaze/target_signal.h | 2 ++
>   linux-user/ppc/target_signal.h        | 2 ++
>   linux-user/s390x/target_signal.h      | 2 ++
>   linux-user/sh4/target_signal.h        | 2 ++
>   linux-user/x86_64/target_signal.h     | 2 ++
>   linux-user/xtensa/target_signal.h     | 2 ++
>   11 files changed, 19 insertions(+), 1 deletion(-)

Queued, thanks.


r~

