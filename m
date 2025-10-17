Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84A8CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mgp-00079k-Vg; Fri, 17 Oct 2025 11:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9mgo-00079H-AJ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:48:22 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9mgh-0003O4-8U
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:48:22 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77f5d497692so2764808b3a.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760716092; x=1761320892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XYWlqstPrtHw7w+P01qCB5tOVLlLL/AlFpf2D4hpIf4=;
 b=Yy58UZv9ppQycij60Hd/lCqyHtczPdDL9c0fuSEtpHHOdzZ3+FnNmB93DGzz2If5EH
 /JOskvv2zMAorsaig0ysAujxlLbUO8J5qmexuk/Bl8aKo7RLUwKTx6muvBR1H8RCFatB
 4aXvog92ej6A5P6FSj0GANv3Lq7xiI42bDpyTOnHe8hd8mjVYnn8X3sW18NyXZyxyUwL
 OlR9F4Rcfp2BLQNPXh/12YzWmwINTgm1/q2u+OtV5XrA0KhRHtRWTEwKfJgEj1Qbd+76
 qRpf5UBHQF/bFUi0/sTdSok6FTMdyyO6ebpr2JKr6i3snwgBtDxjxyzNJPaccwn/DRyy
 MZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760716092; x=1761320892;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XYWlqstPrtHw7w+P01qCB5tOVLlLL/AlFpf2D4hpIf4=;
 b=dlzqPk6+3uaZhnZ6qVigDc78QMQB/PibcRrULB9Zl0mDW/1O5M8VMGTXhe4W++ivis
 tqvbq1QCAIw0WTHLEBieBdhRdKug4BlyWYMRVbq0FDlxj4mmeFsUqLOFJTXOW/IxFHm0
 Q84RMoz/7xTuFfzlkYPcexhj/Y7evfpqn88yBjs6m2joTDJOx1l+9qdsDZj20GNf4Ox9
 Z0S4yP4+SI3xXioMaJKpW71W6im/G5No+G6LbUBDwSNdZBbIsPQVtEbyTqEwwVHUJPoe
 9SIzl8lbKAG2elN70jN5zrTZhrMSSyvZXRlnZfThaXPpApYbB0eeeYn63hxO6dzRBAid
 Hlhg==
X-Gm-Message-State: AOJu0YwlARk8ltcLbPIExbNXj6NjVczyBBo1VQrYitiQu5voNWAY5U4P
 oyg+pjmPjCW4mtDkbKP5Rg/pvFPcDRwLICSaCeb5IWrV9tKFCHG8dB36Ecqou3xAlo6IVEivJl5
 BmSahWSA=
X-Gm-Gg: ASbGnctx9z4D+VwXifuvzzC1iUdDgHa34qSNPtu5sUpHiuCzxnyCrDreJU470LzGJdU
 tPLgk5PkIMHAQ1KR0BDcHHzdU5Ic1oLw8T8WBpZf+kMNiUNHMfSY1my8H0N/9cpFGJh6NpLKVdJ
 0ms2ZtJWAOQXS9D34r6fstEMwWoNWuZFBeMC70yIjlklOWfjkAGBU5s1BzeUhmCzknnum6mKAi2
 xRr0ms7RaqWrpR6Ur++5OFtVIaIz9j6h1Sm1hyLhdCAAycEPU6ADru/9juOI2Cjid+06ECKBDEZ
 nM/H0IG7/25I52VaQDDKvIyL55LsIkIXZft71amnu39I2CXWiG3irlSkNkJ+gneof4mjtF+XAKd
 eKo0k10d8x7Hle8q3T2YHIgUUu/kiXa9E3yzZtJS+2OyWoFk5XNJ93J0bxePcgLkQwJxRGEcBR9
 O1jtEfsz9aaXoBzA==
X-Google-Smtp-Source: AGHT+IHZg/1y/HFzjCPZn1UcQSvbx2xp0HM7O2xwBmLpJupVNyZa8FdPjEVPKtqC+Z2ypaDViZGyFw==
X-Received: by 2002:a05:6a21:6da9:b0:334:802d:75c3 with SMTP id
 adf61e73a8af0-334a864f4fdmr5705528637.52.1760716092351; 
 Fri, 17 Oct 2025 08:48:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bd79d4927sm3342497a91.9.2025.10.17.08.48.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:48:12 -0700 (PDT)
Message-ID: <567b5ed3-a297-4746-a923-9dd90e2e5e71@linaro.org>
Date: Fri, 17 Oct 2025 08:48:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Claim the Arm XML in gdb-xml
To: qemu-devel@nongnu.org
References: <20251017154244.971608-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017154244.971608-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/17/25 08:42, Peter Maydell wrote:
> Add F: entries to the Arm CPU section to claim the Arm related
> XML files in gdb-xml.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I happened to notice while doing the SME2 gdbstub handling
> that we didn't have an entry in MAINTAINERS making the
> Arm gdb xml files fall under the right section.
> 
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 667acd933c7..3ec14bde6bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -208,6 +208,8 @@ F: hw/cpu/a*mpcore.c
>   F: include/hw/cpu/a*mpcore.h
>   F: docs/system/target-arm.rst
>   F: docs/system/arm/cpu-features.rst
> +F: gdb-xml/arm*.xml
> +F: gdb-xml/aarch64*.xml
>   
>   ARM SMMU
>   M: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

