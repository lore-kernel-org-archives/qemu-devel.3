Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A84CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7I9z-00061D-JY; Fri, 10 Oct 2025 14:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I9y-0005wJ-2d
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:48:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I9o-00026K-Iu
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:48:09 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so2385344b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122078; x=1760726878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=STmNcvGQUgYXpHnwVP7LHXN7GduGgixHiKgE8TEzM5o=;
 b=J0pHdOP2u8fc0Qn67qEG+NbQA+SY8FUsBbpi006wWS2b8+cYOsyXX95wufm4pHKpeF
 uRlbAkg1JM0sts7WhHBlaL784eeHs7B5OEb1Cv/YZU7qtXC7NTuRhXmHA/PhYinUnhi9
 ZJYs2ld8FTJzvFYWTi/EqWEAGfSz+mff3sY77roiRiYlnHUD5wVxGzNadIgfAixXHEoO
 X19Tm7EIFdLoaE3ksO2WDigJs+HnK5oznzzfQpztlp0aOVLH0H1YRnE4SqwwnJXvSfTG
 f1D3Zrzi91Lnex9TcEIqZuqQmWlhqA08D8fbTJhMdUyIyuWTqlvNwEMX4sl/wK+ERBUX
 vzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122078; x=1760726878;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STmNcvGQUgYXpHnwVP7LHXN7GduGgixHiKgE8TEzM5o=;
 b=R03DuCgqIVfpW1GkKdFAJXo40NSL9AKd2ElJMUheniFd8GZbu5owV5XP2wEXBhYkm2
 Jlmk8W9kEhEgT7aFn8GZlMI56ZLB1OpiCtI5ToXBpfhcGdXva+BPMhseGTO7W61vxvlP
 aRZyZpL5Z6BiQIQngC84vpmEnOInRy6RxKnE2zeb1otOmHc8UEN6wtWDsAkPM8hfOT6c
 isFq+YGRpZoWXzZlJHMd8qTSbgHrEiBNLoVnuk2CrjFmWenS6JiPZCCTclzDmJRDYtpe
 Iv0L9Z/hmia+DWZ05y7rPBeqMVISFn0SOxRSqllfDZy/KvdK/8+OwsriJuSGU7w5MSW1
 B7vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNOnYqyZZ7awC2W0idya+WuqkEmEMhscYSj6L1IeIJdiA3OFYSwtWTgeZiTo+VYZ4PDrfbm4OuU5Il@nongnu.org
X-Gm-Message-State: AOJu0YxRTH1OZ8ZX4qF1gXeuLhBvhRYvMYBwue3hTPiTzLnCkT9RwD1h
 A2DYPm+AhatsSpRkD3inGMz6yGOQQF9aBVe/0sby7U3NqgqMow+7Nb0WyxtT9dXP1+s=
X-Gm-Gg: ASbGnctzZY3U/sZC91ew2/vd5GNfrSlp9Cy+9J+fATYVM/7vmAZTf++TD4fLgx3t9Da
 8M6H5e1AehTf8IFYjduVkuR2py2lPmbac8hx6f+H0CXzTrJaykK40OsqS7XOW0yzy7RCXGhxlUR
 sCjclZoQAXh3RRzmO+4w9ZiBQHiTNI7tyRj9SDu5o+kfGVJb4j8NFC9NGiZj7kjc5fFEstikNYy
 hZqp7JxbWrTrPdTkdq74tBhXVOyiIAgUNCbEFP40mCP/hrbfQIZ/gtmtR3O+AOS+7Vjljil2wL+
 IAQGmuDi5BGvaXBDRLkD/C9Ua9Byt2evNGRSAuIEJUEKsiqrbNuMWEwqHDGe891jI5NEW7sgdf2
 ncuKz0ZbiLQclVbwL/hU+vDil8YleQro/9rSLMwo3F+DYcIp/BaDcSIgEyw8=
X-Google-Smtp-Source: AGHT+IFoDx2fEClzWrXb5kBp+TCbVDgLHfm5A3W0y3FdnBBmyOqTpsGFasj2tg9FuX0SChxrZYIREQ==
X-Received: by 2002:aa7:8291:0:b0:77d:c625:f5d3 with SMTP id
 d2e1a72fcca58-7922fab2513mr16585820b3a.1.1760122078038; 
 Fri, 10 Oct 2025 11:47:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992dd83dcbsm3700154b3a.83.2025.10.10.11.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:47:57 -0700 (PDT)
Message-ID: <4a4f20d5-39d2-4333-9870-fc0a49cc6278@linaro.org>
Date: Fri, 10 Oct 2025 11:47:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/riscv: Conceal MO_TE within gen_load() /
 gen_store()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/25 08:50, Philippe Mathieu-Daudé wrote:
> All callers of gen_load() / gen_store() set the MO_TE flag.
> Set it once in the callees.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvi.c.inc   | 24 ++++++++++++-----------
>   target/riscv/insn_trans/trans_rvzce.c.inc |  6 +++---
>   2 files changed, 16 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

