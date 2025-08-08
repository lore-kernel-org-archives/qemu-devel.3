Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2D9C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPYE-0004pt-I8; Fri, 08 Aug 2025 12:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPYD-0004mk-7B
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:02:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPYA-00075k-Fz
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:02:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-459ebb6bbdfso15242335e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754668953; x=1755273753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1oOym4G1Uqgj8cAdpo1OSXmVxF88jHGTUaHRF/kQ9ac=;
 b=GCH1HMuj8TbSo4FVsGKPo1UhnxErT+xt78ggn65bqPhuqHRfnx3hfQ+moiI9OB+Dr/
 l1vEmiBxWmtV51lPAxtKFUJBtfYRNt4nv87pnk3YOvbUQbG28PHI7dChTii+MxIhU+ae
 jb8irp9lfIG9vt19yq42H1ub8DscI4+xX3+ON4BZKRcF7iK9BNOFJLct48cGJYckRuWk
 4pkilu3J+EWgseckKxEGIYuGUSEVRgm/BGrw/lzvbtJVURjHkXotTkiyrO+1gQSUfwVN
 elU/v5m/bSmLQMmUKxLpzO9y4/vt6hYknHgPBMJnFkwwcGQOmmXJGTtO8C2tbF8YbqKR
 mS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754668953; x=1755273753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1oOym4G1Uqgj8cAdpo1OSXmVxF88jHGTUaHRF/kQ9ac=;
 b=D+Z3WjgqTZIPZeV195/NLZfbiARv0EWZ+prN+DhBOc4lA48ipIEmvBvl+JAGc9uGU3
 amfU8aQYS+4RYEmClxWvc/1eRlm2gT0AEniXFcd0qEdI1yr9thcKoIDaeloUxmskL5GL
 11NBKtDQOWZuTIuZ5BY2PZU3OcIFhfBFrE5Y61vJ/8xnYIfBu/zWxOPzMxZWPQKZC0mt
 U2IE2j5Xy0jgFX5wh043OQS+/jaFfT+3D9tq2j0LpFA+wJqYfaYuXLgH5JEY7tvg+RDt
 8EwnHrtSxzmirFCtpqa70knYy6k4wEUrFu5/E3OpCJVgBv5w98L3iqLZzr3szE55381a
 Y+KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY425S3hlxPIZ9jr1uHQ6UhzYtTkKnc+iJqVI6xjmD2T2fTqQNWJd6s6hWU8P1aO269uKJn9C3lyK6@nongnu.org
X-Gm-Message-State: AOJu0YyAn0inllF3Sg5jRLzeUpYw35uQQrXk6KouZpnEQPDOc7JgLAYq
 3URwM8IZiQJ0pvAyOP1F4SlPZcH2pZoxc/Z6aqSf8u/kMjeYfy32UaZZyFS+OVIDzdE=
X-Gm-Gg: ASbGnctaPjtuJZ7Y2Pi1nLyVE0YzMltQXQpvMAeEKbfrmuv6R0tBTFgTb63862cimrD
 dCiZjzOVxnCnmFgYrRtesxEPsYeGTvY8yim9+YtuBSqKedpraGAuM7kwMcf7se2u9d/IU1NAIoY
 v3+gaDlGTg70XKZT6smPQWYLsTfPNhRxmtqW+tz4AhuZFjdaKDHL0S9uYx5zjuE3Iun6NZAb1LF
 jeQE1bZHVPxgtsuCSuJZLCkFXtH4vHROHTXRPczXMEf0lLNaKA2B3AAv9bG4xJv5kdvgTCUmbwC
 A/Ef9c+CYcU1YrsAIl5purWN7mT2DOf5Yp5QT5q7tql599lrbytCGOo49tjjg4nKGNPfFuMWcmD
 TeFQ28vQNrgaEqHM9TDJ1CPC0jWIIS2/d+3lK6pyb/YFj2MhfFPmglQ83Vgensj+jHQ==
X-Google-Smtp-Source: AGHT+IHi1QWxohBh4U0B/OD5TWTEFQflyahwLR2+ADsoi/ZWgQa2zZq5A4rgwuuaHJXbTXPiyedN9g==
X-Received: by 2002:a05:6000:220c:b0:3b3:9c75:acc6 with SMTP id
 ffacd0b85a97d-3b900b579abmr2912548f8f.59.1754668952577; 
 Fri, 08 Aug 2025 09:02:32 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c33fesm31295635f8f.29.2025.08.08.09.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:02:32 -0700 (PDT)
Message-ID: <87427d18-af1e-4815-b95f-75bae32720d3@linaro.org>
Date: Fri, 8 Aug 2025 18:02:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/14] target/riscv: Add Xmipslsp instructions
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-8-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717093833.402237-8-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 17/7/25 11:38, Djordje Todorovic wrote:
> Add MIPS P8700 ldp, lwp, sdp, swp instructions.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.c                        |  3 +
>   target/riscv/cpu_cfg.h                    |  2 +-
>   target/riscv/cpu_cfg_fields.h.inc         |  1 +
>   target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
>   target/riscv/xmips.decode                 | 23 +++++++
>   5 files changed, 112 insertions(+), 1 deletion(-)


> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 9734963035..f35d477f27 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -39,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unus
>   
>   static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
>   {
> -    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
> +    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;

Checking for any XMIPS instruction implemented to return vendor
extension presence seems odd. Can you implement them separately?

